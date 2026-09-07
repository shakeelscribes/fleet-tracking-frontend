// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assignment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Assignment _$AssignmentFromJson(Map<String, dynamic> json) => _Assignment(
  route: json['route'] == null
      ? null
      : RouteSummary.fromJson(json['route'] as Map<String, dynamic>),
  vehicle: json['vehicle'] == null
      ? null
      : VehicleSummary.fromJson(json['vehicle'] as Map<String, dynamic>),
);

Map<String, dynamic> _$AssignmentToJson(_Assignment instance) =>
    <String, dynamic>{'route': instance.route, 'vehicle': instance.vehicle};

_RouteSummary _$RouteSummaryFromJson(Map<String, dynamic> json) =>
    _RouteSummary(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
    );

Map<String, dynamic> _$RouteSummaryToJson(_RouteSummary instance) =>
    <String, dynamic>{'id': instance.id, 'name': instance.name};

_VehicleSummary _$VehicleSummaryFromJson(Map<String, dynamic> json) =>
    _VehicleSummary(
      id: (json['id'] as num).toInt(),
      code: json['code'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$VehicleSummaryToJson(_VehicleSummary instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'name': instance.name,
    };
