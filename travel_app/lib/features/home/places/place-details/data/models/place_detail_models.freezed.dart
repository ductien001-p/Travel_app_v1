// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'place_detail_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PlaceDetailApi {

 String get id; String get name; String? get description; String get city; String get country; String get address;@JsonKey(fromJson: _readDouble) double get latitude;@JsonKey(fromJson: _readDouble) double get longitude; String get category; String get status;@JsonKey(fromJson: _readDouble) double get averageRating; List<String> get coverImageUrls;
/// Create a copy of PlaceDetailApi
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlaceDetailApiCopyWith<PlaceDetailApi> get copyWith => _$PlaceDetailApiCopyWithImpl<PlaceDetailApi>(this as PlaceDetailApi, _$identity);

  /// Serializes this PlaceDetailApi to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as PlaceDetailApi;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlaceDetailApi&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.city, _this.city) || other.city == _this.city)&&(identical(other.country, _this.country) || other.country == _this.country)&&(identical(other.address, _this.address) || other.address == _this.address)&&(identical(other.latitude, _this.latitude) || other.latitude == _this.latitude)&&(identical(other.longitude, _this.longitude) || other.longitude == _this.longitude)&&(identical(other.category, _this.category) || other.category == _this.category)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.averageRating, _this.averageRating) || other.averageRating == _this.averageRating)&&const DeepCollectionEquality().equals(other.coverImageUrls, _this.coverImageUrls));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as PlaceDetailApi;
  return Object.hash(runtimeType,_this.id,_this.name,_this.description,_this.city,_this.country,_this.address,_this.latitude,_this.longitude,_this.category,_this.status,_this.averageRating,const DeepCollectionEquality().hash(_this.coverImageUrls));
}

@override
String toString() {
  final _this = this as PlaceDetailApi;
  return 'PlaceDetailApi(id: ${_this.id}, name: ${_this.name}, description: ${_this.description}, city: ${_this.city}, country: ${_this.country}, address: ${_this.address}, latitude: ${_this.latitude}, longitude: ${_this.longitude}, category: ${_this.category}, status: ${_this.status}, averageRating: ${_this.averageRating}, coverImageUrls: ${_this.coverImageUrls})';
}


}

/// @nodoc
abstract mixin class $PlaceDetailApiCopyWith<$Res>  {
  factory $PlaceDetailApiCopyWith(PlaceDetailApi value, $Res Function(PlaceDetailApi) _then) = _$PlaceDetailApiCopyWithImpl;
@useResult
$Res call({
 String id, String name, String? description, String city, String country, String address,@JsonKey(fromJson: _readDouble) double latitude,@JsonKey(fromJson: _readDouble) double longitude, String category, String status,@JsonKey(fromJson: _readDouble) double averageRating, List<String> coverImageUrls
});




}
/// @nodoc
class _$PlaceDetailApiCopyWithImpl<$Res>
    implements $PlaceDetailApiCopyWith<$Res> {
  _$PlaceDetailApiCopyWithImpl(this._self, this._then);

  final PlaceDetailApi _self;
  final $Res Function(PlaceDetailApi) _then;

/// Create a copy of PlaceDetailApi
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? description = freezed,Object? city = null,Object? country = null,Object? address = null,Object? latitude = null,Object? longitude = null,Object? category = null,Object? status = null,Object? averageRating = null,Object? coverImageUrls = null,}) {
  return _then(PlaceDetailApi(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,country: null == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,averageRating: null == averageRating ? _self.averageRating : averageRating // ignore: cast_nullable_to_non_nullable
as double,coverImageUrls: null == coverImageUrls ? _self.coverImageUrls : coverImageUrls // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [PlaceDetailApi].
extension PlaceDetailApiPatterns on PlaceDetailApi {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlaceDetailApi value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlaceDetailApi() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlaceDetailApi value)  $default,){
final _that = this;
switch (_that) {
case _PlaceDetailApi():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlaceDetailApi value)?  $default,){
final _that = this;
switch (_that) {
case _PlaceDetailApi() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String? description,  String city,  String country,  String address, @JsonKey(fromJson: _readDouble)  double latitude, @JsonKey(fromJson: _readDouble)  double longitude,  String category,  String status, @JsonKey(fromJson: _readDouble)  double averageRating,  List<String> coverImageUrls)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlaceDetailApi() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.city,_that.country,_that.address,_that.latitude,_that.longitude,_that.category,_that.status,_that.averageRating,_that.coverImageUrls);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String? description,  String city,  String country,  String address, @JsonKey(fromJson: _readDouble)  double latitude, @JsonKey(fromJson: _readDouble)  double longitude,  String category,  String status, @JsonKey(fromJson: _readDouble)  double averageRating,  List<String> coverImageUrls)  $default,) {final _that = this;
switch (_that) {
case _PlaceDetailApi():
return $default(_that.id,_that.name,_that.description,_that.city,_that.country,_that.address,_that.latitude,_that.longitude,_that.category,_that.status,_that.averageRating,_that.coverImageUrls);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String? description,  String city,  String country,  String address, @JsonKey(fromJson: _readDouble)  double latitude, @JsonKey(fromJson: _readDouble)  double longitude,  String category,  String status, @JsonKey(fromJson: _readDouble)  double averageRating,  List<String> coverImageUrls)?  $default,) {final _that = this;
switch (_that) {
case _PlaceDetailApi() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.city,_that.country,_that.address,_that.latitude,_that.longitude,_that.category,_that.status,_that.averageRating,_that.coverImageUrls);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PlaceDetailApi implements PlaceDetailApi {
  const _PlaceDetailApi({required this.id, required this.name, this.description, required this.city, required this.country, required this.address, @JsonKey(fromJson: _readDouble) required this.latitude, @JsonKey(fromJson: _readDouble) required this.longitude, required this.category, required this.status, @JsonKey(fromJson: _readDouble) required this.averageRating,  List<String> coverImageUrls = const <String>[]}): _coverImageUrls = coverImageUrls;
  factory _PlaceDetailApi.fromJson(Map<String, dynamic> json) => _$PlaceDetailApiFromJson(json);

@override final  String id;
@override final  String name;
@override final  String? description;
@override final  String city;
@override final  String country;
@override final  String address;
@override@JsonKey(fromJson: _readDouble) final  double latitude;
@override@JsonKey(fromJson: _readDouble) final  double longitude;
@override final  String category;
@override final  String status;
@override@JsonKey(fromJson: _readDouble) final  double averageRating;
 final  List<String> _coverImageUrls;
@override@JsonKey() List<String> get coverImageUrls {
  if (_coverImageUrls is EqualUnmodifiableListView) return _coverImageUrls;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_coverImageUrls);
}


/// Create a copy of PlaceDetailApi
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlaceDetailApiCopyWith<_PlaceDetailApi> get copyWith => __$PlaceDetailApiCopyWithImpl<_PlaceDetailApi>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlaceDetailApiToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlaceDetailApi&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.city, city) || other.city == city)&&(identical(other.country, country) || other.country == country)&&(identical(other.address, address) || other.address == address)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.category, category) || other.category == category)&&(identical(other.status, status) || other.status == status)&&(identical(other.averageRating, averageRating) || other.averageRating == averageRating)&&const DeepCollectionEquality().equals(other.coverImageUrls, _coverImageUrls));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,name,description,city,country,address,latitude,longitude,category,status,averageRating,const DeepCollectionEquality().hash(_coverImageUrls));
}

@override
String toString() {
    return 'PlaceDetailApi(id: $id, name: $name, description: $description, city: $city, country: $country, address: $address, latitude: $latitude, longitude: $longitude, category: $category, status: $status, averageRating: $averageRating, coverImageUrls: $coverImageUrls)';
}


}

