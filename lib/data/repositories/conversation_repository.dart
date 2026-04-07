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

  // ─── Watch ────────────────────────────────────────────────────────────────

  Stream<List<Conversation>> watch(String myUserId) {
    final query = (_db.select(_db.cachedConversationTable).join([
      innerJoin(
        _db.cachedParticipantTable,
        _db.cachedParticipantTable.conversationId.equalsExp(
              _db.cachedConversationTable.id,
            ) &
            _db.cachedParticipantTable.userId.equals(myUserId),
      ),
    ]))..orderBy([OrderingTerm.desc(_db.cachedConversationTable.updatedAt)]);

    return query.watch().map(
      (rows) => rows.map((row) {
        final conv = row.readTable(_db.cachedConversationTable);
        final p = row.readTable(_db.cachedParticipantTable);
        return Conversation.fromRow(conv, p);
      }).toList(),
    );
  }

  // ─── Get ──────────────────────────────────────────────────────────────────

  Future<List<Conversation>> getConversations(String myUserId) async {
    final query = (_db.select(_db.cachedConversationTable).join([
      innerJoin(
        _db.cachedParticipantTable,
        _db.cachedParticipantTable.conversationId.equalsExp(
              _db.cachedConversationTable.id,
            ) &
            _db.cachedParticipantTable.userId.equals(myUserId),
      ),
    ]))..orderBy([OrderingTerm.desc(_db.cachedConversationTable.updatedAt)]);

    final rows = await query.get();
    return rows.map((row) {
      final conv = row.readTable(_db.cachedConversationTable);
      final p = row.readTable(_db.cachedParticipantTable);
      return Conversation.fromRow(conv, p);
    }).toList();
  }

  // ─── Sync (after) ─────────────────────────────────────────────────────────

  Future<Result<void>> sync(String myUserId) async {
    try {
      var maxUpdatedAt = await _getMaxUpdatedAt();

      // Cache expired → full refresh
      if (maxUpdatedAt != null) {
        final lastSync = DateTime.parse(maxUpdatedAt);
        if (DateTime.now().difference(lastSync).inDays > _cacheExpiryDays) {
          await _db.delete(_db.cachedConversationTable).go();
          await _db.delete(_db.cachedParticipantTable).go();
          maxUpdatedAt = null;
        }
      }

      final response = await _apiClient.dio.get(
        ApiConstants.conversations,
        queryParameters: {if (maxUpdatedAt != null) 'after': maxUpdatedAt},
      );
      final conversations = (response.data['data'] as List)
          .map(
            (e) => Conversation.fromJson(e as Map<String, dynamic>, myUserId),
          )
          .toList();
      await _upsert(conversations);
      return Result.success(null);
    } on DioException catch (e) {
      final (message, code) = parseApiError(e);
      return Result.failure(message, code);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  // ─── Load more (before) ───────────────────────────────────────────────────

  Future<Result<bool>> loadMore(String before, String myUserId) async {
    try {
      final response = await _apiClient.dio.get(
        ApiConstants.conversations,
        queryParameters: {'before': before, 'limit': _pageSize},
      );
      final conversations = (response.data['data'] as List)
          .map(
            (e) => Conversation.fromJson(e as Map<String, dynamic>, myUserId),
          )
          .toList();
      await _upsert(conversations);

      final hasMore = response.data['nextCursor'] != null;
      return Result.success(hasMore);
    } on DioException catch (e) {
      final (message, code) = parseApiError(e);
      return Result.failure(message, code);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  // ─── Create direct ────────────────────────────────────────────────

  Future<Result<Conversation>> createDirectConversation(
    String targetUserId,
    String myUserId,
  ) async {
    try {
      final response = await _apiClient.dio.post(
        ApiConstants.conversations,
        data: {'type': 'DIRECT', 'targetUserId': targetUserId},
      );
      final conv = Conversation.fromJson(
        response.data as Map<String, dynamic>,
        myUserId,
      );
      await _upsert([conv]);
      return Result.success(conv);
    } on DioException catch (e) {
      final (message, code) = parseApiError(e);
      return Result.failure(message, code);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  // ─── Helpers ──────────────────────────────────────────────────────────────

  Future<String?> _getMaxUpdatedAt() async {
    final row =
        await (_db.select(_db.cachedConversationTable)
              ..orderBy([(t) => OrderingTerm.desc(t.updatedAt)])
              ..limit(1))
            .getSingleOrNull();
    return row?.updatedAt;
  }

  Future<void> _upsert(List<Conversation> conversations) async {
    await _db.batch((b) {
      for (final conv in conversations) {
        b.insert(
          _db.cachedConversationTable,
          _convToCompanion(conv),
          mode: InsertMode.insertOrReplace,
        );
        for (final participant in conv.participants) {
          b.insert(
            _db.cachedParticipantTable,
            _participantToCompanion(conv.id, participant),
            mode: InsertMode.insertOrReplace,
          );
        }
      }
    });
  }

  /// Update denormalized lastMessage fields trong CachedConversationTable.
  Future<void> updateLastMessage(Message message) async {
    // Lookup sender name from participants
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
        lastMessageIsDeleted: const Value(false),
        lastMessageCreatedAt: Value(message.createdAt.toIso8601String()),
        updatedAt: Value(message.createdAt.toIso8601String()),
      ),
    );
  }

  /// Update sender's lastReadSeq khi nhận message mới.
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

  /// Load participants cho 1 conversation từ local DB.
  Future<Map<String, Participant>> getParticipants(
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

  /// Mark last message as deleted trong conversation table.
  Future<void> markLastMessageDeleted(
    String conversationId,
    String messageId,
  ) async {
    await (_db.update(_db.cachedConversationTable)..where(
          (t) =>
              t.id.equals(conversationId) & t.lastMessageId.equals(messageId),
        ))
        .write(
          CachedConversationTableCompanion(
            lastMessageIsDeleted: const Value(true),
            lastMessageContent: const Value(null),
          ),
        );
  }

  /// Update lastReadSeq của participant về lastSeq của conversation trong local DB.
  Future<void> markReadLocally(String conversationId, String userId) async {
    final conv = await (_db.select(
      _db.cachedConversationTable,
    )..where((t) => t.id.equals(conversationId))).getSingleOrNull();
    if (conv == null) return;

    await (_db.update(_db.cachedParticipantTable)..where(
          (t) =>
              t.conversationId.equals(conversationId) & t.userId.equals(userId),
        ))
        .write(
          CachedParticipantTableCompanion(lastReadSeq: Value(conv.lastSeq)),
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
