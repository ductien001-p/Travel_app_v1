// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'explore_places_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ExplorePlacesFeed {

 String get featuredSubtitle; List<FeaturedPlace> get featured; String get nearbySubtitle; String get nearbyRadiusLabel; List<NearbyPlace> get nearby; String get collectionsSubtitle; List<PlaceCollection> get collections;
/// Create a copy of ExplorePlacesFeed
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExplorePlacesFeedCopyWith<ExplorePlacesFeed> get copyWith => _$ExplorePlacesFeedCopyWithImpl<ExplorePlacesFeed>(this as ExplorePlacesFeed, _$identity);

  /// Serializes this ExplorePlacesFeed to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ExplorePlacesFeed;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExplorePlacesFeed&&(identical(other.featuredSubtitle, _this.featuredSubtitle) || other.featuredSubtitle == _this.featuredSubtitle)&&const DeepCollectionEquality().equals(other.featured, _this.featured)&&(identical(other.nearbySubtitle, _this.nearbySubtitle) || other.nearbySubtitle == _this.nearbySubtitle)&&(identical(other.nearbyRadiusLabel, _this.nearbyRadiusLabel) || other.nearbyRadiusLabel == _this.nearbyRadiusLabel)&&const DeepCollectionEquality().equals(other.nearby, _this.nearby)&&(identical(other.collectionsSubtitle, _this.collectionsSubtitle) || other.collectionsSubtitle == _this.collectionsSubtitle)&&const DeepCollectionEquality().equals(other.collections, _this.collections));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ExplorePlacesFeed;
  return Object.hash(runtimeType,_this.featuredSubtitle,const DeepCollectionEquality().hash(_this.featured),_this.nearbySubtitle,_this.nearbyRadiusLabel,const DeepCollectionEquality().hash(_this.nearby),_this.collectionsSubtitle,const DeepCollectionEquality().hash(_this.collections));
}

@override
String toString() {
  final _this = this as ExplorePlacesFeed;
  return 'ExplorePlacesFeed(featuredSubtitle: ${_this.featuredSubtitle}, featured: ${_this.featured}, nearbySubtitle: ${_this.nearbySubtitle}, nearbyRadiusLabel: ${_this.nearbyRadiusLabel}, nearby: ${_this.nearby}, collectionsSubtitle: ${_this.collectionsSubtitle}, collections: ${_this.collections})';
}


}

/// @nodoc
abstract mixin class $ExplorePlacesFeedCopyWith<$Res>  {
  factory $ExplorePlacesFeedCopyWith(ExplorePlacesFeed value, $Res Function(ExplorePlacesFeed) _then) = _$ExplorePlacesFeedCopyWithImpl;
@useResult
$Res call({
 String featuredSubtitle, List<FeaturedPlace> featured, String nearbySubtitle, String nearbyRadiusLabel, List<NearbyPlace> nearby, String collectionsSubtitle, List<PlaceCollection> collections
});




}
/// @nodoc
class _$ExplorePlacesFeedCopyWithImpl<$Res>
    implements $ExplorePlacesFeedCopyWith<$Res> {
  _$ExplorePlacesFeedCopyWithImpl(this._self, this._then);

  final ExplorePlacesFeed _self;
  final $Res Function(ExplorePlacesFeed) _then;

/// Create a copy of ExplorePlacesFeed
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? featuredSubtitle = null,Object? featured = null,Object? nearbySubtitle = null,Object? nearbyRadiusLabel = null,Object? nearby = null,Object? collectionsSubtitle = null,Object? collections = null,}) {
  return _then(ExplorePlacesFeed(
featuredSubtitle: null == featuredSubtitle ? _self.featuredSubtitle : featuredSubtitle // ignore: cast_nullable_to_non_nullable
as String,featured: null == featured ? _self.featured : featured // ignore: cast_nullable_to_non_nullable
as List<FeaturedPlace>,nearbySubtitle: null == nearbySubtitle ? _self.nearbySubtitle : nearbySubtitle // ignore: cast_nullable_to_non_nullable
as String,nearbyRadiusLabel: null == nearbyRadiusLabel ? _self.nearbyRadiusLabel : nearbyRadiusLabel // ignore: cast_nullable_to_non_nullable
as String,nearby: null == nearby ? _self.nearby : nearby // ignore: cast_nullable_to_non_nullable
as List<NearbyPlace>,collectionsSubtitle: null == collectionsSubtitle ? _self.collectionsSubtitle : collectionsSubtitle // ignore: cast_nullable_to_non_nullable
as String,collections: null == collections ? _self.collections : collections // ignore: cast_nullable_to_non_nullable
as List<PlaceCollection>,
  ));
}

}


