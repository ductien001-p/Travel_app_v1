// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'social_post_detail_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SocialPostDetail {

 String get id; String get authorId; String? get placeId; String? get caption; String get visibility; String? get tipTitle; String? get tipBody; String? get topic; String? get placeDetail;@JsonKey(fromJson: _readInt) int get likesCount;@JsonKey(fromJson: _readInt) int get commentsCount;@JsonKey(fromJson: _readInt) int get sharesCount;@JsonKey(fromJson: _readInt) int get savesCount;@JsonKey(fromJson: _readDateTime) DateTime get createdAt; SocialPostDetailAuthor get author; SocialPostDetailPlace? get place; List<SocialPostDetailMedia> get postMedias; bool get liked; bool get shared; bool get bookmarked; String? get trendLabel; String get timeLabel;
/// Create a copy of SocialPostDetail
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SocialPostDetailCopyWith<SocialPostDetail> get copyWith => _$SocialPostDetailCopyWithImpl<SocialPostDetail>(this as SocialPostDetail, _$identity);

  /// Serializes this SocialPostDetail to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SocialPostDetail;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SocialPostDetail&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.authorId, _this.authorId) || other.authorId == _this.authorId)&&(identical(other.placeId, _this.placeId) || other.placeId == _this.placeId)&&(identical(other.caption, _this.caption) || other.caption == _this.caption)&&(identical(other.visibility, _this.visibility) || other.visibility == _this.visibility)&&(identical(other.tipTitle, _this.tipTitle) || other.tipTitle == _this.tipTitle)&&(identical(other.tipBody, _this.tipBody) || other.tipBody == _this.tipBody)&&(identical(other.topic, _this.topic) || other.topic == _this.topic)&&(identical(other.placeDetail, _this.placeDetail) || other.placeDetail == _this.placeDetail)&&(identical(other.likesCount, _this.likesCount) || other.likesCount == _this.likesCount)&&(identical(other.commentsCount, _this.commentsCount) || other.commentsCount == _this.commentsCount)&&(identical(other.sharesCount, _this.sharesCount) || other.sharesCount == _this.sharesCount)&&(identical(other.savesCount, _this.savesCount) || other.savesCount == _this.savesCount)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.author, _this.author) || other.author == _this.author)&&(identical(other.place, _this.place) || other.place == _this.place)&&const DeepCollectionEquality().equals(other.postMedias, _this.postMedias)&&(identical(other.liked, _this.liked) || other.liked == _this.liked)&&(identical(other.shared, _this.shared) || other.shared == _this.shared)&&(identical(other.bookmarked, _this.bookmarked) || other.bookmarked == _this.bookmarked)&&(identical(other.trendLabel, _this.trendLabel) || other.trendLabel == _this.trendLabel)&&(identical(other.timeLabel, _this.timeLabel) || other.timeLabel == _this.timeLabel));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SocialPostDetail;
  return Object.hashAll([runtimeType,_this.id,_this.authorId,_this.placeId,_this.caption,_this.visibility,_this.tipTitle,_this.tipBody,_this.topic,_this.placeDetail,_this.likesCount,_this.commentsCount,_this.sharesCount,_this.savesCount,_this.createdAt,_this.author,_this.place,const DeepCollectionEquality().hash(_this.postMedias),_this.liked,_this.shared,_this.bookmarked,_this.trendLabel,_this.timeLabel]);
}

@override
String toString() {
  final _this = this as SocialPostDetail;
  return 'SocialPostDetail(id: ${_this.id}, authorId: ${_this.authorId}, placeId: ${_this.placeId}, caption: ${_this.caption}, visibility: ${_this.visibility}, tipTitle: ${_this.tipTitle}, tipBody: ${_this.tipBody}, topic: ${_this.topic}, placeDetail: ${_this.placeDetail}, likesCount: ${_this.likesCount}, commentsCount: ${_this.commentsCount}, sharesCount: ${_this.sharesCount}, savesCount: ${_this.savesCount}, createdAt: ${_this.createdAt}, author: ${_this.author}, place: ${_this.place}, postMedias: ${_this.postMedias}, liked: ${_this.liked}, shared: ${_this.shared}, bookmarked: ${_this.bookmarked}, trendLabel: ${_this.trendLabel}, timeLabel: ${_this.timeLabel})';
}


}

/// @nodoc
abstract mixin class $SocialPostDetailCopyWith<$Res>  {
  factory $SocialPostDetailCopyWith(SocialPostDetail value, $Res Function(SocialPostDetail) _then) = _$SocialPostDetailCopyWithImpl;
@useResult
$Res call({
 String id, String authorId, String? placeId, String? caption, String visibility, String? tipTitle, String? tipBody, String? topic, String? placeDetail,@JsonKey(fromJson: _readInt) int likesCount,@JsonKey(fromJson: _readInt) int commentsCount,@JsonKey(fromJson: _readInt) int sharesCount,@JsonKey(fromJson: _readInt) int savesCount,@JsonKey(fromJson: _readDateTime) DateTime createdAt, SocialPostDetailAuthor author, SocialPostDetailPlace? place, List<SocialPostDetailMedia> postMedias, bool liked, bool shared, bool bookmarked, String? trendLabel, String timeLabel
});


$SocialPostDetailAuthorCopyWith<$Res> get author;$SocialPostDetailPlaceCopyWith<$Res>? get place;

}
/// @nodoc
class _$SocialPostDetailCopyWithImpl<$Res>
    implements $SocialPostDetailCopyWith<$Res> {
  _$SocialPostDetailCopyWithImpl(this._self, this._then);

  final SocialPostDetail _self;
  final $Res Function(SocialPostDetail) _then;

/// Create a copy of SocialPostDetail
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? authorId = null,Object? placeId = freezed,Object? caption = freezed,Object? visibility = null,Object? tipTitle = freezed,Object? tipBody = freezed,Object? topic = freezed,Object? placeDetail = freezed,Object? likesCount = null,Object? commentsCount = null,Object? sharesCount = null,Object? savesCount = null,Object? createdAt = null,Object? author = null,Object? place = freezed,Object? postMedias = null,Object? liked = null,Object? shared = null,Object? bookmarked = null,Object? trendLabel = freezed,Object? timeLabel = null,}) {
  return _then(SocialPostDetail(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,authorId: null == authorId ? _self.authorId : authorId // ignore: cast_nullable_to_non_nullable
as String,placeId: freezed == placeId ? _self.placeId : placeId // ignore: cast_nullable_to_non_nullable
as String?,caption: freezed == caption ? _self.caption : caption // ignore: cast_nullable_to_non_nullable
as String?,visibility: null == visibility ? _self.visibility : visibility // ignore: cast_nullable_to_non_nullable
as String,tipTitle: freezed == tipTitle ? _self.tipTitle : tipTitle // ignore: cast_nullable_to_non_nullable
as String?,tipBody: freezed == tipBody ? _self.tipBody : tipBody // ignore: cast_nullable_to_non_nullable
as String?,topic: freezed == topic ? _self.topic : topic // ignore: cast_nullable_to_non_nullable
as String?,placeDetail: freezed == placeDetail ? _self.placeDetail : placeDetail // ignore: cast_nullable_to_non_nullable
as String?,likesCount: null == likesCount ? _self.likesCount : likesCount // ignore: cast_nullable_to_non_nullable
as int,commentsCount: null == commentsCount ? _self.commentsCount : commentsCount // ignore: cast_nullable_to_non_nullable
as int,sharesCount: null == sharesCount ? _self.sharesCount : sharesCount // ignore: cast_nullable_to_non_nullable
as int,savesCount: null == savesCount ? _self.savesCount : savesCount // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,author: null == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as SocialPostDetailAuthor,place: freezed == place ? _self.place : place // ignore: cast_nullable_to_non_nullable
as SocialPostDetailPlace?,postMedias: null == postMedias ? _self.postMedias : postMedias // ignore: cast_nullable_to_non_nullable
as List<SocialPostDetailMedia>,liked: null == liked ? _self.liked : liked // ignore: cast_nullable_to_non_nullable
as bool,shared: null == shared ? _self.shared : shared // ignore: cast_nullable_to_non_nullable
as bool,bookmarked: null == bookmarked ? _self.bookmarked : bookmarked // ignore: cast_nullable_to_non_nullable
as bool,trendLabel: freezed == trendLabel ? _self.trendLabel : trendLabel // ignore: cast_nullable_to_non_nullable
as String?,timeLabel: null == timeLabel ? _self.timeLabel : timeLabel // ignore: cast_nullable_to_non_nullable
as String,
  ));
}
/// Create a copy of SocialPostDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SocialPostDetailAuthorCopyWith<$Res> get author {
  
  return $SocialPostDetailAuthorCopyWith<$Res>(_self.author, (value) {
    return _then(_self.copyWith(author: value));
  });
}/// Create a copy of SocialPostDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SocialPostDetailPlaceCopyWith<$Res>? get place {
    if (_self.place == null) {
    return null;
  }

  return $SocialPostDetailPlaceCopyWith<$Res>(_self.place!, (value) {
    return _then(_self.copyWith(place: value));
  });
}
}


