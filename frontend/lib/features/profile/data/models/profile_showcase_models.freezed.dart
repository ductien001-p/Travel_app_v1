// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_showcase_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ProfileShowcase {

 String get hostStatus; ProfileShowcaseRanking get ranking; ProfileSocialStats get social; ProfileTravelDna get travelDna; ProfileShowcaseTrip? get ongoingTrip; ProfileShowcaseTrip? get upcomingTrip; ProfileShowcaseMemories get memories; ProfileShowcaseSavedPlaces get savedPlaces; ProfileShowcasePosts get posts;
/// Create a copy of ProfileShowcase
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileShowcaseCopyWith<ProfileShowcase> get copyWith => _$ProfileShowcaseCopyWithImpl<ProfileShowcase>(this as ProfileShowcase, _$identity);

  /// Serializes this ProfileShowcase to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ProfileShowcase;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileShowcase&&(identical(other.hostStatus, _this.hostStatus) || other.hostStatus == _this.hostStatus)&&(identical(other.ranking, _this.ranking) || other.ranking == _this.ranking)&&(identical(other.social, _this.social) || other.social == _this.social)&&(identical(other.travelDna, _this.travelDna) || other.travelDna == _this.travelDna)&&(identical(other.ongoingTrip, _this.ongoingTrip) || other.ongoingTrip == _this.ongoingTrip)&&(identical(other.upcomingTrip, _this.upcomingTrip) || other.upcomingTrip == _this.upcomingTrip)&&(identical(other.memories, _this.memories) || other.memories == _this.memories)&&(identical(other.savedPlaces, _this.savedPlaces) || other.savedPlaces == _this.savedPlaces)&&(identical(other.posts, _this.posts) || other.posts == _this.posts));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ProfileShowcase;
  return Object.hash(runtimeType,_this.hostStatus,_this.ranking,_this.social,_this.travelDna,_this.ongoingTrip,_this.upcomingTrip,_this.memories,_this.savedPlaces,_this.posts);
}

@override
String toString() {
  final _this = this as ProfileShowcase;
  return 'ProfileShowcase(hostStatus: ${_this.hostStatus}, ranking: ${_this.ranking}, social: ${_this.social}, travelDna: ${_this.travelDna}, ongoingTrip: ${_this.ongoingTrip}, upcomingTrip: ${_this.upcomingTrip}, memories: ${_this.memories}, savedPlaces: ${_this.savedPlaces}, posts: ${_this.posts})';
}


}

/// @nodoc
abstract mixin class $ProfileShowcaseCopyWith<$Res>  {
  factory $ProfileShowcaseCopyWith(ProfileShowcase value, $Res Function(ProfileShowcase) _then) = _$ProfileShowcaseCopyWithImpl;
@useResult
$Res call({
 String hostStatus, ProfileShowcaseRanking ranking, ProfileSocialStats social, ProfileTravelDna travelDna, ProfileShowcaseTrip? ongoingTrip, ProfileShowcaseTrip? upcomingTrip, ProfileShowcaseMemories memories, ProfileShowcaseSavedPlaces savedPlaces, ProfileShowcasePosts posts
});


$ProfileShowcaseRankingCopyWith<$Res> get ranking;$ProfileSocialStatsCopyWith<$Res> get social;$ProfileTravelDnaCopyWith<$Res> get travelDna;$ProfileShowcaseTripCopyWith<$Res>? get ongoingTrip;$ProfileShowcaseTripCopyWith<$Res>? get upcomingTrip;$ProfileShowcaseMemoriesCopyWith<$Res> get memories;$ProfileShowcaseSavedPlacesCopyWith<$Res> get savedPlaces;$ProfileShowcasePostsCopyWith<$Res> get posts;

}
/// @nodoc
class _$ProfileShowcaseCopyWithImpl<$Res>
    implements $ProfileShowcaseCopyWith<$Res> {
  _$ProfileShowcaseCopyWithImpl(this._self, this._then);

  final ProfileShowcase _self;
  final $Res Function(ProfileShowcase) _then;

/// Create a copy of ProfileShowcase
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? hostStatus = null,Object? ranking = null,Object? social = null,Object? travelDna = null,Object? ongoingTrip = freezed,Object? upcomingTrip = freezed,Object? memories = null,Object? savedPlaces = null,Object? posts = null,}) {
  return _then(ProfileShowcase(
hostStatus: null == hostStatus ? _self.hostStatus : hostStatus // ignore: cast_nullable_to_non_nullable
as String,ranking: null == ranking ? _self.ranking : ranking // ignore: cast_nullable_to_non_nullable
as ProfileShowcaseRanking,social: null == social ? _self.social : social // ignore: cast_nullable_to_non_nullable
as ProfileSocialStats,travelDna: null == travelDna ? _self.travelDna : travelDna // ignore: cast_nullable_to_non_nullable
as ProfileTravelDna,ongoingTrip: freezed == ongoingTrip ? _self.ongoingTrip : ongoingTrip // ignore: cast_nullable_to_non_nullable
as ProfileShowcaseTrip?,upcomingTrip: freezed == upcomingTrip ? _self.upcomingTrip : upcomingTrip // ignore: cast_nullable_to_non_nullable
as ProfileShowcaseTrip?,memories: null == memories ? _self.memories : memories // ignore: cast_nullable_to_non_nullable
as ProfileShowcaseMemories,savedPlaces: null == savedPlaces ? _self.savedPlaces : savedPlaces // ignore: cast_nullable_to_non_nullable
as ProfileShowcaseSavedPlaces,posts: null == posts ? _self.posts : posts // ignore: cast_nullable_to_non_nullable
as ProfileShowcasePosts,
  ));
}
/// Create a copy of ProfileShowcase
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProfileShowcaseRankingCopyWith<$Res> get ranking {
  
  return $ProfileShowcaseRankingCopyWith<$Res>(_self.ranking, (value) {
    return _then(_self.copyWith(ranking: value));
  });
}/// Create a copy of ProfileShowcase
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProfileSocialStatsCopyWith<$Res> get social {
  
  return $ProfileSocialStatsCopyWith<$Res>(_self.social, (value) {
    return _then(_self.copyWith(social: value));
  });
}/// Create a copy of ProfileShowcase
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProfileTravelDnaCopyWith<$Res> get travelDna {
  
  return $ProfileTravelDnaCopyWith<$Res>(_self.travelDna, (value) {
    return _then(_self.copyWith(travelDna: value));
  });
}/// Create a copy of ProfileShowcase
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProfileShowcaseTripCopyWith<$Res>? get ongoingTrip {
    if (_self.ongoingTrip == null) {
    return null;
  }

  return $ProfileShowcaseTripCopyWith<$Res>(_self.ongoingTrip!, (value) {
    return _then(_self.copyWith(ongoingTrip: value));
  });
}/// Create a copy of ProfileShowcase
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProfileShowcaseTripCopyWith<$Res>? get upcomingTrip {
    if (_self.upcomingTrip == null) {
    return null;
  }

  return $ProfileShowcaseTripCopyWith<$Res>(_self.upcomingTrip!, (value) {
    return _then(_self.copyWith(upcomingTrip: value));
  });
}/// Create a copy of ProfileShowcase
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProfileShowcaseMemoriesCopyWith<$Res> get memories {
  
  return $ProfileShowcaseMemoriesCopyWith<$Res>(_self.memories, (value) {
    return _then(_self.copyWith(memories: value));
  });
}/// Create a copy of ProfileShowcase
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProfileShowcaseSavedPlacesCopyWith<$Res> get savedPlaces {
  
  return $ProfileShowcaseSavedPlacesCopyWith<$Res>(_self.savedPlaces, (value) {
    return _then(_self.copyWith(savedPlaces: value));
  });
}/// Create a copy of ProfileShowcase
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProfileShowcasePostsCopyWith<$Res> get posts {
  
  return $ProfileShowcasePostsCopyWith<$Res>(_self.posts, (value) {
    return _then(_self.copyWith(posts: value));
  });
}
}


/// Adds pattern-matching-related methods to [ProfileShowcase].
extension ProfileShowcasePatterns on ProfileShowcase {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProfileShowcase value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProfileShowcase() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProfileShowcase value)  $default,){
final _that = this;
switch (_that) {
case _ProfileShowcase():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProfileShowcase value)?  $default,){
final _that = this;
switch (_that) {
case _ProfileShowcase() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String hostStatus,  ProfileShowcaseRanking ranking,  ProfileSocialStats social,  ProfileTravelDna travelDna,  ProfileShowcaseTrip? ongoingTrip,  ProfileShowcaseTrip? upcomingTrip,  ProfileShowcaseMemories memories,  ProfileShowcaseSavedPlaces savedPlaces,  ProfileShowcasePosts posts)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProfileShowcase() when $default != null:
return $default(_that.hostStatus,_that.ranking,_that.social,_that.travelDna,_that.ongoingTrip,_that.upcomingTrip,_that.memories,_that.savedPlaces,_that.posts);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String hostStatus,  ProfileShowcaseRanking ranking,  ProfileSocialStats social,  ProfileTravelDna travelDna,  ProfileShowcaseTrip? ongoingTrip,  ProfileShowcaseTrip? upcomingTrip,  ProfileShowcaseMemories memories,  ProfileShowcaseSavedPlaces savedPlaces,  ProfileShowcasePosts posts)  $default,) {final _that = this;
switch (_that) {
case _ProfileShowcase():
return $default(_that.hostStatus,_that.ranking,_that.social,_that.travelDna,_that.ongoingTrip,_that.upcomingTrip,_that.memories,_that.savedPlaces,_that.posts);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String hostStatus,  ProfileShowcaseRanking ranking,  ProfileSocialStats social,  ProfileTravelDna travelDna,  ProfileShowcaseTrip? ongoingTrip,  ProfileShowcaseTrip? upcomingTrip,  ProfileShowcaseMemories memories,  ProfileShowcaseSavedPlaces savedPlaces,  ProfileShowcasePosts posts)?  $default,) {final _that = this;
switch (_that) {
case _ProfileShowcase() when $default != null:
return $default(_that.hostStatus,_that.ranking,_that.social,_that.travelDna,_that.ongoingTrip,_that.upcomingTrip,_that.memories,_that.savedPlaces,_that.posts);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProfileShowcase implements ProfileShowcase {
  const _ProfileShowcase({required this.hostStatus, required this.ranking, required this.social, required this.travelDna, this.ongoingTrip, this.upcomingTrip, required this.memories, required this.savedPlaces, required this.posts});
  factory _ProfileShowcase.fromJson(Map<String, dynamic> json) => _$ProfileShowcaseFromJson(json);

@override final  String hostStatus;
@override final  ProfileShowcaseRanking ranking;
@override final  ProfileSocialStats social;
@override final  ProfileTravelDna travelDna;
@override final  ProfileShowcaseTrip? ongoingTrip;
@override final  ProfileShowcaseTrip? upcomingTrip;
@override final  ProfileShowcaseMemories memories;
@override final  ProfileShowcaseSavedPlaces savedPlaces;
@override final  ProfileShowcasePosts posts;

/// Create a copy of ProfileShowcase
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProfileShowcaseCopyWith<_ProfileShowcase> get copyWith => __$ProfileShowcaseCopyWithImpl<_ProfileShowcase>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProfileShowcaseToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProfileShowcase&&(identical(other.hostStatus, hostStatus) || other.hostStatus == hostStatus)&&(identical(other.ranking, ranking) || other.ranking == ranking)&&(identical(other.social, social) || other.social == social)&&(identical(other.travelDna, travelDna) || other.travelDna == travelDna)&&(identical(other.ongoingTrip, ongoingTrip) || other.ongoingTrip == ongoingTrip)&&(identical(other.upcomingTrip, upcomingTrip) || other.upcomingTrip == upcomingTrip)&&(identical(other.memories, memories) || other.memories == memories)&&(identical(other.savedPlaces, savedPlaces) || other.savedPlaces == savedPlaces)&&(identical(other.posts, posts) || other.posts == posts));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,hostStatus,ranking,social,travelDna,ongoingTrip,upcomingTrip,memories,savedPlaces,posts);
}

