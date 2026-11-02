// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'explore_home_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ExploreHomeFeed {

 ExploreHomeHeader get header; List<ExploreFilterChip> get filters; List<CommunityTripCard> get hotTrips; List<ExploreDestination> get destinations; List<LiveTripUpdate> get liveTrips; int get page; bool get hasNextPage; bool get catalogUnavailable;
/// Create a copy of ExploreHomeFeed
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExploreHomeFeedCopyWith<ExploreHomeFeed> get copyWith => _$ExploreHomeFeedCopyWithImpl<ExploreHomeFeed>(this as ExploreHomeFeed, _$identity);

  /// Serializes this ExploreHomeFeed to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ExploreHomeFeed;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExploreHomeFeed&&(identical(other.header, _this.header) || other.header == _this.header)&&const DeepCollectionEquality().equals(other.filters, _this.filters)&&const DeepCollectionEquality().equals(other.hotTrips, _this.hotTrips)&&const DeepCollectionEquality().equals(other.destinations, _this.destinations)&&const DeepCollectionEquality().equals(other.liveTrips, _this.liveTrips)&&(identical(other.page, _this.page) || other.page == _this.page)&&(identical(other.hasNextPage, _this.hasNextPage) || other.hasNextPage == _this.hasNextPage)&&(identical(other.catalogUnavailable, _this.catalogUnavailable) || other.catalogUnavailable == _this.catalogUnavailable));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ExploreHomeFeed;
  return Object.hash(runtimeType,_this.header,const DeepCollectionEquality().hash(_this.filters),const DeepCollectionEquality().hash(_this.hotTrips),const DeepCollectionEquality().hash(_this.destinations),const DeepCollectionEquality().hash(_this.liveTrips),_this.page,_this.hasNextPage,_this.catalogUnavailable);
}

@override
String toString() {
  final _this = this as ExploreHomeFeed;
  return 'ExploreHomeFeed(header: ${_this.header}, filters: ${_this.filters}, hotTrips: ${_this.hotTrips}, destinations: ${_this.destinations}, liveTrips: ${_this.liveTrips}, page: ${_this.page}, hasNextPage: ${_this.hasNextPage}, catalogUnavailable: ${_this.catalogUnavailable})';
}


}

/// @nodoc
abstract mixin class $ExploreHomeFeedCopyWith<$Res>  {
  factory $ExploreHomeFeedCopyWith(ExploreHomeFeed value, $Res Function(ExploreHomeFeed) _then) = _$ExploreHomeFeedCopyWithImpl;
@useResult
$Res call({
 ExploreHomeHeader header, List<ExploreFilterChip> filters, List<CommunityTripCard> hotTrips, List<ExploreDestination> destinations, List<LiveTripUpdate> liveTrips, int page, bool hasNextPage, bool catalogUnavailable
});


$ExploreHomeHeaderCopyWith<$Res> get header;

}
/// @nodoc
class _$ExploreHomeFeedCopyWithImpl<$Res>
    implements $ExploreHomeFeedCopyWith<$Res> {
  _$ExploreHomeFeedCopyWithImpl(this._self, this._then);

  final ExploreHomeFeed _self;
  final $Res Function(ExploreHomeFeed) _then;

/// Create a copy of ExploreHomeFeed
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? header = null,Object? filters = null,Object? hotTrips = null,Object? destinations = null,Object? liveTrips = null,Object? page = null,Object? hasNextPage = null,Object? catalogUnavailable = null,}) {
  return _then(ExploreHomeFeed(
header: null == header ? _self.header : header // ignore: cast_nullable_to_non_nullable
as ExploreHomeHeader,filters: null == filters ? _self.filters : filters // ignore: cast_nullable_to_non_nullable
as List<ExploreFilterChip>,hotTrips: null == hotTrips ? _self.hotTrips : hotTrips // ignore: cast_nullable_to_non_nullable
as List<CommunityTripCard>,destinations: null == destinations ? _self.destinations : destinations // ignore: cast_nullable_to_non_nullable
as List<ExploreDestination>,liveTrips: null == liveTrips ? _self.liveTrips : liveTrips // ignore: cast_nullable_to_non_nullable
as List<LiveTripUpdate>,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,hasNextPage: null == hasNextPage ? _self.hasNextPage : hasNextPage // ignore: cast_nullable_to_non_nullable
as bool,catalogUnavailable: null == catalogUnavailable ? _self.catalogUnavailable : catalogUnavailable // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of ExploreHomeFeed
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ExploreHomeHeaderCopyWith<$Res> get header {
  
  return $ExploreHomeHeaderCopyWith<$Res>(_self.header, (value) {
    return _then(_self.copyWith(header: value));
  });
}
}


/// Adds pattern-matching-related methods to [ExploreHomeFeed].
extension ExploreHomeFeedPatterns on ExploreHomeFeed {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ExploreHomeFeed value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ExploreHomeFeed() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ExploreHomeFeed value)  $default,){
final _that = this;
switch (_that) {
case _ExploreHomeFeed():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ExploreHomeFeed value)?  $default,){
final _that = this;
switch (_that) {
case _ExploreHomeFeed() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ExploreHomeHeader header,  List<ExploreFilterChip> filters,  List<CommunityTripCard> hotTrips,  List<ExploreDestination> destinations,  List<LiveTripUpdate> liveTrips,  int page,  bool hasNextPage,  bool catalogUnavailable)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ExploreHomeFeed() when $default != null:
return $default(_that.header,_that.filters,_that.hotTrips,_that.destinations,_that.liveTrips,_that.page,_that.hasNextPage,_that.catalogUnavailable);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ExploreHomeHeader header,  List<ExploreFilterChip> filters,  List<CommunityTripCard> hotTrips,  List<ExploreDestination> destinations,  List<LiveTripUpdate> liveTrips,  int page,  bool hasNextPage,  bool catalogUnavailable)  $default,) {final _that = this;
switch (_that) {
case _ExploreHomeFeed():
return $default(_that.header,_that.filters,_that.hotTrips,_that.destinations,_that.liveTrips,_that.page,_that.hasNextPage,_that.catalogUnavailable);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ExploreHomeHeader header,  List<ExploreFilterChip> filters,  List<CommunityTripCard> hotTrips,  List<ExploreDestination> destinations,  List<LiveTripUpdate> liveTrips,  int page,  bool hasNextPage,  bool catalogUnavailable)?  $default,) {final _that = this;
switch (_that) {
case _ExploreHomeFeed() when $default != null:
return $default(_that.header,_that.filters,_that.hotTrips,_that.destinations,_that.liveTrips,_that.page,_that.hasNextPage,_that.catalogUnavailable);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ExploreHomeFeed implements ExploreHomeFeed {
  const _ExploreHomeFeed({required this.header, required  List<ExploreFilterChip> filters, required  List<CommunityTripCard> hotTrips, required  List<ExploreDestination> destinations, required  List<LiveTripUpdate> liveTrips, this.page = 1, this.hasNextPage = false, this.catalogUnavailable = false}): _filters = filters,_hotTrips = hotTrips,_destinations = destinations,_liveTrips = liveTrips;
  factory _ExploreHomeFeed.fromJson(Map<String, dynamic> json) => _$ExploreHomeFeedFromJson(json);

@override final  ExploreHomeHeader header;
 final  List<ExploreFilterChip> _filters;
@override List<ExploreFilterChip> get filters {
  if (_filters is EqualUnmodifiableListView) return _filters;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_filters);
}

 final  List<CommunityTripCard> _hotTrips;
@override List<CommunityTripCard> get hotTrips {
  if (_hotTrips is EqualUnmodifiableListView) return _hotTrips;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_hotTrips);
}

 final  List<ExploreDestination> _destinations;
@override List<ExploreDestination> get destinations {
  if (_destinations is EqualUnmodifiableListView) return _destinations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_destinations);
}

 final  List<LiveTripUpdate> _liveTrips;