/// Adds pattern-matching-related methods to [SocialPostDetail].
extension SocialPostDetailPatterns on SocialPostDetail {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SocialPostDetail value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SocialPostDetail() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SocialPostDetail value)  $default,){
final _that = this;
switch (_that) {
case _SocialPostDetail():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SocialPostDetail value)?  $default,){
final _that = this;
switch (_that) {
case _SocialPostDetail() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String authorId,  String? placeId,  String? caption,  String visibility,  String? tipTitle,  String? tipBody,  String? topic,  String? placeDetail, @JsonKey(fromJson: _readInt)  int likesCount, @JsonKey(fromJson: _readInt)  int commentsCount, @JsonKey(fromJson: _readInt)  int sharesCount, @JsonKey(fromJson: _readInt)  int savesCount, @JsonKey(fromJson: _readDateTime)  DateTime createdAt,  SocialPostDetailAuthor author,  SocialPostDetailPlace? place,  List<SocialPostDetailMedia> postMedias,  bool liked,  bool shared,  bool bookmarked,  String? trendLabel,  String timeLabel)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SocialPostDetail() when $default != null:
return $default(_that.id,_that.authorId,_that.placeId,_that.caption,_that.visibility,_that.tipTitle,_that.tipBody,_that.topic,_that.placeDetail,_that.likesCount,_that.commentsCount,_that.sharesCount,_that.savesCount,_that.createdAt,_that.author,_that.place,_that.postMedias,_that.liked,_that.shared,_that.bookmarked,_that.trendLabel,_that.timeLabel);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String authorId,  String? placeId,  String? caption,  String visibility,  String? tipTitle,  String? tipBody,  String? topic,  String? placeDetail, @JsonKey(fromJson: _readInt)  int likesCount, @JsonKey(fromJson: _readInt)  int commentsCount, @JsonKey(fromJson: _readInt)  int sharesCount, @JsonKey(fromJson: _readInt)  int savesCount, @JsonKey(fromJson: _readDateTime)  DateTime createdAt,  SocialPostDetailAuthor author,  SocialPostDetailPlace? place,  List<SocialPostDetailMedia> postMedias,  bool liked,  bool shared,  bool bookmarked,  String? trendLabel,  String timeLabel)  $default,) {final _that = this;
switch (_that) {
case _SocialPostDetail():
return $default(_that.id,_that.authorId,_that.placeId,_that.caption,_that.visibility,_that.tipTitle,_that.tipBody,_that.topic,_that.placeDetail,_that.likesCount,_that.commentsCount,_that.sharesCount,_that.savesCount,_that.createdAt,_that.author,_that.place,_that.postMedias,_that.liked,_that.shared,_that.bookmarked,_that.trendLabel,_that.timeLabel);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String authorId,  String? placeId,  String? caption,  String visibility,  String? tipTitle,  String? tipBody,  String? topic,  String? placeDetail, @JsonKey(fromJson: _readInt)  int likesCount, @JsonKey(fromJson: _readInt)  int commentsCount, @JsonKey(fromJson: _readInt)  int sharesCount, @JsonKey(fromJson: _readInt)  int savesCount, @JsonKey(fromJson: _readDateTime)  DateTime createdAt,  SocialPostDetailAuthor author,  SocialPostDetailPlace? place,  List<SocialPostDetailMedia> postMedias,  bool liked,  bool shared,  bool bookmarked,  String? trendLabel,  String timeLabel)?  $default,) {final _that = this;
switch (_that) {
case _SocialPostDetail() when $default != null:
return $default(_that.id,_that.authorId,_that.placeId,_that.caption,_that.visibility,_that.tipTitle,_that.tipBody,_that.topic,_that.placeDetail,_that.likesCount,_that.commentsCount,_that.sharesCount,_that.savesCount,_that.createdAt,_that.author,_that.place,_that.postMedias,_that.liked,_that.shared,_that.bookmarked,_that.trendLabel,_that.timeLabel);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SocialPostDetail implements SocialPostDetail {
  const _SocialPostDetail({required this.id, required this.authorId, this.placeId, this.caption, this.visibility = 'PUBLIC', this.tipTitle, this.tipBody, this.topic, this.placeDetail, @JsonKey(fromJson: _readInt) this.likesCount = 0, @JsonKey(fromJson: _readInt) this.commentsCount = 0, @JsonKey(fromJson: _readInt) this.sharesCount = 0, @JsonKey(fromJson: _readInt) this.savesCount = 0, @JsonKey(fromJson: _readDateTime) required this.createdAt, required this.author, this.place,  List<SocialPostDetailMedia> postMedias = const <SocialPostDetailMedia>[], this.liked = false, this.shared = false, this.bookmarked = false, this.trendLabel, this.timeLabel = ''}): _postMedias = postMedias;
  factory _SocialPostDetail.fromJson(Map<String, dynamic> json) => _$SocialPostDetailFromJson(json);

@override final  String id;
@override final  String authorId;
@override final  String? placeId;
@override final  String? caption;
@override@JsonKey() final  String visibility;
@override final  String? tipTitle;
@override final  String? tipBody;
@override final  String? topic;
@override final  String? placeDetail;
@override@JsonKey(fromJson: _readInt) final  int likesCount;
@override@JsonKey(fromJson: _readInt) final  int commentsCount;
@override@JsonKey(fromJson: _readInt) final  int sharesCount;
@override@JsonKey(fromJson: _readInt) final  int savesCount;
@override@JsonKey(fromJson: _readDateTime) final  DateTime createdAt;
@override final  SocialPostDetailAuthor author;
@override final  SocialPostDetailPlace? place;
 final  List<SocialPostDetailMedia> _postMedias;
@override@JsonKey() List<SocialPostDetailMedia> get postMedias {
  if (_postMedias is EqualUnmodifiableListView) return _postMedias;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_postMedias);
}

@override@JsonKey() final  bool liked;
@override@JsonKey() final  bool shared;
@override@JsonKey() final  bool bookmarked;
@override final  String? trendLabel;
@override@JsonKey() final  String timeLabel;

/// Create a copy of SocialPostDetail
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SocialPostDetailCopyWith<_SocialPostDetail> get copyWith => __$SocialPostDetailCopyWithImpl<_SocialPostDetail>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SocialPostDetailToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SocialPostDetail&&(identical(other.id, id) || other.id == id)&&(identical(other.authorId, authorId) || other.authorId == authorId)&&(identical(other.placeId, placeId) || other.placeId == placeId)&&(identical(other.caption, caption) || other.caption == caption)&&(identical(other.visibility, visibility) || other.visibility == visibility)&&(identical(other.tipTitle, tipTitle) || other.tipTitle == tipTitle)&&(identical(other.tipBody, tipBody) || other.tipBody == tipBody)&&(identical(other.topic, topic) || other.topic == topic)&&(identical(other.placeDetail, placeDetail) || other.placeDetail == placeDetail)&&(identical(other.likesCount, likesCount) || other.likesCount == likesCount)&&(identical(other.commentsCount, commentsCount) || other.commentsCount == commentsCount)&&(identical(other.sharesCount, sharesCount) || other.sharesCount == sharesCount)&&(identical(other.savesCount, savesCount) || other.savesCount == savesCount)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.author, author) || other.author == author)&&(identical(other.place, place) || other.place == place)&&const DeepCollectionEquality().equals(other.postMedias, _postMedias)&&(identical(other.liked, liked) || other.liked == liked)&&(identical(other.shared, shared) || other.shared == shared)&&(identical(other.bookmarked, bookmarked) || other.bookmarked == bookmarked)&&(identical(other.trendLabel, trendLabel) || other.trendLabel == trendLabel)&&(identical(other.timeLabel, timeLabel) || other.timeLabel == timeLabel));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hashAll([runtimeType,id,authorId,placeId,caption,visibility,tipTitle,tipBody,topic,placeDetail,likesCount,commentsCount,sharesCount,savesCount,createdAt,author,place,const DeepCollectionEquality().hash(_postMedias),liked,shared,bookmarked,trendLabel,timeLabel]);
}

