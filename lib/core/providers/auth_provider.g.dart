// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// App-wide session (keep-alive). Restores the session on boot from the
/// stored access token; survives until logout or a fatal 401.

@ProviderFor(AuthController)
final authControllerProvider = AuthControllerProvider._();

/// App-wide session (keep-alive). Restores the session on boot from the
/// stored access token; survives until logout or a fatal 401.
final class AuthControllerProvider
    extends $AsyncNotifierProvider<AuthController, AuthState> {
  /// App-wide session (keep-alive). Restores the session on boot from the
  /// stored access token; survives until logout or a fatal 401.
  AuthControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authControllerHash();

  @$internal
  @override
  AuthController create() => AuthController();
}

String _$authControllerHash() => r'144d0fe722c1add0989d19d59fc24d0855ebf90a';

/// App-wide session (keep-alive). Restores the session on boot from the
/// stored access token; survives until logout or a fatal 401.

abstract class _$AuthController extends $AsyncNotifier<AuthState> {
  FutureOr<AuthState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<AuthState>, AuthState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<AuthState>, AuthState>,
              AsyncValue<AuthState>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
