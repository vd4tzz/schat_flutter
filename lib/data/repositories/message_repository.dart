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
    final messages = rows.map(Message.fromRow).toList();
    return _populateReplyTo(messages);
  }

  /// Lookup a single message: check DB first, fallback to API if not found.
  Future<Message?> getMessage(String messageId) async {
    final row = await (_db.select(
      _db.cachedMessageTable,
    )..where((t) => t.id.equals(messageId))).getSingleOrNull();
    if (row != null) return Message.fromRow(row);

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

  /// Sync messages from server and return updated cached messages.
  /// If cache exists, fetch newer ones; otherwise fetch latest.
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
    final cachedMessage = rows.map(Message.fromRow).toList();

    if (cachedMessage.length == limit) {
      return (await _populateReplyTo(cachedMessage), true);
    }

    // DB didn't have enough → fetch older from API
    // Use the smallest cached seq as cursor to avoid re-fetching existing messages
    final apiBeforeSeq = cachedMessage.isNotEmpty
        ? cachedMessage.last.seq
        : beforeSeq;

    List<Message> fetched;
    try {
      final response = await _apiClient.dio.get(
        ApiConstants.conversationMessages(conversationId),
        queryParameters: {'before': apiBeforeSeq, 'limit': _pageSize},
      );
      fetched = (response.data as List)
          .map((e) => Message.fromJson(e as Map<String, dynamic>))
          .toList();
      await upsertMessages(fetched);
    } on DioException {
      // Network error → return whatever DB has
      return (await _populateReplyTo(cachedMessage), cachedMessage.isNotEmpty);
    }

    if (cachedMessage.isEmpty && fetched.isEmpty) {
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

    final combined = updated.map(Message.fromRow).toList();
    return (await _populateReplyTo(combined), fetched.length == _pageSize);
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
        .insertOnConflictUpdate(message.toCompanion());
  }

  Future<void> upsertMessages(List<Message> messages) async {
    if (messages.isEmpty) return;
    await _db.batch((b) {
      for (final m in messages) {
        b.insert(
          _db.cachedMessageTable,
          m.toCompanion(),
          mode: InsertMode.insertOrReplace,
        );
      }
    });
  }

  Future<void> markDeleted(String messageId) async {
    await (_db.update(
      _db.cachedMessageTable,
    )..where((t) => t.id.equals(messageId))).write(
      const CachedMessageTableCompanion(
        isDeleted: Value(true),
        content: Value(null),
      ),
    );
  }

  Future<void> updateEdited(String messageId, String newContent) async {
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
  Future<void> updateReaction(
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
    final replyMap = {for (final row in rows) row.id: Message.fromRow(row)};

    return messages.map((m) {
      if (m.replyToId != null && replyMap.containsKey(m.replyToId)) {
        return m.copyWith(replyTo: replyMap[m.replyToId]);
      }
      return m;
    }).toList();
  }
}