@override
String toString() {
    return 'SocialPostDetail(id: $id, authorId: $authorId, placeId: $placeId, caption: $caption, visibility: $visibility, tipTitle: $tipTitle, tipBody: $tipBody, topic: $topic, placeDetail: $placeDetail, likesCount: $likesCount, commentsCount: $commentsCount, sharesCount: $sharesCount, savesCount: $savesCount, createdAt: $createdAt, author: $author, place: $place, postMedias: $postMedias, liked: $liked, shared: $shared, bookmarked: $bookmarked, trendLabel: $trendLabel, timeLabel: $timeLabel)';
}


}

/// @nodoc
abstract mixin class _$SocialPostDetailCopyWith<$Res> implements $SocialPostDetailCopyWith<$Res> {
  factory _$SocialPostDetailCopyWith(_SocialPostDetail value, $Res Function(_SocialPostDetail) _then) = __$SocialPostDetailCopyWithImpl;
@override @useResult
$Res call({
 String id, String authorId, String? placeId, String? caption, String visibility, String? tipTitle, String? tipBody, String? topic, String? placeDetail,@JsonKey(fromJson: _readInt) int likesCount,@JsonKey(fromJson: _readInt) int commentsCount,@JsonKey(fromJson: _readInt) int sharesCount,@JsonKey(fromJson: _readInt) int savesCount,@JsonKey(fromJson: _readDateTime) DateTime createdAt, SocialPostDetailAuthor author, SocialPostDetailPlace? place, List<SocialPostDetailMedia> postMedias, bool liked, bool shared, bool bookmarked, String? trendLabel, String timeLabel
});


@override $SocialPostDetailAuthorCopyWith<$Res> get author;@override $SocialPostDetailPlaceCopyWith<$Res>? get place;

}
/// @nodoc
class __$SocialPostDetailCopyWithImpl<$Res>
    implements _$SocialPostDetailCopyWith<$Res> {
  __$SocialPostDetailCopyWithImpl(this._self, this._then);

  final _SocialPostDetail _self;
  final $Res Function(_SocialPostDetail) _then;

/// Create a copy of SocialPostDetail
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? authorId = null,Object? placeId = freezed,Object? caption = freezed,Object? visibility = null,Object? tipTitle = freezed,Object? tipBody = freezed,Object? topic = freezed,Object? placeDetail = freezed,Object? likesCount = null,Object? commentsCount = null,Object? sharesCount = null,Object? savesCount = null,Object? createdAt = null,Object? author = null,Object? place = freezed,Object? postMedias = null,Object? liked = null,Object? shared = null,Object? bookmarked = null,Object? trendLabel = freezed,Object? timeLabel = null,}) {
  return _then(_SocialPostDetail(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,authorId: null == authorId ? _self.authorId : authorId // ignore: cast_nullable_to_non_nullable
as String,placeId: freezed == placeId ? _self.placeId : placeId // ignore: cast_nullable_to_non_nullable
as String?,caption: freezed == caption ? _self.caption : caption // ignore: cast_nullable_to_non_nullable
as String?,visibility: null == visibility ? _self.visibility : visibility // ignore: cast_nullable_to_non_nullable
as String,tipTitle: freezed == tipTitle ? _self.tipTitle : tipTitle // ignore: cast_nullable_to_non_nullable
as String?,tipBody: freezed == tipBody ? _self.tipBody : tipBody // ignore: cast_nullable_to_non_nullable
as String?,topic: freezed == topic ? _self.topic : topic // ignore: cast_nullable_to_non_nullable
as String?,placeDetail: freezed == placeDetail ? _self.placeDetail : placeDetail // ignore: cast_nullable_to_non_nullable
as String?,likesCount: null == likesCount ? _self.likesCount : likesCount // ignore: cast_nullable_to_non_nullable
as int,commentsCount: null == commentsCount ? _self.commentsCount : commentsCount // ignore: cast_nullable_to_non_nullable
as int,sharesCount: null == sharesCount ? _self.sharesCount : sharesCount // ignore: cast_nullable_to_non_nullable
as int,savesCount: null == savesCount ? _self.savesCount : savesCount // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,author: null == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as SocialPostDetailAuthor,place: freezed == place ? _self.place : place // ignore: cast_nullable_to_non_nullable
as SocialPostDetailPlace?,postMedias: null == postMedias ? _self._postMedias : postMedias // ignore: cast_nullable_to_non_nullable
as List<SocialPostDetailMedia>,liked: null == liked ? _self.liked : liked // ignore: cast_nullable_to_non_nullable
as bool,shared: null == shared ? _self.shared : shared // ignore: cast_nullable_to_non_nullable
as bool,bookmarked: null == bookmarked ? _self.bookmarked : bookmarked // ignore: cast_nullable_to_non_nullable
as bool,trendLabel: freezed == trendLabel ? _self.trendLabel : trendLabel // ignore: cast_nullable_to_non_nullable
as String?,timeLabel: null == timeLabel ? _self.timeLabel : timeLabel // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of SocialPostDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SocialPostDetailAuthorCopyWith<$Res> get author {
  
  return $SocialPostDetailAuthorCopyWith<$Res>(_self.author, (value) {
    return _then(_self.copyWith(author: value));
  });
}/// Create a copy of SocialPostDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SocialPostDetailPlaceCopyWith<$Res>? get place {
    if (_self.place == null) {
    return null;
  }

  return $SocialPostDetailPlaceCopyWith<$Res>(_self.place!, (value) {
    return _then(_self.copyWith(place: value));
  });
}
}


/// @nodoc
mixin _$SocialPostDetailAuthor {

 String get id; String get username; String? get displayName; String? get avatarId; String? get avatarUrl; String? get badgeLabel; bool get verified;
/// Create a copy of SocialPostDetailAuthor
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SocialPostDetailAuthorCopyWith<SocialPostDetailAuthor> get copyWith => _$SocialPostDetailAuthorCopyWithImpl<SocialPostDetailAuthor>(this as SocialPostDetailAuthor, _$identity);

  /// Serializes this SocialPostDetailAuthor to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SocialPostDetailAuthor;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SocialPostDetailAuthor&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.username, _this.username) || other.username == _this.username)&&(identical(other.displayName, _this.displayName) || other.displayName == _this.displayName)&&(identical(other.avatarId, _this.avatarId) || other.avatarId == _this.avatarId)&&(identical(other.avatarUrl, _this.avatarUrl) || other.avatarUrl == _this.avatarUrl)&&(identical(other.badgeLabel, _this.badgeLabel) || other.badgeLabel == _this.badgeLabel)&&(identical(other.verified, _this.verified) || other.verified == _this.verified));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SocialPostDetailAuthor;
  return Object.hash(runtimeType,_this.id,_this.username,_this.displayName,_this.avatarId,_this.avatarUrl,_this.badgeLabel,_this.verified);
}

@override
String toString() {
  final _this = this as SocialPostDetailAuthor;
  return 'SocialPostDetailAuthor(id: ${_this.id}, username: ${_this.username}, displayName: ${_this.displayName}, avatarId: ${_this.avatarId}, avatarUrl: ${_this.avatarUrl}, badgeLabel: ${_this.badgeLabel}, verified: ${_this.verified})';
}


}

