// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(authApi)
final authApiProvider = AuthApiProvider._();

final class AuthApiProvider
    extends $FunctionalProvider<AuthApi, AuthApi, AuthApi>
    with $Provider<AuthApi> {
  AuthApiProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authApiProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authApiHash();

  @$internal
  @override
  $ProviderElement<AuthApi> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AuthApi create(Ref ref) {
    return authApi(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AuthApi value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuthApi>(value),
    );
  }
}

String _$authApiHash() => r'78e8aaec68f25c41e945aed300d265ee9385585a';

@ProviderFor(meApi)
final meApiProvider = MeApiProvider._();

final class MeApiProvider extends $FunctionalProvider<MeApi, MeApi, MeApi>
    with $Provider<MeApi> {
  MeApiProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'meApiProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$meApiHash();

  @$internal
  @override
  $ProviderElement<MeApi> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  MeApi create(Ref ref) {
    return meApi(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MeApi value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MeApi>(value),
    );
  }
}

String _$meApiHash() => r'2bf09e121fa2b23dc1542983e6c9e93ac1c0cb3b';

@ProviderFor(adminApi)
final adminApiProvider = AdminApiProvider._();

final class AdminApiProvider
    extends $FunctionalProvider<AdminApi, AdminApi, AdminApi>
    with $Provider<AdminApi> {
  AdminApiProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'adminApiProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$adminApiHash();

  @$internal
  @override
  $ProviderElement<AdminApi> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AdminApi create(Ref ref) {
    return adminApi(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AdminApi value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AdminApi>(value),
    );
  }
}

String _$adminApiHash() => r'ee177643e673cdb0bb44ce8aace71c5dbefcf1f7';
