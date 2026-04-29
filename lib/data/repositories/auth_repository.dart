import 'package:dio/dio.dart';

import '../../core/result/result.dart';
import '../../core/utils/api_error.dart';
import '../local/app_database.dart';
import '../local/token_storage.dart';
import '../remote/api_client.dart';

class AuthRepository {
  final TokenStorage _tokenStorage;
  final ApiClient _apiClient;
  final AppDatabase _db;

  AuthRepository(this._tokenStorage, this._apiClient, this._db);

  Future<bool> isLoggedIn() => _tokenStorage.hasTokens();

  Future<Result<int>> register({
    required String fullName,
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      final response = await _apiClient.dio.post(
        '/auth/register',
        data: {
          'fullName': fullName,
          'username': username,
          'email': email,
          'password': password,
        },
      );

      final otpExpiresIn =
          (response.data as Map<String, dynamic>)['otpExpiresIn'] as int;

      return Result.success(otpExpiresIn);
    } on DioException catch (e) {
      final (message, code) = parseApiError(e);
      return Result.failure(message, code);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  Future<Result<void>> verifyOtp({
    required String email,
    required String otp,
  }) async {
    try {
      await _apiClient.dio.post(
        '/auth/verify-otp',
        data: {'email': email, 'otp': otp},
      );

      return Result.success(null);
    } on DioException catch (e) {
      final (message, code) = parseApiError(e);
      return Result.failure(message, code);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  Future<Result<void>> resendOtp({required String email}) async {
    try {
      await _apiClient.dio.post(
        '/auth/resend-otp',
        data: {'email': email},
      );

      return Result.success(null);
    } on DioException catch (e) {
      final (message, code) = parseApiError(e);
      return Result.failure(message, code);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  Future<Result<void>> login({
    required String identifier,
    required String password,
  }) async {
    try {
      final response = await _apiClient.dio.post(
        '/auth/login',
        data: {'identifier': identifier, 'password': password},
      );

      final data = response.data as Map<String, dynamic>;

      await _tokenStorage.saveTokens(
        accessToken: data['accessToken'] as String,
        refreshToken: data['refreshToken'] as String,
      );

      return Result.success(null);
    } on DioException catch (e) {
      final (message, code) = parseApiError(e);
      return Result.failure(message, code);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  Future<Result<void>> logout() async {
    try {
      final refreshToken = await _tokenStorage.getRefreshToken();
      if (refreshToken != null) {
        await _apiClient.dio.post(
          '/auth/logout',
          data: {'refreshToken': refreshToken},
        );
      }
    } catch (_) {}

    await _tokenStorage.clearTokens();
    await _db.clearAll();
    return Result.success(null);
  }
}