/// Adds pattern-matching-related methods to [ExplorePlacesFeed].
extension ExplorePlacesFeedPatterns on ExplorePlacesFeed {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ExplorePlacesFeed value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ExplorePlacesFeed() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ExplorePlacesFeed value)  $default,){
final _that = this;
switch (_that) {
case _ExplorePlacesFeed():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ExplorePlacesFeed value)?  $default,){
final _that = this;
switch (_that) {
case _ExplorePlacesFeed() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String featuredSubtitle,  List<FeaturedPlace> featured,  String nearbySubtitle,  String nearbyRadiusLabel,  List<NearbyPlace> nearby,  String collectionsSubtitle,  List<PlaceCollection> collections)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ExplorePlacesFeed() when $default != null:
return $default(_that.featuredSubtitle,_that.featured,_that.nearbySubtitle,_that.nearbyRadiusLabel,_that.nearby,_that.collectionsSubtitle,_that.collections);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String featuredSubtitle,  List<FeaturedPlace> featured,  String nearbySubtitle,  String nearbyRadiusLabel,  List<NearbyPlace> nearby,  String collectionsSubtitle,  List<PlaceCollection> collections)  $default,) {final _that = this;
switch (_that) {
case _ExplorePlacesFeed():
return $default(_that.featuredSubtitle,_that.featured,_that.nearbySubtitle,_that.nearbyRadiusLabel,_that.nearby,_that.collectionsSubtitle,_that.collections);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String featuredSubtitle,  List<FeaturedPlace> featured,  String nearbySubtitle,  String nearbyRadiusLabel,  List<NearbyPlace> nearby,  String collectionsSubtitle,  List<PlaceCollection> collections)?  $default,) {final _that = this;
switch (_that) {
case _ExplorePlacesFeed() when $default != null:
return $default(_that.featuredSubtitle,_that.featured,_that.nearbySubtitle,_that.nearbyRadiusLabel,_that.nearby,_that.collectionsSubtitle,_that.collections);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ExplorePlacesFeed implements ExplorePlacesFeed {
  const _ExplorePlacesFeed({required this.featuredSubtitle, required  List<FeaturedPlace> featured, required this.nearbySubtitle, required this.nearbyRadiusLabel, required  List<NearbyPlace> nearby, required this.collectionsSubtitle, required  List<PlaceCollection> collections}): _featured = featured,_nearby = nearby,_collections = collections;
  factory _ExplorePlacesFeed.fromJson(Map<String, dynamic> json) => _$ExplorePlacesFeedFromJson(json);

@override final  String featuredSubtitle;
 final  List<FeaturedPlace> _featured;
@override List<FeaturedPlace> get featured {
  if (_featured is EqualUnmodifiableListView) return _featured;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_featured);
}

@override final  String nearbySubtitle;
@override final  String nearbyRadiusLabel;
 final  List<NearbyPlace> _nearby;
@override List<NearbyPlace> get nearby {
  if (_nearby is EqualUnmodifiableListView) return _nearby;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_nearby);
}

@override final  String collectionsSubtitle;
 final  List<PlaceCollection> _collections;
@override List<PlaceCollection> get collections {
  if (_collections is EqualUnmodifiableListView) return _collections;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_collections);
}


/// Create a copy of ExplorePlacesFeed
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExplorePlacesFeedCopyWith<_ExplorePlacesFeed> get copyWith => __$ExplorePlacesFeedCopyWithImpl<_ExplorePlacesFeed>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ExplorePlacesFeedToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExplorePlacesFeed&&(identical(other.featuredSubtitle, featuredSubtitle) || other.featuredSubtitle == featuredSubtitle)&&const DeepCollectionEquality().equals(other.featured, _featured)&&(identical(other.nearbySubtitle, nearbySubtitle) || other.nearbySubtitle == nearbySubtitle)&&(identical(other.nearbyRadiusLabel, nearbyRadiusLabel) || other.nearbyRadiusLabel == nearbyRadiusLabel)&&const DeepCollectionEquality().equals(other.nearby, _nearby)&&(identical(other.collectionsSubtitle, collectionsSubtitle) || other.collectionsSubtitle == collectionsSubtitle)&&const DeepCollectionEquality().equals(other.collections, _collections));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,featuredSubtitle,const DeepCollectionEquality().hash(_featured),nearbySubtitle,nearbyRadiusLabel,const DeepCollectionEquality().hash(_nearby),collectionsSubtitle,const DeepCollectionEquality().hash(_collections));
}

