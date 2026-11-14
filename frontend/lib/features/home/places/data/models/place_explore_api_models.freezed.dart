// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'place_explore_api_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FeaturedPlacesData {

 String get subtitle; String get date; List<FeaturedPlaceApi> get places;
/// Create a copy of FeaturedPlacesData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeaturedPlacesDataCopyWith<FeaturedPlacesData> get copyWith => _$FeaturedPlacesDataCopyWithImpl<FeaturedPlacesData>(this as FeaturedPlacesData, _$identity);

  /// Serializes this FeaturedPlacesData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as FeaturedPlacesData;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeaturedPlacesData&&(identical(other.subtitle, _this.subtitle) || other.subtitle == _this.subtitle)&&(identical(other.date, _this.date) || other.date == _this.date)&&const DeepCollectionEquality().equals(other.places, _this.places));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as FeaturedPlacesData;
  return Object.hash(runtimeType,_this.subtitle,_this.date,const DeepCollectionEquality().hash(_this.places));
}

@override
String toString() {
  final _this = this as FeaturedPlacesData;
  return 'FeaturedPlacesData(subtitle: ${_this.subtitle}, date: ${_this.date}, places: ${_this.places})';
}


}

/// @nodoc
abstract mixin class $FeaturedPlacesDataCopyWith<$Res>  {
  factory $FeaturedPlacesDataCopyWith(FeaturedPlacesData value, $Res Function(FeaturedPlacesData) _then) = _$FeaturedPlacesDataCopyWithImpl;
@useResult
$Res call({
 String subtitle, String date, List<FeaturedPlaceApi> places
});




}
/// @nodoc
class _$FeaturedPlacesDataCopyWithImpl<$Res>
    implements $FeaturedPlacesDataCopyWith<$Res> {
  _$FeaturedPlacesDataCopyWithImpl(this._self, this._then);

  final FeaturedPlacesData _self;
  final $Res Function(FeaturedPlacesData) _then;

/// Create a copy of FeaturedPlacesData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? subtitle = null,Object? date = null,Object? places = null,}) {
  return _then(FeaturedPlacesData(
subtitle: null == subtitle ? _self.subtitle : subtitle // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,places: null == places ? _self.places : places // ignore: cast_nullable_to_non_nullable
as List<FeaturedPlaceApi>,
  ));
}

}


/// Adds pattern-matching-related methods to [FeaturedPlacesData].
extension FeaturedPlacesDataPatterns on FeaturedPlacesData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FeaturedPlacesData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FeaturedPlacesData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FeaturedPlacesData value)  $default,){
final _that = this;
switch (_that) {
case _FeaturedPlacesData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FeaturedPlacesData value)?  $default,){
final _that = this;
switch (_that) {
case _FeaturedPlacesData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String subtitle,  String date,  List<FeaturedPlaceApi> places)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FeaturedPlacesData() when $default != null:
return $default(_that.subtitle,_that.date,_that.places);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String subtitle,  String date,  List<FeaturedPlaceApi> places)  $default,) {final _that = this;
switch (_that) {
case _FeaturedPlacesData():
return $default(_that.subtitle,_that.date,_that.places);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String subtitle,  String date,  List<FeaturedPlaceApi> places)?  $default,) {final _that = this;
switch (_that) {
case _FeaturedPlacesData() when $default != null:
return $default(_that.subtitle,_that.date,_that.places);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FeaturedPlacesData implements FeaturedPlacesData {
  const _FeaturedPlacesData({required this.subtitle, required this.date,  List<FeaturedPlaceApi> places = const <FeaturedPlaceApi>[]}): _places = places;
  factory _FeaturedPlacesData.fromJson(Map<String, dynamic> json) => _$FeaturedPlacesDataFromJson(json);

@override final  String subtitle;
@override final  String date;
 final  List<FeaturedPlaceApi> _places;
@override@JsonKey() List<FeaturedPlaceApi> get places {
  if (_places is EqualUnmodifiableListView) return _places;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_places);
}


/// Create a copy of FeaturedPlacesData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FeaturedPlacesDataCopyWith<_FeaturedPlacesData> get copyWith => __$FeaturedPlacesDataCopyWithImpl<_FeaturedPlacesData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FeaturedPlacesDataToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _FeaturedPlacesData&&(identical(other.subtitle, subtitle) || other.subtitle == subtitle)&&(identical(other.date, date) || other.date == date)&&const DeepCollectionEquality().equals(other.places, _places));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,subtitle,date,const DeepCollectionEquality().hash(_places));
}

@override
String toString() {
    return 'FeaturedPlacesData(subtitle: $subtitle, date: $date, places: $places)';
}


}

/// @nodoc
abstract mixin class _$FeaturedPlacesDataCopyWith<$Res> implements $FeaturedPlacesDataCopyWith<$Res> {
  factory _$FeaturedPlacesDataCopyWith(_FeaturedPlacesData value, $Res Function(_FeaturedPlacesData) _then) = __$FeaturedPlacesDataCopyWithImpl;
@override @useResult
$Res call({
 String subtitle, String date, List<FeaturedPlaceApi> places
});




}
/// @nodoc
class __$FeaturedPlacesDataCopyWithImpl<$Res>
    implements _$FeaturedPlacesDataCopyWith<$Res> {
  __$FeaturedPlacesDataCopyWithImpl(this._self, this._then);

  final _FeaturedPlacesData _self;
  final $Res Function(_FeaturedPlacesData) _then;

/// Create a copy of FeaturedPlacesData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? subtitle = null,Object? date = null,Object? places = null,}) {
  return _then(_FeaturedPlacesData(
subtitle: null == subtitle ? _self.subtitle : subtitle // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,places: null == places ? _self._places : places // ignore: cast_nullable_to_non_nullable
as List<FeaturedPlaceApi>,
  ));
}


}


/// @nodoc
mixin _$FeaturedPlaceApi {

 String get id; String get name; String? get coverImageUrl; String get category;@JsonKey(fromJson: _readDouble) double get averageRating;@JsonKey(fromJson: _readInt) int get saveCount; String get city; String get address; String? get description; bool get bookmarked;
/// Create a copy of FeaturedPlaceApi
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeaturedPlaceApiCopyWith<FeaturedPlaceApi> get copyWith => _$FeaturedPlaceApiCopyWithImpl<FeaturedPlaceApi>(this as FeaturedPlaceApi, _$identity);

  /// Serializes this FeaturedPlaceApi to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as FeaturedPlaceApi;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeaturedPlaceApi&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.coverImageUrl, _this.coverImageUrl) || other.coverImageUrl == _this.coverImageUrl)&&(identical(other.category, _this.category) || other.category == _this.category)&&(identical(other.averageRating, _this.averageRating) || other.averageRating == _this.averageRating)&&(identical(other.saveCount, _this.saveCount) || other.saveCount == _this.saveCount)&&(identical(other.city, _this.city) || other.city == _this.city)&&(identical(other.address, _this.address) || other.address == _this.address)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.bookmarked, _this.bookmarked) || other.bookmarked == _this.bookmarked));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as FeaturedPlaceApi;
  return Object.hash(runtimeType,_this.id,_this.name,_this.coverImageUrl,_this.category,_this.averageRating,_this.saveCount,_this.city,_this.address,_this.description,_this.bookmarked);
}

@override
String toString() {
  final _this = this as FeaturedPlaceApi;
  return 'FeaturedPlaceApi(id: ${_this.id}, name: ${_this.name}, coverImageUrl: ${_this.coverImageUrl}, category: ${_this.category}, averageRating: ${_this.averageRating}, saveCount: ${_this.saveCount}, city: ${_this.city}, address: ${_this.address}, description: ${_this.description}, bookmarked: ${_this.bookmarked})';
}


}

