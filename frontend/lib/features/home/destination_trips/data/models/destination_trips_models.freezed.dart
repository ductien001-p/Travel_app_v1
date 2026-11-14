// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'destination_trips_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DestinationTripsPage {

 DestinationProfile get profile; List<CommunityTripCard> get trips; Map<String, String> get tripTypesById; List<DestinationSpot> get spots; int get openTripCount; int get spotsTotal;
/// Create a copy of DestinationTripsPage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DestinationTripsPageCopyWith<DestinationTripsPage> get copyWith => _$DestinationTripsPageCopyWithImpl<DestinationTripsPage>(this as DestinationTripsPage, _$identity);

  /// Serializes this DestinationTripsPage to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as DestinationTripsPage;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DestinationTripsPage&&(identical(other.profile, _this.profile) || other.profile == _this.profile)&&const DeepCollectionEquality().equals(other.trips, _this.trips)&&const DeepCollectionEquality().equals(other.tripTypesById, _this.tripTypesById)&&const DeepCollectionEquality().equals(other.spots, _this.spots)&&(identical(other.openTripCount, _this.openTripCount) || other.openTripCount == _this.openTripCount)&&(identical(other.spotsTotal, _this.spotsTotal) || other.spotsTotal == _this.spotsTotal));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as DestinationTripsPage;
  return Object.hash(runtimeType,_this.profile,const DeepCollectionEquality().hash(_this.trips),const DeepCollectionEquality().hash(_this.tripTypesById),const DeepCollectionEquality().hash(_this.spots),_this.openTripCount,_this.spotsTotal);
}

@override
String toString() {
  final _this = this as DestinationTripsPage;
  return 'DestinationTripsPage(profile: ${_this.profile}, trips: ${_this.trips}, tripTypesById: ${_this.tripTypesById}, spots: ${_this.spots}, openTripCount: ${_this.openTripCount}, spotsTotal: ${_this.spotsTotal})';
}


}

/// @nodoc
abstract mixin class $DestinationTripsPageCopyWith<$Res>  {
  factory $DestinationTripsPageCopyWith(DestinationTripsPage value, $Res Function(DestinationTripsPage) _then) = _$DestinationTripsPageCopyWithImpl;
@useResult
$Res call({
 DestinationProfile profile, List<CommunityTripCard> trips, Map<String, String> tripTypesById, List<DestinationSpot> spots, int openTripCount, int spotsTotal
});


$DestinationProfileCopyWith<$Res> get profile;

}
/// @nodoc
class _$DestinationTripsPageCopyWithImpl<$Res>
    implements $DestinationTripsPageCopyWith<$Res> {
  _$DestinationTripsPageCopyWithImpl(this._self, this._then);

  final DestinationTripsPage _self;
  final $Res Function(DestinationTripsPage) _then;

/// Create a copy of DestinationTripsPage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? profile = null,Object? trips = null,Object? tripTypesById = null,Object? spots = null,Object? openTripCount = null,Object? spotsTotal = null,}) {
  return _then(DestinationTripsPage(
profile: null == profile ? _self.profile : profile // ignore: cast_nullable_to_non_nullable
as DestinationProfile,trips: null == trips ? _self.trips : trips // ignore: cast_nullable_to_non_nullable
as List<CommunityTripCard>,tripTypesById: null == tripTypesById ? _self.tripTypesById : tripTypesById // ignore: cast_nullable_to_non_nullable
as Map<String, String>,spots: null == spots ? _self.spots : spots // ignore: cast_nullable_to_non_nullable
as List<DestinationSpot>,openTripCount: null == openTripCount ? _self.openTripCount : openTripCount // ignore: cast_nullable_to_non_nullable
as int,spotsTotal: null == spotsTotal ? _self.spotsTotal : spotsTotal // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of DestinationTripsPage
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DestinationProfileCopyWith<$Res> get profile {
  
  return $DestinationProfileCopyWith<$Res>(_self.profile, (value) {
    return _then(_self.copyWith(profile: value));
  });
}
}


/// Adds pattern-matching-related methods to [DestinationTripsPage].
extension DestinationTripsPagePatterns on DestinationTripsPage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DestinationTripsPage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DestinationTripsPage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DestinationTripsPage value)  $default,){
final _that = this;
switch (_that) {
case _DestinationTripsPage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DestinationTripsPage value)?  $default,){
final _that = this;
switch (_that) {
case _DestinationTripsPage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DestinationProfile profile,  List<CommunityTripCard> trips,  Map<String, String> tripTypesById,  List<DestinationSpot> spots,  int openTripCount,  int spotsTotal)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DestinationTripsPage() when $default != null:
return $default(_that.profile,_that.trips,_that.tripTypesById,_that.spots,_that.openTripCount,_that.spotsTotal);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DestinationProfile profile,  List<CommunityTripCard> trips,  Map<String, String> tripTypesById,  List<DestinationSpot> spots,  int openTripCount,  int spotsTotal)  $default,) {final _that = this;
switch (_that) {
case _DestinationTripsPage():
return $default(_that.profile,_that.trips,_that.tripTypesById,_that.spots,_that.openTripCount,_that.spotsTotal);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DestinationProfile profile,  List<CommunityTripCard> trips,  Map<String, String> tripTypesById,  List<DestinationSpot> spots,  int openTripCount,  int spotsTotal)?  $default,) {final _that = this;
switch (_that) {
case _DestinationTripsPage() when $default != null:
return $default(_that.profile,_that.trips,_that.tripTypesById,_that.spots,_that.openTripCount,_that.spotsTotal);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DestinationTripsPage implements DestinationTripsPage {
  const _DestinationTripsPage({required this.profile, required  List<CommunityTripCard> trips,  Map<String, String> tripTypesById = const <String, String>{}, required  List<DestinationSpot> spots, required this.openTripCount, this.spotsTotal = 0}): _trips = trips,_tripTypesById = tripTypesById,_spots = spots;
  factory _DestinationTripsPage.fromJson(Map<String, dynamic> json) => _$DestinationTripsPageFromJson(json);

@override final  DestinationProfile profile;
 final  List<CommunityTripCard> _trips;
@override List<CommunityTripCard> get trips {
  if (_trips is EqualUnmodifiableListView) return _trips;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_trips);
}

 final  Map<String, String> _tripTypesById;
@override@JsonKey() Map<String, String> get tripTypesById {
  if (_tripTypesById is EqualUnmodifiableMapView) return _tripTypesById;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_tripTypesById);
}

 final  List<DestinationSpot> _spots;
@override List<DestinationSpot> get spots {
  if (_spots is EqualUnmodifiableListView) return _spots;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_spots);
}