@override List<LiveTripUpdate> get liveTrips {
  if (_liveTrips is EqualUnmodifiableListView) return _liveTrips;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_liveTrips);
}

@override@JsonKey() final  int page;
@override@JsonKey() final  bool hasNextPage;
@override@JsonKey() final  bool catalogUnavailable;

/// Create a copy of ExploreHomeFeed
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExploreHomeFeedCopyWith<_ExploreHomeFeed> get copyWith => __$ExploreHomeFeedCopyWithImpl<_ExploreHomeFeed>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ExploreHomeFeedToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExploreHomeFeed&&(identical(other.header, header) || other.header == header)&&const DeepCollectionEquality().equals(other.filters, _filters)&&const DeepCollectionEquality().equals(other.hotTrips, _hotTrips)&&const DeepCollectionEquality().equals(other.destinations, _destinations)&&const DeepCollectionEquality().equals(other.liveTrips, _liveTrips)&&(identical(other.page, page) || other.page == page)&&(identical(other.hasNextPage, hasNextPage) || other.hasNextPage == hasNextPage)&&(identical(other.catalogUnavailable, catalogUnavailable) || other.catalogUnavailable == catalogUnavailable));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,header,const DeepCollectionEquality().hash(_filters),const DeepCollectionEquality().hash(_hotTrips),const DeepCollectionEquality().hash(_destinations),const DeepCollectionEquality().hash(_liveTrips),page,hasNextPage,catalogUnavailable);
}

@override
String toString() {
    return 'ExploreHomeFeed(header: $header, filters: $filters, hotTrips: $hotTrips, destinations: $destinations, liveTrips: $liveTrips, page: $page, hasNextPage: $hasNextPage, catalogUnavailable: $catalogUnavailable)';
}


}

/// @nodoc
abstract mixin class _$ExploreHomeFeedCopyWith<$Res> implements $ExploreHomeFeedCopyWith<$Res> {
  factory _$ExploreHomeFeedCopyWith(_ExploreHomeFeed value, $Res Function(_ExploreHomeFeed) _then) = __$ExploreHomeFeedCopyWithImpl;
@override @useResult
$Res call({
 ExploreHomeHeader header, List<ExploreFilterChip> filters, List<CommunityTripCard> hotTrips, List<ExploreDestination> destinations, List<LiveTripUpdate> liveTrips, int page, bool hasNextPage, bool catalogUnavailable
});


@override $ExploreHomeHeaderCopyWith<$Res> get header;

}
/// @nodoc
class __$ExploreHomeFeedCopyWithImpl<$Res>
    implements _$ExploreHomeFeedCopyWith<$Res> {
  __$ExploreHomeFeedCopyWithImpl(this._self, this._then);

  final _ExploreHomeFeed _self;
  final $Res Function(_ExploreHomeFeed) _then;

/// Create a copy of ExploreHomeFeed
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? header = null,Object? filters = null,Object? hotTrips = null,Object? destinations = null,Object? liveTrips = null,Object? page = null,Object? hasNextPage = null,Object? catalogUnavailable = null,}) {
  return _then(_ExploreHomeFeed(
header: null == header ? _self.header : header // ignore: cast_nullable_to_non_nullable
as ExploreHomeHeader,filters: null == filters ? _self._filters : filters // ignore: cast_nullable_to_non_nullable
as List<ExploreFilterChip>,hotTrips: null == hotTrips ? _self._hotTrips : hotTrips // ignore: cast_nullable_to_non_nullable
as List<CommunityTripCard>,destinations: null == destinations ? _self._destinations : destinations // ignore: cast_nullable_to_non_nullable
as List<ExploreDestination>,liveTrips: null == liveTrips ? _self._liveTrips : liveTrips // ignore: cast_nullable_to_non_nullable
as List<LiveTripUpdate>,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,hasNextPage: null == hasNextPage ? _self.hasNextPage : hasNextPage // ignore: cast_nullable_to_non_nullable
as bool,catalogUnavailable: null == catalogUnavailable ? _self.catalogUnavailable : catalogUnavailable // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of ExploreHomeFeed
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ExploreHomeHeaderCopyWith<$Res> get header {
  
  return $ExploreHomeHeaderCopyWith<$Res>(_self.header, (value) {
    return _then(_self.copyWith(header: value));
  });
}
}


/// @nodoc
mixin _$ExploreHomeHeader {

 String get displayName; String? get avatarUrl; String get locationLabel; bool get hasUnreadNotifications;
/// Create a copy of ExploreHomeHeader
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExploreHomeHeaderCopyWith<ExploreHomeHeader> get copyWith => _$ExploreHomeHeaderCopyWithImpl<ExploreHomeHeader>(this as ExploreHomeHeader, _$identity);

  /// Serializes this ExploreHomeHeader to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ExploreHomeHeader;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExploreHomeHeader&&(identical(other.displayName, _this.displayName) || other.displayName == _this.displayName)&&(identical(other.avatarUrl, _this.avatarUrl) || other.avatarUrl == _this.avatarUrl)&&(identical(other.locationLabel, _this.locationLabel) || other.locationLabel == _this.locationLabel)&&(identical(other.hasUnreadNotifications, _this.hasUnreadNotifications) || other.hasUnreadNotifications == _this.hasUnreadNotifications));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ExploreHomeHeader;
  return Object.hash(runtimeType,_this.displayName,_this.avatarUrl,_this.locationLabel,_this.hasUnreadNotifications);
}

@override
String toString() {
  final _this = this as ExploreHomeHeader;
  return 'ExploreHomeHeader(displayName: ${_this.displayName}, avatarUrl: ${_this.avatarUrl}, locationLabel: ${_this.locationLabel}, hasUnreadNotifications: ${_this.hasUnreadNotifications})';
}


}

/// @nodoc
abstract mixin class $ExploreHomeHeaderCopyWith<$Res>  {
  factory $ExploreHomeHeaderCopyWith(ExploreHomeHeader value, $Res Function(ExploreHomeHeader) _then) = _$ExploreHomeHeaderCopyWithImpl;
@useResult
$Res call({
 String displayName, String? avatarUrl, String locationLabel, bool hasUnreadNotifications
});




}
/// @nodoc
class _$ExploreHomeHeaderCopyWithImpl<$Res>
    implements $ExploreHomeHeaderCopyWith<$Res> {
  _$ExploreHomeHeaderCopyWithImpl(this._self, this._then);

  final ExploreHomeHeader _self;
  final $Res Function(ExploreHomeHeader) _then;

/// Create a copy of ExploreHomeHeader
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? displayName = null,Object? avatarUrl = freezed,Object? locationLabel = null,Object? hasUnreadNotifications = null,}) {
  return _then(ExploreHomeHeader(
displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,locationLabel: null == locationLabel ? _self.locationLabel : locationLabel // ignore: cast_nullable_to_non_nullable
as String,hasUnreadNotifications: null == hasUnreadNotifications ? _self.hasUnreadNotifications : hasUnreadNotifications // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ExploreHomeHeader].
extension ExploreHomeHeaderPatterns on ExploreHomeHeader {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ExploreHomeHeader value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ExploreHomeHeader() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ExploreHomeHeader value)  $default,){
final _that = this;
switch (_that) {
case _ExploreHomeHeader():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ExploreHomeHeader value)?  $default,){
final _that = this;
switch (_that) {
case _ExploreHomeHeader() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String displayName,  String? avatarUrl,  String locationLabel,  bool hasUnreadNotifications)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ExploreHomeHeader() when $default != null:
return $default(_that.displayName,_that.avatarUrl,_that.locationLabel,_that.hasUnreadNotifications);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String displayName,  String? avatarUrl,  String locationLabel,  bool hasUnreadNotifications)  $default,) {final _that = this;
switch (_that) {
case _ExploreHomeHeader():
return $default(_that.displayName,_that.avatarUrl,_that.locationLabel,_that.hasUnreadNotifications);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String displayName,  String? avatarUrl,  String locationLabel,  bool hasUnreadNotifications)?  $default,) {final _that = this;
switch (_that) {
case _ExploreHomeHeader() when $default != null:
return $default(_that.displayName,_that.avatarUrl,_that.locationLabel,_that.hasUnreadNotifications);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ExploreHomeHeader implements ExploreHomeHeader {
  const _ExploreHomeHeader({required this.displayName, this.avatarUrl, required this.locationLabel, this.hasUnreadNotifications = false});
  factory _ExploreHomeHeader.fromJson(Map<String, dynamic> json) => _$ExploreHomeHeaderFromJson(json);

@override final  String displayName;
@override final  String? avatarUrl;
@override final  String locationLabel;
@override@JsonKey() final  bool hasUnreadNotifications;

/// Create a copy of ExploreHomeHeader
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExploreHomeHeaderCopyWith<_ExploreHomeHeader> get copyWith => __$ExploreHomeHeaderCopyWithImpl<_ExploreHomeHeader>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ExploreHomeHeaderToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExploreHomeHeader&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.locationLabel, locationLabel) || other.locationLabel == locationLabel)&&(identical(other.hasUnreadNotifications, hasUnreadNotifications) || other.hasUnreadNotifications == hasUnreadNotifications));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,displayName,avatarUrl,locationLabel,hasUnreadNotifications);
}