/// @nodoc
abstract mixin class $FeaturedPlaceApiCopyWith<$Res>  {
  factory $FeaturedPlaceApiCopyWith(FeaturedPlaceApi value, $Res Function(FeaturedPlaceApi) _then) = _$FeaturedPlaceApiCopyWithImpl;
@useResult
$Res call({
 String id, String name, String? coverImageUrl, String category,@JsonKey(fromJson: _readDouble) double averageRating,@JsonKey(fromJson: _readInt) int saveCount, String city, String address, String? description, bool bookmarked
});




}
/// @nodoc
class _$FeaturedPlaceApiCopyWithImpl<$Res>
    implements $FeaturedPlaceApiCopyWith<$Res> {
  _$FeaturedPlaceApiCopyWithImpl(this._self, this._then);

  final FeaturedPlaceApi _self;
  final $Res Function(FeaturedPlaceApi) _then;

/// Create a copy of FeaturedPlaceApi
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? coverImageUrl = freezed,Object? category = null,Object? averageRating = null,Object? saveCount = null,Object? city = null,Object? address = null,Object? description = freezed,Object? bookmarked = null,}) {
  return _then(FeaturedPlaceApi(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,coverImageUrl: freezed == coverImageUrl ? _self.coverImageUrl : coverImageUrl // ignore: cast_nullable_to_non_nullable
as String?,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,averageRating: null == averageRating ? _self.averageRating : averageRating // ignore: cast_nullable_to_non_nullable
as double,saveCount: null == saveCount ? _self.saveCount : saveCount // ignore: cast_nullable_to_non_nullable
as int,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,bookmarked: null == bookmarked ? _self.bookmarked : bookmarked // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [FeaturedPlaceApi].
extension FeaturedPlaceApiPatterns on FeaturedPlaceApi {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FeaturedPlaceApi value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FeaturedPlaceApi() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FeaturedPlaceApi value)  $default,){
final _that = this;
switch (_that) {
case _FeaturedPlaceApi():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FeaturedPlaceApi value)?  $default,){
final _that = this;
switch (_that) {
case _FeaturedPlaceApi() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String? coverImageUrl,  String category, @JsonKey(fromJson: _readDouble)  double averageRating, @JsonKey(fromJson: _readInt)  int saveCount,  String city,  String address,  String? description,  bool bookmarked)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FeaturedPlaceApi() when $default != null:
return $default(_that.id,_that.name,_that.coverImageUrl,_that.category,_that.averageRating,_that.saveCount,_that.city,_that.address,_that.description,_that.bookmarked);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String? coverImageUrl,  String category, @JsonKey(fromJson: _readDouble)  double averageRating, @JsonKey(fromJson: _readInt)  int saveCount,  String city,  String address,  String? description,  bool bookmarked)  $default,) {final _that = this;
switch (_that) {
case _FeaturedPlaceApi():
return $default(_that.id,_that.name,_that.coverImageUrl,_that.category,_that.averageRating,_that.saveCount,_that.city,_that.address,_that.description,_that.bookmarked);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String? coverImageUrl,  String category, @JsonKey(fromJson: _readDouble)  double averageRating, @JsonKey(fromJson: _readInt)  int saveCount,  String city,  String address,  String? description,  bool bookmarked)?  $default,) {final _that = this;
switch (_that) {
case _FeaturedPlaceApi() when $default != null:
return $default(_that.id,_that.name,_that.coverImageUrl,_that.category,_that.averageRating,_that.saveCount,_that.city,_that.address,_that.description,_that.bookmarked);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FeaturedPlaceApi implements FeaturedPlaceApi {
  const _FeaturedPlaceApi({required this.id, required this.name, this.coverImageUrl, required this.category, @JsonKey(fromJson: _readDouble) required this.averageRating, @JsonKey(fromJson: _readInt) required this.saveCount, required this.city, required this.address, this.description, this.bookmarked = false});
  factory _FeaturedPlaceApi.fromJson(Map<String, dynamic> json) => _$FeaturedPlaceApiFromJson(json);

@override final  String id;
@override final  String name;
@override final  String? coverImageUrl;
@override final  String category;
@override@JsonKey(fromJson: _readDouble) final  double averageRating;
@override@JsonKey(fromJson: _readInt) final  int saveCount;
@override final  String city;
@override final  String address;
@override final  String? description;
@override@JsonKey() final  bool bookmarked;

/// Create a copy of FeaturedPlaceApi
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FeaturedPlaceApiCopyWith<_FeaturedPlaceApi> get copyWith => __$FeaturedPlaceApiCopyWithImpl<_FeaturedPlaceApi>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FeaturedPlaceApiToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _FeaturedPlaceApi&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.coverImageUrl, coverImageUrl) || other.coverImageUrl == coverImageUrl)&&(identical(other.category, category) || other.category == category)&&(identical(other.averageRating, averageRating) || other.averageRating == averageRating)&&(identical(other.saveCount, saveCount) || other.saveCount == saveCount)&&(identical(other.city, city) || other.city == city)&&(identical(other.address, address) || other.address == address)&&(identical(other.description, description) || other.description == description)&&(identical(other.bookmarked, bookmarked) || other.bookmarked == bookmarked));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,name,coverImageUrl,category,averageRating,saveCount,city,address,description,bookmarked);
}

@override
String toString() {
    return 'FeaturedPlaceApi(id: $id, name: $name, coverImageUrl: $coverImageUrl, category: $category, averageRating: $averageRating, saveCount: $saveCount, city: $city, address: $address, description: $description, bookmarked: $bookmarked)';
}


}

