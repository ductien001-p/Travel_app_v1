// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'travel_dna_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TravelDnaRadar {

 TravelDnaSnapshot get dna; List<TravelDnaCommunityScore> get community; int? get dominantPercentile; List<TravelDnaFitPlaces> get fitPlaces; TravelDnaJourney? get journey; List<TravelDnaCompanion> get companions;
/// Create a copy of TravelDnaRadar
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TravelDnaRadarCopyWith<TravelDnaRadar> get copyWith => _$TravelDnaRadarCopyWithImpl<TravelDnaRadar>(this as TravelDnaRadar, _$identity);

  /// Serializes this TravelDnaRadar to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TravelDnaRadar;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TravelDnaRadar&&(identical(other.dna, _this.dna) || other.dna == _this.dna)&&const DeepCollectionEquality().equals(other.community, _this.community)&&(identical(other.dominantPercentile, _this.dominantPercentile) || other.dominantPercentile == _this.dominantPercentile)&&const DeepCollectionEquality().equals(other.fitPlaces, _this.fitPlaces)&&(identical(other.journey, _this.journey) || other.journey == _this.journey)&&const DeepCollectionEquality().equals(other.companions, _this.companions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TravelDnaRadar;
  return Object.hash(runtimeType,_this.dna,const DeepCollectionEquality().hash(_this.community),_this.dominantPercentile,const DeepCollectionEquality().hash(_this.fitPlaces),_this.journey,const DeepCollectionEquality().hash(_this.companions));
}

@override
String toString() {
  final _this = this as TravelDnaRadar;
  return 'TravelDnaRadar(dna: ${_this.dna}, community: ${_this.community}, dominantPercentile: ${_this.dominantPercentile}, fitPlaces: ${_this.fitPlaces}, journey: ${_this.journey}, companions: ${_this.companions})';
}


}

/// @nodoc
abstract mixin class $TravelDnaRadarCopyWith<$Res>  {
  factory $TravelDnaRadarCopyWith(TravelDnaRadar value, $Res Function(TravelDnaRadar) _then) = _$TravelDnaRadarCopyWithImpl;
@useResult
$Res call({
 TravelDnaSnapshot dna, List<TravelDnaCommunityScore> community, int? dominantPercentile, List<TravelDnaFitPlaces> fitPlaces, TravelDnaJourney? journey, List<TravelDnaCompanion> companions
});


$TravelDnaSnapshotCopyWith<$Res> get dna;$TravelDnaJourneyCopyWith<$Res>? get journey;

}
/// @nodoc
class _$TravelDnaRadarCopyWithImpl<$Res>
    implements $TravelDnaRadarCopyWith<$Res> {
  _$TravelDnaRadarCopyWithImpl(this._self, this._then);

  final TravelDnaRadar _self;
  final $Res Function(TravelDnaRadar) _then;

/// Create a copy of TravelDnaRadar
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? dna = null,Object? community = null,Object? dominantPercentile = freezed,Object? fitPlaces = null,Object? journey = freezed,Object? companions = null,}) {
  return _then(TravelDnaRadar(
dna: null == dna ? _self.dna : dna // ignore: cast_nullable_to_non_nullable
as TravelDnaSnapshot,community: null == community ? _self.community : community // ignore: cast_nullable_to_non_nullable
as List<TravelDnaCommunityScore>,dominantPercentile: freezed == dominantPercentile ? _self.dominantPercentile : dominantPercentile // ignore: cast_nullable_to_non_nullable
as int?,fitPlaces: null == fitPlaces ? _self.fitPlaces : fitPlaces // ignore: cast_nullable_to_non_nullable
as List<TravelDnaFitPlaces>,journey: freezed == journey ? _self.journey : journey // ignore: cast_nullable_to_non_nullable
as TravelDnaJourney?,companions: null == companions ? _self.companions : companions // ignore: cast_nullable_to_non_nullable
as List<TravelDnaCompanion>,
  ));
}
/// Create a copy of TravelDnaRadar
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TravelDnaSnapshotCopyWith<$Res> get dna {
  
  return $TravelDnaSnapshotCopyWith<$Res>(_self.dna, (value) {
    return _then(_self.copyWith(dna: value));
  });
}/// Create a copy of TravelDnaRadar
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TravelDnaJourneyCopyWith<$Res>? get journey {
    if (_self.journey == null) {
    return null;
  }

  return $TravelDnaJourneyCopyWith<$Res>(_self.journey!, (value) {
    return _then(_self.copyWith(journey: value));
  });
}
}


/// Adds pattern-matching-related methods to [TravelDnaRadar].
extension TravelDnaRadarPatterns on TravelDnaRadar {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TravelDnaRadar value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TravelDnaRadar() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TravelDnaRadar value)  $default,){
final _that = this;
switch (_that) {
case _TravelDnaRadar():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TravelDnaRadar value)?  $default,){
final _that = this;
switch (_that) {
case _TravelDnaRadar() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( TravelDnaSnapshot dna,  List<TravelDnaCommunityScore> community,  int? dominantPercentile,  List<TravelDnaFitPlaces> fitPlaces,  TravelDnaJourney? journey,  List<TravelDnaCompanion> companions)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TravelDnaRadar() when $default != null:
return $default(_that.dna,_that.community,_that.dominantPercentile,_that.fitPlaces,_that.journey,_that.companions);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( TravelDnaSnapshot dna,  List<TravelDnaCommunityScore> community,  int? dominantPercentile,  List<TravelDnaFitPlaces> fitPlaces,  TravelDnaJourney? journey,  List<TravelDnaCompanion> companions)  $default,) {final _that = this;
switch (_that) {
case _TravelDnaRadar():
return $default(_that.dna,_that.community,_that.dominantPercentile,_that.fitPlaces,_that.journey,_that.companions);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( TravelDnaSnapshot dna,  List<TravelDnaCommunityScore> community,  int? dominantPercentile,  List<TravelDnaFitPlaces> fitPlaces,  TravelDnaJourney? journey,  List<TravelDnaCompanion> companions)?  $default,) {final _that = this;
switch (_that) {
case _TravelDnaRadar() when $default != null:
return $default(_that.dna,_that.community,_that.dominantPercentile,_that.fitPlaces,_that.journey,_that.companions);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TravelDnaRadar implements TravelDnaRadar {
  const _TravelDnaRadar({required this.dna, required  List<TravelDnaCommunityScore> community, this.dominantPercentile, required  List<TravelDnaFitPlaces> fitPlaces, this.journey, required  List<TravelDnaCompanion> companions}): _community = community,_fitPlaces = fitPlaces,_companions = companions;
  factory _TravelDnaRadar.fromJson(Map<String, dynamic> json) => _$TravelDnaRadarFromJson(json);

@override final  TravelDnaSnapshot dna;
 final  List<TravelDnaCommunityScore> _community;
@override List<TravelDnaCommunityScore> get community {
  if (_community is EqualUnmodifiableListView) return _community;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_community);
}

@override final  int? dominantPercentile;
 final  List<TravelDnaFitPlaces> _fitPlaces;
@override List<TravelDnaFitPlaces> get fitPlaces {
  if (_fitPlaces is EqualUnmodifiableListView) return _fitPlaces;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_fitPlaces);
}

@override final  TravelDnaJourney? journey;
 final  List<TravelDnaCompanion> _companions;
@override List<TravelDnaCompanion> get companions {
  if (_companions is EqualUnmodifiableListView) return _companions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_companions);
}


/// Create a copy of TravelDnaRadar
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TravelDnaRadarCopyWith<_TravelDnaRadar> get copyWith => __$TravelDnaRadarCopyWithImpl<_TravelDnaRadar>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TravelDnaRadarToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TravelDnaRadar&&(identical(other.dna, dna) || other.dna == dna)&&const DeepCollectionEquality().equals(other.community, _community)&&(identical(other.dominantPercentile, dominantPercentile) || other.dominantPercentile == dominantPercentile)&&const DeepCollectionEquality().equals(other.fitPlaces, _fitPlaces)&&(identical(other.journey, journey) || other.journey == journey)&&const DeepCollectionEquality().equals(other.companions, _companions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,dna,const DeepCollectionEquality().hash(_community),dominantPercentile,const DeepCollectionEquality().hash(_fitPlaces),journey,const DeepCollectionEquality().hash(_companions));
}

@override
String toString() {
    return 'TravelDnaRadar(dna: $dna, community: $community, dominantPercentile: $dominantPercentile, fitPlaces: $fitPlaces, journey: $journey, companions: $companions)';
}


}