/// @nodoc
abstract mixin class _$PlaceDetailApiCopyWith<$Res> implements $PlaceDetailApiCopyWith<$Res> {
  factory _$PlaceDetailApiCopyWith(_PlaceDetailApi value, $Res Function(_PlaceDetailApi) _then) = __$PlaceDetailApiCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String? description, String city, String country, String address,@JsonKey(fromJson: _readDouble) double latitude,@JsonKey(fromJson: _readDouble) double longitude, String category, String status,@JsonKey(fromJson: _readDouble) double averageRating, List<String> coverImageUrls
});




}
/// @nodoc
class __$PlaceDetailApiCopyWithImpl<$Res>
    implements _$PlaceDetailApiCopyWith<$Res> {
  __$PlaceDetailApiCopyWithImpl(this._self, this._then);

  final _PlaceDetailApi _self;
  final $Res Function(_PlaceDetailApi) _then;

/// Create a copy of PlaceDetailApi
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? description = freezed,Object? city = null,Object? country = null,Object? address = null,Object? latitude = null,Object? longitude = null,Object? category = null,Object? status = null,Object? averageRating = null,Object? coverImageUrls = null,}) {
  return _then(_PlaceDetailApi(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,country: null == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,averageRating: null == averageRating ? _self.averageRating : averageRating // ignore: cast_nullable_to_non_nullable
as double,coverImageUrls: null == coverImageUrls ? _self._coverImageUrls : coverImageUrls // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}


/// @nodoc
mixin _$PlacePageMeta {

@JsonKey(fromJson: _readInt) int get page;@JsonKey(fromJson: _readInt) int get limit;@JsonKey(fromJson: _readInt) int get total;@JsonKey(fromJson: _readInt) int get totalPages; bool get hasNextPage; bool get hasPreviousPage;
/// Create a copy of PlacePageMeta
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlacePageMetaCopyWith<PlacePageMeta> get copyWith => _$PlacePageMetaCopyWithImpl<PlacePageMeta>(this as PlacePageMeta, _$identity);

  /// Serializes this PlacePageMeta to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as PlacePageMeta;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlacePageMeta&&(identical(other.page, _this.page) || other.page == _this.page)&&(identical(other.limit, _this.limit) || other.limit == _this.limit)&&(identical(other.total, _this.total) || other.total == _this.total)&&(identical(other.totalPages, _this.totalPages) || other.totalPages == _this.totalPages)&&(identical(other.hasNextPage, _this.hasNextPage) || other.hasNextPage == _this.hasNextPage)&&(identical(other.hasPreviousPage, _this.hasPreviousPage) || other.hasPreviousPage == _this.hasPreviousPage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as PlacePageMeta;
  return Object.hash(runtimeType,_this.page,_this.limit,_this.total,_this.totalPages,_this.hasNextPage,_this.hasPreviousPage);
}

@override
String toString() {
  final _this = this as PlacePageMeta;
  return 'PlacePageMeta(page: ${_this.page}, limit: ${_this.limit}, total: ${_this.total}, totalPages: ${_this.totalPages}, hasNextPage: ${_this.hasNextPage}, hasPreviousPage: ${_this.hasPreviousPage})';
}


}

/// @nodoc
abstract mixin class $PlacePageMetaCopyWith<$Res>  {
  factory $PlacePageMetaCopyWith(PlacePageMeta value, $Res Function(PlacePageMeta) _then) = _$PlacePageMetaCopyWithImpl;
@useResult
$Res call({
@JsonKey(fromJson: _readInt) int page,@JsonKey(fromJson: _readInt) int limit,@JsonKey(fromJson: _readInt) int total,@JsonKey(fromJson: _readInt) int totalPages, bool hasNextPage, bool hasPreviousPage
});




}
/// @nodoc
class _$PlacePageMetaCopyWithImpl<$Res>
    implements $PlacePageMetaCopyWith<$Res> {
  _$PlacePageMetaCopyWithImpl(this._self, this._then);

  final PlacePageMeta _self;
  final $Res Function(PlacePageMeta) _then;

/// Create a copy of PlacePageMeta
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? page = null,Object? limit = null,Object? total = null,Object? totalPages = null,Object? hasNextPage = null,Object? hasPreviousPage = null,}) {
  return _then(PlacePageMeta(
page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,limit: null == limit ? _self.limit : limit // ignore: cast_nullable_to_non_nullable
as int,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,totalPages: null == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as int,hasNextPage: null == hasNextPage ? _self.hasNextPage : hasNextPage // ignore: cast_nullable_to_non_nullable
as bool,hasPreviousPage: null == hasPreviousPage ? _self.hasPreviousPage : hasPreviousPage // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [PlacePageMeta].
extension PlacePageMetaPatterns on PlacePageMeta {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlacePageMeta value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlacePageMeta() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlacePageMeta value)  $default,){
final _that = this;
switch (_that) {
case _PlacePageMeta():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlacePageMeta value)?  $default,){
final _that = this;
switch (_that) {
case _PlacePageMeta() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(fromJson: _readInt)  int page, @JsonKey(fromJson: _readInt)  int limit, @JsonKey(fromJson: _readInt)  int total, @JsonKey(fromJson: _readInt)  int totalPages,  bool hasNextPage,  bool hasPreviousPage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlacePageMeta() when $default != null:
return $default(_that.page,_that.limit,_that.total,_that.totalPages,_that.hasNextPage,_that.hasPreviousPage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(fromJson: _readInt)  int page, @JsonKey(fromJson: _readInt)  int limit, @JsonKey(fromJson: _readInt)  int total, @JsonKey(fromJson: _readInt)  int totalPages,  bool hasNextPage,  bool hasPreviousPage)  $default,) {final _that = this;
switch (_that) {
case _PlacePageMeta():
return $default(_that.page,_that.limit,_that.total,_that.totalPages,_that.hasNextPage,_that.hasPreviousPage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(fromJson: _readInt)  int page, @JsonKey(fromJson: _readInt)  int limit, @JsonKey(fromJson: _readInt)  int total, @JsonKey(fromJson: _readInt)  int totalPages,  bool hasNextPage,  bool hasPreviousPage)?  $default,) {final _that = this;
switch (_that) {
case _PlacePageMeta() when $default != null:
return $default(_that.page,_that.limit,_that.total,_that.totalPages,_that.hasNextPage,_that.hasPreviousPage);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PlacePageMeta implements PlacePageMeta {
  const _PlacePageMeta({@JsonKey(fromJson: _readInt) required this.page, @JsonKey(fromJson: _readInt) required this.limit, @JsonKey(fromJson: _readInt) required this.total, @JsonKey(fromJson: _readInt) required this.totalPages, required this.hasNextPage, required this.hasPreviousPage});
  factory _PlacePageMeta.fromJson(Map<String, dynamic> json) => _$PlacePageMetaFromJson(json);

@override@JsonKey(fromJson: _readInt) final  int page;
@override@JsonKey(fromJson: _readInt) final  int limit;
@override@JsonKey(fromJson: _readInt) final  int total;
@override@JsonKey(fromJson: _readInt) final  int totalPages;
@override final  bool hasNextPage;
@override final  bool hasPreviousPage;

/// Create a copy of PlacePageMeta
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlacePageMetaCopyWith<_PlacePageMeta> get copyWith => __$PlacePageMetaCopyWithImpl<_PlacePageMeta>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlacePageMetaToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlacePageMeta&&(identical(other.page, page) || other.page == page)&&(identical(other.limit, limit) || other.limit == limit)&&(identical(other.total, total) || other.total == total)&&(identical(other.totalPages, totalPages) || other.totalPages == totalPages)&&(identical(other.hasNextPage, hasNextPage) || other.hasNextPage == hasNextPage)&&(identical(other.hasPreviousPage, hasPreviousPage) || other.hasPreviousPage == hasPreviousPage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,page,limit,total,totalPages,hasNextPage,hasPreviousPage);
}

@override
String toString() {
    return 'PlacePageMeta(page: $page, limit: $limit, total: $total, totalPages: $totalPages, hasNextPage: $hasNextPage, hasPreviousPage: $hasPreviousPage)';
}


}

/// @nodoc
abstract mixin class _$PlacePageMetaCopyWith<$Res> implements $PlacePageMetaCopyWith<$Res> {
  factory _$PlacePageMetaCopyWith(_PlacePageMeta value, $Res Function(_PlacePageMeta) _then) = __$PlacePageMetaCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(fromJson: _readInt) int page,@JsonKey(fromJson: _readInt) int limit,@JsonKey(fromJson: _readInt) int total,@JsonKey(fromJson: _readInt) int totalPages, bool hasNextPage, bool hasPreviousPage
});




}
/// @nodoc
class __$PlacePageMetaCopyWithImpl<$Res>
    implements _$PlacePageMetaCopyWith<$Res> {
  __$PlacePageMetaCopyWithImpl(this._self, this._then);

  final _PlacePageMeta _self;
  final $Res Function(_PlacePageMeta) _then;

/// Create a copy of PlacePageMeta
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? page = null,Object? limit = null,Object? total = null,Object? totalPages = null,Object? hasNextPage = null,Object? hasPreviousPage = null,}) {
  return _then(_PlacePageMeta(
page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,limit: null == limit ? _self.limit : limit // ignore: cast_nullable_to_non_nullable
as int,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,totalPages: null == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as int,hasNextPage: null == hasNextPage ? _self.hasNextPage : hasNextPage // ignore: cast_nullable_to_non_nullable
as bool,hasPreviousPage: null == hasPreviousPage ? _self.hasPreviousPage : hasPreviousPage // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$PlaceRatingDistribution {

@JsonKey(name: '1', fromJson: _readInt) int get one;@JsonKey(name: '2', fromJson: _readInt) int get two;@JsonKey(name: '3', fromJson: _readInt) int get three;@JsonKey(name: '4', fromJson: _readInt) int get four;@JsonKey(name: '5', fromJson: _readInt) int get five;
/// Create a copy of PlaceRatingDistribution
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlaceRatingDistributionCopyWith<PlaceRatingDistribution> get copyWith => _$PlaceRatingDistributionCopyWithImpl<PlaceRatingDistribution>(this as PlaceRatingDistribution, _$identity);

  /// Serializes this PlaceRatingDistribution to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as PlaceRatingDistribution;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlaceRatingDistribution&&(identical(other.one, _this.one) || other.one == _this.one)&&(identical(other.two, _this.two) || other.two == _this.two)&&(identical(other.three, _this.three) || other.three == _this.three)&&(identical(other.four, _this.four) || other.four == _this.four)&&(identical(other.five, _this.five) || other.five == _this.five));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as PlaceRatingDistribution;
  return Object.hash(runtimeType,_this.one,_this.two,_this.three,_this.four,_this.five);
}

@override
String toString() {
  final _this = this as PlaceRatingDistribution;
  return 'PlaceRatingDistribution(one: ${_this.one}, two: ${_this.two}, three: ${_this.three}, four: ${_this.four}, five: ${_this.five})';
}


}

/// @nodoc
abstract mixin class $PlaceRatingDistributionCopyWith<$Res>  {
  factory $PlaceRatingDistributionCopyWith(PlaceRatingDistribution value, $Res Function(PlaceRatingDistribution) _then) = _$PlaceRatingDistributionCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: '1', fromJson: _readInt) int one,@JsonKey(name: '2', fromJson: _readInt) int two,@JsonKey(name: '3', fromJson: _readInt) int three,@JsonKey(name: '4', fromJson: _readInt) int four,@JsonKey(name: '5', fromJson: _readInt) int five
});




}
/// @nodoc
class _$PlaceRatingDistributionCopyWithImpl<$Res>
    implements $PlaceRatingDistributionCopyWith<$Res> {
  _$PlaceRatingDistributionCopyWithImpl(this._self, this._then);

  final PlaceRatingDistribution _self;
  final $Res Function(PlaceRatingDistribution) _then;

/// Create a copy of PlaceRatingDistribution
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? one = null,Object? two = null,Object? three = null,Object? four = null,Object? five = null,}) {
  return _then(PlaceRatingDistribution(
one: null == one ? _self.one : one // ignore: cast_nullable_to_non_nullable
as int,two: null == two ? _self.two : two // ignore: cast_nullable_to_non_nullable
as int,three: null == three ? _self.three : three // ignore: cast_nullable_to_non_nullable
as int,four: null == four ? _self.four : four // ignore: cast_nullable_to_non_nullable
as int,five: null == five ? _self.five : five // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [PlaceRatingDistribution].
extension PlaceRatingDistributionPatterns on PlaceRatingDistribution {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlaceRatingDistribution value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlaceRatingDistribution() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlaceRatingDistribution value)  $default,){
final _that = this;
switch (_that) {
case _PlaceRatingDistribution():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlaceRatingDistribution value)?  $default,){
final _that = this;
switch (_that) {
case _PlaceRatingDistribution() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: '1', fromJson: _readInt)  int one, @JsonKey(name: '2', fromJson: _readInt)  int two, @JsonKey(name: '3', fromJson: _readInt)  int three, @JsonKey(name: '4', fromJson: _readInt)  int four, @JsonKey(name: '5', fromJson: _readInt)  int five)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlaceRatingDistribution() when $default != null:
return $default(_that.one,_that.two,_that.three,_that.four,_that.five);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: '1', fromJson: _readInt)  int one, @JsonKey(name: '2', fromJson: _readInt)  int two, @JsonKey(name: '3', fromJson: _readInt)  int three, @JsonKey(name: '4', fromJson: _readInt)  int four, @JsonKey(name: '5', fromJson: _readInt)  int five)  $default,) {final _that = this;
switch (_that) {
case _PlaceRatingDistribution():
return $default(_that.one,_that.two,_that.three,_that.four,_that.five);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: '1', fromJson: _readInt)  int one, @JsonKey(name: '2', fromJson: _readInt)  int two, @JsonKey(name: '3', fromJson: _readInt)  int three, @JsonKey(name: '4', fromJson: _readInt)  int four, @JsonKey(name: '5', fromJson: _readInt)  int five)?  $default,) {final _that = this;
switch (_that) {
case _PlaceRatingDistribution() when $default != null:
return $default(_that.one,_that.two,_that.three,_that.four,_that.five);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PlaceRatingDistribution implements PlaceRatingDistribution {
  const _PlaceRatingDistribution({@JsonKey(name: '1', fromJson: _readInt) required this.one, @JsonKey(name: '2', fromJson: _readInt) required this.two, @JsonKey(name: '3', fromJson: _readInt) required this.three, @JsonKey(name: '4', fromJson: _readInt) required this.four, @JsonKey(name: '5', fromJson: _readInt) required this.five});
  factory _PlaceRatingDistribution.fromJson(Map<String, dynamic> json) => _$PlaceRatingDistributionFromJson(json);

@override@JsonKey(name: '1', fromJson: _readInt) final  int one;
@override@JsonKey(name: '2', fromJson: _readInt) final  int two;
@override@JsonKey(name: '3', fromJson: _readInt) final  int three;
@override@JsonKey(name: '4', fromJson: _readInt) final  int four;
@override@JsonKey(name: '5', fromJson: _readInt) final  int five;

/// Create a copy of PlaceRatingDistribution
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlaceRatingDistributionCopyWith<_PlaceRatingDistribution> get copyWith => __$PlaceRatingDistributionCopyWithImpl<_PlaceRatingDistribution>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlaceRatingDistributionToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlaceRatingDistribution&&(identical(other.one, one) || other.one == one)&&(identical(other.two, two) || other.two == two)&&(identical(other.three, three) || other.three == three)&&(identical(other.four, four) || other.four == four)&&(identical(other.five, five) || other.five == five));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,one,two,three,four,five);
}

