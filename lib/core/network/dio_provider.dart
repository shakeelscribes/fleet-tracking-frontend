import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../errors/error_mapper.dart';
import '../providers/auth_provider.dart';
import '../utils/constants.dart';

part 'dio_provider.g.dart';

/// Token store (skill ANTI-33: never SharedPreferences for secrets).
/// Exposed as a keep-alive provider so every consumer shares one instance.
class TokenStore {
  static const _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  static const _accessKey = 'fleet_access_token';
  static const _refreshKey = 'fleet_refresh_token';

  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    await _storage.write(key: _accessKey, value: accessToken);
    await _storage.write(key: _refreshKey, value: refreshToken);
  }

  Future<String?> getAccessToken() => _storage.read(key: _accessKey);

  Future<String?> getRefreshToken() => _storage.read(key: _refreshKey);

  Future<void> clearTokens() async {
    await _storage.delete(key: _accessKey);
    await _storage.delete(key: _refreshKey);
  }
}

@Riverpod(keepAlive: true)
TokenStore tokenStore(Ref ref) => TokenStore();

/// Single Dio for the whole app (skill ANTI-23: never create Dio in widgets).
///
/// Interceptors, in order:
/// 1. [_AuthInterceptor] - bearer header + one transparent refresh on 401.
/// 2. [_ErrorMappingInterceptor] - DioException -> AppException (skill EH-2).
@Riverpod(keepAlive: true)
Dio dioClient(Ref ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: AppConstants.baseUrl,
      contentType: Headers.jsonContentType,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 15),
    ),
  );

  dio.interceptors.addAll([_AuthInterceptor(ref), _ErrorMappingInterceptor()]);

  if (kDebugMode) {
    dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        logPrint: (o) => debugPrint(o.toString()),
      ),
    );
  }
  return dio;
}

/// Adds the bearer token; on 401 (expired access token) tries ONE refresh
/// with the stored refresh token and replays the original request.
class _AuthInterceptor extends Interceptor {
  _AuthInterceptor(this._ref);
  final Ref _ref;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _ref.read(tokenStoreProvider).getAccessToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode != 401) {
      return handler.next(err);
    }

    final storage = _ref.read(tokenStoreProvider);
    final refreshToken = await storage.getRefreshToken();
    if (refreshToken == null) {
      await _ref.read(authControllerProvider.notifier).forceSignOut();
      return handler.next(err);
    }

    try {
      // Bare Dio: no interceptors here, or a 401 from /refresh would recurse.
      final bare = Dio(BaseOptions(baseUrl: AppConstants.baseUrl));
      final response = await bare.post(
        '/auth/refresh',
        data: {'refresh_token': refreshToken},
      );
      final tokens = response.data as Map<String, dynamic>;
      await storage.saveTokens(
        accessToken: tokens['access_token'] as String,
        refreshToken: tokens['refresh_token'] as String,
      );

      final replay = err.requestOptions;
      replay.headers['Authorization'] =
          'Bearer ${tokens['access_token'] as String}';
      final dio = _ref.read(dioClientProvider);
      final ok = await dio.fetch<dynamic>(replay);
      return handler.resolve(ok);
    } on DioException {
      await _ref.read(authControllerProvider.notifier).forceSignOut();
      return handler.next(err);
    }
  }
}

/// Maps every DioException to the sealed AppException before it reaches
/// providers (skill EH-2), so notifiers never see raw Dio types.
class _ErrorMappingInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    handler.next(err.copyWith(error: mapDioException(err)));
  }
}