/// @nodoc
abstract mixin class _$TravelDnaRadarCopyWith<$Res> implements $TravelDnaRadarCopyWith<$Res> {
  factory _$TravelDnaRadarCopyWith(_TravelDnaRadar value, $Res Function(_TravelDnaRadar) _then) = __$TravelDnaRadarCopyWithImpl;
@override @useResult
$Res call({
 TravelDnaSnapshot dna, List<TravelDnaCommunityScore> community, int? dominantPercentile, List<TravelDnaFitPlaces> fitPlaces, TravelDnaJourney? journey, List<TravelDnaCompanion> companions
});


@override $TravelDnaSnapshotCopyWith<$Res> get dna;@override $TravelDnaJourneyCopyWith<$Res>? get journey;

}
/// @nodoc
class __$TravelDnaRadarCopyWithImpl<$Res>
    implements _$TravelDnaRadarCopyWith<$Res> {
  __$TravelDnaRadarCopyWithImpl(this._self, this._then);

  final _TravelDnaRadar _self;
  final $Res Function(_TravelDnaRadar) _then;

/// Create a copy of TravelDnaRadar
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? dna = null,Object? community = null,Object? dominantPercentile = freezed,Object? fitPlaces = null,Object? journey = freezed,Object? companions = null,}) {
  return _then(_TravelDnaRadar(
dna: null == dna ? _self.dna : dna // ignore: cast_nullable_to_non_nullable
as TravelDnaSnapshot,community: null == community ? _self._community : community // ignore: cast_nullable_to_non_nullable
as List<TravelDnaCommunityScore>,dominantPercentile: freezed == dominantPercentile ? _self.dominantPercentile : dominantPercentile // ignore: cast_nullable_to_non_nullable
as int?,fitPlaces: null == fitPlaces ? _self._fitPlaces : fitPlaces // ignore: cast_nullable_to_non_nullable
as List<TravelDnaFitPlaces>,journey: freezed == journey ? _self.journey : journey // ignore: cast_nullable_to_non_nullable
as TravelDnaJourney?,companions: null == companions ? _self._companions : companions // ignore: cast_nullable_to_non_nullable
as List<TravelDnaCompanion>,
  ));
}

/// Create a copy of TravelDnaRadar
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TravelDnaSnapshotCopyWith<$Res> get dna {
  
  return $TravelDnaSnapshotCopyWith<$Res>(_self.dna, (value) {
    return _then(_self.copyWith(dna: value));
  });
}/// Create a copy of TravelDnaRadar
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TravelDnaJourneyCopyWith<$Res>? get journey {
    if (_self.journey == null) {
    return null;
  }

  return $TravelDnaJourneyCopyWith<$Res>(_self.journey!, (value) {
    return _then(_self.copyWith(journey: value));
  });
}
}


/// @nodoc
mixin _$TravelDnaSnapshot {

 TravelDnaBadge? get dominant; List<TravelDnaBadge> get topBadges; List<TravelDnaBadge> get all;
/// Create a copy of TravelDnaSnapshot
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TravelDnaSnapshotCopyWith<TravelDnaSnapshot> get copyWith => _$TravelDnaSnapshotCopyWithImpl<TravelDnaSnapshot>(this as TravelDnaSnapshot, _$identity);

  /// Serializes this TravelDnaSnapshot to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TravelDnaSnapshot;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TravelDnaSnapshot&&(identical(other.dominant, _this.dominant) || other.dominant == _this.dominant)&&const DeepCollectionEquality().equals(other.topBadges, _this.topBadges)&&const DeepCollectionEquality().equals(other.all, _this.all));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TravelDnaSnapshot;
  return Object.hash(runtimeType,_this.dominant,const DeepCollectionEquality().hash(_this.topBadges),const DeepCollectionEquality().hash(_this.all));
}

@override
String toString() {
  final _this = this as TravelDnaSnapshot;
  return 'TravelDnaSnapshot(dominant: ${_this.dominant}, topBadges: ${_this.topBadges}, all: ${_this.all})';
}


}

/// @nodoc
abstract mixin class $TravelDnaSnapshotCopyWith<$Res>  {
  factory $TravelDnaSnapshotCopyWith(TravelDnaSnapshot value, $Res Function(TravelDnaSnapshot) _then) = _$TravelDnaSnapshotCopyWithImpl;
@useResult
$Res call({
 TravelDnaBadge? dominant, List<TravelDnaBadge> topBadges, List<TravelDnaBadge> all
});


$TravelDnaBadgeCopyWith<$Res>? get dominant;

}
/// @nodoc
class _$TravelDnaSnapshotCopyWithImpl<$Res>
    implements $TravelDnaSnapshotCopyWith<$Res> {
  _$TravelDnaSnapshotCopyWithImpl(this._self, this._then);

  final TravelDnaSnapshot _self;
  final $Res Function(TravelDnaSnapshot) _then;

/// Create a copy of TravelDnaSnapshot
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? dominant = freezed,Object? topBadges = null,Object? all = null,}) {
  return _then(TravelDnaSnapshot(
dominant: freezed == dominant ? _self.dominant : dominant // ignore: cast_nullable_to_non_nullable
as TravelDnaBadge?,topBadges: null == topBadges ? _self.topBadges : topBadges // ignore: cast_nullable_to_non_nullable
as List<TravelDnaBadge>,all: null == all ? _self.all : all // ignore: cast_nullable_to_non_nullable
as List<TravelDnaBadge>,
  ));
}
/// Create a copy of TravelDnaSnapshot
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TravelDnaBadgeCopyWith<$Res>? get dominant {
    if (_self.dominant == null) {
    return null;
  }

  return $TravelDnaBadgeCopyWith<$Res>(_self.dominant!, (value) {
    return _then(_self.copyWith(dominant: value));
  });
}
}


/// Adds pattern-matching-related methods to [TravelDnaSnapshot].
extension TravelDnaSnapshotPatterns on TravelDnaSnapshot {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TravelDnaSnapshot value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TravelDnaSnapshot() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TravelDnaSnapshot value)  $default,){
final _that = this;
switch (_that) {
case _TravelDnaSnapshot():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TravelDnaSnapshot value)?  $default,){
final _that = this;
switch (_that) {
case _TravelDnaSnapshot() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( TravelDnaBadge? dominant,  List<TravelDnaBadge> topBadges,  List<TravelDnaBadge> all)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TravelDnaSnapshot() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( TravelDnaBadge? dominant,  List<TravelDnaBadge> topBadges,  List<TravelDnaBadge> all)  $default,) {final _that = this;
switch (_that) {
case _TravelDnaSnapshot():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( TravelDnaBadge? dominant,  List<TravelDnaBadge> topBadges,  List<TravelDnaBadge> all)?  $default,) {final _that = this;
switch (_that) {
case _TravelDnaSnapshot() when $default != null:
return $default(_that.dominant,_that.topBadges,_that.all);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TravelDnaSnapshot implements TravelDnaSnapshot {
  const _TravelDnaSnapshot({this.dominant, required  List<TravelDnaBadge> topBadges, required  List<TravelDnaBadge> all}): _topBadges = topBadges,_all = all;
  factory _TravelDnaSnapshot.fromJson(Map<String, dynamic> json) => _$TravelDnaSnapshotFromJson(json);

@override final  TravelDnaBadge? dominant;
 final  List<TravelDnaBadge> _topBadges;
@override List<TravelDnaBadge> get topBadges {
  if (_topBadges is EqualUnmodifiableListView) return _topBadges;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_topBadges);
}

 final  List<TravelDnaBadge> _all;
@override List<TravelDnaBadge> get all {
  if (_all is EqualUnmodifiableListView) return _all;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_all);
}


/// Create a copy of TravelDnaSnapshot
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TravelDnaSnapshotCopyWith<_TravelDnaSnapshot> get copyWith => __$TravelDnaSnapshotCopyWithImpl<_TravelDnaSnapshot>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TravelDnaSnapshotToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TravelDnaSnapshot&&(identical(other.dominant, dominant) || other.dominant == dominant)&&const DeepCollectionEquality().equals(other.topBadges, _topBadges)&&const DeepCollectionEquality().equals(other.all, _all));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,dominant,const DeepCollectionEquality().hash(_topBadges),const DeepCollectionEquality().hash(_all));
}

