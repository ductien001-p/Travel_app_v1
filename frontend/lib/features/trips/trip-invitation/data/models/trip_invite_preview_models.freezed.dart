// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'trip_invite_preview_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TripJoinInvitePreview {

 String? get inviteCode; String get tripId; String get name; String? get coverImageUrl; DateTime get startDate; DateTime get endDate; String get ownerDisplayName; int get memberCount; int get maxMembers;/// 0..100; null when either side has nothing to compare.
 int? get matchScore;
/// Create a copy of TripJoinInvitePreview
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TripJoinInvitePreviewCopyWith<TripJoinInvitePreview> get copyWith => _$TripJoinInvitePreviewCopyWithImpl<TripJoinInvitePreview>(this as TripJoinInvitePreview, _$identity);

  /// Serializes this TripJoinInvitePreview to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TripJoinInvitePreview;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TripJoinInvitePreview&&(identical(other.inviteCode, _this.inviteCode) || other.inviteCode == _this.inviteCode)&&(identical(other.tripId, _this.tripId) || other.tripId == _this.tripId)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.coverImageUrl, _this.coverImageUrl) || other.coverImageUrl == _this.coverImageUrl)&&(identical(other.startDate, _this.startDate) || other.startDate == _this.startDate)&&(identical(other.endDate, _this.endDate) || other.endDate == _this.endDate)&&(identical(other.ownerDisplayName, _this.ownerDisplayName) || other.ownerDisplayName == _this.ownerDisplayName)&&(identical(other.memberCount, _this.memberCount) || other.memberCount == _this.memberCount)&&(identical(other.maxMembers, _this.maxMembers) || other.maxMembers == _this.maxMembers)&&(identical(other.matchScore, _this.matchScore) || other.matchScore == _this.matchScore));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TripJoinInvitePreview;
  return Object.hash(runtimeType,_this.inviteCode,_this.tripId,_this.name,_this.coverImageUrl,_this.startDate,_this.endDate,_this.ownerDisplayName,_this.memberCount,_this.maxMembers,_this.matchScore);
}

@override
String toString() {
  final _this = this as TripJoinInvitePreview;
  return 'TripJoinInvitePreview(inviteCode: ${_this.inviteCode}, tripId: ${_this.tripId}, name: ${_this.name}, coverImageUrl: ${_this.coverImageUrl}, startDate: ${_this.startDate}, endDate: ${_this.endDate}, ownerDisplayName: ${_this.ownerDisplayName}, memberCount: ${_this.memberCount}, maxMembers: ${_this.maxMembers}, matchScore: ${_this.matchScore})';
}


}