@override
String toString() {
    return 'PlaceRatingDistribution(one: $one, two: $two, three: $three, four: $four, five: $five)';
}


}

/// @nodoc
abstract mixin class _$PlaceRatingDistributionCopyWith<$Res> implements $PlaceRatingDistributionCopyWith<$Res> {
  factory _$PlaceRatingDistributionCopyWith(_PlaceRatingDistribution value, $Res Function(_PlaceRatingDistribution) _then) = __$PlaceRatingDistributionCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: '1', fromJson: _readInt) int one,@JsonKey(name: '2', fromJson: _readInt) int two,@JsonKey(name: '3', fromJson: _readInt) int three,@JsonKey(name: '4', fromJson: _readInt) int four,@JsonKey(name: '5', fromJson: _readInt) int five
});




}
/// @nodoc
class __$PlaceRatingDistributionCopyWithImpl<$Res>
    implements _$PlaceRatingDistributionCopyWith<$Res> {
  __$PlaceRatingDistributionCopyWithImpl(this._self, this._then);

  final _PlaceRatingDistribution _self;
  final $Res Function(_PlaceRatingDistribution) _then;

/// Create a copy of PlaceRatingDistribution
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? one = null,Object? two = null,Object? three = null,Object? four = null,Object? five = null,}) {
  return _then(_PlaceRatingDistribution(
one: null == one ? _self.one : one // ignore: cast_nullable_to_non_nullable
as int,two: null == two ? _self.two : two // ignore: cast_nullable_to_non_nullable
as int,three: null == three ? _self.three : three // ignore: cast_nullable_to_non_nullable
as int,four: null == four ? _self.four : four // ignore: cast_nullable_to_non_nullable
as int,five: null == five ? _self.five : five // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$PlaceRatingSummaryApi {

@JsonKey(fromJson: _readDouble) double get averageRating;@JsonKey(fromJson: _readInt) int get totalReviews; PlaceRatingDistribution get distribution;
/// Create a copy of PlaceRatingSummaryApi
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlaceRatingSummaryApiCopyWith<PlaceRatingSummaryApi> get copyWith => _$PlaceRatingSummaryApiCopyWithImpl<PlaceRatingSummaryApi>(this as PlaceRatingSummaryApi, _$identity);

  /// Serializes this PlaceRatingSummaryApi to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as PlaceRatingSummaryApi;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlaceRatingSummaryApi&&(identical(other.averageRating, _this.averageRating) || other.averageRating == _this.averageRating)&&(identical(other.totalReviews, _this.totalReviews) || other.totalReviews == _this.totalReviews)&&(identical(other.distribution, _this.distribution) || other.distribution == _this.distribution));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as PlaceRatingSummaryApi;
  return Object.hash(runtimeType,_this.averageRating,_this.totalReviews,_this.distribution);
}

@override
String toString() {
  final _this = this as PlaceRatingSummaryApi;
  return 'PlaceRatingSummaryApi(averageRating: ${_this.averageRating}, totalReviews: ${_this.totalReviews}, distribution: ${_this.distribution})';
}


}

/// @nodoc
abstract mixin class $PlaceRatingSummaryApiCopyWith<$Res>  {
  factory $PlaceRatingSummaryApiCopyWith(PlaceRatingSummaryApi value, $Res Function(PlaceRatingSummaryApi) _then) = _$PlaceRatingSummaryApiCopyWithImpl;
@useResult
$Res call({
@JsonKey(fromJson: _readDouble) double averageRating,@JsonKey(fromJson: _readInt) int totalReviews, PlaceRatingDistribution distribution
});


$PlaceRatingDistributionCopyWith<$Res> get distribution;

}
/// @nodoc
class _$PlaceRatingSummaryApiCopyWithImpl<$Res>
    implements $PlaceRatingSummaryApiCopyWith<$Res> {
  _$PlaceRatingSummaryApiCopyWithImpl(this._self, this._then);

  final PlaceRatingSummaryApi _self;
  final $Res Function(PlaceRatingSummaryApi) _then;

/// Create a copy of PlaceRatingSummaryApi
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? averageRating = null,Object? totalReviews = null,Object? distribution = null,}) {
  return _then(PlaceRatingSummaryApi(
averageRating: null == averageRating ? _self.averageRating : averageRating // ignore: cast_nullable_to_non_nullable
as double,totalReviews: null == totalReviews ? _self.totalReviews : totalReviews // ignore: cast_nullable_to_non_nullable
as int,distribution: null == distribution ? _self.distribution : distribution // ignore: cast_nullable_to_non_nullable
as PlaceRatingDistribution,
  ));
}
/// Create a copy of PlaceRatingSummaryApi
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlaceRatingDistributionCopyWith<$Res> get distribution {
  
  return $PlaceRatingDistributionCopyWith<$Res>(_self.distribution, (value) {
    return _then(_self.copyWith(distribution: value));
  });
}
}


/// Adds pattern-matching-related methods to [PlaceRatingSummaryApi].
extension PlaceRatingSummaryApiPatterns on PlaceRatingSummaryApi {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlaceRatingSummaryApi value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlaceRatingSummaryApi() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlaceRatingSummaryApi value)  $default,){
final _that = this;
switch (_that) {
case _PlaceRatingSummaryApi():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlaceRatingSummaryApi value)?  $default,){
final _that = this;
switch (_that) {
case _PlaceRatingSummaryApi() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(fromJson: _readDouble)  double averageRating, @JsonKey(fromJson: _readInt)  int totalReviews,  PlaceRatingDistribution distribution)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlaceRatingSummaryApi() when $default != null:
return $default(_that.averageRating,_that.totalReviews,_that.distribution);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(fromJson: _readDouble)  double averageRating, @JsonKey(fromJson: _readInt)  int totalReviews,  PlaceRatingDistribution distribution)  $default,) {final _that = this;
switch (_that) {
case _PlaceRatingSummaryApi():
return $default(_that.averageRating,_that.totalReviews,_that.distribution);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(fromJson: _readDouble)  double averageRating, @JsonKey(fromJson: _readInt)  int totalReviews,  PlaceRatingDistribution distribution)?  $default,) {final _that = this;
switch (_that) {
case _PlaceRatingSummaryApi() when $default != null:
return $default(_that.averageRating,_that.totalReviews,_that.distribution);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PlaceRatingSummaryApi implements PlaceRatingSummaryApi {
  const _PlaceRatingSummaryApi({@JsonKey(fromJson: _readDouble) required this.averageRating, @JsonKey(fromJson: _readInt) required this.totalReviews, required this.distribution});
  factory _PlaceRatingSummaryApi.fromJson(Map<String, dynamic> json) => _$PlaceRatingSummaryApiFromJson(json);

@override@JsonKey(fromJson: _readDouble) final  double averageRating;
@override@JsonKey(fromJson: _readInt) final  int totalReviews;
@override final  PlaceRatingDistribution distribution;

/// Create a copy of PlaceRatingSummaryApi
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlaceRatingSummaryApiCopyWith<_PlaceRatingSummaryApi> get copyWith => __$PlaceRatingSummaryApiCopyWithImpl<_PlaceRatingSummaryApi>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlaceRatingSummaryApiToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlaceRatingSummaryApi&&(identical(other.averageRating, averageRating) || other.averageRating == averageRating)&&(identical(other.totalReviews, totalReviews) || other.totalReviews == totalReviews)&&(identical(other.distribution, distribution) || other.distribution == distribution));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,averageRating,totalReviews,distribution);
}

@override
String toString() {
    return 'PlaceRatingSummaryApi(averageRating: $averageRating, totalReviews: $totalReviews, distribution: $distribution)';
}


}

/// @nodoc
abstract mixin class _$PlaceRatingSummaryApiCopyWith<$Res> implements $PlaceRatingSummaryApiCopyWith<$Res> {
  factory _$PlaceRatingSummaryApiCopyWith(_PlaceRatingSummaryApi value, $Res Function(_PlaceRatingSummaryApi) _then) = __$PlaceRatingSummaryApiCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(fromJson: _readDouble) double averageRating,@JsonKey(fromJson: _readInt) int totalReviews, PlaceRatingDistribution distribution
});


