// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'trip_itinerary_route_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TripRouteLeg {

 String get fromActivityId; String get toActivityId; bool get available; int? get distanceMeters; int? get durationSeconds;/// Google encoded polyline; null when unavailable or for a repeated place.
 String? get polyline;@JsonKey(unknownEnumValue: TripRouteUnavailableReason.unknown) TripRouteUnavailableReason? get unavailableReason;
/// Create a copy of TripRouteLeg
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TripRouteLegCopyWith<TripRouteLeg> get copyWith => _$TripRouteLegCopyWithImpl<TripRouteLeg>(this as TripRouteLeg, _$identity);

  /// Serializes this TripRouteLeg to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TripRouteLeg;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TripRouteLeg&&(identical(other.fromActivityId, _this.fromActivityId) || other.fromActivityId == _this.fromActivityId)&&(identical(other.toActivityId, _this.toActivityId) || other.toActivityId == _this.toActivityId)&&(identical(other.available, _this.available) || other.available == _this.available)&&(identical(other.distanceMeters, _this.distanceMeters) || other.distanceMeters == _this.distanceMeters)&&(identical(other.durationSeconds, _this.durationSeconds) || other.durationSeconds == _this.durationSeconds)&&(identical(other.polyline, _this.polyline) || other.polyline == _this.polyline)&&(identical(other.unavailableReason, _this.unavailableReason) || other.unavailableReason == _this.unavailableReason));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TripRouteLeg;
  return Object.hash(runtimeType,_this.fromActivityId,_this.toActivityId,_this.available,_this.distanceMeters,_this.durationSeconds,_this.polyline,_this.unavailableReason);
}

@override
String toString() {
  final _this = this as TripRouteLeg;
  return 'TripRouteLeg(fromActivityId: ${_this.fromActivityId}, toActivityId: ${_this.toActivityId}, available: ${_this.available}, distanceMeters: ${_this.distanceMeters}, durationSeconds: ${_this.durationSeconds}, polyline: ${_this.polyline}, unavailableReason: ${_this.unavailableReason})';
}


}

/// @nodoc
abstract mixin class $TripRouteLegCopyWith<$Res>  {
  factory $TripRouteLegCopyWith(TripRouteLeg value, $Res Function(TripRouteLeg) _then) = _$TripRouteLegCopyWithImpl;
@useResult
$Res call({
 String fromActivityId, String toActivityId, bool available, int? distanceMeters, int? durationSeconds, String? polyline,@JsonKey(unknownEnumValue: TripRouteUnavailableReason.unknown) TripRouteUnavailableReason? unavailableReason
});




}
/// @nodoc
class _$TripRouteLegCopyWithImpl<$Res>
    implements $TripRouteLegCopyWith<$Res> {
  _$TripRouteLegCopyWithImpl(this._self, this._then);

  final TripRouteLeg _self;
  final $Res Function(TripRouteLeg) _then;

/// Create a copy of TripRouteLeg
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? fromActivityId = null,Object? toActivityId = null,Object? available = null,Object? distanceMeters = freezed,Object? durationSeconds = freezed,Object? polyline = freezed,Object? unavailableReason = freezed,}) {
  return _then(TripRouteLeg(
fromActivityId: null == fromActivityId ? _self.fromActivityId : fromActivityId // ignore: cast_nullable_to_non_nullable
as String,toActivityId: null == toActivityId ? _self.toActivityId : toActivityId // ignore: cast_nullable_to_non_nullable
as String,available: null == available ? _self.available : available // ignore: cast_nullable_to_non_nullable
as bool,distanceMeters: freezed == distanceMeters ? _self.distanceMeters : distanceMeters // ignore: cast_nullable_to_non_nullable
as int?,durationSeconds: freezed == durationSeconds ? _self.durationSeconds : durationSeconds // ignore: cast_nullable_to_non_nullable
as int?,polyline: freezed == polyline ? _self.polyline : polyline // ignore: cast_nullable_to_non_nullable
as String?,unavailableReason: freezed == unavailableReason ? _self.unavailableReason : unavailableReason // ignore: cast_nullable_to_non_nullable
as TripRouteUnavailableReason?,
  ));
}

}


