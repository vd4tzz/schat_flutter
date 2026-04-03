import 'package:dio/dio.dart';

import '../../core/result/result.dart';
import '../../core/utils/api_error.dart';
import '../local/token_storage.dart';
import '../models/auth_request.dart';
import '../models/auth_response.dart';
import '../remote/api_client.dart';

class AuthRepository {
  final TokenStorage _tokenStorage;
  final ApiClient _apiClient;

  AuthRepository(this._tokenStorage, this._apiClient);

  Future<bool> isLoggedIn() => _tokenStorage.hasTokens();

  Future<Result<int>> register({
    required String fullName,
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      final request = RegisterRequest(
        fullName: fullName,
        username: username,
        email: email,
        password: password,
      );

      final response = await _apiClient.dio.post(
        '/auth/register',
        data: request.toJson(),
      );

      final registerResponse = RegisterResponse.fromJson(
        response.data as Map<String, dynamic>,
      );

      return Result.success(registerResponse.otpExpiresIn);
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
      final request = VerifyOtpRequest(email: email, otp: otp);

      await _apiClient.dio.post(
        '/auth/verify-otp',
        data: request.toJson(),
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
      final request = ResendOtpRequest(email: email);

      await _apiClient.dio.post(
        '/auth/resend-otp',
        data: request.toJson(),
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
      final request = LoginRequest(identifier: identifier, password: password);

      final response = await _apiClient.dio.post(
        '/auth/login',
        data: request.toJson(),
      );

      final loginResponse = LoginResponse.fromJson(
        response.data as Map<String, dynamic>,
      );

      await _tokenStorage.saveTokens(
        accessToken: loginResponse.accessToken,
        refreshToken: loginResponse.refreshToken,
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
        final request = RefreshTokenRequest(refreshToken: refreshToken);
        await _apiClient.dio.post(
          '/auth/logout',
          data: request.toJson(),
        );
      }

      await _tokenStorage.clearTokens();
      return Result.success(null);
    } catch (e) {
      // Logout luôn thành công (client-side)
      await _tokenStorage.clearTokens();
      return Result.success(null);
    }
  }
}
