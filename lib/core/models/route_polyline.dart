// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'route_polyline.g.dart';

/// GET /me/route - the caller's assigned route polyline (JSONB waypoints).
///
/// Hand-written (not freezed): freezed 3.2.3 emits invalid `required final`
/// constructor params for List-of-freezed fields.
@JsonSerializable()
class RoutePolyline {
  const RoutePolyline({
    required this.id,
    required this.name,
    required this.waypoints,
  });

  factory RoutePolyline.fromJson(Map<String, dynamic> json) =>
      _$RoutePolylineFromJson(json);

  final int id;
  final String name;
  final List<Waypoint> waypoints;

  Map<String, dynamic> toJson() => _$RoutePolylineToJson(this);
}

@JsonSerializable()
class Waypoint {
  const Waypoint({required this.lat, required this.lng});

  factory Waypoint.fromJson(Map<String, dynamic> json) =>
      _$WaypointFromJson(json);

  final double lat;
  final double lng;

  Map<String, dynamic> toJson() => _$WaypointToJson(this);
}
