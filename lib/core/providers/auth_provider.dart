// ignore_for_file: invalid_annotation_target
import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../errors/app_exception.dart';
import '../errors/error_mapper.dart';
import '../models/auth_requests.dart';
import '../models/token_pair.dart';
import '../models/user_profile.dart';
import '../network/api_providers.dart';
import '../network/dio_provider.dart';

part 'auth_provider.freezed.dart';
part 'auth_provider.g.dart';

/// Session state: the ONLY two shapes the app understands. Loading is
/// AsyncValue.isLoading on the controller itself (splash while restoring).
@freezed
sealed class AuthState with _$AuthState {
  const factory AuthState.signedOut() = AuthSignedOut;

  const factory AuthState.signedIn({required UserProfile profile}) =
      AuthSignedIn;
}

/// App-wide session (keep-alive). Restores the session on boot from the
/// stored access token; survives until logout or a fatal 401.
@Riverpod(keepAlive: true)
class AuthController extends _$AuthController {
  @override
  Future<AuthState> build() async {
    final storage = ref.watch(tokenStoreProvider);
    final token = await storage.getAccessToken();
    if (token == null) {
      return const AuthState.signedOut();
    }
    try {
      final profile = await ref.watch(meApiProvider).getProfile();
      return AuthState.signedIn(profile: profile);
    } catch (_) {
      // Access token exists but is unusable (Retrofit rethrows DioException
      // even when the interceptor mapped it) - treat as no session.
      await storage.clearTokens();
      return const AuthState.signedOut();
    }
  }

  /// Login + immediate profile fetch (role drives navigation).
  Future<void> login(String email, String password) async {
    final authApi = ref.read(authApiProvider);
    final TokenPair tokens = await authApi.login(
      LoginRequest(email: email, password: password),
    );
    await ref
        .read(tokenStoreProvider)
        .saveTokens(
          accessToken: tokens.accessToken,
          refreshToken: tokens.refreshToken,
        );

    final profile = await ref.read(meApiProvider).getProfile();
    state = AsyncValue.data(AuthState.signedIn(profile: profile));
  }

  Future<void> logout() async {
    await ref.read(tokenStoreProvider).clearTokens();
    state = const AsyncValue.data(AuthState.signedOut());
  }

  /// Invoked by the Dio interceptor when a refresh also fails (fatal 401).
  Future<void> forceSignOut() async {
    if (state.value is AuthSignedIn) {
      await logout();
    }
  }
}

/// Normalizes anything a repository call can throw into [AppException].
/// Retrofit rethrows Dio's DioException with our mapped error riding in
/// `.error`, so unwrapping must happen here - `on AppException` alone
/// never matches at call sites.
AppException extractAppException(Object error) {
  if (error is AppException) return error;
  if (error is DioException) {
    final inner = error.error;
    if (inner is AppException) return inner;
    return mapDioException(error);
  }
  return AppException.unknown(error: error);
}

/// Async body wrapper for providers/screens: catches EVERYTHING (Retrofit
/// rethrows DioException with the mapped error inside), unwraps to
/// [AppException].
Future<T> guardApi<T>(Future<T> Function() body) async {
  try {
    return await body();
  } catch (e, st) {
    Error.throwWithStackTrace(extractAppException(e), st);
  }
}
