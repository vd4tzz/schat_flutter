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

  Stream<List<AppNotification>> watch() {
    return (_db.select(_db.cachedNotificationTable)
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
        .watch()
        .map((rows) => rows.map(_rowToModel).toList());
  }

  Future<Result<void>> refresh() => _fetchAndCache();

  Future<Result<void>> _fetchAndCache() async {
    try {
      final latestRow =
          await (_db.select(_db.cachedNotificationTable)
                ..orderBy([(t) => OrderingTerm.desc(t.createdAt)])
                ..limit(1))
              .getSingleOrNull();

      // Offline > 30 ngày hoặc lần đầu → full refresh (xóa cache cũ)
      // Trong vòng 30 ngày → incremental sync với since
      final latestCreatedAt = latestRow != null
          ? DateTime.parse(latestRow.createdAt)
          : null;
      final isStale =
          latestCreatedAt == null ||
          DateTime.now().difference(latestCreatedAt).inDays >= 30;

      if (isStale) {
        await _db.delete(_db.cachedNotificationTable).go();
      }

      final since = isStale ? null : latestRow!.createdAt;

      int page = 1;
      const limit = 50;

      while (true) {
        final response = await _apiClient.dio.get(
          ApiConstants.notifications,
          queryParameters: {'page': page, 'limit': limit, 'since': since},
        );

        final fetched = (response.data['data'] as List)
            .map((e) => AppNotification.fromJson(e as Map<String, dynamic>))
            .toList();

        if (fetched.isEmpty) break;

        await _db.batch(
          (b) => b.insertAll(
            _db.cachedNotificationTable,
            fetched.map(_modelToCompanion),
            mode: InsertMode.insertOrReplace,
          ),
        );

        final total = response.data['total'] as int;
        if (page * limit >= total) break;
        page++;
      }

      return Result.success(null);
    } on DioException catch (e) {
      final (message, code) = parseApiError(e);
      return Result.failure(message, code);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  // delete later
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
    await (_db.update(
      _db.cachedNotificationTable,
    )).write(const CachedNotificationTableCompanion(isRead: Value(true)));

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
    await (_db.delete(
      _db.cachedNotificationTable,
    )..where((t) => t.id.equals(id))).go();

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

  Future<void> insertNotification(AppNotification notification) => _db
      .into(_db.cachedNotificationTable)
      .insertOnConflictUpdate(_modelToCompanion(notification));

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
