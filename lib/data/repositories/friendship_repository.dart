import 'package:dio/dio.dart';

import '../../core/constants/api_constants.dart';
import '../../core/result/result.dart';
import '../../core/utils/api_error.dart';
import '../models/friend_request.dart';
import '../models/search_user_result.dart';
import '../remote/api_client.dart';

class FriendshipRepository {
  final ApiClient _apiClient;

  FriendshipRepository(this._apiClient);

  Future<Result<FriendshipInfo>> sendRequest(String addresseeId) async {
    try {
      final response = await _apiClient.dio.post(
        ApiConstants.friendRequests,
        data: {'addresseeId': addresseeId},
      );
      final data = response.data as Map<String, dynamic>;
      return Result.success(
        FriendshipInfo(
          status: FriendshipStatus.pendingSent,
          friendshipId: data['id'] as String,
        ),
      );
    } on DioException catch (e) {
      final (message, code) = parseApiError(e);
      return Result.failure(message, code);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  Future<Result<List<FriendRequest>>> listIncomingRequests() async {
    try {
      final response = await _apiClient.dio.get(ApiConstants.incomingRequests);
      final list = ((response.data['data']) as List)
          .map((e) => FriendRequest.fromJson(e as Map<String, dynamic>))
          .toList();
      return Result.success(list);
    } on DioException catch (e) {
      final (message, code) = parseApiError(e);
      return Result.failure(message, code);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  Future<Result<void>> acceptRequest(String friendshipId) async {
    try {
      await _apiClient.dio.post(
        '${ApiConstants.friendRequests}/$friendshipId/accept',
      );
      return Result.success(null);
    } on DioException catch (e) {
      final (message, code) = parseApiError(e);
      return Result.failure(message, code);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  Future<Result<void>> rejectRequest(String friendshipId) async {
    try {
      await _apiClient.dio.post(
        '${ApiConstants.friendRequests}/$friendshipId/reject',
      );
      return Result.success(null);
    } on DioException catch (e) {
      final (message, code) = parseApiError(e);
      return Result.failure(message, code);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  Future<Result<void>> unfriend(String friendshipId) async {
    try {
      await _apiClient.dio.delete('${ApiConstants.friendships}/$friendshipId');
      return Result.success(null);
    } on DioException catch (e) {
      final (message, code) = parseApiError(e);
      return Result.failure(message, code);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }
}