/// @nodoc
abstract mixin class $SocialPostDetailAuthorCopyWith<$Res>  {
  factory $SocialPostDetailAuthorCopyWith(SocialPostDetailAuthor value, $Res Function(SocialPostDetailAuthor) _then) = _$SocialPostDetailAuthorCopyWithImpl;
@useResult
$Res call({
 String id, String username, String? displayName, String? avatarId, String? avatarUrl, String? badgeLabel, bool verified
});




}
/// @nodoc
class _$SocialPostDetailAuthorCopyWithImpl<$Res>
    implements $SocialPostDetailAuthorCopyWith<$Res> {
  _$SocialPostDetailAuthorCopyWithImpl(this._self, this._then);

  final SocialPostDetailAuthor _self;
  final $Res Function(SocialPostDetailAuthor) _then;

/// Create a copy of SocialPostDetailAuthor
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? username = null,Object? displayName = freezed,Object? avatarId = freezed,Object? avatarUrl = freezed,Object? badgeLabel = freezed,Object? verified = null,}) {
  return _then(SocialPostDetailAuthor(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,displayName: freezed == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String?,avatarId: freezed == avatarId ? _self.avatarId : avatarId // ignore: cast_nullable_to_non_nullable
as String?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,badgeLabel: freezed == badgeLabel ? _self.badgeLabel : badgeLabel // ignore: cast_nullable_to_non_nullable
as String?,verified: null == verified ? _self.verified : verified // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [SocialPostDetailAuthor].
extension SocialPostDetailAuthorPatterns on SocialPostDetailAuthor {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SocialPostDetailAuthor value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SocialPostDetailAuthor() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SocialPostDetailAuthor value)  $default,){
final _that = this;
switch (_that) {
case _SocialPostDetailAuthor():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SocialPostDetailAuthor value)?  $default,){
final _that = this;
switch (_that) {
case _SocialPostDetailAuthor() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String username,  String? displayName,  String? avatarId,  String? avatarUrl,  String? badgeLabel,  bool verified)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SocialPostDetailAuthor() when $default != null:
return $default(_that.id,_that.username,_that.displayName,_that.avatarId,_that.avatarUrl,_that.badgeLabel,_that.verified);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String username,  String? displayName,  String? avatarId,  String? avatarUrl,  String? badgeLabel,  bool verified)  $default,) {final _that = this;
switch (_that) {
case _SocialPostDetailAuthor():
return $default(_that.id,_that.username,_that.displayName,_that.avatarId,_that.avatarUrl,_that.badgeLabel,_that.verified);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String username,  String? displayName,  String? avatarId,  String? avatarUrl,  String? badgeLabel,  bool verified)?  $default,) {final _that = this;
switch (_that) {
case _SocialPostDetailAuthor() when $default != null:
return $default(_that.id,_that.username,_that.displayName,_that.avatarId,_that.avatarUrl,_that.badgeLabel,_that.verified);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SocialPostDetailAuthor implements SocialPostDetailAuthor {
  const _SocialPostDetailAuthor({required this.id, required this.username, this.displayName, this.avatarId, this.avatarUrl, this.badgeLabel, this.verified = false});
  factory _SocialPostDetailAuthor.fromJson(Map<String, dynamic> json) => _$SocialPostDetailAuthorFromJson(json);

@override final  String id;
@override final  String username;
@override final  String? displayName;
@override final  String? avatarId;
@override final  String? avatarUrl;
@override final  String? badgeLabel;
@override@JsonKey() final  bool verified;

/// Create a copy of SocialPostDetailAuthor
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SocialPostDetailAuthorCopyWith<_SocialPostDetailAuthor> get copyWith => __$SocialPostDetailAuthorCopyWithImpl<_SocialPostDetailAuthor>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SocialPostDetailAuthorToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SocialPostDetailAuthor&&(identical(other.id, id) || other.id == id)&&(identical(other.username, username) || other.username == username)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.avatarId, avatarId) || other.avatarId == avatarId)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.badgeLabel, badgeLabel) || other.badgeLabel == badgeLabel)&&(identical(other.verified, verified) || other.verified == verified));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,username,displayName,avatarId,avatarUrl,badgeLabel,verified);
}

@override
String toString() {
    return 'SocialPostDetailAuthor(id: $id, username: $username, displayName: $displayName, avatarId: $avatarId, avatarUrl: $avatarUrl, badgeLabel: $badgeLabel, verified: $verified)';
}


}

/// @nodoc
abstract mixin class _$SocialPostDetailAuthorCopyWith<$Res> implements $SocialPostDetailAuthorCopyWith<$Res> {
  factory _$SocialPostDetailAuthorCopyWith(_SocialPostDetailAuthor value, $Res Function(_SocialPostDetailAuthor) _then) = __$SocialPostDetailAuthorCopyWithImpl;
@override @useResult
$Res call({
 String id, String username, String? displayName, String? avatarId, String? avatarUrl, String? badgeLabel, bool verified
});




}
/// @nodoc
class __$SocialPostDetailAuthorCopyWithImpl<$Res>
    implements _$SocialPostDetailAuthorCopyWith<$Res> {
  __$SocialPostDetailAuthorCopyWithImpl(this._self, this._then);

  final _SocialPostDetailAuthor _self;
  final $Res Function(_SocialPostDetailAuthor) _then;

/// Create a copy of SocialPostDetailAuthor
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? username = null,Object? displayName = freezed,Object? avatarId = freezed,Object? avatarUrl = freezed,Object? badgeLabel = freezed,Object? verified = null,}) {
  return _then(_SocialPostDetailAuthor(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,displayName: freezed == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String?,avatarId: freezed == avatarId ? _self.avatarId : avatarId // ignore: cast_nullable_to_non_nullable
as String?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,badgeLabel: freezed == badgeLabel ? _self.badgeLabel : badgeLabel // ignore: cast_nullable_to_non_nullable
as String?,verified: null == verified ? _self.verified : verified // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$SocialPostDetailPlace {

 String get id; String get name; String? get detail;
/// Create a copy of SocialPostDetailPlace
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SocialPostDetailPlaceCopyWith<SocialPostDetailPlace> get copyWith => _$SocialPostDetailPlaceCopyWithImpl<SocialPostDetailPlace>(this as SocialPostDetailPlace, _$identity);

  /// Serializes this SocialPostDetailPlace to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SocialPostDetailPlace;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SocialPostDetailPlace&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.detail, _this.detail) || other.detail == _this.detail));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SocialPostDetailPlace;
  return Object.hash(runtimeType,_this.id,_this.name,_this.detail);
}

@override
String toString() {
  final _this = this as SocialPostDetailPlace;
  return 'SocialPostDetailPlace(id: ${_this.id}, name: ${_this.name}, detail: ${_this.detail})';
}


}

/// @nodoc
abstract mixin class $SocialPostDetailPlaceCopyWith<$Res>  {
  factory $SocialPostDetailPlaceCopyWith(SocialPostDetailPlace value, $Res Function(SocialPostDetailPlace) _then) = _$SocialPostDetailPlaceCopyWithImpl;
@useResult
$Res call({
 String id, String name, String? detail
});




}
/// @nodoc
class _$SocialPostDetailPlaceCopyWithImpl<$Res>
    implements $SocialPostDetailPlaceCopyWith<$Res> {
  _$SocialPostDetailPlaceCopyWithImpl(this._self, this._then);

  final SocialPostDetailPlace _self;
  final $Res Function(SocialPostDetailPlace) _then;

/// Create a copy of SocialPostDetailPlace
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? detail = freezed,}) {
  return _then(SocialPostDetailPlace(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,detail: freezed == detail ? _self.detail : detail // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SocialPostDetailPlace].
extension SocialPostDetailPlacePatterns on SocialPostDetailPlace {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SocialPostDetailPlace value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SocialPostDetailPlace() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SocialPostDetailPlace value)  $default,){
final _that = this;
switch (_that) {
case _SocialPostDetailPlace():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SocialPostDetailPlace value)?  $default,){
final _that = this;
switch (_that) {
case _SocialPostDetailPlace() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String? detail)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SocialPostDetailPlace() when $default != null:
return $default(_that.id,_that.name,_that.detail);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String? detail)  $default,) {final _that = this;
switch (_that) {
case _SocialPostDetailPlace():
return $default(_that.id,_that.name,_that.detail);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String? detail)?  $default,) {final _that = this;
switch (_that) {
case _SocialPostDetailPlace() when $default != null:
return $default(_that.id,_that.name,_that.detail);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SocialPostDetailPlace implements SocialPostDetailPlace {
  const _SocialPostDetailPlace({required this.id, required this.name, this.detail});
  factory _SocialPostDetailPlace.fromJson(Map<String, dynamic> json) => _$SocialPostDetailPlaceFromJson(json);

@override final  String id;
@override final  String name;
@override final  String? detail;

/// Create a copy of SocialPostDetailPlace
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SocialPostDetailPlaceCopyWith<_SocialPostDetailPlace> get copyWith => __$SocialPostDetailPlaceCopyWithImpl<_SocialPostDetailPlace>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SocialPostDetailPlaceToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SocialPostDetailPlace&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.detail, detail) || other.detail == detail));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,name,detail);
}