@override
String toString() {
    return 'TravelDnaSnapshot(dominant: $dominant, topBadges: $topBadges, all: $all)';
}


}

/// @nodoc
abstract mixin class _$TravelDnaSnapshotCopyWith<$Res> implements $TravelDnaSnapshotCopyWith<$Res> {
  factory _$TravelDnaSnapshotCopyWith(_TravelDnaSnapshot value, $Res Function(_TravelDnaSnapshot) _then) = __$TravelDnaSnapshotCopyWithImpl;
@override @useResult
$Res call({
 TravelDnaBadge? dominant, List<TravelDnaBadge> topBadges, List<TravelDnaBadge> all
});


@override $TravelDnaBadgeCopyWith<$Res>? get dominant;

}
/// @nodoc
class __$TravelDnaSnapshotCopyWithImpl<$Res>
    implements _$TravelDnaSnapshotCopyWith<$Res> {
  __$TravelDnaSnapshotCopyWithImpl(this._self, this._then);

  final _TravelDnaSnapshot _self;
  final $Res Function(_TravelDnaSnapshot) _then;

/// Create a copy of TravelDnaSnapshot
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? dominant = freezed,Object? topBadges = null,Object? all = null,}) {
  return _then(_TravelDnaSnapshot(
dominant: freezed == dominant ? _self.dominant : dominant // ignore: cast_nullable_to_non_nullable
as TravelDnaBadge?,topBadges: null == topBadges ? _self._topBadges : topBadges // ignore: cast_nullable_to_non_nullable
as List<TravelDnaBadge>,all: null == all ? _self._all : all // ignore: cast_nullable_to_non_nullable
as List<TravelDnaBadge>,
  ));
}

/// Create a copy of TravelDnaSnapshot
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TravelDnaBadgeCopyWith<$Res>? get dominant {
    if (_self.dominant == null) {
    return null;
  }

  return $TravelDnaBadgeCopyWith<$Res>(_self.dominant!, (value) {
    return _then(_self.copyWith(dominant: value));
  });
}
}


/// @nodoc
mixin _$TravelDnaBadge {

 String get type; String get name; String get icon; String get description;@JsonKey(fromJson: travelDnaJsonInt) int get score;@JsonKey(fromJson: travelDnaJsonInt) int get tripTypeCount;@JsonKey(fromJson: travelDnaJsonInt) int get activityCount; String get createdAt; String get updatedAt; String get shortLabel; String get badgeTitle;
/// Create a copy of TravelDnaBadge
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TravelDnaBadgeCopyWith<TravelDnaBadge> get copyWith => _$TravelDnaBadgeCopyWithImpl<TravelDnaBadge>(this as TravelDnaBadge, _$identity);

  /// Serializes this TravelDnaBadge to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TravelDnaBadge;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TravelDnaBadge&&(identical(other.type, _this.type) || other.type == _this.type)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.icon, _this.icon) || other.icon == _this.icon)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.score, _this.score) || other.score == _this.score)&&(identical(other.tripTypeCount, _this.tripTypeCount) || other.tripTypeCount == _this.tripTypeCount)&&(identical(other.activityCount, _this.activityCount) || other.activityCount == _this.activityCount)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.updatedAt, _this.updatedAt) || other.updatedAt == _this.updatedAt)&&(identical(other.shortLabel, _this.shortLabel) || other.shortLabel == _this.shortLabel)&&(identical(other.badgeTitle, _this.badgeTitle) || other.badgeTitle == _this.badgeTitle));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TravelDnaBadge;
  return Object.hash(runtimeType,_this.type,_this.name,_this.icon,_this.description,_this.score,_this.tripTypeCount,_this.activityCount,_this.createdAt,_this.updatedAt,_this.shortLabel,_this.badgeTitle);
}

@override
String toString() {
  final _this = this as TravelDnaBadge;
  return 'TravelDnaBadge(type: ${_this.type}, name: ${_this.name}, icon: ${_this.icon}, description: ${_this.description}, score: ${_this.score}, tripTypeCount: ${_this.tripTypeCount}, activityCount: ${_this.activityCount}, createdAt: ${_this.createdAt}, updatedAt: ${_this.updatedAt}, shortLabel: ${_this.shortLabel}, badgeTitle: ${_this.badgeTitle})';
}


}

/// @nodoc
abstract mixin class $TravelDnaBadgeCopyWith<$Res>  {
  factory $TravelDnaBadgeCopyWith(TravelDnaBadge value, $Res Function(TravelDnaBadge) _then) = _$TravelDnaBadgeCopyWithImpl;
@useResult
$Res call({
 String type, String name, String icon, String description,@JsonKey(fromJson: travelDnaJsonInt) int score,@JsonKey(fromJson: travelDnaJsonInt) int tripTypeCount,@JsonKey(fromJson: travelDnaJsonInt) int activityCount, String createdAt, String updatedAt, String shortLabel, String badgeTitle
});




}
/// @nodoc
class _$TravelDnaBadgeCopyWithImpl<$Res>
    implements $TravelDnaBadgeCopyWith<$Res> {
  _$TravelDnaBadgeCopyWithImpl(this._self, this._then);

  final TravelDnaBadge _self;
  final $Res Function(TravelDnaBadge) _then;

/// Create a copy of TravelDnaBadge
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? name = null,Object? icon = null,Object? description = null,Object? score = null,Object? tripTypeCount = null,Object? activityCount = null,Object? createdAt = null,Object? updatedAt = null,Object? shortLabel = null,Object? badgeTitle = null,}) {
  return _then(TravelDnaBadge(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as int,tripTypeCount: null == tripTypeCount ? _self.tripTypeCount : tripTypeCount // ignore: cast_nullable_to_non_nullable
as int,activityCount: null == activityCount ? _self.activityCount : activityCount // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String,shortLabel: null == shortLabel ? _self.shortLabel : shortLabel // ignore: cast_nullable_to_non_nullable
as String,badgeTitle: null == badgeTitle ? _self.badgeTitle : badgeTitle // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [TravelDnaBadge].
extension TravelDnaBadgePatterns on TravelDnaBadge {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TravelDnaBadge value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TravelDnaBadge() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TravelDnaBadge value)  $default,){
final _that = this;
switch (_that) {
case _TravelDnaBadge():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TravelDnaBadge value)?  $default,){
final _that = this;
switch (_that) {
case _TravelDnaBadge() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String type,  String name,  String icon,  String description, @JsonKey(fromJson: travelDnaJsonInt)  int score, @JsonKey(fromJson: travelDnaJsonInt)  int tripTypeCount, @JsonKey(fromJson: travelDnaJsonInt)  int activityCount,  String createdAt,  String updatedAt,  String shortLabel,  String badgeTitle)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TravelDnaBadge() when $default != null:
return $default(_that.type,_that.name,_that.icon,_that.description,_that.score,_that.tripTypeCount,_that.activityCount,_that.createdAt,_that.updatedAt,_that.shortLabel,_that.badgeTitle);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String type,  String name,  String icon,  String description, @JsonKey(fromJson: travelDnaJsonInt)  int score, @JsonKey(fromJson: travelDnaJsonInt)  int tripTypeCount, @JsonKey(fromJson: travelDnaJsonInt)  int activityCount,  String createdAt,  String updatedAt,  String shortLabel,  String badgeTitle)  $default,) {final _that = this;
switch (_that) {
case _TravelDnaBadge():
return $default(_that.type,_that.name,_that.icon,_that.description,_that.score,_that.tripTypeCount,_that.activityCount,_that.createdAt,_that.updatedAt,_that.shortLabel,_that.badgeTitle);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String type,  String name,  String icon,  String description, @JsonKey(fromJson: travelDnaJsonInt)  int score, @JsonKey(fromJson: travelDnaJsonInt)  int tripTypeCount, @JsonKey(fromJson: travelDnaJsonInt)  int activityCount,  String createdAt,  String updatedAt,  String shortLabel,  String badgeTitle)?  $default,) {final _that = this;
switch (_that) {
case _TravelDnaBadge() when $default != null:
return $default(_that.type,_that.name,_that.icon,_that.description,_that.score,_that.tripTypeCount,_that.activityCount,_that.createdAt,_that.updatedAt,_that.shortLabel,_that.badgeTitle);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TravelDnaBadge implements TravelDnaBadge {
  const _TravelDnaBadge({required this.type, required this.name, required this.icon, required this.description, @JsonKey(fromJson: travelDnaJsonInt) required this.score, @JsonKey(fromJson: travelDnaJsonInt) required this.tripTypeCount, @JsonKey(fromJson: travelDnaJsonInt) required this.activityCount, required this.createdAt, required this.updatedAt, required this.shortLabel, required this.badgeTitle});
  factory _TravelDnaBadge.fromJson(Map<String, dynamic> json) => _$TravelDnaBadgeFromJson(json);

@override final  String type;
@override final  String name;
@override final  String icon;
@override final  String description;
@override@JsonKey(fromJson: travelDnaJsonInt) final  int score;
@override@JsonKey(fromJson: travelDnaJsonInt) final  int tripTypeCount;
@override@JsonKey(fromJson: travelDnaJsonInt) final  int activityCount;
@override final  String createdAt;
@override final  String updatedAt;
@override final  String shortLabel;
@override final  String badgeTitle;

/// Create a copy of TravelDnaBadge
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TravelDnaBadgeCopyWith<_TravelDnaBadge> get copyWith => __$TravelDnaBadgeCopyWithImpl<_TravelDnaBadge>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TravelDnaBadgeToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TravelDnaBadge&&(identical(other.type, type) || other.type == type)&&(identical(other.name, name) || other.name == name)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.description, description) || other.description == description)&&(identical(other.score, score) || other.score == score)&&(identical(other.tripTypeCount, tripTypeCount) || other.tripTypeCount == tripTypeCount)&&(identical(other.activityCount, activityCount) || other.activityCount == activityCount)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.shortLabel, shortLabel) || other.shortLabel == shortLabel)&&(identical(other.badgeTitle, badgeTitle) || other.badgeTitle == badgeTitle));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,type,name,icon,description,score,tripTypeCount,activityCount,createdAt,updatedAt,shortLabel,badgeTitle);
}