/// Adds pattern-matching-related methods to [TripRouteLeg].
extension TripRouteLegPatterns on TripRouteLeg {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TripRouteLeg value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TripRouteLeg() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TripRouteLeg value)  $default,){
final _that = this;
switch (_that) {
case _TripRouteLeg():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TripRouteLeg value)?  $default,){
final _that = this;
switch (_that) {
case _TripRouteLeg() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String fromActivityId,  String toActivityId,  bool available,  int? distanceMeters,  int? durationSeconds,  String? polyline, @JsonKey(unknownEnumValue: TripRouteUnavailableReason.unknown)  TripRouteUnavailableReason? unavailableReason)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TripRouteLeg() when $default != null:
return $default(_that.fromActivityId,_that.toActivityId,_that.available,_that.distanceMeters,_that.durationSeconds,_that.polyline,_that.unavailableReason);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String fromActivityId,  String toActivityId,  bool available,  int? distanceMeters,  int? durationSeconds,  String? polyline, @JsonKey(unknownEnumValue: TripRouteUnavailableReason.unknown)  TripRouteUnavailableReason? unavailableReason)  $default,) {final _that = this;
switch (_that) {
case _TripRouteLeg():
return $default(_that.fromActivityId,_that.toActivityId,_that.available,_that.distanceMeters,_that.durationSeconds,_that.polyline,_that.unavailableReason);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String fromActivityId,  String toActivityId,  bool available,  int? distanceMeters,  int? durationSeconds,  String? polyline, @JsonKey(unknownEnumValue: TripRouteUnavailableReason.unknown)  TripRouteUnavailableReason? unavailableReason)?  $default,) {final _that = this;
switch (_that) {
case _TripRouteLeg() when $default != null:
return $default(_that.fromActivityId,_that.toActivityId,_that.available,_that.distanceMeters,_that.durationSeconds,_that.polyline,_that.unavailableReason);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TripRouteLeg implements TripRouteLeg {
  const _TripRouteLeg({required this.fromActivityId, required this.toActivityId, required this.available, this.distanceMeters, this.durationSeconds, this.polyline, @JsonKey(unknownEnumValue: TripRouteUnavailableReason.unknown) this.unavailableReason});
  factory _TripRouteLeg.fromJson(Map<String, dynamic> json) => _$TripRouteLegFromJson(json);

@override final  String fromActivityId;
@override final  String toActivityId;
@override final  bool available;
@override final  int? distanceMeters;
@override final  int? durationSeconds;
/// Google encoded polyline; null when unavailable or for a repeated place.
@override final  String? polyline;
@override@JsonKey(unknownEnumValue: TripRouteUnavailableReason.unknown) final  TripRouteUnavailableReason? unavailableReason;

/// Create a copy of TripRouteLeg
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TripRouteLegCopyWith<_TripRouteLeg> get copyWith => __$TripRouteLegCopyWithImpl<_TripRouteLeg>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TripRouteLegToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TripRouteLeg&&(identical(other.fromActivityId, fromActivityId) || other.fromActivityId == fromActivityId)&&(identical(other.toActivityId, toActivityId) || other.toActivityId == toActivityId)&&(identical(other.available, available) || other.available == available)&&(identical(other.distanceMeters, distanceMeters) || other.distanceMeters == distanceMeters)&&(identical(other.durationSeconds, durationSeconds) || other.durationSeconds == durationSeconds)&&(identical(other.polyline, polyline) || other.polyline == polyline)&&(identical(other.unavailableReason, unavailableReason) || other.unavailableReason == unavailableReason));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,fromActivityId,toActivityId,available,distanceMeters,durationSeconds,polyline,unavailableReason);
}

@override
String toString() {
    return 'TripRouteLeg(fromActivityId: $fromActivityId, toActivityId: $toActivityId, available: $available, distanceMeters: $distanceMeters, durationSeconds: $durationSeconds, polyline: $polyline, unavailableReason: $unavailableReason)';
}


}