@override
String toString() {
    return 'ProfileShowcase(hostStatus: $hostStatus, ranking: $ranking, social: $social, travelDna: $travelDna, ongoingTrip: $ongoingTrip, upcomingTrip: $upcomingTrip, memories: $memories, savedPlaces: $savedPlaces, posts: $posts)';
}


}

/// @nodoc
abstract mixin class _$ProfileShowcaseCopyWith<$Res> implements $ProfileShowcaseCopyWith<$Res> {
  factory _$ProfileShowcaseCopyWith(_ProfileShowcase value, $Res Function(_ProfileShowcase) _then) = __$ProfileShowcaseCopyWithImpl;
@override @useResult
$Res call({
 String hostStatus, ProfileShowcaseRanking ranking, ProfileSocialStats social, ProfileTravelDna travelDna, ProfileShowcaseTrip? ongoingTrip, ProfileShowcaseTrip? upcomingTrip, ProfileShowcaseMemories memories, ProfileShowcaseSavedPlaces savedPlaces, ProfileShowcasePosts posts
});


@override $ProfileShowcaseRankingCopyWith<$Res> get ranking;@override $ProfileSocialStatsCopyWith<$Res> get social;@override $ProfileTravelDnaCopyWith<$Res> get travelDna;@override $ProfileShowcaseTripCopyWith<$Res>? get ongoingTrip;@override $ProfileShowcaseTripCopyWith<$Res>? get upcomingTrip;@override $ProfileShowcaseMemoriesCopyWith<$Res> get memories;@override $ProfileShowcaseSavedPlacesCopyWith<$Res> get savedPlaces;@override $ProfileShowcasePostsCopyWith<$Res> get posts;

}
/// @nodoc
class __$ProfileShowcaseCopyWithImpl<$Res>
    implements _$ProfileShowcaseCopyWith<$Res> {
  __$ProfileShowcaseCopyWithImpl(this._self, this._then);

  final _ProfileShowcase _self;
  final $Res Function(_ProfileShowcase) _then;

/// Create a copy of ProfileShowcase
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? hostStatus = null,Object? ranking = null,Object? social = null,Object? travelDna = null,Object? ongoingTrip = freezed,Object? upcomingTrip = freezed,Object? memories = null,Object? savedPlaces = null,Object? posts = null,}) {
  return _then(_ProfileShowcase(
hostStatus: null == hostStatus ? _self.hostStatus : hostStatus // ignore: cast_nullable_to_non_nullable
as String,ranking: null == ranking ? _self.ranking : ranking // ignore: cast_nullable_to_non_nullable
as ProfileShowcaseRanking,social: null == social ? _self.social : social // ignore: cast_nullable_to_non_nullable
as ProfileSocialStats,travelDna: null == travelDna ? _self.travelDna : travelDna // ignore: cast_nullable_to_non_nullable
as ProfileTravelDna,ongoingTrip: freezed == ongoingTrip ? _self.ongoingTrip : ongoingTrip // ignore: cast_nullable_to_non_nullable
as ProfileShowcaseTrip?,upcomingTrip: freezed == upcomingTrip ? _self.upcomingTrip : upcomingTrip // ignore: cast_nullable_to_non_nullable
as ProfileShowcaseTrip?,memories: null == memories ? _self.memories : memories // ignore: cast_nullable_to_non_nullable
as ProfileShowcaseMemories,savedPlaces: null == savedPlaces ? _self.savedPlaces : savedPlaces // ignore: cast_nullable_to_non_nullable
as ProfileShowcaseSavedPlaces,posts: null == posts ? _self.posts : posts // ignore: cast_nullable_to_non_nullable
as ProfileShowcasePosts,
  ));
}

/// Create a copy of ProfileShowcase
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProfileShowcaseRankingCopyWith<$Res> get ranking {
  
  return $ProfileShowcaseRankingCopyWith<$Res>(_self.ranking, (value) {
    return _then(_self.copyWith(ranking: value));
  });
}/// Create a copy of ProfileShowcase
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProfileSocialStatsCopyWith<$Res> get social {
  
  return $ProfileSocialStatsCopyWith<$Res>(_self.social, (value) {
    return _then(_self.copyWith(social: value));
  });
}/// Create a copy of ProfileShowcase
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProfileTravelDnaCopyWith<$Res> get travelDna {
  
  return $ProfileTravelDnaCopyWith<$Res>(_self.travelDna, (value) {
    return _then(_self.copyWith(travelDna: value));
  });
}/// Create a copy of ProfileShowcase
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProfileShowcaseTripCopyWith<$Res>? get ongoingTrip {
    if (_self.ongoingTrip == null) {
    return null;
  }

  return $ProfileShowcaseTripCopyWith<$Res>(_self.ongoingTrip!, (value) {
    return _then(_self.copyWith(ongoingTrip: value));
  });
}/// Create a copy of ProfileShowcase
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProfileShowcaseTripCopyWith<$Res>? get upcomingTrip {
    if (_self.upcomingTrip == null) {
    return null;
  }

  return $ProfileShowcaseTripCopyWith<$Res>(_self.upcomingTrip!, (value) {
    return _then(_self.copyWith(upcomingTrip: value));
  });
}/// Create a copy of ProfileShowcase
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProfileShowcaseMemoriesCopyWith<$Res> get memories {
  
  return $ProfileShowcaseMemoriesCopyWith<$Res>(_self.memories, (value) {
    return _then(_self.copyWith(memories: value));
  });
}/// Create a copy of ProfileShowcase
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProfileShowcaseSavedPlacesCopyWith<$Res> get savedPlaces {
  
  return $ProfileShowcaseSavedPlacesCopyWith<$Res>(_self.savedPlaces, (value) {
    return _then(_self.copyWith(savedPlaces: value));
  });
}/// Create a copy of ProfileShowcase
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProfileShowcasePostsCopyWith<$Res> get posts {
  
  return $ProfileShowcasePostsCopyWith<$Res>(_self.posts, (value) {
    return _then(_self.copyWith(posts: value));
  });
}
}


/// @nodoc
mixin _$ProfileShowcaseRanking {

 String get userId; int get totalPoints; int get totalTripsCompleted; String get rank; int? get ranking; int? get percentile;
/// Create a copy of ProfileShowcaseRanking
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileShowcaseRankingCopyWith<ProfileShowcaseRanking> get copyWith => _$ProfileShowcaseRankingCopyWithImpl<ProfileShowcaseRanking>(this as ProfileShowcaseRanking, _$identity);

  /// Serializes this ProfileShowcaseRanking to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ProfileShowcaseRanking;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileShowcaseRanking&&(identical(other.userId, _this.userId) || other.userId == _this.userId)&&(identical(other.totalPoints, _this.totalPoints) || other.totalPoints == _this.totalPoints)&&(identical(other.totalTripsCompleted, _this.totalTripsCompleted) || other.totalTripsCompleted == _this.totalTripsCompleted)&&(identical(other.rank, _this.rank) || other.rank == _this.rank)&&(identical(other.ranking, _this.ranking) || other.ranking == _this.ranking)&&(identical(other.percentile, _this.percentile) || other.percentile == _this.percentile));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ProfileShowcaseRanking;
  return Object.hash(runtimeType,_this.userId,_this.totalPoints,_this.totalTripsCompleted,_this.rank,_this.ranking,_this.percentile);
}

@override
String toString() {
  final _this = this as ProfileShowcaseRanking;
  return 'ProfileShowcaseRanking(userId: ${_this.userId}, totalPoints: ${_this.totalPoints}, totalTripsCompleted: ${_this.totalTripsCompleted}, rank: ${_this.rank}, ranking: ${_this.ranking}, percentile: ${_this.percentile})';
}


}

/// @nodoc
abstract mixin class $ProfileShowcaseRankingCopyWith<$Res>  {
  factory $ProfileShowcaseRankingCopyWith(ProfileShowcaseRanking value, $Res Function(ProfileShowcaseRanking) _then) = _$ProfileShowcaseRankingCopyWithImpl;
@useResult
$Res call({
 String userId, int totalPoints, int totalTripsCompleted, String rank, int? ranking, int? percentile
});




}
/// @nodoc
class _$ProfileShowcaseRankingCopyWithImpl<$Res>
    implements $ProfileShowcaseRankingCopyWith<$Res> {
  _$ProfileShowcaseRankingCopyWithImpl(this._self, this._then);

  final ProfileShowcaseRanking _self;
  final $Res Function(ProfileShowcaseRanking) _then;

/// Create a copy of ProfileShowcaseRanking
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? totalPoints = null,Object? totalTripsCompleted = null,Object? rank = null,Object? ranking = freezed,Object? percentile = freezed,}) {
  return _then(ProfileShowcaseRanking(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,totalPoints: null == totalPoints ? _self.totalPoints : totalPoints // ignore: cast_nullable_to_non_nullable
as int,totalTripsCompleted: null == totalTripsCompleted ? _self.totalTripsCompleted : totalTripsCompleted // ignore: cast_nullable_to_non_nullable
as int,rank: null == rank ? _self.rank : rank // ignore: cast_nullable_to_non_nullable
as String,ranking: freezed == ranking ? _self.ranking : ranking // ignore: cast_nullable_to_non_nullable
as int?,percentile: freezed == percentile ? _self.percentile : percentile // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [ProfileShowcaseRanking].
extension ProfileShowcaseRankingPatterns on ProfileShowcaseRanking {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProfileShowcaseRanking value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProfileShowcaseRanking() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProfileShowcaseRanking value)  $default,){
final _that = this;
switch (_that) {
case _ProfileShowcaseRanking():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProfileShowcaseRanking value)?  $default,){
final _that = this;
switch (_that) {
case _ProfileShowcaseRanking() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String userId,  int totalPoints,  int totalTripsCompleted,  String rank,  int? ranking,  int? percentile)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProfileShowcaseRanking() when $default != null:
return $default(_that.userId,_that.totalPoints,_that.totalTripsCompleted,_that.rank,_that.ranking,_that.percentile);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String userId,  int totalPoints,  int totalTripsCompleted,  String rank,  int? ranking,  int? percentile)  $default,) {final _that = this;
switch (_that) {
case _ProfileShowcaseRanking():
return $default(_that.userId,_that.totalPoints,_that.totalTripsCompleted,_that.rank,_that.ranking,_that.percentile);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String userId,  int totalPoints,  int totalTripsCompleted,  String rank,  int? ranking,  int? percentile)?  $default,) {final _that = this;
switch (_that) {
case _ProfileShowcaseRanking() when $default != null:
return $default(_that.userId,_that.totalPoints,_that.totalTripsCompleted,_that.rank,_that.ranking,_that.percentile);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProfileShowcaseRanking implements ProfileShowcaseRanking {
  const _ProfileShowcaseRanking({required this.userId, required this.totalPoints, required this.totalTripsCompleted, required this.rank, this.ranking, this.percentile});
  factory _ProfileShowcaseRanking.fromJson(Map<String, dynamic> json) => _$ProfileShowcaseRankingFromJson(json);

@override final  String userId;
@override final  int totalPoints;
@override final  int totalTripsCompleted;
@override final  String rank;
@override final  int? ranking;
@override final  int? percentile;

/// Create a copy of ProfileShowcaseRanking
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProfileShowcaseRankingCopyWith<_ProfileShowcaseRanking> get copyWith => __$ProfileShowcaseRankingCopyWithImpl<_ProfileShowcaseRanking>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProfileShowcaseRankingToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProfileShowcaseRanking&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.totalPoints, totalPoints) || other.totalPoints == totalPoints)&&(identical(other.totalTripsCompleted, totalTripsCompleted) || other.totalTripsCompleted == totalTripsCompleted)&&(identical(other.rank, rank) || other.rank == rank)&&(identical(other.ranking, ranking) || other.ranking == ranking)&&(identical(other.percentile, percentile) || other.percentile == percentile));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,userId,totalPoints,totalTripsCompleted,rank,ranking,percentile);
}

