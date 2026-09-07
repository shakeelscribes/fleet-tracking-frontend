// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HistoryOut _$HistoryOutFromJson(Map<String, dynamic> json) => HistoryOut(
  vehicleId: (json['vehicle_id'] as num).toInt(),
  count: (json['count'] as num).toInt(),
  points: (json['points'] as List<dynamic>)
      .map((e) => HistoryPoint.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$HistoryOutToJson(HistoryOut instance) =>
    <String, dynamic>{
      'vehicle_id': instance.vehicleId,
      'count': instance.count,
      'points': instance.points,
    };

HistoryPoint _$HistoryPointFromJson(Map<String, dynamic> json) => HistoryPoint(
  lat: (json['lat'] as num).toDouble(),
  lng: (json['lng'] as num).toDouble(),
  speed: (json['speed'] as num).toDouble(),
  recordedAt: DateTime.parse(json['recorded_at'] as String),
);

Map<String, dynamic> _$HistoryPointToJson(HistoryPoint instance) =>
    <String, dynamic>{
      'lat': instance.lat,
      'lng': instance.lng,
      'speed': instance.speed,
      'recorded_at': instance.recordedAt.toIso8601String(),
    };