/// @nodoc
abstract mixin class _$TripRouteLegCopyWith<$Res> implements $TripRouteLegCopyWith<$Res> {
  factory _$TripRouteLegCopyWith(_TripRouteLeg value, $Res Function(_TripRouteLeg) _then) = __$TripRouteLegCopyWithImpl;
@override @useResult
$Res call({
 String fromActivityId, String toActivityId, bool available, int? distanceMeters, int? durationSeconds, String? polyline,@JsonKey(unknownEnumValue: TripRouteUnavailableReason.unknown) TripRouteUnavailableReason? unavailableReason
});




}
/// @nodoc
class __$TripRouteLegCopyWithImpl<$Res>
    implements _$TripRouteLegCopyWith<$Res> {
  __$TripRouteLegCopyWithImpl(this._self, this._then);

  final _TripRouteLeg _self;
  final $Res Function(_TripRouteLeg) _then;

/// Create a copy of TripRouteLeg
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? fromActivityId = null,Object? toActivityId = null,Object? available = null,Object? distanceMeters = freezed,Object? durationSeconds = freezed,Object? polyline = freezed,Object? unavailableReason = freezed,}) {
  return _then(_TripRouteLeg(
fromActivityId: null == fromActivityId ? _self.fromActivityId : fromActivityId // ignore: cast_nullable_to_non_nullable
as String,toActivityId: null == toActivityId ? _self.toActivityId : toActivityId // ignore: cast_nullable_to_non_nullable
as String,available: null == available ? _self.available : available // ignore: cast_nullable_to_non_nullable
as bool,distanceMeters: freezed == distanceMeters ? _self.distanceMeters : distanceMeters // ignore: cast_nullable_to_non_nullable
as int?,durationSeconds: freezed == durationSeconds ? _self.durationSeconds : durationSeconds // ignore: cast_nullable_to_non_nullable
as int?,polyline: freezed == polyline ? _self.polyline : polyline // ignore: cast_nullable_to_non_nullable
as String?,unavailableReason: freezed == unavailableReason ? _self.unavailableReason : unavailableReason // ignore: cast_nullable_to_non_nullable
as TripRouteUnavailableReason?,
  ));
}


}


/// @nodoc
mixin _$TripDayRoute {

 String get dayId; bool get available; int get totalDistanceMeters; int get totalDurationSeconds; List<TripRouteLeg> get legs;
/// Create a copy of TripDayRoute
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TripDayRouteCopyWith<TripDayRoute> get copyWith => _$TripDayRouteCopyWithImpl<TripDayRoute>(this as TripDayRoute, _$identity);

  /// Serializes this TripDayRoute to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TripDayRoute;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TripDayRoute&&(identical(other.dayId, _this.dayId) || other.dayId == _this.dayId)&&(identical(other.available, _this.available) || other.available == _this.available)&&(identical(other.totalDistanceMeters, _this.totalDistanceMeters) || other.totalDistanceMeters == _this.totalDistanceMeters)&&(identical(other.totalDurationSeconds, _this.totalDurationSeconds) || other.totalDurationSeconds == _this.totalDurationSeconds)&&const DeepCollectionEquality().equals(other.legs, _this.legs));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TripDayRoute;
  return Object.hash(runtimeType,_this.dayId,_this.available,_this.totalDistanceMeters,_this.totalDurationSeconds,const DeepCollectionEquality().hash(_this.legs));
}

@override
String toString() {
  final _this = this as TripDayRoute;
  return 'TripDayRoute(dayId: ${_this.dayId}, available: ${_this.available}, totalDistanceMeters: ${_this.totalDistanceMeters}, totalDurationSeconds: ${_this.totalDurationSeconds}, legs: ${_this.legs})';
}


}

/// @nodoc
abstract mixin class $TripDayRouteCopyWith<$Res>  {
  factory $TripDayRouteCopyWith(TripDayRoute value, $Res Function(TripDayRoute) _then) = _$TripDayRouteCopyWithImpl;
@useResult
$Res call({
 String dayId, bool available, int totalDistanceMeters, int totalDurationSeconds, List<TripRouteLeg> legs
});




}
/// @nodoc
class _$TripDayRouteCopyWithImpl<$Res>
    implements $TripDayRouteCopyWith<$Res> {
  _$TripDayRouteCopyWithImpl(this._self, this._then);

  final TripDayRoute _self;
  final $Res Function(TripDayRoute) _then;

/// Create a copy of TripDayRoute
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? dayId = null,Object? available = null,Object? totalDistanceMeters = null,Object? totalDurationSeconds = null,Object? legs = null,}) {
  return _then(TripDayRoute(
dayId: null == dayId ? _self.dayId : dayId // ignore: cast_nullable_to_non_nullable
as String,available: null == available ? _self.available : available // ignore: cast_nullable_to_non_nullable
as bool,totalDistanceMeters: null == totalDistanceMeters ? _self.totalDistanceMeters : totalDistanceMeters // ignore: cast_nullable_to_non_nullable
as int,totalDurationSeconds: null == totalDurationSeconds ? _self.totalDurationSeconds : totalDurationSeconds // ignore: cast_nullable_to_non_nullable
as int,legs: null == legs ? _self.legs : legs // ignore: cast_nullable_to_non_nullable
as List<TripRouteLeg>,
  ));
}

}