@override
String toString() {
    return 'ProfileShowcaseRanking(userId: $userId, totalPoints: $totalPoints, totalTripsCompleted: $totalTripsCompleted, rank: $rank, ranking: $ranking, percentile: $percentile)';
}


}

/// @nodoc
abstract mixin class _$ProfileShowcaseRankingCopyWith<$Res> implements $ProfileShowcaseRankingCopyWith<$Res> {
  factory _$ProfileShowcaseRankingCopyWith(_ProfileShowcaseRanking value, $Res Function(_ProfileShowcaseRanking) _then) = __$ProfileShowcaseRankingCopyWithImpl;
@override @useResult
$Res call({
 String userId, int totalPoints, int totalTripsCompleted, String rank, int? ranking, int? percentile
});




}
/// @nodoc
class __$ProfileShowcaseRankingCopyWithImpl<$Res>
    implements _$ProfileShowcaseRankingCopyWith<$Res> {
  __$ProfileShowcaseRankingCopyWithImpl(this._self, this._then);

  final _ProfileShowcaseRanking _self;
  final $Res Function(_ProfileShowcaseRanking) _then;

/// Create a copy of ProfileShowcaseRanking
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? totalPoints = null,Object? totalTripsCompleted = null,Object? rank = null,Object? ranking = freezed,Object? percentile = freezed,}) {
  return _then(_ProfileShowcaseRanking(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,totalPoints: null == totalPoints ? _self.totalPoints : totalPoints // ignore: cast_nullable_to_non_nullable
as int,totalTripsCompleted: null == totalTripsCompleted ? _self.totalTripsCompleted : totalTripsCompleted // ignore: cast_nullable_to_non_nullable
as int,rank: null == rank ? _self.rank : rank // ignore: cast_nullable_to_non_nullable
as String,ranking: freezed == ranking ? _self.ranking : ranking // ignore: cast_nullable_to_non_nullable
as int?,percentile: freezed == percentile ? _self.percentile : percentile // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$ProfileSocialStats {

 int get tripCount; int get followerCount; int get followingCount;
/// Create a copy of ProfileSocialStats
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileSocialStatsCopyWith<ProfileSocialStats> get copyWith => _$ProfileSocialStatsCopyWithImpl<ProfileSocialStats>(this as ProfileSocialStats, _$identity);

  /// Serializes this ProfileSocialStats to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ProfileSocialStats;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileSocialStats&&(identical(other.tripCount, _this.tripCount) || other.tripCount == _this.tripCount)&&(identical(other.followerCount, _this.followerCount) || other.followerCount == _this.followerCount)&&(identical(other.followingCount, _this.followingCount) || other.followingCount == _this.followingCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ProfileSocialStats;
  return Object.hash(runtimeType,_this.tripCount,_this.followerCount,_this.followingCount);
}

@override
String toString() {
  final _this = this as ProfileSocialStats;
  return 'ProfileSocialStats(tripCount: ${_this.tripCount}, followerCount: ${_this.followerCount}, followingCount: ${_this.followingCount})';
}


}

/// @nodoc
abstract mixin class $ProfileSocialStatsCopyWith<$Res>  {
  factory $ProfileSocialStatsCopyWith(ProfileSocialStats value, $Res Function(ProfileSocialStats) _then) = _$ProfileSocialStatsCopyWithImpl;
@useResult
$Res call({
 int tripCount, int followerCount, int followingCount
});




}
/// @nodoc
class _$ProfileSocialStatsCopyWithImpl<$Res>
    implements $ProfileSocialStatsCopyWith<$Res> {
  _$ProfileSocialStatsCopyWithImpl(this._self, this._then);

  final ProfileSocialStats _self;
  final $Res Function(ProfileSocialStats) _then;

/// Create a copy of ProfileSocialStats
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? tripCount = null,Object? followerCount = null,Object? followingCount = null,}) {
  return _then(ProfileSocialStats(
tripCount: null == tripCount ? _self.tripCount : tripCount // ignore: cast_nullable_to_non_nullable
as int,followerCount: null == followerCount ? _self.followerCount : followerCount // ignore: cast_nullable_to_non_nullable
as int,followingCount: null == followingCount ? _self.followingCount : followingCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ProfileSocialStats].
extension ProfileSocialStatsPatterns on ProfileSocialStats {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProfileSocialStats value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProfileSocialStats() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProfileSocialStats value)  $default,){
final _that = this;
switch (_that) {
case _ProfileSocialStats():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProfileSocialStats value)?  $default,){
final _that = this;
switch (_that) {
case _ProfileSocialStats() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int tripCount,  int followerCount,  int followingCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProfileSocialStats() when $default != null:
return $default(_that.tripCount,_that.followerCount,_that.followingCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int tripCount,  int followerCount,  int followingCount)  $default,) {final _that = this;
switch (_that) {
case _ProfileSocialStats():
return $default(_that.tripCount,_that.followerCount,_that.followingCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int tripCount,  int followerCount,  int followingCount)?  $default,) {final _that = this;
switch (_that) {
case _ProfileSocialStats() when $default != null:
return $default(_that.tripCount,_that.followerCount,_that.followingCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProfileSocialStats implements ProfileSocialStats {
  const _ProfileSocialStats({required this.tripCount, required this.followerCount, required this.followingCount});
  factory _ProfileSocialStats.fromJson(Map<String, dynamic> json) => _$ProfileSocialStatsFromJson(json);

@override final  int tripCount;
@override final  int followerCount;
@override final  int followingCount;

/// Create a copy of ProfileSocialStats
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProfileSocialStatsCopyWith<_ProfileSocialStats> get copyWith => __$ProfileSocialStatsCopyWithImpl<_ProfileSocialStats>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProfileSocialStatsToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProfileSocialStats&&(identical(other.tripCount, tripCount) || other.tripCount == tripCount)&&(identical(other.followerCount, followerCount) || other.followerCount == followerCount)&&(identical(other.followingCount, followingCount) || other.followingCount == followingCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,tripCount,followerCount,followingCount);
}

@override
String toString() {
    return 'ProfileSocialStats(tripCount: $tripCount, followerCount: $followerCount, followingCount: $followingCount)';
}


}

/// @nodoc
abstract mixin class _$ProfileSocialStatsCopyWith<$Res> implements $ProfileSocialStatsCopyWith<$Res> {
  factory _$ProfileSocialStatsCopyWith(_ProfileSocialStats value, $Res Function(_ProfileSocialStats) _then) = __$ProfileSocialStatsCopyWithImpl;
@override @useResult
$Res call({
 int tripCount, int followerCount, int followingCount
});




}
/// @nodoc
class __$ProfileSocialStatsCopyWithImpl<$Res>
    implements _$ProfileSocialStatsCopyWith<$Res> {
  __$ProfileSocialStatsCopyWithImpl(this._self, this._then);

  final _ProfileSocialStats _self;
  final $Res Function(_ProfileSocialStats) _then;

/// Create a copy of ProfileSocialStats
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? tripCount = null,Object? followerCount = null,Object? followingCount = null,}) {
  return _then(_ProfileSocialStats(
tripCount: null == tripCount ? _self.tripCount : tripCount // ignore: cast_nullable_to_non_nullable
as int,followerCount: null == followerCount ? _self.followerCount : followerCount // ignore: cast_nullable_to_non_nullable
as int,followingCount: null == followingCount ? _self.followingCount : followingCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$ProfileTravelDna {

 ProfileTravelDnaBadge? get dominant; List<ProfileTravelDnaBadge> get topBadges; List<ProfileTravelDnaBadge> get all;
/// Create a copy of ProfileTravelDna
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileTravelDnaCopyWith<ProfileTravelDna> get copyWith => _$ProfileTravelDnaCopyWithImpl<ProfileTravelDna>(this as ProfileTravelDna, _$identity);

  /// Serializes this ProfileTravelDna to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ProfileTravelDna;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileTravelDna&&(identical(other.dominant, _this.dominant) || other.dominant == _this.dominant)&&const DeepCollectionEquality().equals(other.topBadges, _this.topBadges)&&const DeepCollectionEquality().equals(other.all, _this.all));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ProfileTravelDna;
  return Object.hash(runtimeType,_this.dominant,const DeepCollectionEquality().hash(_this.topBadges),const DeepCollectionEquality().hash(_this.all));
}

@override
String toString() {
  final _this = this as ProfileTravelDna;
  return 'ProfileTravelDna(dominant: ${_this.dominant}, topBadges: ${_this.topBadges}, all: ${_this.all})';
}


}

/// @nodoc
abstract mixin class $ProfileTravelDnaCopyWith<$Res>  {
  factory $ProfileTravelDnaCopyWith(ProfileTravelDna value, $Res Function(ProfileTravelDna) _then) = _$ProfileTravelDnaCopyWithImpl;
@useResult
$Res call({
 ProfileTravelDnaBadge? dominant, List<ProfileTravelDnaBadge> topBadges, List<ProfileTravelDnaBadge> all
});


$ProfileTravelDnaBadgeCopyWith<$Res>? get dominant;

}
/// @nodoc
class _$ProfileTravelDnaCopyWithImpl<$Res>
    implements $ProfileTravelDnaCopyWith<$Res> {
  _$ProfileTravelDnaCopyWithImpl(this._self, this._then);

  final ProfileTravelDna _self;
  final $Res Function(ProfileTravelDna) _then;

/// Create a copy of ProfileTravelDna
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? dominant = freezed,Object? topBadges = null,Object? all = null,}) {
  return _then(ProfileTravelDna(
dominant: freezed == dominant ? _self.dominant : dominant // ignore: cast_nullable_to_non_nullable
as ProfileTravelDnaBadge?,topBadges: null == topBadges ? _self.topBadges : topBadges // ignore: cast_nullable_to_non_nullable
as List<ProfileTravelDnaBadge>,all: null == all ? _self.all : all // ignore: cast_nullable_to_non_nullable
as List<ProfileTravelDnaBadge>,
  ));
}
/// Create a copy of ProfileTravelDna
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProfileTravelDnaBadgeCopyWith<$Res>? get dominant {
    if (_self.dominant == null) {
    return null;
  }

  return $ProfileTravelDnaBadgeCopyWith<$Res>(_self.dominant!, (value) {
    return _then(_self.copyWith(dominant: value));
  });
}
}


/// Adds pattern-matching-related methods to [ProfileTravelDna].
extension ProfileTravelDnaPatterns on ProfileTravelDna {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProfileTravelDna value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProfileTravelDna() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProfileTravelDna value)  $default,){
final _that = this;
switch (_that) {
case _ProfileTravelDna():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProfileTravelDna value)?  $default,){
final _that = this;
switch (_that) {
case _ProfileTravelDna() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ProfileTravelDnaBadge? dominant,  List<ProfileTravelDnaBadge> topBadges,  List<ProfileTravelDnaBadge> all)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProfileTravelDna() when $default != null:
return $default(_that.dominant,_that.topBadges,_that.all);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ProfileTravelDnaBadge? dominant,  List<ProfileTravelDnaBadge> topBadges,  List<ProfileTravelDnaBadge> all)  $default,) {final _that = this;
switch (_that) {
case _ProfileTravelDna():
return $default(_that.dominant,_that.topBadges,_that.all);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ProfileTravelDnaBadge? dominant,  List<ProfileTravelDnaBadge> topBadges,  List<ProfileTravelDnaBadge> all)?  $default,) {final _that = this;
switch (_that) {
case _ProfileTravelDna() when $default != null:
return $default(_that.dominant,_that.topBadges,_that.all);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProfileTravelDna implements ProfileTravelDna {
  const _ProfileTravelDna({this.dominant, required  List<ProfileTravelDnaBadge> topBadges, required  List<ProfileTravelDnaBadge> all}): _topBadges = topBadges,_all = all;
  factory _ProfileTravelDna.fromJson(Map<String, dynamic> json) => _$ProfileTravelDnaFromJson(json);

@override final  ProfileTravelDnaBadge? dominant;
 final  List<ProfileTravelDnaBadge> _topBadges;
@override List<ProfileTravelDnaBadge> get topBadges {
  if (_topBadges is EqualUnmodifiableListView) return _topBadges;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_topBadges);
}

 final  List<ProfileTravelDnaBadge> _all;
@override List<ProfileTravelDnaBadge> get all {
  if (_all is EqualUnmodifiableListView) return _all;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_all);
}


/// Create a copy of ProfileTravelDna
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProfileTravelDnaCopyWith<_ProfileTravelDna> get copyWith => __$ProfileTravelDnaCopyWithImpl<_ProfileTravelDna>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProfileTravelDnaToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProfileTravelDna&&(identical(other.dominant, dominant) || other.dominant == dominant)&&const DeepCollectionEquality().equals(other.topBadges, _topBadges)&&const DeepCollectionEquality().equals(other.all, _all));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,dominant,const DeepCollectionEquality().hash(_topBadges),const DeepCollectionEquality().hash(_all));
}

