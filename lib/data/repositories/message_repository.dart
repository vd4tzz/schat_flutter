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

  // ─── Local DB ─────────────────────────────────────────────────────────────

  Future<List<Message>> getMessages(
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

  Future<(List<Message>, bool)> loadMore(
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
    final fromDb = rows.map(Message.fromRow).toList();

    if (fromDb.length == limit) {
      return (await _populateReplyTo(fromDb), true);
    }

    // DB không đủ → fetch thêm từ API
    final apiBeforeSeq = fromDb.isNotEmpty ? fromDb.last.seq : beforeSeq;
    final result = await _fetchAndCacheOldMessages(
      conversationId,
      before: apiBeforeSeq,
    );

    if (result is Failure) {
      // Lỗi mạng → trả về những gì DB có, vẫn cho loadMore tiếp
      return (await _populateReplyTo(fromDb), fromDb.isNotEmpty);
    }

    final fetched = (result as Success<List<Message>>).data;

    if (fromDb.isEmpty && fetched.isEmpty) {
      return (<Message>[], false);
    }

    // Re-query DB để lấy đầy đủ (cả fromDb + fetched đã cache)
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

  /// Fetch messages mới nhất từ API (không có cursor) và cache vào DB.
  /// Dùng khi DB trống — lần đầu mở conversation.
  Future<Result<void>> fetchLatestMessages(String conversationId) async {
    try {
      final response = await _apiClient.dio.get(
        ApiConstants.conversationMessages(conversationId),
        queryParameters: {'limit': _pageSize},
      );
      final messages = (response.data as List)
          .map((e) => Message.fromJson(e as Map<String, dynamic>))
          .toList();
      await upsertMessages(messages);
      return Result.success(null);
    } on DioException catch (e) {
      final (message, code) = parseApiError(e);
      return Result.failure(message, code);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  /// Fetch messages mới hơn [afterSeq] từ API và cache vào DB.
  /// Dùng cho initial sync khi DB đã có data.
  Future<Result<void>> syncNewMessages(
    String conversationId,
    int afterSeq,
  ) async {
    try {
      final response = await _apiClient.dio.get(
        ApiConstants.conversationMessages(conversationId),
        queryParameters: {'after': afterSeq},
      );

      final messages = (response.data as List)
          .map((e) => Message.fromJson(e as Map<String, dynamic>))
          .toList();

      await upsertMessages(messages);

      return Result.success(null);
    } on DioException catch (e) {
      final (message, code) = parseApiError(e);
      return Result.failure(message, code);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  /// Fetch messages cũ hơn [before] từ API và cache vào DB.
  Future<Result<List<Message>>> _fetchAndCacheOldMessages(
    String conversationId, {
    required int before,
  }) async {
    try {
      final response = await _apiClient.dio.get(
        ApiConstants.conversationMessages(conversationId),
        queryParameters: {'before': before, 'limit': _pageSize},
      );
      final messages = (response.data as List)
          .map((e) => Message.fromJson(e as Map<String, dynamic>))
          .toList();
      await upsertMessages(messages);
      return Result.success(messages);
    } on DioException catch (e) {
      final (message, code) = parseApiError(e);
      return Result.failure(message, code);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  // ─── Upsert ───────────────────────────────────────────────────────────────

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

  // ─── Update ───────────────────────────────────────────────────────────────

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

  /// Update reactions của 1 message trong DB.
  Future<void> applyReaction(
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

  // ─── Lookup ───────────────────────────────────────────────────────────────

  /// Lookup 1 message: DB trước, fallback fetch API nếu không có.
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
