import 'package:dio/dio.dart';
import 'package:drift/drift.dart';

import '../../core/constants/api_constants.dart';
import '../../core/result/result.dart';
import '../../core/utils/api_error.dart';
import '../local/app_database.dart';
import '../models/conversation.dart';
import '../models/message.dart';
import '../models/participant.dart';
import '../remote/api_client.dart';

class ConversationRepository {
  final ApiClient _apiClient;
  final AppDatabase _db;

  ConversationRepository(this._apiClient, this._db);

  static const _pageSize = 20;
  static const _cacheExpiryDays = 30;

  /// Watch all conversations that [currentUserId] participates in,
  /// ordered by most recently updated.
  Stream<List<Conversation>> watchConversation(String currentUserId) {
    final query = (_db.select(_db.cachedConversationTable).join([
      innerJoin(
        _db.cachedParticipantTable,
        _db.cachedParticipantTable.conversationId.equalsExp(
              _db.cachedConversationTable.id,
            ) &
            _db.cachedParticipantTable.userId.equals(currentUserId),
      ),
    ]))..orderBy([OrderingTerm.desc(_db.cachedConversationTable.updatedAt)]);

    return query.watch().map(
      (rows) => rows.map((row) {
        final conv = row.readTable(_db.cachedConversationTable);
        final p = row.readTable(_db.cachedParticipantTable);
        return _rowToConversation(conv, p);
      }).toList(),
    );
  }

  Future<List<Conversation>> getCachedConversations(
    String currentUserId,
  ) async {
    final query = (_db.select(_db.cachedConversationTable).join([
      innerJoin(
        _db.cachedParticipantTable,
        _db.cachedParticipantTable.conversationId.equalsExp(
              _db.cachedConversationTable.id,
            ) &
            _db.cachedParticipantTable.userId.equals(currentUserId),
      ),
    ]))..orderBy([OrderingTerm.desc(_db.cachedConversationTable.updatedAt)]);

    final rows = await query.get();
    return rows.map((row) {
      final conv = row.readTable(_db.cachedConversationTable);
      final p = row.readTable(_db.cachedParticipantTable);
      return _rowToConversation(conv, p);
    }).toList();
  }

