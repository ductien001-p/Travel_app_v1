// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'trip_invite_friends_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TripInviteFriend {

 String get id; String get username;@JsonKey(name: 'displayname') String get displayName; String? get avatarId;
/// Create a copy of TripInviteFriend
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TripInviteFriendCopyWith<TripInviteFriend> get copyWith => _$TripInviteFriendCopyWithImpl<TripInviteFriend>(this as TripInviteFriend, _$identity);

  /// Serializes this TripInviteFriend to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TripInviteFriend;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TripInviteFriend&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.username, _this.username) || other.username == _this.username)&&(identical(other.displayName, _this.displayName) || other.displayName == _this.displayName)&&(identical(other.avatarId, _this.avatarId) || other.avatarId == _this.avatarId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TripInviteFriend;
  return Object.hash(runtimeType,_this.id,_this.username,_this.displayName,_this.avatarId);
}

@override
String toString() {
  final _this = this as TripInviteFriend;
  return 'TripInviteFriend(id: ${_this.id}, username: ${_this.username}, displayName: ${_this.displayName}, avatarId: ${_this.avatarId})';
}


}

/// @nodoc
abstract mixin class $TripInviteFriendCopyWith<$Res>  {
  factory $TripInviteFriendCopyWith(TripInviteFriend value, $Res Function(TripInviteFriend) _then) = _$TripInviteFriendCopyWithImpl;
@useResult
$Res call({
 String id, String username,@JsonKey(name: 'displayname') String displayName, String? avatarId
});




}
/// @nodoc
class _$TripInviteFriendCopyWithImpl<$Res>
    implements $TripInviteFriendCopyWith<$Res> {
  _$TripInviteFriendCopyWithImpl(this._self, this._then);

  final TripInviteFriend _self;
  final $Res Function(TripInviteFriend) _then;

/// Create a copy of TripInviteFriend
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? username = null,Object? displayName = null,Object? avatarId = freezed,}) {
  return _then(TripInviteFriend(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,avatarId: freezed == avatarId ? _self.avatarId : avatarId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TripInviteFriend].
extension TripInviteFriendPatterns on TripInviteFriend {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TripInviteFriend value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TripInviteFriend() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TripInviteFriend value)  $default,){
final _that = this;
switch (_that) {
case _TripInviteFriend():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TripInviteFriend value)?  $default,){
final _that = this;
switch (_that) {
case _TripInviteFriend() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String username, @JsonKey(name: 'displayname')  String displayName,  String? avatarId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TripInviteFriend() when $default != null:
return $default(_that.id,_that.username,_that.displayName,_that.avatarId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String username, @JsonKey(name: 'displayname')  String displayName,  String? avatarId)  $default,) {final _that = this;
switch (_that) {
case _TripInviteFriend():
return $default(_that.id,_that.username,_that.displayName,_that.avatarId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String username, @JsonKey(name: 'displayname')  String displayName,  String? avatarId)?  $default,) {final _that = this;
switch (_that) {
case _TripInviteFriend() when $default != null:
return $default(_that.id,_that.username,_that.displayName,_that.avatarId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TripInviteFriend implements TripInviteFriend {
  const _TripInviteFriend({required this.id, required this.username, @JsonKey(name: 'displayname') required this.displayName, this.avatarId});
  factory _TripInviteFriend.fromJson(Map<String, dynamic> json) => _$TripInviteFriendFromJson(json);

@override final  String id;
@override final  String username;
@override@JsonKey(name: 'displayname') final  String displayName;
@override final  String? avatarId;

/// Create a copy of TripInviteFriend
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TripInviteFriendCopyWith<_TripInviteFriend> get copyWith => __$TripInviteFriendCopyWithImpl<_TripInviteFriend>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TripInviteFriendToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TripInviteFriend&&(identical(other.id, id) || other.id == id)&&(identical(other.username, username) || other.username == username)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.avatarId, avatarId) || other.avatarId == avatarId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,username,displayName,avatarId);
}

@override
String toString() {
    return 'TripInviteFriend(id: $id, username: $username, displayName: $displayName, avatarId: $avatarId)';
}


}

/// @nodoc
abstract mixin class _$TripInviteFriendCopyWith<$Res> implements $TripInviteFriendCopyWith<$Res> {
  factory _$TripInviteFriendCopyWith(_TripInviteFriend value, $Res Function(_TripInviteFriend) _then) = __$TripInviteFriendCopyWithImpl;
@override @useResult
$Res call({
 String id, String username,@JsonKey(name: 'displayname') String displayName, String? avatarId
});




}
/// @nodoc
class __$TripInviteFriendCopyWithImpl<$Res>
    implements _$TripInviteFriendCopyWith<$Res> {
  __$TripInviteFriendCopyWithImpl(this._self, this._then);

  final _TripInviteFriend _self;
  final $Res Function(_TripInviteFriend) _then;

/// Create a copy of TripInviteFriend
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? username = null,Object? displayName = null,Object? avatarId = freezed,}) {
  return _then(_TripInviteFriend(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,avatarId: freezed == avatarId ? _self.avatarId : avatarId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$TripInviteCandidate {

 TripInviteFriend get user; int get tripsTogetherCount; TripInviteStatus? get invitationStatus;/// Strongest Travel DNA badge, for example `Beach Lover 🏖️`.
 String? get travelPersona;/// 0–100 fit with this trip. Null when either side has no DNA to compare.
 int? get matchScore;/// Later of the friendship date and the latest direct message.
 DateTime? get lastInteractionAt;
/// Create a copy of TripInviteCandidate
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TripInviteCandidateCopyWith<TripInviteCandidate> get copyWith => _$TripInviteCandidateCopyWithImpl<TripInviteCandidate>(this as TripInviteCandidate, _$identity);

  /// Serializes this TripInviteCandidate to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TripInviteCandidate;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TripInviteCandidate&&(identical(other.user, _this.user) || other.user == _this.user)&&(identical(other.tripsTogetherCount, _this.tripsTogetherCount) || other.tripsTogetherCount == _this.tripsTogetherCount)&&(identical(other.invitationStatus, _this.invitationStatus) || other.invitationStatus == _this.invitationStatus)&&(identical(other.travelPersona, _this.travelPersona) || other.travelPersona == _this.travelPersona)&&(identical(other.matchScore, _this.matchScore) || other.matchScore == _this.matchScore)&&(identical(other.lastInteractionAt, _this.lastInteractionAt) || other.lastInteractionAt == _this.lastInteractionAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TripInviteCandidate;
  return Object.hash(runtimeType,_this.user,_this.tripsTogetherCount,_this.invitationStatus,_this.travelPersona,_this.matchScore,_this.lastInteractionAt);
}

@override
String toString() {
  final _this = this as TripInviteCandidate;
  return 'TripInviteCandidate(user: ${_this.user}, tripsTogetherCount: ${_this.tripsTogetherCount}, invitationStatus: ${_this.invitationStatus}, travelPersona: ${_this.travelPersona}, matchScore: ${_this.matchScore}, lastInteractionAt: ${_this.lastInteractionAt})';
}


}

/// @nodoc
abstract mixin class $TripInviteCandidateCopyWith<$Res>  {
  factory $TripInviteCandidateCopyWith(TripInviteCandidate value, $Res Function(TripInviteCandidate) _then) = _$TripInviteCandidateCopyWithImpl;
@useResult
$Res call({
 TripInviteFriend user, int tripsTogetherCount, TripInviteStatus? invitationStatus, String? travelPersona, int? matchScore, DateTime? lastInteractionAt
});


$TripInviteFriendCopyWith<$Res> get user;

}
/// @nodoc
class _$TripInviteCandidateCopyWithImpl<$Res>
    implements $TripInviteCandidateCopyWith<$Res> {
  _$TripInviteCandidateCopyWithImpl(this._self, this._then);

  final TripInviteCandidate _self;
  final $Res Function(TripInviteCandidate) _then;

/// Create a copy of TripInviteCandidate
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? user = null,Object? tripsTogetherCount = null,Object? invitationStatus = freezed,Object? travelPersona = freezed,Object? matchScore = freezed,Object? lastInteractionAt = freezed,}) {
  return _then(TripInviteCandidate(
user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as TripInviteFriend,tripsTogetherCount: null == tripsTogetherCount ? _self.tripsTogetherCount : tripsTogetherCount // ignore: cast_nullable_to_non_nullable
as int,invitationStatus: freezed == invitationStatus ? _self.invitationStatus : invitationStatus // ignore: cast_nullable_to_non_nullable
as TripInviteStatus?,travelPersona: freezed == travelPersona ? _self.travelPersona : travelPersona // ignore: cast_nullable_to_non_nullable
as String?,matchScore: freezed == matchScore ? _self.matchScore : matchScore // ignore: cast_nullable_to_non_nullable
as int?,lastInteractionAt: freezed == lastInteractionAt ? _self.lastInteractionAt : lastInteractionAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}
/// Create a copy of TripInviteCandidate
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TripInviteFriendCopyWith<$Res> get user {
  
  return $TripInviteFriendCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}


/// Adds pattern-matching-related methods to [TripInviteCandidate].
extension TripInviteCandidatePatterns on TripInviteCandidate {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TripInviteCandidate value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TripInviteCandidate() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TripInviteCandidate value)  $default,){
final _that = this;
switch (_that) {
case _TripInviteCandidate():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TripInviteCandidate value)?  $default,){
final _that = this;
switch (_that) {
case _TripInviteCandidate() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( TripInviteFriend user,  int tripsTogetherCount,  TripInviteStatus? invitationStatus,  String? travelPersona,  int? matchScore,  DateTime? lastInteractionAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TripInviteCandidate() when $default != null:
return $default(_that.user,_that.tripsTogetherCount,_that.invitationStatus,_that.travelPersona,_that.matchScore,_that.lastInteractionAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( TripInviteFriend user,  int tripsTogetherCount,  TripInviteStatus? invitationStatus,  String? travelPersona,  int? matchScore,  DateTime? lastInteractionAt)  $default,) {final _that = this;
switch (_that) {
case _TripInviteCandidate():
return $default(_that.user,_that.tripsTogetherCount,_that.invitationStatus,_that.travelPersona,_that.matchScore,_that.lastInteractionAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( TripInviteFriend user,  int tripsTogetherCount,  TripInviteStatus? invitationStatus,  String? travelPersona,  int? matchScore,  DateTime? lastInteractionAt)?  $default,) {final _that = this;
switch (_that) {
case _TripInviteCandidate() when $default != null:
return $default(_that.user,_that.tripsTogetherCount,_that.invitationStatus,_that.travelPersona,_that.matchScore,_that.lastInteractionAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TripInviteCandidate implements TripInviteCandidate {
  const _TripInviteCandidate({required this.user, this.tripsTogetherCount = 0, this.invitationStatus, this.travelPersona, this.matchScore, this.lastInteractionAt});
  factory _TripInviteCandidate.fromJson(Map<String, dynamic> json) => _$TripInviteCandidateFromJson(json);

@override final  TripInviteFriend user;
@override@JsonKey() final  int tripsTogetherCount;
@override final  TripInviteStatus? invitationStatus;
/// Strongest Travel DNA badge, for example `Beach Lover 🏖️`.
@override final  String? travelPersona;
/// 0–100 fit with this trip. Null when either side has no DNA to compare.
@override final  int? matchScore;
/// Later of the friendship date and the latest direct message.
@override final  DateTime? lastInteractionAt;

/// Create a copy of TripInviteCandidate
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TripInviteCandidateCopyWith<_TripInviteCandidate> get copyWith => __$TripInviteCandidateCopyWithImpl<_TripInviteCandidate>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TripInviteCandidateToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TripInviteCandidate&&(identical(other.user, user) || other.user == user)&&(identical(other.tripsTogetherCount, tripsTogetherCount) || other.tripsTogetherCount == tripsTogetherCount)&&(identical(other.invitationStatus, invitationStatus) || other.invitationStatus == invitationStatus)&&(identical(other.travelPersona, travelPersona) || other.travelPersona == travelPersona)&&(identical(other.matchScore, matchScore) || other.matchScore == matchScore)&&(identical(other.lastInteractionAt, lastInteractionAt) || other.lastInteractionAt == lastInteractionAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,user,tripsTogetherCount,invitationStatus,travelPersona,matchScore,lastInteractionAt);
}

@override
String toString() {
    return 'TripInviteCandidate(user: $user, tripsTogetherCount: $tripsTogetherCount, invitationStatus: $invitationStatus, travelPersona: $travelPersona, matchScore: $matchScore, lastInteractionAt: $lastInteractionAt)';
}


}

/// @nodoc
abstract mixin class _$TripInviteCandidateCopyWith<$Res> implements $TripInviteCandidateCopyWith<$Res> {
  factory _$TripInviteCandidateCopyWith(_TripInviteCandidate value, $Res Function(_TripInviteCandidate) _then) = __$TripInviteCandidateCopyWithImpl;
@override @useResult
$Res call({
 TripInviteFriend user, int tripsTogetherCount, TripInviteStatus? invitationStatus, String? travelPersona, int? matchScore, DateTime? lastInteractionAt
});


@override $TripInviteFriendCopyWith<$Res> get user;

}
/// @nodoc
class __$TripInviteCandidateCopyWithImpl<$Res>
    implements _$TripInviteCandidateCopyWith<$Res> {
  __$TripInviteCandidateCopyWithImpl(this._self, this._then);

  final _TripInviteCandidate _self;
  final $Res Function(_TripInviteCandidate) _then;

/// Create a copy of TripInviteCandidate
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? user = null,Object? tripsTogetherCount = null,Object? invitationStatus = freezed,Object? travelPersona = freezed,Object? matchScore = freezed,Object? lastInteractionAt = freezed,}) {
  return _then(_TripInviteCandidate(
user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as TripInviteFriend,tripsTogetherCount: null == tripsTogetherCount ? _self.tripsTogetherCount : tripsTogetherCount // ignore: cast_nullable_to_non_nullable
as int,invitationStatus: freezed == invitationStatus ? _self.invitationStatus : invitationStatus // ignore: cast_nullable_to_non_nullable
as TripInviteStatus?,travelPersona: freezed == travelPersona ? _self.travelPersona : travelPersona // ignore: cast_nullable_to_non_nullable
as String?,matchScore: freezed == matchScore ? _self.matchScore : matchScore // ignore: cast_nullable_to_non_nullable
as int?,lastInteractionAt: freezed == lastInteractionAt ? _self.lastInteractionAt : lastInteractionAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

/// Create a copy of TripInviteCandidate
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TripInviteFriendCopyWith<$Res> get user {
  
  return $TripInviteFriendCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}

/// @nodoc
mixin _$TripInviteSearchPage {

 List<TripInviteFriend> get users; bool get hasNextPage;
/// Create a copy of TripInviteSearchPage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TripInviteSearchPageCopyWith<TripInviteSearchPage> get copyWith => _$TripInviteSearchPageCopyWithImpl<TripInviteSearchPage>(this as TripInviteSearchPage, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as TripInviteSearchPage;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TripInviteSearchPage&&const DeepCollectionEquality().equals(other.users, _this.users)&&(identical(other.hasNextPage, _this.hasNextPage) || other.hasNextPage == _this.hasNextPage));
}


@override
int get hashCode {
  final _this = this as TripInviteSearchPage;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.users),_this.hasNextPage);
}

@override
String toString() {
  final _this = this as TripInviteSearchPage;
  return 'TripInviteSearchPage(users: ${_this.users}, hasNextPage: ${_this.hasNextPage})';
}


}

/// @nodoc
abstract mixin class $TripInviteSearchPageCopyWith<$Res>  {
  factory $TripInviteSearchPageCopyWith(TripInviteSearchPage value, $Res Function(TripInviteSearchPage) _then) = _$TripInviteSearchPageCopyWithImpl;
@useResult
$Res call({
 List<TripInviteFriend> users, bool hasNextPage
});




}
/// @nodoc
class _$TripInviteSearchPageCopyWithImpl<$Res>
    implements $TripInviteSearchPageCopyWith<$Res> {
  _$TripInviteSearchPageCopyWithImpl(this._self, this._then);

  final TripInviteSearchPage _self;
  final $Res Function(TripInviteSearchPage) _then;

/// Create a copy of TripInviteSearchPage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? users = null,Object? hasNextPage = null,}) {
  return _then(TripInviteSearchPage(
users: null == users ? _self.users : users // ignore: cast_nullable_to_non_nullable
as List<TripInviteFriend>,hasNextPage: null == hasNextPage ? _self.hasNextPage : hasNextPage // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [TripInviteSearchPage].
extension TripInviteSearchPagePatterns on TripInviteSearchPage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TripInviteSearchPage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TripInviteSearchPage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TripInviteSearchPage value)  $default,){
final _that = this;
switch (_that) {
case _TripInviteSearchPage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TripInviteSearchPage value)?  $default,){
final _that = this;
switch (_that) {
case _TripInviteSearchPage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<TripInviteFriend> users,  bool hasNextPage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TripInviteSearchPage() when $default != null:
return $default(_that.users,_that.hasNextPage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<TripInviteFriend> users,  bool hasNextPage)  $default,) {final _that = this;
switch (_that) {
case _TripInviteSearchPage():
return $default(_that.users,_that.hasNextPage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<TripInviteFriend> users,  bool hasNextPage)?  $default,) {final _that = this;
switch (_that) {
case _TripInviteSearchPage() when $default != null:
return $default(_that.users,_that.hasNextPage);case _:
  return null;

}
}

}

/// @nodoc


class _TripInviteSearchPage implements TripInviteSearchPage {
  const _TripInviteSearchPage({required  List<TripInviteFriend> users, required this.hasNextPage}): _users = users;
  

 final  List<TripInviteFriend> _users;
@override List<TripInviteFriend> get users {
  if (_users is EqualUnmodifiableListView) return _users;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_users);
}

@override final  bool hasNextPage;

/// Create a copy of TripInviteSearchPage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TripInviteSearchPageCopyWith<_TripInviteSearchPage> get copyWith => __$TripInviteSearchPageCopyWithImpl<_TripInviteSearchPage>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TripInviteSearchPage&&const DeepCollectionEquality().equals(other.users, _users)&&(identical(other.hasNextPage, hasNextPage) || other.hasNextPage == hasNextPage));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_users),hasNextPage);
}

@override
String toString() {
    return 'TripInviteSearchPage(users: $users, hasNextPage: $hasNextPage)';
}


}

/// @nodoc
abstract mixin class _$TripInviteSearchPageCopyWith<$Res> implements $TripInviteSearchPageCopyWith<$Res> {
  factory _$TripInviteSearchPageCopyWith(_TripInviteSearchPage value, $Res Function(_TripInviteSearchPage) _then) = __$TripInviteSearchPageCopyWithImpl;
@override @useResult
$Res call({
 List<TripInviteFriend> users, bool hasNextPage
});




}
/// @nodoc
class __$TripInviteSearchPageCopyWithImpl<$Res>
    implements _$TripInviteSearchPageCopyWith<$Res> {
  __$TripInviteSearchPageCopyWithImpl(this._self, this._then);

  final _TripInviteSearchPage _self;
  final $Res Function(_TripInviteSearchPage) _then;

/// Create a copy of TripInviteSearchPage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? users = null,Object? hasNextPage = null,}) {
  return _then(_TripInviteSearchPage(
users: null == users ? _self._users : users // ignore: cast_nullable_to_non_nullable
as List<TripInviteFriend>,hasNextPage: null == hasNextPage ? _self.hasNextPage : hasNextPage // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$TripInviteSent {

 String get id; String get tripId; String get inviteeId; TripInviteStatus get status;
/// Create a copy of TripInviteSent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TripInviteSentCopyWith<TripInviteSent> get copyWith => _$TripInviteSentCopyWithImpl<TripInviteSent>(this as TripInviteSent, _$identity);

  /// Serializes this TripInviteSent to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TripInviteSent;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TripInviteSent&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.tripId, _this.tripId) || other.tripId == _this.tripId)&&(identical(other.inviteeId, _this.inviteeId) || other.inviteeId == _this.inviteeId)&&(identical(other.status, _this.status) || other.status == _this.status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TripInviteSent;
  return Object.hash(runtimeType,_this.id,_this.tripId,_this.inviteeId,_this.status);
}

@override
String toString() {
  final _this = this as TripInviteSent;
  return 'TripInviteSent(id: ${_this.id}, tripId: ${_this.tripId}, inviteeId: ${_this.inviteeId}, status: ${_this.status})';
}


}

/// @nodoc
abstract mixin class $TripInviteSentCopyWith<$Res>  {
  factory $TripInviteSentCopyWith(TripInviteSent value, $Res Function(TripInviteSent) _then) = _$TripInviteSentCopyWithImpl;
@useResult
$Res call({
 String id, String tripId, String inviteeId, TripInviteStatus status
});




}
/// @nodoc
class _$TripInviteSentCopyWithImpl<$Res>
    implements $TripInviteSentCopyWith<$Res> {
  _$TripInviteSentCopyWithImpl(this._self, this._then);

  final TripInviteSent _self;
  final $Res Function(TripInviteSent) _then;

/// Create a copy of TripInviteSent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? tripId = null,Object? inviteeId = null,Object? status = null,}) {
  return _then(TripInviteSent(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,tripId: null == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String,inviteeId: null == inviteeId ? _self.inviteeId : inviteeId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TripInviteStatus,
  ));
}

}


/// Adds pattern-matching-related methods to [TripInviteSent].
extension TripInviteSentPatterns on TripInviteSent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TripInviteSent value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TripInviteSent() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TripInviteSent value)  $default,){
final _that = this;
switch (_that) {
case _TripInviteSent():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TripInviteSent value)?  $default,){
final _that = this;
switch (_that) {
case _TripInviteSent() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String tripId,  String inviteeId,  TripInviteStatus status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TripInviteSent() when $default != null:
return $default(_that.id,_that.tripId,_that.inviteeId,_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String tripId,  String inviteeId,  TripInviteStatus status)  $default,) {final _that = this;
switch (_that) {
case _TripInviteSent():
return $default(_that.id,_that.tripId,_that.inviteeId,_that.status);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String tripId,  String inviteeId,  TripInviteStatus status)?  $default,) {final _that = this;
switch (_that) {
case _TripInviteSent() when $default != null:
return $default(_that.id,_that.tripId,_that.inviteeId,_that.status);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TripInviteSent implements TripInviteSent {
  const _TripInviteSent({required this.id, required this.tripId, required this.inviteeId, required this.status});
  factory _TripInviteSent.fromJson(Map<String, dynamic> json) => _$TripInviteSentFromJson(json);

@override final  String id;
@override final  String tripId;
@override final  String inviteeId;
@override final  TripInviteStatus status;

/// Create a copy of TripInviteSent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TripInviteSentCopyWith<_TripInviteSent> get copyWith => __$TripInviteSentCopyWithImpl<_TripInviteSent>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TripInviteSentToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TripInviteSent&&(identical(other.id, id) || other.id == id)&&(identical(other.tripId, tripId) || other.tripId == tripId)&&(identical(other.inviteeId, inviteeId) || other.inviteeId == inviteeId)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,tripId,inviteeId,status);
}

@override
String toString() {
    return 'TripInviteSent(id: $id, tripId: $tripId, inviteeId: $inviteeId, status: $status)';
}


}

/// @nodoc
abstract mixin class _$TripInviteSentCopyWith<$Res> implements $TripInviteSentCopyWith<$Res> {
  factory _$TripInviteSentCopyWith(_TripInviteSent value, $Res Function(_TripInviteSent) _then) = __$TripInviteSentCopyWithImpl;
@override @useResult
$Res call({
 String id, String tripId, String inviteeId, TripInviteStatus status
});




}
/// @nodoc
class __$TripInviteSentCopyWithImpl<$Res>
    implements _$TripInviteSentCopyWith<$Res> {
  __$TripInviteSentCopyWithImpl(this._self, this._then);

  final _TripInviteSent _self;
  final $Res Function(_TripInviteSent) _then;

/// Create a copy of TripInviteSent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? tripId = null,Object? inviteeId = null,Object? status = null,}) {
  return _then(_TripInviteSent(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,tripId: null == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String,inviteeId: null == inviteeId ? _self.inviteeId : inviteeId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TripInviteStatus,
  ));
}


}

// dart format on
