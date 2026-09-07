// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle_live.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_VehicleLive _$VehicleLiveFromJson(Map<String, dynamic> json) => _VehicleLive(
  vehicleId: (json['vehicle_id'] as num).toInt(),
  vehicleCode: json['vehicle_code'] as String,
  lat: (json['lat'] as num?)?.toDouble(),
  lng: (json['lng'] as num?)?.toDouble(),
  speed: (json['speed'] as num?)?.toDouble(),
  recordedAt: json['recorded_at'] == null
      ? null
      : DateTime.parse(json['recorded_at'] as String),
  status: json['status'] as String? ?? 'offline',
);

Map<String, dynamic> _$VehicleLiveToJson(_VehicleLive instance) =>
    <String, dynamic>{
      'vehicle_id': instance.vehicleId,
      'vehicle_code': instance.vehicleCode,
      'lat': instance.lat,
      'lng': instance.lng,
      'speed': instance.speed,
      'recorded_at': instance.recordedAt?.toIso8601String(),
      'status': instance.status,
    };
