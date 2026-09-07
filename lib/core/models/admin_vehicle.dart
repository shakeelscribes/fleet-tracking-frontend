// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

import 'vehicle_live.dart';

part 'admin_vehicle.freezed.dart';
part 'admin_vehicle.g.dart';

/// GET /admin/vehicles - fleet overview rows (admin role only, server-gated).
@freezed
abstract class AdminVehicle with _$AdminVehicle {
  const factory AdminVehicle({
    required int id,
    required String code,
    required String name,
    @JsonKey(name: 'is_active') @Default(true) bool isActive,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'current_location') VehicleLive? currentLocation,
  }) = _AdminVehicle;

  factory AdminVehicle.fromJson(Map<String, dynamic> json) =>
      _$AdminVehicleFromJson(json);
}
