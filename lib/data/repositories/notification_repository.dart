import 'package:dio/dio.dart';

import '../../core/constants/api_constants.dart';
import '../../core/result/result.dart';
import '../../core/utils/api_error.dart';
import '../models/app_notification.dart';
import '../remote/api_client.dart';

class NotificationRepository {
  final ApiClient _apiClient;

  NotificationRepository(this._apiClient);

  Future<Result<List<AppNotification>>> list() async {
    try {
      final response = await _apiClient.dio.get(ApiConstants.notifications);
      final list = ((response.data['data']) as List)
          .map((e) => AppNotification.fromJson(e as Map<String, dynamic>))
          .toList();
      return Result.success(list);
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
}