@override
String toString() {
    return 'TravelDnaBadge(type: $type, name: $name, icon: $icon, description: $description, score: $score, tripTypeCount: $tripTypeCount, activityCount: $activityCount, createdAt: $createdAt, updatedAt: $updatedAt, shortLabel: $shortLabel, badgeTitle: $badgeTitle)';
}


}

/// @nodoc
abstract mixin class _$TravelDnaBadgeCopyWith<$Res> implements $TravelDnaBadgeCopyWith<$Res> {
  factory _$TravelDnaBadgeCopyWith(_TravelDnaBadge value, $Res Function(_TravelDnaBadge) _then) = __$TravelDnaBadgeCopyWithImpl;
@override @useResult
$Res call({
 String type, String name, String icon, String description,@JsonKey(fromJson: travelDnaJsonInt) int score,@JsonKey(fromJson: travelDnaJsonInt) int tripTypeCount,@JsonKey(fromJson: travelDnaJsonInt) int activityCount, String createdAt, String updatedAt, String shortLabel, String badgeTitle
});




}
/// @nodoc
class __$TravelDnaBadgeCopyWithImpl<$Res>
    implements _$TravelDnaBadgeCopyWith<$Res> {
  __$TravelDnaBadgeCopyWithImpl(this._self, this._then);

  final _TravelDnaBadge _self;
  final $Res Function(_TravelDnaBadge) _then;

/// Create a copy of TravelDnaBadge
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? name = null,Object? icon = null,Object? description = null,Object? score = null,Object? tripTypeCount = null,Object? activityCount = null,Object? createdAt = null,Object? updatedAt = null,Object? shortLabel = null,Object? badgeTitle = null,}) {
  return _then(_TravelDnaBadge(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as int,tripTypeCount: null == tripTypeCount ? _self.tripTypeCount : tripTypeCount // ignore: cast_nullable_to_non_nullable
as int,activityCount: null == activityCount ? _self.activityCount : activityCount // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String,shortLabel: null == shortLabel ? _self.shortLabel : shortLabel // ignore: cast_nullable_to_non_nullable
as String,badgeTitle: null == badgeTitle ? _self.badgeTitle : badgeTitle // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$TravelDnaCommunityScore {

 String get type;@JsonKey(fromJson: travelDnaJsonInt) int get averageScore;@JsonKey(fromJson: travelDnaJsonInt) int get sampleCount;
/// Create a copy of TravelDnaCommunityScore
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TravelDnaCommunityScoreCopyWith<TravelDnaCommunityScore> get copyWith => _$TravelDnaCommunityScoreCopyWithImpl<TravelDnaCommunityScore>(this as TravelDnaCommunityScore, _$identity);

  /// Serializes this TravelDnaCommunityScore to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TravelDnaCommunityScore;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TravelDnaCommunityScore&&(identical(other.type, _this.type) || other.type == _this.type)&&(identical(other.averageScore, _this.averageScore) || other.averageScore == _this.averageScore)&&(identical(other.sampleCount, _this.sampleCount) || other.sampleCount == _this.sampleCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TravelDnaCommunityScore;
  return Object.hash(runtimeType,_this.type,_this.averageScore,_this.sampleCount);
}

@override
String toString() {
  final _this = this as TravelDnaCommunityScore;
  return 'TravelDnaCommunityScore(type: ${_this.type}, averageScore: ${_this.averageScore}, sampleCount: ${_this.sampleCount})';
}


}

/// @nodoc
abstract mixin class $TravelDnaCommunityScoreCopyWith<$Res>  {
  factory $TravelDnaCommunityScoreCopyWith(TravelDnaCommunityScore value, $Res Function(TravelDnaCommunityScore) _then) = _$TravelDnaCommunityScoreCopyWithImpl;
@useResult
$Res call({
 String type,@JsonKey(fromJson: travelDnaJsonInt) int averageScore,@JsonKey(fromJson: travelDnaJsonInt) int sampleCount
});




}
/// @nodoc
class _$TravelDnaCommunityScoreCopyWithImpl<$Res>
    implements $TravelDnaCommunityScoreCopyWith<$Res> {
  _$TravelDnaCommunityScoreCopyWithImpl(this._self, this._then);

  final TravelDnaCommunityScore _self;
  final $Res Function(TravelDnaCommunityScore) _then;

/// Create a copy of TravelDnaCommunityScore
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? averageScore = null,Object? sampleCount = null,}) {
  return _then(TravelDnaCommunityScore(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,averageScore: null == averageScore ? _self.averageScore : averageScore // ignore: cast_nullable_to_non_nullable
as int,sampleCount: null == sampleCount ? _self.sampleCount : sampleCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [TravelDnaCommunityScore].
extension TravelDnaCommunityScorePatterns on TravelDnaCommunityScore {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TravelDnaCommunityScore value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TravelDnaCommunityScore() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TravelDnaCommunityScore value)  $default,){
final _that = this;
switch (_that) {
case _TravelDnaCommunityScore():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TravelDnaCommunityScore value)?  $default,){
final _that = this;
switch (_that) {
case _TravelDnaCommunityScore() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String type, @JsonKey(fromJson: travelDnaJsonInt)  int averageScore, @JsonKey(fromJson: travelDnaJsonInt)  int sampleCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TravelDnaCommunityScore() when $default != null:
return $default(_that.type,_that.averageScore,_that.sampleCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String type, @JsonKey(fromJson: travelDnaJsonInt)  int averageScore, @JsonKey(fromJson: travelDnaJsonInt)  int sampleCount)  $default,) {final _that = this;
switch (_that) {
case _TravelDnaCommunityScore():
return $default(_that.type,_that.averageScore,_that.sampleCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String type, @JsonKey(fromJson: travelDnaJsonInt)  int averageScore, @JsonKey(fromJson: travelDnaJsonInt)  int sampleCount)?  $default,) {final _that = this;
switch (_that) {
case _TravelDnaCommunityScore() when $default != null:
return $default(_that.type,_that.averageScore,_that.sampleCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TravelDnaCommunityScore implements TravelDnaCommunityScore {
  const _TravelDnaCommunityScore({required this.type, @JsonKey(fromJson: travelDnaJsonInt) required this.averageScore, @JsonKey(fromJson: travelDnaJsonInt) required this.sampleCount});
  factory _TravelDnaCommunityScore.fromJson(Map<String, dynamic> json) => _$TravelDnaCommunityScoreFromJson(json);

@override final  String type;
@override@JsonKey(fromJson: travelDnaJsonInt) final  int averageScore;
@override@JsonKey(fromJson: travelDnaJsonInt) final  int sampleCount;

/// Create a copy of TravelDnaCommunityScore
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TravelDnaCommunityScoreCopyWith<_TravelDnaCommunityScore> get copyWith => __$TravelDnaCommunityScoreCopyWithImpl<_TravelDnaCommunityScore>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TravelDnaCommunityScoreToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TravelDnaCommunityScore&&(identical(other.type, type) || other.type == type)&&(identical(other.averageScore, averageScore) || other.averageScore == averageScore)&&(identical(other.sampleCount, sampleCount) || other.sampleCount == sampleCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,type,averageScore,sampleCount);
}

@override
String toString() {
    return 'TravelDnaCommunityScore(type: $type, averageScore: $averageScore, sampleCount: $sampleCount)';
}


}

/// @nodoc
abstract mixin class _$TravelDnaCommunityScoreCopyWith<$Res> implements $TravelDnaCommunityScoreCopyWith<$Res> {
  factory _$TravelDnaCommunityScoreCopyWith(_TravelDnaCommunityScore value, $Res Function(_TravelDnaCommunityScore) _then) = __$TravelDnaCommunityScoreCopyWithImpl;
@override @useResult
$Res call({
 String type,@JsonKey(fromJson: travelDnaJsonInt) int averageScore,@JsonKey(fromJson: travelDnaJsonInt) int sampleCount
});




}
/// @nodoc
class __$TravelDnaCommunityScoreCopyWithImpl<$Res>
    implements _$TravelDnaCommunityScoreCopyWith<$Res> {
  __$TravelDnaCommunityScoreCopyWithImpl(this._self, this._then);

  final _TravelDnaCommunityScore _self;
  final $Res Function(_TravelDnaCommunityScore) _then;

/// Create a copy of TravelDnaCommunityScore
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? averageScore = null,Object? sampleCount = null,}) {
  return _then(_TravelDnaCommunityScore(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,averageScore: null == averageScore ? _self.averageScore : averageScore // ignore: cast_nullable_to_non_nullable
as int,sampleCount: null == sampleCount ? _self.sampleCount : sampleCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$TravelDnaFitPlaces {

 String get type; List<TravelDnaPlace> get places;
/// Create a copy of TravelDnaFitPlaces
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TravelDnaFitPlacesCopyWith<TravelDnaFitPlaces> get copyWith => _$TravelDnaFitPlacesCopyWithImpl<TravelDnaFitPlaces>(this as TravelDnaFitPlaces, _$identity);

  /// Serializes this TravelDnaFitPlaces to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TravelDnaFitPlaces;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TravelDnaFitPlaces&&(identical(other.type, _this.type) || other.type == _this.type)&&const DeepCollectionEquality().equals(other.places, _this.places));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TravelDnaFitPlaces;
  return Object.hash(runtimeType,_this.type,const DeepCollectionEquality().hash(_this.places));
}

@override
String toString() {
  final _this = this as TravelDnaFitPlaces;
  return 'TravelDnaFitPlaces(type: ${_this.type}, places: ${_this.places})';
}


}

/// @nodoc
abstract mixin class $TravelDnaFitPlacesCopyWith<$Res>  {
  factory $TravelDnaFitPlacesCopyWith(TravelDnaFitPlaces value, $Res Function(TravelDnaFitPlaces) _then) = _$TravelDnaFitPlacesCopyWithImpl;
@useResult
$Res call({
 String type, List<TravelDnaPlace> places
});




}
/// @nodoc
class _$TravelDnaFitPlacesCopyWithImpl<$Res>
    implements $TravelDnaFitPlacesCopyWith<$Res> {
  _$TravelDnaFitPlacesCopyWithImpl(this._self, this._then);

  final TravelDnaFitPlaces _self;
  final $Res Function(TravelDnaFitPlaces) _then;

/// Create a copy of TravelDnaFitPlaces
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? places = null,}) {
  return _then(TravelDnaFitPlaces(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,places: null == places ? _self.places : places // ignore: cast_nullable_to_non_nullable
as List<TravelDnaPlace>,
  ));
}

}


/// Adds pattern-matching-related methods to [TravelDnaFitPlaces].
extension TravelDnaFitPlacesPatterns on TravelDnaFitPlaces {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TravelDnaFitPlaces value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TravelDnaFitPlaces() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TravelDnaFitPlaces value)  $default,){
final _that = this;
switch (_that) {
case _TravelDnaFitPlaces():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TravelDnaFitPlaces value)?  $default,){
final _that = this;
switch (_that) {
case _TravelDnaFitPlaces() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String type,  List<TravelDnaPlace> places)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TravelDnaFitPlaces() when $default != null:
return $default(_that.type,_that.places);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String type,  List<TravelDnaPlace> places)  $default,) {final _that = this;
switch (_that) {
case _TravelDnaFitPlaces():
return $default(_that.type,_that.places);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String type,  List<TravelDnaPlace> places)?  $default,) {final _that = this;
switch (_that) {
case _TravelDnaFitPlaces() when $default != null:
return $default(_that.type,_that.places);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TravelDnaFitPlaces implements TravelDnaFitPlaces {
  const _TravelDnaFitPlaces({required this.type, required  List<TravelDnaPlace> places}): _places = places;
  factory _TravelDnaFitPlaces.fromJson(Map<String, dynamic> json) => _$TravelDnaFitPlacesFromJson(json);

@override final  String type;
 final  List<TravelDnaPlace> _places;
@override List<TravelDnaPlace> get places {
  if (_places is EqualUnmodifiableListView) return _places;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_places);
}


/// Create a copy of TravelDnaFitPlaces
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TravelDnaFitPlacesCopyWith<_TravelDnaFitPlaces> get copyWith => __$TravelDnaFitPlacesCopyWithImpl<_TravelDnaFitPlaces>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TravelDnaFitPlacesToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TravelDnaFitPlaces&&(identical(other.type, type) || other.type == type)&&const DeepCollectionEquality().equals(other.places, _places));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,type,const DeepCollectionEquality().hash(_places));
}

@override
String toString() {
    return 'TravelDnaFitPlaces(type: $type, places: $places)';
}


}

/// @nodoc
abstract mixin class _$TravelDnaFitPlacesCopyWith<$Res> implements $TravelDnaFitPlacesCopyWith<$Res> {
  factory _$TravelDnaFitPlacesCopyWith(_TravelDnaFitPlaces value, $Res Function(_TravelDnaFitPlaces) _then) = __$TravelDnaFitPlacesCopyWithImpl;
@override @useResult
$Res call({
 String type, List<TravelDnaPlace> places
});




}
/// @nodoc
class __$TravelDnaFitPlacesCopyWithImpl<$Res>
    implements _$TravelDnaFitPlacesCopyWith<$Res> {
  __$TravelDnaFitPlacesCopyWithImpl(this._self, this._then);

  final _TravelDnaFitPlaces _self;
  final $Res Function(_TravelDnaFitPlaces) _then;

/// Create a copy of TravelDnaFitPlaces
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? places = null,}) {
  return _then(_TravelDnaFitPlaces(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,places: null == places ? _self._places : places // ignore: cast_nullable_to_non_nullable
as List<TravelDnaPlace>,
  ));
}


}