@override
String toString() {
    return 'SocialPostDetailPlace(id: $id, name: $name, detail: $detail)';
}


}

/// @nodoc
abstract mixin class _$SocialPostDetailPlaceCopyWith<$Res> implements $SocialPostDetailPlaceCopyWith<$Res> {
  factory _$SocialPostDetailPlaceCopyWith(_SocialPostDetailPlace value, $Res Function(_SocialPostDetailPlace) _then) = __$SocialPostDetailPlaceCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String? detail
});




}
/// @nodoc
class __$SocialPostDetailPlaceCopyWithImpl<$Res>
    implements _$SocialPostDetailPlaceCopyWith<$Res> {
  __$SocialPostDetailPlaceCopyWithImpl(this._self, this._then);

  final _SocialPostDetailPlace _self;
  final $Res Function(_SocialPostDetailPlace) _then;

/// Create a copy of SocialPostDetailPlace
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? detail = freezed,}) {
  return _then(_SocialPostDetailPlace(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,detail: freezed == detail ? _self.detail : detail // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$SocialPostDetailMedia {

 String get mediaId;@JsonKey(fromJson: _readInt) int get orderIndex; String? get url;
/// Create a copy of SocialPostDetailMedia
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SocialPostDetailMediaCopyWith<SocialPostDetailMedia> get copyWith => _$SocialPostDetailMediaCopyWithImpl<SocialPostDetailMedia>(this as SocialPostDetailMedia, _$identity);

  /// Serializes this SocialPostDetailMedia to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SocialPostDetailMedia;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SocialPostDetailMedia&&(identical(other.mediaId, _this.mediaId) || other.mediaId == _this.mediaId)&&(identical(other.orderIndex, _this.orderIndex) || other.orderIndex == _this.orderIndex)&&(identical(other.url, _this.url) || other.url == _this.url));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SocialPostDetailMedia;
  return Object.hash(runtimeType,_this.mediaId,_this.orderIndex,_this.url);
}

@override
String toString() {
  final _this = this as SocialPostDetailMedia;
  return 'SocialPostDetailMedia(mediaId: ${_this.mediaId}, orderIndex: ${_this.orderIndex}, url: ${_this.url})';
}


}

/// @nodoc
abstract mixin class $SocialPostDetailMediaCopyWith<$Res>  {
  factory $SocialPostDetailMediaCopyWith(SocialPostDetailMedia value, $Res Function(SocialPostDetailMedia) _then) = _$SocialPostDetailMediaCopyWithImpl;
@useResult
$Res call({
 String mediaId,@JsonKey(fromJson: _readInt) int orderIndex, String? url
});




}
/// @nodoc
class _$SocialPostDetailMediaCopyWithImpl<$Res>
    implements $SocialPostDetailMediaCopyWith<$Res> {
  _$SocialPostDetailMediaCopyWithImpl(this._self, this._then);

  final SocialPostDetailMedia _self;
  final $Res Function(SocialPostDetailMedia) _then;

/// Create a copy of SocialPostDetailMedia
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? mediaId = null,Object? orderIndex = null,Object? url = freezed,}) {
  return _then(SocialPostDetailMedia(
mediaId: null == mediaId ? _self.mediaId : mediaId // ignore: cast_nullable_to_non_nullable
as String,orderIndex: null == orderIndex ? _self.orderIndex : orderIndex // ignore: cast_nullable_to_non_nullable
as int,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SocialPostDetailMedia].
extension SocialPostDetailMediaPatterns on SocialPostDetailMedia {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SocialPostDetailMedia value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SocialPostDetailMedia() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SocialPostDetailMedia value)  $default,){
final _that = this;
switch (_that) {
case _SocialPostDetailMedia():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SocialPostDetailMedia value)?  $default,){
final _that = this;
switch (_that) {
case _SocialPostDetailMedia() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String mediaId, @JsonKey(fromJson: _readInt)  int orderIndex,  String? url)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SocialPostDetailMedia() when $default != null:
return $default(_that.mediaId,_that.orderIndex,_that.url);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String mediaId, @JsonKey(fromJson: _readInt)  int orderIndex,  String? url)  $default,) {final _that = this;
switch (_that) {
case _SocialPostDetailMedia():
return $default(_that.mediaId,_that.orderIndex,_that.url);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String mediaId, @JsonKey(fromJson: _readInt)  int orderIndex,  String? url)?  $default,) {final _that = this;
switch (_that) {
case _SocialPostDetailMedia() when $default != null:
return $default(_that.mediaId,_that.orderIndex,_that.url);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SocialPostDetailMedia implements SocialPostDetailMedia {
  const _SocialPostDetailMedia({required this.mediaId, @JsonKey(fromJson: _readInt) this.orderIndex = 0, this.url});
  factory _SocialPostDetailMedia.fromJson(Map<String, dynamic> json) => _$SocialPostDetailMediaFromJson(json);

@override final  String mediaId;
@override@JsonKey(fromJson: _readInt) final  int orderIndex;
@override final  String? url;

/// Create a copy of SocialPostDetailMedia
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SocialPostDetailMediaCopyWith<_SocialPostDetailMedia> get copyWith => __$SocialPostDetailMediaCopyWithImpl<_SocialPostDetailMedia>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SocialPostDetailMediaToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SocialPostDetailMedia&&(identical(other.mediaId, mediaId) || other.mediaId == mediaId)&&(identical(other.orderIndex, orderIndex) || other.orderIndex == orderIndex)&&(identical(other.url, url) || other.url == url));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,mediaId,orderIndex,url);
}

@override
String toString() {
    return 'SocialPostDetailMedia(mediaId: $mediaId, orderIndex: $orderIndex, url: $url)';
}


}