@override
String toString() {
    return 'ProfileTravelDna(dominant: $dominant, topBadges: $topBadges, all: $all)';
}


}

/// @nodoc
abstract mixin class _$ProfileTravelDnaCopyWith<$Res> implements $ProfileTravelDnaCopyWith<$Res> {
  factory _$ProfileTravelDnaCopyWith(_ProfileTravelDna value, $Res Function(_ProfileTravelDna) _then) = __$ProfileTravelDnaCopyWithImpl;
@override @useResult
$Res call({
 ProfileTravelDnaBadge? dominant, List<ProfileTravelDnaBadge> topBadges, List<ProfileTravelDnaBadge> all
});


@override $ProfileTravelDnaBadgeCopyWith<$Res>? get dominant;

}
/// @nodoc
class __$ProfileTravelDnaCopyWithImpl<$Res>
    implements _$ProfileTravelDnaCopyWith<$Res> {
  __$ProfileTravelDnaCopyWithImpl(this._self, this._then);

  final _ProfileTravelDna _self;
  final $Res Function(_ProfileTravelDna) _then;

/// Create a copy of ProfileTravelDna
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? dominant = freezed,Object? topBadges = null,Object? all = null,}) {
  return _then(_ProfileTravelDna(
dominant: freezed == dominant ? _self.dominant : dominant // ignore: cast_nullable_to_non_nullable
as ProfileTravelDnaBadge?,topBadges: null == topBadges ? _self._topBadges : topBadges // ignore: cast_nullable_to_non_nullable
as List<ProfileTravelDnaBadge>,all: null == all ? _self._all : all // ignore: cast_nullable_to_non_nullable
as List<ProfileTravelDnaBadge>,
  ));
}

/// Create a copy of ProfileTravelDna
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProfileTravelDnaBadgeCopyWith<$Res>? get dominant {
    if (_self.dominant == null) {
    return null;
  }

  return $ProfileTravelDnaBadgeCopyWith<$Res>(_self.dominant!, (value) {
    return _then(_self.copyWith(dominant: value));
  });
}
}


/// @nodoc
mixin _$ProfileTravelDnaBadge {

 String get type; String get name; String get icon; String get description; int get score; int get tripTypeCount; int get activityCount; String get createdAt; String get updatedAt;
/// Create a copy of ProfileTravelDnaBadge
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileTravelDnaBadgeCopyWith<ProfileTravelDnaBadge> get copyWith => _$ProfileTravelDnaBadgeCopyWithImpl<ProfileTravelDnaBadge>(this as ProfileTravelDnaBadge, _$identity);

  /// Serializes this ProfileTravelDnaBadge to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ProfileTravelDnaBadge;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileTravelDnaBadge&&(identical(other.type, _this.type) || other.type == _this.type)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.icon, _this.icon) || other.icon == _this.icon)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.score, _this.score) || other.score == _this.score)&&(identical(other.tripTypeCount, _this.tripTypeCount) || other.tripTypeCount == _this.tripTypeCount)&&(identical(other.activityCount, _this.activityCount) || other.activityCount == _this.activityCount)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.updatedAt, _this.updatedAt) || other.updatedAt == _this.updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ProfileTravelDnaBadge;
  return Object.hash(runtimeType,_this.type,_this.name,_this.icon,_this.description,_this.score,_this.tripTypeCount,_this.activityCount,_this.createdAt,_this.updatedAt);
}

@override
String toString() {
  final _this = this as ProfileTravelDnaBadge;
  return 'ProfileTravelDnaBadge(type: ${_this.type}, name: ${_this.name}, icon: ${_this.icon}, description: ${_this.description}, score: ${_this.score}, tripTypeCount: ${_this.tripTypeCount}, activityCount: ${_this.activityCount}, createdAt: ${_this.createdAt}, updatedAt: ${_this.updatedAt})';
}


}