@override
String toString() {
    return 'ExploreHomeHeader(displayName: $displayName, avatarUrl: $avatarUrl, locationLabel: $locationLabel, hasUnreadNotifications: $hasUnreadNotifications)';
}


}

/// @nodoc
abstract mixin class _$ExploreHomeHeaderCopyWith<$Res> implements $ExploreHomeHeaderCopyWith<$Res> {
  factory _$ExploreHomeHeaderCopyWith(_ExploreHomeHeader value, $Res Function(_ExploreHomeHeader) _then) = __$ExploreHomeHeaderCopyWithImpl;
@override @useResult
$Res call({
 String displayName, String? avatarUrl, String locationLabel, bool hasUnreadNotifications
});




}
/// @nodoc
class __$ExploreHomeHeaderCopyWithImpl<$Res>
    implements _$ExploreHomeHeaderCopyWith<$Res> {
  __$ExploreHomeHeaderCopyWithImpl(this._self, this._then);

  final _ExploreHomeHeader _self;
  final $Res Function(_ExploreHomeHeader) _then;

/// Create a copy of ExploreHomeHeader
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? displayName = null,Object? avatarUrl = freezed,Object? locationLabel = null,Object? hasUnreadNotifications = null,}) {
  return _then(_ExploreHomeHeader(
displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,locationLabel: null == locationLabel ? _self.locationLabel : locationLabel // ignore: cast_nullable_to_non_nullable
as String,hasUnreadNotifications: null == hasUnreadNotifications ? _self.hasUnreadNotifications : hasUnreadNotifications // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$ExploreFilterChip {

 String get id; String get label;
/// Create a copy of ExploreFilterChip
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExploreFilterChipCopyWith<ExploreFilterChip> get copyWith => _$ExploreFilterChipCopyWithImpl<ExploreFilterChip>(this as ExploreFilterChip, _$identity);

  /// Serializes this ExploreFilterChip to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ExploreFilterChip;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExploreFilterChip&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.label, _this.label) || other.label == _this.label));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ExploreFilterChip;
  return Object.hash(runtimeType,_this.id,_this.label);
}

@override
String toString() {
  final _this = this as ExploreFilterChip;
  return 'ExploreFilterChip(id: ${_this.id}, label: ${_this.label})';
}


}

/// @nodoc
abstract mixin class $ExploreFilterChipCopyWith<$Res>  {
  factory $ExploreFilterChipCopyWith(ExploreFilterChip value, $Res Function(ExploreFilterChip) _then) = _$ExploreFilterChipCopyWithImpl;
@useResult
$Res call({
 String id, String label
});




}
/// @nodoc
class _$ExploreFilterChipCopyWithImpl<$Res>
    implements $ExploreFilterChipCopyWith<$Res> {
  _$ExploreFilterChipCopyWithImpl(this._self, this._then);

  final ExploreFilterChip _self;
  final $Res Function(ExploreFilterChip) _then;

/// Create a copy of ExploreFilterChip
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? label = null,}) {
  return _then(ExploreFilterChip(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ExploreFilterChip].
extension ExploreFilterChipPatterns on ExploreFilterChip {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ExploreFilterChip value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ExploreFilterChip() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ExploreFilterChip value)  $default,){
final _that = this;
switch (_that) {
case _ExploreFilterChip():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ExploreFilterChip value)?  $default,){
final _that = this;
switch (_that) {
case _ExploreFilterChip() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String label)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ExploreFilterChip() when $default != null:
return $default(_that.id,_that.label);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String label)  $default,) {final _that = this;
switch (_that) {
case _ExploreFilterChip():
return $default(_that.id,_that.label);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String label)?  $default,) {final _that = this;
switch (_that) {
case _ExploreFilterChip() when $default != null:
return $default(_that.id,_that.label);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ExploreFilterChip implements ExploreFilterChip {
  const _ExploreFilterChip({required this.id, required this.label});
  factory _ExploreFilterChip.fromJson(Map<String, dynamic> json) => _$ExploreFilterChipFromJson(json);

@override final  String id;
@override final  String label;

/// Create a copy of ExploreFilterChip
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExploreFilterChipCopyWith<_ExploreFilterChip> get copyWith => __$ExploreFilterChipCopyWithImpl<_ExploreFilterChip>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ExploreFilterChipToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExploreFilterChip&&(identical(other.id, id) || other.id == id)&&(identical(other.label, label) || other.label == label));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,label);
}

@override
String toString() {
    return 'ExploreFilterChip(id: $id, label: $label)';
}


}