@override $PlaceRatingDistributionCopyWith<$Res> get distribution;

}
/// @nodoc
class __$PlaceRatingSummaryApiCopyWithImpl<$Res>
    implements _$PlaceRatingSummaryApiCopyWith<$Res> {
  __$PlaceRatingSummaryApiCopyWithImpl(this._self, this._then);

  final _PlaceRatingSummaryApi _self;
  final $Res Function(_PlaceRatingSummaryApi) _then;

/// Create a copy of PlaceRatingSummaryApi
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? averageRating = null,Object? totalReviews = null,Object? distribution = null,}) {
  return _then(_PlaceRatingSummaryApi(
averageRating: null == averageRating ? _self.averageRating : averageRating // ignore: cast_nullable_to_non_nullable
as double,totalReviews: null == totalReviews ? _self.totalReviews : totalReviews // ignore: cast_nullable_to_non_nullable
as int,distribution: null == distribution ? _self.distribution : distribution // ignore: cast_nullable_to_non_nullable
as PlaceRatingDistribution,
  ));
}

/// Create a copy of PlaceRatingSummaryApi
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlaceRatingDistributionCopyWith<$Res> get distribution {
  
  return $PlaceRatingDistributionCopyWith<$Res>(_self.distribution, (value) {
    return _then(_self.copyWith(distribution: value));
  });
}
}


/// @nodoc
mixin _$PlaceReviewUserApi {

 String get id; String get username; String? get avatarId;
/// Create a copy of PlaceReviewUserApi
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlaceReviewUserApiCopyWith<PlaceReviewUserApi> get copyWith => _$PlaceReviewUserApiCopyWithImpl<PlaceReviewUserApi>(this as PlaceReviewUserApi, _$identity);

  /// Serializes this PlaceReviewUserApi to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as PlaceReviewUserApi;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlaceReviewUserApi&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.username, _this.username) || other.username == _this.username)&&(identical(other.avatarId, _this.avatarId) || other.avatarId == _this.avatarId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as PlaceReviewUserApi;
  return Object.hash(runtimeType,_this.id,_this.username,_this.avatarId);
}

@override
String toString() {
  final _this = this as PlaceReviewUserApi;
  return 'PlaceReviewUserApi(id: ${_this.id}, username: ${_this.username}, avatarId: ${_this.avatarId})';
}


}

/// @nodoc
abstract mixin class $PlaceReviewUserApiCopyWith<$Res>  {
  factory $PlaceReviewUserApiCopyWith(PlaceReviewUserApi value, $Res Function(PlaceReviewUserApi) _then) = _$PlaceReviewUserApiCopyWithImpl;
@useResult
$Res call({
 String id, String username, String? avatarId
});




}
/// @nodoc
class _$PlaceReviewUserApiCopyWithImpl<$Res>
    implements $PlaceReviewUserApiCopyWith<$Res> {
  _$PlaceReviewUserApiCopyWithImpl(this._self, this._then);

  final PlaceReviewUserApi _self;
  final $Res Function(PlaceReviewUserApi) _then;

/// Create a copy of PlaceReviewUserApi
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? username = null,Object? avatarId = freezed,}) {
  return _then(PlaceReviewUserApi(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,avatarId: freezed == avatarId ? _self.avatarId : avatarId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PlaceReviewUserApi].
extension PlaceReviewUserApiPatterns on PlaceReviewUserApi {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlaceReviewUserApi value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlaceReviewUserApi() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlaceReviewUserApi value)  $default,){
final _that = this;
switch (_that) {
case _PlaceReviewUserApi():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlaceReviewUserApi value)?  $default,){
final _that = this;
switch (_that) {
case _PlaceReviewUserApi() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String username,  String? avatarId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlaceReviewUserApi() when $default != null:
return $default(_that.id,_that.username,_that.avatarId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String username,  String? avatarId)  $default,) {final _that = this;
switch (_that) {
case _PlaceReviewUserApi():
return $default(_that.id,_that.username,_that.avatarId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String username,  String? avatarId)?  $default,) {final _that = this;
switch (_that) {
case _PlaceReviewUserApi() when $default != null:
return $default(_that.id,_that.username,_that.avatarId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PlaceReviewUserApi implements PlaceReviewUserApi {
  const _PlaceReviewUserApi({required this.id, required this.username, this.avatarId});
  factory _PlaceReviewUserApi.fromJson(Map<String, dynamic> json) => _$PlaceReviewUserApiFromJson(json);

@override final  String id;
@override final  String username;
@override final  String? avatarId;

/// Create a copy of PlaceReviewUserApi
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlaceReviewUserApiCopyWith<_PlaceReviewUserApi> get copyWith => __$PlaceReviewUserApiCopyWithImpl<_PlaceReviewUserApi>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlaceReviewUserApiToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlaceReviewUserApi&&(identical(other.id, id) || other.id == id)&&(identical(other.username, username) || other.username == username)&&(identical(other.avatarId, avatarId) || other.avatarId == avatarId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,username,avatarId);
}

@override
String toString() {
    return 'PlaceReviewUserApi(id: $id, username: $username, avatarId: $avatarId)';
}


}

/// @nodoc
abstract mixin class _$PlaceReviewUserApiCopyWith<$Res> implements $PlaceReviewUserApiCopyWith<$Res> {
  factory _$PlaceReviewUserApiCopyWith(_PlaceReviewUserApi value, $Res Function(_PlaceReviewUserApi) _then) = __$PlaceReviewUserApiCopyWithImpl;
@override @useResult
$Res call({
 String id, String username, String? avatarId
});




}
/// @nodoc
class __$PlaceReviewUserApiCopyWithImpl<$Res>
    implements _$PlaceReviewUserApiCopyWith<$Res> {
  __$PlaceReviewUserApiCopyWithImpl(this._self, this._then);

  final _PlaceReviewUserApi _self;
  final $Res Function(_PlaceReviewUserApi) _then;

/// Create a copy of PlaceReviewUserApi
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? username = null,Object? avatarId = freezed,}) {
  return _then(_PlaceReviewUserApi(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,avatarId: freezed == avatarId ? _self.avatarId : avatarId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$PlaceReviewPlaceApi {

 String get id; String get name;
/// Create a copy of PlaceReviewPlaceApi
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlaceReviewPlaceApiCopyWith<PlaceReviewPlaceApi> get copyWith => _$PlaceReviewPlaceApiCopyWithImpl<PlaceReviewPlaceApi>(this as PlaceReviewPlaceApi, _$identity);

  /// Serializes this PlaceReviewPlaceApi to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as PlaceReviewPlaceApi;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlaceReviewPlaceApi&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as PlaceReviewPlaceApi;
  return Object.hash(runtimeType,_this.id,_this.name);
}

@override
String toString() {
  final _this = this as PlaceReviewPlaceApi;
  return 'PlaceReviewPlaceApi(id: ${_this.id}, name: ${_this.name})';
}


}

/// @nodoc
abstract mixin class $PlaceReviewPlaceApiCopyWith<$Res>  {
  factory $PlaceReviewPlaceApiCopyWith(PlaceReviewPlaceApi value, $Res Function(PlaceReviewPlaceApi) _then) = _$PlaceReviewPlaceApiCopyWithImpl;
@useResult
$Res call({
 String id, String name
});




}
/// @nodoc
class _$PlaceReviewPlaceApiCopyWithImpl<$Res>
    implements $PlaceReviewPlaceApiCopyWith<$Res> {
  _$PlaceReviewPlaceApiCopyWithImpl(this._self, this._then);

  final PlaceReviewPlaceApi _self;
  final $Res Function(PlaceReviewPlaceApi) _then;

/// Create a copy of PlaceReviewPlaceApi
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,}) {
  return _then(PlaceReviewPlaceApi(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [PlaceReviewPlaceApi].
extension PlaceReviewPlaceApiPatterns on PlaceReviewPlaceApi {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlaceReviewPlaceApi value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlaceReviewPlaceApi() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlaceReviewPlaceApi value)  $default,){
final _that = this;
switch (_that) {
case _PlaceReviewPlaceApi():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlaceReviewPlaceApi value)?  $default,){
final _that = this;
switch (_that) {
case _PlaceReviewPlaceApi() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlaceReviewPlaceApi() when $default != null:
return $default(_that.id,_that.name);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name)  $default,) {final _that = this;
switch (_that) {
case _PlaceReviewPlaceApi():
return $default(_that.id,_that.name);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name)?  $default,) {final _that = this;
switch (_that) {
case _PlaceReviewPlaceApi() when $default != null:
return $default(_that.id,_that.name);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PlaceReviewPlaceApi implements PlaceReviewPlaceApi {
  const _PlaceReviewPlaceApi({required this.id, required this.name});
  factory _PlaceReviewPlaceApi.fromJson(Map<String, dynamic> json) => _$PlaceReviewPlaceApiFromJson(json);

@override final  String id;
@override final  String name;

/// Create a copy of PlaceReviewPlaceApi
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlaceReviewPlaceApiCopyWith<_PlaceReviewPlaceApi> get copyWith => __$PlaceReviewPlaceApiCopyWithImpl<_PlaceReviewPlaceApi>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlaceReviewPlaceApiToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlaceReviewPlaceApi&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,name);
}

@override
String toString() {
    return 'PlaceReviewPlaceApi(id: $id, name: $name)';
}


}

/// @nodoc
abstract mixin class _$PlaceReviewPlaceApiCopyWith<$Res> implements $PlaceReviewPlaceApiCopyWith<$Res> {
  factory _$PlaceReviewPlaceApiCopyWith(_PlaceReviewPlaceApi value, $Res Function(_PlaceReviewPlaceApi) _then) = __$PlaceReviewPlaceApiCopyWithImpl;
@override @useResult
$Res call({
 String id, String name
});




}
/// @nodoc
class __$PlaceReviewPlaceApiCopyWithImpl<$Res>
    implements _$PlaceReviewPlaceApiCopyWith<$Res> {
  __$PlaceReviewPlaceApiCopyWithImpl(this._self, this._then);

  final _PlaceReviewPlaceApi _self;
  final $Res Function(_PlaceReviewPlaceApi) _then;

/// Create a copy of PlaceReviewPlaceApi
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,}) {
  return _then(_PlaceReviewPlaceApi(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$PlaceReviewApi {

 String get id; String get userId; String get placeId;@JsonKey(fromJson: _readDouble) double get rating; String? get comment; String get createdAt; String get updatedAt; PlaceReviewUserApi get user; PlaceReviewPlaceApi? get place;
/// Create a copy of PlaceReviewApi
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlaceReviewApiCopyWith<PlaceReviewApi> get copyWith => _$PlaceReviewApiCopyWithImpl<PlaceReviewApi>(this as PlaceReviewApi, _$identity);

  /// Serializes this PlaceReviewApi to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as PlaceReviewApi;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlaceReviewApi&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.userId, _this.userId) || other.userId == _this.userId)&&(identical(other.placeId, _this.placeId) || other.placeId == _this.placeId)&&(identical(other.rating, _this.rating) || other.rating == _this.rating)&&(identical(other.comment, _this.comment) || other.comment == _this.comment)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.updatedAt, _this.updatedAt) || other.updatedAt == _this.updatedAt)&&(identical(other.user, _this.user) || other.user == _this.user)&&(identical(other.place, _this.place) || other.place == _this.place));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as PlaceReviewApi;
  return Object.hash(runtimeType,_this.id,_this.userId,_this.placeId,_this.rating,_this.comment,_this.createdAt,_this.updatedAt,_this.user,_this.place);
}

@override
String toString() {
  final _this = this as PlaceReviewApi;
  return 'PlaceReviewApi(id: ${_this.id}, userId: ${_this.userId}, placeId: ${_this.placeId}, rating: ${_this.rating}, comment: ${_this.comment}, createdAt: ${_this.createdAt}, updatedAt: ${_this.updatedAt}, user: ${_this.user}, place: ${_this.place})';
}


}

/// @nodoc
abstract mixin class $PlaceReviewApiCopyWith<$Res>  {
  factory $PlaceReviewApiCopyWith(PlaceReviewApi value, $Res Function(PlaceReviewApi) _then) = _$PlaceReviewApiCopyWithImpl;
@useResult
$Res call({
 String id, String userId, String placeId,@JsonKey(fromJson: _readDouble) double rating, String? comment, String createdAt, String updatedAt, PlaceReviewUserApi user, PlaceReviewPlaceApi? place
});


$PlaceReviewUserApiCopyWith<$Res> get user;$PlaceReviewPlaceApiCopyWith<$Res>? get place;

}
/// @nodoc
class _$PlaceReviewApiCopyWithImpl<$Res>
    implements $PlaceReviewApiCopyWith<$Res> {
  _$PlaceReviewApiCopyWithImpl(this._self, this._then);

  final PlaceReviewApi _self;
  final $Res Function(PlaceReviewApi) _then;

/// Create a copy of PlaceReviewApi
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? placeId = null,Object? rating = null,Object? comment = freezed,Object? createdAt = null,Object? updatedAt = null,Object? user = null,Object? place = freezed,}) {
  return _then(PlaceReviewApi(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,placeId: null == placeId ? _self.placeId : placeId // ignore: cast_nullable_to_non_nullable
as String,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,comment: freezed == comment ? _self.comment : comment // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String,user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as PlaceReviewUserApi,place: freezed == place ? _self.place : place // ignore: cast_nullable_to_non_nullable
as PlaceReviewPlaceApi?,
  ));
}
/// Create a copy of PlaceReviewApi
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlaceReviewUserApiCopyWith<$Res> get user {
  
  return $PlaceReviewUserApiCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}/// Create a copy of PlaceReviewApi
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlaceReviewPlaceApiCopyWith<$Res>? get place {
    if (_self.place == null) {
    return null;
  }

  return $PlaceReviewPlaceApiCopyWith<$Res>(_self.place!, (value) {
    return _then(_self.copyWith(place: value));
  });
}
}


/// Adds pattern-matching-related methods to [PlaceReviewApi].
extension PlaceReviewApiPatterns on PlaceReviewApi {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlaceReviewApi value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlaceReviewApi() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlaceReviewApi value)  $default,){
final _that = this;
switch (_that) {
case _PlaceReviewApi():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlaceReviewApi value)?  $default,){
final _that = this;
switch (_that) {
case _PlaceReviewApi() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String userId,  String placeId, @JsonKey(fromJson: _readDouble)  double rating,  String? comment,  String createdAt,  String updatedAt,  PlaceReviewUserApi user,  PlaceReviewPlaceApi? place)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlaceReviewApi() when $default != null:
return $default(_that.id,_that.userId,_that.placeId,_that.rating,_that.comment,_that.createdAt,_that.updatedAt,_that.user,_that.place);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String userId,  String placeId, @JsonKey(fromJson: _readDouble)  double rating,  String? comment,  String createdAt,  String updatedAt,  PlaceReviewUserApi user,  PlaceReviewPlaceApi? place)  $default,) {final _that = this;
switch (_that) {
case _PlaceReviewApi():
return $default(_that.id,_that.userId,_that.placeId,_that.rating,_that.comment,_that.createdAt,_that.updatedAt,_that.user,_that.place);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String userId,  String placeId, @JsonKey(fromJson: _readDouble)  double rating,  String? comment,  String createdAt,  String updatedAt,  PlaceReviewUserApi user,  PlaceReviewPlaceApi? place)?  $default,) {final _that = this;
switch (_that) {
case _PlaceReviewApi() when $default != null:
return $default(_that.id,_that.userId,_that.placeId,_that.rating,_that.comment,_that.createdAt,_that.updatedAt,_that.user,_that.place);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PlaceReviewApi implements PlaceReviewApi {
  const _PlaceReviewApi({required this.id, required this.userId, required this.placeId, @JsonKey(fromJson: _readDouble) required this.rating, this.comment, required this.createdAt, required this.updatedAt, required this.user, this.place});
  factory _PlaceReviewApi.fromJson(Map<String, dynamic> json) => _$PlaceReviewApiFromJson(json);

@override final  String id;
@override final  String userId;
@override final  String placeId;
@override@JsonKey(fromJson: _readDouble) final  double rating;
@override final  String? comment;
@override final  String createdAt;
@override final  String updatedAt;
@override final  PlaceReviewUserApi user;
@override final  PlaceReviewPlaceApi? place;

/// Create a copy of PlaceReviewApi
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlaceReviewApiCopyWith<_PlaceReviewApi> get copyWith => __$PlaceReviewApiCopyWithImpl<_PlaceReviewApi>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlaceReviewApiToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlaceReviewApi&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.placeId, placeId) || other.placeId == placeId)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.comment, comment) || other.comment == comment)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.user, user) || other.user == user)&&(identical(other.place, place) || other.place == place));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,userId,placeId,rating,comment,createdAt,updatedAt,user,place);
}