/// @nodoc
abstract mixin class $ProfileTravelDnaBadgeCopyWith<$Res>  {
  factory $ProfileTravelDnaBadgeCopyWith(ProfileTravelDnaBadge value, $Res Function(ProfileTravelDnaBadge) _then) = _$ProfileTravelDnaBadgeCopyWithImpl;
@useResult
$Res call({
 String type, String name, String icon, String description, int score, int tripTypeCount, int activityCount, String createdAt, String updatedAt
});




}
/// @nodoc
class _$ProfileTravelDnaBadgeCopyWithImpl<$Res>
    implements $ProfileTravelDnaBadgeCopyWith<$Res> {
  _$ProfileTravelDnaBadgeCopyWithImpl(this._self, this._then);

  final ProfileTravelDnaBadge _self;
  final $Res Function(ProfileTravelDnaBadge) _then;

/// Create a copy of ProfileTravelDnaBadge
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? name = null,Object? icon = null,Object? description = null,Object? score = null,Object? tripTypeCount = null,Object? activityCount = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(ProfileTravelDnaBadge(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as int,tripTypeCount: null == tripTypeCount ? _self.tripTypeCount : tripTypeCount // ignore: cast_nullable_to_non_nullable
as int,activityCount: null == activityCount ? _self.activityCount : activityCount // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ProfileTravelDnaBadge].
extension ProfileTravelDnaBadgePatterns on ProfileTravelDnaBadge {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProfileTravelDnaBadge value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProfileTravelDnaBadge() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProfileTravelDnaBadge value)  $default,){
final _that = this;
switch (_that) {
case _ProfileTravelDnaBadge():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProfileTravelDnaBadge value)?  $default,){
final _that = this;
switch (_that) {
case _ProfileTravelDnaBadge() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String type,  String name,  String icon,  String description,  int score,  int tripTypeCount,  int activityCount,  String createdAt,  String updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProfileTravelDnaBadge() when $default != null:
return $default(_that.type,_that.name,_that.icon,_that.description,_that.score,_that.tripTypeCount,_that.activityCount,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String type,  String name,  String icon,  String description,  int score,  int tripTypeCount,  int activityCount,  String createdAt,  String updatedAt)  $default,) {final _that = this;
switch (_that) {
case _ProfileTravelDnaBadge():
return $default(_that.type,_that.name,_that.icon,_that.description,_that.score,_that.tripTypeCount,_that.activityCount,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String type,  String name,  String icon,  String description,  int score,  int tripTypeCount,  int activityCount,  String createdAt,  String updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _ProfileTravelDnaBadge() when $default != null:
return $default(_that.type,_that.name,_that.icon,_that.description,_that.score,_that.tripTypeCount,_that.activityCount,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProfileTravelDnaBadge implements ProfileTravelDnaBadge {
  const _ProfileTravelDnaBadge({required this.type, required this.name, required this.icon, required this.description, required this.score, required this.tripTypeCount, required this.activityCount, required this.createdAt, required this.updatedAt});
  factory _ProfileTravelDnaBadge.fromJson(Map<String, dynamic> json) => _$ProfileTravelDnaBadgeFromJson(json);

@override final  String type;
@override final  String name;
@override final  String icon;
@override final  String description;
@override final  int score;
@override final  int tripTypeCount;
@override final  int activityCount;
@override final  String createdAt;
@override final  String updatedAt;

/// Create a copy of ProfileTravelDnaBadge
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProfileTravelDnaBadgeCopyWith<_ProfileTravelDnaBadge> get copyWith => __$ProfileTravelDnaBadgeCopyWithImpl<_ProfileTravelDnaBadge>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProfileTravelDnaBadgeToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProfileTravelDnaBadge&&(identical(other.type, type) || other.type == type)&&(identical(other.name, name) || other.name == name)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.description, description) || other.description == description)&&(identical(other.score, score) || other.score == score)&&(identical(other.tripTypeCount, tripTypeCount) || other.tripTypeCount == tripTypeCount)&&(identical(other.activityCount, activityCount) || other.activityCount == activityCount)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,type,name,icon,description,score,tripTypeCount,activityCount,createdAt,updatedAt);
}

@override
String toString() {
    return 'ProfileTravelDnaBadge(type: $type, name: $name, icon: $icon, description: $description, score: $score, tripTypeCount: $tripTypeCount, activityCount: $activityCount, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$ProfileTravelDnaBadgeCopyWith<$Res> implements $ProfileTravelDnaBadgeCopyWith<$Res> {
  factory _$ProfileTravelDnaBadgeCopyWith(_ProfileTravelDnaBadge value, $Res Function(_ProfileTravelDnaBadge) _then) = __$ProfileTravelDnaBadgeCopyWithImpl;
@override @useResult
$Res call({
 String type, String name, String icon, String description, int score, int tripTypeCount, int activityCount, String createdAt, String updatedAt
});




}
/// @nodoc
class __$ProfileTravelDnaBadgeCopyWithImpl<$Res>
    implements _$ProfileTravelDnaBadgeCopyWith<$Res> {
  __$ProfileTravelDnaBadgeCopyWithImpl(this._self, this._then);

  final _ProfileTravelDnaBadge _self;
  final $Res Function(_ProfileTravelDnaBadge) _then;

/// Create a copy of ProfileTravelDnaBadge
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? name = null,Object? icon = null,Object? description = null,Object? score = null,Object? tripTypeCount = null,Object? activityCount = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_ProfileTravelDnaBadge(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as int,tripTypeCount: null == tripTypeCount ? _self.tripTypeCount : tripTypeCount // ignore: cast_nullable_to_non_nullable
as int,activityCount: null == activityCount ? _self.activityCount : activityCount // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$ProfileShowcaseTrip {

 String get id; String get name; String? get coverImageUrl; String get status; String get startDate; String get endDate; String? get budgetLevel; int get maxMembers; int get memberCount; int get totalActivities; int get completedActivities; List<String> get highlights;
/// Create a copy of ProfileShowcaseTrip
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileShowcaseTripCopyWith<ProfileShowcaseTrip> get copyWith => _$ProfileShowcaseTripCopyWithImpl<ProfileShowcaseTrip>(this as ProfileShowcaseTrip, _$identity);

  /// Serializes this ProfileShowcaseTrip to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ProfileShowcaseTrip;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileShowcaseTrip&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.coverImageUrl, _this.coverImageUrl) || other.coverImageUrl == _this.coverImageUrl)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.startDate, _this.startDate) || other.startDate == _this.startDate)&&(identical(other.endDate, _this.endDate) || other.endDate == _this.endDate)&&(identical(other.budgetLevel, _this.budgetLevel) || other.budgetLevel == _this.budgetLevel)&&(identical(other.maxMembers, _this.maxMembers) || other.maxMembers == _this.maxMembers)&&(identical(other.memberCount, _this.memberCount) || other.memberCount == _this.memberCount)&&(identical(other.totalActivities, _this.totalActivities) || other.totalActivities == _this.totalActivities)&&(identical(other.completedActivities, _this.completedActivities) || other.completedActivities == _this.completedActivities)&&const DeepCollectionEquality().equals(other.highlights, _this.highlights));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ProfileShowcaseTrip;
  return Object.hash(runtimeType,_this.id,_this.name,_this.coverImageUrl,_this.status,_this.startDate,_this.endDate,_this.budgetLevel,_this.maxMembers,_this.memberCount,_this.totalActivities,_this.completedActivities,const DeepCollectionEquality().hash(_this.highlights));
}

@override
String toString() {
  final _this = this as ProfileShowcaseTrip;
  return 'ProfileShowcaseTrip(id: ${_this.id}, name: ${_this.name}, coverImageUrl: ${_this.coverImageUrl}, status: ${_this.status}, startDate: ${_this.startDate}, endDate: ${_this.endDate}, budgetLevel: ${_this.budgetLevel}, maxMembers: ${_this.maxMembers}, memberCount: ${_this.memberCount}, totalActivities: ${_this.totalActivities}, completedActivities: ${_this.completedActivities}, highlights: ${_this.highlights})';
}


}

/// @nodoc
abstract mixin class $ProfileShowcaseTripCopyWith<$Res>  {
  factory $ProfileShowcaseTripCopyWith(ProfileShowcaseTrip value, $Res Function(ProfileShowcaseTrip) _then) = _$ProfileShowcaseTripCopyWithImpl;
@useResult
$Res call({
 String id, String name, String? coverImageUrl, String status, String startDate, String endDate, String? budgetLevel, int maxMembers, int memberCount, int totalActivities, int completedActivities, List<String> highlights
});




}
/// @nodoc
class _$ProfileShowcaseTripCopyWithImpl<$Res>
    implements $ProfileShowcaseTripCopyWith<$Res> {
  _$ProfileShowcaseTripCopyWithImpl(this._self, this._then);

  final ProfileShowcaseTrip _self;
  final $Res Function(ProfileShowcaseTrip) _then;

/// Create a copy of ProfileShowcaseTrip
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? coverImageUrl = freezed,Object? status = null,Object? startDate = null,Object? endDate = null,Object? budgetLevel = freezed,Object? maxMembers = null,Object? memberCount = null,Object? totalActivities = null,Object? completedActivities = null,Object? highlights = null,}) {
  return _then(ProfileShowcaseTrip(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,coverImageUrl: freezed == coverImageUrl ? _self.coverImageUrl : coverImageUrl // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as String,endDate: null == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as String,budgetLevel: freezed == budgetLevel ? _self.budgetLevel : budgetLevel // ignore: cast_nullable_to_non_nullable
as String?,maxMembers: null == maxMembers ? _self.maxMembers : maxMembers // ignore: cast_nullable_to_non_nullable
as int,memberCount: null == memberCount ? _self.memberCount : memberCount // ignore: cast_nullable_to_non_nullable
as int,totalActivities: null == totalActivities ? _self.totalActivities : totalActivities // ignore: cast_nullable_to_non_nullable
as int,completedActivities: null == completedActivities ? _self.completedActivities : completedActivities // ignore: cast_nullable_to_non_nullable
as int,highlights: null == highlights ? _self.highlights : highlights // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [ProfileShowcaseTrip].
extension ProfileShowcaseTripPatterns on ProfileShowcaseTrip {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProfileShowcaseTrip value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProfileShowcaseTrip() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProfileShowcaseTrip value)  $default,){
final _that = this;
switch (_that) {
case _ProfileShowcaseTrip():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProfileShowcaseTrip value)?  $default,){
final _that = this;
switch (_that) {
case _ProfileShowcaseTrip() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String? coverImageUrl,  String status,  String startDate,  String endDate,  String? budgetLevel,  int maxMembers,  int memberCount,  int totalActivities,  int completedActivities,  List<String> highlights)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProfileShowcaseTrip() when $default != null:
return $default(_that.id,_that.name,_that.coverImageUrl,_that.status,_that.startDate,_that.endDate,_that.budgetLevel,_that.maxMembers,_that.memberCount,_that.totalActivities,_that.completedActivities,_that.highlights);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String? coverImageUrl,  String status,  String startDate,  String endDate,  String? budgetLevel,  int maxMembers,  int memberCount,  int totalActivities,  int completedActivities,  List<String> highlights)  $default,) {final _that = this;
switch (_that) {
case _ProfileShowcaseTrip():
return $default(_that.id,_that.name,_that.coverImageUrl,_that.status,_that.startDate,_that.endDate,_that.budgetLevel,_that.maxMembers,_that.memberCount,_that.totalActivities,_that.completedActivities,_that.highlights);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String? coverImageUrl,  String status,  String startDate,  String endDate,  String? budgetLevel,  int maxMembers,  int memberCount,  int totalActivities,  int completedActivities,  List<String> highlights)?  $default,) {final _that = this;
switch (_that) {
case _ProfileShowcaseTrip() when $default != null:
return $default(_that.id,_that.name,_that.coverImageUrl,_that.status,_that.startDate,_that.endDate,_that.budgetLevel,_that.maxMembers,_that.memberCount,_that.totalActivities,_that.completedActivities,_that.highlights);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProfileShowcaseTrip implements ProfileShowcaseTrip {
  const _ProfileShowcaseTrip({required this.id, required this.name, this.coverImageUrl, required this.status, required this.startDate, required this.endDate, this.budgetLevel, required this.maxMembers, required this.memberCount, required this.totalActivities, required this.completedActivities, required  List<String> highlights}): _highlights = highlights;
  factory _ProfileShowcaseTrip.fromJson(Map<String, dynamic> json) => _$ProfileShowcaseTripFromJson(json);

@override final  String id;
@override final  String name;
@override final  String? coverImageUrl;
@override final  String status;
@override final  String startDate;
@override final  String endDate;
@override final  String? budgetLevel;
@override final  int maxMembers;
@override final  int memberCount;
@override final  int totalActivities;
@override final  int completedActivities;
 final  List<String> _highlights;
@override List<String> get highlights {
  if (_highlights is EqualUnmodifiableListView) return _highlights;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_highlights);
}


/// Create a copy of ProfileShowcaseTrip
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProfileShowcaseTripCopyWith<_ProfileShowcaseTrip> get copyWith => __$ProfileShowcaseTripCopyWithImpl<_ProfileShowcaseTrip>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProfileShowcaseTripToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProfileShowcaseTrip&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.coverImageUrl, coverImageUrl) || other.coverImageUrl == coverImageUrl)&&(identical(other.status, status) || other.status == status)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.budgetLevel, budgetLevel) || other.budgetLevel == budgetLevel)&&(identical(other.maxMembers, maxMembers) || other.maxMembers == maxMembers)&&(identical(other.memberCount, memberCount) || other.memberCount == memberCount)&&(identical(other.totalActivities, totalActivities) || other.totalActivities == totalActivities)&&(identical(other.completedActivities, completedActivities) || other.completedActivities == completedActivities)&&const DeepCollectionEquality().equals(other.highlights, _highlights));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,name,coverImageUrl,status,startDate,endDate,budgetLevel,maxMembers,memberCount,totalActivities,completedActivities,const DeepCollectionEquality().hash(_highlights));
}

@override
String toString() {
    return 'ProfileShowcaseTrip(id: $id, name: $name, coverImageUrl: $coverImageUrl, status: $status, startDate: $startDate, endDate: $endDate, budgetLevel: $budgetLevel, maxMembers: $maxMembers, memberCount: $memberCount, totalActivities: $totalActivities, completedActivities: $completedActivities, highlights: $highlights)';
}


}