/// @nodoc
abstract mixin class _$ExploreFilterChipCopyWith<$Res> implements $ExploreFilterChipCopyWith<$Res> {
  factory _$ExploreFilterChipCopyWith(_ExploreFilterChip value, $Res Function(_ExploreFilterChip) _then) = __$ExploreFilterChipCopyWithImpl;
@override @useResult
$Res call({
 String id, String label
});




}
/// @nodoc
class __$ExploreFilterChipCopyWithImpl<$Res>
    implements _$ExploreFilterChipCopyWith<$Res> {
  __$ExploreFilterChipCopyWithImpl(this._self, this._then);

  final _ExploreFilterChip _self;
  final $Res Function(_ExploreFilterChip) _then;

/// Create a copy of ExploreFilterChip
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? label = null,}) {
  return _then(_ExploreFilterChip(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$CommunityTripAuthor {

 String get name; String get handle; String? get avatarUrl; String? get badgeLabel;
/// Create a copy of CommunityTripAuthor
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CommunityTripAuthorCopyWith<CommunityTripAuthor> get copyWith => _$CommunityTripAuthorCopyWithImpl<CommunityTripAuthor>(this as CommunityTripAuthor, _$identity);

  /// Serializes this CommunityTripAuthor to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as CommunityTripAuthor;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommunityTripAuthor&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.handle, _this.handle) || other.handle == _this.handle)&&(identical(other.avatarUrl, _this.avatarUrl) || other.avatarUrl == _this.avatarUrl)&&(identical(other.badgeLabel, _this.badgeLabel) || other.badgeLabel == _this.badgeLabel));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as CommunityTripAuthor;
  return Object.hash(runtimeType,_this.name,_this.handle,_this.avatarUrl,_this.badgeLabel);
}

@override
String toString() {
  final _this = this as CommunityTripAuthor;
  return 'CommunityTripAuthor(name: ${_this.name}, handle: ${_this.handle}, avatarUrl: ${_this.avatarUrl}, badgeLabel: ${_this.badgeLabel})';
}


}

/// @nodoc
abstract mixin class $CommunityTripAuthorCopyWith<$Res>  {
  factory $CommunityTripAuthorCopyWith(CommunityTripAuthor value, $Res Function(CommunityTripAuthor) _then) = _$CommunityTripAuthorCopyWithImpl;
@useResult
$Res call({
 String name, String handle, String? avatarUrl, String? badgeLabel
});




}
/// @nodoc
class _$CommunityTripAuthorCopyWithImpl<$Res>
    implements $CommunityTripAuthorCopyWith<$Res> {
  _$CommunityTripAuthorCopyWithImpl(this._self, this._then);

  final CommunityTripAuthor _self;
  final $Res Function(CommunityTripAuthor) _then;

/// Create a copy of CommunityTripAuthor
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? handle = null,Object? avatarUrl = freezed,Object? badgeLabel = freezed,}) {
  return _then(CommunityTripAuthor(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,handle: null == handle ? _self.handle : handle // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,badgeLabel: freezed == badgeLabel ? _self.badgeLabel : badgeLabel // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CommunityTripAuthor].
extension CommunityTripAuthorPatterns on CommunityTripAuthor {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CommunityTripAuthor value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CommunityTripAuthor() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CommunityTripAuthor value)  $default,){
final _that = this;
switch (_that) {
case _CommunityTripAuthor():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CommunityTripAuthor value)?  $default,){
final _that = this;
switch (_that) {
case _CommunityTripAuthor() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String handle,  String? avatarUrl,  String? badgeLabel)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CommunityTripAuthor() when $default != null:
return $default(_that.name,_that.handle,_that.avatarUrl,_that.badgeLabel);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String handle,  String? avatarUrl,  String? badgeLabel)  $default,) {final _that = this;
switch (_that) {
case _CommunityTripAuthor():
return $default(_that.name,_that.handle,_that.avatarUrl,_that.badgeLabel);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String handle,  String? avatarUrl,  String? badgeLabel)?  $default,) {final _that = this;
switch (_that) {
case _CommunityTripAuthor() when $default != null:
return $default(_that.name,_that.handle,_that.avatarUrl,_that.badgeLabel);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CommunityTripAuthor implements CommunityTripAuthor {
  const _CommunityTripAuthor({required this.name, required this.handle, this.avatarUrl, this.badgeLabel});
  factory _CommunityTripAuthor.fromJson(Map<String, dynamic> json) => _$CommunityTripAuthorFromJson(json);

@override final  String name;
@override final  String handle;
@override final  String? avatarUrl;
@override final  String? badgeLabel;

/// Create a copy of CommunityTripAuthor
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CommunityTripAuthorCopyWith<_CommunityTripAuthor> get copyWith => __$CommunityTripAuthorCopyWithImpl<_CommunityTripAuthor>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CommunityTripAuthorToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CommunityTripAuthor&&(identical(other.name, name) || other.name == name)&&(identical(other.handle, handle) || other.handle == handle)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.badgeLabel, badgeLabel) || other.badgeLabel == badgeLabel));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,name,handle,avatarUrl,badgeLabel);
}

@override
String toString() {
    return 'CommunityTripAuthor(name: $name, handle: $handle, avatarUrl: $avatarUrl, badgeLabel: $badgeLabel)';
}


}

