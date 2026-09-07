// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vehicle_live.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$VehicleLive {

@JsonKey(name: 'vehicle_id') int get vehicleId;@JsonKey(name: 'vehicle_code') String get vehicleCode; double? get lat; double? get lng; double? get speed;@JsonKey(name: 'recorded_at') DateTime? get recordedAt; String get status;
/// Create a copy of VehicleLive
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VehicleLiveCopyWith<VehicleLive> get copyWith => _$VehicleLiveCopyWithImpl<VehicleLive>(this as VehicleLive, _$identity);

  /// Serializes this VehicleLive to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VehicleLive&&(identical(other.vehicleId, vehicleId) || other.vehicleId == vehicleId)&&(identical(other.vehicleCode, vehicleCode) || other.vehicleCode == vehicleCode)&&(identical(other.lat, lat) || other.lat == lat)&&(identical(other.lng, lng) || other.lng == lng)&&(identical(other.speed, speed) || other.speed == speed)&&(identical(other.recordedAt, recordedAt) || other.recordedAt == recordedAt)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,vehicleId,vehicleCode,lat,lng,speed,recordedAt,status);

@override
String toString() {
  return 'VehicleLive(vehicleId: $vehicleId, vehicleCode: $vehicleCode, lat: $lat, lng: $lng, speed: $speed, recordedAt: $recordedAt, status: $status)';
}


}

