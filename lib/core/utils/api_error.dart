import 'package:dio/dio.dart';

(String message, String? code) parseApiError(DioException e) {
  if (e.type == DioExceptionType.connectionTimeout ||
      e.type == DioExceptionType.receiveTimeout) {
    return ('Connection timeout', null);
  }

  if (e.type == DioExceptionType.unknown) {
    return ('Network error', null);
  }

  final data = e.response?.data as Map<String, dynamic>?;
  final code = data?['errorCode'] as String?;
  final message = data?['message'] as String? ?? e.message ?? 'Unknown error';
  return (message, code);
}