/// @nodoc
mixin _$TravelDnaPlace {

 String get id; String get name; String get city;
/// Create a copy of TravelDnaPlace
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TravelDnaPlaceCopyWith<TravelDnaPlace> get copyWith => _$TravelDnaPlaceCopyWithImpl<TravelDnaPlace>(this as TravelDnaPlace, _$identity);

  /// Serializes this TravelDnaPlace to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TravelDnaPlace;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TravelDnaPlace&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.city, _this.city) || other.city == _this.city));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TravelDnaPlace;
  return Object.hash(runtimeType,_this.id,_this.name,_this.city);
}

@override
String toString() {
  final _this = this as TravelDnaPlace;
  return 'TravelDnaPlace(id: ${_this.id}, name: ${_this.name}, city: ${_this.city})';
}


}

/// @nodoc
abstract mixin class $TravelDnaPlaceCopyWith<$Res>  {
  factory $TravelDnaPlaceCopyWith(TravelDnaPlace value, $Res Function(TravelDnaPlace) _then) = _$TravelDnaPlaceCopyWithImpl;
@useResult
$Res call({
 String id, String name, String city
});




}
/// @nodoc
class _$TravelDnaPlaceCopyWithImpl<$Res>
    implements $TravelDnaPlaceCopyWith<$Res> {
  _$TravelDnaPlaceCopyWithImpl(this._self, this._then);

  final TravelDnaPlace _self;
  final $Res Function(TravelDnaPlace) _then;

/// Create a copy of TravelDnaPlace
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? city = null,}) {
  return _then(TravelDnaPlace(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [TravelDnaPlace].
extension TravelDnaPlacePatterns on TravelDnaPlace {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TravelDnaPlace value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TravelDnaPlace() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TravelDnaPlace value)  $default,){
final _that = this;
switch (_that) {
case _TravelDnaPlace():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TravelDnaPlace value)?  $default,){
final _that = this;
switch (_that) {
case _TravelDnaPlace() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String city)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TravelDnaPlace() when $default != null:
return $default(_that.id,_that.name,_that.city);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String city)  $default,) {final _that = this;
switch (_that) {
case _TravelDnaPlace():
return $default(_that.id,_that.name,_that.city);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String city)?  $default,) {final _that = this;
switch (_that) {
case _TravelDnaPlace() when $default != null:
return $default(_that.id,_that.name,_that.city);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TravelDnaPlace implements TravelDnaPlace {
  const _TravelDnaPlace({required this.id, required this.name, required this.city});
  factory _TravelDnaPlace.fromJson(Map<String, dynamic> json) => _$TravelDnaPlaceFromJson(json);

@override final  String id;
@override final  String name;
@override final  String city;

/// Create a copy of TravelDnaPlace
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TravelDnaPlaceCopyWith<_TravelDnaPlace> get copyWith => __$TravelDnaPlaceCopyWithImpl<_TravelDnaPlace>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TravelDnaPlaceToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TravelDnaPlace&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.city, city) || other.city == city));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,name,city);
}