@override
String toString() {
    return 'ExplorePlacesFeed(featuredSubtitle: $featuredSubtitle, featured: $featured, nearbySubtitle: $nearbySubtitle, nearbyRadiusLabel: $nearbyRadiusLabel, nearby: $nearby, collectionsSubtitle: $collectionsSubtitle, collections: $collections)';
}


}

/// @nodoc
abstract mixin class _$ExplorePlacesFeedCopyWith<$Res> implements $ExplorePlacesFeedCopyWith<$Res> {
  factory _$ExplorePlacesFeedCopyWith(_ExplorePlacesFeed value, $Res Function(_ExplorePlacesFeed) _then) = __$ExplorePlacesFeedCopyWithImpl;
@override @useResult
$Res call({
 String featuredSubtitle, List<FeaturedPlace> featured, String nearbySubtitle, String nearbyRadiusLabel, List<NearbyPlace> nearby, String collectionsSubtitle, List<PlaceCollection> collections
});




}
/// @nodoc
class __$ExplorePlacesFeedCopyWithImpl<$Res>
    implements _$ExplorePlacesFeedCopyWith<$Res> {
  __$ExplorePlacesFeedCopyWithImpl(this._self, this._then);

  final _ExplorePlacesFeed _self;
  final $Res Function(_ExplorePlacesFeed) _then;

/// Create a copy of ExplorePlacesFeed
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? featuredSubtitle = null,Object? featured = null,Object? nearbySubtitle = null,Object? nearbyRadiusLabel = null,Object? nearby = null,Object? collectionsSubtitle = null,Object? collections = null,}) {
  return _then(_ExplorePlacesFeed(
featuredSubtitle: null == featuredSubtitle ? _self.featuredSubtitle : featuredSubtitle // ignore: cast_nullable_to_non_nullable
as String,featured: null == featured ? _self._featured : featured // ignore: cast_nullable_to_non_nullable
as List<FeaturedPlace>,nearbySubtitle: null == nearbySubtitle ? _self.nearbySubtitle : nearbySubtitle // ignore: cast_nullable_to_non_nullable
as String,nearbyRadiusLabel: null == nearbyRadiusLabel ? _self.nearbyRadiusLabel : nearbyRadiusLabel // ignore: cast_nullable_to_non_nullable
as String,nearby: null == nearby ? _self._nearby : nearby // ignore: cast_nullable_to_non_nullable
as List<NearbyPlace>,collectionsSubtitle: null == collectionsSubtitle ? _self.collectionsSubtitle : collectionsSubtitle // ignore: cast_nullable_to_non_nullable
as String,collections: null == collections ? _self._collections : collections // ignore: cast_nullable_to_non_nullable
as List<PlaceCollection>,
  ));
}


}


/// @nodoc
mixin _$FeaturedPlace {

 String get id; String get name; String get imageUrl; String get categoryLabel; double get rating; String get saveCountLabel; String get locationLabel; String get tagline; bool get bookmarked;
/// Create a copy of FeaturedPlace
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeaturedPlaceCopyWith<FeaturedPlace> get copyWith => _$FeaturedPlaceCopyWithImpl<FeaturedPlace>(this as FeaturedPlace, _$identity);

  /// Serializes this FeaturedPlace to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as FeaturedPlace;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeaturedPlace&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.imageUrl, _this.imageUrl) || other.imageUrl == _this.imageUrl)&&(identical(other.categoryLabel, _this.categoryLabel) || other.categoryLabel == _this.categoryLabel)&&(identical(other.rating, _this.rating) || other.rating == _this.rating)&&(identical(other.saveCountLabel, _this.saveCountLabel) || other.saveCountLabel == _this.saveCountLabel)&&(identical(other.locationLabel, _this.locationLabel) || other.locationLabel == _this.locationLabel)&&(identical(other.tagline, _this.tagline) || other.tagline == _this.tagline)&&(identical(other.bookmarked, _this.bookmarked) || other.bookmarked == _this.bookmarked));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as FeaturedPlace;
  return Object.hash(runtimeType,_this.id,_this.name,_this.imageUrl,_this.categoryLabel,_this.rating,_this.saveCountLabel,_this.locationLabel,_this.tagline,_this.bookmarked);
}

