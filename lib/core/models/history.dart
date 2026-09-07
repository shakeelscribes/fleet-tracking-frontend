// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'history.g.dart';

/// GET /me/vehicle/history - the caller's own vehicle trail.
///
/// Hand-written (not freezed): freezed 3.2.3 emits invalid `required final`
/// constructor params for List-of-freezed fields.
@JsonSerializable()
class HistoryOut {
  const HistoryOut({
    @JsonKey(name: 'vehicle_id') required this.vehicleId,
    required this.count,
    required this.points,
  });

  factory HistoryOut.fromJson(Map<String, dynamic> json) =>
      _$HistoryOutFromJson(json);

  @JsonKey(name: 'vehicle_id')
  final int vehicleId;
  final int count;
  final List<HistoryPoint> points;

  Map<String, dynamic> toJson() => _$HistoryOutToJson(this);
}

@JsonSerializable()
class HistoryPoint {
  const HistoryPoint({
    required this.lat,
    required this.lng,
    required this.speed,
    @JsonKey(name: 'recorded_at') required this.recordedAt,
  });

  factory HistoryPoint.fromJson(Map<String, dynamic> json) =>
      _$HistoryPointFromJson(json);

  final double lat;
  final double lng;
  final double speed;
  @JsonKey(name: 'recorded_at')
  final DateTime recordedAt;

  Map<String, dynamic> toJson() => _$HistoryPointToJson(this);
}