@override
String toString() {
    return 'TravelDnaPlace(id: $id, name: $name, city: $city)';
}


}

/// @nodoc
abstract mixin class _$TravelDnaPlaceCopyWith<$Res> implements $TravelDnaPlaceCopyWith<$Res> {
  factory _$TravelDnaPlaceCopyWith(_TravelDnaPlace value, $Res Function(_TravelDnaPlace) _then) = __$TravelDnaPlaceCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String city
});




}
/// @nodoc
class __$TravelDnaPlaceCopyWithImpl<$Res>
    implements _$TravelDnaPlaceCopyWith<$Res> {
  __$TravelDnaPlaceCopyWithImpl(this._self, this._then);

  final _TravelDnaPlace _self;
  final $Res Function(_TravelDnaPlace) _then;

/// Create a copy of TravelDnaPlace
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? city = null,}) {
  return _then(_TravelDnaPlace(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$TravelDnaJourney {

 String get tripId; String get name;@JsonKey(fromJson: travelDnaJsonInt) int get matchPercent; String get startDate; String get endDate; String? get coverImageUrl;@JsonKey(fromJson: travelDnaJsonInt) int get activityCount;
/// Create a copy of TravelDnaJourney
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TravelDnaJourneyCopyWith<TravelDnaJourney> get copyWith => _$TravelDnaJourneyCopyWithImpl<TravelDnaJourney>(this as TravelDnaJourney, _$identity);

  /// Serializes this TravelDnaJourney to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TravelDnaJourney;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TravelDnaJourney&&(identical(other.tripId, _this.tripId) || other.tripId == _this.tripId)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.matchPercent, _this.matchPercent) || other.matchPercent == _this.matchPercent)&&(identical(other.startDate, _this.startDate) || other.startDate == _this.startDate)&&(identical(other.endDate, _this.endDate) || other.endDate == _this.endDate)&&(identical(other.coverImageUrl, _this.coverImageUrl) || other.coverImageUrl == _this.coverImageUrl)&&(identical(other.activityCount, _this.activityCount) || other.activityCount == _this.activityCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TravelDnaJourney;
  return Object.hash(runtimeType,_this.tripId,_this.name,_this.matchPercent,_this.startDate,_this.endDate,_this.coverImageUrl,_this.activityCount);
}

@override
String toString() {
  final _this = this as TravelDnaJourney;
  return 'TravelDnaJourney(tripId: ${_this.tripId}, name: ${_this.name}, matchPercent: ${_this.matchPercent}, startDate: ${_this.startDate}, endDate: ${_this.endDate}, coverImageUrl: ${_this.coverImageUrl}, activityCount: ${_this.activityCount})';
}


}

/// @nodoc
abstract mixin class $TravelDnaJourneyCopyWith<$Res>  {
  factory $TravelDnaJourneyCopyWith(TravelDnaJourney value, $Res Function(TravelDnaJourney) _then) = _$TravelDnaJourneyCopyWithImpl;
@useResult
$Res call({
 String tripId, String name,@JsonKey(fromJson: travelDnaJsonInt) int matchPercent, String startDate, String endDate, String? coverImageUrl,@JsonKey(fromJson: travelDnaJsonInt) int activityCount
});




}
/// @nodoc
class _$TravelDnaJourneyCopyWithImpl<$Res>
    implements $TravelDnaJourneyCopyWith<$Res> {
  _$TravelDnaJourneyCopyWithImpl(this._self, this._then);

  final TravelDnaJourney _self;
  final $Res Function(TravelDnaJourney) _then;

/// Create a copy of TravelDnaJourney
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? tripId = null,Object? name = null,Object? matchPercent = null,Object? startDate = null,Object? endDate = null,Object? coverImageUrl = freezed,Object? activityCount = null,}) {
  return _then(TravelDnaJourney(
tripId: null == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,matchPercent: null == matchPercent ? _self.matchPercent : matchPercent // ignore: cast_nullable_to_non_nullable
as int,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as String,endDate: null == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as String,coverImageUrl: freezed == coverImageUrl ? _self.coverImageUrl : coverImageUrl // ignore: cast_nullable_to_non_nullable
as String?,activityCount: null == activityCount ? _self.activityCount : activityCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [TravelDnaJourney].
extension TravelDnaJourneyPatterns on TravelDnaJourney {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TravelDnaJourney value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TravelDnaJourney() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TravelDnaJourney value)  $default,){
final _that = this;
switch (_that) {
case _TravelDnaJourney():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TravelDnaJourney value)?  $default,){
final _that = this;
switch (_that) {
case _TravelDnaJourney() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String tripId,  String name, @JsonKey(fromJson: travelDnaJsonInt)  int matchPercent,  String startDate,  String endDate,  String? coverImageUrl, @JsonKey(fromJson: travelDnaJsonInt)  int activityCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TravelDnaJourney() when $default != null:
return $default(_that.tripId,_that.name,_that.matchPercent,_that.startDate,_that.endDate,_that.coverImageUrl,_that.activityCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String tripId,  String name, @JsonKey(fromJson: travelDnaJsonInt)  int matchPercent,  String startDate,  String endDate,  String? coverImageUrl, @JsonKey(fromJson: travelDnaJsonInt)  int activityCount)  $default,) {final _that = this;
switch (_that) {
case _TravelDnaJourney():
return $default(_that.tripId,_that.name,_that.matchPercent,_that.startDate,_that.endDate,_that.coverImageUrl,_that.activityCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String tripId,  String name, @JsonKey(fromJson: travelDnaJsonInt)  int matchPercent,  String startDate,  String endDate,  String? coverImageUrl, @JsonKey(fromJson: travelDnaJsonInt)  int activityCount)?  $default,) {final _that = this;
switch (_that) {
case _TravelDnaJourney() when $default != null:
return $default(_that.tripId,_that.name,_that.matchPercent,_that.startDate,_that.endDate,_that.coverImageUrl,_that.activityCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TravelDnaJourney implements TravelDnaJourney {
  const _TravelDnaJourney({required this.tripId, required this.name, @JsonKey(fromJson: travelDnaJsonInt) required this.matchPercent, required this.startDate, required this.endDate, this.coverImageUrl, @JsonKey(fromJson: travelDnaJsonInt) required this.activityCount});
  factory _TravelDnaJourney.fromJson(Map<String, dynamic> json) => _$TravelDnaJourneyFromJson(json);

@override final  String tripId;
@override final  String name;
@override@JsonKey(fromJson: travelDnaJsonInt) final  int matchPercent;
@override final  String startDate;
@override final  String endDate;
@override final  String? coverImageUrl;
@override@JsonKey(fromJson: travelDnaJsonInt) final  int activityCount;

/// Create a copy of TravelDnaJourney
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TravelDnaJourneyCopyWith<_TravelDnaJourney> get copyWith => __$TravelDnaJourneyCopyWithImpl<_TravelDnaJourney>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TravelDnaJourneyToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TravelDnaJourney&&(identical(other.tripId, tripId) || other.tripId == tripId)&&(identical(other.name, name) || other.name == name)&&(identical(other.matchPercent, matchPercent) || other.matchPercent == matchPercent)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.coverImageUrl, coverImageUrl) || other.coverImageUrl == coverImageUrl)&&(identical(other.activityCount, activityCount) || other.activityCount == activityCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,tripId,name,matchPercent,startDate,endDate,coverImageUrl,activityCount);
}

@override
String toString() {
    return 'TravelDnaJourney(tripId: $tripId, name: $name, matchPercent: $matchPercent, startDate: $startDate, endDate: $endDate, coverImageUrl: $coverImageUrl, activityCount: $activityCount)';
}


}

/// @nodoc
abstract mixin class _$TravelDnaJourneyCopyWith<$Res> implements $TravelDnaJourneyCopyWith<$Res> {
  factory _$TravelDnaJourneyCopyWith(_TravelDnaJourney value, $Res Function(_TravelDnaJourney) _then) = __$TravelDnaJourneyCopyWithImpl;
@override @useResult
$Res call({
 String tripId, String name,@JsonKey(fromJson: travelDnaJsonInt) int matchPercent, String startDate, String endDate, String? coverImageUrl,@JsonKey(fromJson: travelDnaJsonInt) int activityCount
});




}
/// @nodoc
class __$TravelDnaJourneyCopyWithImpl<$Res>
    implements _$TravelDnaJourneyCopyWith<$Res> {
  __$TravelDnaJourneyCopyWithImpl(this._self, this._then);

  final _TravelDnaJourney _self;
  final $Res Function(_TravelDnaJourney) _then;

/// Create a copy of TravelDnaJourney
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? tripId = null,Object? name = null,Object? matchPercent = null,Object? startDate = null,Object? endDate = null,Object? coverImageUrl = freezed,Object? activityCount = null,}) {
  return _then(_TravelDnaJourney(
tripId: null == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,matchPercent: null == matchPercent ? _self.matchPercent : matchPercent // ignore: cast_nullable_to_non_nullable
as int,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as String,endDate: null == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as String,coverImageUrl: freezed == coverImageUrl ? _self.coverImageUrl : coverImageUrl // ignore: cast_nullable_to_non_nullable
as String?,activityCount: null == activityCount ? _self.activityCount : activityCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$TravelDnaCompanion {

 String get userId; String get displayName; String get username; String? get avatarUrl;@JsonKey(fromJson: travelDnaJsonInt) int get matchPercent; TravelDnaPersona get persona;
/// Create a copy of TravelDnaCompanion
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TravelDnaCompanionCopyWith<TravelDnaCompanion> get copyWith => _$TravelDnaCompanionCopyWithImpl<TravelDnaCompanion>(this as TravelDnaCompanion, _$identity);

  /// Serializes this TravelDnaCompanion to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TravelDnaCompanion;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TravelDnaCompanion&&(identical(other.userId, _this.userId) || other.userId == _this.userId)&&(identical(other.displayName, _this.displayName) || other.displayName == _this.displayName)&&(identical(other.username, _this.username) || other.username == _this.username)&&(identical(other.avatarUrl, _this.avatarUrl) || other.avatarUrl == _this.avatarUrl)&&(identical(other.matchPercent, _this.matchPercent) || other.matchPercent == _this.matchPercent)&&(identical(other.persona, _this.persona) || other.persona == _this.persona));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TravelDnaCompanion;
  return Object.hash(runtimeType,_this.userId,_this.displayName,_this.username,_this.avatarUrl,_this.matchPercent,_this.persona);
}

@override
String toString() {
  final _this = this as TravelDnaCompanion;
  return 'TravelDnaCompanion(userId: ${_this.userId}, displayName: ${_this.displayName}, username: ${_this.username}, avatarUrl: ${_this.avatarUrl}, matchPercent: ${_this.matchPercent}, persona: ${_this.persona})';
}


}

/// @nodoc
abstract mixin class $TravelDnaCompanionCopyWith<$Res>  {
  factory $TravelDnaCompanionCopyWith(TravelDnaCompanion value, $Res Function(TravelDnaCompanion) _then) = _$TravelDnaCompanionCopyWithImpl;
@useResult
$Res call({
 String userId, String displayName, String username, String? avatarUrl,@JsonKey(fromJson: travelDnaJsonInt) int matchPercent, TravelDnaPersona persona
});


$TravelDnaPersonaCopyWith<$Res> get persona;

}
/// @nodoc
class _$TravelDnaCompanionCopyWithImpl<$Res>
    implements $TravelDnaCompanionCopyWith<$Res> {
  _$TravelDnaCompanionCopyWithImpl(this._self, this._then);

  final TravelDnaCompanion _self;
  final $Res Function(TravelDnaCompanion) _then;

/// Create a copy of TravelDnaCompanion
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? displayName = null,Object? username = null,Object? avatarUrl = freezed,Object? matchPercent = null,Object? persona = null,}) {
  return _then(TravelDnaCompanion(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,matchPercent: null == matchPercent ? _self.matchPercent : matchPercent // ignore: cast_nullable_to_non_nullable
as int,persona: null == persona ? _self.persona : persona // ignore: cast_nullable_to_non_nullable
as TravelDnaPersona,
  ));
}
/// Create a copy of TravelDnaCompanion
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TravelDnaPersonaCopyWith<$Res> get persona {
  
  return $TravelDnaPersonaCopyWith<$Res>(_self.persona, (value) {
    return _then(_self.copyWith(persona: value));
  });
}
}


/// Adds pattern-matching-related methods to [TravelDnaCompanion].
extension TravelDnaCompanionPatterns on TravelDnaCompanion {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TravelDnaCompanion value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TravelDnaCompanion() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TravelDnaCompanion value)  $default,){
final _that = this;
switch (_that) {
case _TravelDnaCompanion():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TravelDnaCompanion value)?  $default,){
final _that = this;
switch (_that) {
case _TravelDnaCompanion() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String userId,  String displayName,  String username,  String? avatarUrl, @JsonKey(fromJson: travelDnaJsonInt)  int matchPercent,  TravelDnaPersona persona)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TravelDnaCompanion() when $default != null:
return $default(_that.userId,_that.displayName,_that.username,_that.avatarUrl,_that.matchPercent,_that.persona);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String userId,  String displayName,  String username,  String? avatarUrl, @JsonKey(fromJson: travelDnaJsonInt)  int matchPercent,  TravelDnaPersona persona)  $default,) {final _that = this;
switch (_that) {
case _TravelDnaCompanion():
return $default(_that.userId,_that.displayName,_that.username,_that.avatarUrl,_that.matchPercent,_that.persona);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String userId,  String displayName,  String username,  String? avatarUrl, @JsonKey(fromJson: travelDnaJsonInt)  int matchPercent,  TravelDnaPersona persona)?  $default,) {final _that = this;
switch (_that) {
case _TravelDnaCompanion() when $default != null:
return $default(_that.userId,_that.displayName,_that.username,_that.avatarUrl,_that.matchPercent,_that.persona);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TravelDnaCompanion implements TravelDnaCompanion {
  const _TravelDnaCompanion({required this.userId, required this.displayName, required this.username, this.avatarUrl, @JsonKey(fromJson: travelDnaJsonInt) required this.matchPercent, required this.persona});
  factory _TravelDnaCompanion.fromJson(Map<String, dynamic> json) => _$TravelDnaCompanionFromJson(json);

@override final  String userId;
@override final  String displayName;
@override final  String username;
@override final  String? avatarUrl;
@override@JsonKey(fromJson: travelDnaJsonInt) final  int matchPercent;
@override final  TravelDnaPersona persona;

/// Create a copy of TravelDnaCompanion
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TravelDnaCompanionCopyWith<_TravelDnaCompanion> get copyWith => __$TravelDnaCompanionCopyWithImpl<_TravelDnaCompanion>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TravelDnaCompanionToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TravelDnaCompanion&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.username, username) || other.username == username)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.matchPercent, matchPercent) || other.matchPercent == matchPercent)&&(identical(other.persona, persona) || other.persona == persona));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,userId,displayName,username,avatarUrl,matchPercent,persona);
}