/// @nodoc
abstract mixin class $VehicleLiveCopyWith<$Res>  {
  factory $VehicleLiveCopyWith(VehicleLive value, $Res Function(VehicleLive) _then) = _$VehicleLiveCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'vehicle_id') int vehicleId,@JsonKey(name: 'vehicle_code') String vehicleCode, double? lat, double? lng, double? speed,@JsonKey(name: 'recorded_at') DateTime? recordedAt, String status
});




}
/// @nodoc
class _$VehicleLiveCopyWithImpl<$Res>
    implements $VehicleLiveCopyWith<$Res> {
  _$VehicleLiveCopyWithImpl(this._self, this._then);

  final VehicleLive _self;
  final $Res Function(VehicleLive) _then;

/// Create a copy of VehicleLive
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? vehicleId = null,Object? vehicleCode = null,Object? lat = freezed,Object? lng = freezed,Object? speed = freezed,Object? recordedAt = freezed,Object? status = null,}) {
  return _then(_self.copyWith(
vehicleId: null == vehicleId ? _self.vehicleId : vehicleId // ignore: cast_nullable_to_non_nullable
as int,vehicleCode: null == vehicleCode ? _self.vehicleCode : vehicleCode // ignore: cast_nullable_to_non_nullable
as String,lat: freezed == lat ? _self.lat : lat // ignore: cast_nullable_to_non_nullable
as double?,lng: freezed == lng ? _self.lng : lng // ignore: cast_nullable_to_non_nullable
as double?,speed: freezed == speed ? _self.speed : speed // ignore: cast_nullable_to_non_nullable
as double?,recordedAt: freezed == recordedAt ? _self.recordedAt : recordedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [VehicleLive].
extension VehicleLivePatterns on VehicleLive {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VehicleLive value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VehicleLive() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VehicleLive value)  $default,){
final _that = this;
switch (_that) {
case _VehicleLive():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VehicleLive value)?  $default,){
final _that = this;
switch (_that) {
case _VehicleLive() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'vehicle_id')  int vehicleId, @JsonKey(name: 'vehicle_code')  String vehicleCode,  double? lat,  double? lng,  double? speed, @JsonKey(name: 'recorded_at')  DateTime? recordedAt,  String status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VehicleLive() when $default != null:
return $default(_that.vehicleId,_that.vehicleCode,_that.lat,_that.lng,_that.speed,_that.recordedAt,_that.status);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'vehicle_id')  int vehicleId, @JsonKey(name: 'vehicle_code')  String vehicleCode,  double? lat,  double? lng,  double? speed, @JsonKey(name: 'recorded_at')  DateTime? recordedAt,  String status)  $default,) {final _that = this;
switch (_that) {
case _VehicleLive():
return $default(_that.vehicleId,_that.vehicleCode,_that.lat,_that.lng,_that.speed,_that.recordedAt,_that.status);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'vehicle_id')  int vehicleId, @JsonKey(name: 'vehicle_code')  String vehicleCode,  double? lat,  double? lng,  double? speed, @JsonKey(name: 'recorded_at')  DateTime? recordedAt,  String status)?  $default,) {final _that = this;
switch (_that) {
case _VehicleLive() when $default != null:
return $default(_that.vehicleId,_that.vehicleCode,_that.lat,_that.lng,_that.speed,_that.recordedAt,_that.status);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VehicleLive implements VehicleLive {
  const _VehicleLive({@JsonKey(name: 'vehicle_id') required this.vehicleId, @JsonKey(name: 'vehicle_code') required this.vehicleCode, this.lat, this.lng, this.speed, @JsonKey(name: 'recorded_at') this.recordedAt, this.status = 'offline'});
  factory _VehicleLive.fromJson(Map<String, dynamic> json) => _$VehicleLiveFromJson(json);

@override@JsonKey(name: 'vehicle_id') final  int vehicleId;
@override@JsonKey(name: 'vehicle_code') final  String vehicleCode;
@override final  double? lat;
@override final  double? lng;
@override final  double? speed;
@override@JsonKey(name: 'recorded_at') final  DateTime? recordedAt;
@override@JsonKey() final  String status;

/// Create a copy of VehicleLive
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VehicleLiveCopyWith<_VehicleLive> get copyWith => __$VehicleLiveCopyWithImpl<_VehicleLive>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VehicleLiveToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VehicleLive&&(identical(other.vehicleId, vehicleId) || other.vehicleId == vehicleId)&&(identical(other.vehicleCode, vehicleCode) || other.vehicleCode == vehicleCode)&&(identical(other.lat, lat) || other.lat == lat)&&(identical(other.lng, lng) || other.lng == lng)&&(identical(other.speed, speed) || other.speed == speed)&&(identical(other.recordedAt, recordedAt) || other.recordedAt == recordedAt)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,vehicleId,vehicleCode,lat,lng,speed,recordedAt,status);

@override
String toString() {
  return 'VehicleLive(vehicleId: $vehicleId, vehicleCode: $vehicleCode, lat: $lat, lng: $lng, speed: $speed, recordedAt: $recordedAt, status: $status)';
}


}

/// @nodoc
abstract mixin class _$VehicleLiveCopyWith<$Res> implements $VehicleLiveCopyWith<$Res> {
  factory _$VehicleLiveCopyWith(_VehicleLive value, $Res Function(_VehicleLive) _then) = __$VehicleLiveCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'vehicle_id') int vehicleId,@JsonKey(name: 'vehicle_code') String vehicleCode, double? lat, double? lng, double? speed,@JsonKey(name: 'recorded_at') DateTime? recordedAt, String status
});




}
/// @nodoc
class __$VehicleLiveCopyWithImpl<$Res>
    implements _$VehicleLiveCopyWith<$Res> {
  __$VehicleLiveCopyWithImpl(this._self, this._then);

  final _VehicleLive _self;
  final $Res Function(_VehicleLive) _then;

/// Create a copy of VehicleLive
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? vehicleId = null,Object? vehicleCode = null,Object? lat = freezed,Object? lng = freezed,Object? speed = freezed,Object? recordedAt = freezed,Object? status = null,}) {
  return _then(_VehicleLive(
vehicleId: null == vehicleId ? _self.vehicleId : vehicleId // ignore: cast_nullable_to_non_nullable
as int,vehicleCode: null == vehicleCode ? _self.vehicleCode : vehicleCode // ignore: cast_nullable_to_non_nullable
as String,lat: freezed == lat ? _self.lat : lat // ignore: cast_nullable_to_non_nullable
as double?,lng: freezed == lng ? _self.lng : lng // ignore: cast_nullable_to_non_nullable
as double?,speed: freezed == speed ? _self.speed : speed // ignore: cast_nullable_to_non_nullable
as double?,recordedAt: freezed == recordedAt ? _self.recordedAt : recordedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
