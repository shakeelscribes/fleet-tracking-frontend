// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_exception.freezed.dart';

/// Sealed domain errors (skill EH-1). Providers catch raw exceptions and
/// expose ONLY these through AsyncValue.error; UI maps them to friendly,
/// localized text - never `e.toString()`.
@freezed
sealed class AppException with _$AppException implements Exception {
  /// No internet / timeout / DNS failure.
  const factory AppException.network({String? message}) = NetworkException;

  /// Backend returned 4xx with its error envelope.
  const factory AppException.server({
    required int statusCode,
    required String code,
    required String message,
  }) = ServerException;

  /// 401 - token expired/invalid (refresh failed too).
  const factory AppException.unauthorized() = UnauthorizedException;

  /// 403 - backend-enforced authorization (e.g. `no_assignment`, admin-only).
  const factory AppException.forbidden({
    required String code,
    String? message,
  }) = ForbiddenException;

  /// 404.
  const factory AppException.notFound() = NotFoundException;

  /// Catch-all.
  const factory AppException.unknown({Object? error}) = UnknownException;
}