@override
String toString() {
  final _this = this as FeaturedPlace;
  return 'FeaturedPlace(id: ${_this.id}, name: ${_this.name}, imageUrl: ${_this.imageUrl}, categoryLabel: ${_this.categoryLabel}, rating: ${_this.rating}, saveCountLabel: ${_this.saveCountLabel}, locationLabel: ${_this.locationLabel}, tagline: ${_this.tagline}, bookmarked: ${_this.bookmarked})';
}


}

/// @nodoc
abstract mixin class $FeaturedPlaceCopyWith<$Res>  {
  factory $FeaturedPlaceCopyWith(FeaturedPlace value, $Res Function(FeaturedPlace) _then) = _$FeaturedPlaceCopyWithImpl;
@useResult
$Res call({
 String id, String name, String imageUrl, String categoryLabel, double rating, String saveCountLabel, String locationLabel, String tagline, bool bookmarked
});




}
/// @nodoc
class _$FeaturedPlaceCopyWithImpl<$Res>
    implements $FeaturedPlaceCopyWith<$Res> {
  _$FeaturedPlaceCopyWithImpl(this._self, this._then);

  final FeaturedPlace _self;
  final $Res Function(FeaturedPlace) _then;

/// Create a copy of FeaturedPlace
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? imageUrl = null,Object? categoryLabel = null,Object? rating = null,Object? saveCountLabel = null,Object? locationLabel = null,Object? tagline = null,Object? bookmarked = null,}) {
  return _then(FeaturedPlace(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,categoryLabel: null == categoryLabel ? _self.categoryLabel : categoryLabel // ignore: cast_nullable_to_non_nullable
as String,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,saveCountLabel: null == saveCountLabel ? _self.saveCountLabel : saveCountLabel // ignore: cast_nullable_to_non_nullable
as String,locationLabel: null == locationLabel ? _self.locationLabel : locationLabel // ignore: cast_nullable_to_non_nullable
as String,tagline: null == tagline ? _self.tagline : tagline // ignore: cast_nullable_to_non_nullable
as String,bookmarked: null == bookmarked ? _self.bookmarked : bookmarked // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [FeaturedPlace].
extension FeaturedPlacePatterns on FeaturedPlace {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FeaturedPlace value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FeaturedPlace() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FeaturedPlace value)  $default,){
final _that = this;
switch (_that) {
case _FeaturedPlace():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FeaturedPlace value)?  $default,){
final _that = this;
switch (_that) {
case _FeaturedPlace() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String imageUrl,  String categoryLabel,  double rating,  String saveCountLabel,  String locationLabel,  String tagline,  bool bookmarked)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FeaturedPlace() when $default != null:
return $default(_that.id,_that.name,_that.imageUrl,_that.categoryLabel,_that.rating,_that.saveCountLabel,_that.locationLabel,_that.tagline,_that.bookmarked);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String imageUrl,  String categoryLabel,  double rating,  String saveCountLabel,  String locationLabel,  String tagline,  bool bookmarked)  $default,) {final _that = this;
switch (_that) {
case _FeaturedPlace():
return $default(_that.id,_that.name,_that.imageUrl,_that.categoryLabel,_that.rating,_that.saveCountLabel,_that.locationLabel,_that.tagline,_that.bookmarked);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String imageUrl,  String categoryLabel,  double rating,  String saveCountLabel,  String locationLabel,  String tagline,  bool bookmarked)?  $default,) {final _that = this;
switch (_that) {
case _FeaturedPlace() when $default != null:
return $default(_that.id,_that.name,_that.imageUrl,_that.categoryLabel,_that.rating,_that.saveCountLabel,_that.locationLabel,_that.tagline,_that.bookmarked);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FeaturedPlace implements FeaturedPlace {
  const _FeaturedPlace({required this.id, required this.name, required this.imageUrl, required this.categoryLabel, required this.rating, required this.saveCountLabel, required this.locationLabel, required this.tagline, this.bookmarked = false});
  factory _FeaturedPlace.fromJson(Map<String, dynamic> json) => _$FeaturedPlaceFromJson(json);

@override final  String id;
@override final  String name;
@override final  String imageUrl;
@override final  String categoryLabel;
@override final  double rating;
@override final  String saveCountLabel;
@override final  String locationLabel;
@override final  String tagline;
@override@JsonKey() final  bool bookmarked;

/// Create a copy of FeaturedPlace
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FeaturedPlaceCopyWith<_FeaturedPlace> get copyWith => __$FeaturedPlaceCopyWithImpl<_FeaturedPlace>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FeaturedPlaceToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _FeaturedPlace&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.categoryLabel, categoryLabel) || other.categoryLabel == categoryLabel)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.saveCountLabel, saveCountLabel) || other.saveCountLabel == saveCountLabel)&&(identical(other.locationLabel, locationLabel) || other.locationLabel == locationLabel)&&(identical(other.tagline, tagline) || other.tagline == tagline)&&(identical(other.bookmarked, bookmarked) || other.bookmarked == bookmarked));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,name,imageUrl,categoryLabel,rating,saveCountLabel,locationLabel,tagline,bookmarked);
}