/// @nodoc
abstract mixin class _$FeaturedPlaceApiCopyWith<$Res> implements $FeaturedPlaceApiCopyWith<$Res> {
  factory _$FeaturedPlaceApiCopyWith(_FeaturedPlaceApi value, $Res Function(_FeaturedPlaceApi) _then) = __$FeaturedPlaceApiCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String? coverImageUrl, String category,@JsonKey(fromJson: _readDouble) double averageRating,@JsonKey(fromJson: _readInt) int saveCount, String city, String address, String? description, bool bookmarked
});




}
/// @nodoc
class __$FeaturedPlaceApiCopyWithImpl<$Res>
    implements _$FeaturedPlaceApiCopyWith<$Res> {
  __$FeaturedPlaceApiCopyWithImpl(this._self, this._then);

  final _FeaturedPlaceApi _self;
  final $Res Function(_FeaturedPlaceApi) _then;

/// Create a copy of FeaturedPlaceApi
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? coverImageUrl = freezed,Object? category = null,Object? averageRating = null,Object? saveCount = null,Object? city = null,Object? address = null,Object? description = freezed,Object? bookmarked = null,}) {
  return _then(_FeaturedPlaceApi(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,coverImageUrl: freezed == coverImageUrl ? _self.coverImageUrl : coverImageUrl // ignore: cast_nullable_to_non_nullable
as String?,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,averageRating: null == averageRating ? _self.averageRating : averageRating // ignore: cast_nullable_to_non_nullable
as double,saveCount: null == saveCount ? _self.saveCount : saveCount // ignore: cast_nullable_to_non_nullable
as int,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,bookmarked: null == bookmarked ? _self.bookmarked : bookmarked // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$NearbyPlaceApi {

 String get id; String get name; String? get coverImageUrl; String get category;@JsonKey(fromJson: _readDouble) double get averageRating;@JsonKey(fromJson: _readInt) int get reviewCount; String get address;@JsonKey(fromJson: _readInt) int get distanceMeters; String get travelMode;@JsonKey(fromJson: _readInt) int get travelMinutes;
/// Create a copy of NearbyPlaceApi
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NearbyPlaceApiCopyWith<NearbyPlaceApi> get copyWith => _$NearbyPlaceApiCopyWithImpl<NearbyPlaceApi>(this as NearbyPlaceApi, _$identity);

  /// Serializes this NearbyPlaceApi to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as NearbyPlaceApi;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NearbyPlaceApi&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.coverImageUrl, _this.coverImageUrl) || other.coverImageUrl == _this.coverImageUrl)&&(identical(other.category, _this.category) || other.category == _this.category)&&(identical(other.averageRating, _this.averageRating) || other.averageRating == _this.averageRating)&&(identical(other.reviewCount, _this.reviewCount) || other.reviewCount == _this.reviewCount)&&(identical(other.address, _this.address) || other.address == _this.address)&&(identical(other.distanceMeters, _this.distanceMeters) || other.distanceMeters == _this.distanceMeters)&&(identical(other.travelMode, _this.travelMode) || other.travelMode == _this.travelMode)&&(identical(other.travelMinutes, _this.travelMinutes) || other.travelMinutes == _this.travelMinutes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as NearbyPlaceApi;
  return Object.hash(runtimeType,_this.id,_this.name,_this.coverImageUrl,_this.category,_this.averageRating,_this.reviewCount,_this.address,_this.distanceMeters,_this.travelMode,_this.travelMinutes);
}

@override
String toString() {
  final _this = this as NearbyPlaceApi;
  return 'NearbyPlaceApi(id: ${_this.id}, name: ${_this.name}, coverImageUrl: ${_this.coverImageUrl}, category: ${_this.category}, averageRating: ${_this.averageRating}, reviewCount: ${_this.reviewCount}, address: ${_this.address}, distanceMeters: ${_this.distanceMeters}, travelMode: ${_this.travelMode}, travelMinutes: ${_this.travelMinutes})';
}


}

/// @nodoc
abstract mixin class $NearbyPlaceApiCopyWith<$Res>  {
  factory $NearbyPlaceApiCopyWith(NearbyPlaceApi value, $Res Function(NearbyPlaceApi) _then) = _$NearbyPlaceApiCopyWithImpl;
@useResult
$Res call({
 String id, String name, String? coverImageUrl, String category,@JsonKey(fromJson: _readDouble) double averageRating,@JsonKey(fromJson: _readInt) int reviewCount, String address,@JsonKey(fromJson: _readInt) int distanceMeters, String travelMode,@JsonKey(fromJson: _readInt) int travelMinutes
});




}
/// @nodoc
class _$NearbyPlaceApiCopyWithImpl<$Res>
    implements $NearbyPlaceApiCopyWith<$Res> {
  _$NearbyPlaceApiCopyWithImpl(this._self, this._then);

  final NearbyPlaceApi _self;
  final $Res Function(NearbyPlaceApi) _then;

/// Create a copy of NearbyPlaceApi
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? coverImageUrl = freezed,Object? category = null,Object? averageRating = null,Object? reviewCount = null,Object? address = null,Object? distanceMeters = null,Object? travelMode = null,Object? travelMinutes = null,}) {
  return _then(NearbyPlaceApi(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,coverImageUrl: freezed == coverImageUrl ? _self.coverImageUrl : coverImageUrl // ignore: cast_nullable_to_non_nullable
as String?,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,averageRating: null == averageRating ? _self.averageRating : averageRating // ignore: cast_nullable_to_non_nullable
as double,reviewCount: null == reviewCount ? _self.reviewCount : reviewCount // ignore: cast_nullable_to_non_nullable
as int,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,distanceMeters: null == distanceMeters ? _self.distanceMeters : distanceMeters // ignore: cast_nullable_to_non_nullable
as int,travelMode: null == travelMode ? _self.travelMode : travelMode // ignore: cast_nullable_to_non_nullable
as String,travelMinutes: null == travelMinutes ? _self.travelMinutes : travelMinutes // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [NearbyPlaceApi].
extension NearbyPlaceApiPatterns on NearbyPlaceApi {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NearbyPlaceApi value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NearbyPlaceApi() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NearbyPlaceApi value)  $default,){
final _that = this;
switch (_that) {
case _NearbyPlaceApi():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NearbyPlaceApi value)?  $default,){
final _that = this;
switch (_that) {
case _NearbyPlaceApi() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String? coverImageUrl,  String category, @JsonKey(fromJson: _readDouble)  double averageRating, @JsonKey(fromJson: _readInt)  int reviewCount,  String address, @JsonKey(fromJson: _readInt)  int distanceMeters,  String travelMode, @JsonKey(fromJson: _readInt)  int travelMinutes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NearbyPlaceApi() when $default != null:
return $default(_that.id,_that.name,_that.coverImageUrl,_that.category,_that.averageRating,_that.reviewCount,_that.address,_that.distanceMeters,_that.travelMode,_that.travelMinutes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String? coverImageUrl,  String category, @JsonKey(fromJson: _readDouble)  double averageRating, @JsonKey(fromJson: _readInt)  int reviewCount,  String address, @JsonKey(fromJson: _readInt)  int distanceMeters,  String travelMode, @JsonKey(fromJson: _readInt)  int travelMinutes)  $default,) {final _that = this;
switch (_that) {
case _NearbyPlaceApi():
return $default(_that.id,_that.name,_that.coverImageUrl,_that.category,_that.averageRating,_that.reviewCount,_that.address,_that.distanceMeters,_that.travelMode,_that.travelMinutes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String? coverImageUrl,  String category, @JsonKey(fromJson: _readDouble)  double averageRating, @JsonKey(fromJson: _readInt)  int reviewCount,  String address, @JsonKey(fromJson: _readInt)  int distanceMeters,  String travelMode, @JsonKey(fromJson: _readInt)  int travelMinutes)?  $default,) {final _that = this;
switch (_that) {
case _NearbyPlaceApi() when $default != null:
return $default(_that.id,_that.name,_that.coverImageUrl,_that.category,_that.averageRating,_that.reviewCount,_that.address,_that.distanceMeters,_that.travelMode,_that.travelMinutes);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NearbyPlaceApi implements NearbyPlaceApi {
  const _NearbyPlaceApi({required this.id, required this.name, this.coverImageUrl, required this.category, @JsonKey(fromJson: _readDouble) required this.averageRating, @JsonKey(fromJson: _readInt) required this.reviewCount, required this.address, @JsonKey(fromJson: _readInt) required this.distanceMeters, required this.travelMode, @JsonKey(fromJson: _readInt) required this.travelMinutes});
  factory _NearbyPlaceApi.fromJson(Map<String, dynamic> json) => _$NearbyPlaceApiFromJson(json);

@override final  String id;
@override final  String name;
@override final  String? coverImageUrl;
@override final  String category;
@override@JsonKey(fromJson: _readDouble) final  double averageRating;
@override@JsonKey(fromJson: _readInt) final  int reviewCount;
@override final  String address;
@override@JsonKey(fromJson: _readInt) final  int distanceMeters;
@override final  String travelMode;
@override@JsonKey(fromJson: _readInt) final  int travelMinutes;

/// Create a copy of NearbyPlaceApi
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NearbyPlaceApiCopyWith<_NearbyPlaceApi> get copyWith => __$NearbyPlaceApiCopyWithImpl<_NearbyPlaceApi>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NearbyPlaceApiToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _NearbyPlaceApi&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.coverImageUrl, coverImageUrl) || other.coverImageUrl == coverImageUrl)&&(identical(other.category, category) || other.category == category)&&(identical(other.averageRating, averageRating) || other.averageRating == averageRating)&&(identical(other.reviewCount, reviewCount) || other.reviewCount == reviewCount)&&(identical(other.address, address) || other.address == address)&&(identical(other.distanceMeters, distanceMeters) || other.distanceMeters == distanceMeters)&&(identical(other.travelMode, travelMode) || other.travelMode == travelMode)&&(identical(other.travelMinutes, travelMinutes) || other.travelMinutes == travelMinutes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,name,coverImageUrl,category,averageRating,reviewCount,address,distanceMeters,travelMode,travelMinutes);
}

@override
String toString() {
    return 'NearbyPlaceApi(id: $id, name: $name, coverImageUrl: $coverImageUrl, category: $category, averageRating: $averageRating, reviewCount: $reviewCount, address: $address, distanceMeters: $distanceMeters, travelMode: $travelMode, travelMinutes: $travelMinutes)';
}


}

/// @nodoc
abstract mixin class _$NearbyPlaceApiCopyWith<$Res> implements $NearbyPlaceApiCopyWith<$Res> {
  factory _$NearbyPlaceApiCopyWith(_NearbyPlaceApi value, $Res Function(_NearbyPlaceApi) _then) = __$NearbyPlaceApiCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String? coverImageUrl, String category,@JsonKey(fromJson: _readDouble) double averageRating,@JsonKey(fromJson: _readInt) int reviewCount, String address,@JsonKey(fromJson: _readInt) int distanceMeters, String travelMode,@JsonKey(fromJson: _readInt) int travelMinutes
});




}
/// @nodoc
class __$NearbyPlaceApiCopyWithImpl<$Res>
    implements _$NearbyPlaceApiCopyWith<$Res> {
  __$NearbyPlaceApiCopyWithImpl(this._self, this._then);

  final _NearbyPlaceApi _self;
  final $Res Function(_NearbyPlaceApi) _then;

/// Create a copy of NearbyPlaceApi
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? coverImageUrl = freezed,Object? category = null,Object? averageRating = null,Object? reviewCount = null,Object? address = null,Object? distanceMeters = null,Object? travelMode = null,Object? travelMinutes = null,}) {
  return _then(_NearbyPlaceApi(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,coverImageUrl: freezed == coverImageUrl ? _self.coverImageUrl : coverImageUrl // ignore: cast_nullable_to_non_nullable
as String?,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,averageRating: null == averageRating ? _self.averageRating : averageRating // ignore: cast_nullable_to_non_nullable
as double,reviewCount: null == reviewCount ? _self.reviewCount : reviewCount // ignore: cast_nullable_to_non_nullable
as int,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,distanceMeters: null == distanceMeters ? _self.distanceMeters : distanceMeters // ignore: cast_nullable_to_non_nullable
as int,travelMode: null == travelMode ? _self.travelMode : travelMode // ignore: cast_nullable_to_non_nullable
as String,travelMinutes: null == travelMinutes ? _self.travelMinutes : travelMinutes // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$FeaturedCollectionApi {

 String get id; String get title; String get ownerDisplayName; String? get coverImageUrl;@JsonKey(fromJson: _readInt) int get placeCount;@JsonKey(fromJson: _readDoubleOrNull) double? get averageRating;@JsonKey(fromJson: _readInt) int get ratingCount;
/// Create a copy of FeaturedCollectionApi
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeaturedCollectionApiCopyWith<FeaturedCollectionApi> get copyWith => _$FeaturedCollectionApiCopyWithImpl<FeaturedCollectionApi>(this as FeaturedCollectionApi, _$identity);

  /// Serializes this FeaturedCollectionApi to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as FeaturedCollectionApi;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeaturedCollectionApi&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.ownerDisplayName, _this.ownerDisplayName) || other.ownerDisplayName == _this.ownerDisplayName)&&(identical(other.coverImageUrl, _this.coverImageUrl) || other.coverImageUrl == _this.coverImageUrl)&&(identical(other.placeCount, _this.placeCount) || other.placeCount == _this.placeCount)&&(identical(other.averageRating, _this.averageRating) || other.averageRating == _this.averageRating)&&(identical(other.ratingCount, _this.ratingCount) || other.ratingCount == _this.ratingCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as FeaturedCollectionApi;
  return Object.hash(runtimeType,_this.id,_this.title,_this.ownerDisplayName,_this.coverImageUrl,_this.placeCount,_this.averageRating,_this.ratingCount);
}

@override
String toString() {
  final _this = this as FeaturedCollectionApi;
  return 'FeaturedCollectionApi(id: ${_this.id}, title: ${_this.title}, ownerDisplayName: ${_this.ownerDisplayName}, coverImageUrl: ${_this.coverImageUrl}, placeCount: ${_this.placeCount}, averageRating: ${_this.averageRating}, ratingCount: ${_this.ratingCount})';
}


}

/// @nodoc
abstract mixin class $FeaturedCollectionApiCopyWith<$Res>  {
  factory $FeaturedCollectionApiCopyWith(FeaturedCollectionApi value, $Res Function(FeaturedCollectionApi) _then) = _$FeaturedCollectionApiCopyWithImpl;
@useResult
$Res call({
 String id, String title, String ownerDisplayName, String? coverImageUrl,@JsonKey(fromJson: _readInt) int placeCount,@JsonKey(fromJson: _readDoubleOrNull) double? averageRating,@JsonKey(fromJson: _readInt) int ratingCount
});




}
/// @nodoc
class _$FeaturedCollectionApiCopyWithImpl<$Res>
    implements $FeaturedCollectionApiCopyWith<$Res> {
  _$FeaturedCollectionApiCopyWithImpl(this._self, this._then);

  final FeaturedCollectionApi _self;
  final $Res Function(FeaturedCollectionApi) _then;

/// Create a copy of FeaturedCollectionApi
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? ownerDisplayName = null,Object? coverImageUrl = freezed,Object? placeCount = null,Object? averageRating = freezed,Object? ratingCount = null,}) {
  return _then(FeaturedCollectionApi(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,ownerDisplayName: null == ownerDisplayName ? _self.ownerDisplayName : ownerDisplayName // ignore: cast_nullable_to_non_nullable
as String,coverImageUrl: freezed == coverImageUrl ? _self.coverImageUrl : coverImageUrl // ignore: cast_nullable_to_non_nullable
as String?,placeCount: null == placeCount ? _self.placeCount : placeCount // ignore: cast_nullable_to_non_nullable
as int,averageRating: freezed == averageRating ? _self.averageRating : averageRating // ignore: cast_nullable_to_non_nullable
as double?,ratingCount: null == ratingCount ? _self.ratingCount : ratingCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [FeaturedCollectionApi].
extension FeaturedCollectionApiPatterns on FeaturedCollectionApi {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FeaturedCollectionApi value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FeaturedCollectionApi() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FeaturedCollectionApi value)  $default,){
final _that = this;
switch (_that) {
case _FeaturedCollectionApi():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FeaturedCollectionApi value)?  $default,){
final _that = this;
switch (_that) {
case _FeaturedCollectionApi() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String ownerDisplayName,  String? coverImageUrl, @JsonKey(fromJson: _readInt)  int placeCount, @JsonKey(fromJson: _readDoubleOrNull)  double? averageRating, @JsonKey(fromJson: _readInt)  int ratingCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FeaturedCollectionApi() when $default != null:
return $default(_that.id,_that.title,_that.ownerDisplayName,_that.coverImageUrl,_that.placeCount,_that.averageRating,_that.ratingCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String ownerDisplayName,  String? coverImageUrl, @JsonKey(fromJson: _readInt)  int placeCount, @JsonKey(fromJson: _readDoubleOrNull)  double? averageRating, @JsonKey(fromJson: _readInt)  int ratingCount)  $default,) {final _that = this;
switch (_that) {
case _FeaturedCollectionApi():
return $default(_that.id,_that.title,_that.ownerDisplayName,_that.coverImageUrl,_that.placeCount,_that.averageRating,_that.ratingCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String ownerDisplayName,  String? coverImageUrl, @JsonKey(fromJson: _readInt)  int placeCount, @JsonKey(fromJson: _readDoubleOrNull)  double? averageRating, @JsonKey(fromJson: _readInt)  int ratingCount)?  $default,) {final _that = this;
switch (_that) {
case _FeaturedCollectionApi() when $default != null:
return $default(_that.id,_that.title,_that.ownerDisplayName,_that.coverImageUrl,_that.placeCount,_that.averageRating,_that.ratingCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FeaturedCollectionApi implements FeaturedCollectionApi {
  const _FeaturedCollectionApi({required this.id, required this.title, required this.ownerDisplayName, this.coverImageUrl, @JsonKey(fromJson: _readInt) required this.placeCount, @JsonKey(fromJson: _readDoubleOrNull) this.averageRating, @JsonKey(fromJson: _readInt) required this.ratingCount});
  factory _FeaturedCollectionApi.fromJson(Map<String, dynamic> json) => _$FeaturedCollectionApiFromJson(json);

@override final  String id;
@override final  String title;
@override final  String ownerDisplayName;
@override final  String? coverImageUrl;
@override@JsonKey(fromJson: _readInt) final  int placeCount;
@override@JsonKey(fromJson: _readDoubleOrNull) final  double? averageRating;
@override@JsonKey(fromJson: _readInt) final  int ratingCount;

/// Create a copy of FeaturedCollectionApi
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FeaturedCollectionApiCopyWith<_FeaturedCollectionApi> get copyWith => __$FeaturedCollectionApiCopyWithImpl<_FeaturedCollectionApi>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FeaturedCollectionApiToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _FeaturedCollectionApi&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.ownerDisplayName, ownerDisplayName) || other.ownerDisplayName == ownerDisplayName)&&(identical(other.coverImageUrl, coverImageUrl) || other.coverImageUrl == coverImageUrl)&&(identical(other.placeCount, placeCount) || other.placeCount == placeCount)&&(identical(other.averageRating, averageRating) || other.averageRating == averageRating)&&(identical(other.ratingCount, ratingCount) || other.ratingCount == ratingCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,title,ownerDisplayName,coverImageUrl,placeCount,averageRating,ratingCount);
}

@override
String toString() {
    return 'FeaturedCollectionApi(id: $id, title: $title, ownerDisplayName: $ownerDisplayName, coverImageUrl: $coverImageUrl, placeCount: $placeCount, averageRating: $averageRating, ratingCount: $ratingCount)';
}


}

/// @nodoc
abstract mixin class _$FeaturedCollectionApiCopyWith<$Res> implements $FeaturedCollectionApiCopyWith<$Res> {
  factory _$FeaturedCollectionApiCopyWith(_FeaturedCollectionApi value, $Res Function(_FeaturedCollectionApi) _then) = __$FeaturedCollectionApiCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String ownerDisplayName, String? coverImageUrl,@JsonKey(fromJson: _readInt) int placeCount,@JsonKey(fromJson: _readDoubleOrNull) double? averageRating,@JsonKey(fromJson: _readInt) int ratingCount
});




}
/// @nodoc
class __$FeaturedCollectionApiCopyWithImpl<$Res>
    implements _$FeaturedCollectionApiCopyWith<$Res> {
  __$FeaturedCollectionApiCopyWithImpl(this._self, this._then);

  final _FeaturedCollectionApi _self;
  final $Res Function(_FeaturedCollectionApi) _then;

/// Create a copy of FeaturedCollectionApi
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? ownerDisplayName = null,Object? coverImageUrl = freezed,Object? placeCount = null,Object? averageRating = freezed,Object? ratingCount = null,}) {
  return _then(_FeaturedCollectionApi(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,ownerDisplayName: null == ownerDisplayName ? _self.ownerDisplayName : ownerDisplayName // ignore: cast_nullable_to_non_nullable
as String,coverImageUrl: freezed == coverImageUrl ? _self.coverImageUrl : coverImageUrl // ignore: cast_nullable_to_non_nullable
as String?,placeCount: null == placeCount ? _self.placeCount : placeCount // ignore: cast_nullable_to_non_nullable
as int,averageRating: freezed == averageRating ? _self.averageRating : averageRating // ignore: cast_nullable_to_non_nullable
as double?,ratingCount: null == ratingCount ? _self.ratingCount : ratingCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$OwnedPlaceCollection {

 String get id; String get title; String get visibility;@JsonKey(fromJson: _readInt) int get placeCount; List<String> get placeIds;
/// Create a copy of OwnedPlaceCollection
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OwnedPlaceCollectionCopyWith<OwnedPlaceCollection> get copyWith => _$OwnedPlaceCollectionCopyWithImpl<OwnedPlaceCollection>(this as OwnedPlaceCollection, _$identity);

  /// Serializes this OwnedPlaceCollection to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as OwnedPlaceCollection;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OwnedPlaceCollection&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.visibility, _this.visibility) || other.visibility == _this.visibility)&&(identical(other.placeCount, _this.placeCount) || other.placeCount == _this.placeCount)&&const DeepCollectionEquality().equals(other.placeIds, _this.placeIds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as OwnedPlaceCollection;
  return Object.hash(runtimeType,_this.id,_this.title,_this.visibility,_this.placeCount,const DeepCollectionEquality().hash(_this.placeIds));
}

@override
String toString() {
  final _this = this as OwnedPlaceCollection;
  return 'OwnedPlaceCollection(id: ${_this.id}, title: ${_this.title}, visibility: ${_this.visibility}, placeCount: ${_this.placeCount}, placeIds: ${_this.placeIds})';
}


}

/// @nodoc
abstract mixin class $OwnedPlaceCollectionCopyWith<$Res>  {
  factory $OwnedPlaceCollectionCopyWith(OwnedPlaceCollection value, $Res Function(OwnedPlaceCollection) _then) = _$OwnedPlaceCollectionCopyWithImpl;
@useResult
$Res call({
 String id, String title, String visibility,@JsonKey(fromJson: _readInt) int placeCount, List<String> placeIds
});




}
/// @nodoc
class _$OwnedPlaceCollectionCopyWithImpl<$Res>
    implements $OwnedPlaceCollectionCopyWith<$Res> {
  _$OwnedPlaceCollectionCopyWithImpl(this._self, this._then);

  final OwnedPlaceCollection _self;
  final $Res Function(OwnedPlaceCollection) _then;

/// Create a copy of OwnedPlaceCollection
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? visibility = null,Object? placeCount = null,Object? placeIds = null,}) {
  return _then(OwnedPlaceCollection(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,visibility: null == visibility ? _self.visibility : visibility // ignore: cast_nullable_to_non_nullable
as String,placeCount: null == placeCount ? _self.placeCount : placeCount // ignore: cast_nullable_to_non_nullable
as int,placeIds: null == placeIds ? _self.placeIds : placeIds // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [OwnedPlaceCollection].
extension OwnedPlaceCollectionPatterns on OwnedPlaceCollection {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OwnedPlaceCollection value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OwnedPlaceCollection() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OwnedPlaceCollection value)  $default,){
final _that = this;
switch (_that) {
case _OwnedPlaceCollection():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OwnedPlaceCollection value)?  $default,){
final _that = this;
switch (_that) {
case _OwnedPlaceCollection() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String visibility, @JsonKey(fromJson: _readInt)  int placeCount,  List<String> placeIds)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OwnedPlaceCollection() when $default != null:
return $default(_that.id,_that.title,_that.visibility,_that.placeCount,_that.placeIds);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String visibility, @JsonKey(fromJson: _readInt)  int placeCount,  List<String> placeIds)  $default,) {final _that = this;
switch (_that) {
case _OwnedPlaceCollection():
return $default(_that.id,_that.title,_that.visibility,_that.placeCount,_that.placeIds);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String visibility, @JsonKey(fromJson: _readInt)  int placeCount,  List<String> placeIds)?  $default,) {final _that = this;
switch (_that) {
case _OwnedPlaceCollection() when $default != null:
return $default(_that.id,_that.title,_that.visibility,_that.placeCount,_that.placeIds);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OwnedPlaceCollection implements OwnedPlaceCollection {
  const _OwnedPlaceCollection({required this.id, required this.title, required this.visibility, @JsonKey(fromJson: _readInt) required this.placeCount,  List<String> placeIds = const <String>[]}): _placeIds = placeIds;
  factory _OwnedPlaceCollection.fromJson(Map<String, dynamic> json) => _$OwnedPlaceCollectionFromJson(json);

@override final  String id;
@override final  String title;
@override final  String visibility;
@override@JsonKey(fromJson: _readInt) final  int placeCount;
 final  List<String> _placeIds;
@override@JsonKey() List<String> get placeIds {
  if (_placeIds is EqualUnmodifiableListView) return _placeIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_placeIds);
}


/// Create a copy of OwnedPlaceCollection
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OwnedPlaceCollectionCopyWith<_OwnedPlaceCollection> get copyWith => __$OwnedPlaceCollectionCopyWithImpl<_OwnedPlaceCollection>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OwnedPlaceCollectionToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _OwnedPlaceCollection&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.visibility, visibility) || other.visibility == visibility)&&(identical(other.placeCount, placeCount) || other.placeCount == placeCount)&&const DeepCollectionEquality().equals(other.placeIds, _placeIds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,title,visibility,placeCount,const DeepCollectionEquality().hash(_placeIds));
}

@override
String toString() {
    return 'OwnedPlaceCollection(id: $id, title: $title, visibility: $visibility, placeCount: $placeCount, placeIds: $placeIds)';
}


}

/// @nodoc
abstract mixin class _$OwnedPlaceCollectionCopyWith<$Res> implements $OwnedPlaceCollectionCopyWith<$Res> {
  factory _$OwnedPlaceCollectionCopyWith(_OwnedPlaceCollection value, $Res Function(_OwnedPlaceCollection) _then) = __$OwnedPlaceCollectionCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String visibility,@JsonKey(fromJson: _readInt) int placeCount, List<String> placeIds
});




}
/// @nodoc
class __$OwnedPlaceCollectionCopyWithImpl<$Res>
    implements _$OwnedPlaceCollectionCopyWith<$Res> {
  __$OwnedPlaceCollectionCopyWithImpl(this._self, this._then);

  final _OwnedPlaceCollection _self;
  final $Res Function(_OwnedPlaceCollection) _then;

/// Create a copy of OwnedPlaceCollection
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? visibility = null,Object? placeCount = null,Object? placeIds = null,}) {
  return _then(_OwnedPlaceCollection(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,visibility: null == visibility ? _self.visibility : visibility // ignore: cast_nullable_to_non_nullable
as String,placeCount: null == placeCount ? _self.placeCount : placeCount // ignore: cast_nullable_to_non_nullable
as int,placeIds: null == placeIds ? _self._placeIds : placeIds // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}


/// @nodoc
mixin _$CollectionPlaceItem {

 String get id; String get name; String? get coverImageUrl; String get category; String get city;@JsonKey(fromJson: _readDouble) double get averageRating;
/// Create a copy of CollectionPlaceItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CollectionPlaceItemCopyWith<CollectionPlaceItem> get copyWith => _$CollectionPlaceItemCopyWithImpl<CollectionPlaceItem>(this as CollectionPlaceItem, _$identity);

  /// Serializes this CollectionPlaceItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as CollectionPlaceItem;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CollectionPlaceItem&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.coverImageUrl, _this.coverImageUrl) || other.coverImageUrl == _this.coverImageUrl)&&(identical(other.category, _this.category) || other.category == _this.category)&&(identical(other.city, _this.city) || other.city == _this.city)&&(identical(other.averageRating, _this.averageRating) || other.averageRating == _this.averageRating));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as CollectionPlaceItem;
  return Object.hash(runtimeType,_this.id,_this.name,_this.coverImageUrl,_this.category,_this.city,_this.averageRating);
}

@override
String toString() {
  final _this = this as CollectionPlaceItem;
  return 'CollectionPlaceItem(id: ${_this.id}, name: ${_this.name}, coverImageUrl: ${_this.coverImageUrl}, category: ${_this.category}, city: ${_this.city}, averageRating: ${_this.averageRating})';
}


}

/// @nodoc
abstract mixin class $CollectionPlaceItemCopyWith<$Res>  {
  factory $CollectionPlaceItemCopyWith(CollectionPlaceItem value, $Res Function(CollectionPlaceItem) _then) = _$CollectionPlaceItemCopyWithImpl;
@useResult
$Res call({
 String id, String name, String? coverImageUrl, String category, String city,@JsonKey(fromJson: _readDouble) double averageRating
});




}
/// @nodoc
class _$CollectionPlaceItemCopyWithImpl<$Res>
    implements $CollectionPlaceItemCopyWith<$Res> {
  _$CollectionPlaceItemCopyWithImpl(this._self, this._then);

  final CollectionPlaceItem _self;
  final $Res Function(CollectionPlaceItem) _then;

/// Create a copy of CollectionPlaceItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? coverImageUrl = freezed,Object? category = null,Object? city = null,Object? averageRating = null,}) {
  return _then(CollectionPlaceItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,coverImageUrl: freezed == coverImageUrl ? _self.coverImageUrl : coverImageUrl // ignore: cast_nullable_to_non_nullable
as String?,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,averageRating: null == averageRating ? _self.averageRating : averageRating // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [CollectionPlaceItem].
extension CollectionPlaceItemPatterns on CollectionPlaceItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CollectionPlaceItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CollectionPlaceItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CollectionPlaceItem value)  $default,){
final _that = this;
switch (_that) {
case _CollectionPlaceItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CollectionPlaceItem value)?  $default,){
final _that = this;
switch (_that) {
case _CollectionPlaceItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String? coverImageUrl,  String category,  String city, @JsonKey(fromJson: _readDouble)  double averageRating)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CollectionPlaceItem() when $default != null:
return $default(_that.id,_that.name,_that.coverImageUrl,_that.category,_that.city,_that.averageRating);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String? coverImageUrl,  String category,  String city, @JsonKey(fromJson: _readDouble)  double averageRating)  $default,) {final _that = this;
switch (_that) {
case _CollectionPlaceItem():
return $default(_that.id,_that.name,_that.coverImageUrl,_that.category,_that.city,_that.averageRating);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String? coverImageUrl,  String category,  String city, @JsonKey(fromJson: _readDouble)  double averageRating)?  $default,) {final _that = this;
switch (_that) {
case _CollectionPlaceItem() when $default != null:
return $default(_that.id,_that.name,_that.coverImageUrl,_that.category,_that.city,_that.averageRating);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CollectionPlaceItem implements CollectionPlaceItem {
  const _CollectionPlaceItem({required this.id, required this.name, this.coverImageUrl, required this.category, required this.city, @JsonKey(fromJson: _readDouble) required this.averageRating});
  factory _CollectionPlaceItem.fromJson(Map<String, dynamic> json) => _$CollectionPlaceItemFromJson(json);

@override final  String id;
@override final  String name;
@override final  String? coverImageUrl;
@override final  String category;
@override final  String city;
@override@JsonKey(fromJson: _readDouble) final  double averageRating;

/// Create a copy of CollectionPlaceItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CollectionPlaceItemCopyWith<_CollectionPlaceItem> get copyWith => __$CollectionPlaceItemCopyWithImpl<_CollectionPlaceItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CollectionPlaceItemToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CollectionPlaceItem&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.coverImageUrl, coverImageUrl) || other.coverImageUrl == coverImageUrl)&&(identical(other.category, category) || other.category == category)&&(identical(other.city, city) || other.city == city)&&(identical(other.averageRating, averageRating) || other.averageRating == averageRating));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,name,coverImageUrl,category,city,averageRating);
}

@override
String toString() {
    return 'CollectionPlaceItem(id: $id, name: $name, coverImageUrl: $coverImageUrl, category: $category, city: $city, averageRating: $averageRating)';
}


}

/// @nodoc
abstract mixin class _$CollectionPlaceItemCopyWith<$Res> implements $CollectionPlaceItemCopyWith<$Res> {
  factory _$CollectionPlaceItemCopyWith(_CollectionPlaceItem value, $Res Function(_CollectionPlaceItem) _then) = __$CollectionPlaceItemCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String? coverImageUrl, String category, String city,@JsonKey(fromJson: _readDouble) double averageRating
});




}
/// @nodoc
class __$CollectionPlaceItemCopyWithImpl<$Res>
    implements _$CollectionPlaceItemCopyWith<$Res> {
  __$CollectionPlaceItemCopyWithImpl(this._self, this._then);

  final _CollectionPlaceItem _self;
  final $Res Function(_CollectionPlaceItem) _then;

/// Create a copy of CollectionPlaceItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? coverImageUrl = freezed,Object? category = null,Object? city = null,Object? averageRating = null,}) {
  return _then(_CollectionPlaceItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,coverImageUrl: freezed == coverImageUrl ? _self.coverImageUrl : coverImageUrl // ignore: cast_nullable_to_non_nullable
as String?,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,averageRating: null == averageRating ? _self.averageRating : averageRating // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$PlaceCollectionDetail {

 String get id; String get title; String get visibility; String get ownerDisplayName; String? get coverImageUrl;@JsonKey(fromJson: _readInt) int get placeCount;@JsonKey(fromJson: _readDoubleOrNull) double? get averageRating;@JsonKey(fromJson: _readInt) int get ratingCount;@JsonKey(fromJson: _readIntNullable) int? get viewerRating; bool get copiedByViewer; List<CollectionPlaceItem> get places;
/// Create a copy of PlaceCollectionDetail
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlaceCollectionDetailCopyWith<PlaceCollectionDetail> get copyWith => _$PlaceCollectionDetailCopyWithImpl<PlaceCollectionDetail>(this as PlaceCollectionDetail, _$identity);

  /// Serializes this PlaceCollectionDetail to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as PlaceCollectionDetail;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlaceCollectionDetail&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.visibility, _this.visibility) || other.visibility == _this.visibility)&&(identical(other.ownerDisplayName, _this.ownerDisplayName) || other.ownerDisplayName == _this.ownerDisplayName)&&(identical(other.coverImageUrl, _this.coverImageUrl) || other.coverImageUrl == _this.coverImageUrl)&&(identical(other.placeCount, _this.placeCount) || other.placeCount == _this.placeCount)&&(identical(other.averageRating, _this.averageRating) || other.averageRating == _this.averageRating)&&(identical(other.ratingCount, _this.ratingCount) || other.ratingCount == _this.ratingCount)&&(identical(other.viewerRating, _this.viewerRating) || other.viewerRating == _this.viewerRating)&&(identical(other.copiedByViewer, _this.copiedByViewer) || other.copiedByViewer == _this.copiedByViewer)&&const DeepCollectionEquality().equals(other.places, _this.places));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as PlaceCollectionDetail;
  return Object.hash(runtimeType,_this.id,_this.title,_this.visibility,_this.ownerDisplayName,_this.coverImageUrl,_this.placeCount,_this.averageRating,_this.ratingCount,_this.viewerRating,_this.copiedByViewer,const DeepCollectionEquality().hash(_this.places));
}

@override
String toString() {
  final _this = this as PlaceCollectionDetail;
  return 'PlaceCollectionDetail(id: ${_this.id}, title: ${_this.title}, visibility: ${_this.visibility}, ownerDisplayName: ${_this.ownerDisplayName}, coverImageUrl: ${_this.coverImageUrl}, placeCount: ${_this.placeCount}, averageRating: ${_this.averageRating}, ratingCount: ${_this.ratingCount}, viewerRating: ${_this.viewerRating}, copiedByViewer: ${_this.copiedByViewer}, places: ${_this.places})';
}


}

