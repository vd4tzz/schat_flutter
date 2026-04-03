import 'package:dio/dio.dart';

import '../../core/constants/api_constants.dart';
import '../../core/result/result.dart';
import '../../core/utils/api_error.dart';
import '../models/search_user_result.dart';
import '../models/user.dart';
import '../remote/api_client.dart';

class UserRepository {
  final ApiClient _apiClient;

  UserRepository(this._apiClient);

  Future<Result<List<SearchUserResult>>> searchUsers(String query) async {
    try {
      final response = await _apiClient.dio.get(
        ApiConstants.searchUsers,
        queryParameters: {'q': query, 'includeFriendship': true},
      );
      final list = (response.data as List)
          .map((e) => SearchUserResult.fromJson(e as Map<String, dynamic>))
          .toList();
      return Result.success(list);
    } on DioException catch (e) {
      final (message, code) = parseApiError(e);
      return Result.failure(message, code);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  Future<Result<User>> getProfile() async {
    try {
      final response = await _apiClient.dio.get('/users/me');
      final user = User.fromJson(response.data as Map<String, dynamic>);
      return Result.success(user);
    } on DioException catch (e) {
      final (message, code) = parseApiError(e);
      return Result.failure(message, code);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  Future<Result<User>> updateProfile({
    String? fullName,
    String? bio,
    String? gender,
    DateTime? dateOfBirth,
    String? phoneNumber,
  }) async {
    try {
      final data = <String, dynamic>{};
      if (fullName != null) data['fullName'] = fullName;
      if (bio != null) data['bio'] = bio;
      if (gender != null) data['gender'] = gender;
      if (dateOfBirth != null) data['dateOfBirth'] = dateOfBirth.toIso8601String();
      if (phoneNumber != null) data['phoneNumber'] = phoneNumber;

      final response = await _apiClient.dio.patch('/users/me', data: data);
      final user = User.fromJson(response.data as Map<String, dynamic>);
      return Result.success(user);
    } on DioException catch (e) {
      final (message, code) = parseApiError(e);
      return Result.failure(message, code);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  Future<Result<User>> uploadAvatar(String filePath) async {
    try {
      final formData = FormData.fromMap({
        'avatar': await MultipartFile.fromFile(filePath),
      });

      final response = await _apiClient.dio.post(
        '/users/me/avatar',
        data: formData,
      );

      final user = User.fromJson(response.data as Map<String, dynamic>);
      return Result.success(user);
    } on DioException catch (e) {
      final (message, code) = parseApiError(e);
      return Result.failure(message, code);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  Future<Result<User>> deleteAvatar() async {
    try {
      final response = await _apiClient.dio.delete('/users/me/avatar');
      final user = User.fromJson(response.data as Map<String, dynamic>);
      return Result.success(user);
    } on DioException catch (e) {
      final (message, code) = parseApiError(e);
      return Result.failure(message, code);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  Future<Result<User>> uploadBackground(String filePath) async {
    try {
      final formData = FormData.fromMap({
        'background': await MultipartFile.fromFile(filePath),
      });

      final response = await _apiClient.dio.post(
        '/users/me/background',
        data: formData,
      );

      final user = User.fromJson(response.data as Map<String, dynamic>);
      return Result.success(user);
    } on DioException catch (e) {
      final (message, code) = parseApiError(e);
      return Result.failure(message, code);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  Future<Result<User>> deleteBackground() async {
    try {
      final response = await _apiClient.dio.delete('/users/me/background');
      final user = User.fromJson(response.data as Map<String, dynamic>);
      return Result.success(user);
    } on DioException catch (e) {
      final (message, code) = parseApiError(e);
      return Result.failure(message, code);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }
}
