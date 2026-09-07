// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fleet_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// GET /admin/vehicles - every vehicle + derived live status (admin only).

@ProviderFor(fleet)
final fleetProvider = FleetProvider._();

/// GET /admin/vehicles - every vehicle + derived live status (admin only).

final class FleetProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<AdminVehicle>>,
          List<AdminVehicle>,
          FutureOr<List<AdminVehicle>>
        >
    with
        $FutureModifier<List<AdminVehicle>>,
        $FutureProvider<List<AdminVehicle>> {
  /// GET /admin/vehicles - every vehicle + derived live status (admin only).
  FleetProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'fleetProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$fleetHash();

  @$internal
  @override
  $FutureProviderElement<List<AdminVehicle>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<AdminVehicle>> create(Ref ref) {
    return fleet(ref);
  }
}

String _$fleetHash() => r'e57cd8b906d69820f2ebb8c03b9a0d489e9ed22d';
