// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserProfile _$UserProfileFromJson(Map<String, dynamic> json) => _UserProfile(
  id: (json['id'] as num).toInt(),
  email: json['email'] as String,
  isAdmin: json['is_admin'] as bool? ?? false,
  routeId: (json['route_id'] as num?)?.toInt(),
  vehicleId: (json['vehicle_id'] as num?)?.toInt(),
  createdAt: DateTime.parse(json['created_at'] as String),
);

Map<String, dynamic> _$UserProfileToJson(_UserProfile instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'is_admin': instance.isAdmin,
      'route_id': instance.routeId,
      'vehicle_id': instance.vehicleId,
      'created_at': instance.createdAt.toIso8601String(),
    };
