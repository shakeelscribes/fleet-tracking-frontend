// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tracking_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// GET /me/assignment - server-enforced pair; 403 `no_assignment` surfaces
/// as ForbiddenException and Home renders the "contact admin" state.

@ProviderFor(assignment)
final assignmentProvider = AssignmentProvider._();

/// GET /me/assignment - server-enforced pair; 403 `no_assignment` surfaces
/// as ForbiddenException and Home renders the "contact admin" state.

final class AssignmentProvider
    extends
        $FunctionalProvider<
          AsyncValue<Assignment>,
          Assignment,
          FutureOr<Assignment>
        >
    with $FutureModifier<Assignment>, $FutureProvider<Assignment> {
  /// GET /me/assignment - server-enforced pair; 403 `no_assignment` surfaces
  /// as ForbiddenException and Home renders the "contact admin" state.
  AssignmentProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'assignmentProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$assignmentHash();

  @$internal
  @override
  $FutureProviderElement<Assignment> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Assignment> create(Ref ref) {
    return assignment(ref);
  }
}

String _$assignmentHash() => r'9bf7a5ad27ed20846a82c90b0209598334c4bc18';

/// GET /me/route - polyline for the assigned route (reloads when the
/// assignment changes, e.g. after re-login as another driver).

@ProviderFor(routePolyline)
final routePolylineProvider = RoutePolylineProvider._();

/// GET /me/route - polyline for the assigned route (reloads when the
/// assignment changes, e.g. after re-login as another driver).

final class RoutePolylineProvider
    extends
        $FunctionalProvider<
          AsyncValue<RoutePolyline>,
          RoutePolyline,
          FutureOr<RoutePolyline>
        >
    with $FutureModifier<RoutePolyline>, $FutureProvider<RoutePolyline> {
  /// GET /me/route - polyline for the assigned route (reloads when the
  /// assignment changes, e.g. after re-login as another driver).
  RoutePolylineProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'routePolylineProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$routePolylineHash();

  @$internal
  @override
  $FutureProviderElement<RoutePolyline> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<RoutePolyline> create(Ref ref) {
    return routePolyline(ref);
  }
}

String _$routePolylineHash() => r'454d963ff979c4a1e77ccb313c778dbb950a52db';

/// GET /me/vehicle/current, polled every [AppConstants.livePollInterval].
///
/// Stream (not Future) so Home and Map watch ONE poller: it runs while any
/// screen listens and cancels itself when the last listener leaves
/// (autoDispose). The simulator publishes a fix every 2s; 5s is fresh
/// without hammering the free-tier Render free instance.

@ProviderFor(vehicleLive)
final vehicleLiveProvider = VehicleLiveProvider._();

/// GET /me/vehicle/current, polled every [AppConstants.livePollInterval].
///
/// Stream (not Future) so Home and Map watch ONE poller: it runs while any
/// screen listens and cancels itself when the last listener leaves
/// (autoDispose). The simulator publishes a fix every 2s; 5s is fresh
/// without hammering the free-tier Render free instance.

final class VehicleLiveProvider
    extends
        $FunctionalProvider<
          AsyncValue<VehicleLive>,
          VehicleLive,
          Stream<VehicleLive>
        >
    with $FutureModifier<VehicleLive>, $StreamProvider<VehicleLive> {
  /// GET /me/vehicle/current, polled every [AppConstants.livePollInterval].
  ///
  /// Stream (not Future) so Home and Map watch ONE poller: it runs while any
  /// screen listens and cancels itself when the last listener leaves
  /// (autoDispose). The simulator publishes a fix every 2s; 5s is fresh
  /// without hammering the free-tier Render free instance.
  VehicleLiveProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'vehicleLiveProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$vehicleLiveHash();

  @$internal
  @override
  $StreamProviderElement<VehicleLive> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<VehicleLive> create(Ref ref) {
    return vehicleLive(ref);
  }
}

String _$vehicleLiveHash() => r'f656876bc70b668d56a2dbdc3d7cd8f50bfe4d9c';

/// GET /me/vehicle/history - pull-to-refresh via ref.invalidate.

@ProviderFor(vehicleHistory)
final vehicleHistoryProvider = VehicleHistoryProvider._();

/// GET /me/vehicle/history - pull-to-refresh via ref.invalidate.

final class VehicleHistoryProvider
    extends
        $FunctionalProvider<
          AsyncValue<HistoryOut>,
          HistoryOut,
          FutureOr<HistoryOut>
        >
    with $FutureModifier<HistoryOut>, $FutureProvider<HistoryOut> {
  /// GET /me/vehicle/history - pull-to-refresh via ref.invalidate.
  VehicleHistoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'vehicleHistoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$vehicleHistoryHash();

  @$internal
  @override
  $FutureProviderElement<HistoryOut> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<HistoryOut> create(Ref ref) {
    return vehicleHistory(ref);
  }
}

String _$vehicleHistoryHash() => r'8ebcb1c88cd875928bee26f64b5fd0b9e6be1fea';