  /// Sync conversations from server to local DB.
  ///
  /// 1. Get the latest updatedAt from cache.
  /// 2. If cache is older than [_cacheExpiryDays], clear db and new fetch
  /// from api.
  /// 3. Otherwise, fetch only conversations updated after the latest cached one.
  /// 4. Upsert fetched data into local DB.
  Future<Result<void>> syncConversations(String myUserId) async {
    try {
      var latestUpdatedAt = await _getUpdateAtOfLatestConv();

      // Cache expired → clear and do a new fetch
      if (latestUpdatedAt != null) {
        final lastSync = DateTime.parse(latestUpdatedAt);
        if (DateTime.now().difference(lastSync).inDays > _cacheExpiryDays) {
          await _db.delete(_db.cachedConversationTable).go();
          await _db.delete(_db.cachedParticipantTable).go();
          latestUpdatedAt = null;
        }
      }

      // latestUpdatedAt == null → new fetch; otherwise → incremental sync
      final response = await _apiClient.dio.get(
        ApiConstants.conversations,
        queryParameters: latestUpdatedAt != null
            ? {'after': latestUpdatedAt}
            : {'limit': _pageSize},
      );

      final conversationsWithParticipants = (response.data['data'] as List)
          .map(
            (e) => _conversationWithParticipantsFromJson(
              e as Map<String, dynamic>,
            ),
          )
          .toList();

      await _upsert(conversationsWithParticipants);

      return Result.success(null);
    } on DioException catch (e) {
      final (message, code) = parseApiError(e);

      return Result.failure(message, code);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  /// Fetch the next page of older conversations before [before] cursor
  /// and cache them locally. Returns whether there are more pages.
  Future<Result<bool>> loadMore(String before, String myUserId) async {
    try {
      final response = await _apiClient.dio.get(
        ApiConstants.conversations,
        queryParameters: {'before': before, 'limit': _pageSize},
      );

      final conversationsWithParticipants = (response.data['data'] as List)
          .map(
            (e) => _conversationWithParticipantsFromJson(
              e as Map<String, dynamic>,
            ),
          )
          .toList();

      await _upsert(conversationsWithParticipants);

      final hasMore = response.data['nextCursor'] != null;

      return Result.success(hasMore);
    } on DioException catch (e) {
      final (message, code) = parseApiError(e);
      return Result.failure(message, code);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  Future<Result<Conversation>> createDirectConversation(
    String targetUserId,
  ) async {
    try {
      final response = await _apiClient.dio.post(
        ApiConstants.conversations,
        data: {'type': 'DIRECT', 'targetUserId': targetUserId},
      );

      final record = _conversationWithParticipantsFromJson(
        response.data as Map<String, dynamic>,
      );

      await _upsert([record]);

      return Result.success(record.$1);
    } on DioException catch (e) {
      final (message, code) = parseApiError(e);
      return Result.failure(message, code);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  Future<String?> _getUpdateAtOfLatestConv() async {
    final row =
        await (_db.select(_db.cachedConversationTable)
              ..orderBy([(t) => OrderingTerm.desc(t.updatedAt)])
              ..limit(1))
            .getSingleOrNull();
    return row?.updatedAt;
  }

  Future<void> _upsert(List<(Conversation, List<Participant>)> records) async {
    await _db.batch((b) {
      for (final (conv, participants) in records) {
        b.insert(
          _db.cachedConversationTable,
          _convToCompanion(conv),
          mode: InsertMode.insertOrReplace,
        );

        for (final participant in participants) {
          b.insert(
            _db.cachedParticipantTable,
            _participantToCompanion(conv.id, participant),
            mode: InsertMode.insertOrReplace,
          );
        }
      }
    });
  }

  /// Update denormalized lastMessage.
  /// If conversation is not cached, fetch it from API first.
  Future<void> updateLastMessage(Message message) async {
    final conv = await (_db.select(
      _db.cachedConversationTable,
    )..where((t) => t.id.equals(message.conversationId))).getSingleOrNull();

    if (conv == null) {
      try {
        final response = await _apiClient.dio.get(
          ApiConstants.conversation(message.conversationId),
        );
        final record = _conversationWithParticipantsFromJson(
          response.data as Map<String, dynamic>,
        );
        await _upsert([record]);
      } catch (_) {}
      return;
    }

    final participant =
        await (_db.select(_db.cachedParticipantTable)..where(
              (t) =>
                  t.conversationId.equals(message.conversationId) &
                  t.userId.equals(message.senderId),
            ))
            .getSingleOrNull();

    await (_db.update(
      _db.cachedConversationTable,
    )..where((t) => t.id.equals(message.conversationId))).write(
      CachedConversationTableCompanion(
        lastSeq: Value(message.seq),
        lastMessageId: Value(message.id),
        lastMessageContent: Value(message.content),
        lastMessageType: Value(message.type.toApiString()),
        lastMessageSenderId: Value(message.senderId),
        lastMessageSenderName: Value(participant?.fullName ?? ''),
        lastMessageIsDeleted: Value(message.isDeleted),
        lastMessageCreatedAt: Value(message.createdAt.toIso8601String()),
        updatedAt: Value(message.createdAt.toIso8601String()),
      ),
    );
  }

  /// "When a sender sends a message, update that sender's lastReadSeq to
  /// the seq of that message."
  /// Todo remove in the future. Use [markRead] instead
  Future<void> updateSenderLastReadSeq(Message message) async {
    await (_db.update(_db.cachedParticipantTable)..where(
          (t) =>
              t.conversationId.equals(message.conversationId) &
              t.userId.equals(message.senderId),
        ))
        .write(
          CachedParticipantTableCompanion(lastReadSeq: Value(message.seq)),
        );
  }

  /// Get participants of a conversation from local DB.
  Future<Map<String, Participant>> getCachedParticipants(
    String conversationId,
  ) async {
    final rows = await (_db.select(
      _db.cachedParticipantTable,
    )..where((t) => t.conversationId.equals(conversationId))).get();
    return {
      for (final row in rows)
        row.userId: Participant(
          userId: row.userId,
          fullName: row.fullName,
          avatarUrl: row.avatarUrl,
          role: row.role,
          lastReadSeq: row.lastReadSeq,
          leftAt: row.leftAt != null ? DateTime.parse(row.leftAt!) : null,
        ),
    };
  }

  /// Update lastReadSeq of a participant in local DB.
  Future<void> markRead(String conversationId, String userId, int seq) async {
    await (_db.update(_db.cachedParticipantTable)..where(
          (t) =>
              t.conversationId.equals(conversationId) & t.userId.equals(userId),
        ))
        .write(CachedParticipantTableCompanion(lastReadSeq: Value(seq)));
  }

  (Conversation, List<Participant>) _conversationWithParticipantsFromJson(
    Map<String, dynamic> json,
  ) {
    final participants = (json['participants'] as List)
        .map((e) => Participant.fromJson(e as Map<String, dynamic>))
        .toList();
    final conv = Conversation.fromJson(json);
    return (conv, participants);
  }

  Conversation _rowToConversation(
    CachedConversationTableData conv,
    CachedParticipantTableData p,
  ) {
    return Conversation(
      id: conv.id,
      type: conv.type,
      name: conv.name,
      avatarUrl: conv.avatarUrl,
      lastSeq: conv.lastSeq,
      lastReadSeq: p.lastReadSeq,
      lastMessage: conv.lastMessageId != null
          ? LastMessage(
              id: conv.lastMessageId!,
              content: conv.lastMessageContent,
              type: conv.lastMessageType!,
              seq: conv.lastSeq,
              senderId: conv.lastMessageSenderId!,
              senderName: conv.lastMessageSenderName!,
              isDeleted: conv.lastMessageIsDeleted,
              createdAt: DateTime.parse(conv.lastMessageCreatedAt!),
            )
          : null,
      updatedAt: DateTime.parse(conv.updatedAt),
      createdAt: DateTime.parse(conv.createdAt),
    );
  }

  CachedConversationTableCompanion _convToCompanion(Conversation conv) {
    final lm = conv.lastMessage;
    return CachedConversationTableCompanion.insert(
      id: conv.id,
      type: conv.type,
      name: Value(conv.name),
      avatarUrl: Value(conv.avatarUrl),
      lastSeq: conv.lastSeq,
      lastMessageId: Value(lm?.id),
      lastMessageContent: Value(lm?.content),
      lastMessageType: Value(lm?.type),
      lastMessageSenderId: Value(lm?.senderId),
      lastMessageSenderName: Value(lm?.senderName),
      lastMessageIsDeleted: Value(lm?.isDeleted ?? false),
      lastMessageCreatedAt: Value(lm?.createdAt.toIso8601String()),
      updatedAt: conv.updatedAt.toIso8601String(),
      createdAt: conv.createdAt.toIso8601String(),
    );
  }

  CachedParticipantTableCompanion _participantToCompanion(
    String conversationId,
    Participant p,
  ) {
    return CachedParticipantTableCompanion.insert(
      conversationId: conversationId,
      userId: p.userId,
      fullName: p.fullName,
      avatarUrl: Value(p.avatarUrl),
      role: p.role,
      lastReadSeq: p.lastReadSeq,
      leftAt: Value(p.leftAt?.toIso8601String()),
    );
  }
}