/// @nodoc
abstract mixin class _$ProfileShowcaseTripCopyWith<$Res> implements $ProfileShowcaseTripCopyWith<$Res> {
  factory _$ProfileShowcaseTripCopyWith(_ProfileShowcaseTrip value, $Res Function(_ProfileShowcaseTrip) _then) = __$ProfileShowcaseTripCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String? coverImageUrl, String status, String startDate, String endDate, String? budgetLevel, int maxMembers, int memberCount, int totalActivities, int completedActivities, List<String> highlights
});




}
/// @nodoc
class __$ProfileShowcaseTripCopyWithImpl<$Res>
    implements _$ProfileShowcaseTripCopyWith<$Res> {
  __$ProfileShowcaseTripCopyWithImpl(this._self, this._then);

  final _ProfileShowcaseTrip _self;
  final $Res Function(_ProfileShowcaseTrip) _then;

/// Create a copy of ProfileShowcaseTrip
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? coverImageUrl = freezed,Object? status = null,Object? startDate = null,Object? endDate = null,Object? budgetLevel = freezed,Object? maxMembers = null,Object? memberCount = null,Object? totalActivities = null,Object? completedActivities = null,Object? highlights = null,}) {
  return _then(_ProfileShowcaseTrip(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,coverImageUrl: freezed == coverImageUrl ? _self.coverImageUrl : coverImageUrl // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as String,endDate: null == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as String,budgetLevel: freezed == budgetLevel ? _self.budgetLevel : budgetLevel // ignore: cast_nullable_to_non_nullable
as String?,maxMembers: null == maxMembers ? _self.maxMembers : maxMembers // ignore: cast_nullable_to_non_nullable
as int,memberCount: null == memberCount ? _self.memberCount : memberCount // ignore: cast_nullable_to_non_nullable
as int,totalActivities: null == totalActivities ? _self.totalActivities : totalActivities // ignore: cast_nullable_to_non_nullable
as int,completedActivities: null == completedActivities ? _self.completedActivities : completedActivities // ignore: cast_nullable_to_non_nullable
as int,highlights: null == highlights ? _self._highlights : highlights // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}


/// @nodoc
mixin _$ProfileShowcaseMemories {

 int get totalCount; List<ProfileShowcaseMemory> get items;
/// Create a copy of ProfileShowcaseMemories
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileShowcaseMemoriesCopyWith<ProfileShowcaseMemories> get copyWith => _$ProfileShowcaseMemoriesCopyWithImpl<ProfileShowcaseMemories>(this as ProfileShowcaseMemories, _$identity);

  /// Serializes this ProfileShowcaseMemories to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ProfileShowcaseMemories;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileShowcaseMemories&&(identical(other.totalCount, _this.totalCount) || other.totalCount == _this.totalCount)&&const DeepCollectionEquality().equals(other.items, _this.items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ProfileShowcaseMemories;
  return Object.hash(runtimeType,_this.totalCount,const DeepCollectionEquality().hash(_this.items));
}

@override
String toString() {
  final _this = this as ProfileShowcaseMemories;
  return 'ProfileShowcaseMemories(totalCount: ${_this.totalCount}, items: ${_this.items})';
}


}

/// @nodoc
abstract mixin class $ProfileShowcaseMemoriesCopyWith<$Res>  {
  factory $ProfileShowcaseMemoriesCopyWith(ProfileShowcaseMemories value, $Res Function(ProfileShowcaseMemories) _then) = _$ProfileShowcaseMemoriesCopyWithImpl;
@useResult
$Res call({
 int totalCount, List<ProfileShowcaseMemory> items
});




}
/// @nodoc
class _$ProfileShowcaseMemoriesCopyWithImpl<$Res>
    implements $ProfileShowcaseMemoriesCopyWith<$Res> {
  _$ProfileShowcaseMemoriesCopyWithImpl(this._self, this._then);

  final ProfileShowcaseMemories _self;
  final $Res Function(ProfileShowcaseMemories) _then;

/// Create a copy of ProfileShowcaseMemories
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalCount = null,Object? items = null,}) {
  return _then(ProfileShowcaseMemories(
totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<ProfileShowcaseMemory>,
  ));
}

}


/// Adds pattern-matching-related methods to [ProfileShowcaseMemories].
extension ProfileShowcaseMemoriesPatterns on ProfileShowcaseMemories {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProfileShowcaseMemories value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProfileShowcaseMemories() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProfileShowcaseMemories value)  $default,){
final _that = this;
switch (_that) {
case _ProfileShowcaseMemories():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProfileShowcaseMemories value)?  $default,){
final _that = this;
switch (_that) {
case _ProfileShowcaseMemories() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int totalCount,  List<ProfileShowcaseMemory> items)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProfileShowcaseMemories() when $default != null:
return $default(_that.totalCount,_that.items);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int totalCount,  List<ProfileShowcaseMemory> items)  $default,) {final _that = this;
switch (_that) {
case _ProfileShowcaseMemories():
return $default(_that.totalCount,_that.items);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int totalCount,  List<ProfileShowcaseMemory> items)?  $default,) {final _that = this;
switch (_that) {
case _ProfileShowcaseMemories() when $default != null:
return $default(_that.totalCount,_that.items);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProfileShowcaseMemories implements ProfileShowcaseMemories {
  const _ProfileShowcaseMemories({required this.totalCount, required  List<ProfileShowcaseMemory> items}): _items = items;
  factory _ProfileShowcaseMemories.fromJson(Map<String, dynamic> json) => _$ProfileShowcaseMemoriesFromJson(json);

@override final  int totalCount;
 final  List<ProfileShowcaseMemory> _items;
@override List<ProfileShowcaseMemory> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}


/// Create a copy of ProfileShowcaseMemories
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProfileShowcaseMemoriesCopyWith<_ProfileShowcaseMemories> get copyWith => __$ProfileShowcaseMemoriesCopyWithImpl<_ProfileShowcaseMemories>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProfileShowcaseMemoriesToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProfileShowcaseMemories&&(identical(other.totalCount, totalCount) || other.totalCount == totalCount)&&const DeepCollectionEquality().equals(other.items, _items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,totalCount,const DeepCollectionEquality().hash(_items));
}

@override
String toString() {
    return 'ProfileShowcaseMemories(totalCount: $totalCount, items: $items)';
}


}

/// @nodoc
abstract mixin class _$ProfileShowcaseMemoriesCopyWith<$Res> implements $ProfileShowcaseMemoriesCopyWith<$Res> {
  factory _$ProfileShowcaseMemoriesCopyWith(_ProfileShowcaseMemories value, $Res Function(_ProfileShowcaseMemories) _then) = __$ProfileShowcaseMemoriesCopyWithImpl;
@override @useResult
$Res call({
 int totalCount, List<ProfileShowcaseMemory> items
});




}
/// @nodoc
class __$ProfileShowcaseMemoriesCopyWithImpl<$Res>
    implements _$ProfileShowcaseMemoriesCopyWith<$Res> {
  __$ProfileShowcaseMemoriesCopyWithImpl(this._self, this._then);

  final _ProfileShowcaseMemories _self;
  final $Res Function(_ProfileShowcaseMemories) _then;

/// Create a copy of ProfileShowcaseMemories
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalCount = null,Object? items = null,}) {
  return _then(_ProfileShowcaseMemories(
totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<ProfileShowcaseMemory>,
  ));
}


}


/// @nodoc
mixin _$ProfileShowcaseMemory {

 String get id; String get imageUrl;
/// Create a copy of ProfileShowcaseMemory
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileShowcaseMemoryCopyWith<ProfileShowcaseMemory> get copyWith => _$ProfileShowcaseMemoryCopyWithImpl<ProfileShowcaseMemory>(this as ProfileShowcaseMemory, _$identity);

  /// Serializes this ProfileShowcaseMemory to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ProfileShowcaseMemory;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileShowcaseMemory&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.imageUrl, _this.imageUrl) || other.imageUrl == _this.imageUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ProfileShowcaseMemory;
  return Object.hash(runtimeType,_this.id,_this.imageUrl);
}

@override
String toString() {
  final _this = this as ProfileShowcaseMemory;
  return 'ProfileShowcaseMemory(id: ${_this.id}, imageUrl: ${_this.imageUrl})';
}


}