@override final  int openTripCount;
@override@JsonKey() final  int spotsTotal;

/// Create a copy of DestinationTripsPage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DestinationTripsPageCopyWith<_DestinationTripsPage> get copyWith => __$DestinationTripsPageCopyWithImpl<_DestinationTripsPage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DestinationTripsPageToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _DestinationTripsPage&&(identical(other.profile, profile) || other.profile == profile)&&const DeepCollectionEquality().equals(other.trips, _trips)&&const DeepCollectionEquality().equals(other.tripTypesById, _tripTypesById)&&const DeepCollectionEquality().equals(other.spots, _spots)&&(identical(other.openTripCount, openTripCount) || other.openTripCount == openTripCount)&&(identical(other.spotsTotal, spotsTotal) || other.spotsTotal == spotsTotal));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,profile,const DeepCollectionEquality().hash(_trips),const DeepCollectionEquality().hash(_tripTypesById),const DeepCollectionEquality().hash(_spots),openTripCount,spotsTotal);
}

@override
String toString() {
    return 'DestinationTripsPage(profile: $profile, trips: $trips, tripTypesById: $tripTypesById, spots: $spots, openTripCount: $openTripCount, spotsTotal: $spotsTotal)';
}


}

/// @nodoc
abstract mixin class _$DestinationTripsPageCopyWith<$Res> implements $DestinationTripsPageCopyWith<$Res> {
  factory _$DestinationTripsPageCopyWith(_DestinationTripsPage value, $Res Function(_DestinationTripsPage) _then) = __$DestinationTripsPageCopyWithImpl;
@override @useResult
$Res call({
 DestinationProfile profile, List<CommunityTripCard> trips, Map<String, String> tripTypesById, List<DestinationSpot> spots, int openTripCount, int spotsTotal
});


@override $DestinationProfileCopyWith<$Res> get profile;

}
/// @nodoc
class __$DestinationTripsPageCopyWithImpl<$Res>
    implements _$DestinationTripsPageCopyWith<$Res> {
  __$DestinationTripsPageCopyWithImpl(this._self, this._then);

  final _DestinationTripsPage _self;
  final $Res Function(_DestinationTripsPage) _then;

/// Create a copy of DestinationTripsPage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? profile = null,Object? trips = null,Object? tripTypesById = null,Object? spots = null,Object? openTripCount = null,Object? spotsTotal = null,}) {
  return _then(_DestinationTripsPage(
profile: null == profile ? _self.profile : profile // ignore: cast_nullable_to_non_nullable
as DestinationProfile,trips: null == trips ? _self._trips : trips // ignore: cast_nullable_to_non_nullable
as List<CommunityTripCard>,tripTypesById: null == tripTypesById ? _self._tripTypesById : tripTypesById // ignore: cast_nullable_to_non_nullable
as Map<String, String>,spots: null == spots ? _self._spots : spots // ignore: cast_nullable_to_non_nullable
as List<DestinationSpot>,openTripCount: null == openTripCount ? _self.openTripCount : openTripCount // ignore: cast_nullable_to_non_nullable
as int,spotsTotal: null == spotsTotal ? _self.spotsTotal : spotsTotal // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of DestinationTripsPage
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DestinationProfileCopyWith<$Res> get profile {
  
  return $DestinationProfileCopyWith<$Res>(_self.profile, (value) {
    return _then(_self.copyWith(profile: value));
  });
}
}


/// @nodoc
mixin _$DestinationProfile {

 String get catalogId; String get name; String get regionLabel; String get coverImageUrl; String get tagline; String get summary; String? get weatherLabel; String? get altitudeLabel; String? get seasonLabel; String? get averageCostLabel;
/// Create a copy of DestinationProfile
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DestinationProfileCopyWith<DestinationProfile> get copyWith => _$DestinationProfileCopyWithImpl<DestinationProfile>(this as DestinationProfile, _$identity);

  /// Serializes this DestinationProfile to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as DestinationProfile;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DestinationProfile&&(identical(other.catalogId, _this.catalogId) || other.catalogId == _this.catalogId)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.regionLabel, _this.regionLabel) || other.regionLabel == _this.regionLabel)&&(identical(other.coverImageUrl, _this.coverImageUrl) || other.coverImageUrl == _this.coverImageUrl)&&(identical(other.tagline, _this.tagline) || other.tagline == _this.tagline)&&(identical(other.summary, _this.summary) || other.summary == _this.summary)&&(identical(other.weatherLabel, _this.weatherLabel) || other.weatherLabel == _this.weatherLabel)&&(identical(other.altitudeLabel, _this.altitudeLabel) || other.altitudeLabel == _this.altitudeLabel)&&(identical(other.seasonLabel, _this.seasonLabel) || other.seasonLabel == _this.seasonLabel)&&(identical(other.averageCostLabel, _this.averageCostLabel) || other.averageCostLabel == _this.averageCostLabel));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as DestinationProfile;
  return Object.hash(runtimeType,_this.catalogId,_this.name,_this.regionLabel,_this.coverImageUrl,_this.tagline,_this.summary,_this.weatherLabel,_this.altitudeLabel,_this.seasonLabel,_this.averageCostLabel);
}

@override
String toString() {
  final _this = this as DestinationProfile;
  return 'DestinationProfile(catalogId: ${_this.catalogId}, name: ${_this.name}, regionLabel: ${_this.regionLabel}, coverImageUrl: ${_this.coverImageUrl}, tagline: ${_this.tagline}, summary: ${_this.summary}, weatherLabel: ${_this.weatherLabel}, altitudeLabel: ${_this.altitudeLabel}, seasonLabel: ${_this.seasonLabel}, averageCostLabel: ${_this.averageCostLabel})';
}


}

/// @nodoc
abstract mixin class $DestinationProfileCopyWith<$Res>  {
  factory $DestinationProfileCopyWith(DestinationProfile value, $Res Function(DestinationProfile) _then) = _$DestinationProfileCopyWithImpl;
@useResult
$Res call({
 String catalogId, String name, String regionLabel, String coverImageUrl, String tagline, String summary, String? weatherLabel, String? altitudeLabel, String? seasonLabel, String? averageCostLabel
});




}
/// @nodoc
class _$DestinationProfileCopyWithImpl<$Res>
    implements $DestinationProfileCopyWith<$Res> {
  _$DestinationProfileCopyWithImpl(this._self, this._then);

  final DestinationProfile _self;
  final $Res Function(DestinationProfile) _then;

/// Create a copy of DestinationProfile
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? catalogId = null,Object? name = null,Object? regionLabel = null,Object? coverImageUrl = null,Object? tagline = null,Object? summary = null,Object? weatherLabel = freezed,Object? altitudeLabel = freezed,Object? seasonLabel = freezed,Object? averageCostLabel = freezed,}) {
  return _then(DestinationProfile(
catalogId: null == catalogId ? _self.catalogId : catalogId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,regionLabel: null == regionLabel ? _self.regionLabel : regionLabel // ignore: cast_nullable_to_non_nullable
as String,coverImageUrl: null == coverImageUrl ? _self.coverImageUrl : coverImageUrl // ignore: cast_nullable_to_non_nullable
as String,tagline: null == tagline ? _self.tagline : tagline // ignore: cast_nullable_to_non_nullable
as String,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as String,weatherLabel: freezed == weatherLabel ? _self.weatherLabel : weatherLabel // ignore: cast_nullable_to_non_nullable
as String?,altitudeLabel: freezed == altitudeLabel ? _self.altitudeLabel : altitudeLabel // ignore: cast_nullable_to_non_nullable
as String?,seasonLabel: freezed == seasonLabel ? _self.seasonLabel : seasonLabel // ignore: cast_nullable_to_non_nullable
as String?,averageCostLabel: freezed == averageCostLabel ? _self.averageCostLabel : averageCostLabel // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [DestinationProfile].
extension DestinationProfilePatterns on DestinationProfile {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DestinationProfile value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DestinationProfile() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DestinationProfile value)  $default,){
final _that = this;
switch (_that) {
case _DestinationProfile():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DestinationProfile value)?  $default,){
final _that = this;
switch (_that) {
case _DestinationProfile() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String catalogId,  String name,  String regionLabel,  String coverImageUrl,  String tagline,  String summary,  String? weatherLabel,  String? altitudeLabel,  String? seasonLabel,  String? averageCostLabel)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DestinationProfile() when $default != null:
return $default(_that.catalogId,_that.name,_that.regionLabel,_that.coverImageUrl,_that.tagline,_that.summary,_that.weatherLabel,_that.altitudeLabel,_that.seasonLabel,_that.averageCostLabel);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String catalogId,  String name,  String regionLabel,  String coverImageUrl,  String tagline,  String summary,  String? weatherLabel,  String? altitudeLabel,  String? seasonLabel,  String? averageCostLabel)  $default,) {final _that = this;
switch (_that) {
case _DestinationProfile():
return $default(_that.catalogId,_that.name,_that.regionLabel,_that.coverImageUrl,_that.tagline,_that.summary,_that.weatherLabel,_that.altitudeLabel,_that.seasonLabel,_that.averageCostLabel);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String catalogId,  String name,  String regionLabel,  String coverImageUrl,  String tagline,  String summary,  String? weatherLabel,  String? altitudeLabel,  String? seasonLabel,  String? averageCostLabel)?  $default,) {final _that = this;
switch (_that) {
case _DestinationProfile() when $default != null:
return $default(_that.catalogId,_that.name,_that.regionLabel,_that.coverImageUrl,_that.tagline,_that.summary,_that.weatherLabel,_that.altitudeLabel,_that.seasonLabel,_that.averageCostLabel);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DestinationProfile implements DestinationProfile {
  const _DestinationProfile({required this.catalogId, required this.name, required this.regionLabel, required this.coverImageUrl, required this.tagline, required this.summary, this.weatherLabel, this.altitudeLabel, this.seasonLabel, this.averageCostLabel});
  factory _DestinationProfile.fromJson(Map<String, dynamic> json) => _$DestinationProfileFromJson(json);

@override final  String catalogId;
@override final  String name;
@override final  String regionLabel;
@override final  String coverImageUrl;
@override final  String tagline;
@override final  String summary;
@override final  String? weatherLabel;
@override final  String? altitudeLabel;
@override final  String? seasonLabel;
@override final  String? averageCostLabel;

/// Create a copy of DestinationProfile
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DestinationProfileCopyWith<_DestinationProfile> get copyWith => __$DestinationProfileCopyWithImpl<_DestinationProfile>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DestinationProfileToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _DestinationProfile&&(identical(other.catalogId, catalogId) || other.catalogId == catalogId)&&(identical(other.name, name) || other.name == name)&&(identical(other.regionLabel, regionLabel) || other.regionLabel == regionLabel)&&(identical(other.coverImageUrl, coverImageUrl) || other.coverImageUrl == coverImageUrl)&&(identical(other.tagline, tagline) || other.tagline == tagline)&&(identical(other.summary, summary) || other.summary == summary)&&(identical(other.weatherLabel, weatherLabel) || other.weatherLabel == weatherLabel)&&(identical(other.altitudeLabel, altitudeLabel) || other.altitudeLabel == altitudeLabel)&&(identical(other.seasonLabel, seasonLabel) || other.seasonLabel == seasonLabel)&&(identical(other.averageCostLabel, averageCostLabel) || other.averageCostLabel == averageCostLabel));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,catalogId,name,regionLabel,coverImageUrl,tagline,summary,weatherLabel,altitudeLabel,seasonLabel,averageCostLabel);
}

@override
String toString() {
    return 'DestinationProfile(catalogId: $catalogId, name: $name, regionLabel: $regionLabel, coverImageUrl: $coverImageUrl, tagline: $tagline, summary: $summary, weatherLabel: $weatherLabel, altitudeLabel: $altitudeLabel, seasonLabel: $seasonLabel, averageCostLabel: $averageCostLabel)';
}


}