/// @nodoc
abstract mixin class _$CommunityTripAuthorCopyWith<$Res> implements $CommunityTripAuthorCopyWith<$Res> {
  factory _$CommunityTripAuthorCopyWith(_CommunityTripAuthor value, $Res Function(_CommunityTripAuthor) _then) = __$CommunityTripAuthorCopyWithImpl;
@override @useResult
$Res call({
 String name, String handle, String? avatarUrl, String? badgeLabel
});




}
/// @nodoc
class __$CommunityTripAuthorCopyWithImpl<$Res>
    implements _$CommunityTripAuthorCopyWith<$Res> {
  __$CommunityTripAuthorCopyWithImpl(this._self, this._then);

  final _CommunityTripAuthor _self;
  final $Res Function(_CommunityTripAuthor) _then;

/// Create a copy of CommunityTripAuthor
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? handle = null,Object? avatarUrl = freezed,Object? badgeLabel = freezed,}) {
  return _then(_CommunityTripAuthor(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,handle: null == handle ? _self.handle : handle // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,badgeLabel: freezed == badgeLabel ? _self.badgeLabel : badgeLabel // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$CommunityTripCard {

 String get id; CommunityTripAuthor get author; String get coverUrl; List<String> get badges; String get durationLabel; String get title; String get dateLabel; String get costLabel; String get departureLabel; int get memberCount; int get capacity; List<String> get memberAvatars; List<String> get filterTags; bool get recruiting; String? get requirements; String? get estimatedBudgetPerPerson; int? get slotsRemaining; DateTime? get expiresAt; int? get matchScore; bool get urgent;
/// Create a copy of CommunityTripCard
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CommunityTripCardCopyWith<CommunityTripCard> get copyWith => _$CommunityTripCardCopyWithImpl<CommunityTripCard>(this as CommunityTripCard, _$identity);

  /// Serializes this CommunityTripCard to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as CommunityTripCard;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommunityTripCard&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.author, _this.author) || other.author == _this.author)&&(identical(other.coverUrl, _this.coverUrl) || other.coverUrl == _this.coverUrl)&&const DeepCollectionEquality().equals(other.badges, _this.badges)&&(identical(other.durationLabel, _this.durationLabel) || other.durationLabel == _this.durationLabel)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.dateLabel, _this.dateLabel) || other.dateLabel == _this.dateLabel)&&(identical(other.costLabel, _this.costLabel) || other.costLabel == _this.costLabel)&&(identical(other.departureLabel, _this.departureLabel) || other.departureLabel == _this.departureLabel)&&(identical(other.memberCount, _this.memberCount) || other.memberCount == _this.memberCount)&&(identical(other.capacity, _this.capacity) || other.capacity == _this.capacity)&&const DeepCollectionEquality().equals(other.memberAvatars, _this.memberAvatars)&&const DeepCollectionEquality().equals(other.filterTags, _this.filterTags)&&(identical(other.recruiting, _this.recruiting) || other.recruiting == _this.recruiting)&&(identical(other.requirements, _this.requirements) || other.requirements == _this.requirements)&&(identical(other.estimatedBudgetPerPerson, _this.estimatedBudgetPerPerson) || other.estimatedBudgetPerPerson == _this.estimatedBudgetPerPerson)&&(identical(other.slotsRemaining, _this.slotsRemaining) || other.slotsRemaining == _this.slotsRemaining)&&(identical(other.expiresAt, _this.expiresAt) || other.expiresAt == _this.expiresAt)&&(identical(other.matchScore, _this.matchScore) || other.matchScore == _this.matchScore)&&(identical(other.urgent, _this.urgent) || other.urgent == _this.urgent));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as CommunityTripCard;
  return Object.hashAll([runtimeType,_this.id,_this.author,_this.coverUrl,const DeepCollectionEquality().hash(_this.badges),_this.durationLabel,_this.title,_this.dateLabel,_this.costLabel,_this.departureLabel,_this.memberCount,_this.capacity,const DeepCollectionEquality().hash(_this.memberAvatars),const DeepCollectionEquality().hash(_this.filterTags),_this.recruiting,_this.requirements,_this.estimatedBudgetPerPerson,_this.slotsRemaining,_this.expiresAt,_this.matchScore,_this.urgent]);
}

@override
String toString() {
  final _this = this as CommunityTripCard;
  return 'CommunityTripCard(id: ${_this.id}, author: ${_this.author}, coverUrl: ${_this.coverUrl}, badges: ${_this.badges}, durationLabel: ${_this.durationLabel}, title: ${_this.title}, dateLabel: ${_this.dateLabel}, costLabel: ${_this.costLabel}, departureLabel: ${_this.departureLabel}, memberCount: ${_this.memberCount}, capacity: ${_this.capacity}, memberAvatars: ${_this.memberAvatars}, filterTags: ${_this.filterTags}, recruiting: ${_this.recruiting}, requirements: ${_this.requirements}, estimatedBudgetPerPerson: ${_this.estimatedBudgetPerPerson}, slotsRemaining: ${_this.slotsRemaining}, expiresAt: ${_this.expiresAt}, matchScore: ${_this.matchScore}, urgent: ${_this.urgent})';
}


}

/// @nodoc
abstract mixin class $CommunityTripCardCopyWith<$Res>  {
  factory $CommunityTripCardCopyWith(CommunityTripCard value, $Res Function(CommunityTripCard) _then) = _$CommunityTripCardCopyWithImpl;
@useResult
$Res call({
 String id, CommunityTripAuthor author, String coverUrl, List<String> badges, String durationLabel, String title, String dateLabel, String costLabel, String departureLabel, int memberCount, int capacity, List<String> memberAvatars, List<String> filterTags, bool recruiting, String? requirements, String? estimatedBudgetPerPerson, int? slotsRemaining, DateTime? expiresAt, int? matchScore, bool urgent
});


$CommunityTripAuthorCopyWith<$Res> get author;

}
/// @nodoc
class _$CommunityTripCardCopyWithImpl<$Res>
    implements $CommunityTripCardCopyWith<$Res> {
  _$CommunityTripCardCopyWithImpl(this._self, this._then);

  final CommunityTripCard _self;
  final $Res Function(CommunityTripCard) _then;

/// Create a copy of CommunityTripCard
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? author = null,Object? coverUrl = null,Object? badges = null,Object? durationLabel = null,Object? title = null,Object? dateLabel = null,Object? costLabel = null,Object? departureLabel = null,Object? memberCount = null,Object? capacity = null,Object? memberAvatars = null,Object? filterTags = null,Object? recruiting = null,Object? requirements = freezed,Object? estimatedBudgetPerPerson = freezed,Object? slotsRemaining = freezed,Object? expiresAt = freezed,Object? matchScore = freezed,Object? urgent = null,}) {
  return _then(CommunityTripCard(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,author: null == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as CommunityTripAuthor,coverUrl: null == coverUrl ? _self.coverUrl : coverUrl // ignore: cast_nullable_to_non_nullable
as String,badges: null == badges ? _self.badges : badges // ignore: cast_nullable_to_non_nullable
as List<String>,durationLabel: null == durationLabel ? _self.durationLabel : durationLabel // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,dateLabel: null == dateLabel ? _self.dateLabel : dateLabel // ignore: cast_nullable_to_non_nullable
as String,costLabel: null == costLabel ? _self.costLabel : costLabel // ignore: cast_nullable_to_non_nullable
as String,departureLabel: null == departureLabel ? _self.departureLabel : departureLabel // ignore: cast_nullable_to_non_nullable
as String,memberCount: null == memberCount ? _self.memberCount : memberCount // ignore: cast_nullable_to_non_nullable
as int,capacity: null == capacity ? _self.capacity : capacity // ignore: cast_nullable_to_non_nullable
as int,memberAvatars: null == memberAvatars ? _self.memberAvatars : memberAvatars // ignore: cast_nullable_to_non_nullable
as List<String>,filterTags: null == filterTags ? _self.filterTags : filterTags // ignore: cast_nullable_to_non_nullable
as List<String>,recruiting: null == recruiting ? _self.recruiting : recruiting // ignore: cast_nullable_to_non_nullable
as bool,requirements: freezed == requirements ? _self.requirements : requirements // ignore: cast_nullable_to_non_nullable
as String?,estimatedBudgetPerPerson: freezed == estimatedBudgetPerPerson ? _self.estimatedBudgetPerPerson : estimatedBudgetPerPerson // ignore: cast_nullable_to_non_nullable
as String?,slotsRemaining: freezed == slotsRemaining ? _self.slotsRemaining : slotsRemaining // ignore: cast_nullable_to_non_nullable
as int?,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,matchScore: freezed == matchScore ? _self.matchScore : matchScore // ignore: cast_nullable_to_non_nullable
as int?,urgent: null == urgent ? _self.urgent : urgent // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of CommunityTripCard
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CommunityTripAuthorCopyWith<$Res> get author {
  
  return $CommunityTripAuthorCopyWith<$Res>(_self.author, (value) {
    return _then(_self.copyWith(author: value));
  });
}
}


/// Adds pattern-matching-related methods to [CommunityTripCard].
extension CommunityTripCardPatterns on CommunityTripCard {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CommunityTripCard value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CommunityTripCard() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CommunityTripCard value)  $default,){
final _that = this;
switch (_that) {
case _CommunityTripCard():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CommunityTripCard value)?  $default,){
final _that = this;
switch (_that) {
case _CommunityTripCard() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  CommunityTripAuthor author,  String coverUrl,  List<String> badges,  String durationLabel,  String title,  String dateLabel,  String costLabel,  String departureLabel,  int memberCount,  int capacity,  List<String> memberAvatars,  List<String> filterTags,  bool recruiting,  String? requirements,  String? estimatedBudgetPerPerson,  int? slotsRemaining,  DateTime? expiresAt,  int? matchScore,  bool urgent)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CommunityTripCard() when $default != null:
return $default(_that.id,_that.author,_that.coverUrl,_that.badges,_that.durationLabel,_that.title,_that.dateLabel,_that.costLabel,_that.departureLabel,_that.memberCount,_that.capacity,_that.memberAvatars,_that.filterTags,_that.recruiting,_that.requirements,_that.estimatedBudgetPerPerson,_that.slotsRemaining,_that.expiresAt,_that.matchScore,_that.urgent);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  CommunityTripAuthor author,  String coverUrl,  List<String> badges,  String durationLabel,  String title,  String dateLabel,  String costLabel,  String departureLabel,  int memberCount,  int capacity,  List<String> memberAvatars,  List<String> filterTags,  bool recruiting,  String? requirements,  String? estimatedBudgetPerPerson,  int? slotsRemaining,  DateTime? expiresAt,  int? matchScore,  bool urgent)  $default,) {final _that = this;
switch (_that) {
case _CommunityTripCard():
return $default(_that.id,_that.author,_that.coverUrl,_that.badges,_that.durationLabel,_that.title,_that.dateLabel,_that.costLabel,_that.departureLabel,_that.memberCount,_that.capacity,_that.memberAvatars,_that.filterTags,_that.recruiting,_that.requirements,_that.estimatedBudgetPerPerson,_that.slotsRemaining,_that.expiresAt,_that.matchScore,_that.urgent);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  CommunityTripAuthor author,  String coverUrl,  List<String> badges,  String durationLabel,  String title,  String dateLabel,  String costLabel,  String departureLabel,  int memberCount,  int capacity,  List<String> memberAvatars,  List<String> filterTags,  bool recruiting,  String? requirements,  String? estimatedBudgetPerPerson,  int? slotsRemaining,  DateTime? expiresAt,  int? matchScore,  bool urgent)?  $default,) {final _that = this;
switch (_that) {
case _CommunityTripCard() when $default != null:
return $default(_that.id,_that.author,_that.coverUrl,_that.badges,_that.durationLabel,_that.title,_that.dateLabel,_that.costLabel,_that.departureLabel,_that.memberCount,_that.capacity,_that.memberAvatars,_that.filterTags,_that.recruiting,_that.requirements,_that.estimatedBudgetPerPerson,_that.slotsRemaining,_that.expiresAt,_that.matchScore,_that.urgent);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CommunityTripCard implements CommunityTripCard {
  const _CommunityTripCard({required this.id, required this.author, required this.coverUrl, required  List<String> badges, required this.durationLabel, required this.title, required this.dateLabel, required this.costLabel, required this.departureLabel, required this.memberCount, required this.capacity, required  List<String> memberAvatars,  List<String> filterTags = const <String>[], this.recruiting = false, this.requirements, this.estimatedBudgetPerPerson, this.slotsRemaining, this.expiresAt, this.matchScore, this.urgent = false}): _badges = badges,_memberAvatars = memberAvatars,_filterTags = filterTags;
  factory _CommunityTripCard.fromJson(Map<String, dynamic> json) => _$CommunityTripCardFromJson(json);

@override final  String id;
@override final  CommunityTripAuthor author;
@override final  String coverUrl;
 final  List<String> _badges;
@override List<String> get badges {
  if (_badges is EqualUnmodifiableListView) return _badges;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_badges);
}

@override final  String durationLabel;
@override final  String title;
@override final  String dateLabel;
@override final  String costLabel;
@override final  String departureLabel;
@override final  int memberCount;
@override final  int capacity;
 final  List<String> _memberAvatars;
@override List<String> get memberAvatars {
  if (_memberAvatars is EqualUnmodifiableListView) return _memberAvatars;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_memberAvatars);
}

 final  List<String> _filterTags;
@override@JsonKey() List<String> get filterTags {
  if (_filterTags is EqualUnmodifiableListView) return _filterTags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_filterTags);
}