/// @nodoc
abstract mixin class $ProfileShowcaseMemoryCopyWith<$Res>  {
  factory $ProfileShowcaseMemoryCopyWith(ProfileShowcaseMemory value, $Res Function(ProfileShowcaseMemory) _then) = _$ProfileShowcaseMemoryCopyWithImpl;
@useResult
$Res call({
 String id, String imageUrl
});




}
/// @nodoc
class _$ProfileShowcaseMemoryCopyWithImpl<$Res>
    implements $ProfileShowcaseMemoryCopyWith<$Res> {
  _$ProfileShowcaseMemoryCopyWithImpl(this._self, this._then);

  final ProfileShowcaseMemory _self;
  final $Res Function(ProfileShowcaseMemory) _then;

/// Create a copy of ProfileShowcaseMemory
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? imageUrl = null,}) {
  return _then(ProfileShowcaseMemory(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ProfileShowcaseMemory].
extension ProfileShowcaseMemoryPatterns on ProfileShowcaseMemory {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProfileShowcaseMemory value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProfileShowcaseMemory() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProfileShowcaseMemory value)  $default,){
final _that = this;
switch (_that) {
case _ProfileShowcaseMemory():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProfileShowcaseMemory value)?  $default,){
final _that = this;
switch (_that) {
case _ProfileShowcaseMemory() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String imageUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProfileShowcaseMemory() when $default != null:
return $default(_that.id,_that.imageUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String imageUrl)  $default,) {final _that = this;
switch (_that) {
case _ProfileShowcaseMemory():
return $default(_that.id,_that.imageUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String imageUrl)?  $default,) {final _that = this;
switch (_that) {
case _ProfileShowcaseMemory() when $default != null:
return $default(_that.id,_that.imageUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProfileShowcaseMemory implements ProfileShowcaseMemory {
  const _ProfileShowcaseMemory({required this.id, required this.imageUrl});
  factory _ProfileShowcaseMemory.fromJson(Map<String, dynamic> json) => _$ProfileShowcaseMemoryFromJson(json);

@override final  String id;
@override final  String imageUrl;

/// Create a copy of ProfileShowcaseMemory
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProfileShowcaseMemoryCopyWith<_ProfileShowcaseMemory> get copyWith => __$ProfileShowcaseMemoryCopyWithImpl<_ProfileShowcaseMemory>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProfileShowcaseMemoryToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProfileShowcaseMemory&&(identical(other.id, id) || other.id == id)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,imageUrl);
}

@override
String toString() {
    return 'ProfileShowcaseMemory(id: $id, imageUrl: $imageUrl)';
}


}

/// @nodoc
abstract mixin class _$ProfileShowcaseMemoryCopyWith<$Res> implements $ProfileShowcaseMemoryCopyWith<$Res> {
  factory _$ProfileShowcaseMemoryCopyWith(_ProfileShowcaseMemory value, $Res Function(_ProfileShowcaseMemory) _then) = __$ProfileShowcaseMemoryCopyWithImpl;
@override @useResult
$Res call({
 String id, String imageUrl
});




}
/// @nodoc
class __$ProfileShowcaseMemoryCopyWithImpl<$Res>
    implements _$ProfileShowcaseMemoryCopyWith<$Res> {
  __$ProfileShowcaseMemoryCopyWithImpl(this._self, this._then);

  final _ProfileShowcaseMemory _self;
  final $Res Function(_ProfileShowcaseMemory) _then;

/// Create a copy of ProfileShowcaseMemory
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? imageUrl = null,}) {
  return _then(_ProfileShowcaseMemory(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$ProfileShowcaseSavedPlaces {

 int get count; List<ProfileShowcaseSavedPlace> get items;
/// Create a copy of ProfileShowcaseSavedPlaces
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileShowcaseSavedPlacesCopyWith<ProfileShowcaseSavedPlaces> get copyWith => _$ProfileShowcaseSavedPlacesCopyWithImpl<ProfileShowcaseSavedPlaces>(this as ProfileShowcaseSavedPlaces, _$identity);

  /// Serializes this ProfileShowcaseSavedPlaces to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ProfileShowcaseSavedPlaces;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileShowcaseSavedPlaces&&(identical(other.count, _this.count) || other.count == _this.count)&&const DeepCollectionEquality().equals(other.items, _this.items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ProfileShowcaseSavedPlaces;
  return Object.hash(runtimeType,_this.count,const DeepCollectionEquality().hash(_this.items));
}

@override
String toString() {
  final _this = this as ProfileShowcaseSavedPlaces;
  return 'ProfileShowcaseSavedPlaces(count: ${_this.count}, items: ${_this.items})';
}


}

/// @nodoc
abstract mixin class $ProfileShowcaseSavedPlacesCopyWith<$Res>  {
  factory $ProfileShowcaseSavedPlacesCopyWith(ProfileShowcaseSavedPlaces value, $Res Function(ProfileShowcaseSavedPlaces) _then) = _$ProfileShowcaseSavedPlacesCopyWithImpl;
@useResult
$Res call({
 int count, List<ProfileShowcaseSavedPlace> items
});




}
/// @nodoc
class _$ProfileShowcaseSavedPlacesCopyWithImpl<$Res>
    implements $ProfileShowcaseSavedPlacesCopyWith<$Res> {
  _$ProfileShowcaseSavedPlacesCopyWithImpl(this._self, this._then);

  final ProfileShowcaseSavedPlaces _self;
  final $Res Function(ProfileShowcaseSavedPlaces) _then;

/// Create a copy of ProfileShowcaseSavedPlaces
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? count = null,Object? items = null,}) {
  return _then(ProfileShowcaseSavedPlaces(
count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<ProfileShowcaseSavedPlace>,
  ));
}

}


/// Adds pattern-matching-related methods to [ProfileShowcaseSavedPlaces].
extension ProfileShowcaseSavedPlacesPatterns on ProfileShowcaseSavedPlaces {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProfileShowcaseSavedPlaces value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProfileShowcaseSavedPlaces() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProfileShowcaseSavedPlaces value)  $default,){
final _that = this;
switch (_that) {
case _ProfileShowcaseSavedPlaces():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProfileShowcaseSavedPlaces value)?  $default,){
final _that = this;
switch (_that) {
case _ProfileShowcaseSavedPlaces() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int count,  List<ProfileShowcaseSavedPlace> items)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProfileShowcaseSavedPlaces() when $default != null:
return $default(_that.count,_that.items);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int count,  List<ProfileShowcaseSavedPlace> items)  $default,) {final _that = this;
switch (_that) {
case _ProfileShowcaseSavedPlaces():
return $default(_that.count,_that.items);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int count,  List<ProfileShowcaseSavedPlace> items)?  $default,) {final _that = this;
switch (_that) {
case _ProfileShowcaseSavedPlaces() when $default != null:
return $default(_that.count,_that.items);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProfileShowcaseSavedPlaces implements ProfileShowcaseSavedPlaces {
  const _ProfileShowcaseSavedPlaces({required this.count, required  List<ProfileShowcaseSavedPlace> items}): _items = items;
  factory _ProfileShowcaseSavedPlaces.fromJson(Map<String, dynamic> json) => _$ProfileShowcaseSavedPlacesFromJson(json);

@override final  int count;
 final  List<ProfileShowcaseSavedPlace> _items;
@override List<ProfileShowcaseSavedPlace> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}


/// Create a copy of ProfileShowcaseSavedPlaces
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProfileShowcaseSavedPlacesCopyWith<_ProfileShowcaseSavedPlaces> get copyWith => __$ProfileShowcaseSavedPlacesCopyWithImpl<_ProfileShowcaseSavedPlaces>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProfileShowcaseSavedPlacesToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProfileShowcaseSavedPlaces&&(identical(other.count, count) || other.count == count)&&const DeepCollectionEquality().equals(other.items, _items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,count,const DeepCollectionEquality().hash(_items));
}

@override
String toString() {
    return 'ProfileShowcaseSavedPlaces(count: $count, items: $items)';
}


}

/// @nodoc
abstract mixin class _$ProfileShowcaseSavedPlacesCopyWith<$Res> implements $ProfileShowcaseSavedPlacesCopyWith<$Res> {
  factory _$ProfileShowcaseSavedPlacesCopyWith(_ProfileShowcaseSavedPlaces value, $Res Function(_ProfileShowcaseSavedPlaces) _then) = __$ProfileShowcaseSavedPlacesCopyWithImpl;
@override @useResult
$Res call({
 int count, List<ProfileShowcaseSavedPlace> items
});




}
/// @nodoc
class __$ProfileShowcaseSavedPlacesCopyWithImpl<$Res>
    implements _$ProfileShowcaseSavedPlacesCopyWith<$Res> {
  __$ProfileShowcaseSavedPlacesCopyWithImpl(this._self, this._then);

  final _ProfileShowcaseSavedPlaces _self;
  final $Res Function(_ProfileShowcaseSavedPlaces) _then;

/// Create a copy of ProfileShowcaseSavedPlaces
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? count = null,Object? items = null,}) {
  return _then(_ProfileShowcaseSavedPlaces(
count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<ProfileShowcaseSavedPlace>,
  ));
}


}


/// @nodoc
mixin _$ProfileShowcaseSavedPlace {

 String get id; String get placeId; String get name; String get city; String get country; String get category; String? get coverImageUrl;
/// Create a copy of ProfileShowcaseSavedPlace
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileShowcaseSavedPlaceCopyWith<ProfileShowcaseSavedPlace> get copyWith => _$ProfileShowcaseSavedPlaceCopyWithImpl<ProfileShowcaseSavedPlace>(this as ProfileShowcaseSavedPlace, _$identity);

  /// Serializes this ProfileShowcaseSavedPlace to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ProfileShowcaseSavedPlace;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileShowcaseSavedPlace&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.placeId, _this.placeId) || other.placeId == _this.placeId)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.city, _this.city) || other.city == _this.city)&&(identical(other.country, _this.country) || other.country == _this.country)&&(identical(other.category, _this.category) || other.category == _this.category)&&(identical(other.coverImageUrl, _this.coverImageUrl) || other.coverImageUrl == _this.coverImageUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ProfileShowcaseSavedPlace;
  return Object.hash(runtimeType,_this.id,_this.placeId,_this.name,_this.city,_this.country,_this.category,_this.coverImageUrl);
}

@override
String toString() {
  final _this = this as ProfileShowcaseSavedPlace;
  return 'ProfileShowcaseSavedPlace(id: ${_this.id}, placeId: ${_this.placeId}, name: ${_this.name}, city: ${_this.city}, country: ${_this.country}, category: ${_this.category}, coverImageUrl: ${_this.coverImageUrl})';
}


}

