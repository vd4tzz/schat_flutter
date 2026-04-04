import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:drift/drift.dart';

import '../../core/constants/api_constants.dart';
import '../../core/result/result.dart';
import '../../core/utils/api_error.dart';
import '../local/app_database.dart';
import '../models/app_notification.dart';
import '../remote/api_client.dart';

class NotificationRepository {
  final ApiClient _apiClient;
  final AppDatabase _db;

  NotificationRepository(this._apiClient, this._db);

  Future<Result<List<AppNotification>>> list() async {
    // 1. Đọc cache trước
    final cached = await (
      _db.select(_db.cachedNotificationTable)
        ..orderBy([(t) => OrderingTerm.desc(t.createdAt)])
    ).get();

    if (cached.isNotEmpty) {
      _fetchAndCache(); // fetch ngầm
      return Result.success(cached.map(_rowToModel).toList());
    }

    // 2. Không có cache → fetch và chờ
    return _fetchAndCache();
  }

  Future<Result<List<AppNotification>>> _fetchAndCache() async {
    try {
      final response = await _apiClient.dio.get(ApiConstants.notifications);
      final fresh = ((response.data['data']) as List)
          .map((e) => AppNotification.fromJson(e as Map<String, dynamic>))
          .toList();

      await _db.transaction(() async {
        await _db.delete(_db.cachedNotificationTable).go();
        await _db.batch(
          (b) => b.insertAll(
            _db.cachedNotificationTable,
            fresh.map(_modelToCompanion),
          ),
        );
      });

      return Result.success(fresh);
    } on DioException catch (e) {
      final (message, code) = parseApiError(e);
      return Result.failure(message, code);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  Future<Result<int>> getUnreadCount() async {
    try {
      final response = await _apiClient.dio.get(
        ApiConstants.notificationsUnreadCount,
      );
      return Result.success(response.data['count'] as int);
    } on DioException catch (e) {
      final (message, code) = parseApiError(e);
      return Result.failure(message, code);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  Future<Result<void>> markAsRead(String id) async {
    // Update local trước (optimistic)
    await (_db.update(_db.cachedNotificationTable)
          ..where((t) => t.id.equals(id)))
        .write(const CachedNotificationTableCompanion(isRead: Value(true)));

    try {
      await _apiClient.dio.patch('${ApiConstants.notifications}/$id/read');
      return Result.success(null);
    } on DioException catch (e) {
      final (message, code) = parseApiError(e);
      return Result.failure(message, code);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  Future<Result<void>> markAllAsRead() async {
    await (_db.update(_db.cachedNotificationTable))
        .write(const CachedNotificationTableCompanion(isRead: Value(true)));

    try {
      await _apiClient.dio.patch(ApiConstants.notificationsReadAll);
      return Result.success(null);
    } on DioException catch (e) {
      final (message, code) = parseApiError(e);
      return Result.failure(message, code);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  Future<Result<void>> delete(String id) async {
    await (_db.delete(_db.cachedNotificationTable)
          ..where((t) => t.id.equals(id)))
        .go();

    try {
      await _apiClient.dio.delete('${ApiConstants.notifications}/$id');
      return Result.success(null);
    } on DioException catch (e) {
      final (message, code) = parseApiError(e);
      return Result.failure(message, code);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  /// Gọi khi nhận notification realtime từ socket
  Future<void> insertNotification(AppNotification notification) =>
      _db.into(_db.cachedNotificationTable).insertOnConflictUpdate(
        _modelToCompanion(notification),
      );

  // Helpers
  AppNotification _rowToModel(CachedNotificationTableData row) =>
      AppNotification(
        id: row.id,
        type: AppNotificationType.fromString(row.type),
        payload: jsonDecode(row.payload) as Map<String, dynamic>,
        isRead: row.isRead,
        createdAt: DateTime.parse(row.createdAt),
      );

  CachedNotificationTableCompanion _modelToCompanion(AppNotification n) =>
      CachedNotificationTableCompanion.insert(
        id: n.id,
        type: n.type.name,
        payload: jsonEncode(n.payload),
        isRead: Value(n.isRead),
        createdAt: n.createdAt.toIso8601String(),
      );
}
