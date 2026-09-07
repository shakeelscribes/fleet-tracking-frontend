import 'package:dio/dio.dart';

import 'app_exception.dart';

/// DioException -> AppException (skill EH-2).
///
/// Understands the backend's uniform error envelope:
/// `{"error": {"code": "...", "message": "..."}}`.
AppException mapDioException(DioException e) {
  final type = e.type;
  if (type == DioExceptionType.connectionTimeout ||
      type == DioExceptionType.sendTimeout ||
      type == DioExceptionType.receiveTimeout ||
      type == DioExceptionType.connectionError) {
    return const AppException.network();
  }

  final statusCode = e.response?.statusCode;
  final data = e.response?.data;
  final envelope = (data is Map<String, dynamic>)
      ? data['error'] as Map<String, dynamic>?
      : null;
  final code = envelope?['code']?.toString() ?? 'unknown_error';
  final message = envelope?['message']?.toString() ?? 'Request failed';

  return switch (statusCode) {
    401 => const AppException.unauthorized(),
    403 => AppException.forbidden(code: code, message: message),
    404 => const AppException.notFound(),
    _ => AppException.server(
      statusCode: statusCode ?? 0,
      code: code,
      message: message,
    ),
  };
}
