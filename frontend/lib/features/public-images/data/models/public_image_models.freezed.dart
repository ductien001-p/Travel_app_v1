// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'public_image_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PublicImageAlbum {

 String get id; String get title; String get tripTitle; List<PublicImageItem> get images;
/// Create a copy of PublicImageAlbum
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PublicImageAlbumCopyWith<PublicImageAlbum> get copyWith => _$PublicImageAlbumCopyWithImpl<PublicImageAlbum>(this as PublicImageAlbum, _$identity);

  /// Serializes this PublicImageAlbum to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as PublicImageAlbum;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PublicImageAlbum&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.tripTitle, _this.tripTitle) || other.tripTitle == _this.tripTitle)&&const DeepCollectionEquality().equals(other.images, _this.images));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as PublicImageAlbum;
  return Object.hash(runtimeType,_this.id,_this.title,_this.tripTitle,const DeepCollectionEquality().hash(_this.images));
}

@override
String toString() {
  final _this = this as PublicImageAlbum;
  return 'PublicImageAlbum(id: ${_this.id}, title: ${_this.title}, tripTitle: ${_this.tripTitle}, images: ${_this.images})';
}


}

/// @nodoc
abstract mixin class $PublicImageAlbumCopyWith<$Res>  {
  factory $PublicImageAlbumCopyWith(PublicImageAlbum value, $Res Function(PublicImageAlbum) _then) = _$PublicImageAlbumCopyWithImpl;
@useResult
$Res call({
 String id, String title, String tripTitle, List<PublicImageItem> images
});




}
/// @nodoc
class _$PublicImageAlbumCopyWithImpl<$Res>
    implements $PublicImageAlbumCopyWith<$Res> {
  _$PublicImageAlbumCopyWithImpl(this._self, this._then);

  final PublicImageAlbum _self;
  final $Res Function(PublicImageAlbum) _then;

/// Create a copy of PublicImageAlbum
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? tripTitle = null,Object? images = null,}) {
  return _then(PublicImageAlbum(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,tripTitle: null == tripTitle ? _self.tripTitle : tripTitle // ignore: cast_nullable_to_non_nullable
as String,images: null == images ? _self.images : images // ignore: cast_nullable_to_non_nullable
as List<PublicImageItem>,
  ));
}

}


/// Adds pattern-matching-related methods to [PublicImageAlbum].
extension PublicImageAlbumPatterns on PublicImageAlbum {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PublicImageAlbum value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PublicImageAlbum() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PublicImageAlbum value)  $default,){
final _that = this;
switch (_that) {
case _PublicImageAlbum():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PublicImageAlbum value)?  $default,){
final _that = this;
switch (_that) {
case _PublicImageAlbum() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String tripTitle,  List<PublicImageItem> images)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PublicImageAlbum() when $default != null:
return $default(_that.id,_that.title,_that.tripTitle,_that.images);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String tripTitle,  List<PublicImageItem> images)  $default,) {final _that = this;
switch (_that) {
case _PublicImageAlbum():
return $default(_that.id,_that.title,_that.tripTitle,_that.images);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String tripTitle,  List<PublicImageItem> images)?  $default,) {final _that = this;
switch (_that) {
case _PublicImageAlbum() when $default != null:
return $default(_that.id,_that.title,_that.tripTitle,_that.images);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PublicImageAlbum implements PublicImageAlbum {
  const _PublicImageAlbum({required this.id, required this.title, this.tripTitle = 'Chuyến đi',  List<PublicImageItem> images = const <PublicImageItem>[]}): _images = images;
  factory _PublicImageAlbum.fromJson(Map<String, dynamic> json) => _$PublicImageAlbumFromJson(json);

@override final  String id;
@override final  String title;
@override@JsonKey() final  String tripTitle;
 final  List<PublicImageItem> _images;
@override@JsonKey() List<PublicImageItem> get images {
  if (_images is EqualUnmodifiableListView) return _images;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_images);
}


/// Create a copy of PublicImageAlbum
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PublicImageAlbumCopyWith<_PublicImageAlbum> get copyWith => __$PublicImageAlbumCopyWithImpl<_PublicImageAlbum>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PublicImageAlbumToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PublicImageAlbum&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.tripTitle, tripTitle) || other.tripTitle == tripTitle)&&const DeepCollectionEquality().equals(other.images, _images));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,title,tripTitle,const DeepCollectionEquality().hash(_images));
}

