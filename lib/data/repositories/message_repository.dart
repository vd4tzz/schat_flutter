import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:drift/drift.dart';

import '../../core/constants/api_constants.dart';
import '../../core/result/result.dart';
import '../../core/utils/api_error.dart';
import '../local/app_database.dart';
import '../models/message.dart';
import '../remote/api_client.dart';

class MessageRepository {
  final ApiClient _apiClient;
  final AppDatabase _db;

  MessageRepository(this._apiClient, this._db);

  static const _pageSize = 20;

  Future<List<Message>> getCachedMessages(
    String conversationId, {
    int limit = _pageSize,
  }) async {
    final rows =
        await (_db.select(_db.cachedMessageTable)
              ..where((t) => t.conversationId.equals(conversationId))
              ..orderBy([(t) => OrderingTerm.desc(t.seq)])
              ..limit(limit))
            .get();
    final messages = rows.map(_rowToMessage).toList();
    return _populateReplyTo(messages);
  }

  /// Lookup a single message: check DB first, fallback to API if not found.
  Future<Message?> getMessage(String messageId) async {
    final row = await (_db.select(
      _db.cachedMessageTable,
    )..where((t) => t.id.equals(messageId))).getSingleOrNull();
    if (row != null) return _rowToMessage(row);

    try {
      final response = await _apiClient.dio.get(
        ApiConstants.message(messageId),
      );
      final message = Message.fromJson(response.data as Map<String, dynamic>);
      await upsertMessage(message);
      return message;
    } catch (_) {
      return null;
    }
  }