@override
String toString() {
    return 'TravelDnaCompanion(userId: $userId, displayName: $displayName, username: $username, avatarUrl: $avatarUrl, matchPercent: $matchPercent, persona: $persona)';
}


}

/// @nodoc
abstract mixin class _$TravelDnaCompanionCopyWith<$Res> implements $TravelDnaCompanionCopyWith<$Res> {
  factory _$TravelDnaCompanionCopyWith(_TravelDnaCompanion value, $Res Function(_TravelDnaCompanion) _then) = __$TravelDnaCompanionCopyWithImpl;
@override @useResult
$Res call({
 String userId, String displayName, String username, String? avatarUrl,@JsonKey(fromJson: travelDnaJsonInt) int matchPercent, TravelDnaPersona persona
});


@override $TravelDnaPersonaCopyWith<$Res> get persona;

}
/// @nodoc
class __$TravelDnaCompanionCopyWithImpl<$Res>
    implements _$TravelDnaCompanionCopyWith<$Res> {
  __$TravelDnaCompanionCopyWithImpl(this._self, this._then);

  final _TravelDnaCompanion _self;
  final $Res Function(_TravelDnaCompanion) _then;

/// Create a copy of TravelDnaCompanion
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? displayName = null,Object? username = null,Object? avatarUrl = freezed,Object? matchPercent = null,Object? persona = null,}) {
  return _then(_TravelDnaCompanion(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,matchPercent: null == matchPercent ? _self.matchPercent : matchPercent // ignore: cast_nullable_to_non_nullable
as int,persona: null == persona ? _self.persona : persona // ignore: cast_nullable_to_non_nullable
as TravelDnaPersona,
  ));
}