@override
String toString() {
    return 'FeaturedPlace(id: $id, name: $name, imageUrl: $imageUrl, categoryLabel: $categoryLabel, rating: $rating, saveCountLabel: $saveCountLabel, locationLabel: $locationLabel, tagline: $tagline, bookmarked: $bookmarked)';
}


}

/// @nodoc
abstract mixin class _$FeaturedPlaceCopyWith<$Res> implements $FeaturedPlaceCopyWith<$Res> {
  factory _$FeaturedPlaceCopyWith(_FeaturedPlace value, $Res Function(_FeaturedPlace) _then) = __$FeaturedPlaceCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String imageUrl, String categoryLabel, double rating, String saveCountLabel, String locationLabel, String tagline, bool bookmarked
});




}
/// @nodoc
class __$FeaturedPlaceCopyWithImpl<$Res>
    implements _$FeaturedPlaceCopyWith<$Res> {
  __$FeaturedPlaceCopyWithImpl(this._self, this._then);

  final _FeaturedPlace _self;
  final $Res Function(_FeaturedPlace) _then;

/// Create a copy of FeaturedPlace
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? imageUrl = null,Object? categoryLabel = null,Object? rating = null,Object? saveCountLabel = null,Object? locationLabel = null,Object? tagline = null,Object? bookmarked = null,}) {
  return _then(_FeaturedPlace(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,categoryLabel: null == categoryLabel ? _self.categoryLabel : categoryLabel // ignore: cast_nullable_to_non_nullable
as String,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,saveCountLabel: null == saveCountLabel ? _self.saveCountLabel : saveCountLabel // ignore: cast_nullable_to_non_nullable
as String,locationLabel: null == locationLabel ? _self.locationLabel : locationLabel // ignore: cast_nullable_to_non_nullable
as String,tagline: null == tagline ? _self.tagline : tagline // ignore: cast_nullable_to_non_nullable
as String,bookmarked: null == bookmarked ? _self.bookmarked : bookmarked // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$NearbyPlace {

 String get id; String get name; String get imageUrl; String get categoryLabel; double get rating; String get reviewCountLabel; String get address; String get distanceLabel; String get travelLabel; NearbyTravelMode get travelMode;
/// Create a copy of NearbyPlace
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NearbyPlaceCopyWith<NearbyPlace> get copyWith => _$NearbyPlaceCopyWithImpl<NearbyPlace>(this as NearbyPlace, _$identity);

  /// Serializes this NearbyPlace to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as NearbyPlace;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NearbyPlace&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.imageUrl, _this.imageUrl) || other.imageUrl == _this.imageUrl)&&(identical(other.categoryLabel, _this.categoryLabel) || other.categoryLabel == _this.categoryLabel)&&(identical(other.rating, _this.rating) || other.rating == _this.rating)&&(identical(other.reviewCountLabel, _this.reviewCountLabel) || other.reviewCountLabel == _this.reviewCountLabel)&&(identical(other.address, _this.address) || other.address == _this.address)&&(identical(other.distanceLabel, _this.distanceLabel) || other.distanceLabel == _this.distanceLabel)&&(identical(other.travelLabel, _this.travelLabel) || other.travelLabel == _this.travelLabel)&&(identical(other.travelMode, _this.travelMode) || other.travelMode == _this.travelMode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as NearbyPlace;
  return Object.hash(runtimeType,_this.id,_this.name,_this.imageUrl,_this.categoryLabel,_this.rating,_this.reviewCountLabel,_this.address,_this.distanceLabel,_this.travelLabel,_this.travelMode);
}

@override
String toString() {
  final _this = this as NearbyPlace;
  return 'NearbyPlace(id: ${_this.id}, name: ${_this.name}, imageUrl: ${_this.imageUrl}, categoryLabel: ${_this.categoryLabel}, rating: ${_this.rating}, reviewCountLabel: ${_this.reviewCountLabel}, address: ${_this.address}, distanceLabel: ${_this.distanceLabel}, travelLabel: ${_this.travelLabel}, travelMode: ${_this.travelMode})';
}


}

/// @nodoc
abstract mixin class $NearbyPlaceCopyWith<$Res>  {
  factory $NearbyPlaceCopyWith(NearbyPlace value, $Res Function(NearbyPlace) _then) = _$NearbyPlaceCopyWithImpl;
@useResult
$Res call({
 String id, String name, String imageUrl, String categoryLabel, double rating, String reviewCountLabel, String address, String distanceLabel, String travelLabel, NearbyTravelMode travelMode
});




}
/// @nodoc
class _$NearbyPlaceCopyWithImpl<$Res>
    implements $NearbyPlaceCopyWith<$Res> {
  _$NearbyPlaceCopyWithImpl(this._self, this._then);

  final NearbyPlace _self;
  final $Res Function(NearbyPlace) _then;

/// Create a copy of NearbyPlace
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? imageUrl = null,Object? categoryLabel = null,Object? rating = null,Object? reviewCountLabel = null,Object? address = null,Object? distanceLabel = null,Object? travelLabel = null,Object? travelMode = null,}) {
  return _then(NearbyPlace(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,categoryLabel: null == categoryLabel ? _self.categoryLabel : categoryLabel // ignore: cast_nullable_to_non_nullable
as String,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,reviewCountLabel: null == reviewCountLabel ? _self.reviewCountLabel : reviewCountLabel // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,distanceLabel: null == distanceLabel ? _self.distanceLabel : distanceLabel // ignore: cast_nullable_to_non_nullable
as String,travelLabel: null == travelLabel ? _self.travelLabel : travelLabel // ignore: cast_nullable_to_non_nullable
as String,travelMode: null == travelMode ? _self.travelMode : travelMode // ignore: cast_nullable_to_non_nullable
as NearbyTravelMode,
  ));
}

}