/// @nodoc
abstract mixin class $TripJoinInvitePreviewCopyWith<$Res>  {
  factory $TripJoinInvitePreviewCopyWith(TripJoinInvitePreview value, $Res Function(TripJoinInvitePreview) _then) = _$TripJoinInvitePreviewCopyWithImpl;
@useResult
$Res call({
 String? inviteCode, String tripId, String name, String? coverImageUrl, DateTime startDate, DateTime endDate, String ownerDisplayName, int memberCount, int maxMembers, int? matchScore
});




}
/// @nodoc
class _$TripJoinInvitePreviewCopyWithImpl<$Res>
    implements $TripJoinInvitePreviewCopyWith<$Res> {
  _$TripJoinInvitePreviewCopyWithImpl(this._self, this._then);

  final TripJoinInvitePreview _self;
  final $Res Function(TripJoinInvitePreview) _then;

/// Create a copy of TripJoinInvitePreview
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? inviteCode = freezed,Object? tripId = null,Object? name = null,Object? coverImageUrl = freezed,Object? startDate = null,Object? endDate = null,Object? ownerDisplayName = null,Object? memberCount = null,Object? maxMembers = null,Object? matchScore = freezed,}) {
  return _then(TripJoinInvitePreview(
inviteCode: freezed == inviteCode ? _self.inviteCode : inviteCode // ignore: cast_nullable_to_non_nullable
as String?,tripId: null == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,coverImageUrl: freezed == coverImageUrl ? _self.coverImageUrl : coverImageUrl // ignore: cast_nullable_to_non_nullable
as String?,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,endDate: null == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime,ownerDisplayName: null == ownerDisplayName ? _self.ownerDisplayName : ownerDisplayName // ignore: cast_nullable_to_non_nullable
as String,memberCount: null == memberCount ? _self.memberCount : memberCount // ignore: cast_nullable_to_non_nullable
as int,maxMembers: null == maxMembers ? _self.maxMembers : maxMembers // ignore: cast_nullable_to_non_nullable
as int,matchScore: freezed == matchScore ? _self.matchScore : matchScore // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [TripJoinInvitePreview].
extension TripJoinInvitePreviewPatterns on TripJoinInvitePreview {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TripJoinInvitePreview value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TripJoinInvitePreview() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TripJoinInvitePreview value)  $default,){
final _that = this;
switch (_that) {
case _TripJoinInvitePreview():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TripJoinInvitePreview value)?  $default,){
final _that = this;
switch (_that) {
case _TripJoinInvitePreview() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? inviteCode,  String tripId,  String name,  String? coverImageUrl,  DateTime startDate,  DateTime endDate,  String ownerDisplayName,  int memberCount,  int maxMembers,  int? matchScore)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TripJoinInvitePreview() when $default != null:
return $default(_that.inviteCode,_that.tripId,_that.name,_that.coverImageUrl,_that.startDate,_that.endDate,_that.ownerDisplayName,_that.memberCount,_that.maxMembers,_that.matchScore);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? inviteCode,  String tripId,  String name,  String? coverImageUrl,  DateTime startDate,  DateTime endDate,  String ownerDisplayName,  int memberCount,  int maxMembers,  int? matchScore)  $default,) {final _that = this;
switch (_that) {
case _TripJoinInvitePreview():
return $default(_that.inviteCode,_that.tripId,_that.name,_that.coverImageUrl,_that.startDate,_that.endDate,_that.ownerDisplayName,_that.memberCount,_that.maxMembers,_that.matchScore);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? inviteCode,  String tripId,  String name,  String? coverImageUrl,  DateTime startDate,  DateTime endDate,  String ownerDisplayName,  int memberCount,  int maxMembers,  int? matchScore)?  $default,) {final _that = this;
switch (_that) {
case _TripJoinInvitePreview() when $default != null:
return $default(_that.inviteCode,_that.tripId,_that.name,_that.coverImageUrl,_that.startDate,_that.endDate,_that.ownerDisplayName,_that.memberCount,_that.maxMembers,_that.matchScore);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TripJoinInvitePreview implements TripJoinInvitePreview {
  const _TripJoinInvitePreview({this.inviteCode, required this.tripId, required this.name, this.coverImageUrl, required this.startDate, required this.endDate, required this.ownerDisplayName, required this.memberCount, required this.maxMembers, this.matchScore});
  factory _TripJoinInvitePreview.fromJson(Map<String, dynamic> json) => _$TripJoinInvitePreviewFromJson(json);

@override final  String? inviteCode;
@override final  String tripId;
@override final  String name;
@override final  String? coverImageUrl;
@override final  DateTime startDate;
@override final  DateTime endDate;
@override final  String ownerDisplayName;
@override final  int memberCount;
@override final  int maxMembers;
/// 0..100; null when either side has nothing to compare.
@override final  int? matchScore;

/// Create a copy of TripJoinInvitePreview
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TripJoinInvitePreviewCopyWith<_TripJoinInvitePreview> get copyWith => __$TripJoinInvitePreviewCopyWithImpl<_TripJoinInvitePreview>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TripJoinInvitePreviewToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TripJoinInvitePreview&&(identical(other.inviteCode, inviteCode) || other.inviteCode == inviteCode)&&(identical(other.tripId, tripId) || other.tripId == tripId)&&(identical(other.name, name) || other.name == name)&&(identical(other.coverImageUrl, coverImageUrl) || other.coverImageUrl == coverImageUrl)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.ownerDisplayName, ownerDisplayName) || other.ownerDisplayName == ownerDisplayName)&&(identical(other.memberCount, memberCount) || other.memberCount == memberCount)&&(identical(other.maxMembers, maxMembers) || other.maxMembers == maxMembers)&&(identical(other.matchScore, matchScore) || other.matchScore == matchScore));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,inviteCode,tripId,name,coverImageUrl,startDate,endDate,ownerDisplayName,memberCount,maxMembers,matchScore);
}

@override
String toString() {
    return 'TripJoinInvitePreview(inviteCode: $inviteCode, tripId: $tripId, name: $name, coverImageUrl: $coverImageUrl, startDate: $startDate, endDate: $endDate, ownerDisplayName: $ownerDisplayName, memberCount: $memberCount, maxMembers: $maxMembers, matchScore: $matchScore)';
}


}

/// @nodoc
abstract mixin class _$TripJoinInvitePreviewCopyWith<$Res> implements $TripJoinInvitePreviewCopyWith<$Res> {
  factory _$TripJoinInvitePreviewCopyWith(_TripJoinInvitePreview value, $Res Function(_TripJoinInvitePreview) _then) = __$TripJoinInvitePreviewCopyWithImpl;
@override @useResult
$Res call({
 String? inviteCode, String tripId, String name, String? coverImageUrl, DateTime startDate, DateTime endDate, String ownerDisplayName, int memberCount, int maxMembers, int? matchScore
});




}
/// @nodoc
class __$TripJoinInvitePreviewCopyWithImpl<$Res>
    implements _$TripJoinInvitePreviewCopyWith<$Res> {
  __$TripJoinInvitePreviewCopyWithImpl(this._self, this._then);

  final _TripJoinInvitePreview _self;
  final $Res Function(_TripJoinInvitePreview) _then;

/// Create a copy of TripJoinInvitePreview
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? inviteCode = freezed,Object? tripId = null,Object? name = null,Object? coverImageUrl = freezed,Object? startDate = null,Object? endDate = null,Object? ownerDisplayName = null,Object? memberCount = null,Object? maxMembers = null,Object? matchScore = freezed,}) {
  return _then(_TripJoinInvitePreview(
inviteCode: freezed == inviteCode ? _self.inviteCode : inviteCode // ignore: cast_nullable_to_non_nullable
as String?,tripId: null == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,coverImageUrl: freezed == coverImageUrl ? _self.coverImageUrl : coverImageUrl // ignore: cast_nullable_to_non_nullable
as String?,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,endDate: null == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime,ownerDisplayName: null == ownerDisplayName ? _self.ownerDisplayName : ownerDisplayName // ignore: cast_nullable_to_non_nullable
as String,memberCount: null == memberCount ? _self.memberCount : memberCount // ignore: cast_nullable_to_non_nullable
as int,maxMembers: null == maxMembers ? _self.maxMembers : maxMembers // ignore: cast_nullable_to_non_nullable
as int,matchScore: freezed == matchScore ? _self.matchScore : matchScore // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