@override@JsonKey() final  bool recruiting;
@override final  String? requirements;
@override final  String? estimatedBudgetPerPerson;
@override final  int? slotsRemaining;
@override final  DateTime? expiresAt;
@override final  int? matchScore;
@override@JsonKey() final  bool urgent;

/// Create a copy of CommunityTripCard
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CommunityTripCardCopyWith<_CommunityTripCard> get copyWith => __$CommunityTripCardCopyWithImpl<_CommunityTripCard>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CommunityTripCardToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CommunityTripCard&&(identical(other.id, id) || other.id == id)&&(identical(other.author, author) || other.author == author)&&(identical(other.coverUrl, coverUrl) || other.coverUrl == coverUrl)&&const DeepCollectionEquality().equals(other.badges, _badges)&&(identical(other.durationLabel, durationLabel) || other.durationLabel == durationLabel)&&(identical(other.title, title) || other.title == title)&&(identical(other.dateLabel, dateLabel) || other.dateLabel == dateLabel)&&(identical(other.costLabel, costLabel) || other.costLabel == costLabel)&&(identical(other.departureLabel, departureLabel) || other.departureLabel == departureLabel)&&(identical(other.memberCount, memberCount) || other.memberCount == memberCount)&&(identical(other.capacity, capacity) || other.capacity == capacity)&&const DeepCollectionEquality().equals(other.memberAvatars, _memberAvatars)&&const DeepCollectionEquality().equals(other.filterTags, _filterTags)&&(identical(other.recruiting, recruiting) || other.recruiting == recruiting)&&(identical(other.requirements, requirements) || other.requirements == requirements)&&(identical(other.estimatedBudgetPerPerson, estimatedBudgetPerPerson) || other.estimatedBudgetPerPerson == estimatedBudgetPerPerson)&&(identical(other.slotsRemaining, slotsRemaining) || other.slotsRemaining == slotsRemaining)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.matchScore, matchScore) || other.matchScore == matchScore)&&(identical(other.urgent, urgent) || other.urgent == urgent));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hashAll([runtimeType,id,author,coverUrl,const DeepCollectionEquality().hash(_badges),durationLabel,title,dateLabel,costLabel,departureLabel,memberCount,capacity,const DeepCollectionEquality().hash(_memberAvatars),const DeepCollectionEquality().hash(_filterTags),recruiting,requirements,estimatedBudgetPerPerson,slotsRemaining,expiresAt,matchScore,urgent]);
}

@override
String toString() {
    return 'CommunityTripCard(id: $id, author: $author, coverUrl: $coverUrl, badges: $badges, durationLabel: $durationLabel, title: $title, dateLabel: $dateLabel, costLabel: $costLabel, departureLabel: $departureLabel, memberCount: $memberCount, capacity: $capacity, memberAvatars: $memberAvatars, filterTags: $filterTags, recruiting: $recruiting, requirements: $requirements, estimatedBudgetPerPerson: $estimatedBudgetPerPerson, slotsRemaining: $slotsRemaining, expiresAt: $expiresAt, matchScore: $matchScore, urgent: $urgent)';
}


}