/// @nodoc
abstract mixin class _$SocialPostDetailMediaCopyWith<$Res> implements $SocialPostDetailMediaCopyWith<$Res> {
  factory _$SocialPostDetailMediaCopyWith(_SocialPostDetailMedia value, $Res Function(_SocialPostDetailMedia) _then) = __$SocialPostDetailMediaCopyWithImpl;
@override @useResult
$Res call({
 String mediaId,@JsonKey(fromJson: _readInt) int orderIndex, String? url
});




}
/// @nodoc
class __$SocialPostDetailMediaCopyWithImpl<$Res>
    implements _$SocialPostDetailMediaCopyWith<$Res> {
  __$SocialPostDetailMediaCopyWithImpl(this._self, this._then);

  final _SocialPostDetailMedia _self;
  final $Res Function(_SocialPostDetailMedia) _then;

/// Create a copy of SocialPostDetailMedia
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? mediaId = null,Object? orderIndex = null,Object? url = freezed,}) {
  return _then(_SocialPostDetailMedia(
mediaId: null == mediaId ? _self.mediaId : mediaId // ignore: cast_nullable_to_non_nullable
as String,orderIndex: null == orderIndex ? _self.orderIndex : orderIndex // ignore: cast_nullable_to_non_nullable
as int,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$SocialPostDetailComment {

 String get id; String get postId; String get userId; String get content;@JsonKey(fromJson: _readDateTime) DateTime get createdAt; SocialPostDetailCommentUser get user;
/// Create a copy of SocialPostDetailComment
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SocialPostDetailCommentCopyWith<SocialPostDetailComment> get copyWith => _$SocialPostDetailCommentCopyWithImpl<SocialPostDetailComment>(this as SocialPostDetailComment, _$identity);

  /// Serializes this SocialPostDetailComment to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SocialPostDetailComment;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SocialPostDetailComment&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.postId, _this.postId) || other.postId == _this.postId)&&(identical(other.userId, _this.userId) || other.userId == _this.userId)&&(identical(other.content, _this.content) || other.content == _this.content)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.user, _this.user) || other.user == _this.user));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SocialPostDetailComment;
  return Object.hash(runtimeType,_this.id,_this.postId,_this.userId,_this.content,_this.createdAt,_this.user);
}

@override
String toString() {
  final _this = this as SocialPostDetailComment;
  return 'SocialPostDetailComment(id: ${_this.id}, postId: ${_this.postId}, userId: ${_this.userId}, content: ${_this.content}, createdAt: ${_this.createdAt}, user: ${_this.user})';
}


}

/// @nodoc
abstract mixin class $SocialPostDetailCommentCopyWith<$Res>  {
  factory $SocialPostDetailCommentCopyWith(SocialPostDetailComment value, $Res Function(SocialPostDetailComment) _then) = _$SocialPostDetailCommentCopyWithImpl;
@useResult
$Res call({
 String id, String postId, String userId, String content,@JsonKey(fromJson: _readDateTime) DateTime createdAt, SocialPostDetailCommentUser user
});


$SocialPostDetailCommentUserCopyWith<$Res> get user;

}
/// @nodoc
class _$SocialPostDetailCommentCopyWithImpl<$Res>
    implements $SocialPostDetailCommentCopyWith<$Res> {
  _$SocialPostDetailCommentCopyWithImpl(this._self, this._then);

  final SocialPostDetailComment _self;
  final $Res Function(SocialPostDetailComment) _then;

/// Create a copy of SocialPostDetailComment
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? postId = null,Object? userId = null,Object? content = null,Object? createdAt = null,Object? user = null,}) {
  return _then(SocialPostDetailComment(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,postId: null == postId ? _self.postId : postId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as SocialPostDetailCommentUser,
  ));
}
/// Create a copy of SocialPostDetailComment
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SocialPostDetailCommentUserCopyWith<$Res> get user {
  
  return $SocialPostDetailCommentUserCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}


/// Adds pattern-matching-related methods to [SocialPostDetailComment].
extension SocialPostDetailCommentPatterns on SocialPostDetailComment {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SocialPostDetailComment value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SocialPostDetailComment() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SocialPostDetailComment value)  $default,){
final _that = this;
switch (_that) {
case _SocialPostDetailComment():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SocialPostDetailComment value)?  $default,){
final _that = this;
switch (_that) {
case _SocialPostDetailComment() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String postId,  String userId,  String content, @JsonKey(fromJson: _readDateTime)  DateTime createdAt,  SocialPostDetailCommentUser user)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SocialPostDetailComment() when $default != null:
return $default(_that.id,_that.postId,_that.userId,_that.content,_that.createdAt,_that.user);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String postId,  String userId,  String content, @JsonKey(fromJson: _readDateTime)  DateTime createdAt,  SocialPostDetailCommentUser user)  $default,) {final _that = this;
switch (_that) {
case _SocialPostDetailComment():
return $default(_that.id,_that.postId,_that.userId,_that.content,_that.createdAt,_that.user);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String postId,  String userId,  String content, @JsonKey(fromJson: _readDateTime)  DateTime createdAt,  SocialPostDetailCommentUser user)?  $default,) {final _that = this;
switch (_that) {
case _SocialPostDetailComment() when $default != null:
return $default(_that.id,_that.postId,_that.userId,_that.content,_that.createdAt,_that.user);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SocialPostDetailComment implements SocialPostDetailComment {
  const _SocialPostDetailComment({required this.id, required this.postId, required this.userId, required this.content, @JsonKey(fromJson: _readDateTime) required this.createdAt, required this.user});
  factory _SocialPostDetailComment.fromJson(Map<String, dynamic> json) => _$SocialPostDetailCommentFromJson(json);

@override final  String id;
@override final  String postId;
@override final  String userId;
@override final  String content;
@override@JsonKey(fromJson: _readDateTime) final  DateTime createdAt;
@override final  SocialPostDetailCommentUser user;

/// Create a copy of SocialPostDetailComment
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SocialPostDetailCommentCopyWith<_SocialPostDetailComment> get copyWith => __$SocialPostDetailCommentCopyWithImpl<_SocialPostDetailComment>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SocialPostDetailCommentToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SocialPostDetailComment&&(identical(other.id, id) || other.id == id)&&(identical(other.postId, postId) || other.postId == postId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.content, content) || other.content == content)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.user, user) || other.user == user));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,postId,userId,content,createdAt,user);
}

@override
String toString() {
    return 'SocialPostDetailComment(id: $id, postId: $postId, userId: $userId, content: $content, createdAt: $createdAt, user: $user)';
}


}

/// @nodoc
abstract mixin class _$SocialPostDetailCommentCopyWith<$Res> implements $SocialPostDetailCommentCopyWith<$Res> {
  factory _$SocialPostDetailCommentCopyWith(_SocialPostDetailComment value, $Res Function(_SocialPostDetailComment) _then) = __$SocialPostDetailCommentCopyWithImpl;
@override @useResult
$Res call({
 String id, String postId, String userId, String content,@JsonKey(fromJson: _readDateTime) DateTime createdAt, SocialPostDetailCommentUser user
});


@override $SocialPostDetailCommentUserCopyWith<$Res> get user;

}
/// @nodoc
class __$SocialPostDetailCommentCopyWithImpl<$Res>
    implements _$SocialPostDetailCommentCopyWith<$Res> {
  __$SocialPostDetailCommentCopyWithImpl(this._self, this._then);

  final _SocialPostDetailComment _self;
  final $Res Function(_SocialPostDetailComment) _then;

/// Create a copy of SocialPostDetailComment
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? postId = null,Object? userId = null,Object? content = null,Object? createdAt = null,Object? user = null,}) {
  return _then(_SocialPostDetailComment(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,postId: null == postId ? _self.postId : postId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as SocialPostDetailCommentUser,
  ));
}

/// Create a copy of SocialPostDetailComment
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SocialPostDetailCommentUserCopyWith<$Res> get user {
  
  return $SocialPostDetailCommentUserCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}


/// @nodoc
mixin _$SocialPostDetailCommentUser {

 String get id; String get username; String? get avatarId; String? get avatarUrl;
/// Create a copy of SocialPostDetailCommentUser
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SocialPostDetailCommentUserCopyWith<SocialPostDetailCommentUser> get copyWith => _$SocialPostDetailCommentUserCopyWithImpl<SocialPostDetailCommentUser>(this as SocialPostDetailCommentUser, _$identity);

  /// Serializes this SocialPostDetailCommentUser to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SocialPostDetailCommentUser;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SocialPostDetailCommentUser&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.username, _this.username) || other.username == _this.username)&&(identical(other.avatarId, _this.avatarId) || other.avatarId == _this.avatarId)&&(identical(other.avatarUrl, _this.avatarUrl) || other.avatarUrl == _this.avatarUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SocialPostDetailCommentUser;
  return Object.hash(runtimeType,_this.id,_this.username,_this.avatarId,_this.avatarUrl);
}

@override
String toString() {
  final _this = this as SocialPostDetailCommentUser;
  return 'SocialPostDetailCommentUser(id: ${_this.id}, username: ${_this.username}, avatarId: ${_this.avatarId}, avatarUrl: ${_this.avatarUrl})';
}


}

