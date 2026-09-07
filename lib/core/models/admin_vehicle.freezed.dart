// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'admin_vehicle.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AdminVehicle {

 int get id; String get code; String get name;@JsonKey(name: 'is_active') bool get isActive;@JsonKey(name: 'created_at') DateTime get createdAt;@JsonKey(name: 'current_location') VehicleLive? get currentLocation;
/// Create a copy of AdminVehicle
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AdminVehicleCopyWith<AdminVehicle> get copyWith => _$AdminVehicleCopyWithImpl<AdminVehicle>(this as AdminVehicle, _$identity);

  /// Serializes this AdminVehicle to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AdminVehicle&&(identical(other.id, id) || other.id == id)&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.currentLocation, currentLocation) || other.currentLocation == currentLocation));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,code,name,isActive,createdAt,currentLocation);

@override
String toString() {
  return 'AdminVehicle(id: $id, code: $code, name: $name, isActive: $isActive, createdAt: $createdAt, currentLocation: $currentLocation)';
}


}

/// @nodoc
abstract mixin class $AdminVehicleCopyWith<$Res>  {
  factory $AdminVehicleCopyWith(AdminVehicle value, $Res Function(AdminVehicle) _then) = _$AdminVehicleCopyWithImpl;
@useResult
$Res call({
 int id, String code, String name,@JsonKey(name: 'is_active') bool isActive,@JsonKey(name: 'created_at') DateTime createdAt,@JsonKey(name: 'current_location') VehicleLive? currentLocation
});


$VehicleLiveCopyWith<$Res>? get currentLocation;

}
/// @nodoc
class _$AdminVehicleCopyWithImpl<$Res>
    implements $AdminVehicleCopyWith<$Res> {
  _$AdminVehicleCopyWithImpl(this._self, this._then);

  final AdminVehicle _self;
  final $Res Function(AdminVehicle) _then;

/// Create a copy of AdminVehicle
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? code = null,Object? name = null,Object? isActive = null,Object? createdAt = null,Object? currentLocation = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,currentLocation: freezed == currentLocation ? _self.currentLocation : currentLocation // ignore: cast_nullable_to_non_nullable
as VehicleLive?,
  ));
}
/// Create a copy of AdminVehicle
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$VehicleLiveCopyWith<$Res>? get currentLocation {
    if (_self.currentLocation == null) {
    return null;
  }

  return $VehicleLiveCopyWith<$Res>(_self.currentLocation!, (value) {
    return _then(_self.copyWith(currentLocation: value));
  });
}
}


/// Adds pattern-matching-related methods to [AdminVehicle].
extension AdminVehiclePatterns on AdminVehicle {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AdminVehicle value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AdminVehicle() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AdminVehicle value)  $default,){
final _that = this;
switch (_that) {
case _AdminVehicle():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AdminVehicle value)?  $default,){
final _that = this;
switch (_that) {
case _AdminVehicle() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String code,  String name, @JsonKey(name: 'is_active')  bool isActive, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'current_location')  VehicleLive? currentLocation)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AdminVehicle() when $default != null:
return $default(_that.id,_that.code,_that.name,_that.isActive,_that.createdAt,_that.currentLocation);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String code,  String name, @JsonKey(name: 'is_active')  bool isActive, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'current_location')  VehicleLive? currentLocation)  $default,) {final _that = this;
switch (_that) {
case _AdminVehicle():
return $default(_that.id,_that.code,_that.name,_that.isActive,_that.createdAt,_that.currentLocation);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String code,  String name, @JsonKey(name: 'is_active')  bool isActive, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'current_location')  VehicleLive? currentLocation)?  $default,) {final _that = this;
switch (_that) {
case _AdminVehicle() when $default != null:
return $default(_that.id,_that.code,_that.name,_that.isActive,_that.createdAt,_that.currentLocation);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AdminVehicle implements AdminVehicle {
  const _AdminVehicle({required this.id, required this.code, required this.name, @JsonKey(name: 'is_active') this.isActive = true, @JsonKey(name: 'created_at') required this.createdAt, @JsonKey(name: 'current_location') this.currentLocation});
  factory _AdminVehicle.fromJson(Map<String, dynamic> json) => _$AdminVehicleFromJson(json);

@override final  int id;
@override final  String code;
@override final  String name;
@override@JsonKey(name: 'is_active') final  bool isActive;
@override@JsonKey(name: 'created_at') final  DateTime createdAt;
@override@JsonKey(name: 'current_location') final  VehicleLive? currentLocation;

/// Create a copy of AdminVehicle
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AdminVehicleCopyWith<_AdminVehicle> get copyWith => __$AdminVehicleCopyWithImpl<_AdminVehicle>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AdminVehicleToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AdminVehicle&&(identical(other.id, id) || other.id == id)&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.currentLocation, currentLocation) || other.currentLocation == currentLocation));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,code,name,isActive,createdAt,currentLocation);

@override
String toString() {
  return 'AdminVehicle(id: $id, code: $code, name: $name, isActive: $isActive, createdAt: $createdAt, currentLocation: $currentLocation)';
}


}

/// @nodoc
abstract mixin class _$AdminVehicleCopyWith<$Res> implements $AdminVehicleCopyWith<$Res> {
  factory _$AdminVehicleCopyWith(_AdminVehicle value, $Res Function(_AdminVehicle) _then) = __$AdminVehicleCopyWithImpl;
@override @useResult
$Res call({
 int id, String code, String name,@JsonKey(name: 'is_active') bool isActive,@JsonKey(name: 'created_at') DateTime createdAt,@JsonKey(name: 'current_location') VehicleLive? currentLocation
});


@override $VehicleLiveCopyWith<$Res>? get currentLocation;

}
/// @nodoc
class __$AdminVehicleCopyWithImpl<$Res>
    implements _$AdminVehicleCopyWith<$Res> {
  __$AdminVehicleCopyWithImpl(this._self, this._then);

  final _AdminVehicle _self;
  final $Res Function(_AdminVehicle) _then;

/// Create a copy of AdminVehicle
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? code = null,Object? name = null,Object? isActive = null,Object? createdAt = null,Object? currentLocation = freezed,}) {
  return _then(_AdminVehicle(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,currentLocation: freezed == currentLocation ? _self.currentLocation : currentLocation // ignore: cast_nullable_to_non_nullable
as VehicleLive?,
  ));
}

/// Create a copy of AdminVehicle
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$VehicleLiveCopyWith<$Res>? get currentLocation {
    if (_self.currentLocation == null) {
    return null;
  }

  return $VehicleLiveCopyWith<$Res>(_self.currentLocation!, (value) {
    return _then(_self.copyWith(currentLocation: value));
  });
}
}

// dart format on