@override
String toString() {
    return 'PlaceReviewApi(id: $id, userId: $userId, placeId: $placeId, rating: $rating, comment: $comment, createdAt: $createdAt, updatedAt: $updatedAt, user: $user, place: $place)';
}


}

/// @nodoc
abstract mixin class _$PlaceReviewApiCopyWith<$Res> implements $PlaceReviewApiCopyWith<$Res> {
  factory _$PlaceReviewApiCopyWith(_PlaceReviewApi value, $Res Function(_PlaceReviewApi) _then) = __$PlaceReviewApiCopyWithImpl;
@override @useResult
$Res call({
 String id, String userId, String placeId,@JsonKey(fromJson: _readDouble) double rating, String? comment, String createdAt, String updatedAt, PlaceReviewUserApi user, PlaceReviewPlaceApi? place
});


@override $PlaceReviewUserApiCopyWith<$Res> get user;@override $PlaceReviewPlaceApiCopyWith<$Res>? get place;

}
/// @nodoc
class __$PlaceReviewApiCopyWithImpl<$Res>
    implements _$PlaceReviewApiCopyWith<$Res> {
  __$PlaceReviewApiCopyWithImpl(this._self, this._then);

  final _PlaceReviewApi _self;
  final $Res Function(_PlaceReviewApi) _then;

/// Create a copy of PlaceReviewApi
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? placeId = null,Object? rating = null,Object? comment = freezed,Object? createdAt = null,Object? updatedAt = null,Object? user = null,Object? place = freezed,}) {
  return _then(_PlaceReviewApi(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,placeId: null == placeId ? _self.placeId : placeId // ignore: cast_nullable_to_non_nullable
as String,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,comment: freezed == comment ? _self.comment : comment // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String,user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as PlaceReviewUserApi,place: freezed == place ? _self.place : place // ignore: cast_nullable_to_non_nullable
as PlaceReviewPlaceApi?,
  ));
}

/// Create a copy of PlaceReviewApi
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlaceReviewUserApiCopyWith<$Res> get user {
  
  return $PlaceReviewUserApiCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}/// Create a copy of PlaceReviewApi
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlaceReviewPlaceApiCopyWith<$Res>? get place {
    if (_self.place == null) {
    return null;
  }

  return $PlaceReviewPlaceApiCopyWith<$Res>(_self.place!, (value) {
    return _then(_self.copyWith(place: value));
  });
}
}


/// @nodoc
mixin _$PlaceReviewsPage {

 List<PlaceReviewApi> get data; PlacePageMeta get meta;
/// Create a copy of PlaceReviewsPage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlaceReviewsPageCopyWith<PlaceReviewsPage> get copyWith => _$PlaceReviewsPageCopyWithImpl<PlaceReviewsPage>(this as PlaceReviewsPage, _$identity);

  /// Serializes this PlaceReviewsPage to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as PlaceReviewsPage;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlaceReviewsPage&&const DeepCollectionEquality().equals(other.data, _this.data)&&(identical(other.meta, _this.meta) || other.meta == _this.meta));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as PlaceReviewsPage;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.data),_this.meta);
}

@override
String toString() {
  final _this = this as PlaceReviewsPage;
  return 'PlaceReviewsPage(data: ${_this.data}, meta: ${_this.meta})';
}


}

/// @nodoc
abstract mixin class $PlaceReviewsPageCopyWith<$Res>  {
  factory $PlaceReviewsPageCopyWith(PlaceReviewsPage value, $Res Function(PlaceReviewsPage) _then) = _$PlaceReviewsPageCopyWithImpl;
@useResult
$Res call({
 List<PlaceReviewApi> data, PlacePageMeta meta
});


$PlacePageMetaCopyWith<$Res> get meta;

}
/// @nodoc
class _$PlaceReviewsPageCopyWithImpl<$Res>
    implements $PlaceReviewsPageCopyWith<$Res> {
  _$PlaceReviewsPageCopyWithImpl(this._self, this._then);

  final PlaceReviewsPage _self;
  final $Res Function(PlaceReviewsPage) _then;

/// Create a copy of PlaceReviewsPage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? data = null,Object? meta = null,}) {
  return _then(PlaceReviewsPage(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as List<PlaceReviewApi>,meta: null == meta ? _self.meta : meta // ignore: cast_nullable_to_non_nullable
as PlacePageMeta,
  ));
}
/// Create a copy of PlaceReviewsPage
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlacePageMetaCopyWith<$Res> get meta {
  
  return $PlacePageMetaCopyWith<$Res>(_self.meta, (value) {
    return _then(_self.copyWith(meta: value));
  });
}
}


