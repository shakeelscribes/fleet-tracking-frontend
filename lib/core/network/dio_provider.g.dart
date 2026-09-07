// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dio_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(tokenStore)
final tokenStoreProvider = TokenStoreProvider._();

final class TokenStoreProvider
    extends $FunctionalProvider<TokenStore, TokenStore, TokenStore>
    with $Provider<TokenStore> {
  TokenStoreProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'tokenStoreProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$tokenStoreHash();

  @$internal
  @override
  $ProviderElement<TokenStore> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  TokenStore create(Ref ref) {
    return tokenStore(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TokenStore value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TokenStore>(value),
    );
  }
}

String _$tokenStoreHash() => r'1a3723cb9c87a80308bd518f02c3e17b42cdd4e8';

/// Single Dio for the whole app (skill ANTI-23: never create Dio in widgets).
///
/// Interceptors, in order:
/// 1. [_AuthInterceptor] - bearer header + one transparent refresh on 401.
/// 2. [_ErrorMappingInterceptor] - DioException -> AppException (skill EH-2).

@ProviderFor(dioClient)
final dioClientProvider = DioClientProvider._();

/// Single Dio for the whole app (skill ANTI-23: never create Dio in widgets).
///
/// Interceptors, in order:
/// 1. [_AuthInterceptor] - bearer header + one transparent refresh on 401.
/// 2. [_ErrorMappingInterceptor] - DioException -> AppException (skill EH-2).

final class DioClientProvider extends $FunctionalProvider<Dio, Dio, Dio>
    with $Provider<Dio> {
  /// Single Dio for the whole app (skill ANTI-23: never create Dio in widgets).
  ///
  /// Interceptors, in order:
  /// 1. [_AuthInterceptor] - bearer header + one transparent refresh on 401.
  /// 2. [_ErrorMappingInterceptor] - DioException -> AppException (skill EH-2).
  DioClientProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dioClientProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dioClientHash();

  @$internal
  @override
  $ProviderElement<Dio> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Dio create(Ref ref) {
    return dioClient(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Dio value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Dio>(value),
    );
  }
}

String _$dioClientHash() => r'040f897d7a8f95ed8fa64659765ddc9c34725322';