  /// Syncs new messages from server into cache, then returns the latest cached page.
  /// - If cache exists: fetches messages with seq > latest cached seq (incremental sync).
  /// - If cache is empty: fetches the most recent page from server.
  /// Returns a [Result] wrapping the updated message list, or a failure on network error.
  Future<Result<List<Message>>> syncAndGetMessages(
    String conversationId, {
    int limit = _pageSize,
  }) async {
    try {
      final latestSeq = await _getLatestSeq(conversationId);

      final response = await _apiClient.dio.get(
        ApiConstants.conversationMessages(conversationId),
        queryParameters: latestSeq != null
            ? {'after': latestSeq}
            : {'limit': _pageSize},
      );

      final messages = (response.data as List)
          .map((e) => Message.fromJson(e as Map<String, dynamic>))
          .toList();

      await upsertMessages(messages);

      final updated = await getCachedMessages(conversationId, limit: limit);

      return Result.success(updated);
    } on DioException catch (e) {
      final (message, code) = parseApiError(e);
      return Result.failure(message, code);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  /// Loads older messages before [beforeSeq] (pagination).
  /// Returns `(messages, hasMore)`:
  /// - Tries cache first; if cache has a full page, returns immediately.
  /// - If cache is insufficient, fetches older messages from API and upserts them.
  /// - On network error, returns whatever is in cache.
  /// - `hasMore` is false when the server returns fewer messages than a full page.
  Future<(List<Message>, bool)> loadMoreMessages(
    String conversationId,
    int beforeSeq, {
    int limit = _pageSize,
  }) async {
    final rows =
        await (_db.select(_db.cachedMessageTable)
              ..where(
                (t) =>
                    t.conversationId.equals(conversationId) &
                    t.seq.isSmallerThanValue(beforeSeq),
              )
              ..orderBy([(t) => OrderingTerm.desc(t.seq)])
              ..limit(limit))
            .get();
    final cachedMessages = rows.map(_rowToMessage).toList();

    if (cachedMessages.length == limit) {
      return (await _populateReplyTo(cachedMessages), true);
    }

    // DB didn't have enough → fetch older from API
    // Use the smallest cached seq as cursor to avoid re-fetching existing messages
    final apiBeforeSeq = cachedMessages.isNotEmpty
        ? cachedMessages.last.seq
        : beforeSeq;

    List<Message> fetchedMessages;
    try {
      final response = await _apiClient.dio.get(
        ApiConstants.conversationMessages(conversationId),
        queryParameters: {'before': apiBeforeSeq, 'limit': _pageSize},
      );

      fetchedMessages = (response.data as List)
          .map((e) => Message.fromJson(e as Map<String, dynamic>))
          .toList();

      await upsertMessages(fetchedMessages);
    } on DioException {
      // Network error → return whatever DB has
      return (
        await _populateReplyTo(cachedMessages),
        cachedMessages.isNotEmpty,
      );
    }

    if (cachedMessages.isEmpty && fetchedMessages.isEmpty) {
      return (<Message>[], false);
    }

    // Re-query DB to get full page (both existing cache + newly fetched)
    final updated =
        await (_db.select(_db.cachedMessageTable)
              ..where(
                (t) =>
                    t.conversationId.equals(conversationId) &
                    t.seq.isSmallerThanValue(beforeSeq),
              )
              ..orderBy([(t) => OrderingTerm.desc(t.seq)])
              ..limit(limit))
            .get();

    final combined = updated.map(_rowToMessage).toList();
    return (
      await _populateReplyTo(combined),
      fetchedMessages.length == _pageSize,
    );
  }

  Future<int?> _getLatestSeq(String conversationId) async {
    final row =
        await (_db.select(_db.cachedMessageTable)
              ..where((t) => t.conversationId.equals(conversationId))
              ..orderBy([(t) => OrderingTerm.desc(t.seq)])
              ..limit(1))
            .getSingleOrNull();
    return row?.seq;
  }

  Future<void> upsertMessage(Message message) async {
    await _db
        .into(_db.cachedMessageTable)
        .insertOnConflictUpdate(_messageToRow(message));
  }

  Future<void> upsertMessages(List<Message> messages) async {
    if (messages.isEmpty) return;
    await _db.batch((b) {
      for (final m in messages) {
        b.insert(
          _db.cachedMessageTable,
          _messageToRow(m),
          mode: InsertMode.insertOrReplace,
        );
      }
    });
  }

  Future<void> markMessageDeleted(String messageId) async {
    await (_db.update(
      _db.cachedMessageTable,
    )..where((t) => t.id.equals(messageId))).write(
      const CachedMessageTableCompanion(
        isDeleted: Value(true),
        content: Value(null),
      ),
    );
  }

  Future<void> updateMessageContent(String messageId, String newContent) async {
    await (_db.update(
      _db.cachedMessageTable,
    )..where((t) => t.id.equals(messageId))).write(
      CachedMessageTableCompanion(
        content: Value(newContent),
        isEdited: const Value(true),
      ),
    );
  }

  /// Update reactions.
  Future<void> updateMessageReaction(
    String messageId,
    String userId,
    String? emoji,
  ) async {
    final row = await (_db.select(
      _db.cachedMessageTable,
    )..where((t) => t.id.equals(messageId))).getSingleOrNull();
    if (row == null) return;

    final reactions =
        (jsonDecode(row.reactionsJson) as List)
            .map((e) => MessageReaction.fromJson(e as Map<String, dynamic>))
            .toList()
          ..removeWhere((r) => r.userId == userId);

    if (emoji != null) {
      reactions.add(
        MessageReaction(messageId: messageId, userId: userId, emoji: emoji),
      );
    }

    await (_db.update(
      _db.cachedMessageTable,
    )..where((t) => t.id.equals(messageId))).write(
      CachedMessageTableCompanion(
        reactionsJson: Value(
          jsonEncode(reactions.map((r) => r.toJson()).toList()),
        ),
      ),
    );
  }

  /// Populate replyTo cho danh sách messages.
  /// Collect replyToIds → batch query từ DB → gán vào message.replyTo.
  Future<List<Message>> _populateReplyTo(List<Message> messages) async {
    final replyToIds = messages
        .where((m) => m.replyToId != null)
        .map((m) => m.replyToId!)
        .toSet();
    if (replyToIds.isEmpty) return messages;

    final rows = await (_db.select(
      _db.cachedMessageTable,
    )..where((t) => t.id.isIn(replyToIds))).get();
    final replyMap = {for (final row in rows) row.id: _rowToMessage(row)};

    return messages.map((m) {
      if (m.replyToId != null && replyMap.containsKey(m.replyToId)) {
        return m.copyWith(replyTo: replyMap[m.replyToId]);
      }
      return m;
    }).toList();
  }

  Message _rowToMessage(CachedMessageTableData row) {
    final reactionsRaw = jsonDecode(row.reactionsJson) as List<dynamic>;

    return Message(
      id: row.id,
      conversationId: row.conversationId,
      seq: row.seq,
      content: row.content,
      type: MessageType.fromString(row.type),
      senderId: row.senderId,
      isEdited: row.isEdited,
      isDeleted: row.isDeleted,
      reactions: reactionsRaw
          .map((e) => MessageReaction.fromJson(e as Map<String, dynamic>))
          .toList(),
      replyToId: row.replyToId,
      createdAt: DateTime.parse(row.createdAt).toUtc(),
    );
  }

  CachedMessageTableCompanion _messageToRow(Message message) {
    return CachedMessageTableCompanion.insert(
      id: message.id,
      conversationId: message.conversationId,
      seq: message.seq,
      content: Value(message.content),
      type: message.type.toApiString(),
      senderId: message.senderId,
      reactionsJson: Value(
        jsonEncode(message.reactions.map((r) => r.toJson()).toList()),
      ),
      replyToId: Value(message.replyToId),
      createdAt: message.createdAt.toIso8601String(),
    );
  }
}