@override
String toString() {
    return 'PublicImageAlbum(id: $id, title: $title, tripTitle: $tripTitle, images: $images)';
}


}

/// @nodoc
abstract mixin class _$PublicImageAlbumCopyWith<$Res> implements $PublicImageAlbumCopyWith<$Res> {
  factory _$PublicImageAlbumCopyWith(_PublicImageAlbum value, $Res Function(_PublicImageAlbum) _then) = __$PublicImageAlbumCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String tripTitle, List<PublicImageItem> images
});




}
/// @nodoc
class __$PublicImageAlbumCopyWithImpl<$Res>
    implements _$PublicImageAlbumCopyWith<$Res> {
  __$PublicImageAlbumCopyWithImpl(this._self, this._then);

  final _PublicImageAlbum _self;
  final $Res Function(_PublicImageAlbum) _then;

/// Create a copy of PublicImageAlbum
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? tripTitle = null,Object? images = null,}) {
  return _then(_PublicImageAlbum(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,tripTitle: null == tripTitle ? _self.tripTitle : tripTitle // ignore: cast_nullable_to_non_nullable
as String,images: null == images ? _self._images : images // ignore: cast_nullable_to_non_nullable
as List<PublicImageItem>,
  ));
}


}


/// @nodoc
mixin _$PublicImageItem {

 String get id; String get imageUrl; String? get thumbnailUrl; String? get caption; String? get cityLabel; String? get locationLabel; String? get locationShortLabel; String? get placeCategoryLabel; String? get regionLabel; String? get countryLabel; double? get latitude; double? get longitude; double? get altitudeMeters; DateTime? get capturedAt; String? get clockLabel; String? get exifSummary; String? get resolutionLabel; String? get shareUrl; int get likeCount; int get commentCount; bool get likedByMe; bool get canSetAsCover; bool get canDelete;
/// Create a copy of PublicImageItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PublicImageItemCopyWith<PublicImageItem> get copyWith => _$PublicImageItemCopyWithImpl<PublicImageItem>(this as PublicImageItem, _$identity);

  /// Serializes this PublicImageItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as PublicImageItem;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PublicImageItem&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.imageUrl, _this.imageUrl) || other.imageUrl == _this.imageUrl)&&(identical(other.thumbnailUrl, _this.thumbnailUrl) || other.thumbnailUrl == _this.thumbnailUrl)&&(identical(other.caption, _this.caption) || other.caption == _this.caption)&&(identical(other.cityLabel, _this.cityLabel) || other.cityLabel == _this.cityLabel)&&(identical(other.locationLabel, _this.locationLabel) || other.locationLabel == _this.locationLabel)&&(identical(other.locationShortLabel, _this.locationShortLabel) || other.locationShortLabel == _this.locationShortLabel)&&(identical(other.placeCategoryLabel, _this.placeCategoryLabel) || other.placeCategoryLabel == _this.placeCategoryLabel)&&(identical(other.regionLabel, _this.regionLabel) || other.regionLabel == _this.regionLabel)&&(identical(other.countryLabel, _this.countryLabel) || other.countryLabel == _this.countryLabel)&&(identical(other.latitude, _this.latitude) || other.latitude == _this.latitude)&&(identical(other.longitude, _this.longitude) || other.longitude == _this.longitude)&&(identical(other.altitudeMeters, _this.altitudeMeters) || other.altitudeMeters == _this.altitudeMeters)&&(identical(other.capturedAt, _this.capturedAt) || other.capturedAt == _this.capturedAt)&&(identical(other.clockLabel, _this.clockLabel) || other.clockLabel == _this.clockLabel)&&(identical(other.exifSummary, _this.exifSummary) || other.exifSummary == _this.exifSummary)&&(identical(other.resolutionLabel, _this.resolutionLabel) || other.resolutionLabel == _this.resolutionLabel)&&(identical(other.shareUrl, _this.shareUrl) || other.shareUrl == _this.shareUrl)&&(identical(other.likeCount, _this.likeCount) || other.likeCount == _this.likeCount)&&(identical(other.commentCount, _this.commentCount) || other.commentCount == _this.commentCount)&&(identical(other.likedByMe, _this.likedByMe) || other.likedByMe == _this.likedByMe)&&(identical(other.canSetAsCover, _this.canSetAsCover) || other.canSetAsCover == _this.canSetAsCover)&&(identical(other.canDelete, _this.canDelete) || other.canDelete == _this.canDelete));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as PublicImageItem;
  return Object.hashAll([runtimeType,_this.id,_this.imageUrl,_this.thumbnailUrl,_this.caption,_this.cityLabel,_this.locationLabel,_this.locationShortLabel,_this.placeCategoryLabel,_this.regionLabel,_this.countryLabel,_this.latitude,_this.longitude,_this.altitudeMeters,_this.capturedAt,_this.clockLabel,_this.exifSummary,_this.resolutionLabel,_this.shareUrl,_this.likeCount,_this.commentCount,_this.likedByMe,_this.canSetAsCover,_this.canDelete]);
}

