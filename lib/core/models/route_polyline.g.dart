// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route_polyline.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoutePolyline _$RoutePolylineFromJson(Map<String, dynamic> json) =>
    RoutePolyline(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      waypoints: (json['waypoints'] as List<dynamic>)
          .map((e) => Waypoint.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RoutePolylineToJson(RoutePolyline instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'waypoints': instance.waypoints,
    };

Waypoint _$WaypointFromJson(Map<String, dynamic> json) => Waypoint(
  lat: (json['lat'] as num).toDouble(),
  lng: (json['lng'] as num).toDouble(),
);

Map<String, dynamic> _$WaypointToJson(Waypoint instance) => <String, dynamic>{
  'lat': instance.lat,
  'lng': instance.lng,
};