/// @nodoc
abstract mixin class $PlaceCollectionDetailCopyWith<$Res>  {
  factory $PlaceCollectionDetailCopyWith(PlaceCollectionDetail value, $Res Function(PlaceCollectionDetail) _then) = _$PlaceCollectionDetailCopyWithImpl;
@useResult
$Res call({
 String id, String title, String visibility, String ownerDisplayName, String? coverImageUrl,@JsonKey(fromJson: _readInt) int placeCount,@JsonKey(fromJson: _readDoubleOrNull) double? averageRating,@JsonKey(fromJson: _readInt) int ratingCount,@JsonKey(fromJson: _readIntNullable) int? viewerRating, bool copiedByViewer, List<CollectionPlaceItem> places
});




}
/// @nodoc
class _$PlaceCollectionDetailCopyWithImpl<$Res>
    implements $PlaceCollectionDetailCopyWith<$Res> {
  _$PlaceCollectionDetailCopyWithImpl(this._self, this._then);

  final PlaceCollectionDetail _self;
  final $Res Function(PlaceCollectionDetail) _then;

/// Create a copy of PlaceCollectionDetail
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? visibility = null,Object? ownerDisplayName = null,Object? coverImageUrl = freezed,Object? placeCount = null,Object? averageRating = freezed,Object? ratingCount = null,Object? viewerRating = freezed,Object? copiedByViewer = null,Object? places = null,}) {
  return _then(PlaceCollectionDetail(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,visibility: null == visibility ? _self.visibility : visibility // ignore: cast_nullable_to_non_nullable
as String,ownerDisplayName: null == ownerDisplayName ? _self.ownerDisplayName : ownerDisplayName // ignore: cast_nullable_to_non_nullable
as String,coverImageUrl: freezed == coverImageUrl ? _self.coverImageUrl : coverImageUrl // ignore: cast_nullable_to_non_nullable
as String?,placeCount: null == placeCount ? _self.placeCount : placeCount // ignore: cast_nullable_to_non_nullable
as int,averageRating: freezed == averageRating ? _self.averageRating : averageRating // ignore: cast_nullable_to_non_nullable
as double?,ratingCount: null == ratingCount ? _self.ratingCount : ratingCount // ignore: cast_nullable_to_non_nullable
as int,viewerRating: freezed == viewerRating ? _self.viewerRating : viewerRating // ignore: cast_nullable_to_non_nullable
as int?,copiedByViewer: null == copiedByViewer ? _self.copiedByViewer : copiedByViewer // ignore: cast_nullable_to_non_nullable
as bool,places: null == places ? _self.places : places // ignore: cast_nullable_to_non_nullable
as List<CollectionPlaceItem>,
  ));
}

}