/// @nodoc
abstract mixin class _$DestinationProfileCopyWith<$Res> implements $DestinationProfileCopyWith<$Res> {
  factory _$DestinationProfileCopyWith(_DestinationProfile value, $Res Function(_DestinationProfile) _then) = __$DestinationProfileCopyWithImpl;
@override @useResult
$Res call({
 String catalogId, String name, String regionLabel, String coverImageUrl, String tagline, String summary, String? weatherLabel, String? altitudeLabel, String? seasonLabel, String? averageCostLabel
});




}
/// @nodoc
class __$DestinationProfileCopyWithImpl<$Res>
    implements _$DestinationProfileCopyWith<$Res> {
  __$DestinationProfileCopyWithImpl(this._self, this._then);

  final _DestinationProfile _self;
  final $Res Function(_DestinationProfile) _then;

/// Create a copy of DestinationProfile
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? catalogId = null,Object? name = null,Object? regionLabel = null,Object? coverImageUrl = null,Object? tagline = null,Object? summary = null,Object? weatherLabel = freezed,Object? altitudeLabel = freezed,Object? seasonLabel = freezed,Object? averageCostLabel = freezed,}) {
  return _then(_DestinationProfile(
catalogId: null == catalogId ? _self.catalogId : catalogId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,regionLabel: null == regionLabel ? _self.regionLabel : regionLabel // ignore: cast_nullable_to_non_nullable
as String,coverImageUrl: null == coverImageUrl ? _self.coverImageUrl : coverImageUrl // ignore: cast_nullable_to_non_nullable
as String,tagline: null == tagline ? _self.tagline : tagline // ignore: cast_nullable_to_non_nullable
as String,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as String,weatherLabel: freezed == weatherLabel ? _self.weatherLabel : weatherLabel // ignore: cast_nullable_to_non_nullable
as String?,altitudeLabel: freezed == altitudeLabel ? _self.altitudeLabel : altitudeLabel // ignore: cast_nullable_to_non_nullable
as String?,seasonLabel: freezed == seasonLabel ? _self.seasonLabel : seasonLabel // ignore: cast_nullable_to_non_nullable
as String?,averageCostLabel: freezed == averageCostLabel ? _self.averageCostLabel : averageCostLabel // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$DestinationSpot {

 String get id; String get name; String get imageUrl; double? get rating; String get categoryLabel; String get note;
/// Create a copy of DestinationSpot
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DestinationSpotCopyWith<DestinationSpot> get copyWith => _$DestinationSpotCopyWithImpl<DestinationSpot>(this as DestinationSpot, _$identity);

  /// Serializes this DestinationSpot to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as DestinationSpot;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DestinationSpot&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.imageUrl, _this.imageUrl) || other.imageUrl == _this.imageUrl)&&(identical(other.rating, _this.rating) || other.rating == _this.rating)&&(identical(other.categoryLabel, _this.categoryLabel) || other.categoryLabel == _this.categoryLabel)&&(identical(other.note, _this.note) || other.note == _this.note));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as DestinationSpot;
  return Object.hash(runtimeType,_this.id,_this.name,_this.imageUrl,_this.rating,_this.categoryLabel,_this.note);
}

@override
String toString() {
  final _this = this as DestinationSpot;
  return 'DestinationSpot(id: ${_this.id}, name: ${_this.name}, imageUrl: ${_this.imageUrl}, rating: ${_this.rating}, categoryLabel: ${_this.categoryLabel}, note: ${_this.note})';
}


}

/// @nodoc
abstract mixin class $DestinationSpotCopyWith<$Res>  {
  factory $DestinationSpotCopyWith(DestinationSpot value, $Res Function(DestinationSpot) _then) = _$DestinationSpotCopyWithImpl;
@useResult
$Res call({
 String id, String name, String imageUrl, double? rating, String categoryLabel, String note
});




}
/// @nodoc
class _$DestinationSpotCopyWithImpl<$Res>
    implements $DestinationSpotCopyWith<$Res> {
  _$DestinationSpotCopyWithImpl(this._self, this._then);

  final DestinationSpot _self;
  final $Res Function(DestinationSpot) _then;

/// Create a copy of DestinationSpot
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? imageUrl = null,Object? rating = freezed,Object? categoryLabel = null,Object? note = null,}) {
  return _then(DestinationSpot(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,rating: freezed == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double?,categoryLabel: null == categoryLabel ? _self.categoryLabel : categoryLabel // ignore: cast_nullable_to_non_nullable
as String,note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [DestinationSpot].
extension DestinationSpotPatterns on DestinationSpot {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DestinationSpot value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DestinationSpot() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DestinationSpot value)  $default,){
final _that = this;
switch (_that) {
case _DestinationSpot():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DestinationSpot value)?  $default,){
final _that = this;
switch (_that) {
case _DestinationSpot() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String imageUrl,  double? rating,  String categoryLabel,  String note)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DestinationSpot() when $default != null:
return $default(_that.id,_that.name,_that.imageUrl,_that.rating,_that.categoryLabel,_that.note);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String imageUrl,  double? rating,  String categoryLabel,  String note)  $default,) {final _that = this;
switch (_that) {
case _DestinationSpot():
return $default(_that.id,_that.name,_that.imageUrl,_that.rating,_that.categoryLabel,_that.note);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String imageUrl,  double? rating,  String categoryLabel,  String note)?  $default,) {final _that = this;
switch (_that) {
case _DestinationSpot() when $default != null:
return $default(_that.id,_that.name,_that.imageUrl,_that.rating,_that.categoryLabel,_that.note);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DestinationSpot implements DestinationSpot {
  const _DestinationSpot({required this.id, required this.name, required this.imageUrl, this.rating, required this.categoryLabel, required this.note});
  factory _DestinationSpot.fromJson(Map<String, dynamic> json) => _$DestinationSpotFromJson(json);

@override final  String id;
@override final  String name;
@override final  String imageUrl;
@override final  double? rating;
@override final  String categoryLabel;
@override final  String note;

/// Create a copy of DestinationSpot
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DestinationSpotCopyWith<_DestinationSpot> get copyWith => __$DestinationSpotCopyWithImpl<_DestinationSpot>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DestinationSpotToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _DestinationSpot&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.categoryLabel, categoryLabel) || other.categoryLabel == categoryLabel)&&(identical(other.note, note) || other.note == note));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,name,imageUrl,rating,categoryLabel,note);
}

@override
String toString() {
    return 'DestinationSpot(id: $id, name: $name, imageUrl: $imageUrl, rating: $rating, categoryLabel: $categoryLabel, note: $note)';
}


}

/// @nodoc
abstract mixin class _$DestinationSpotCopyWith<$Res> implements $DestinationSpotCopyWith<$Res> {
  factory _$DestinationSpotCopyWith(_DestinationSpot value, $Res Function(_DestinationSpot) _then) = __$DestinationSpotCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String imageUrl, double? rating, String categoryLabel, String note
});




}
/// @nodoc
class __$DestinationSpotCopyWithImpl<$Res>
    implements _$DestinationSpotCopyWith<$Res> {
  __$DestinationSpotCopyWithImpl(this._self, this._then);

  final _DestinationSpot _self;
  final $Res Function(_DestinationSpot) _then;

/// Create a copy of DestinationSpot
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? imageUrl = null,Object? rating = freezed,Object? categoryLabel = null,Object? note = null,}) {
  return _then(_DestinationSpot(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,rating: freezed == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double?,categoryLabel: null == categoryLabel ? _self.categoryLabel : categoryLabel // ignore: cast_nullable_to_non_nullable
as String,note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
