import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/models/assignment.dart';
import '../../../../core/models/history.dart';
import '../../../../core/models/route_polyline.dart';
import '../../../../core/models/vehicle_live.dart';
import '../../../../core/network/api_providers.dart';
import '../../../../core/utils/constants.dart';

part 'tracking_providers.g.dart';

/// GET /me/assignment - server-enforced pair; 403 `no_assignment` surfaces
/// as ForbiddenException and Home renders the "contact admin" state.
@riverpod
Future<Assignment> assignment(Ref ref) async {
  final api = ref.watch(meApiProvider);
  return api.getAssignment();
}

/// GET /me/route - polyline for the assigned route (reloads when the
/// assignment changes, e.g. after re-login as another driver).
@riverpod
Future<RoutePolyline> routePolyline(Ref ref) async {
  final api = ref.watch(meApiProvider);
  return api.getRoute();
}

/// GET /me/vehicle/current, polled every [AppConstants.livePollInterval].
///
/// Stream (not Future) so Home and Map watch ONE poller: it runs while any
/// screen listens and cancels itself when the last listener leaves
/// (autoDispose). The simulator publishes a fix every 2s; 5s is fresh
/// without hammering the free-tier Render free instance.
@riverpod
Stream<VehicleLive> vehicleLive(Ref ref) async* {
  final api = ref.watch(meApiProvider);
  while (true) {
    // `on Object`: Retrofit rethrows DioException (mapped error rides in
    // `.error`), so an `on AppException` catch would never match - and an
    // uncaught throw kills the poll loop. ANY failure surfaces as an
    // offline fix and the loop keeps polling (never hot-retries: the
    // delay is on the shared path, not inside the catch).
    try {
      yield await api.getVehicleCurrent();
    } on Object {
      yield VehicleLive(vehicleId: 0, vehicleCode: '', status: 'offline');
    }
    await Future<void>.delayed(AppConstants.livePollInterval);
  }
}

/// GET /me/vehicle/history - pull-to-refresh via ref.invalidate.
@riverpod
Future<HistoryOut> vehicleHistory(Ref ref) async {
  final api = ref.watch(meApiProvider);
  final history = await api.getVehicleHistory(limit: 500, offset: 0);
  // Backend streams oldest-first; the UI contract is newest-first so the
  // latest fix is row 1 (no scrolling to the bottom to find "now").
  return HistoryOut(
    vehicleId: history.vehicleId,
    count: history.count,
    points: history.points.reversed.toList(),
  );
}
