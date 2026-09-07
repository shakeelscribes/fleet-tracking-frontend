// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'vehicle_live.freezed.dart';
part 'vehicle_live.g.dart';

/// GET /me/vehicle/current (also embedded in the admin fleet list).
///
/// Nulls until the vehicle's first GPS fix arrives; `status` is derived
/// server-side (moving / idle / offline) with one shared rule.
@freezed
abstract class VehicleLive with _$VehicleLive {
  const factory VehicleLive({
    @JsonKey(name: 'vehicle_id') required int vehicleId,
    @JsonKey(name: 'vehicle_code') required String vehicleCode,
    double? lat,
    double? lng,
    double? speed,
    @JsonKey(name: 'recorded_at') DateTime? recordedAt,
    @Default('offline') String status,
  }) = _VehicleLive;

  factory VehicleLive.fromJson(Map<String, dynamic> json) =>
      _$VehicleLiveFromJson(json);
}

/// The three backend-derived statuses, as a typed view for UI switches.
enum LiveStatus { moving, idle, offline }

LiveStatus liveStatusOf(String raw) => switch (raw) {
  'moving' => LiveStatus.moving,
  'idle' => LiveStatus.idle,
  _ => LiveStatus.offline,
};
