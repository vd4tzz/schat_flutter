import 'package:dio/dio.dart';

import '../../core/constants/api_constants.dart';
import '../local/token_storage.dart';

class ApiClient {
  final Dio _dio;
  final TokenStorage _tokenStorage;

  ApiClient(this._tokenStorage) : _dio = Dio(_baseOptions()) {
    _dio.interceptors.add(_AuthInterceptor(_tokenStorage, _dio));
  }

  Dio get dio => _dio;

  static BaseOptions _baseOptions() => BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 15),
        headers: {'Content-Type': 'application/json'},
      );
}

class _AuthInterceptor extends Interceptor {
  final TokenStorage _tokenStorage;
  final Dio _dio;

  // Tránh gọi refresh đồng thời nhiều lần
  bool _isRefreshing = false;
  final _pendingRequests = <({RequestOptions options, ErrorInterceptorHandler handler})>[];

  _AuthInterceptor(this._tokenStorage, this._dio);

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _tokenStorage.getAccessToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final statusCode = err.response?.statusCode;
    final isRefreshEndpoint = err.requestOptions.path == ApiConstants.refresh;

    if (statusCode != 401 || isRefreshEndpoint) {
      return handler.next(err);
    }

    if (_isRefreshing) {
      _pendingRequests.add((options: err.requestOptions, handler: handler));
      return;
    }

    _isRefreshing = true;

    final refreshed = await _tryRefreshToken();

    if (refreshed) {
      final token = await _tokenStorage.getAccessToken();
      await _retryRequest(err.requestOptions, token!, handler);
      for (final pending in _pendingRequests) {
        await _retryRequest(pending.options, token, pending.handler);
      }
    } else {
      await _tokenStorage.clearTokens();
      handler.next(err);
      for (final pending in _pendingRequests) {
        pending.handler.next(err);
      }
    }

    _pendingRequests.clear();
    _isRefreshing = false;
  }

  Future<void> _retryRequest(
    RequestOptions requestOptions,
    String token,
    ErrorInterceptorHandler handler,
  ) async {
    requestOptions.headers['Authorization'] = 'Bearer $token';
    try {
      final response = await _dio.fetch(requestOptions);
      handler.resolve(response);
    } on DioException catch (e) {
      handler.next(e);
    }
  }

  Future<bool> _tryRefreshToken() async {
    final refreshToken = await _tokenStorage.getRefreshToken();
    if (refreshToken == null) return false;

    try {
      // Dùng Dio mới, không qua interceptor để tránh vòng lặp vô tận
      final dio = Dio(_baseOptions());
      final response = await dio.post(
        ApiConstants.refresh,
        data: {'refreshToken': refreshToken},
      );
      final data = response.data as Map<String, dynamic>;
      await _tokenStorage.saveTokens(
        accessToken: data['accessToken'] as String,
        refreshToken: data['refreshToken'] as String,
      );
      return true;
    } catch (_) {
      return false;
    }
  }

  static BaseOptions _baseOptions() => BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 15),
        headers: {'Content-Type': 'application/json'},
      );
}