@override
String toString() {
  final _this = this as PublicImageItem;
  return 'PublicImageItem(id: ${_this.id}, imageUrl: ${_this.imageUrl}, thumbnailUrl: ${_this.thumbnailUrl}, caption: ${_this.caption}, cityLabel: ${_this.cityLabel}, locationLabel: ${_this.locationLabel}, locationShortLabel: ${_this.locationShortLabel}, placeCategoryLabel: ${_this.placeCategoryLabel}, regionLabel: ${_this.regionLabel}, countryLabel: ${_this.countryLabel}, latitude: ${_this.latitude}, longitude: ${_this.longitude}, altitudeMeters: ${_this.altitudeMeters}, capturedAt: ${_this.capturedAt}, clockLabel: ${_this.clockLabel}, exifSummary: ${_this.exifSummary}, resolutionLabel: ${_this.resolutionLabel}, shareUrl: ${_this.shareUrl}, likeCount: ${_this.likeCount}, commentCount: ${_this.commentCount}, likedByMe: ${_this.likedByMe}, canSetAsCover: ${_this.canSetAsCover}, canDelete: ${_this.canDelete})';
}


}

/// @nodoc
abstract mixin class $PublicImageItemCopyWith<$Res>  {
  factory $PublicImageItemCopyWith(PublicImageItem value, $Res Function(PublicImageItem) _then) = _$PublicImageItemCopyWithImpl;
@useResult
$Res call({
 String id, String imageUrl, String? thumbnailUrl, String? caption, String? cityLabel, String? locationLabel, String? locationShortLabel, String? placeCategoryLabel, String? regionLabel, String? countryLabel, double? latitude, double? longitude, double? altitudeMeters, DateTime? capturedAt, String? clockLabel, String? exifSummary, String? resolutionLabel, String? shareUrl, int likeCount, int commentCount, bool likedByMe, bool canSetAsCover, bool canDelete
});




}
/// @nodoc
class _$PublicImageItemCopyWithImpl<$Res>
    implements $PublicImageItemCopyWith<$Res> {
  _$PublicImageItemCopyWithImpl(this._self, this._then);

  final PublicImageItem _self;
  final $Res Function(PublicImageItem) _then;

/// Create a copy of PublicImageItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? imageUrl = null,Object? thumbnailUrl = freezed,Object? caption = freezed,Object? cityLabel = freezed,Object? locationLabel = freezed,Object? locationShortLabel = freezed,Object? placeCategoryLabel = freezed,Object? regionLabel = freezed,Object? countryLabel = freezed,Object? latitude = freezed,Object? longitude = freezed,Object? altitudeMeters = freezed,Object? capturedAt = freezed,Object? clockLabel = freezed,Object? exifSummary = freezed,Object? resolutionLabel = freezed,Object? shareUrl = freezed,Object? likeCount = null,Object? commentCount = null,Object? likedByMe = null,Object? canSetAsCover = null,Object? canDelete = null,}) {
  return _then(PublicImageItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,thumbnailUrl: freezed == thumbnailUrl ? _self.thumbnailUrl : thumbnailUrl // ignore: cast_nullable_to_non_nullable
as String?,caption: freezed == caption ? _self.caption : caption // ignore: cast_nullable_to_non_nullable
as String?,cityLabel: freezed == cityLabel ? _self.cityLabel : cityLabel // ignore: cast_nullable_to_non_nullable
as String?,locationLabel: freezed == locationLabel ? _self.locationLabel : locationLabel // ignore: cast_nullable_to_non_nullable
as String?,locationShortLabel: freezed == locationShortLabel ? _self.locationShortLabel : locationShortLabel // ignore: cast_nullable_to_non_nullable
as String?,placeCategoryLabel: freezed == placeCategoryLabel ? _self.placeCategoryLabel : placeCategoryLabel // ignore: cast_nullable_to_non_nullable
as String?,regionLabel: freezed == regionLabel ? _self.regionLabel : regionLabel // ignore: cast_nullable_to_non_nullable
as String?,countryLabel: freezed == countryLabel ? _self.countryLabel : countryLabel // ignore: cast_nullable_to_non_nullable
as String?,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,altitudeMeters: freezed == altitudeMeters ? _self.altitudeMeters : altitudeMeters // ignore: cast_nullable_to_non_nullable
as double?,capturedAt: freezed == capturedAt ? _self.capturedAt : capturedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,clockLabel: freezed == clockLabel ? _self.clockLabel : clockLabel // ignore: cast_nullable_to_non_nullable
as String?,exifSummary: freezed == exifSummary ? _self.exifSummary : exifSummary // ignore: cast_nullable_to_non_nullable
as String?,resolutionLabel: freezed == resolutionLabel ? _self.resolutionLabel : resolutionLabel // ignore: cast_nullable_to_non_nullable
as String?,shareUrl: freezed == shareUrl ? _self.shareUrl : shareUrl // ignore: cast_nullable_to_non_nullable
as String?,likeCount: null == likeCount ? _self.likeCount : likeCount // ignore: cast_nullable_to_non_nullable
as int,commentCount: null == commentCount ? _self.commentCount : commentCount // ignore: cast_nullable_to_non_nullable
as int,likedByMe: null == likedByMe ? _self.likedByMe : likedByMe // ignore: cast_nullable_to_non_nullable
as bool,canSetAsCover: null == canSetAsCover ? _self.canSetAsCover : canSetAsCover // ignore: cast_nullable_to_non_nullable
as bool,canDelete: null == canDelete ? _self.canDelete : canDelete // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [PublicImageItem].
extension PublicImageItemPatterns on PublicImageItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PublicImageItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PublicImageItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PublicImageItem value)  $default,){
final _that = this;
switch (_that) {
case _PublicImageItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PublicImageItem value)?  $default,){
final _that = this;
switch (_that) {
case _PublicImageItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String imageUrl,  String? thumbnailUrl,  String? caption,  String? cityLabel,  String? locationLabel,  String? locationShortLabel,  String? placeCategoryLabel,  String? regionLabel,  String? countryLabel,  double? latitude,  double? longitude,  double? altitudeMeters,  DateTime? capturedAt,  String? clockLabel,  String? exifSummary,  String? resolutionLabel,  String? shareUrl,  int likeCount,  int commentCount,  bool likedByMe,  bool canSetAsCover,  bool canDelete)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PublicImageItem() when $default != null:
return $default(_that.id,_that.imageUrl,_that.thumbnailUrl,_that.caption,_that.cityLabel,_that.locationLabel,_that.locationShortLabel,_that.placeCategoryLabel,_that.regionLabel,_that.countryLabel,_that.latitude,_that.longitude,_that.altitudeMeters,_that.capturedAt,_that.clockLabel,_that.exifSummary,_that.resolutionLabel,_that.shareUrl,_that.likeCount,_that.commentCount,_that.likedByMe,_that.canSetAsCover,_that.canDelete);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String imageUrl,  String? thumbnailUrl,  String? caption,  String? cityLabel,  String? locationLabel,  String? locationShortLabel,  String? placeCategoryLabel,  String? regionLabel,  String? countryLabel,  double? latitude,  double? longitude,  double? altitudeMeters,  DateTime? capturedAt,  String? clockLabel,  String? exifSummary,  String? resolutionLabel,  String? shareUrl,  int likeCount,  int commentCount,  bool likedByMe,  bool canSetAsCover,  bool canDelete)  $default,) {final _that = this;
switch (_that) {
case _PublicImageItem():
return $default(_that.id,_that.imageUrl,_that.thumbnailUrl,_that.caption,_that.cityLabel,_that.locationLabel,_that.locationShortLabel,_that.placeCategoryLabel,_that.regionLabel,_that.countryLabel,_that.latitude,_that.longitude,_that.altitudeMeters,_that.capturedAt,_that.clockLabel,_that.exifSummary,_that.resolutionLabel,_that.shareUrl,_that.likeCount,_that.commentCount,_that.likedByMe,_that.canSetAsCover,_that.canDelete);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String imageUrl,  String? thumbnailUrl,  String? caption,  String? cityLabel,  String? locationLabel,  String? locationShortLabel,  String? placeCategoryLabel,  String? regionLabel,  String? countryLabel,  double? latitude,  double? longitude,  double? altitudeMeters,  DateTime? capturedAt,  String? clockLabel,  String? exifSummary,  String? resolutionLabel,  String? shareUrl,  int likeCount,  int commentCount,  bool likedByMe,  bool canSetAsCover,  bool canDelete)?  $default,) {final _that = this;
switch (_that) {
case _PublicImageItem() when $default != null:
return $default(_that.id,_that.imageUrl,_that.thumbnailUrl,_that.caption,_that.cityLabel,_that.locationLabel,_that.locationShortLabel,_that.placeCategoryLabel,_that.regionLabel,_that.countryLabel,_that.latitude,_that.longitude,_that.altitudeMeters,_that.capturedAt,_that.clockLabel,_that.exifSummary,_that.resolutionLabel,_that.shareUrl,_that.likeCount,_that.commentCount,_that.likedByMe,_that.canSetAsCover,_that.canDelete);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PublicImageItem implements PublicImageItem {
  const _PublicImageItem({required this.id, required this.imageUrl, this.thumbnailUrl, this.caption, this.cityLabel, this.locationLabel, this.locationShortLabel, this.placeCategoryLabel, this.regionLabel, this.countryLabel, this.latitude, this.longitude, this.altitudeMeters, this.capturedAt, this.clockLabel, this.exifSummary, this.resolutionLabel, this.shareUrl, this.likeCount = 0, this.commentCount = 0, this.likedByMe = false, this.canSetAsCover = true, this.canDelete = true});
  factory _PublicImageItem.fromJson(Map<String, dynamic> json) => _$PublicImageItemFromJson(json);

@override final  String id;
@override final  String imageUrl;
@override final  String? thumbnailUrl;
@override final  String? caption;
@override final  String? cityLabel;
@override final  String? locationLabel;
@override final  String? locationShortLabel;
@override final  String? placeCategoryLabel;
@override final  String? regionLabel;
@override final  String? countryLabel;
@override final  double? latitude;
@override final  double? longitude;
@override final  double? altitudeMeters;
@override final  DateTime? capturedAt;
@override final  String? clockLabel;
@override final  String? exifSummary;
@override final  String? resolutionLabel;
@override final  String? shareUrl;
@override@JsonKey() final  int likeCount;
@override@JsonKey() final  int commentCount;
@override@JsonKey() final  bool likedByMe;
@override@JsonKey() final  bool canSetAsCover;
@override@JsonKey() final  bool canDelete;

/// Create a copy of PublicImageItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PublicImageItemCopyWith<_PublicImageItem> get copyWith => __$PublicImageItemCopyWithImpl<_PublicImageItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PublicImageItemToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PublicImageItem&&(identical(other.id, id) || other.id == id)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.thumbnailUrl, thumbnailUrl) || other.thumbnailUrl == thumbnailUrl)&&(identical(other.caption, caption) || other.caption == caption)&&(identical(other.cityLabel, cityLabel) || other.cityLabel == cityLabel)&&(identical(other.locationLabel, locationLabel) || other.locationLabel == locationLabel)&&(identical(other.locationShortLabel, locationShortLabel) || other.locationShortLabel == locationShortLabel)&&(identical(other.placeCategoryLabel, placeCategoryLabel) || other.placeCategoryLabel == placeCategoryLabel)&&(identical(other.regionLabel, regionLabel) || other.regionLabel == regionLabel)&&(identical(other.countryLabel, countryLabel) || other.countryLabel == countryLabel)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.altitudeMeters, altitudeMeters) || other.altitudeMeters == altitudeMeters)&&(identical(other.capturedAt, capturedAt) || other.capturedAt == capturedAt)&&(identical(other.clockLabel, clockLabel) || other.clockLabel == clockLabel)&&(identical(other.exifSummary, exifSummary) || other.exifSummary == exifSummary)&&(identical(other.resolutionLabel, resolutionLabel) || other.resolutionLabel == resolutionLabel)&&(identical(other.shareUrl, shareUrl) || other.shareUrl == shareUrl)&&(identical(other.likeCount, likeCount) || other.likeCount == likeCount)&&(identical(other.commentCount, commentCount) || other.commentCount == commentCount)&&(identical(other.likedByMe, likedByMe) || other.likedByMe == likedByMe)&&(identical(other.canSetAsCover, canSetAsCover) || other.canSetAsCover == canSetAsCover)&&(identical(other.canDelete, canDelete) || other.canDelete == canDelete));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hashAll([runtimeType,id,imageUrl,thumbnailUrl,caption,cityLabel,locationLabel,locationShortLabel,placeCategoryLabel,regionLabel,countryLabel,latitude,longitude,altitudeMeters,capturedAt,clockLabel,exifSummary,resolutionLabel,shareUrl,likeCount,commentCount,likedByMe,canSetAsCover,canDelete]);
}

@override
String toString() {
    return 'PublicImageItem(id: $id, imageUrl: $imageUrl, thumbnailUrl: $thumbnailUrl, caption: $caption, cityLabel: $cityLabel, locationLabel: $locationLabel, locationShortLabel: $locationShortLabel, placeCategoryLabel: $placeCategoryLabel, regionLabel: $regionLabel, countryLabel: $countryLabel, latitude: $latitude, longitude: $longitude, altitudeMeters: $altitudeMeters, capturedAt: $capturedAt, clockLabel: $clockLabel, exifSummary: $exifSummary, resolutionLabel: $resolutionLabel, shareUrl: $shareUrl, likeCount: $likeCount, commentCount: $commentCount, likedByMe: $likedByMe, canSetAsCover: $canSetAsCover, canDelete: $canDelete)';
}


}

/// @nodoc
abstract mixin class _$PublicImageItemCopyWith<$Res> implements $PublicImageItemCopyWith<$Res> {
  factory _$PublicImageItemCopyWith(_PublicImageItem value, $Res Function(_PublicImageItem) _then) = __$PublicImageItemCopyWithImpl;
@override @useResult
$Res call({
 String id, String imageUrl, String? thumbnailUrl, String? caption, String? cityLabel, String? locationLabel, String? locationShortLabel, String? placeCategoryLabel, String? regionLabel, String? countryLabel, double? latitude, double? longitude, double? altitudeMeters, DateTime? capturedAt, String? clockLabel, String? exifSummary, String? resolutionLabel, String? shareUrl, int likeCount, int commentCount, bool likedByMe, bool canSetAsCover, bool canDelete
});




}
/// @nodoc
class __$PublicImageItemCopyWithImpl<$Res>
    implements _$PublicImageItemCopyWith<$Res> {
  __$PublicImageItemCopyWithImpl(this._self, this._then);

  final _PublicImageItem _self;
  final $Res Function(_PublicImageItem) _then;

/// Create a copy of PublicImageItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? imageUrl = null,Object? thumbnailUrl = freezed,Object? caption = freezed,Object? cityLabel = freezed,Object? locationLabel = freezed,Object? locationShortLabel = freezed,Object? placeCategoryLabel = freezed,Object? regionLabel = freezed,Object? countryLabel = freezed,Object? latitude = freezed,Object? longitude = freezed,Object? altitudeMeters = freezed,Object? capturedAt = freezed,Object? clockLabel = freezed,Object? exifSummary = freezed,Object? resolutionLabel = freezed,Object? shareUrl = freezed,Object? likeCount = null,Object? commentCount = null,Object? likedByMe = null,Object? canSetAsCover = null,Object? canDelete = null,}) {
  return _then(_PublicImageItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,thumbnailUrl: freezed == thumbnailUrl ? _self.thumbnailUrl : thumbnailUrl // ignore: cast_nullable_to_non_nullable
as String?,caption: freezed == caption ? _self.caption : caption // ignore: cast_nullable_to_non_nullable
as String?,cityLabel: freezed == cityLabel ? _self.cityLabel : cityLabel // ignore: cast_nullable_to_non_nullable
as String?,locationLabel: freezed == locationLabel ? _self.locationLabel : locationLabel // ignore: cast_nullable_to_non_nullable
as String?,locationShortLabel: freezed == locationShortLabel ? _self.locationShortLabel : locationShortLabel // ignore: cast_nullable_to_non_nullable
as String?,placeCategoryLabel: freezed == placeCategoryLabel ? _self.placeCategoryLabel : placeCategoryLabel // ignore: cast_nullable_to_non_nullable
as String?,regionLabel: freezed == regionLabel ? _self.regionLabel : regionLabel // ignore: cast_nullable_to_non_nullable
as String?,countryLabel: freezed == countryLabel ? _self.countryLabel : countryLabel // ignore: cast_nullable_to_non_nullable
as String?,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,altitudeMeters: freezed == altitudeMeters ? _self.altitudeMeters : altitudeMeters // ignore: cast_nullable_to_non_nullable
as double?,capturedAt: freezed == capturedAt ? _self.capturedAt : capturedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,clockLabel: freezed == clockLabel ? _self.clockLabel : clockLabel // ignore: cast_nullable_to_non_nullable
as String?,exifSummary: freezed == exifSummary ? _self.exifSummary : exifSummary // ignore: cast_nullable_to_non_nullable
as String?,resolutionLabel: freezed == resolutionLabel ? _self.resolutionLabel : resolutionLabel // ignore: cast_nullable_to_non_nullable
as String?,shareUrl: freezed == shareUrl ? _self.shareUrl : shareUrl // ignore: cast_nullable_to_non_nullable
as String?,likeCount: null == likeCount ? _self.likeCount : likeCount // ignore: cast_nullable_to_non_nullable
as int,commentCount: null == commentCount ? _self.commentCount : commentCount // ignore: cast_nullable_to_non_nullable
as int,likedByMe: null == likedByMe ? _self.likedByMe : likedByMe // ignore: cast_nullable_to_non_nullable
as bool,canSetAsCover: null == canSetAsCover ? _self.canSetAsCover : canSetAsCover // ignore: cast_nullable_to_non_nullable
as bool,canDelete: null == canDelete ? _self.canDelete : canDelete // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