/// Adds pattern-matching-related methods to [PlaceCollectionDetail].
extension PlaceCollectionDetailPatterns on PlaceCollectionDetail {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlaceCollectionDetail value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlaceCollectionDetail() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlaceCollectionDetail value)  $default,){
final _that = this;
switch (_that) {
case _PlaceCollectionDetail():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlaceCollectionDetail value)?  $default,){
final _that = this;
switch (_that) {
case _PlaceCollectionDetail() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String visibility,  String ownerDisplayName,  String? coverImageUrl, @JsonKey(fromJson: _readInt)  int placeCount, @JsonKey(fromJson: _readDoubleOrNull)  double? averageRating, @JsonKey(fromJson: _readInt)  int ratingCount, @JsonKey(fromJson: _readIntNullable)  int? viewerRating,  bool copiedByViewer,  List<CollectionPlaceItem> places)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlaceCollectionDetail() when $default != null:
return $default(_that.id,_that.title,_that.visibility,_that.ownerDisplayName,_that.coverImageUrl,_that.placeCount,_that.averageRating,_that.ratingCount,_that.viewerRating,_that.copiedByViewer,_that.places);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String visibility,  String ownerDisplayName,  String? coverImageUrl, @JsonKey(fromJson: _readInt)  int placeCount, @JsonKey(fromJson: _readDoubleOrNull)  double? averageRating, @JsonKey(fromJson: _readInt)  int ratingCount, @JsonKey(fromJson: _readIntNullable)  int? viewerRating,  bool copiedByViewer,  List<CollectionPlaceItem> places)  $default,) {final _that = this;
switch (_that) {
case _PlaceCollectionDetail():
return $default(_that.id,_that.title,_that.visibility,_that.ownerDisplayName,_that.coverImageUrl,_that.placeCount,_that.averageRating,_that.ratingCount,_that.viewerRating,_that.copiedByViewer,_that.places);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String visibility,  String ownerDisplayName,  String? coverImageUrl, @JsonKey(fromJson: _readInt)  int placeCount, @JsonKey(fromJson: _readDoubleOrNull)  double? averageRating, @JsonKey(fromJson: _readInt)  int ratingCount, @JsonKey(fromJson: _readIntNullable)  int? viewerRating,  bool copiedByViewer,  List<CollectionPlaceItem> places)?  $default,) {final _that = this;
switch (_that) {
case _PlaceCollectionDetail() when $default != null:
return $default(_that.id,_that.title,_that.visibility,_that.ownerDisplayName,_that.coverImageUrl,_that.placeCount,_that.averageRating,_that.ratingCount,_that.viewerRating,_that.copiedByViewer,_that.places);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PlaceCollectionDetail implements PlaceCollectionDetail {
  const _PlaceCollectionDetail({required this.id, required this.title, required this.visibility, required this.ownerDisplayName, this.coverImageUrl, @JsonKey(fromJson: _readInt) required this.placeCount, @JsonKey(fromJson: _readDoubleOrNull) this.averageRating, @JsonKey(fromJson: _readInt) required this.ratingCount, @JsonKey(fromJson: _readIntNullable) this.viewerRating, this.copiedByViewer = false,  List<CollectionPlaceItem> places = const <CollectionPlaceItem>[]}): _places = places;
  factory _PlaceCollectionDetail.fromJson(Map<String, dynamic> json) => _$PlaceCollectionDetailFromJson(json);

@override final  String id;
@override final  String title;
@override final  String visibility;
@override final  String ownerDisplayName;
@override final  String? coverImageUrl;
@override@JsonKey(fromJson: _readInt) final  int placeCount;
@override@JsonKey(fromJson: _readDoubleOrNull) final  double? averageRating;
@override@JsonKey(fromJson: _readInt) final  int ratingCount;
@override@JsonKey(fromJson: _readIntNullable) final  int? viewerRating;
@override@JsonKey() final  bool copiedByViewer;
 final  List<CollectionPlaceItem> _places;
@override@JsonKey() List<CollectionPlaceItem> get places {
  if (_places is EqualUnmodifiableListView) return _places;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_places);
}


/// Create a copy of PlaceCollectionDetail
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlaceCollectionDetailCopyWith<_PlaceCollectionDetail> get copyWith => __$PlaceCollectionDetailCopyWithImpl<_PlaceCollectionDetail>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlaceCollectionDetailToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlaceCollectionDetail&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.visibility, visibility) || other.visibility == visibility)&&(identical(other.ownerDisplayName, ownerDisplayName) || other.ownerDisplayName == ownerDisplayName)&&(identical(other.coverImageUrl, coverImageUrl) || other.coverImageUrl == coverImageUrl)&&(identical(other.placeCount, placeCount) || other.placeCount == placeCount)&&(identical(other.averageRating, averageRating) || other.averageRating == averageRating)&&(identical(other.ratingCount, ratingCount) || other.ratingCount == ratingCount)&&(identical(other.viewerRating, viewerRating) || other.viewerRating == viewerRating)&&(identical(other.copiedByViewer, copiedByViewer) || other.copiedByViewer == copiedByViewer)&&const DeepCollectionEquality().equals(other.places, _places));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,title,visibility,ownerDisplayName,coverImageUrl,placeCount,averageRating,ratingCount,viewerRating,copiedByViewer,const DeepCollectionEquality().hash(_places));
}

