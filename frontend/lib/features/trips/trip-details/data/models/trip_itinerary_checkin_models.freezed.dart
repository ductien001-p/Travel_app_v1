// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'trip_itinerary_checkin_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TripItineraryViewerCheckin {

 String? get activityId; String get placeId; DateTime get visitedAt;
/// Create a copy of TripItineraryViewerCheckin
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TripItineraryViewerCheckinCopyWith<TripItineraryViewerCheckin> get copyWith => _$TripItineraryViewerCheckinCopyWithImpl<TripItineraryViewerCheckin>(this as TripItineraryViewerCheckin, _$identity);

  /// Serializes this TripItineraryViewerCheckin to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TripItineraryViewerCheckin;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TripItineraryViewerCheckin&&(identical(other.activityId, _this.activityId) || other.activityId == _this.activityId)&&(identical(other.placeId, _this.placeId) || other.placeId == _this.placeId)&&(identical(other.visitedAt, _this.visitedAt) || other.visitedAt == _this.visitedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TripItineraryViewerCheckin;
  return Object.hash(runtimeType,_this.activityId,_this.placeId,_this.visitedAt);
}

@override
String toString() {
  final _this = this as TripItineraryViewerCheckin;
  return 'TripItineraryViewerCheckin(activityId: ${_this.activityId}, placeId: ${_this.placeId}, visitedAt: ${_this.visitedAt})';
}


}

/// @nodoc
abstract mixin class $TripItineraryViewerCheckinCopyWith<$Res>  {
  factory $TripItineraryViewerCheckinCopyWith(TripItineraryViewerCheckin value, $Res Function(TripItineraryViewerCheckin) _then) = _$TripItineraryViewerCheckinCopyWithImpl;
@useResult
$Res call({
 String? activityId, String placeId, DateTime visitedAt
});




}
/// @nodoc
class _$TripItineraryViewerCheckinCopyWithImpl<$Res>
    implements $TripItineraryViewerCheckinCopyWith<$Res> {
  _$TripItineraryViewerCheckinCopyWithImpl(this._self, this._then);

  final TripItineraryViewerCheckin _self;
  final $Res Function(TripItineraryViewerCheckin) _then;

/// Create a copy of TripItineraryViewerCheckin
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? activityId = freezed,Object? placeId = null,Object? visitedAt = null,}) {
  return _then(TripItineraryViewerCheckin(
activityId: freezed == activityId ? _self.activityId : activityId // ignore: cast_nullable_to_non_nullable
as String?,placeId: null == placeId ? _self.placeId : placeId // ignore: cast_nullable_to_non_nullable
as String,visitedAt: null == visitedAt ? _self.visitedAt : visitedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [TripItineraryViewerCheckin].
extension TripItineraryViewerCheckinPatterns on TripItineraryViewerCheckin {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TripItineraryViewerCheckin value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TripItineraryViewerCheckin() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TripItineraryViewerCheckin value)  $default,){
final _that = this;
switch (_that) {
case _TripItineraryViewerCheckin():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TripItineraryViewerCheckin value)?  $default,){
final _that = this;
switch (_that) {
case _TripItineraryViewerCheckin() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? activityId,  String placeId,  DateTime visitedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TripItineraryViewerCheckin() when $default != null:
return $default(_that.activityId,_that.placeId,_that.visitedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? activityId,  String placeId,  DateTime visitedAt)  $default,) {final _that = this;
switch (_that) {
case _TripItineraryViewerCheckin():
return $default(_that.activityId,_that.placeId,_that.visitedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? activityId,  String placeId,  DateTime visitedAt)?  $default,) {final _that = this;
switch (_that) {
case _TripItineraryViewerCheckin() when $default != null:
return $default(_that.activityId,_that.placeId,_that.visitedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TripItineraryViewerCheckin implements TripItineraryViewerCheckin {
  const _TripItineraryViewerCheckin({this.activityId, required this.placeId, required this.visitedAt});
  factory _TripItineraryViewerCheckin.fromJson(Map<String, dynamic> json) => _$TripItineraryViewerCheckinFromJson(json);

@override final  String? activityId;
@override final  String placeId;
@override final  DateTime visitedAt;

/// Create a copy of TripItineraryViewerCheckin
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TripItineraryViewerCheckinCopyWith<_TripItineraryViewerCheckin> get copyWith => __$TripItineraryViewerCheckinCopyWithImpl<_TripItineraryViewerCheckin>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TripItineraryViewerCheckinToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TripItineraryViewerCheckin&&(identical(other.activityId, activityId) || other.activityId == activityId)&&(identical(other.placeId, placeId) || other.placeId == placeId)&&(identical(other.visitedAt, visitedAt) || other.visitedAt == visitedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,activityId,placeId,visitedAt);
}

@override
String toString() {
    return 'TripItineraryViewerCheckin(activityId: $activityId, placeId: $placeId, visitedAt: $visitedAt)';
}


}

/// @nodoc
abstract mixin class _$TripItineraryViewerCheckinCopyWith<$Res> implements $TripItineraryViewerCheckinCopyWith<$Res> {
  factory _$TripItineraryViewerCheckinCopyWith(_TripItineraryViewerCheckin value, $Res Function(_TripItineraryViewerCheckin) _then) = __$TripItineraryViewerCheckinCopyWithImpl;
@override @useResult
$Res call({
 String? activityId, String placeId, DateTime visitedAt
});




}
/// @nodoc
class __$TripItineraryViewerCheckinCopyWithImpl<$Res>
    implements _$TripItineraryViewerCheckinCopyWith<$Res> {
  __$TripItineraryViewerCheckinCopyWithImpl(this._self, this._then);

  final _TripItineraryViewerCheckin _self;
  final $Res Function(_TripItineraryViewerCheckin) _then;

/// Create a copy of TripItineraryViewerCheckin
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? activityId = freezed,Object? placeId = null,Object? visitedAt = null,}) {
  return _then(_TripItineraryViewerCheckin(
activityId: freezed == activityId ? _self.activityId : activityId // ignore: cast_nullable_to_non_nullable
as String?,placeId: null == placeId ? _self.placeId : placeId // ignore: cast_nullable_to_non_nullable
as String,visitedAt: null == visitedAt ? _self.visitedAt : visitedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
