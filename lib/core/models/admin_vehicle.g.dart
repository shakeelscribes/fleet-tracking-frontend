// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_vehicle.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AdminVehicle _$AdminVehicleFromJson(Map<String, dynamic> json) =>
    _AdminVehicle(
      id: (json['id'] as num).toInt(),
      code: json['code'] as String,
      name: json['name'] as String,
      isActive: json['is_active'] as bool? ?? true,
      createdAt: DateTime.parse(json['created_at'] as String),
      currentLocation: json['current_location'] == null
          ? null
          : VehicleLive.fromJson(
              json['current_location'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$AdminVehicleToJson(_AdminVehicle instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'name': instance.name,
      'is_active': instance.isActive,
      'created_at': instance.createdAt.toIso8601String(),
      'current_location': instance.currentLocation,
    };