@override
String toString() {
    return 'PlaceCollectionDetail(id: $id, title: $title, visibility: $visibility, ownerDisplayName: $ownerDisplayName, coverImageUrl: $coverImageUrl, placeCount: $placeCount, averageRating: $averageRating, ratingCount: $ratingCount, viewerRating: $viewerRating, copiedByViewer: $copiedByViewer, places: $places)';
}


}

/// @nodoc
abstract mixin class _$PlaceCollectionDetailCopyWith<$Res> implements $PlaceCollectionDetailCopyWith<$Res> {
  factory _$PlaceCollectionDetailCopyWith(_PlaceCollectionDetail value, $Res Function(_PlaceCollectionDetail) _then) = __$PlaceCollectionDetailCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String visibility, String ownerDisplayName, String? coverImageUrl,@JsonKey(fromJson: _readInt) int placeCount,@JsonKey(fromJson: _readDoubleOrNull) double? averageRating,@JsonKey(fromJson: _readInt) int ratingCount,@JsonKey(fromJson: _readIntNullable) int? viewerRating, bool copiedByViewer, List<CollectionPlaceItem> places
});




}
/// @nodoc
class __$PlaceCollectionDetailCopyWithImpl<$Res>
    implements _$PlaceCollectionDetailCopyWith<$Res> {
  __$PlaceCollectionDetailCopyWithImpl(this._self, this._then);

  final _PlaceCollectionDetail _self;
  final $Res Function(_PlaceCollectionDetail) _then;

/// Create a copy of PlaceCollectionDetail
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? visibility = null,Object? ownerDisplayName = null,Object? coverImageUrl = freezed,Object? placeCount = null,Object? averageRating = freezed,Object? ratingCount = null,Object? viewerRating = freezed,Object? copiedByViewer = null,Object? places = null,}) {
  return _then(_PlaceCollectionDetail(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,visibility: null == visibility ? _self.visibility : visibility // ignore: cast_nullable_to_non_nullable
as String,ownerDisplayName: null == ownerDisplayName ? _self.ownerDisplayName : ownerDisplayName // ignore: cast_nullable_to_non_nullable
as String,coverImageUrl: freezed == coverImageUrl ? _self.coverImageUrl : coverImageUrl // ignore: cast_nullable_to_non_nullable
as String?,placeCount: null == placeCount ? _self.placeCount : placeCount // ignore: cast_nullable_to_non_nullable
as int,averageRating: freezed == averageRating ? _self.averageRating : averageRating // ignore: cast_nullable_to_non_nullable
as double?,ratingCount: null == ratingCount ? _self.ratingCount : ratingCount // ignore: cast_nullable_to_non_nullable
as int,viewerRating: freezed == viewerRating ? _self.viewerRating : viewerRating // ignore: cast_nullable_to_non_nullable
as int?,copiedByViewer: null == copiedByViewer ? _self.copiedByViewer : copiedByViewer // ignore: cast_nullable_to_non_nullable
as bool,places: null == places ? _self._places : places // ignore: cast_nullable_to_non_nullable
as List<CollectionPlaceItem>,
  ));
}


}