/// Create a copy of TravelDnaCompanion
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TravelDnaPersonaCopyWith<$Res> get persona {
  
  return $TravelDnaPersonaCopyWith<$Res>(_self.persona, (value) {
    return _then(_self.copyWith(persona: value));
  });
}
}


/// @nodoc
mixin _$TravelDnaPersona {

 String get name; String get icon;
/// Create a copy of TravelDnaPersona
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TravelDnaPersonaCopyWith<TravelDnaPersona> get copyWith => _$TravelDnaPersonaCopyWithImpl<TravelDnaPersona>(this as TravelDnaPersona, _$identity);

  /// Serializes this TravelDnaPersona to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TravelDnaPersona;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TravelDnaPersona&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.icon, _this.icon) || other.icon == _this.icon));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TravelDnaPersona;
  return Object.hash(runtimeType,_this.name,_this.icon);
}

@override
String toString() {
  final _this = this as TravelDnaPersona;
  return 'TravelDnaPersona(name: ${_this.name}, icon: ${_this.icon})';
}


}

/// @nodoc
abstract mixin class $TravelDnaPersonaCopyWith<$Res>  {
  factory $TravelDnaPersonaCopyWith(TravelDnaPersona value, $Res Function(TravelDnaPersona) _then) = _$TravelDnaPersonaCopyWithImpl;
@useResult
$Res call({
 String name, String icon
});




}
/// @nodoc
class _$TravelDnaPersonaCopyWithImpl<$Res>
    implements $TravelDnaPersonaCopyWith<$Res> {
  _$TravelDnaPersonaCopyWithImpl(this._self, this._then);

  final TravelDnaPersona _self;
  final $Res Function(TravelDnaPersona) _then;

/// Create a copy of TravelDnaPersona
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? icon = null,}) {
  return _then(TravelDnaPersona(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [TravelDnaPersona].
extension TravelDnaPersonaPatterns on TravelDnaPersona {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TravelDnaPersona value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TravelDnaPersona() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TravelDnaPersona value)  $default,){
final _that = this;
switch (_that) {
case _TravelDnaPersona():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TravelDnaPersona value)?  $default,){
final _that = this;
switch (_that) {
case _TravelDnaPersona() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String icon)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TravelDnaPersona() when $default != null:
return $default(_that.name,_that.icon);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String icon)  $default,) {final _that = this;
switch (_that) {
case _TravelDnaPersona():
return $default(_that.name,_that.icon);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String icon)?  $default,) {final _that = this;
switch (_that) {
case _TravelDnaPersona() when $default != null:
return $default(_that.name,_that.icon);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TravelDnaPersona implements TravelDnaPersona {
  const _TravelDnaPersona({required this.name, required this.icon});
  factory _TravelDnaPersona.fromJson(Map<String, dynamic> json) => _$TravelDnaPersonaFromJson(json);

@override final  String name;
@override final  String icon;

/// Create a copy of TravelDnaPersona
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TravelDnaPersonaCopyWith<_TravelDnaPersona> get copyWith => __$TravelDnaPersonaCopyWithImpl<_TravelDnaPersona>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TravelDnaPersonaToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TravelDnaPersona&&(identical(other.name, name) || other.name == name)&&(identical(other.icon, icon) || other.icon == icon));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,name,icon);
}

@override
String toString() {
    return 'TravelDnaPersona(name: $name, icon: $icon)';
}


}

/// @nodoc
abstract mixin class _$TravelDnaPersonaCopyWith<$Res> implements $TravelDnaPersonaCopyWith<$Res> {
  factory _$TravelDnaPersonaCopyWith(_TravelDnaPersona value, $Res Function(_TravelDnaPersona) _then) = __$TravelDnaPersonaCopyWithImpl;
@override @useResult
$Res call({
 String name, String icon
});




}
/// @nodoc
class __$TravelDnaPersonaCopyWithImpl<$Res>
    implements _$TravelDnaPersonaCopyWith<$Res> {
  __$TravelDnaPersonaCopyWithImpl(this._self, this._then);

  final _TravelDnaPersona _self;
  final $Res Function(_TravelDnaPersona) _then;

/// Create a copy of TravelDnaPersona
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? icon = null,}) {
  return _then(_TravelDnaPersona(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