/// @nodoc
abstract mixin class $ProfileShowcaseSavedPlaceCopyWith<$Res>  {
  factory $ProfileShowcaseSavedPlaceCopyWith(ProfileShowcaseSavedPlace value, $Res Function(ProfileShowcaseSavedPlace) _then) = _$ProfileShowcaseSavedPlaceCopyWithImpl;
@useResult
$Res call({
 String id, String placeId, String name, String city, String country, String category, String? coverImageUrl
});




}
/// @nodoc
class _$ProfileShowcaseSavedPlaceCopyWithImpl<$Res>
    implements $ProfileShowcaseSavedPlaceCopyWith<$Res> {
  _$ProfileShowcaseSavedPlaceCopyWithImpl(this._self, this._then);

  final ProfileShowcaseSavedPlace _self;
  final $Res Function(ProfileShowcaseSavedPlace) _then;

/// Create a copy of ProfileShowcaseSavedPlace
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? placeId = null,Object? name = null,Object? city = null,Object? country = null,Object? category = null,Object? coverImageUrl = freezed,}) {
  return _then(ProfileShowcaseSavedPlace(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,placeId: null == placeId ? _self.placeId : placeId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,country: null == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,coverImageUrl: freezed == coverImageUrl ? _self.coverImageUrl : coverImageUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ProfileShowcaseSavedPlace].
extension ProfileShowcaseSavedPlacePatterns on ProfileShowcaseSavedPlace {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProfileShowcaseSavedPlace value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProfileShowcaseSavedPlace() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProfileShowcaseSavedPlace value)  $default,){
final _that = this;
switch (_that) {
case _ProfileShowcaseSavedPlace():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProfileShowcaseSavedPlace value)?  $default,){
final _that = this;
switch (_that) {
case _ProfileShowcaseSavedPlace() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String placeId,  String name,  String city,  String country,  String category,  String? coverImageUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProfileShowcaseSavedPlace() when $default != null:
return $default(_that.id,_that.placeId,_that.name,_that.city,_that.country,_that.category,_that.coverImageUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String placeId,  String name,  String city,  String country,  String category,  String? coverImageUrl)  $default,) {final _that = this;
switch (_that) {
case _ProfileShowcaseSavedPlace():
return $default(_that.id,_that.placeId,_that.name,_that.city,_that.country,_that.category,_that.coverImageUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String placeId,  String name,  String city,  String country,  String category,  String? coverImageUrl)?  $default,) {final _that = this;
switch (_that) {
case _ProfileShowcaseSavedPlace() when $default != null:
return $default(_that.id,_that.placeId,_that.name,_that.city,_that.country,_that.category,_that.coverImageUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProfileShowcaseSavedPlace implements ProfileShowcaseSavedPlace {
  const _ProfileShowcaseSavedPlace({required this.id, required this.placeId, required this.name, required this.city, required this.country, required this.category, this.coverImageUrl});
  factory _ProfileShowcaseSavedPlace.fromJson(Map<String, dynamic> json) => _$ProfileShowcaseSavedPlaceFromJson(json);

@override final  String id;
@override final  String placeId;
@override final  String name;
@override final  String city;
@override final  String country;
@override final  String category;
@override final  String? coverImageUrl;

/// Create a copy of ProfileShowcaseSavedPlace
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProfileShowcaseSavedPlaceCopyWith<_ProfileShowcaseSavedPlace> get copyWith => __$ProfileShowcaseSavedPlaceCopyWithImpl<_ProfileShowcaseSavedPlace>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProfileShowcaseSavedPlaceToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProfileShowcaseSavedPlace&&(identical(other.id, id) || other.id == id)&&(identical(other.placeId, placeId) || other.placeId == placeId)&&(identical(other.name, name) || other.name == name)&&(identical(other.city, city) || other.city == city)&&(identical(other.country, country) || other.country == country)&&(identical(other.category, category) || other.category == category)&&(identical(other.coverImageUrl, coverImageUrl) || other.coverImageUrl == coverImageUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,placeId,name,city,country,category,coverImageUrl);
}

@override
String toString() {
    return 'ProfileShowcaseSavedPlace(id: $id, placeId: $placeId, name: $name, city: $city, country: $country, category: $category, coverImageUrl: $coverImageUrl)';
}


}

/// @nodoc
abstract mixin class _$ProfileShowcaseSavedPlaceCopyWith<$Res> implements $ProfileShowcaseSavedPlaceCopyWith<$Res> {
  factory _$ProfileShowcaseSavedPlaceCopyWith(_ProfileShowcaseSavedPlace value, $Res Function(_ProfileShowcaseSavedPlace) _then) = __$ProfileShowcaseSavedPlaceCopyWithImpl;
@override @useResult
$Res call({
 String id, String placeId, String name, String city, String country, String category, String? coverImageUrl
});




}
/// @nodoc
class __$ProfileShowcaseSavedPlaceCopyWithImpl<$Res>
    implements _$ProfileShowcaseSavedPlaceCopyWith<$Res> {
  __$ProfileShowcaseSavedPlaceCopyWithImpl(this._self, this._then);

  final _ProfileShowcaseSavedPlace _self;
  final $Res Function(_ProfileShowcaseSavedPlace) _then;

/// Create a copy of ProfileShowcaseSavedPlace
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? placeId = null,Object? name = null,Object? city = null,Object? country = null,Object? category = null,Object? coverImageUrl = freezed,}) {
  return _then(_ProfileShowcaseSavedPlace(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,placeId: null == placeId ? _self.placeId : placeId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,country: null == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,coverImageUrl: freezed == coverImageUrl ? _self.coverImageUrl : coverImageUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$ProfileShowcasePosts {

 int get count; List<ProfileShowcasePost> get items;
/// Create a copy of ProfileShowcasePosts
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileShowcasePostsCopyWith<ProfileShowcasePosts> get copyWith => _$ProfileShowcasePostsCopyWithImpl<ProfileShowcasePosts>(this as ProfileShowcasePosts, _$identity);

  /// Serializes this ProfileShowcasePosts to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ProfileShowcasePosts;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileShowcasePosts&&(identical(other.count, _this.count) || other.count == _this.count)&&const DeepCollectionEquality().equals(other.items, _this.items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ProfileShowcasePosts;
  return Object.hash(runtimeType,_this.count,const DeepCollectionEquality().hash(_this.items));
}

@override
String toString() {
  final _this = this as ProfileShowcasePosts;
  return 'ProfileShowcasePosts(count: ${_this.count}, items: ${_this.items})';
}


}

/// @nodoc
abstract mixin class $ProfileShowcasePostsCopyWith<$Res>  {
  factory $ProfileShowcasePostsCopyWith(ProfileShowcasePosts value, $Res Function(ProfileShowcasePosts) _then) = _$ProfileShowcasePostsCopyWithImpl;
@useResult
$Res call({
 int count, List<ProfileShowcasePost> items
});




}
/// @nodoc
class _$ProfileShowcasePostsCopyWithImpl<$Res>
    implements $ProfileShowcasePostsCopyWith<$Res> {
  _$ProfileShowcasePostsCopyWithImpl(this._self, this._then);

  final ProfileShowcasePosts _self;
  final $Res Function(ProfileShowcasePosts) _then;

/// Create a copy of ProfileShowcasePosts
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? count = null,Object? items = null,}) {
  return _then(ProfileShowcasePosts(
count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<ProfileShowcasePost>,
  ));
}

}


/// Adds pattern-matching-related methods to [ProfileShowcasePosts].
extension ProfileShowcasePostsPatterns on ProfileShowcasePosts {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProfileShowcasePosts value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProfileShowcasePosts() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProfileShowcasePosts value)  $default,){
final _that = this;
switch (_that) {
case _ProfileShowcasePosts():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProfileShowcasePosts value)?  $default,){
final _that = this;
switch (_that) {
case _ProfileShowcasePosts() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int count,  List<ProfileShowcasePost> items)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProfileShowcasePosts() when $default != null:
return $default(_that.count,_that.items);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int count,  List<ProfileShowcasePost> items)  $default,) {final _that = this;
switch (_that) {
case _ProfileShowcasePosts():
return $default(_that.count,_that.items);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int count,  List<ProfileShowcasePost> items)?  $default,) {final _that = this;
switch (_that) {
case _ProfileShowcasePosts() when $default != null:
return $default(_that.count,_that.items);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProfileShowcasePosts implements ProfileShowcasePosts {
  const _ProfileShowcasePosts({required this.count, required  List<ProfileShowcasePost> items}): _items = items;
  factory _ProfileShowcasePosts.fromJson(Map<String, dynamic> json) => _$ProfileShowcasePostsFromJson(json);

@override final  int count;
 final  List<ProfileShowcasePost> _items;
@override List<ProfileShowcasePost> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}


/// Create a copy of ProfileShowcasePosts
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProfileShowcasePostsCopyWith<_ProfileShowcasePosts> get copyWith => __$ProfileShowcasePostsCopyWithImpl<_ProfileShowcasePosts>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProfileShowcasePostsToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProfileShowcasePosts&&(identical(other.count, count) || other.count == count)&&const DeepCollectionEquality().equals(other.items, _items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,count,const DeepCollectionEquality().hash(_items));
}

@override
String toString() {
    return 'ProfileShowcasePosts(count: $count, items: $items)';
}


}

/// @nodoc
abstract mixin class _$ProfileShowcasePostsCopyWith<$Res> implements $ProfileShowcasePostsCopyWith<$Res> {
  factory _$ProfileShowcasePostsCopyWith(_ProfileShowcasePosts value, $Res Function(_ProfileShowcasePosts) _then) = __$ProfileShowcasePostsCopyWithImpl;
@override @useResult
$Res call({
 int count, List<ProfileShowcasePost> items
});




}
/// @nodoc
class __$ProfileShowcasePostsCopyWithImpl<$Res>
    implements _$ProfileShowcasePostsCopyWith<$Res> {
  __$ProfileShowcasePostsCopyWithImpl(this._self, this._then);

  final _ProfileShowcasePosts _self;
  final $Res Function(_ProfileShowcasePosts) _then;

/// Create a copy of ProfileShowcasePosts
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? count = null,Object? items = null,}) {
  return _then(_ProfileShowcasePosts(
count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<ProfileShowcasePost>,
  ));
}


}


/// @nodoc
mixin _$ProfileShowcasePost {

 String get id; String? get caption; String? get imageUrl;
/// Create a copy of ProfileShowcasePost
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileShowcasePostCopyWith<ProfileShowcasePost> get copyWith => _$ProfileShowcasePostCopyWithImpl<ProfileShowcasePost>(this as ProfileShowcasePost, _$identity);

  /// Serializes this ProfileShowcasePost to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ProfileShowcasePost;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileShowcasePost&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.caption, _this.caption) || other.caption == _this.caption)&&(identical(other.imageUrl, _this.imageUrl) || other.imageUrl == _this.imageUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ProfileShowcasePost;
  return Object.hash(runtimeType,_this.id,_this.caption,_this.imageUrl);
}

@override
String toString() {
  final _this = this as ProfileShowcasePost;
  return 'ProfileShowcasePost(id: ${_this.id}, caption: ${_this.caption}, imageUrl: ${_this.imageUrl})';
}


}

/// @nodoc
abstract mixin class $ProfileShowcasePostCopyWith<$Res>  {
  factory $ProfileShowcasePostCopyWith(ProfileShowcasePost value, $Res Function(ProfileShowcasePost) _then) = _$ProfileShowcasePostCopyWithImpl;
@useResult
$Res call({
 String id, String? caption, String? imageUrl
});




}
/// @nodoc
class _$ProfileShowcasePostCopyWithImpl<$Res>
    implements $ProfileShowcasePostCopyWith<$Res> {
  _$ProfileShowcasePostCopyWithImpl(this._self, this._then);

  final ProfileShowcasePost _self;
  final $Res Function(ProfileShowcasePost) _then;

/// Create a copy of ProfileShowcasePost
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? caption = freezed,Object? imageUrl = freezed,}) {
  return _then(ProfileShowcasePost(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,caption: freezed == caption ? _self.caption : caption // ignore: cast_nullable_to_non_nullable
as String?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ProfileShowcasePost].
extension ProfileShowcasePostPatterns on ProfileShowcasePost {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProfileShowcasePost value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProfileShowcasePost() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProfileShowcasePost value)  $default,){
final _that = this;
switch (_that) {
case _ProfileShowcasePost():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProfileShowcasePost value)?  $default,){
final _that = this;
switch (_that) {
case _ProfileShowcasePost() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String? caption,  String? imageUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProfileShowcasePost() when $default != null:
return $default(_that.id,_that.caption,_that.imageUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String? caption,  String? imageUrl)  $default,) {final _that = this;
switch (_that) {
case _ProfileShowcasePost():
return $default(_that.id,_that.caption,_that.imageUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String? caption,  String? imageUrl)?  $default,) {final _that = this;
switch (_that) {
case _ProfileShowcasePost() when $default != null:
return $default(_that.id,_that.caption,_that.imageUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProfileShowcasePost implements ProfileShowcasePost {
  const _ProfileShowcasePost({required this.id, this.caption, this.imageUrl});
  factory _ProfileShowcasePost.fromJson(Map<String, dynamic> json) => _$ProfileShowcasePostFromJson(json);

@override final  String id;
@override final  String? caption;
@override final  String? imageUrl;

/// Create a copy of ProfileShowcasePost
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProfileShowcasePostCopyWith<_ProfileShowcasePost> get copyWith => __$ProfileShowcasePostCopyWithImpl<_ProfileShowcasePost>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProfileShowcasePostToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProfileShowcasePost&&(identical(other.id, id) || other.id == id)&&(identical(other.caption, caption) || other.caption == caption)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,caption,imageUrl);
}

@override
String toString() {
    return 'ProfileShowcasePost(id: $id, caption: $caption, imageUrl: $imageUrl)';
}


}

/// @nodoc
abstract mixin class _$ProfileShowcasePostCopyWith<$Res> implements $ProfileShowcasePostCopyWith<$Res> {
  factory _$ProfileShowcasePostCopyWith(_ProfileShowcasePost value, $Res Function(_ProfileShowcasePost) _then) = __$ProfileShowcasePostCopyWithImpl;
@override @useResult
$Res call({
 String id, String? caption, String? imageUrl
});




}
/// @nodoc
class __$ProfileShowcasePostCopyWithImpl<$Res>
    implements _$ProfileShowcasePostCopyWith<$Res> {
  __$ProfileShowcasePostCopyWithImpl(this._self, this._then);

  final _ProfileShowcasePost _self;
  final $Res Function(_ProfileShowcasePost) _then;

/// Create a copy of ProfileShowcasePost
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? caption = freezed,Object? imageUrl = freezed,}) {
  return _then(_ProfileShowcasePost(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,caption: freezed == caption ? _self.caption : caption // ignore: cast_nullable_to_non_nullable
as String?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