/// @nodoc
mixin _$PlaceEmbeddingSearchApi {

 String get id; String get name; String? get description;@JsonKey(fromJson: _readDouble) double get latitude;@JsonKey(fromJson: _readDouble) double get longitude;@JsonKey(fromJson: _readDouble) double get similarity;@JsonKey(name: 'distance_km', fromJson: _readDoubleOrNull) double? get distanceKm; String? get category; String? get address;@JsonKey(fromJson: _readDoubleOrNull) double? get averageRating;@JsonKey(fromJson: _readIntNullable) int? get reviewCount; String? get thumbnailUrl;@JsonKey(fromJson: _readInt) int get saveCount; bool get bookmarked;
/// Create a copy of PlaceEmbeddingSearchApi
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlaceEmbeddingSearchApiCopyWith<PlaceEmbeddingSearchApi> get copyWith => _$PlaceEmbeddingSearchApiCopyWithImpl<PlaceEmbeddingSearchApi>(this as PlaceEmbeddingSearchApi, _$identity);

  /// Serializes this PlaceEmbeddingSearchApi to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as PlaceEmbeddingSearchApi;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlaceEmbeddingSearchApi&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.latitude, _this.latitude) || other.latitude == _this.latitude)&&(identical(other.longitude, _this.longitude) || other.longitude == _this.longitude)&&(identical(other.similarity, _this.similarity) || other.similarity == _this.similarity)&&(identical(other.distanceKm, _this.distanceKm) || other.distanceKm == _this.distanceKm)&&(identical(other.category, _this.category) || other.category == _this.category)&&(identical(other.address, _this.address) || other.address == _this.address)&&(identical(other.averageRating, _this.averageRating) || other.averageRating == _this.averageRating)&&(identical(other.reviewCount, _this.reviewCount) || other.reviewCount == _this.reviewCount)&&(identical(other.thumbnailUrl, _this.thumbnailUrl) || other.thumbnailUrl == _this.thumbnailUrl)&&(identical(other.saveCount, _this.saveCount) || other.saveCount == _this.saveCount)&&(identical(other.bookmarked, _this.bookmarked) || other.bookmarked == _this.bookmarked));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as PlaceEmbeddingSearchApi;
  return Object.hash(runtimeType,_this.id,_this.name,_this.description,_this.latitude,_this.longitude,_this.similarity,_this.distanceKm,_this.category,_this.address,_this.averageRating,_this.reviewCount,_this.thumbnailUrl,_this.saveCount,_this.bookmarked);
}

@override
String toString() {
  final _this = this as PlaceEmbeddingSearchApi;
  return 'PlaceEmbeddingSearchApi(id: ${_this.id}, name: ${_this.name}, description: ${_this.description}, latitude: ${_this.latitude}, longitude: ${_this.longitude}, similarity: ${_this.similarity}, distanceKm: ${_this.distanceKm}, category: ${_this.category}, address: ${_this.address}, averageRating: ${_this.averageRating}, reviewCount: ${_this.reviewCount}, thumbnailUrl: ${_this.thumbnailUrl}, saveCount: ${_this.saveCount}, bookmarked: ${_this.bookmarked})';
}


}