/// @nodoc
abstract mixin class $SocialPostDetailCommentUserCopyWith<$Res>  {
  factory $SocialPostDetailCommentUserCopyWith(SocialPostDetailCommentUser value, $Res Function(SocialPostDetailCommentUser) _then) = _$SocialPostDetailCommentUserCopyWithImpl;
@useResult
$Res call({
 String id, String username, String? avatarId, String? avatarUrl
});




}
/// @nodoc
class _$SocialPostDetailCommentUserCopyWithImpl<$Res>
    implements $SocialPostDetailCommentUserCopyWith<$Res> {
  _$SocialPostDetailCommentUserCopyWithImpl(this._self, this._then);

  final SocialPostDetailCommentUser _self;
  final $Res Function(SocialPostDetailCommentUser) _then;

/// Create a copy of SocialPostDetailCommentUser
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? username = null,Object? avatarId = freezed,Object? avatarUrl = freezed,}) {
  return _then(SocialPostDetailCommentUser(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,avatarId: freezed == avatarId ? _self.avatarId : avatarId // ignore: cast_nullable_to_non_nullable
as String?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SocialPostDetailCommentUser].
extension SocialPostDetailCommentUserPatterns on SocialPostDetailCommentUser {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SocialPostDetailCommentUser value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SocialPostDetailCommentUser() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SocialPostDetailCommentUser value)  $default,){
final _that = this;
switch (_that) {
case _SocialPostDetailCommentUser():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SocialPostDetailCommentUser value)?  $default,){
final _that = this;
switch (_that) {
case _SocialPostDetailCommentUser() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String username,  String? avatarId,  String? avatarUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SocialPostDetailCommentUser() when $default != null:
return $default(_that.id,_that.username,_that.avatarId,_that.avatarUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String username,  String? avatarId,  String? avatarUrl)  $default,) {final _that = this;
switch (_that) {
case _SocialPostDetailCommentUser():
return $default(_that.id,_that.username,_that.avatarId,_that.avatarUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String username,  String? avatarId,  String? avatarUrl)?  $default,) {final _that = this;
switch (_that) {
case _SocialPostDetailCommentUser() when $default != null:
return $default(_that.id,_that.username,_that.avatarId,_that.avatarUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SocialPostDetailCommentUser implements SocialPostDetailCommentUser {
  const _SocialPostDetailCommentUser({required this.id, required this.username, this.avatarId, this.avatarUrl});
  factory _SocialPostDetailCommentUser.fromJson(Map<String, dynamic> json) => _$SocialPostDetailCommentUserFromJson(json);

@override final  String id;
@override final  String username;
@override final  String? avatarId;
@override final  String? avatarUrl;

/// Create a copy of SocialPostDetailCommentUser
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SocialPostDetailCommentUserCopyWith<_SocialPostDetailCommentUser> get copyWith => __$SocialPostDetailCommentUserCopyWithImpl<_SocialPostDetailCommentUser>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SocialPostDetailCommentUserToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SocialPostDetailCommentUser&&(identical(other.id, id) || other.id == id)&&(identical(other.username, username) || other.username == username)&&(identical(other.avatarId, avatarId) || other.avatarId == avatarId)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,username,avatarId,avatarUrl);
}

@override
String toString() {
    return 'SocialPostDetailCommentUser(id: $id, username: $username, avatarId: $avatarId, avatarUrl: $avatarUrl)';
}


}

/// @nodoc
abstract mixin class _$SocialPostDetailCommentUserCopyWith<$Res> implements $SocialPostDetailCommentUserCopyWith<$Res> {
  factory _$SocialPostDetailCommentUserCopyWith(_SocialPostDetailCommentUser value, $Res Function(_SocialPostDetailCommentUser) _then) = __$SocialPostDetailCommentUserCopyWithImpl;
@override @useResult
$Res call({
 String id, String username, String? avatarId, String? avatarUrl
});




}
/// @nodoc
class __$SocialPostDetailCommentUserCopyWithImpl<$Res>
    implements _$SocialPostDetailCommentUserCopyWith<$Res> {
  __$SocialPostDetailCommentUserCopyWithImpl(this._self, this._then);

  final _SocialPostDetailCommentUser _self;
  final $Res Function(_SocialPostDetailCommentUser) _then;

/// Create a copy of SocialPostDetailCommentUser
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? username = null,Object? avatarId = freezed,Object? avatarUrl = freezed,}) {
  return _then(_SocialPostDetailCommentUser(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,avatarId: freezed == avatarId ? _self.avatarId : avatarId // ignore: cast_nullable_to_non_nullable
as String?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$SocialPostDetailCommentsPage {

 List<SocialPostDetailComment> get data; SocialPostDetailPageMeta get meta;
/// Create a copy of SocialPostDetailCommentsPage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SocialPostDetailCommentsPageCopyWith<SocialPostDetailCommentsPage> get copyWith => _$SocialPostDetailCommentsPageCopyWithImpl<SocialPostDetailCommentsPage>(this as SocialPostDetailCommentsPage, _$identity);

  /// Serializes this SocialPostDetailCommentsPage to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SocialPostDetailCommentsPage;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SocialPostDetailCommentsPage&&const DeepCollectionEquality().equals(other.data, _this.data)&&(identical(other.meta, _this.meta) || other.meta == _this.meta));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SocialPostDetailCommentsPage;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.data),_this.meta);
}

@override
String toString() {
  final _this = this as SocialPostDetailCommentsPage;
  return 'SocialPostDetailCommentsPage(data: ${_this.data}, meta: ${_this.meta})';
}


}

/// @nodoc
abstract mixin class $SocialPostDetailCommentsPageCopyWith<$Res>  {
  factory $SocialPostDetailCommentsPageCopyWith(SocialPostDetailCommentsPage value, $Res Function(SocialPostDetailCommentsPage) _then) = _$SocialPostDetailCommentsPageCopyWithImpl;
@useResult
$Res call({
 List<SocialPostDetailComment> data, SocialPostDetailPageMeta meta
});


$SocialPostDetailPageMetaCopyWith<$Res> get meta;

}
/// @nodoc
class _$SocialPostDetailCommentsPageCopyWithImpl<$Res>
    implements $SocialPostDetailCommentsPageCopyWith<$Res> {
  _$SocialPostDetailCommentsPageCopyWithImpl(this._self, this._then);

  final SocialPostDetailCommentsPage _self;
  final $Res Function(SocialPostDetailCommentsPage) _then;

/// Create a copy of SocialPostDetailCommentsPage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? data = null,Object? meta = null,}) {
  return _then(SocialPostDetailCommentsPage(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as List<SocialPostDetailComment>,meta: null == meta ? _self.meta : meta // ignore: cast_nullable_to_non_nullable
as SocialPostDetailPageMeta,
  ));
}
/// Create a copy of SocialPostDetailCommentsPage
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SocialPostDetailPageMetaCopyWith<$Res> get meta {
  
  return $SocialPostDetailPageMetaCopyWith<$Res>(_self.meta, (value) {
    return _then(_self.copyWith(meta: value));
  });
}
}


/// Adds pattern-matching-related methods to [SocialPostDetailCommentsPage].
extension SocialPostDetailCommentsPagePatterns on SocialPostDetailCommentsPage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SocialPostDetailCommentsPage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SocialPostDetailCommentsPage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SocialPostDetailCommentsPage value)  $default,){
final _that = this;
switch (_that) {
case _SocialPostDetailCommentsPage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SocialPostDetailCommentsPage value)?  $default,){
final _that = this;
switch (_that) {
case _SocialPostDetailCommentsPage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<SocialPostDetailComment> data,  SocialPostDetailPageMeta meta)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SocialPostDetailCommentsPage() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<SocialPostDetailComment> data,  SocialPostDetailPageMeta meta)  $default,) {final _that = this;
switch (_that) {
case _SocialPostDetailCommentsPage():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<SocialPostDetailComment> data,  SocialPostDetailPageMeta meta)?  $default,) {final _that = this;
switch (_that) {
case _SocialPostDetailCommentsPage() when $default != null:
return $default(_that.data,_that.meta);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SocialPostDetailCommentsPage implements SocialPostDetailCommentsPage {
  const _SocialPostDetailCommentsPage({ List<SocialPostDetailComment> data = const <SocialPostDetailComment>[], required this.meta}): _data = data;
  factory _SocialPostDetailCommentsPage.fromJson(Map<String, dynamic> json) => _$SocialPostDetailCommentsPageFromJson(json);

 final  List<SocialPostDetailComment> _data;
@override@JsonKey() List<SocialPostDetailComment> get data {
  if (_data is EqualUnmodifiableListView) return _data;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_data);
}

@override final  SocialPostDetailPageMeta meta;

/// Create a copy of SocialPostDetailCommentsPage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SocialPostDetailCommentsPageCopyWith<_SocialPostDetailCommentsPage> get copyWith => __$SocialPostDetailCommentsPageCopyWithImpl<_SocialPostDetailCommentsPage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SocialPostDetailCommentsPageToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SocialPostDetailCommentsPage&&const DeepCollectionEquality().equals(other.data, _data)&&(identical(other.meta, meta) || other.meta == meta));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_data),meta);
}

@override
String toString() {
    return 'SocialPostDetailCommentsPage(data: $data, meta: $meta)';
}


}

/// @nodoc
abstract mixin class _$SocialPostDetailCommentsPageCopyWith<$Res> implements $SocialPostDetailCommentsPageCopyWith<$Res> {
  factory _$SocialPostDetailCommentsPageCopyWith(_SocialPostDetailCommentsPage value, $Res Function(_SocialPostDetailCommentsPage) _then) = __$SocialPostDetailCommentsPageCopyWithImpl;
@override @useResult
$Res call({
 List<SocialPostDetailComment> data, SocialPostDetailPageMeta meta
});


@override $SocialPostDetailPageMetaCopyWith<$Res> get meta;

}
/// @nodoc
class __$SocialPostDetailCommentsPageCopyWithImpl<$Res>
    implements _$SocialPostDetailCommentsPageCopyWith<$Res> {
  __$SocialPostDetailCommentsPageCopyWithImpl(this._self, this._then);

  final _SocialPostDetailCommentsPage _self;
  final $Res Function(_SocialPostDetailCommentsPage) _then;

/// Create a copy of SocialPostDetailCommentsPage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? data = null,Object? meta = null,}) {
  return _then(_SocialPostDetailCommentsPage(
data: null == data ? _self._data : data // ignore: cast_nullable_to_non_nullable
as List<SocialPostDetailComment>,meta: null == meta ? _self.meta : meta // ignore: cast_nullable_to_non_nullable
as SocialPostDetailPageMeta,
  ));
}

/// Create a copy of SocialPostDetailCommentsPage
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SocialPostDetailPageMetaCopyWith<$Res> get meta {
  
  return $SocialPostDetailPageMetaCopyWith<$Res>(_self.meta, (value) {
    return _then(_self.copyWith(meta: value));
  });
}
}