/// Adds pattern-matching-related methods to [NearbyPlace].
extension NearbyPlacePatterns on NearbyPlace {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NearbyPlace value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NearbyPlace() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NearbyPlace value)  $default,){
final _that = this;
switch (_that) {
case _NearbyPlace():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NearbyPlace value)?  $default,){
final _that = this;
switch (_that) {
case _NearbyPlace() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String imageUrl,  String categoryLabel,  double rating,  String reviewCountLabel,  String address,  String distanceLabel,  String travelLabel,  NearbyTravelMode travelMode)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NearbyPlace() when $default != null:
return $default(_that.id,_that.name,_that.imageUrl,_that.categoryLabel,_that.rating,_that.reviewCountLabel,_that.address,_that.distanceLabel,_that.travelLabel,_that.travelMode);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String imageUrl,  String categoryLabel,  double rating,  String reviewCountLabel,  String address,  String distanceLabel,  String travelLabel,  NearbyTravelMode travelMode)  $default,) {final _that = this;
switch (_that) {
case _NearbyPlace():
return $default(_that.id,_that.name,_that.imageUrl,_that.categoryLabel,_that.rating,_that.reviewCountLabel,_that.address,_that.distanceLabel,_that.travelLabel,_that.travelMode);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String imageUrl,  String categoryLabel,  double rating,  String reviewCountLabel,  String address,  String distanceLabel,  String travelLabel,  NearbyTravelMode travelMode)?  $default,) {final _that = this;
switch (_that) {
case _NearbyPlace() when $default != null:
return $default(_that.id,_that.name,_that.imageUrl,_that.categoryLabel,_that.rating,_that.reviewCountLabel,_that.address,_that.distanceLabel,_that.travelLabel,_that.travelMode);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NearbyPlace implements NearbyPlace {
  const _NearbyPlace({required this.id, required this.name, required this.imageUrl, required this.categoryLabel, required this.rating, required this.reviewCountLabel, required this.address, required this.distanceLabel, required this.travelLabel, required this.travelMode});
  factory _NearbyPlace.fromJson(Map<String, dynamic> json) => _$NearbyPlaceFromJson(json);

@override final  String id;
@override final  String name;
@override final  String imageUrl;
@override final  String categoryLabel;
@override final  double rating;
@override final  String reviewCountLabel;
@override final  String address;
@override final  String distanceLabel;
@override final  String travelLabel;
@override final  NearbyTravelMode travelMode;

/// Create a copy of NearbyPlace
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NearbyPlaceCopyWith<_NearbyPlace> get copyWith => __$NearbyPlaceCopyWithImpl<_NearbyPlace>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NearbyPlaceToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _NearbyPlace&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.categoryLabel, categoryLabel) || other.categoryLabel == categoryLabel)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.reviewCountLabel, reviewCountLabel) || other.reviewCountLabel == reviewCountLabel)&&(identical(other.address, address) || other.address == address)&&(identical(other.distanceLabel, distanceLabel) || other.distanceLabel == distanceLabel)&&(identical(other.travelLabel, travelLabel) || other.travelLabel == travelLabel)&&(identical(other.travelMode, travelMode) || other.travelMode == travelMode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,name,imageUrl,categoryLabel,rating,reviewCountLabel,address,distanceLabel,travelLabel,travelMode);
}