/// Adds pattern-matching-related methods to [PlaceReviewsPage].
extension PlaceReviewsPagePatterns on PlaceReviewsPage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlaceReviewsPage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlaceReviewsPage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlaceReviewsPage value)  $default,){
final _that = this;
switch (_that) {
case _PlaceReviewsPage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlaceReviewsPage value)?  $default,){
final _that = this;
switch (_that) {
case _PlaceReviewsPage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<PlaceReviewApi> data,  PlacePageMeta meta)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlaceReviewsPage() when $default != null:
return $default(_that.data,_that.meta);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<PlaceReviewApi> data,  PlacePageMeta meta)  $default,) {final _that = this;
switch (_that) {
case _PlaceReviewsPage():
return $default(_that.data,_that.meta);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<PlaceReviewApi> data,  PlacePageMeta meta)?  $default,) {final _that = this;
switch (_that) {
case _PlaceReviewsPage() when $default != null:
return $default(_that.data,_that.meta);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PlaceReviewsPage implements PlaceReviewsPage {
  const _PlaceReviewsPage({ List<PlaceReviewApi> data = const <PlaceReviewApi>[], required this.meta}): _data = data;
  factory _PlaceReviewsPage.fromJson(Map<String, dynamic> json) => _$PlaceReviewsPageFromJson(json);

 final  List<PlaceReviewApi> _data;
@override@JsonKey() List<PlaceReviewApi> get data {
  if (_data is EqualUnmodifiableListView) return _data;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_data);
}

@override final  PlacePageMeta meta;

/// Create a copy of PlaceReviewsPage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlaceReviewsPageCopyWith<_PlaceReviewsPage> get copyWith => __$PlaceReviewsPageCopyWithImpl<_PlaceReviewsPage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlaceReviewsPageToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlaceReviewsPage&&const DeepCollectionEquality().equals(other.data, _data)&&(identical(other.meta, meta) || other.meta == meta));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_data),meta);
}

@override
String toString() {
    return 'PlaceReviewsPage(data: $data, meta: $meta)';
}


}

/// @nodoc
abstract mixin class _$PlaceReviewsPageCopyWith<$Res> implements $PlaceReviewsPageCopyWith<$Res> {
  factory _$PlaceReviewsPageCopyWith(_PlaceReviewsPage value, $Res Function(_PlaceReviewsPage) _then) = __$PlaceReviewsPageCopyWithImpl;
@override @useResult
$Res call({
 List<PlaceReviewApi> data, PlacePageMeta meta
});


@override $PlacePageMetaCopyWith<$Res> get meta;

}
/// @nodoc
class __$PlaceReviewsPageCopyWithImpl<$Res>
    implements _$PlaceReviewsPageCopyWith<$Res> {
  __$PlaceReviewsPageCopyWithImpl(this._self, this._then);

  final _PlaceReviewsPage _self;
  final $Res Function(_PlaceReviewsPage) _then;

/// Create a copy of PlaceReviewsPage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? data = null,Object? meta = null,}) {
  return _then(_PlaceReviewsPage(
data: null == data ? _self._data : data // ignore: cast_nullable_to_non_nullable
as List<PlaceReviewApi>,meta: null == meta ? _self.meta : meta // ignore: cast_nullable_to_non_nullable
as PlacePageMeta,
  ));
}

/// Create a copy of PlaceReviewsPage
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlacePageMetaCopyWith<$Res> get meta {
  
  return $PlacePageMetaCopyWith<$Res>(_self.meta, (value) {
    return _then(_self.copyWith(meta: value));
  });
}
}


/// @nodoc
mixin _$PlaceSaveStatusApi {

 bool get saved; String? get savedAt;
/// Create a copy of PlaceSaveStatusApi
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlaceSaveStatusApiCopyWith<PlaceSaveStatusApi> get copyWith => _$PlaceSaveStatusApiCopyWithImpl<PlaceSaveStatusApi>(this as PlaceSaveStatusApi, _$identity);

  /// Serializes this PlaceSaveStatusApi to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as PlaceSaveStatusApi;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlaceSaveStatusApi&&(identical(other.saved, _this.saved) || other.saved == _this.saved)&&(identical(other.savedAt, _this.savedAt) || other.savedAt == _this.savedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as PlaceSaveStatusApi;
  return Object.hash(runtimeType,_this.saved,_this.savedAt);
}

@override
String toString() {
  final _this = this as PlaceSaveStatusApi;
  return 'PlaceSaveStatusApi(saved: ${_this.saved}, savedAt: ${_this.savedAt})';
}


}