/// Adds pattern-matching-related methods to [TripDayRoute].
extension TripDayRoutePatterns on TripDayRoute {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TripDayRoute value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TripDayRoute() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TripDayRoute value)  $default,){
final _that = this;
switch (_that) {
case _TripDayRoute():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TripDayRoute value)?  $default,){
final _that = this;
switch (_that) {
case _TripDayRoute() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String dayId,  bool available,  int totalDistanceMeters,  int totalDurationSeconds,  List<TripRouteLeg> legs)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TripDayRoute() when $default != null:
return $default(_that.dayId,_that.available,_that.totalDistanceMeters,_that.totalDurationSeconds,_that.legs);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String dayId,  bool available,  int totalDistanceMeters,  int totalDurationSeconds,  List<TripRouteLeg> legs)  $default,) {final _that = this;
switch (_that) {
case _TripDayRoute():
return $default(_that.dayId,_that.available,_that.totalDistanceMeters,_that.totalDurationSeconds,_that.legs);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String dayId,  bool available,  int totalDistanceMeters,  int totalDurationSeconds,  List<TripRouteLeg> legs)?  $default,) {final _that = this;
switch (_that) {
case _TripDayRoute() when $default != null:
return $default(_that.dayId,_that.available,_that.totalDistanceMeters,_that.totalDurationSeconds,_that.legs);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TripDayRoute implements TripDayRoute {
  const _TripDayRoute({required this.dayId, required this.available, required this.totalDistanceMeters, required this.totalDurationSeconds, required  List<TripRouteLeg> legs}): _legs = legs;
  factory _TripDayRoute.fromJson(Map<String, dynamic> json) => _$TripDayRouteFromJson(json);

@override final  String dayId;
@override final  bool available;
@override final  int totalDistanceMeters;
@override final  int totalDurationSeconds;
 final  List<TripRouteLeg> _legs;
@override List<TripRouteLeg> get legs {
  if (_legs is EqualUnmodifiableListView) return _legs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_legs);
}


/// Create a copy of TripDayRoute
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TripDayRouteCopyWith<_TripDayRoute> get copyWith => __$TripDayRouteCopyWithImpl<_TripDayRoute>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TripDayRouteToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TripDayRoute&&(identical(other.dayId, dayId) || other.dayId == dayId)&&(identical(other.available, available) || other.available == available)&&(identical(other.totalDistanceMeters, totalDistanceMeters) || other.totalDistanceMeters == totalDistanceMeters)&&(identical(other.totalDurationSeconds, totalDurationSeconds) || other.totalDurationSeconds == totalDurationSeconds)&&const DeepCollectionEquality().equals(other.legs, _legs));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,dayId,available,totalDistanceMeters,totalDurationSeconds,const DeepCollectionEquality().hash(_legs));
}

@override
String toString() {
    return 'TripDayRoute(dayId: $dayId, available: $available, totalDistanceMeters: $totalDistanceMeters, totalDurationSeconds: $totalDurationSeconds, legs: $legs)';
}


}

/// @nodoc
abstract mixin class _$TripDayRouteCopyWith<$Res> implements $TripDayRouteCopyWith<$Res> {
  factory _$TripDayRouteCopyWith(_TripDayRoute value, $Res Function(_TripDayRoute) _then) = __$TripDayRouteCopyWithImpl;
@override @useResult
$Res call({
 String dayId, bool available, int totalDistanceMeters, int totalDurationSeconds, List<TripRouteLeg> legs
});




}
/// @nodoc
class __$TripDayRouteCopyWithImpl<$Res>
    implements _$TripDayRouteCopyWith<$Res> {
  __$TripDayRouteCopyWithImpl(this._self, this._then);

  final _TripDayRoute _self;
  final $Res Function(_TripDayRoute) _then;

/// Create a copy of TripDayRoute
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? dayId = null,Object? available = null,Object? totalDistanceMeters = null,Object? totalDurationSeconds = null,Object? legs = null,}) {
  return _then(_TripDayRoute(
dayId: null == dayId ? _self.dayId : dayId // ignore: cast_nullable_to_non_nullable
as String,available: null == available ? _self.available : available // ignore: cast_nullable_to_non_nullable
as bool,totalDistanceMeters: null == totalDistanceMeters ? _self.totalDistanceMeters : totalDistanceMeters // ignore: cast_nullable_to_non_nullable
as int,totalDurationSeconds: null == totalDurationSeconds ? _self.totalDurationSeconds : totalDurationSeconds // ignore: cast_nullable_to_non_nullable
as int,legs: null == legs ? _self._legs : legs // ignore: cast_nullable_to_non_nullable
as List<TripRouteLeg>,
  ));
}


}

// dart format on