/// @nodoc
abstract mixin class _$CommunityTripCardCopyWith<$Res> implements $CommunityTripCardCopyWith<$Res> {
  factory _$CommunityTripCardCopyWith(_CommunityTripCard value, $Res Function(_CommunityTripCard) _then) = __$CommunityTripCardCopyWithImpl;
@override @useResult
$Res call({
 String id, CommunityTripAuthor author, String coverUrl, List<String> badges, String durationLabel, String title, String dateLabel, String costLabel, String departureLabel, int memberCount, int capacity, List<String> memberAvatars, List<String> filterTags, bool recruiting, String? requirements, String? estimatedBudgetPerPerson, int? slotsRemaining, DateTime? expiresAt, int? matchScore, bool urgent
});


@override $CommunityTripAuthorCopyWith<$Res> get author;

}
/// @nodoc
class __$CommunityTripCardCopyWithImpl<$Res>
    implements _$CommunityTripCardCopyWith<$Res> {
  __$CommunityTripCardCopyWithImpl(this._self, this._then);

  final _CommunityTripCard _self;
  final $Res Function(_CommunityTripCard) _then;

/// Create a copy of CommunityTripCard
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? author = null,Object? coverUrl = null,Object? badges = null,Object? durationLabel = null,Object? title = null,Object? dateLabel = null,Object? costLabel = null,Object? departureLabel = null,Object? memberCount = null,Object? capacity = null,Object? memberAvatars = null,Object? filterTags = null,Object? recruiting = null,Object? requirements = freezed,Object? estimatedBudgetPerPerson = freezed,Object? slotsRemaining = freezed,Object? expiresAt = freezed,Object? matchScore = freezed,Object? urgent = null,}) {
  return _then(_CommunityTripCard(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,author: null == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as CommunityTripAuthor,coverUrl: null == coverUrl ? _self.coverUrl : coverUrl // ignore: cast_nullable_to_non_nullable
as String,badges: null == badges ? _self._badges : badges // ignore: cast_nullable_to_non_nullable
as List<String>,durationLabel: null == durationLabel ? _self.durationLabel : durationLabel // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,dateLabel: null == dateLabel ? _self.dateLabel : dateLabel // ignore: cast_nullable_to_non_nullable
as String,costLabel: null == costLabel ? _self.costLabel : costLabel // ignore: cast_nullable_to_non_nullable
as String,departureLabel: null == departureLabel ? _self.departureLabel : departureLabel // ignore: cast_nullable_to_non_nullable
as String,memberCount: null == memberCount ? _self.memberCount : memberCount // ignore: cast_nullable_to_non_nullable
as int,capacity: null == capacity ? _self.capacity : capacity // ignore: cast_nullable_to_non_nullable
as int,memberAvatars: null == memberAvatars ? _self._memberAvatars : memberAvatars // ignore: cast_nullable_to_non_nullable
as List<String>,filterTags: null == filterTags ? _self._filterTags : filterTags // ignore: cast_nullable_to_non_nullable
as List<String>,recruiting: null == recruiting ? _self.recruiting : recruiting // ignore: cast_nullable_to_non_nullable
as bool,requirements: freezed == requirements ? _self.requirements : requirements // ignore: cast_nullable_to_non_nullable
as String?,estimatedBudgetPerPerson: freezed == estimatedBudgetPerPerson ? _self.estimatedBudgetPerPerson : estimatedBudgetPerPerson // ignore: cast_nullable_to_non_nullable
as String?,slotsRemaining: freezed == slotsRemaining ? _self.slotsRemaining : slotsRemaining // ignore: cast_nullable_to_non_nullable
as int?,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,matchScore: freezed == matchScore ? _self.matchScore : matchScore // ignore: cast_nullable_to_non_nullable
as int?,urgent: null == urgent ? _self.urgent : urgent // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of CommunityTripCard
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CommunityTripAuthorCopyWith<$Res> get author {
  
  return $CommunityTripAuthorCopyWith<$Res>(_self.author, (value) {
    return _then(_self.copyWith(author: value));
  });
}
}


/// @nodoc
mixin _$ExploreDestination {

 String get id; String get name; String get imageUrl; int get openTripCount;
/// Create a copy of ExploreDestination
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExploreDestinationCopyWith<ExploreDestination> get copyWith => _$ExploreDestinationCopyWithImpl<ExploreDestination>(this as ExploreDestination, _$identity);

  /// Serializes this ExploreDestination to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ExploreDestination;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExploreDestination&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.imageUrl, _this.imageUrl) || other.imageUrl == _this.imageUrl)&&(identical(other.openTripCount, _this.openTripCount) || other.openTripCount == _this.openTripCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ExploreDestination;
  return Object.hash(runtimeType,_this.id,_this.name,_this.imageUrl,_this.openTripCount);
}

@override
String toString() {
  final _this = this as ExploreDestination;
  return 'ExploreDestination(id: ${_this.id}, name: ${_this.name}, imageUrl: ${_this.imageUrl}, openTripCount: ${_this.openTripCount})';
}


}

/// @nodoc
abstract mixin class $ExploreDestinationCopyWith<$Res>  {
  factory $ExploreDestinationCopyWith(ExploreDestination value, $Res Function(ExploreDestination) _then) = _$ExploreDestinationCopyWithImpl;
@useResult
$Res call({
 String id, String name, String imageUrl, int openTripCount
});




}
/// @nodoc
class _$ExploreDestinationCopyWithImpl<$Res>
    implements $ExploreDestinationCopyWith<$Res> {
  _$ExploreDestinationCopyWithImpl(this._self, this._then);

  final ExploreDestination _self;
  final $Res Function(ExploreDestination) _then;

/// Create a copy of ExploreDestination
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? imageUrl = null,Object? openTripCount = null,}) {
  return _then(ExploreDestination(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,openTripCount: null == openTripCount ? _self.openTripCount : openTripCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ExploreDestination].
extension ExploreDestinationPatterns on ExploreDestination {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ExploreDestination value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ExploreDestination() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ExploreDestination value)  $default,){
final _that = this;
switch (_that) {
case _ExploreDestination():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ExploreDestination value)?  $default,){
final _that = this;
switch (_that) {
case _ExploreDestination() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String imageUrl,  int openTripCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ExploreDestination() when $default != null:
return $default(_that.id,_that.name,_that.imageUrl,_that.openTripCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String imageUrl,  int openTripCount)  $default,) {final _that = this;
switch (_that) {
case _ExploreDestination():
return $default(_that.id,_that.name,_that.imageUrl,_that.openTripCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String imageUrl,  int openTripCount)?  $default,) {final _that = this;
switch (_that) {
case _ExploreDestination() when $default != null:
return $default(_that.id,_that.name,_that.imageUrl,_that.openTripCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ExploreDestination implements ExploreDestination {
  const _ExploreDestination({required this.id, required this.name, required this.imageUrl, required this.openTripCount});
  factory _ExploreDestination.fromJson(Map<String, dynamic> json) => _$ExploreDestinationFromJson(json);

@override final  String id;
@override final  String name;
@override final  String imageUrl;
@override final  int openTripCount;

/// Create a copy of ExploreDestination
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExploreDestinationCopyWith<_ExploreDestination> get copyWith => __$ExploreDestinationCopyWithImpl<_ExploreDestination>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ExploreDestinationToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExploreDestination&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.openTripCount, openTripCount) || other.openTripCount == openTripCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,name,imageUrl,openTripCount);
}

@override
String toString() {
    return 'ExploreDestination(id: $id, name: $name, imageUrl: $imageUrl, openTripCount: $openTripCount)';
}


}

/// @nodoc
abstract mixin class _$ExploreDestinationCopyWith<$Res> implements $ExploreDestinationCopyWith<$Res> {
  factory _$ExploreDestinationCopyWith(_ExploreDestination value, $Res Function(_ExploreDestination) _then) = __$ExploreDestinationCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String imageUrl, int openTripCount
});




}
/// @nodoc
class __$ExploreDestinationCopyWithImpl<$Res>
    implements _$ExploreDestinationCopyWith<$Res> {
  __$ExploreDestinationCopyWithImpl(this._self, this._then);

  final _ExploreDestination _self;
  final $Res Function(_ExploreDestination) _then;

/// Create a copy of ExploreDestination
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? imageUrl = null,Object? openTripCount = null,}) {
  return _then(_ExploreDestination(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,openTripCount: null == openTripCount ? _self.openTripCount : openTripCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$LiveTripUpdate {

 String get id; String get title; String get placeLabel; int get memberCount; int get minutesAgo;
/// Create a copy of LiveTripUpdate
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LiveTripUpdateCopyWith<LiveTripUpdate> get copyWith => _$LiveTripUpdateCopyWithImpl<LiveTripUpdate>(this as LiveTripUpdate, _$identity);

  /// Serializes this LiveTripUpdate to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as LiveTripUpdate;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LiveTripUpdate&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.placeLabel, _this.placeLabel) || other.placeLabel == _this.placeLabel)&&(identical(other.memberCount, _this.memberCount) || other.memberCount == _this.memberCount)&&(identical(other.minutesAgo, _this.minutesAgo) || other.minutesAgo == _this.minutesAgo));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as LiveTripUpdate;
  return Object.hash(runtimeType,_this.id,_this.title,_this.placeLabel,_this.memberCount,_this.minutesAgo);
}

@override
String toString() {
  final _this = this as LiveTripUpdate;
  return 'LiveTripUpdate(id: ${_this.id}, title: ${_this.title}, placeLabel: ${_this.placeLabel}, memberCount: ${_this.memberCount}, minutesAgo: ${_this.minutesAgo})';
}


}

/// @nodoc
abstract mixin class $LiveTripUpdateCopyWith<$Res>  {
  factory $LiveTripUpdateCopyWith(LiveTripUpdate value, $Res Function(LiveTripUpdate) _then) = _$LiveTripUpdateCopyWithImpl;
@useResult
$Res call({
 String id, String title, String placeLabel, int memberCount, int minutesAgo
});




}
/// @nodoc
class _$LiveTripUpdateCopyWithImpl<$Res>
    implements $LiveTripUpdateCopyWith<$Res> {
  _$LiveTripUpdateCopyWithImpl(this._self, this._then);

  final LiveTripUpdate _self;
  final $Res Function(LiveTripUpdate) _then;

/// Create a copy of LiveTripUpdate
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? placeLabel = null,Object? memberCount = null,Object? minutesAgo = null,}) {
  return _then(LiveTripUpdate(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,placeLabel: null == placeLabel ? _self.placeLabel : placeLabel // ignore: cast_nullable_to_non_nullable
as String,memberCount: null == memberCount ? _self.memberCount : memberCount // ignore: cast_nullable_to_non_nullable
as int,minutesAgo: null == minutesAgo ? _self.minutesAgo : minutesAgo // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [LiveTripUpdate].
extension LiveTripUpdatePatterns on LiveTripUpdate {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LiveTripUpdate value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LiveTripUpdate() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LiveTripUpdate value)  $default,){
final _that = this;
switch (_that) {
case _LiveTripUpdate():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LiveTripUpdate value)?  $default,){
final _that = this;
switch (_that) {
case _LiveTripUpdate() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String placeLabel,  int memberCount,  int minutesAgo)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LiveTripUpdate() when $default != null:
return $default(_that.id,_that.title,_that.placeLabel,_that.memberCount,_that.minutesAgo);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String placeLabel,  int memberCount,  int minutesAgo)  $default,) {final _that = this;
switch (_that) {
case _LiveTripUpdate():
return $default(_that.id,_that.title,_that.placeLabel,_that.memberCount,_that.minutesAgo);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String placeLabel,  int memberCount,  int minutesAgo)?  $default,) {final _that = this;
switch (_that) {
case _LiveTripUpdate() when $default != null:
return $default(_that.id,_that.title,_that.placeLabel,_that.memberCount,_that.minutesAgo);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LiveTripUpdate implements LiveTripUpdate {
  const _LiveTripUpdate({required this.id, required this.title, required this.placeLabel, required this.memberCount, required this.minutesAgo});
  factory _LiveTripUpdate.fromJson(Map<String, dynamic> json) => _$LiveTripUpdateFromJson(json);

@override final  String id;
@override final  String title;
@override final  String placeLabel;
@override final  int memberCount;
@override final  int minutesAgo;

/// Create a copy of LiveTripUpdate
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LiveTripUpdateCopyWith<_LiveTripUpdate> get copyWith => __$LiveTripUpdateCopyWithImpl<_LiveTripUpdate>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LiveTripUpdateToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _LiveTripUpdate&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.placeLabel, placeLabel) || other.placeLabel == placeLabel)&&(identical(other.memberCount, memberCount) || other.memberCount == memberCount)&&(identical(other.minutesAgo, minutesAgo) || other.minutesAgo == minutesAgo));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,title,placeLabel,memberCount,minutesAgo);
}