/// @nodoc
abstract mixin class $PlaceSaveStatusApiCopyWith<$Res>  {
  factory $PlaceSaveStatusApiCopyWith(PlaceSaveStatusApi value, $Res Function(PlaceSaveStatusApi) _then) = _$PlaceSaveStatusApiCopyWithImpl;
@useResult
$Res call({
 bool saved, String? savedAt
});




}
/// @nodoc
class _$PlaceSaveStatusApiCopyWithImpl<$Res>
    implements $PlaceSaveStatusApiCopyWith<$Res> {
  _$PlaceSaveStatusApiCopyWithImpl(this._self, this._then);

  final PlaceSaveStatusApi _self;
  final $Res Function(PlaceSaveStatusApi) _then;

/// Create a copy of PlaceSaveStatusApi
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? saved = null,Object? savedAt = freezed,}) {
  return _then(PlaceSaveStatusApi(
saved: null == saved ? _self.saved : saved // ignore: cast_nullable_to_non_nullable
as bool,savedAt: freezed == savedAt ? _self.savedAt : savedAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PlaceSaveStatusApi].
extension PlaceSaveStatusApiPatterns on PlaceSaveStatusApi {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlaceSaveStatusApi value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlaceSaveStatusApi() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlaceSaveStatusApi value)  $default,){
final _that = this;
switch (_that) {
case _PlaceSaveStatusApi():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlaceSaveStatusApi value)?  $default,){
final _that = this;
switch (_that) {
case _PlaceSaveStatusApi() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool saved,  String? savedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlaceSaveStatusApi() when $default != null:
return $default(_that.saved,_that.savedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool saved,  String? savedAt)  $default,) {final _that = this;
switch (_that) {
case _PlaceSaveStatusApi():
return $default(_that.saved,_that.savedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool saved,  String? savedAt)?  $default,) {final _that = this;
switch (_that) {
case _PlaceSaveStatusApi() when $default != null:
return $default(_that.saved,_that.savedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PlaceSaveStatusApi implements PlaceSaveStatusApi {
  const _PlaceSaveStatusApi({required this.saved, this.savedAt});
  factory _PlaceSaveStatusApi.fromJson(Map<String, dynamic> json) => _$PlaceSaveStatusApiFromJson(json);

@override final  bool saved;
@override final  String? savedAt;

/// Create a copy of PlaceSaveStatusApi
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlaceSaveStatusApiCopyWith<_PlaceSaveStatusApi> get copyWith => __$PlaceSaveStatusApiCopyWithImpl<_PlaceSaveStatusApi>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlaceSaveStatusApiToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlaceSaveStatusApi&&(identical(other.saved, saved) || other.saved == saved)&&(identical(other.savedAt, savedAt) || other.savedAt == savedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,saved,savedAt);
}

@override
String toString() {
    return 'PlaceSaveStatusApi(saved: $saved, savedAt: $savedAt)';
}


}

/// @nodoc
abstract mixin class _$PlaceSaveStatusApiCopyWith<$Res> implements $PlaceSaveStatusApiCopyWith<$Res> {
  factory _$PlaceSaveStatusApiCopyWith(_PlaceSaveStatusApi value, $Res Function(_PlaceSaveStatusApi) _then) = __$PlaceSaveStatusApiCopyWithImpl;
@override @useResult
$Res call({
 bool saved, String? savedAt
});




}
/// @nodoc
class __$PlaceSaveStatusApiCopyWithImpl<$Res>
    implements _$PlaceSaveStatusApiCopyWith<$Res> {
  __$PlaceSaveStatusApiCopyWithImpl(this._self, this._then);

  final _PlaceSaveStatusApi _self;
  final $Res Function(_PlaceSaveStatusApi) _then;

/// Create a copy of PlaceSaveStatusApi
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? saved = null,Object? savedAt = freezed,}) {
  return _then(_PlaceSaveStatusApi(
saved: null == saved ? _self.saved : saved // ignore: cast_nullable_to_non_nullable
as bool,savedAt: freezed == savedAt ? _self.savedAt : savedAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$PlacePostAuthorApi {

 String get id; String get username; String? get avatarId;
/// Create a copy of PlacePostAuthorApi
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlacePostAuthorApiCopyWith<PlacePostAuthorApi> get copyWith => _$PlacePostAuthorApiCopyWithImpl<PlacePostAuthorApi>(this as PlacePostAuthorApi, _$identity);

  /// Serializes this PlacePostAuthorApi to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as PlacePostAuthorApi;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlacePostAuthorApi&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.username, _this.username) || other.username == _this.username)&&(identical(other.avatarId, _this.avatarId) || other.avatarId == _this.avatarId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as PlacePostAuthorApi;
  return Object.hash(runtimeType,_this.id,_this.username,_this.avatarId);
}

@override
String toString() {
  final _this = this as PlacePostAuthorApi;
  return 'PlacePostAuthorApi(id: ${_this.id}, username: ${_this.username}, avatarId: ${_this.avatarId})';
}


}

/// @nodoc
abstract mixin class $PlacePostAuthorApiCopyWith<$Res>  {
  factory $PlacePostAuthorApiCopyWith(PlacePostAuthorApi value, $Res Function(PlacePostAuthorApi) _then) = _$PlacePostAuthorApiCopyWithImpl;
@useResult
$Res call({
 String id, String username, String? avatarId
});




}
/// @nodoc
class _$PlacePostAuthorApiCopyWithImpl<$Res>
    implements $PlacePostAuthorApiCopyWith<$Res> {
  _$PlacePostAuthorApiCopyWithImpl(this._self, this._then);

  final PlacePostAuthorApi _self;
  final $Res Function(PlacePostAuthorApi) _then;

/// Create a copy of PlacePostAuthorApi
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? username = null,Object? avatarId = freezed,}) {
  return _then(PlacePostAuthorApi(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,avatarId: freezed == avatarId ? _self.avatarId : avatarId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PlacePostAuthorApi].
extension PlacePostAuthorApiPatterns on PlacePostAuthorApi {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlacePostAuthorApi value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlacePostAuthorApi() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlacePostAuthorApi value)  $default,){
final _that = this;
switch (_that) {
case _PlacePostAuthorApi():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlacePostAuthorApi value)?  $default,){
final _that = this;
switch (_that) {
case _PlacePostAuthorApi() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String username,  String? avatarId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlacePostAuthorApi() when $default != null:
return $default(_that.id,_that.username,_that.avatarId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String username,  String? avatarId)  $default,) {final _that = this;
switch (_that) {
case _PlacePostAuthorApi():
return $default(_that.id,_that.username,_that.avatarId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String username,  String? avatarId)?  $default,) {final _that = this;
switch (_that) {
case _PlacePostAuthorApi() when $default != null:
return $default(_that.id,_that.username,_that.avatarId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PlacePostAuthorApi implements PlacePostAuthorApi {
  const _PlacePostAuthorApi({required this.id, required this.username, this.avatarId});
  factory _PlacePostAuthorApi.fromJson(Map<String, dynamic> json) => _$PlacePostAuthorApiFromJson(json);

@override final  String id;
@override final  String username;
@override final  String? avatarId;

/// Create a copy of PlacePostAuthorApi
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlacePostAuthorApiCopyWith<_PlacePostAuthorApi> get copyWith => __$PlacePostAuthorApiCopyWithImpl<_PlacePostAuthorApi>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlacePostAuthorApiToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlacePostAuthorApi&&(identical(other.id, id) || other.id == id)&&(identical(other.username, username) || other.username == username)&&(identical(other.avatarId, avatarId) || other.avatarId == avatarId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,username,avatarId);
}

@override
String toString() {
    return 'PlacePostAuthorApi(id: $id, username: $username, avatarId: $avatarId)';
}


}

/// @nodoc
abstract mixin class _$PlacePostAuthorApiCopyWith<$Res> implements $PlacePostAuthorApiCopyWith<$Res> {
  factory _$PlacePostAuthorApiCopyWith(_PlacePostAuthorApi value, $Res Function(_PlacePostAuthorApi) _then) = __$PlacePostAuthorApiCopyWithImpl;
@override @useResult
$Res call({
 String id, String username, String? avatarId
});




}
/// @nodoc
class __$PlacePostAuthorApiCopyWithImpl<$Res>
    implements _$PlacePostAuthorApiCopyWith<$Res> {
  __$PlacePostAuthorApiCopyWithImpl(this._self, this._then);

  final _PlacePostAuthorApi _self;
  final $Res Function(_PlacePostAuthorApi) _then;

/// Create a copy of PlacePostAuthorApi
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? username = null,Object? avatarId = freezed,}) {
  return _then(_PlacePostAuthorApi(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,avatarId: freezed == avatarId ? _self.avatarId : avatarId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$PlacePostMediaApi {

 String get mediaId;@JsonKey(fromJson: _readInt) int get orderIndex;
/// Create a copy of PlacePostMediaApi
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlacePostMediaApiCopyWith<PlacePostMediaApi> get copyWith => _$PlacePostMediaApiCopyWithImpl<PlacePostMediaApi>(this as PlacePostMediaApi, _$identity);

  /// Serializes this PlacePostMediaApi to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as PlacePostMediaApi;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlacePostMediaApi&&(identical(other.mediaId, _this.mediaId) || other.mediaId == _this.mediaId)&&(identical(other.orderIndex, _this.orderIndex) || other.orderIndex == _this.orderIndex));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as PlacePostMediaApi;
  return Object.hash(runtimeType,_this.mediaId,_this.orderIndex);
}

@override
String toString() {
  final _this = this as PlacePostMediaApi;
  return 'PlacePostMediaApi(mediaId: ${_this.mediaId}, orderIndex: ${_this.orderIndex})';
}


}

/// @nodoc
abstract mixin class $PlacePostMediaApiCopyWith<$Res>  {
  factory $PlacePostMediaApiCopyWith(PlacePostMediaApi value, $Res Function(PlacePostMediaApi) _then) = _$PlacePostMediaApiCopyWithImpl;
@useResult
$Res call({
 String mediaId,@JsonKey(fromJson: _readInt) int orderIndex
});




}
/// @nodoc
class _$PlacePostMediaApiCopyWithImpl<$Res>
    implements $PlacePostMediaApiCopyWith<$Res> {
  _$PlacePostMediaApiCopyWithImpl(this._self, this._then);

  final PlacePostMediaApi _self;
  final $Res Function(PlacePostMediaApi) _then;

/// Create a copy of PlacePostMediaApi
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? mediaId = null,Object? orderIndex = null,}) {
  return _then(PlacePostMediaApi(
mediaId: null == mediaId ? _self.mediaId : mediaId // ignore: cast_nullable_to_non_nullable
as String,orderIndex: null == orderIndex ? _self.orderIndex : orderIndex // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [PlacePostMediaApi].
extension PlacePostMediaApiPatterns on PlacePostMediaApi {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlacePostMediaApi value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlacePostMediaApi() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlacePostMediaApi value)  $default,){
final _that = this;
switch (_that) {
case _PlacePostMediaApi():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlacePostMediaApi value)?  $default,){
final _that = this;
switch (_that) {
case _PlacePostMediaApi() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String mediaId, @JsonKey(fromJson: _readInt)  int orderIndex)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlacePostMediaApi() when $default != null:
return $default(_that.mediaId,_that.orderIndex);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String mediaId, @JsonKey(fromJson: _readInt)  int orderIndex)  $default,) {final _that = this;
switch (_that) {
case _PlacePostMediaApi():
return $default(_that.mediaId,_that.orderIndex);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String mediaId, @JsonKey(fromJson: _readInt)  int orderIndex)?  $default,) {final _that = this;
switch (_that) {
case _PlacePostMediaApi() when $default != null:
return $default(_that.mediaId,_that.orderIndex);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PlacePostMediaApi implements PlacePostMediaApi {
  const _PlacePostMediaApi({required this.mediaId, @JsonKey(fromJson: _readInt) required this.orderIndex});
  factory _PlacePostMediaApi.fromJson(Map<String, dynamic> json) => _$PlacePostMediaApiFromJson(json);

@override final  String mediaId;
@override@JsonKey(fromJson: _readInt) final  int orderIndex;

/// Create a copy of PlacePostMediaApi
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlacePostMediaApiCopyWith<_PlacePostMediaApi> get copyWith => __$PlacePostMediaApiCopyWithImpl<_PlacePostMediaApi>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlacePostMediaApiToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlacePostMediaApi&&(identical(other.mediaId, mediaId) || other.mediaId == mediaId)&&(identical(other.orderIndex, orderIndex) || other.orderIndex == orderIndex));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,mediaId,orderIndex);
}

@override
String toString() {
    return 'PlacePostMediaApi(mediaId: $mediaId, orderIndex: $orderIndex)';
}


}

/// @nodoc
abstract mixin class _$PlacePostMediaApiCopyWith<$Res> implements $PlacePostMediaApiCopyWith<$Res> {
  factory _$PlacePostMediaApiCopyWith(_PlacePostMediaApi value, $Res Function(_PlacePostMediaApi) _then) = __$PlacePostMediaApiCopyWithImpl;
@override @useResult
$Res call({
 String mediaId,@JsonKey(fromJson: _readInt) int orderIndex
});




}
/// @nodoc
class __$PlacePostMediaApiCopyWithImpl<$Res>
    implements _$PlacePostMediaApiCopyWith<$Res> {
  __$PlacePostMediaApiCopyWithImpl(this._self, this._then);

  final _PlacePostMediaApi _self;
  final $Res Function(_PlacePostMediaApi) _then;

/// Create a copy of PlacePostMediaApi
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? mediaId = null,Object? orderIndex = null,}) {
  return _then(_PlacePostMediaApi(
mediaId: null == mediaId ? _self.mediaId : mediaId // ignore: cast_nullable_to_non_nullable
as String,orderIndex: null == orderIndex ? _self.orderIndex : orderIndex // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$PlacePostApi {

 String get id; String? get caption;@JsonKey(fromJson: _readInt) int get likesCount; PlacePostAuthorApi get author; List<PlacePostMediaApi> get postMedias;
/// Create a copy of PlacePostApi
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlacePostApiCopyWith<PlacePostApi> get copyWith => _$PlacePostApiCopyWithImpl<PlacePostApi>(this as PlacePostApi, _$identity);

  /// Serializes this PlacePostApi to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as PlacePostApi;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlacePostApi&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.caption, _this.caption) || other.caption == _this.caption)&&(identical(other.likesCount, _this.likesCount) || other.likesCount == _this.likesCount)&&(identical(other.author, _this.author) || other.author == _this.author)&&const DeepCollectionEquality().equals(other.postMedias, _this.postMedias));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as PlacePostApi;
  return Object.hash(runtimeType,_this.id,_this.caption,_this.likesCount,_this.author,const DeepCollectionEquality().hash(_this.postMedias));
}

@override
String toString() {
  final _this = this as PlacePostApi;
  return 'PlacePostApi(id: ${_this.id}, caption: ${_this.caption}, likesCount: ${_this.likesCount}, author: ${_this.author}, postMedias: ${_this.postMedias})';
}


}

/// @nodoc
abstract mixin class $PlacePostApiCopyWith<$Res>  {
  factory $PlacePostApiCopyWith(PlacePostApi value, $Res Function(PlacePostApi) _then) = _$PlacePostApiCopyWithImpl;
@useResult
$Res call({
 String id, String? caption,@JsonKey(fromJson: _readInt) int likesCount, PlacePostAuthorApi author, List<PlacePostMediaApi> postMedias
});


$PlacePostAuthorApiCopyWith<$Res> get author;

}
/// @nodoc
class _$PlacePostApiCopyWithImpl<$Res>
    implements $PlacePostApiCopyWith<$Res> {
  _$PlacePostApiCopyWithImpl(this._self, this._then);

  final PlacePostApi _self;
  final $Res Function(PlacePostApi) _then;

/// Create a copy of PlacePostApi
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? caption = freezed,Object? likesCount = null,Object? author = null,Object? postMedias = null,}) {
  return _then(PlacePostApi(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,caption: freezed == caption ? _self.caption : caption // ignore: cast_nullable_to_non_nullable
as String?,likesCount: null == likesCount ? _self.likesCount : likesCount // ignore: cast_nullable_to_non_nullable
as int,author: null == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as PlacePostAuthorApi,postMedias: null == postMedias ? _self.postMedias : postMedias // ignore: cast_nullable_to_non_nullable
as List<PlacePostMediaApi>,
  ));
}
/// Create a copy of PlacePostApi
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlacePostAuthorApiCopyWith<$Res> get author {
  
  return $PlacePostAuthorApiCopyWith<$Res>(_self.author, (value) {
    return _then(_self.copyWith(author: value));
  });
}
}


/// Adds pattern-matching-related methods to [PlacePostApi].
extension PlacePostApiPatterns on PlacePostApi {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlacePostApi value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlacePostApi() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlacePostApi value)  $default,){
final _that = this;
switch (_that) {
case _PlacePostApi():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlacePostApi value)?  $default,){
final _that = this;
switch (_that) {
case _PlacePostApi() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String? caption, @JsonKey(fromJson: _readInt)  int likesCount,  PlacePostAuthorApi author,  List<PlacePostMediaApi> postMedias)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlacePostApi() when $default != null:
return $default(_that.id,_that.caption,_that.likesCount,_that.author,_that.postMedias);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String? caption, @JsonKey(fromJson: _readInt)  int likesCount,  PlacePostAuthorApi author,  List<PlacePostMediaApi> postMedias)  $default,) {final _that = this;
switch (_that) {
case _PlacePostApi():
return $default(_that.id,_that.caption,_that.likesCount,_that.author,_that.postMedias);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String? caption, @JsonKey(fromJson: _readInt)  int likesCount,  PlacePostAuthorApi author,  List<PlacePostMediaApi> postMedias)?  $default,) {final _that = this;
switch (_that) {
case _PlacePostApi() when $default != null:
return $default(_that.id,_that.caption,_that.likesCount,_that.author,_that.postMedias);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PlacePostApi implements PlacePostApi {
  const _PlacePostApi({required this.id, this.caption, @JsonKey(fromJson: _readInt) required this.likesCount, required this.author,  List<PlacePostMediaApi> postMedias = const <PlacePostMediaApi>[]}): _postMedias = postMedias;
  factory _PlacePostApi.fromJson(Map<String, dynamic> json) => _$PlacePostApiFromJson(json);

@override final  String id;
@override final  String? caption;
@override@JsonKey(fromJson: _readInt) final  int likesCount;
@override final  PlacePostAuthorApi author;
 final  List<PlacePostMediaApi> _postMedias;
@override@JsonKey() List<PlacePostMediaApi> get postMedias {
  if (_postMedias is EqualUnmodifiableListView) return _postMedias;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_postMedias);
}


/// Create a copy of PlacePostApi
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlacePostApiCopyWith<_PlacePostApi> get copyWith => __$PlacePostApiCopyWithImpl<_PlacePostApi>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlacePostApiToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlacePostApi&&(identical(other.id, id) || other.id == id)&&(identical(other.caption, caption) || other.caption == caption)&&(identical(other.likesCount, likesCount) || other.likesCount == likesCount)&&(identical(other.author, author) || other.author == author)&&const DeepCollectionEquality().equals(other.postMedias, _postMedias));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,caption,likesCount,author,const DeepCollectionEquality().hash(_postMedias));
}

@override
String toString() {
    return 'PlacePostApi(id: $id, caption: $caption, likesCount: $likesCount, author: $author, postMedias: $postMedias)';
}


}

/// @nodoc
abstract mixin class _$PlacePostApiCopyWith<$Res> implements $PlacePostApiCopyWith<$Res> {
  factory _$PlacePostApiCopyWith(_PlacePostApi value, $Res Function(_PlacePostApi) _then) = __$PlacePostApiCopyWithImpl;
@override @useResult
$Res call({
 String id, String? caption,@JsonKey(fromJson: _readInt) int likesCount, PlacePostAuthorApi author, List<PlacePostMediaApi> postMedias
});


@override $PlacePostAuthorApiCopyWith<$Res> get author;

}
/// @nodoc
class __$PlacePostApiCopyWithImpl<$Res>
    implements _$PlacePostApiCopyWith<$Res> {
  __$PlacePostApiCopyWithImpl(this._self, this._then);

  final _PlacePostApi _self;
  final $Res Function(_PlacePostApi) _then;

/// Create a copy of PlacePostApi
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? caption = freezed,Object? likesCount = null,Object? author = null,Object? postMedias = null,}) {
  return _then(_PlacePostApi(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,caption: freezed == caption ? _self.caption : caption // ignore: cast_nullable_to_non_nullable
as String?,likesCount: null == likesCount ? _self.likesCount : likesCount // ignore: cast_nullable_to_non_nullable
as int,author: null == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as PlacePostAuthorApi,postMedias: null == postMedias ? _self._postMedias : postMedias // ignore: cast_nullable_to_non_nullable
as List<PlacePostMediaApi>,
  ));
}

/// Create a copy of PlacePostApi
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlacePostAuthorApiCopyWith<$Res> get author {
  
  return $PlacePostAuthorApiCopyWith<$Res>(_self.author, (value) {
    return _then(_self.copyWith(author: value));
  });
}
}


/// @nodoc
mixin _$PlacePostsPage {

 List<PlacePostApi> get data; PlacePageMeta get meta;
/// Create a copy of PlacePostsPage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlacePostsPageCopyWith<PlacePostsPage> get copyWith => _$PlacePostsPageCopyWithImpl<PlacePostsPage>(this as PlacePostsPage, _$identity);

  /// Serializes this PlacePostsPage to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as PlacePostsPage;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlacePostsPage&&const DeepCollectionEquality().equals(other.data, _this.data)&&(identical(other.meta, _this.meta) || other.meta == _this.meta));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as PlacePostsPage;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.data),_this.meta);
}

@override
String toString() {
  final _this = this as PlacePostsPage;
  return 'PlacePostsPage(data: ${_this.data}, meta: ${_this.meta})';
}


}

/// @nodoc
abstract mixin class $PlacePostsPageCopyWith<$Res>  {
  factory $PlacePostsPageCopyWith(PlacePostsPage value, $Res Function(PlacePostsPage) _then) = _$PlacePostsPageCopyWithImpl;
@useResult
$Res call({
 List<PlacePostApi> data, PlacePageMeta meta
});


$PlacePageMetaCopyWith<$Res> get meta;

}
/// @nodoc
class _$PlacePostsPageCopyWithImpl<$Res>
    implements $PlacePostsPageCopyWith<$Res> {
  _$PlacePostsPageCopyWithImpl(this._self, this._then);

  final PlacePostsPage _self;
  final $Res Function(PlacePostsPage) _then;

/// Create a copy of PlacePostsPage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? data = null,Object? meta = null,}) {
  return _then(PlacePostsPage(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as List<PlacePostApi>,meta: null == meta ? _self.meta : meta // ignore: cast_nullable_to_non_nullable
as PlacePageMeta,
  ));
}
/// Create a copy of PlacePostsPage
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlacePageMetaCopyWith<$Res> get meta {
  
  return $PlacePageMetaCopyWith<$Res>(_self.meta, (value) {
    return _then(_self.copyWith(meta: value));
  });
}
}