@override
String toString() {
    return 'NearbyPlace(id: $id, name: $name, imageUrl: $imageUrl, categoryLabel: $categoryLabel, rating: $rating, reviewCountLabel: $reviewCountLabel, address: $address, distanceLabel: $distanceLabel, travelLabel: $travelLabel, travelMode: $travelMode)';
}


}

/// @nodoc
abstract mixin class _$NearbyPlaceCopyWith<$Res> implements $NearbyPlaceCopyWith<$Res> {
  factory _$NearbyPlaceCopyWith(_NearbyPlace value, $Res Function(_NearbyPlace) _then) = __$NearbyPlaceCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String imageUrl, String categoryLabel, double rating, String reviewCountLabel, String address, String distanceLabel, String travelLabel, NearbyTravelMode travelMode
});




}
/// @nodoc
class __$NearbyPlaceCopyWithImpl<$Res>
    implements _$NearbyPlaceCopyWith<$Res> {
  __$NearbyPlaceCopyWithImpl(this._self, this._then);

  final _NearbyPlace _self;
  final $Res Function(_NearbyPlace) _then;

/// Create a copy of NearbyPlace
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? imageUrl = null,Object? categoryLabel = null,Object? rating = null,Object? reviewCountLabel = null,Object? address = null,Object? distanceLabel = null,Object? travelLabel = null,Object? travelMode = null,}) {
  return _then(_NearbyPlace(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,categoryLabel: null == categoryLabel ? _self.categoryLabel : categoryLabel // ignore: cast_nullable_to_non_nullable
as String,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,reviewCountLabel: null == reviewCountLabel ? _self.reviewCountLabel : reviewCountLabel // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,distanceLabel: null == distanceLabel ? _self.distanceLabel : distanceLabel // ignore: cast_nullable_to_non_nullable
as String,travelLabel: null == travelLabel ? _self.travelLabel : travelLabel // ignore: cast_nullable_to_non_nullable
as String,travelMode: null == travelMode ? _self.travelMode : travelMode // ignore: cast_nullable_to_non_nullable
as NearbyTravelMode,
  ));
}


}


/// @nodoc
mixin _$PlaceCollection {

 String get id; String get title; String get eyebrow; String get imageUrl; String get countLabel; PlaceCollectionTone get tone;
/// Create a copy of PlaceCollection
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlaceCollectionCopyWith<PlaceCollection> get copyWith => _$PlaceCollectionCopyWithImpl<PlaceCollection>(this as PlaceCollection, _$identity);

  /// Serializes this PlaceCollection to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as PlaceCollection;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlaceCollection&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.eyebrow, _this.eyebrow) || other.eyebrow == _this.eyebrow)&&(identical(other.imageUrl, _this.imageUrl) || other.imageUrl == _this.imageUrl)&&(identical(other.countLabel, _this.countLabel) || other.countLabel == _this.countLabel)&&(identical(other.tone, _this.tone) || other.tone == _this.tone));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as PlaceCollection;
  return Object.hash(runtimeType,_this.id,_this.title,_this.eyebrow,_this.imageUrl,_this.countLabel,_this.tone);
}

@override
String toString() {
  final _this = this as PlaceCollection;
  return 'PlaceCollection(id: ${_this.id}, title: ${_this.title}, eyebrow: ${_this.eyebrow}, imageUrl: ${_this.imageUrl}, countLabel: ${_this.countLabel}, tone: ${_this.tone})';
}


}