@override
String toString() {
    return 'LiveTripUpdate(id: $id, title: $title, placeLabel: $placeLabel, memberCount: $memberCount, minutesAgo: $minutesAgo)';
}


}

/// @nodoc
abstract mixin class _$LiveTripUpdateCopyWith<$Res> implements $LiveTripUpdateCopyWith<$Res> {
  factory _$LiveTripUpdateCopyWith(_LiveTripUpdate value, $Res Function(_LiveTripUpdate) _then) = __$LiveTripUpdateCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String placeLabel, int memberCount, int minutesAgo
});




}
/// @nodoc
class __$LiveTripUpdateCopyWithImpl<$Res>
    implements _$LiveTripUpdateCopyWith<$Res> {
  __$LiveTripUpdateCopyWithImpl(this._self, this._then);

  final _LiveTripUpdate _self;
  final $Res Function(_LiveTripUpdate) _then;

/// Create a copy of LiveTripUpdate
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? placeLabel = null,Object? memberCount = null,Object? minutesAgo = null,}) {
  return _then(_LiveTripUpdate(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,placeLabel: null == placeLabel ? _self.placeLabel : placeLabel // ignore: cast_nullable_to_non_nullable
as String,memberCount: null == memberCount ? _self.memberCount : memberCount // ignore: cast_nullable_to_non_nullable
as int,minutesAgo: null == minutesAgo ? _self.minutesAgo : minutesAgo // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