/// Adds pattern-matching-related methods to [PlacePostsPage].
extension PlacePostsPagePatterns on PlacePostsPage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlacePostsPage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlacePostsPage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlacePostsPage value)  $default,){
final _that = this;
switch (_that) {
case _PlacePostsPage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlacePostsPage value)?  $default,){
final _that = this;
switch (_that) {
case _PlacePostsPage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<PlacePostApi> data,  PlacePageMeta meta)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlacePostsPage() when $default != null:
return $default(_that.data,_that.meta);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<PlacePostApi> data,  PlacePageMeta meta)  $default,) {final _that = this;
switch (_that) {
case _PlacePostsPage():
return $default(_that.data,_that.meta);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<PlacePostApi> data,  PlacePageMeta meta)?  $default,) {final _that = this;
switch (_that) {
case _PlacePostsPage() when $default != null:
return $default(_that.data,_that.meta);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PlacePostsPage implements PlacePostsPage {
  const _PlacePostsPage({ List<PlacePostApi> data = const <PlacePostApi>[], required this.meta}): _data = data;
  factory _PlacePostsPage.fromJson(Map<String, dynamic> json) => _$PlacePostsPageFromJson(json);

 final  List<PlacePostApi> _data;
@override@JsonKey() List<PlacePostApi> get data {
  if (_data is EqualUnmodifiableListView) return _data;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_data);
}

@override final  PlacePageMeta meta;

/// Create a copy of PlacePostsPage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlacePostsPageCopyWith<_PlacePostsPage> get copyWith => __$PlacePostsPageCopyWithImpl<_PlacePostsPage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlacePostsPageToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlacePostsPage&&const DeepCollectionEquality().equals(other.data, _data)&&(identical(other.meta, meta) || other.meta == meta));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_data),meta);
}

@override
String toString() {
    return 'PlacePostsPage(data: $data, meta: $meta)';
}


}

/// @nodoc
abstract mixin class _$PlacePostsPageCopyWith<$Res> implements $PlacePostsPageCopyWith<$Res> {
  factory _$PlacePostsPageCopyWith(_PlacePostsPage value, $Res Function(_PlacePostsPage) _then) = __$PlacePostsPageCopyWithImpl;
@override @useResult
$Res call({
 List<PlacePostApi> data, PlacePageMeta meta
});


@override $PlacePageMetaCopyWith<$Res> get meta;

}
/// @nodoc
class __$PlacePostsPageCopyWithImpl<$Res>
    implements _$PlacePostsPageCopyWith<$Res> {
  __$PlacePostsPageCopyWithImpl(this._self, this._then);

  final _PlacePostsPage _self;
  final $Res Function(_PlacePostsPage) _then;

/// Create a copy of PlacePostsPage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? data = null,Object? meta = null,}) {
  return _then(_PlacePostsPage(
data: null == data ? _self._data : data // ignore: cast_nullable_to_non_nullable
as List<PlacePostApi>,meta: null == meta ? _self.meta : meta // ignore: cast_nullable_to_non_nullable
as PlacePageMeta,
  ));
}

/// Create a copy of PlacePostsPage
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlacePageMetaCopyWith<$Res> get meta {
  
  return $PlacePageMetaCopyWith<$Res>(_self.meta, (value) {
    return _then(_self.copyWith(meta: value));
  });
}
}

// dart format on