/// @nodoc
abstract mixin class $PlaceCollectionCopyWith<$Res>  {
  factory $PlaceCollectionCopyWith(PlaceCollection value, $Res Function(PlaceCollection) _then) = _$PlaceCollectionCopyWithImpl;
@useResult
$Res call({
 String id, String title, String eyebrow, String imageUrl, String countLabel, PlaceCollectionTone tone
});




}
/// @nodoc
class _$PlaceCollectionCopyWithImpl<$Res>
    implements $PlaceCollectionCopyWith<$Res> {
  _$PlaceCollectionCopyWithImpl(this._self, this._then);

  final PlaceCollection _self;
  final $Res Function(PlaceCollection) _then;

/// Create a copy of PlaceCollection
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? eyebrow = null,Object? imageUrl = null,Object? countLabel = null,Object? tone = null,}) {
  return _then(PlaceCollection(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,eyebrow: null == eyebrow ? _self.eyebrow : eyebrow // ignore: cast_nullable_to_non_nullable
as String,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,countLabel: null == countLabel ? _self.countLabel : countLabel // ignore: cast_nullable_to_non_nullable
as String,tone: null == tone ? _self.tone : tone // ignore: cast_nullable_to_non_nullable
as PlaceCollectionTone,
  ));
}

}


/// Adds pattern-matching-related methods to [PlaceCollection].
extension PlaceCollectionPatterns on PlaceCollection {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlaceCollection value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlaceCollection() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlaceCollection value)  $default,){
final _that = this;
switch (_that) {
case _PlaceCollection():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlaceCollection value)?  $default,){
final _that = this;
switch (_that) {
case _PlaceCollection() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String eyebrow,  String imageUrl,  String countLabel,  PlaceCollectionTone tone)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlaceCollection() when $default != null:
return $default(_that.id,_that.title,_that.eyebrow,_that.imageUrl,_that.countLabel,_that.tone);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String eyebrow,  String imageUrl,  String countLabel,  PlaceCollectionTone tone)  $default,) {final _that = this;
switch (_that) {
case _PlaceCollection():
return $default(_that.id,_that.title,_that.eyebrow,_that.imageUrl,_that.countLabel,_that.tone);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String eyebrow,  String imageUrl,  String countLabel,  PlaceCollectionTone tone)?  $default,) {final _that = this;
switch (_that) {
case _PlaceCollection() when $default != null:
return $default(_that.id,_that.title,_that.eyebrow,_that.imageUrl,_that.countLabel,_that.tone);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PlaceCollection implements PlaceCollection {
  const _PlaceCollection({required this.id, required this.title, required this.eyebrow, required this.imageUrl, required this.countLabel, required this.tone});
  factory _PlaceCollection.fromJson(Map<String, dynamic> json) => _$PlaceCollectionFromJson(json);

@override final  String id;
@override final  String title;
@override final  String eyebrow;
@override final  String imageUrl;
@override final  String countLabel;
@override final  PlaceCollectionTone tone;

/// Create a copy of PlaceCollection
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlaceCollectionCopyWith<_PlaceCollection> get copyWith => __$PlaceCollectionCopyWithImpl<_PlaceCollection>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlaceCollectionToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlaceCollection&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.eyebrow, eyebrow) || other.eyebrow == eyebrow)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.countLabel, countLabel) || other.countLabel == countLabel)&&(identical(other.tone, tone) || other.tone == tone));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,title,eyebrow,imageUrl,countLabel,tone);
}

@override
String toString() {
    return 'PlaceCollection(id: $id, title: $title, eyebrow: $eyebrow, imageUrl: $imageUrl, countLabel: $countLabel, tone: $tone)';
}


}

/// @nodoc
abstract mixin class _$PlaceCollectionCopyWith<$Res> implements $PlaceCollectionCopyWith<$Res> {
  factory _$PlaceCollectionCopyWith(_PlaceCollection value, $Res Function(_PlaceCollection) _then) = __$PlaceCollectionCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String eyebrow, String imageUrl, String countLabel, PlaceCollectionTone tone
});




}
/// @nodoc
class __$PlaceCollectionCopyWithImpl<$Res>
    implements _$PlaceCollectionCopyWith<$Res> {
  __$PlaceCollectionCopyWithImpl(this._self, this._then);

  final _PlaceCollection _self;
  final $Res Function(_PlaceCollection) _then;

/// Create a copy of PlaceCollection
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? eyebrow = null,Object? imageUrl = null,Object? countLabel = null,Object? tone = null,}) {
  return _then(_PlaceCollection(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,eyebrow: null == eyebrow ? _self.eyebrow : eyebrow // ignore: cast_nullable_to_non_nullable
as String,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,countLabel: null == countLabel ? _self.countLabel : countLabel // ignore: cast_nullable_to_non_nullable
as String,tone: null == tone ? _self.tone : tone // ignore: cast_nullable_to_non_nullable
as PlaceCollectionTone,
  ));
}


}

// dart format on
