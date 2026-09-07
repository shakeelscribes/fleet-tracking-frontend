import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/models/admin_vehicle.dart';
import '../../../../core/network/api_providers.dart';

part 'fleet_providers.g.dart';

/// GET /admin/vehicles - every vehicle + derived live status (admin only).
@riverpod
Future<List<AdminVehicle>> fleet(Ref ref) async {
  final api = ref.watch(adminApiProvider);
  return api.listVehicles();
}