/// @nodoc
abstract mixin class $PlaceEmbeddingSearchApiCopyWith<$Res>  {
  factory $PlaceEmbeddingSearchApiCopyWith(PlaceEmbeddingSearchApi value, $Res Function(PlaceEmbeddingSearchApi) _then) = _$PlaceEmbeddingSearchApiCopyWithImpl;
@useResult
$Res call({
 String id, String name, String? description,@JsonKey(fromJson: _readDouble) double latitude,@JsonKey(fromJson: _readDouble) double longitude,@JsonKey(fromJson: _readDouble) double similarity,@JsonKey(name: 'distance_km', fromJson: _readDoubleOrNull) double? distanceKm, String? category, String? address,@JsonKey(fromJson: _readDoubleOrNull) double? averageRating,@JsonKey(fromJson: _readIntNullable) int? reviewCount, String? thumbnailUrl,@JsonKey(fromJson: _readInt) int saveCount, bool bookmarked
});




}
/// @nodoc
class _$PlaceEmbeddingSearchApiCopyWithImpl<$Res>
    implements $PlaceEmbeddingSearchApiCopyWith<$Res> {
  _$PlaceEmbeddingSearchApiCopyWithImpl(this._self, this._then);

  final PlaceEmbeddingSearchApi _self;
  final $Res Function(PlaceEmbeddingSearchApi) _then;

/// Create a copy of PlaceEmbeddingSearchApi
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? description = freezed,Object? latitude = null,Object? longitude = null,Object? similarity = null,Object? distanceKm = freezed,Object? category = freezed,Object? address = freezed,Object? averageRating = freezed,Object? reviewCount = freezed,Object? thumbnailUrl = freezed,Object? saveCount = null,Object? bookmarked = null,}) {
  return _then(PlaceEmbeddingSearchApi(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,similarity: null == similarity ? _self.similarity : similarity // ignore: cast_nullable_to_non_nullable
as double,distanceKm: freezed == distanceKm ? _self.distanceKm : distanceKm // ignore: cast_nullable_to_non_nullable
as double?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,averageRating: freezed == averageRating ? _self.averageRating : averageRating // ignore: cast_nullable_to_non_nullable
as double?,reviewCount: freezed == reviewCount ? _self.reviewCount : reviewCount // ignore: cast_nullable_to_non_nullable
as int?,thumbnailUrl: freezed == thumbnailUrl ? _self.thumbnailUrl : thumbnailUrl // ignore: cast_nullable_to_non_nullable
as String?,saveCount: null == saveCount ? _self.saveCount : saveCount // ignore: cast_nullable_to_non_nullable
as int,bookmarked: null == bookmarked ? _self.bookmarked : bookmarked // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [PlaceEmbeddingSearchApi].
extension PlaceEmbeddingSearchApiPatterns on PlaceEmbeddingSearchApi {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlaceEmbeddingSearchApi value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlaceEmbeddingSearchApi() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlaceEmbeddingSearchApi value)  $default,){
final _that = this;
switch (_that) {
case _PlaceEmbeddingSearchApi():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlaceEmbeddingSearchApi value)?  $default,){
final _that = this;
switch (_that) {
case _PlaceEmbeddingSearchApi() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String? description, @JsonKey(fromJson: _readDouble)  double latitude, @JsonKey(fromJson: _readDouble)  double longitude, @JsonKey(fromJson: _readDouble)  double similarity, @JsonKey(name: 'distance_km', fromJson: _readDoubleOrNull)  double? distanceKm,  String? category,  String? address, @JsonKey(fromJson: _readDoubleOrNull)  double? averageRating, @JsonKey(fromJson: _readIntNullable)  int? reviewCount,  String? thumbnailUrl, @JsonKey(fromJson: _readInt)  int saveCount,  bool bookmarked)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlaceEmbeddingSearchApi() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.latitude,_that.longitude,_that.similarity,_that.distanceKm,_that.category,_that.address,_that.averageRating,_that.reviewCount,_that.thumbnailUrl,_that.saveCount,_that.bookmarked);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String? description, @JsonKey(fromJson: _readDouble)  double latitude, @JsonKey(fromJson: _readDouble)  double longitude, @JsonKey(fromJson: _readDouble)  double similarity, @JsonKey(name: 'distance_km', fromJson: _readDoubleOrNull)  double? distanceKm,  String? category,  String? address, @JsonKey(fromJson: _readDoubleOrNull)  double? averageRating, @JsonKey(fromJson: _readIntNullable)  int? reviewCount,  String? thumbnailUrl, @JsonKey(fromJson: _readInt)  int saveCount,  bool bookmarked)  $default,) {final _that = this;
switch (_that) {
case _PlaceEmbeddingSearchApi():
return $default(_that.id,_that.name,_that.description,_that.latitude,_that.longitude,_that.similarity,_that.distanceKm,_that.category,_that.address,_that.averageRating,_that.reviewCount,_that.thumbnailUrl,_that.saveCount,_that.bookmarked);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String? description, @JsonKey(fromJson: _readDouble)  double latitude, @JsonKey(fromJson: _readDouble)  double longitude, @JsonKey(fromJson: _readDouble)  double similarity, @JsonKey(name: 'distance_km', fromJson: _readDoubleOrNull)  double? distanceKm,  String? category,  String? address, @JsonKey(fromJson: _readDoubleOrNull)  double? averageRating, @JsonKey(fromJson: _readIntNullable)  int? reviewCount,  String? thumbnailUrl, @JsonKey(fromJson: _readInt)  int saveCount,  bool bookmarked)?  $default,) {final _that = this;
switch (_that) {
case _PlaceEmbeddingSearchApi() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.latitude,_that.longitude,_that.similarity,_that.distanceKm,_that.category,_that.address,_that.averageRating,_that.reviewCount,_that.thumbnailUrl,_that.saveCount,_that.bookmarked);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PlaceEmbeddingSearchApi implements PlaceEmbeddingSearchApi {
  const _PlaceEmbeddingSearchApi({required this.id, required this.name, this.description, @JsonKey(fromJson: _readDouble) required this.latitude, @JsonKey(fromJson: _readDouble) required this.longitude, @JsonKey(fromJson: _readDouble) required this.similarity, @JsonKey(name: 'distance_km', fromJson: _readDoubleOrNull) this.distanceKm, this.category, this.address, @JsonKey(fromJson: _readDoubleOrNull) this.averageRating, @JsonKey(fromJson: _readIntNullable) this.reviewCount, this.thumbnailUrl, @JsonKey(fromJson: _readInt) required this.saveCount, this.bookmarked = false});
  factory _PlaceEmbeddingSearchApi.fromJson(Map<String, dynamic> json) => _$PlaceEmbeddingSearchApiFromJson(json);

@override final  String id;
@override final  String name;
@override final  String? description;
@override@JsonKey(fromJson: _readDouble) final  double latitude;
@override@JsonKey(fromJson: _readDouble) final  double longitude;
@override@JsonKey(fromJson: _readDouble) final  double similarity;
@override@JsonKey(name: 'distance_km', fromJson: _readDoubleOrNull) final  double? distanceKm;
@override final  String? category;
@override final  String? address;
@override@JsonKey(fromJson: _readDoubleOrNull) final  double? averageRating;
@override@JsonKey(fromJson: _readIntNullable) final  int? reviewCount;
@override final  String? thumbnailUrl;
@override@JsonKey(fromJson: _readInt) final  int saveCount;
@override@JsonKey() final  bool bookmarked;

/// Create a copy of PlaceEmbeddingSearchApi
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlaceEmbeddingSearchApiCopyWith<_PlaceEmbeddingSearchApi> get copyWith => __$PlaceEmbeddingSearchApiCopyWithImpl<_PlaceEmbeddingSearchApi>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlaceEmbeddingSearchApiToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlaceEmbeddingSearchApi&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.similarity, similarity) || other.similarity == similarity)&&(identical(other.distanceKm, distanceKm) || other.distanceKm == distanceKm)&&(identical(other.category, category) || other.category == category)&&(identical(other.address, address) || other.address == address)&&(identical(other.averageRating, averageRating) || other.averageRating == averageRating)&&(identical(other.reviewCount, reviewCount) || other.reviewCount == reviewCount)&&(identical(other.thumbnailUrl, thumbnailUrl) || other.thumbnailUrl == thumbnailUrl)&&(identical(other.saveCount, saveCount) || other.saveCount == saveCount)&&(identical(other.bookmarked, bookmarked) || other.bookmarked == bookmarked));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,name,description,latitude,longitude,similarity,distanceKm,category,address,averageRating,reviewCount,thumbnailUrl,saveCount,bookmarked);
}

@override
String toString() {
    return 'PlaceEmbeddingSearchApi(id: $id, name: $name, description: $description, latitude: $latitude, longitude: $longitude, similarity: $similarity, distanceKm: $distanceKm, category: $category, address: $address, averageRating: $averageRating, reviewCount: $reviewCount, thumbnailUrl: $thumbnailUrl, saveCount: $saveCount, bookmarked: $bookmarked)';
}


}

/// @nodoc
abstract mixin class _$PlaceEmbeddingSearchApiCopyWith<$Res> implements $PlaceEmbeddingSearchApiCopyWith<$Res> {
  factory _$PlaceEmbeddingSearchApiCopyWith(_PlaceEmbeddingSearchApi value, $Res Function(_PlaceEmbeddingSearchApi) _then) = __$PlaceEmbeddingSearchApiCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String? description,@JsonKey(fromJson: _readDouble) double latitude,@JsonKey(fromJson: _readDouble) double longitude,@JsonKey(fromJson: _readDouble) double similarity,@JsonKey(name: 'distance_km', fromJson: _readDoubleOrNull) double? distanceKm, String? category, String? address,@JsonKey(fromJson: _readDoubleOrNull) double? averageRating,@JsonKey(fromJson: _readIntNullable) int? reviewCount, String? thumbnailUrl,@JsonKey(fromJson: _readInt) int saveCount, bool bookmarked
});




}
/// @nodoc
class __$PlaceEmbeddingSearchApiCopyWithImpl<$Res>
    implements _$PlaceEmbeddingSearchApiCopyWith<$Res> {
  __$PlaceEmbeddingSearchApiCopyWithImpl(this._self, this._then);

  final _PlaceEmbeddingSearchApi _self;
  final $Res Function(_PlaceEmbeddingSearchApi) _then;

/// Create a copy of PlaceEmbeddingSearchApi
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? description = freezed,Object? latitude = null,Object? longitude = null,Object? similarity = null,Object? distanceKm = freezed,Object? category = freezed,Object? address = freezed,Object? averageRating = freezed,Object? reviewCount = freezed,Object? thumbnailUrl = freezed,Object? saveCount = null,Object? bookmarked = null,}) {
  return _then(_PlaceEmbeddingSearchApi(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,similarity: null == similarity ? _self.similarity : similarity // ignore: cast_nullable_to_non_nullable
as double,distanceKm: freezed == distanceKm ? _self.distanceKm : distanceKm // ignore: cast_nullable_to_non_nullable
as double?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,averageRating: freezed == averageRating ? _self.averageRating : averageRating // ignore: cast_nullable_to_non_nullable
as double?,reviewCount: freezed == reviewCount ? _self.reviewCount : reviewCount // ignore: cast_nullable_to_non_nullable
as int?,thumbnailUrl: freezed == thumbnailUrl ? _self.thumbnailUrl : thumbnailUrl // ignore: cast_nullable_to_non_nullable
as String?,saveCount: null == saveCount ? _self.saveCount : saveCount // ignore: cast_nullable_to_non_nullable
as int,bookmarked: null == bookmarked ? _self.bookmarked : bookmarked // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