/// @nodoc
mixin _$SocialPostDetailPageMeta {

@JsonKey(fromJson: _readInt) int get page;@JsonKey(fromJson: _readInt) int get limit;@JsonKey(fromJson: _readInt) int get total;@JsonKey(fromJson: _readInt) int get totalPages; bool get hasNextPage; bool get hasPreviousPage;
/// Create a copy of SocialPostDetailPageMeta
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SocialPostDetailPageMetaCopyWith<SocialPostDetailPageMeta> get copyWith => _$SocialPostDetailPageMetaCopyWithImpl<SocialPostDetailPageMeta>(this as SocialPostDetailPageMeta, _$identity);

  /// Serializes this SocialPostDetailPageMeta to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SocialPostDetailPageMeta;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SocialPostDetailPageMeta&&(identical(other.page, _this.page) || other.page == _this.page)&&(identical(other.limit, _this.limit) || other.limit == _this.limit)&&(identical(other.total, _this.total) || other.total == _this.total)&&(identical(other.totalPages, _this.totalPages) || other.totalPages == _this.totalPages)&&(identical(other.hasNextPage, _this.hasNextPage) || other.hasNextPage == _this.hasNextPage)&&(identical(other.hasPreviousPage, _this.hasPreviousPage) || other.hasPreviousPage == _this.hasPreviousPage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SocialPostDetailPageMeta;
  return Object.hash(runtimeType,_this.page,_this.limit,_this.total,_this.totalPages,_this.hasNextPage,_this.hasPreviousPage);
}

@override
String toString() {
  final _this = this as SocialPostDetailPageMeta;
  return 'SocialPostDetailPageMeta(page: ${_this.page}, limit: ${_this.limit}, total: ${_this.total}, totalPages: ${_this.totalPages}, hasNextPage: ${_this.hasNextPage}, hasPreviousPage: ${_this.hasPreviousPage})';
}


}

/// @nodoc
abstract mixin class $SocialPostDetailPageMetaCopyWith<$Res>  {
  factory $SocialPostDetailPageMetaCopyWith(SocialPostDetailPageMeta value, $Res Function(SocialPostDetailPageMeta) _then) = _$SocialPostDetailPageMetaCopyWithImpl;
@useResult
$Res call({
@JsonKey(fromJson: _readInt) int page,@JsonKey(fromJson: _readInt) int limit,@JsonKey(fromJson: _readInt) int total,@JsonKey(fromJson: _readInt) int totalPages, bool hasNextPage, bool hasPreviousPage
});




}
/// @nodoc
class _$SocialPostDetailPageMetaCopyWithImpl<$Res>
    implements $SocialPostDetailPageMetaCopyWith<$Res> {
  _$SocialPostDetailPageMetaCopyWithImpl(this._self, this._then);

  final SocialPostDetailPageMeta _self;
  final $Res Function(SocialPostDetailPageMeta) _then;

/// Create a copy of SocialPostDetailPageMeta
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? page = null,Object? limit = null,Object? total = null,Object? totalPages = null,Object? hasNextPage = null,Object? hasPreviousPage = null,}) {
  return _then(SocialPostDetailPageMeta(
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


/// Adds pattern-matching-related methods to [SocialPostDetailPageMeta].
extension SocialPostDetailPageMetaPatterns on SocialPostDetailPageMeta {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SocialPostDetailPageMeta value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SocialPostDetailPageMeta() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SocialPostDetailPageMeta value)  $default,){
final _that = this;
switch (_that) {
case _SocialPostDetailPageMeta():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SocialPostDetailPageMeta value)?  $default,){
final _that = this;
switch (_that) {
case _SocialPostDetailPageMeta() when $default != null:
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
case _SocialPostDetailPageMeta() when $default != null:
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
case _SocialPostDetailPageMeta():
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
case _SocialPostDetailPageMeta() when $default != null:
return $default(_that.page,_that.limit,_that.total,_that.totalPages,_that.hasNextPage,_that.hasPreviousPage);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SocialPostDetailPageMeta implements SocialPostDetailPageMeta {
  const _SocialPostDetailPageMeta({@JsonKey(fromJson: _readInt) this.page = 1, @JsonKey(fromJson: _readInt) this.limit = 20, @JsonKey(fromJson: _readInt) this.total = 0, @JsonKey(fromJson: _readInt) this.totalPages = 0, this.hasNextPage = false, this.hasPreviousPage = false});
  factory _SocialPostDetailPageMeta.fromJson(Map<String, dynamic> json) => _$SocialPostDetailPageMetaFromJson(json);

@override@JsonKey(fromJson: _readInt) final  int page;
@override@JsonKey(fromJson: _readInt) final  int limit;
@override@JsonKey(fromJson: _readInt) final  int total;
@override@JsonKey(fromJson: _readInt) final  int totalPages;
@override@JsonKey() final  bool hasNextPage;
@override@JsonKey() final  bool hasPreviousPage;

/// Create a copy of SocialPostDetailPageMeta
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SocialPostDetailPageMetaCopyWith<_SocialPostDetailPageMeta> get copyWith => __$SocialPostDetailPageMetaCopyWithImpl<_SocialPostDetailPageMeta>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SocialPostDetailPageMetaToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SocialPostDetailPageMeta&&(identical(other.page, page) || other.page == page)&&(identical(other.limit, limit) || other.limit == limit)&&(identical(other.total, total) || other.total == total)&&(identical(other.totalPages, totalPages) || other.totalPages == totalPages)&&(identical(other.hasNextPage, hasNextPage) || other.hasNextPage == hasNextPage)&&(identical(other.hasPreviousPage, hasPreviousPage) || other.hasPreviousPage == hasPreviousPage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,page,limit,total,totalPages,hasNextPage,hasPreviousPage);
}

@override
String toString() {
    return 'SocialPostDetailPageMeta(page: $page, limit: $limit, total: $total, totalPages: $totalPages, hasNextPage: $hasNextPage, hasPreviousPage: $hasPreviousPage)';
}


}

/// @nodoc
abstract mixin class _$SocialPostDetailPageMetaCopyWith<$Res> implements $SocialPostDetailPageMetaCopyWith<$Res> {
  factory _$SocialPostDetailPageMetaCopyWith(_SocialPostDetailPageMeta value, $Res Function(_SocialPostDetailPageMeta) _then) = __$SocialPostDetailPageMetaCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(fromJson: _readInt) int page,@JsonKey(fromJson: _readInt) int limit,@JsonKey(fromJson: _readInt) int total,@JsonKey(fromJson: _readInt) int totalPages, bool hasNextPage, bool hasPreviousPage
});




}
/// @nodoc
class __$SocialPostDetailPageMetaCopyWithImpl<$Res>
    implements _$SocialPostDetailPageMetaCopyWith<$Res> {
  __$SocialPostDetailPageMetaCopyWithImpl(this._self, this._then);

  final _SocialPostDetailPageMeta _self;
  final $Res Function(_SocialPostDetailPageMeta) _then;

/// Create a copy of SocialPostDetailPageMeta
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? page = null,Object? limit = null,Object? total = null,Object? totalPages = null,Object? hasNextPage = null,Object? hasPreviousPage = null,}) {
  return _then(_SocialPostDetailPageMeta(
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

// dart format on
