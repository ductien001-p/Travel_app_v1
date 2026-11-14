// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'social_feed_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SocialFeed {

 SocialFeedHeader get header; SocialFeedComposer get composer; List<SocialFeedStory> get stories; List<SocialFeedTab> get tabs; List<SocialFeedTopicChip> get topicChips; List<SocialFeedItem> get items; SocialFeedMeta? get meta;
/// Create a copy of SocialFeed
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SocialFeedCopyWith<SocialFeed> get copyWith => _$SocialFeedCopyWithImpl<SocialFeed>(this as SocialFeed, _$identity);

  /// Serializes this SocialFeed to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SocialFeed;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SocialFeed&&(identical(other.header, _this.header) || other.header == _this.header)&&(identical(other.composer, _this.composer) || other.composer == _this.composer)&&const DeepCollectionEquality().equals(other.stories, _this.stories)&&const DeepCollectionEquality().equals(other.tabs, _this.tabs)&&const DeepCollectionEquality().equals(other.topicChips, _this.topicChips)&&const DeepCollectionEquality().equals(other.items, _this.items)&&(identical(other.meta, _this.meta) || other.meta == _this.meta));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SocialFeed;
  return Object.hash(runtimeType,_this.header,_this.composer,const DeepCollectionEquality().hash(_this.stories),const DeepCollectionEquality().hash(_this.tabs),const DeepCollectionEquality().hash(_this.topicChips),const DeepCollectionEquality().hash(_this.items),_this.meta);
}

@override
String toString() {
  final _this = this as SocialFeed;
  return 'SocialFeed(header: ${_this.header}, composer: ${_this.composer}, stories: ${_this.stories}, tabs: ${_this.tabs}, topicChips: ${_this.topicChips}, items: ${_this.items}, meta: ${_this.meta})';
}


}

/// @nodoc
abstract mixin class $SocialFeedCopyWith<$Res>  {
  factory $SocialFeedCopyWith(SocialFeed value, $Res Function(SocialFeed) _then) = _$SocialFeedCopyWithImpl;
@useResult
$Res call({
 SocialFeedHeader header, SocialFeedComposer composer, List<SocialFeedStory> stories, List<SocialFeedTab> tabs, List<SocialFeedTopicChip> topicChips, List<SocialFeedItem> items, SocialFeedMeta? meta
});


$SocialFeedHeaderCopyWith<$Res> get header;$SocialFeedComposerCopyWith<$Res> get composer;$SocialFeedMetaCopyWith<$Res>? get meta;

}
/// @nodoc
class _$SocialFeedCopyWithImpl<$Res>
    implements $SocialFeedCopyWith<$Res> {
  _$SocialFeedCopyWithImpl(this._self, this._then);

  final SocialFeed _self;
  final $Res Function(SocialFeed) _then;

/// Create a copy of SocialFeed
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? header = null,Object? composer = null,Object? stories = null,Object? tabs = null,Object? topicChips = null,Object? items = null,Object? meta = freezed,}) {
  return _then(SocialFeed(
header: null == header ? _self.header : header // ignore: cast_nullable_to_non_nullable
as SocialFeedHeader,composer: null == composer ? _self.composer : composer // ignore: cast_nullable_to_non_nullable
as SocialFeedComposer,stories: null == stories ? _self.stories : stories // ignore: cast_nullable_to_non_nullable
as List<SocialFeedStory>,tabs: null == tabs ? _self.tabs : tabs // ignore: cast_nullable_to_non_nullable
as List<SocialFeedTab>,topicChips: null == topicChips ? _self.topicChips : topicChips // ignore: cast_nullable_to_non_nullable
as List<SocialFeedTopicChip>,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<SocialFeedItem>,meta: freezed == meta ? _self.meta : meta // ignore: cast_nullable_to_non_nullable
as SocialFeedMeta?,
  ));
}
/// Create a copy of SocialFeed
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SocialFeedHeaderCopyWith<$Res> get header {
  
  return $SocialFeedHeaderCopyWith<$Res>(_self.header, (value) {
    return _then(_self.copyWith(header: value));
  });
}/// Create a copy of SocialFeed
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SocialFeedComposerCopyWith<$Res> get composer {
  
  return $SocialFeedComposerCopyWith<$Res>(_self.composer, (value) {
    return _then(_self.copyWith(composer: value));
  });
}/// Create a copy of SocialFeed
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SocialFeedMetaCopyWith<$Res>? get meta {
    if (_self.meta == null) {
    return null;
  }

  return $SocialFeedMetaCopyWith<$Res>(_self.meta!, (value) {
    return _then(_self.copyWith(meta: value));
  });
}
}


/// Adds pattern-matching-related methods to [SocialFeed].
extension SocialFeedPatterns on SocialFeed {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SocialFeed value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SocialFeed() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SocialFeed value)  $default,){
final _that = this;
switch (_that) {
case _SocialFeed():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SocialFeed value)?  $default,){
final _that = this;
switch (_that) {
case _SocialFeed() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( SocialFeedHeader header,  SocialFeedComposer composer,  List<SocialFeedStory> stories,  List<SocialFeedTab> tabs,  List<SocialFeedTopicChip> topicChips,  List<SocialFeedItem> items,  SocialFeedMeta? meta)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SocialFeed() when $default != null:
return $default(_that.header,_that.composer,_that.stories,_that.tabs,_that.topicChips,_that.items,_that.meta);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( SocialFeedHeader header,  SocialFeedComposer composer,  List<SocialFeedStory> stories,  List<SocialFeedTab> tabs,  List<SocialFeedTopicChip> topicChips,  List<SocialFeedItem> items,  SocialFeedMeta? meta)  $default,) {final _that = this;
switch (_that) {
case _SocialFeed():
return $default(_that.header,_that.composer,_that.stories,_that.tabs,_that.topicChips,_that.items,_that.meta);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( SocialFeedHeader header,  SocialFeedComposer composer,  List<SocialFeedStory> stories,  List<SocialFeedTab> tabs,  List<SocialFeedTopicChip> topicChips,  List<SocialFeedItem> items,  SocialFeedMeta? meta)?  $default,) {final _that = this;
switch (_that) {
case _SocialFeed() when $default != null:
return $default(_that.header,_that.composer,_that.stories,_that.tabs,_that.topicChips,_that.items,_that.meta);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SocialFeed implements SocialFeed {
  const _SocialFeed({required this.header, required this.composer,  List<SocialFeedStory> stories = const <SocialFeedStory>[],  List<SocialFeedTab> tabs = const <SocialFeedTab>[],  List<SocialFeedTopicChip> topicChips = const <SocialFeedTopicChip>[],  List<SocialFeedItem> items = const <SocialFeedItem>[], this.meta}): _stories = stories,_tabs = tabs,_topicChips = topicChips,_items = items;
  factory _SocialFeed.fromJson(Map<String, dynamic> json) => _$SocialFeedFromJson(json);

@override final  SocialFeedHeader header;
@override final  SocialFeedComposer composer;
 final  List<SocialFeedStory> _stories;
@override@JsonKey() List<SocialFeedStory> get stories {
  if (_stories is EqualUnmodifiableListView) return _stories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_stories);
}

 final  List<SocialFeedTab> _tabs;
@override@JsonKey() List<SocialFeedTab> get tabs {
  if (_tabs is EqualUnmodifiableListView) return _tabs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tabs);
}

 final  List<SocialFeedTopicChip> _topicChips;
@override@JsonKey() List<SocialFeedTopicChip> get topicChips {
  if (_topicChips is EqualUnmodifiableListView) return _topicChips;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_topicChips);
}

 final  List<SocialFeedItem> _items;
@override@JsonKey() List<SocialFeedItem> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override final  SocialFeedMeta? meta;

/// Create a copy of SocialFeed
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SocialFeedCopyWith<_SocialFeed> get copyWith => __$SocialFeedCopyWithImpl<_SocialFeed>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SocialFeedToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SocialFeed&&(identical(other.header, header) || other.header == header)&&(identical(other.composer, composer) || other.composer == composer)&&const DeepCollectionEquality().equals(other.stories, _stories)&&const DeepCollectionEquality().equals(other.tabs, _tabs)&&const DeepCollectionEquality().equals(other.topicChips, _topicChips)&&const DeepCollectionEquality().equals(other.items, _items)&&(identical(other.meta, meta) || other.meta == meta));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,header,composer,const DeepCollectionEquality().hash(_stories),const DeepCollectionEquality().hash(_tabs),const DeepCollectionEquality().hash(_topicChips),const DeepCollectionEquality().hash(_items),meta);
}

@override
String toString() {
    return 'SocialFeed(header: $header, composer: $composer, stories: $stories, tabs: $tabs, topicChips: $topicChips, items: $items, meta: $meta)';
}


}

/// @nodoc
abstract mixin class _$SocialFeedCopyWith<$Res> implements $SocialFeedCopyWith<$Res> {
  factory _$SocialFeedCopyWith(_SocialFeed value, $Res Function(_SocialFeed) _then) = __$SocialFeedCopyWithImpl;
@override @useResult
$Res call({
 SocialFeedHeader header, SocialFeedComposer composer, List<SocialFeedStory> stories, List<SocialFeedTab> tabs, List<SocialFeedTopicChip> topicChips, List<SocialFeedItem> items, SocialFeedMeta? meta
});


@override $SocialFeedHeaderCopyWith<$Res> get header;@override $SocialFeedComposerCopyWith<$Res> get composer;@override $SocialFeedMetaCopyWith<$Res>? get meta;

}
/// @nodoc
class __$SocialFeedCopyWithImpl<$Res>
    implements _$SocialFeedCopyWith<$Res> {
  __$SocialFeedCopyWithImpl(this._self, this._then);

  final _SocialFeed _self;
  final $Res Function(_SocialFeed) _then;

/// Create a copy of SocialFeed
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? header = null,Object? composer = null,Object? stories = null,Object? tabs = null,Object? topicChips = null,Object? items = null,Object? meta = freezed,}) {
  return _then(_SocialFeed(
header: null == header ? _self.header : header // ignore: cast_nullable_to_non_nullable
as SocialFeedHeader,composer: null == composer ? _self.composer : composer // ignore: cast_nullable_to_non_nullable
as SocialFeedComposer,stories: null == stories ? _self._stories : stories // ignore: cast_nullable_to_non_nullable
as List<SocialFeedStory>,tabs: null == tabs ? _self._tabs : tabs // ignore: cast_nullable_to_non_nullable
as List<SocialFeedTab>,topicChips: null == topicChips ? _self._topicChips : topicChips // ignore: cast_nullable_to_non_nullable
as List<SocialFeedTopicChip>,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<SocialFeedItem>,meta: freezed == meta ? _self.meta : meta // ignore: cast_nullable_to_non_nullable
as SocialFeedMeta?,
  ));
}

/// Create a copy of SocialFeed
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SocialFeedHeaderCopyWith<$Res> get header {
  
  return $SocialFeedHeaderCopyWith<$Res>(_self.header, (value) {
    return _then(_self.copyWith(header: value));
  });
}/// Create a copy of SocialFeed
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SocialFeedComposerCopyWith<$Res> get composer {
  
  return $SocialFeedComposerCopyWith<$Res>(_self.composer, (value) {
    return _then(_self.copyWith(composer: value));
  });
}/// Create a copy of SocialFeed
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SocialFeedMetaCopyWith<$Res>? get meta {
    if (_self.meta == null) {
    return null;
  }

  return $SocialFeedMetaCopyWith<$Res>(_self.meta!, (value) {
    return _then(_self.copyWith(meta: value));
  });
}
}


/// @nodoc
mixin _$SocialFeedMeta {

@JsonKey(fromJson: _readInt) int get page;@JsonKey(fromJson: _readInt) int get limit;@JsonKey(fromJson: _readInt) int get total;@JsonKey(fromJson: _readInt) int get totalPages; bool get hasNextPage; bool get hasPreviousPage;
/// Create a copy of SocialFeedMeta
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SocialFeedMetaCopyWith<SocialFeedMeta> get copyWith => _$SocialFeedMetaCopyWithImpl<SocialFeedMeta>(this as SocialFeedMeta, _$identity);

  /// Serializes this SocialFeedMeta to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SocialFeedMeta;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SocialFeedMeta&&(identical(other.page, _this.page) || other.page == _this.page)&&(identical(other.limit, _this.limit) || other.limit == _this.limit)&&(identical(other.total, _this.total) || other.total == _this.total)&&(identical(other.totalPages, _this.totalPages) || other.totalPages == _this.totalPages)&&(identical(other.hasNextPage, _this.hasNextPage) || other.hasNextPage == _this.hasNextPage)&&(identical(other.hasPreviousPage, _this.hasPreviousPage) || other.hasPreviousPage == _this.hasPreviousPage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SocialFeedMeta;
  return Object.hash(runtimeType,_this.page,_this.limit,_this.total,_this.totalPages,_this.hasNextPage,_this.hasPreviousPage);
}

@override
String toString() {
  final _this = this as SocialFeedMeta;
  return 'SocialFeedMeta(page: ${_this.page}, limit: ${_this.limit}, total: ${_this.total}, totalPages: ${_this.totalPages}, hasNextPage: ${_this.hasNextPage}, hasPreviousPage: ${_this.hasPreviousPage})';
}


}

/// @nodoc
abstract mixin class $SocialFeedMetaCopyWith<$Res>  {
  factory $SocialFeedMetaCopyWith(SocialFeedMeta value, $Res Function(SocialFeedMeta) _then) = _$SocialFeedMetaCopyWithImpl;
@useResult
$Res call({
@JsonKey(fromJson: _readInt) int page,@JsonKey(fromJson: _readInt) int limit,@JsonKey(fromJson: _readInt) int total,@JsonKey(fromJson: _readInt) int totalPages, bool hasNextPage, bool hasPreviousPage
});




}
/// @nodoc
class _$SocialFeedMetaCopyWithImpl<$Res>
    implements $SocialFeedMetaCopyWith<$Res> {
  _$SocialFeedMetaCopyWithImpl(this._self, this._then);

  final SocialFeedMeta _self;
  final $Res Function(SocialFeedMeta) _then;

/// Create a copy of SocialFeedMeta
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? page = null,Object? limit = null,Object? total = null,Object? totalPages = null,Object? hasNextPage = null,Object? hasPreviousPage = null,}) {
  return _then(SocialFeedMeta(
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


/// Adds pattern-matching-related methods to [SocialFeedMeta].
extension SocialFeedMetaPatterns on SocialFeedMeta {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SocialFeedMeta value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SocialFeedMeta() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SocialFeedMeta value)  $default,){
final _that = this;
switch (_that) {
case _SocialFeedMeta():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SocialFeedMeta value)?  $default,){
final _that = this;
switch (_that) {
case _SocialFeedMeta() when $default != null:
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
case _SocialFeedMeta() when $default != null:
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
case _SocialFeedMeta():
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
case _SocialFeedMeta() when $default != null:
return $default(_that.page,_that.limit,_that.total,_that.totalPages,_that.hasNextPage,_that.hasPreviousPage);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SocialFeedMeta implements SocialFeedMeta {
  const _SocialFeedMeta({@JsonKey(fromJson: _readInt) this.page = 1, @JsonKey(fromJson: _readInt) this.limit = 10, @JsonKey(fromJson: _readInt) this.total = 0, @JsonKey(fromJson: _readInt) this.totalPages = 0, this.hasNextPage = false, this.hasPreviousPage = false});
  factory _SocialFeedMeta.fromJson(Map<String, dynamic> json) => _$SocialFeedMetaFromJson(json);

@override@JsonKey(fromJson: _readInt) final  int page;
@override@JsonKey(fromJson: _readInt) final  int limit;
@override@JsonKey(fromJson: _readInt) final  int total;
@override@JsonKey(fromJson: _readInt) final  int totalPages;
@override@JsonKey() final  bool hasNextPage;
@override@JsonKey() final  bool hasPreviousPage;

/// Create a copy of SocialFeedMeta
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SocialFeedMetaCopyWith<_SocialFeedMeta> get copyWith => __$SocialFeedMetaCopyWithImpl<_SocialFeedMeta>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SocialFeedMetaToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SocialFeedMeta&&(identical(other.page, page) || other.page == page)&&(identical(other.limit, limit) || other.limit == limit)&&(identical(other.total, total) || other.total == total)&&(identical(other.totalPages, totalPages) || other.totalPages == totalPages)&&(identical(other.hasNextPage, hasNextPage) || other.hasNextPage == hasNextPage)&&(identical(other.hasPreviousPage, hasPreviousPage) || other.hasPreviousPage == hasPreviousPage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,page,limit,total,totalPages,hasNextPage,hasPreviousPage);
}

@override
String toString() {
    return 'SocialFeedMeta(page: $page, limit: $limit, total: $total, totalPages: $totalPages, hasNextPage: $hasNextPage, hasPreviousPage: $hasPreviousPage)';
}


}

/// @nodoc
abstract mixin class _$SocialFeedMetaCopyWith<$Res> implements $SocialFeedMetaCopyWith<$Res> {
  factory _$SocialFeedMetaCopyWith(_SocialFeedMeta value, $Res Function(_SocialFeedMeta) _then) = __$SocialFeedMetaCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(fromJson: _readInt) int page,@JsonKey(fromJson: _readInt) int limit,@JsonKey(fromJson: _readInt) int total,@JsonKey(fromJson: _readInt) int totalPages, bool hasNextPage, bool hasPreviousPage
});




}
/// @nodoc
class __$SocialFeedMetaCopyWithImpl<$Res>
    implements _$SocialFeedMetaCopyWith<$Res> {
  __$SocialFeedMetaCopyWithImpl(this._self, this._then);

  final _SocialFeedMeta _self;
  final $Res Function(_SocialFeedMeta) _then;

/// Create a copy of SocialFeedMeta
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? page = null,Object? limit = null,Object? total = null,Object? totalPages = null,Object? hasNextPage = null,Object? hasPreviousPage = null,}) {
  return _then(_SocialFeedMeta(
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
mixin _$SocialFeedHeader {

 String get title; String get streakLabel; bool get hasUnreadNotifications; bool get showFriendsCta;
/// Create a copy of SocialFeedHeader
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SocialFeedHeaderCopyWith<SocialFeedHeader> get copyWith => _$SocialFeedHeaderCopyWithImpl<SocialFeedHeader>(this as SocialFeedHeader, _$identity);

  /// Serializes this SocialFeedHeader to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SocialFeedHeader;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SocialFeedHeader&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.streakLabel, _this.streakLabel) || other.streakLabel == _this.streakLabel)&&(identical(other.hasUnreadNotifications, _this.hasUnreadNotifications) || other.hasUnreadNotifications == _this.hasUnreadNotifications)&&(identical(other.showFriendsCta, _this.showFriendsCta) || other.showFriendsCta == _this.showFriendsCta));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SocialFeedHeader;
  return Object.hash(runtimeType,_this.title,_this.streakLabel,_this.hasUnreadNotifications,_this.showFriendsCta);
}

@override
String toString() {
  final _this = this as SocialFeedHeader;
  return 'SocialFeedHeader(title: ${_this.title}, streakLabel: ${_this.streakLabel}, hasUnreadNotifications: ${_this.hasUnreadNotifications}, showFriendsCta: ${_this.showFriendsCta})';
}


}

/// @nodoc
abstract mixin class $SocialFeedHeaderCopyWith<$Res>  {
  factory $SocialFeedHeaderCopyWith(SocialFeedHeader value, $Res Function(SocialFeedHeader) _then) = _$SocialFeedHeaderCopyWithImpl;
@useResult
$Res call({
 String title, String streakLabel, bool hasUnreadNotifications, bool showFriendsCta
});




}
/// @nodoc
class _$SocialFeedHeaderCopyWithImpl<$Res>
    implements $SocialFeedHeaderCopyWith<$Res> {
  _$SocialFeedHeaderCopyWithImpl(this._self, this._then);

  final SocialFeedHeader _self;
  final $Res Function(SocialFeedHeader) _then;

/// Create a copy of SocialFeedHeader
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? streakLabel = null,Object? hasUnreadNotifications = null,Object? showFriendsCta = null,}) {
  return _then(SocialFeedHeader(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,streakLabel: null == streakLabel ? _self.streakLabel : streakLabel // ignore: cast_nullable_to_non_nullable
as String,hasUnreadNotifications: null == hasUnreadNotifications ? _self.hasUnreadNotifications : hasUnreadNotifications // ignore: cast_nullable_to_non_nullable
as bool,showFriendsCta: null == showFriendsCta ? _self.showFriendsCta : showFriendsCta // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [SocialFeedHeader].
extension SocialFeedHeaderPatterns on SocialFeedHeader {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SocialFeedHeader value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SocialFeedHeader() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SocialFeedHeader value)  $default,){
final _that = this;
switch (_that) {
case _SocialFeedHeader():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SocialFeedHeader value)?  $default,){
final _that = this;
switch (_that) {
case _SocialFeedHeader() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String title,  String streakLabel,  bool hasUnreadNotifications,  bool showFriendsCta)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SocialFeedHeader() when $default != null:
return $default(_that.title,_that.streakLabel,_that.hasUnreadNotifications,_that.showFriendsCta);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String title,  String streakLabel,  bool hasUnreadNotifications,  bool showFriendsCta)  $default,) {final _that = this;
switch (_that) {
case _SocialFeedHeader():
return $default(_that.title,_that.streakLabel,_that.hasUnreadNotifications,_that.showFriendsCta);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String title,  String streakLabel,  bool hasUnreadNotifications,  bool showFriendsCta)?  $default,) {final _that = this;
switch (_that) {
case _SocialFeedHeader() when $default != null:
return $default(_that.title,_that.streakLabel,_that.hasUnreadNotifications,_that.showFriendsCta);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SocialFeedHeader implements SocialFeedHeader {
  const _SocialFeedHeader({required this.title, required this.streakLabel, this.hasUnreadNotifications = false, this.showFriendsCta = true});
  factory _SocialFeedHeader.fromJson(Map<String, dynamic> json) => _$SocialFeedHeaderFromJson(json);

@override final  String title;
@override final  String streakLabel;
@override@JsonKey() final  bool hasUnreadNotifications;
@override@JsonKey() final  bool showFriendsCta;

/// Create a copy of SocialFeedHeader
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SocialFeedHeaderCopyWith<_SocialFeedHeader> get copyWith => __$SocialFeedHeaderCopyWithImpl<_SocialFeedHeader>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SocialFeedHeaderToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SocialFeedHeader&&(identical(other.title, title) || other.title == title)&&(identical(other.streakLabel, streakLabel) || other.streakLabel == streakLabel)&&(identical(other.hasUnreadNotifications, hasUnreadNotifications) || other.hasUnreadNotifications == hasUnreadNotifications)&&(identical(other.showFriendsCta, showFriendsCta) || other.showFriendsCta == showFriendsCta));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,title,streakLabel,hasUnreadNotifications,showFriendsCta);
}

@override
String toString() {
    return 'SocialFeedHeader(title: $title, streakLabel: $streakLabel, hasUnreadNotifications: $hasUnreadNotifications, showFriendsCta: $showFriendsCta)';
}


}

/// @nodoc
abstract mixin class _$SocialFeedHeaderCopyWith<$Res> implements $SocialFeedHeaderCopyWith<$Res> {
  factory _$SocialFeedHeaderCopyWith(_SocialFeedHeader value, $Res Function(_SocialFeedHeader) _then) = __$SocialFeedHeaderCopyWithImpl;
@override @useResult
$Res call({
 String title, String streakLabel, bool hasUnreadNotifications, bool showFriendsCta
});




}
/// @nodoc
class __$SocialFeedHeaderCopyWithImpl<$Res>
    implements _$SocialFeedHeaderCopyWith<$Res> {
  __$SocialFeedHeaderCopyWithImpl(this._self, this._then);

  final _SocialFeedHeader _self;
  final $Res Function(_SocialFeedHeader) _then;

/// Create a copy of SocialFeedHeader
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? streakLabel = null,Object? hasUnreadNotifications = null,Object? showFriendsCta = null,}) {
  return _then(_SocialFeedHeader(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,streakLabel: null == streakLabel ? _self.streakLabel : streakLabel // ignore: cast_nullable_to_non_nullable
as String,hasUnreadNotifications: null == hasUnreadNotifications ? _self.hasUnreadNotifications : hasUnreadNotifications // ignore: cast_nullable_to_non_nullable
as bool,showFriendsCta: null == showFriendsCta ? _self.showFriendsCta : showFriendsCta // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$SocialFeedComposer {

 String get displayName; String? get avatarUrl; String get prompt;
/// Create a copy of SocialFeedComposer
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SocialFeedComposerCopyWith<SocialFeedComposer> get copyWith => _$SocialFeedComposerCopyWithImpl<SocialFeedComposer>(this as SocialFeedComposer, _$identity);

  /// Serializes this SocialFeedComposer to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SocialFeedComposer;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SocialFeedComposer&&(identical(other.displayName, _this.displayName) || other.displayName == _this.displayName)&&(identical(other.avatarUrl, _this.avatarUrl) || other.avatarUrl == _this.avatarUrl)&&(identical(other.prompt, _this.prompt) || other.prompt == _this.prompt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SocialFeedComposer;
  return Object.hash(runtimeType,_this.displayName,_this.avatarUrl,_this.prompt);
}

@override
String toString() {
  final _this = this as SocialFeedComposer;
  return 'SocialFeedComposer(displayName: ${_this.displayName}, avatarUrl: ${_this.avatarUrl}, prompt: ${_this.prompt})';
}


}

/// @nodoc
abstract mixin class $SocialFeedComposerCopyWith<$Res>  {
  factory $SocialFeedComposerCopyWith(SocialFeedComposer value, $Res Function(SocialFeedComposer) _then) = _$SocialFeedComposerCopyWithImpl;
@useResult
$Res call({
 String displayName, String? avatarUrl, String prompt
});




}
/// @nodoc
class _$SocialFeedComposerCopyWithImpl<$Res>
    implements $SocialFeedComposerCopyWith<$Res> {
  _$SocialFeedComposerCopyWithImpl(this._self, this._then);

  final SocialFeedComposer _self;
  final $Res Function(SocialFeedComposer) _then;

/// Create a copy of SocialFeedComposer
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? displayName = null,Object? avatarUrl = freezed,Object? prompt = null,}) {
  return _then(SocialFeedComposer(
displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,prompt: null == prompt ? _self.prompt : prompt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [SocialFeedComposer].
extension SocialFeedComposerPatterns on SocialFeedComposer {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SocialFeedComposer value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SocialFeedComposer() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SocialFeedComposer value)  $default,){
final _that = this;
switch (_that) {
case _SocialFeedComposer():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SocialFeedComposer value)?  $default,){
final _that = this;
switch (_that) {
case _SocialFeedComposer() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String displayName,  String? avatarUrl,  String prompt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SocialFeedComposer() when $default != null:
return $default(_that.displayName,_that.avatarUrl,_that.prompt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String displayName,  String? avatarUrl,  String prompt)  $default,) {final _that = this;
switch (_that) {
case _SocialFeedComposer():
return $default(_that.displayName,_that.avatarUrl,_that.prompt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String displayName,  String? avatarUrl,  String prompt)?  $default,) {final _that = this;
switch (_that) {
case _SocialFeedComposer() when $default != null:
return $default(_that.displayName,_that.avatarUrl,_that.prompt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SocialFeedComposer implements SocialFeedComposer {
  const _SocialFeedComposer({required this.displayName, this.avatarUrl, required this.prompt});
  factory _SocialFeedComposer.fromJson(Map<String, dynamic> json) => _$SocialFeedComposerFromJson(json);

@override final  String displayName;
@override final  String? avatarUrl;
@override final  String prompt;

/// Create a copy of SocialFeedComposer
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SocialFeedComposerCopyWith<_SocialFeedComposer> get copyWith => __$SocialFeedComposerCopyWithImpl<_SocialFeedComposer>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SocialFeedComposerToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SocialFeedComposer&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.prompt, prompt) || other.prompt == prompt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,displayName,avatarUrl,prompt);
}

@override
String toString() {
    return 'SocialFeedComposer(displayName: $displayName, avatarUrl: $avatarUrl, prompt: $prompt)';
}


}

/// @nodoc
abstract mixin class _$SocialFeedComposerCopyWith<$Res> implements $SocialFeedComposerCopyWith<$Res> {
  factory _$SocialFeedComposerCopyWith(_SocialFeedComposer value, $Res Function(_SocialFeedComposer) _then) = __$SocialFeedComposerCopyWithImpl;
@override @useResult
$Res call({
 String displayName, String? avatarUrl, String prompt
});




}
/// @nodoc
class __$SocialFeedComposerCopyWithImpl<$Res>
    implements _$SocialFeedComposerCopyWith<$Res> {
  __$SocialFeedComposerCopyWithImpl(this._self, this._then);

  final _SocialFeedComposer _self;
  final $Res Function(_SocialFeedComposer) _then;

/// Create a copy of SocialFeedComposer
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? displayName = null,Object? avatarUrl = freezed,Object? prompt = null,}) {
  return _then(_SocialFeedComposer(
displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,prompt: null == prompt ? _self.prompt : prompt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$SocialFeedStory {

 String get id; String get label; String? get imageUrl; bool get isSelf; bool get isActive; SocialFeedStoryBadge get badge;
/// Create a copy of SocialFeedStory
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SocialFeedStoryCopyWith<SocialFeedStory> get copyWith => _$SocialFeedStoryCopyWithImpl<SocialFeedStory>(this as SocialFeedStory, _$identity);

  /// Serializes this SocialFeedStory to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SocialFeedStory;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SocialFeedStory&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.label, _this.label) || other.label == _this.label)&&(identical(other.imageUrl, _this.imageUrl) || other.imageUrl == _this.imageUrl)&&(identical(other.isSelf, _this.isSelf) || other.isSelf == _this.isSelf)&&(identical(other.isActive, _this.isActive) || other.isActive == _this.isActive)&&(identical(other.badge, _this.badge) || other.badge == _this.badge));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SocialFeedStory;
  return Object.hash(runtimeType,_this.id,_this.label,_this.imageUrl,_this.isSelf,_this.isActive,_this.badge);
}

@override
String toString() {
  final _this = this as SocialFeedStory;
  return 'SocialFeedStory(id: ${_this.id}, label: ${_this.label}, imageUrl: ${_this.imageUrl}, isSelf: ${_this.isSelf}, isActive: ${_this.isActive}, badge: ${_this.badge})';
}


}

/// @nodoc
abstract mixin class $SocialFeedStoryCopyWith<$Res>  {
  factory $SocialFeedStoryCopyWith(SocialFeedStory value, $Res Function(SocialFeedStory) _then) = _$SocialFeedStoryCopyWithImpl;
@useResult
$Res call({
 String id, String label, String? imageUrl, bool isSelf, bool isActive, SocialFeedStoryBadge badge
});




}
/// @nodoc
class _$SocialFeedStoryCopyWithImpl<$Res>
    implements $SocialFeedStoryCopyWith<$Res> {
  _$SocialFeedStoryCopyWithImpl(this._self, this._then);

  final SocialFeedStory _self;
  final $Res Function(SocialFeedStory) _then;

/// Create a copy of SocialFeedStory
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? label = null,Object? imageUrl = freezed,Object? isSelf = null,Object? isActive = null,Object? badge = null,}) {
  return _then(SocialFeedStory(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,isSelf: null == isSelf ? _self.isSelf : isSelf // ignore: cast_nullable_to_non_nullable
as bool,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,badge: null == badge ? _self.badge : badge // ignore: cast_nullable_to_non_nullable
as SocialFeedStoryBadge,
  ));
}

}


/// Adds pattern-matching-related methods to [SocialFeedStory].
extension SocialFeedStoryPatterns on SocialFeedStory {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SocialFeedStory value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SocialFeedStory() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SocialFeedStory value)  $default,){
final _that = this;
switch (_that) {
case _SocialFeedStory():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SocialFeedStory value)?  $default,){
final _that = this;
switch (_that) {
case _SocialFeedStory() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String label,  String? imageUrl,  bool isSelf,  bool isActive,  SocialFeedStoryBadge badge)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SocialFeedStory() when $default != null:
return $default(_that.id,_that.label,_that.imageUrl,_that.isSelf,_that.isActive,_that.badge);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String label,  String? imageUrl,  bool isSelf,  bool isActive,  SocialFeedStoryBadge badge)  $default,) {final _that = this;
switch (_that) {
case _SocialFeedStory():
return $default(_that.id,_that.label,_that.imageUrl,_that.isSelf,_that.isActive,_that.badge);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String label,  String? imageUrl,  bool isSelf,  bool isActive,  SocialFeedStoryBadge badge)?  $default,) {final _that = this;
switch (_that) {
case _SocialFeedStory() when $default != null:
return $default(_that.id,_that.label,_that.imageUrl,_that.isSelf,_that.isActive,_that.badge);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SocialFeedStory implements SocialFeedStory {
  const _SocialFeedStory({required this.id, required this.label, this.imageUrl, this.isSelf = false, this.isActive = false, this.badge = SocialFeedStoryBadge.none});
  factory _SocialFeedStory.fromJson(Map<String, dynamic> json) => _$SocialFeedStoryFromJson(json);

@override final  String id;
@override final  String label;
@override final  String? imageUrl;
@override@JsonKey() final  bool isSelf;
@override@JsonKey() final  bool isActive;
@override@JsonKey() final  SocialFeedStoryBadge badge;

/// Create a copy of SocialFeedStory
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SocialFeedStoryCopyWith<_SocialFeedStory> get copyWith => __$SocialFeedStoryCopyWithImpl<_SocialFeedStory>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SocialFeedStoryToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SocialFeedStory&&(identical(other.id, id) || other.id == id)&&(identical(other.label, label) || other.label == label)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.isSelf, isSelf) || other.isSelf == isSelf)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.badge, badge) || other.badge == badge));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,label,imageUrl,isSelf,isActive,badge);
}

@override
String toString() {
    return 'SocialFeedStory(id: $id, label: $label, imageUrl: $imageUrl, isSelf: $isSelf, isActive: $isActive, badge: $badge)';
}


}

/// @nodoc
abstract mixin class _$SocialFeedStoryCopyWith<$Res> implements $SocialFeedStoryCopyWith<$Res> {
  factory _$SocialFeedStoryCopyWith(_SocialFeedStory value, $Res Function(_SocialFeedStory) _then) = __$SocialFeedStoryCopyWithImpl;
@override @useResult
$Res call({
 String id, String label, String? imageUrl, bool isSelf, bool isActive, SocialFeedStoryBadge badge
});




}
/// @nodoc
class __$SocialFeedStoryCopyWithImpl<$Res>
    implements _$SocialFeedStoryCopyWith<$Res> {
  __$SocialFeedStoryCopyWithImpl(this._self, this._then);

  final _SocialFeedStory _self;
  final $Res Function(_SocialFeedStory) _then;

/// Create a copy of SocialFeedStory
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? label = null,Object? imageUrl = freezed,Object? isSelf = null,Object? isActive = null,Object? badge = null,}) {
  return _then(_SocialFeedStory(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,isSelf: null == isSelf ? _self.isSelf : isSelf // ignore: cast_nullable_to_non_nullable
as bool,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,badge: null == badge ? _self.badge : badge // ignore: cast_nullable_to_non_nullable
as SocialFeedStoryBadge,
  ));
}


}


/// @nodoc
mixin _$SocialFeedTab {

 String get id; String get label; String? get badgeLabel; String? get emoji; bool get selected;
/// Create a copy of SocialFeedTab
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SocialFeedTabCopyWith<SocialFeedTab> get copyWith => _$SocialFeedTabCopyWithImpl<SocialFeedTab>(this as SocialFeedTab, _$identity);

  /// Serializes this SocialFeedTab to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SocialFeedTab;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SocialFeedTab&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.label, _this.label) || other.label == _this.label)&&(identical(other.badgeLabel, _this.badgeLabel) || other.badgeLabel == _this.badgeLabel)&&(identical(other.emoji, _this.emoji) || other.emoji == _this.emoji)&&(identical(other.selected, _this.selected) || other.selected == _this.selected));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SocialFeedTab;
  return Object.hash(runtimeType,_this.id,_this.label,_this.badgeLabel,_this.emoji,_this.selected);
}

@override
String toString() {
  final _this = this as SocialFeedTab;
  return 'SocialFeedTab(id: ${_this.id}, label: ${_this.label}, badgeLabel: ${_this.badgeLabel}, emoji: ${_this.emoji}, selected: ${_this.selected})';
}


}

/// @nodoc
abstract mixin class $SocialFeedTabCopyWith<$Res>  {
  factory $SocialFeedTabCopyWith(SocialFeedTab value, $Res Function(SocialFeedTab) _then) = _$SocialFeedTabCopyWithImpl;
@useResult
$Res call({
 String id, String label, String? badgeLabel, String? emoji, bool selected
});




}
/// @nodoc
class _$SocialFeedTabCopyWithImpl<$Res>
    implements $SocialFeedTabCopyWith<$Res> {
  _$SocialFeedTabCopyWithImpl(this._self, this._then);

  final SocialFeedTab _self;
  final $Res Function(SocialFeedTab) _then;

/// Create a copy of SocialFeedTab
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? label = null,Object? badgeLabel = freezed,Object? emoji = freezed,Object? selected = null,}) {
  return _then(SocialFeedTab(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,badgeLabel: freezed == badgeLabel ? _self.badgeLabel : badgeLabel // ignore: cast_nullable_to_non_nullable
as String?,emoji: freezed == emoji ? _self.emoji : emoji // ignore: cast_nullable_to_non_nullable
as String?,selected: null == selected ? _self.selected : selected // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [SocialFeedTab].
extension SocialFeedTabPatterns on SocialFeedTab {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SocialFeedTab value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SocialFeedTab() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SocialFeedTab value)  $default,){
final _that = this;
switch (_that) {
case _SocialFeedTab():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SocialFeedTab value)?  $default,){
final _that = this;
switch (_that) {
case _SocialFeedTab() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String label,  String? badgeLabel,  String? emoji,  bool selected)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SocialFeedTab() when $default != null:
return $default(_that.id,_that.label,_that.badgeLabel,_that.emoji,_that.selected);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String label,  String? badgeLabel,  String? emoji,  bool selected)  $default,) {final _that = this;
switch (_that) {
case _SocialFeedTab():
return $default(_that.id,_that.label,_that.badgeLabel,_that.emoji,_that.selected);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String label,  String? badgeLabel,  String? emoji,  bool selected)?  $default,) {final _that = this;
switch (_that) {
case _SocialFeedTab() when $default != null:
return $default(_that.id,_that.label,_that.badgeLabel,_that.emoji,_that.selected);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SocialFeedTab implements SocialFeedTab {
  const _SocialFeedTab({required this.id, required this.label, this.badgeLabel, this.emoji, this.selected = false});
  factory _SocialFeedTab.fromJson(Map<String, dynamic> json) => _$SocialFeedTabFromJson(json);

@override final  String id;
@override final  String label;
@override final  String? badgeLabel;
@override final  String? emoji;
@override@JsonKey() final  bool selected;

/// Create a copy of SocialFeedTab
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SocialFeedTabCopyWith<_SocialFeedTab> get copyWith => __$SocialFeedTabCopyWithImpl<_SocialFeedTab>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SocialFeedTabToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SocialFeedTab&&(identical(other.id, id) || other.id == id)&&(identical(other.label, label) || other.label == label)&&(identical(other.badgeLabel, badgeLabel) || other.badgeLabel == badgeLabel)&&(identical(other.emoji, emoji) || other.emoji == emoji)&&(identical(other.selected, selected) || other.selected == selected));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,label,badgeLabel,emoji,selected);
}

@override
String toString() {
    return 'SocialFeedTab(id: $id, label: $label, badgeLabel: $badgeLabel, emoji: $emoji, selected: $selected)';
}


}

/// @nodoc
abstract mixin class _$SocialFeedTabCopyWith<$Res> implements $SocialFeedTabCopyWith<$Res> {
  factory _$SocialFeedTabCopyWith(_SocialFeedTab value, $Res Function(_SocialFeedTab) _then) = __$SocialFeedTabCopyWithImpl;
@override @useResult
$Res call({
 String id, String label, String? badgeLabel, String? emoji, bool selected
});




}
/// @nodoc
class __$SocialFeedTabCopyWithImpl<$Res>
    implements _$SocialFeedTabCopyWith<$Res> {
  __$SocialFeedTabCopyWithImpl(this._self, this._then);

  final _SocialFeedTab _self;
  final $Res Function(_SocialFeedTab) _then;

/// Create a copy of SocialFeedTab
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? label = null,Object? badgeLabel = freezed,Object? emoji = freezed,Object? selected = null,}) {
  return _then(_SocialFeedTab(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,badgeLabel: freezed == badgeLabel ? _self.badgeLabel : badgeLabel // ignore: cast_nullable_to_non_nullable
as String?,emoji: freezed == emoji ? _self.emoji : emoji // ignore: cast_nullable_to_non_nullable
as String?,selected: null == selected ? _self.selected : selected // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$SocialFeedTopicChip {

 String get id; String get label; bool get selected;
/// Create a copy of SocialFeedTopicChip
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SocialFeedTopicChipCopyWith<SocialFeedTopicChip> get copyWith => _$SocialFeedTopicChipCopyWithImpl<SocialFeedTopicChip>(this as SocialFeedTopicChip, _$identity);

  /// Serializes this SocialFeedTopicChip to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SocialFeedTopicChip;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SocialFeedTopicChip&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.label, _this.label) || other.label == _this.label)&&(identical(other.selected, _this.selected) || other.selected == _this.selected));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SocialFeedTopicChip;
  return Object.hash(runtimeType,_this.id,_this.label,_this.selected);
}

@override
String toString() {
  final _this = this as SocialFeedTopicChip;
  return 'SocialFeedTopicChip(id: ${_this.id}, label: ${_this.label}, selected: ${_this.selected})';
}


}

/// @nodoc
abstract mixin class $SocialFeedTopicChipCopyWith<$Res>  {
  factory $SocialFeedTopicChipCopyWith(SocialFeedTopicChip value, $Res Function(SocialFeedTopicChip) _then) = _$SocialFeedTopicChipCopyWithImpl;
@useResult
$Res call({
 String id, String label, bool selected
});




}
/// @nodoc
class _$SocialFeedTopicChipCopyWithImpl<$Res>
    implements $SocialFeedTopicChipCopyWith<$Res> {
  _$SocialFeedTopicChipCopyWithImpl(this._self, this._then);

  final SocialFeedTopicChip _self;
  final $Res Function(SocialFeedTopicChip) _then;

/// Create a copy of SocialFeedTopicChip
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? label = null,Object? selected = null,}) {
  return _then(SocialFeedTopicChip(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,selected: null == selected ? _self.selected : selected // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [SocialFeedTopicChip].
extension SocialFeedTopicChipPatterns on SocialFeedTopicChip {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SocialFeedTopicChip value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SocialFeedTopicChip() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SocialFeedTopicChip value)  $default,){
final _that = this;
switch (_that) {
case _SocialFeedTopicChip():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SocialFeedTopicChip value)?  $default,){
final _that = this;
switch (_that) {
case _SocialFeedTopicChip() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String label,  bool selected)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SocialFeedTopicChip() when $default != null:
return $default(_that.id,_that.label,_that.selected);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String label,  bool selected)  $default,) {final _that = this;
switch (_that) {
case _SocialFeedTopicChip():
return $default(_that.id,_that.label,_that.selected);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String label,  bool selected)?  $default,) {final _that = this;
switch (_that) {
case _SocialFeedTopicChip() when $default != null:
return $default(_that.id,_that.label,_that.selected);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SocialFeedTopicChip implements SocialFeedTopicChip {
  const _SocialFeedTopicChip({required this.id, required this.label, this.selected = false});
  factory _SocialFeedTopicChip.fromJson(Map<String, dynamic> json) => _$SocialFeedTopicChipFromJson(json);

@override final  String id;
@override final  String label;
@override@JsonKey() final  bool selected;

/// Create a copy of SocialFeedTopicChip
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SocialFeedTopicChipCopyWith<_SocialFeedTopicChip> get copyWith => __$SocialFeedTopicChipCopyWithImpl<_SocialFeedTopicChip>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SocialFeedTopicChipToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SocialFeedTopicChip&&(identical(other.id, id) || other.id == id)&&(identical(other.label, label) || other.label == label)&&(identical(other.selected, selected) || other.selected == selected));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,label,selected);
}

@override
String toString() {
    return 'SocialFeedTopicChip(id: $id, label: $label, selected: $selected)';
}


}

/// @nodoc
abstract mixin class _$SocialFeedTopicChipCopyWith<$Res> implements $SocialFeedTopicChipCopyWith<$Res> {
  factory _$SocialFeedTopicChipCopyWith(_SocialFeedTopicChip value, $Res Function(_SocialFeedTopicChip) _then) = __$SocialFeedTopicChipCopyWithImpl;
@override @useResult
$Res call({
 String id, String label, bool selected
});




}
/// @nodoc
class __$SocialFeedTopicChipCopyWithImpl<$Res>
    implements _$SocialFeedTopicChipCopyWith<$Res> {
  __$SocialFeedTopicChipCopyWithImpl(this._self, this._then);

  final _SocialFeedTopicChip _self;
  final $Res Function(_SocialFeedTopicChip) _then;

/// Create a copy of SocialFeedTopicChip
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? label = null,Object? selected = null,}) {
  return _then(_SocialFeedTopicChip(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,selected: null == selected ? _self.selected : selected // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$SocialFeedItem {

 String get id; SocialFeedItemType get type; SocialFeedReviewPost? get review; SocialFeedChallenge? get challenge; SocialFeedTripRecruit? get tripRecruit;
/// Create a copy of SocialFeedItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SocialFeedItemCopyWith<SocialFeedItem> get copyWith => _$SocialFeedItemCopyWithImpl<SocialFeedItem>(this as SocialFeedItem, _$identity);

  /// Serializes this SocialFeedItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SocialFeedItem;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SocialFeedItem&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.type, _this.type) || other.type == _this.type)&&(identical(other.review, _this.review) || other.review == _this.review)&&(identical(other.challenge, _this.challenge) || other.challenge == _this.challenge)&&(identical(other.tripRecruit, _this.tripRecruit) || other.tripRecruit == _this.tripRecruit));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SocialFeedItem;
  return Object.hash(runtimeType,_this.id,_this.type,_this.review,_this.challenge,_this.tripRecruit);
}

@override
String toString() {
  final _this = this as SocialFeedItem;
  return 'SocialFeedItem(id: ${_this.id}, type: ${_this.type}, review: ${_this.review}, challenge: ${_this.challenge}, tripRecruit: ${_this.tripRecruit})';
}


}

/// @nodoc
abstract mixin class $SocialFeedItemCopyWith<$Res>  {
  factory $SocialFeedItemCopyWith(SocialFeedItem value, $Res Function(SocialFeedItem) _then) = _$SocialFeedItemCopyWithImpl;
@useResult
$Res call({
 String id, SocialFeedItemType type, SocialFeedReviewPost? review, SocialFeedChallenge? challenge, SocialFeedTripRecruit? tripRecruit
});


$SocialFeedReviewPostCopyWith<$Res>? get review;$SocialFeedChallengeCopyWith<$Res>? get challenge;$SocialFeedTripRecruitCopyWith<$Res>? get tripRecruit;

}
/// @nodoc
class _$SocialFeedItemCopyWithImpl<$Res>
    implements $SocialFeedItemCopyWith<$Res> {
  _$SocialFeedItemCopyWithImpl(this._self, this._then);

  final SocialFeedItem _self;
  final $Res Function(SocialFeedItem) _then;

/// Create a copy of SocialFeedItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? type = null,Object? review = freezed,Object? challenge = freezed,Object? tripRecruit = freezed,}) {
  return _then(SocialFeedItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as SocialFeedItemType,review: freezed == review ? _self.review : review // ignore: cast_nullable_to_non_nullable
as SocialFeedReviewPost?,challenge: freezed == challenge ? _self.challenge : challenge // ignore: cast_nullable_to_non_nullable
as SocialFeedChallenge?,tripRecruit: freezed == tripRecruit ? _self.tripRecruit : tripRecruit // ignore: cast_nullable_to_non_nullable
as SocialFeedTripRecruit?,
  ));
}
/// Create a copy of SocialFeedItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SocialFeedReviewPostCopyWith<$Res>? get review {
    if (_self.review == null) {
    return null;
  }

  return $SocialFeedReviewPostCopyWith<$Res>(_self.review!, (value) {
    return _then(_self.copyWith(review: value));
  });
}/// Create a copy of SocialFeedItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SocialFeedChallengeCopyWith<$Res>? get challenge {
    if (_self.challenge == null) {
    return null;
  }

  return $SocialFeedChallengeCopyWith<$Res>(_self.challenge!, (value) {
    return _then(_self.copyWith(challenge: value));
  });
}/// Create a copy of SocialFeedItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SocialFeedTripRecruitCopyWith<$Res>? get tripRecruit {
    if (_self.tripRecruit == null) {
    return null;
  }

  return $SocialFeedTripRecruitCopyWith<$Res>(_self.tripRecruit!, (value) {
    return _then(_self.copyWith(tripRecruit: value));
  });
}
}


/// Adds pattern-matching-related methods to [SocialFeedItem].
extension SocialFeedItemPatterns on SocialFeedItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SocialFeedItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SocialFeedItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SocialFeedItem value)  $default,){
final _that = this;
switch (_that) {
case _SocialFeedItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SocialFeedItem value)?  $default,){
final _that = this;
switch (_that) {
case _SocialFeedItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  SocialFeedItemType type,  SocialFeedReviewPost? review,  SocialFeedChallenge? challenge,  SocialFeedTripRecruit? tripRecruit)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SocialFeedItem() when $default != null:
return $default(_that.id,_that.type,_that.review,_that.challenge,_that.tripRecruit);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  SocialFeedItemType type,  SocialFeedReviewPost? review,  SocialFeedChallenge? challenge,  SocialFeedTripRecruit? tripRecruit)  $default,) {final _that = this;
switch (_that) {
case _SocialFeedItem():
return $default(_that.id,_that.type,_that.review,_that.challenge,_that.tripRecruit);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  SocialFeedItemType type,  SocialFeedReviewPost? review,  SocialFeedChallenge? challenge,  SocialFeedTripRecruit? tripRecruit)?  $default,) {final _that = this;
switch (_that) {
case _SocialFeedItem() when $default != null:
return $default(_that.id,_that.type,_that.review,_that.challenge,_that.tripRecruit);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SocialFeedItem implements SocialFeedItem {
  const _SocialFeedItem({required this.id, required this.type, this.review, this.challenge, this.tripRecruit});
  factory _SocialFeedItem.fromJson(Map<String, dynamic> json) => _$SocialFeedItemFromJson(json);

@override final  String id;
@override final  SocialFeedItemType type;
@override final  SocialFeedReviewPost? review;
@override final  SocialFeedChallenge? challenge;
@override final  SocialFeedTripRecruit? tripRecruit;

/// Create a copy of SocialFeedItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SocialFeedItemCopyWith<_SocialFeedItem> get copyWith => __$SocialFeedItemCopyWithImpl<_SocialFeedItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SocialFeedItemToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SocialFeedItem&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.review, review) || other.review == review)&&(identical(other.challenge, challenge) || other.challenge == challenge)&&(identical(other.tripRecruit, tripRecruit) || other.tripRecruit == tripRecruit));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,type,review,challenge,tripRecruit);
}

@override
String toString() {
    return 'SocialFeedItem(id: $id, type: $type, review: $review, challenge: $challenge, tripRecruit: $tripRecruit)';
}


}

/// @nodoc
abstract mixin class _$SocialFeedItemCopyWith<$Res> implements $SocialFeedItemCopyWith<$Res> {
  factory _$SocialFeedItemCopyWith(_SocialFeedItem value, $Res Function(_SocialFeedItem) _then) = __$SocialFeedItemCopyWithImpl;
@override @useResult
$Res call({
 String id, SocialFeedItemType type, SocialFeedReviewPost? review, SocialFeedChallenge? challenge, SocialFeedTripRecruit? tripRecruit
});


@override $SocialFeedReviewPostCopyWith<$Res>? get review;@override $SocialFeedChallengeCopyWith<$Res>? get challenge;@override $SocialFeedTripRecruitCopyWith<$Res>? get tripRecruit;

}
/// @nodoc
class __$SocialFeedItemCopyWithImpl<$Res>
    implements _$SocialFeedItemCopyWith<$Res> {
  __$SocialFeedItemCopyWithImpl(this._self, this._then);

  final _SocialFeedItem _self;
  final $Res Function(_SocialFeedItem) _then;

/// Create a copy of SocialFeedItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? type = null,Object? review = freezed,Object? challenge = freezed,Object? tripRecruit = freezed,}) {
  return _then(_SocialFeedItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as SocialFeedItemType,review: freezed == review ? _self.review : review // ignore: cast_nullable_to_non_nullable
as SocialFeedReviewPost?,challenge: freezed == challenge ? _self.challenge : challenge // ignore: cast_nullable_to_non_nullable
as SocialFeedChallenge?,tripRecruit: freezed == tripRecruit ? _self.tripRecruit : tripRecruit // ignore: cast_nullable_to_non_nullable
as SocialFeedTripRecruit?,
  ));
}

/// Create a copy of SocialFeedItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SocialFeedReviewPostCopyWith<$Res>? get review {
    if (_self.review == null) {
    return null;
  }

  return $SocialFeedReviewPostCopyWith<$Res>(_self.review!, (value) {
    return _then(_self.copyWith(review: value));
  });
}/// Create a copy of SocialFeedItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SocialFeedChallengeCopyWith<$Res>? get challenge {
    if (_self.challenge == null) {
    return null;
  }

  return $SocialFeedChallengeCopyWith<$Res>(_self.challenge!, (value) {
    return _then(_self.copyWith(challenge: value));
  });
}/// Create a copy of SocialFeedItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SocialFeedTripRecruitCopyWith<$Res>? get tripRecruit {
    if (_self.tripRecruit == null) {
    return null;
  }

  return $SocialFeedTripRecruitCopyWith<$Res>(_self.tripRecruit!, (value) {
    return _then(_self.copyWith(tripRecruit: value));
  });
}
}


/// @nodoc
mixin _$SocialFeedAuthor {

 String get id; String get displayName; String? get avatarUrl; String? get badgeLabel; bool get verified;
/// Create a copy of SocialFeedAuthor
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SocialFeedAuthorCopyWith<SocialFeedAuthor> get copyWith => _$SocialFeedAuthorCopyWithImpl<SocialFeedAuthor>(this as SocialFeedAuthor, _$identity);

  /// Serializes this SocialFeedAuthor to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SocialFeedAuthor;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SocialFeedAuthor&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.displayName, _this.displayName) || other.displayName == _this.displayName)&&(identical(other.avatarUrl, _this.avatarUrl) || other.avatarUrl == _this.avatarUrl)&&(identical(other.badgeLabel, _this.badgeLabel) || other.badgeLabel == _this.badgeLabel)&&(identical(other.verified, _this.verified) || other.verified == _this.verified));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SocialFeedAuthor;
  return Object.hash(runtimeType,_this.id,_this.displayName,_this.avatarUrl,_this.badgeLabel,_this.verified);
}

@override
String toString() {
  final _this = this as SocialFeedAuthor;
  return 'SocialFeedAuthor(id: ${_this.id}, displayName: ${_this.displayName}, avatarUrl: ${_this.avatarUrl}, badgeLabel: ${_this.badgeLabel}, verified: ${_this.verified})';
}


}

/// @nodoc
abstract mixin class $SocialFeedAuthorCopyWith<$Res>  {
  factory $SocialFeedAuthorCopyWith(SocialFeedAuthor value, $Res Function(SocialFeedAuthor) _then) = _$SocialFeedAuthorCopyWithImpl;
@useResult
$Res call({
 String id, String displayName, String? avatarUrl, String? badgeLabel, bool verified
});




}
/// @nodoc
class _$SocialFeedAuthorCopyWithImpl<$Res>
    implements $SocialFeedAuthorCopyWith<$Res> {
  _$SocialFeedAuthorCopyWithImpl(this._self, this._then);

  final SocialFeedAuthor _self;
  final $Res Function(SocialFeedAuthor) _then;

/// Create a copy of SocialFeedAuthor
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? displayName = null,Object? avatarUrl = freezed,Object? badgeLabel = freezed,Object? verified = null,}) {
  return _then(SocialFeedAuthor(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,badgeLabel: freezed == badgeLabel ? _self.badgeLabel : badgeLabel // ignore: cast_nullable_to_non_nullable
as String?,verified: null == verified ? _self.verified : verified // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [SocialFeedAuthor].
extension SocialFeedAuthorPatterns on SocialFeedAuthor {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SocialFeedAuthor value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SocialFeedAuthor() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SocialFeedAuthor value)  $default,){
final _that = this;
switch (_that) {
case _SocialFeedAuthor():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SocialFeedAuthor value)?  $default,){
final _that = this;
switch (_that) {
case _SocialFeedAuthor() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String displayName,  String? avatarUrl,  String? badgeLabel,  bool verified)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SocialFeedAuthor() when $default != null:
return $default(_that.id,_that.displayName,_that.avatarUrl,_that.badgeLabel,_that.verified);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String displayName,  String? avatarUrl,  String? badgeLabel,  bool verified)  $default,) {final _that = this;
switch (_that) {
case _SocialFeedAuthor():
return $default(_that.id,_that.displayName,_that.avatarUrl,_that.badgeLabel,_that.verified);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String displayName,  String? avatarUrl,  String? badgeLabel,  bool verified)?  $default,) {final _that = this;
switch (_that) {
case _SocialFeedAuthor() when $default != null:
return $default(_that.id,_that.displayName,_that.avatarUrl,_that.badgeLabel,_that.verified);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SocialFeedAuthor implements SocialFeedAuthor {
  const _SocialFeedAuthor({required this.id, required this.displayName, this.avatarUrl, this.badgeLabel, this.verified = false});
  factory _SocialFeedAuthor.fromJson(Map<String, dynamic> json) => _$SocialFeedAuthorFromJson(json);

@override final  String id;
@override final  String displayName;
@override final  String? avatarUrl;
@override final  String? badgeLabel;
@override@JsonKey() final  bool verified;

/// Create a copy of SocialFeedAuthor
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SocialFeedAuthorCopyWith<_SocialFeedAuthor> get copyWith => __$SocialFeedAuthorCopyWithImpl<_SocialFeedAuthor>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SocialFeedAuthorToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SocialFeedAuthor&&(identical(other.id, id) || other.id == id)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.badgeLabel, badgeLabel) || other.badgeLabel == badgeLabel)&&(identical(other.verified, verified) || other.verified == verified));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,displayName,avatarUrl,badgeLabel,verified);
}

@override
String toString() {
    return 'SocialFeedAuthor(id: $id, displayName: $displayName, avatarUrl: $avatarUrl, badgeLabel: $badgeLabel, verified: $verified)';
}


}

/// @nodoc
abstract mixin class _$SocialFeedAuthorCopyWith<$Res> implements $SocialFeedAuthorCopyWith<$Res> {
  factory _$SocialFeedAuthorCopyWith(_SocialFeedAuthor value, $Res Function(_SocialFeedAuthor) _then) = __$SocialFeedAuthorCopyWithImpl;
@override @useResult
$Res call({
 String id, String displayName, String? avatarUrl, String? badgeLabel, bool verified
});




}
/// @nodoc
class __$SocialFeedAuthorCopyWithImpl<$Res>
    implements _$SocialFeedAuthorCopyWith<$Res> {
  __$SocialFeedAuthorCopyWithImpl(this._self, this._then);

  final _SocialFeedAuthor _self;
  final $Res Function(_SocialFeedAuthor) _then;

/// Create a copy of SocialFeedAuthor
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? displayName = null,Object? avatarUrl = freezed,Object? badgeLabel = freezed,Object? verified = null,}) {
  return _then(_SocialFeedAuthor(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,badgeLabel: freezed == badgeLabel ? _self.badgeLabel : badgeLabel // ignore: cast_nullable_to_non_nullable
as String?,verified: null == verified ? _self.verified : verified // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$SocialFeedMedia {

 String get id; String get imageUrl; String? get caption; bool get isHero; String? get overlayLabel;
/// Create a copy of SocialFeedMedia
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SocialFeedMediaCopyWith<SocialFeedMedia> get copyWith => _$SocialFeedMediaCopyWithImpl<SocialFeedMedia>(this as SocialFeedMedia, _$identity);

  /// Serializes this SocialFeedMedia to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SocialFeedMedia;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SocialFeedMedia&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.imageUrl, _this.imageUrl) || other.imageUrl == _this.imageUrl)&&(identical(other.caption, _this.caption) || other.caption == _this.caption)&&(identical(other.isHero, _this.isHero) || other.isHero == _this.isHero)&&(identical(other.overlayLabel, _this.overlayLabel) || other.overlayLabel == _this.overlayLabel));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SocialFeedMedia;
  return Object.hash(runtimeType,_this.id,_this.imageUrl,_this.caption,_this.isHero,_this.overlayLabel);
}

@override
String toString() {
  final _this = this as SocialFeedMedia;
  return 'SocialFeedMedia(id: ${_this.id}, imageUrl: ${_this.imageUrl}, caption: ${_this.caption}, isHero: ${_this.isHero}, overlayLabel: ${_this.overlayLabel})';
}


}

/// @nodoc
abstract mixin class $SocialFeedMediaCopyWith<$Res>  {
  factory $SocialFeedMediaCopyWith(SocialFeedMedia value, $Res Function(SocialFeedMedia) _then) = _$SocialFeedMediaCopyWithImpl;
@useResult
$Res call({
 String id, String imageUrl, String? caption, bool isHero, String? overlayLabel
});




}
/// @nodoc
class _$SocialFeedMediaCopyWithImpl<$Res>
    implements $SocialFeedMediaCopyWith<$Res> {
  _$SocialFeedMediaCopyWithImpl(this._self, this._then);

  final SocialFeedMedia _self;
  final $Res Function(SocialFeedMedia) _then;

/// Create a copy of SocialFeedMedia
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? imageUrl = null,Object? caption = freezed,Object? isHero = null,Object? overlayLabel = freezed,}) {
  return _then(SocialFeedMedia(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,caption: freezed == caption ? _self.caption : caption // ignore: cast_nullable_to_non_nullable
as String?,isHero: null == isHero ? _self.isHero : isHero // ignore: cast_nullable_to_non_nullable
as bool,overlayLabel: freezed == overlayLabel ? _self.overlayLabel : overlayLabel // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SocialFeedMedia].
extension SocialFeedMediaPatterns on SocialFeedMedia {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SocialFeedMedia value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SocialFeedMedia() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SocialFeedMedia value)  $default,){
final _that = this;
switch (_that) {
case _SocialFeedMedia():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SocialFeedMedia value)?  $default,){
final _that = this;
switch (_that) {
case _SocialFeedMedia() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String imageUrl,  String? caption,  bool isHero,  String? overlayLabel)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SocialFeedMedia() when $default != null:
return $default(_that.id,_that.imageUrl,_that.caption,_that.isHero,_that.overlayLabel);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String imageUrl,  String? caption,  bool isHero,  String? overlayLabel)  $default,) {final _that = this;
switch (_that) {
case _SocialFeedMedia():
return $default(_that.id,_that.imageUrl,_that.caption,_that.isHero,_that.overlayLabel);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String imageUrl,  String? caption,  bool isHero,  String? overlayLabel)?  $default,) {final _that = this;
switch (_that) {
case _SocialFeedMedia() when $default != null:
return $default(_that.id,_that.imageUrl,_that.caption,_that.isHero,_that.overlayLabel);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SocialFeedMedia implements SocialFeedMedia {
  const _SocialFeedMedia({required this.id, required this.imageUrl, this.caption, this.isHero = false, this.overlayLabel});
  factory _SocialFeedMedia.fromJson(Map<String, dynamic> json) => _$SocialFeedMediaFromJson(json);

@override final  String id;
@override final  String imageUrl;
@override final  String? caption;
@override@JsonKey() final  bool isHero;
@override final  String? overlayLabel;

/// Create a copy of SocialFeedMedia
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SocialFeedMediaCopyWith<_SocialFeedMedia> get copyWith => __$SocialFeedMediaCopyWithImpl<_SocialFeedMedia>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SocialFeedMediaToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SocialFeedMedia&&(identical(other.id, id) || other.id == id)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.caption, caption) || other.caption == caption)&&(identical(other.isHero, isHero) || other.isHero == isHero)&&(identical(other.overlayLabel, overlayLabel) || other.overlayLabel == overlayLabel));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,imageUrl,caption,isHero,overlayLabel);
}

@override
String toString() {
    return 'SocialFeedMedia(id: $id, imageUrl: $imageUrl, caption: $caption, isHero: $isHero, overlayLabel: $overlayLabel)';
}


}

/// @nodoc
abstract mixin class _$SocialFeedMediaCopyWith<$Res> implements $SocialFeedMediaCopyWith<$Res> {
  factory _$SocialFeedMediaCopyWith(_SocialFeedMedia value, $Res Function(_SocialFeedMedia) _then) = __$SocialFeedMediaCopyWithImpl;
@override @useResult
$Res call({
 String id, String imageUrl, String? caption, bool isHero, String? overlayLabel
});




}
/// @nodoc
class __$SocialFeedMediaCopyWithImpl<$Res>
    implements _$SocialFeedMediaCopyWith<$Res> {
  __$SocialFeedMediaCopyWithImpl(this._self, this._then);

  final _SocialFeedMedia _self;
  final $Res Function(_SocialFeedMedia) _then;

/// Create a copy of SocialFeedMedia
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? imageUrl = null,Object? caption = freezed,Object? isHero = null,Object? overlayLabel = freezed,}) {
  return _then(_SocialFeedMedia(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,caption: freezed == caption ? _self.caption : caption // ignore: cast_nullable_to_non_nullable
as String?,isHero: null == isHero ? _self.isHero : isHero // ignore: cast_nullable_to_non_nullable
as bool,overlayLabel: freezed == overlayLabel ? _self.overlayLabel : overlayLabel // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$SocialFeedPreviewComment {

 String get id; String get authorName; String? get avatarUrl; String get text; String get timeLabel; String? get replyLabel;
/// Create a copy of SocialFeedPreviewComment
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SocialFeedPreviewCommentCopyWith<SocialFeedPreviewComment> get copyWith => _$SocialFeedPreviewCommentCopyWithImpl<SocialFeedPreviewComment>(this as SocialFeedPreviewComment, _$identity);

  /// Serializes this SocialFeedPreviewComment to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SocialFeedPreviewComment;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SocialFeedPreviewComment&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.authorName, _this.authorName) || other.authorName == _this.authorName)&&(identical(other.avatarUrl, _this.avatarUrl) || other.avatarUrl == _this.avatarUrl)&&(identical(other.text, _this.text) || other.text == _this.text)&&(identical(other.timeLabel, _this.timeLabel) || other.timeLabel == _this.timeLabel)&&(identical(other.replyLabel, _this.replyLabel) || other.replyLabel == _this.replyLabel));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SocialFeedPreviewComment;
  return Object.hash(runtimeType,_this.id,_this.authorName,_this.avatarUrl,_this.text,_this.timeLabel,_this.replyLabel);
}

@override
String toString() {
  final _this = this as SocialFeedPreviewComment;
  return 'SocialFeedPreviewComment(id: ${_this.id}, authorName: ${_this.authorName}, avatarUrl: ${_this.avatarUrl}, text: ${_this.text}, timeLabel: ${_this.timeLabel}, replyLabel: ${_this.replyLabel})';
}


}

/// @nodoc
abstract mixin class $SocialFeedPreviewCommentCopyWith<$Res>  {
  factory $SocialFeedPreviewCommentCopyWith(SocialFeedPreviewComment value, $Res Function(SocialFeedPreviewComment) _then) = _$SocialFeedPreviewCommentCopyWithImpl;
@useResult
$Res call({
 String id, String authorName, String? avatarUrl, String text, String timeLabel, String? replyLabel
});




}
/// @nodoc
class _$SocialFeedPreviewCommentCopyWithImpl<$Res>
    implements $SocialFeedPreviewCommentCopyWith<$Res> {
  _$SocialFeedPreviewCommentCopyWithImpl(this._self, this._then);

  final SocialFeedPreviewComment _self;
  final $Res Function(SocialFeedPreviewComment) _then;

/// Create a copy of SocialFeedPreviewComment
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? authorName = null,Object? avatarUrl = freezed,Object? text = null,Object? timeLabel = null,Object? replyLabel = freezed,}) {
  return _then(SocialFeedPreviewComment(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,authorName: null == authorName ? _self.authorName : authorName // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,timeLabel: null == timeLabel ? _self.timeLabel : timeLabel // ignore: cast_nullable_to_non_nullable
as String,replyLabel: freezed == replyLabel ? _self.replyLabel : replyLabel // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SocialFeedPreviewComment].
extension SocialFeedPreviewCommentPatterns on SocialFeedPreviewComment {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SocialFeedPreviewComment value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SocialFeedPreviewComment() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SocialFeedPreviewComment value)  $default,){
final _that = this;
switch (_that) {
case _SocialFeedPreviewComment():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SocialFeedPreviewComment value)?  $default,){
final _that = this;
switch (_that) {
case _SocialFeedPreviewComment() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String authorName,  String? avatarUrl,  String text,  String timeLabel,  String? replyLabel)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SocialFeedPreviewComment() when $default != null:
return $default(_that.id,_that.authorName,_that.avatarUrl,_that.text,_that.timeLabel,_that.replyLabel);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String authorName,  String? avatarUrl,  String text,  String timeLabel,  String? replyLabel)  $default,) {final _that = this;
switch (_that) {
case _SocialFeedPreviewComment():
return $default(_that.id,_that.authorName,_that.avatarUrl,_that.text,_that.timeLabel,_that.replyLabel);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String authorName,  String? avatarUrl,  String text,  String timeLabel,  String? replyLabel)?  $default,) {final _that = this;
switch (_that) {
case _SocialFeedPreviewComment() when $default != null:
return $default(_that.id,_that.authorName,_that.avatarUrl,_that.text,_that.timeLabel,_that.replyLabel);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SocialFeedPreviewComment implements SocialFeedPreviewComment {
  const _SocialFeedPreviewComment({required this.id, required this.authorName, this.avatarUrl, required this.text, required this.timeLabel, this.replyLabel});
  factory _SocialFeedPreviewComment.fromJson(Map<String, dynamic> json) => _$SocialFeedPreviewCommentFromJson(json);

@override final  String id;
@override final  String authorName;
@override final  String? avatarUrl;
@override final  String text;
@override final  String timeLabel;
@override final  String? replyLabel;

/// Create a copy of SocialFeedPreviewComment
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SocialFeedPreviewCommentCopyWith<_SocialFeedPreviewComment> get copyWith => __$SocialFeedPreviewCommentCopyWithImpl<_SocialFeedPreviewComment>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SocialFeedPreviewCommentToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SocialFeedPreviewComment&&(identical(other.id, id) || other.id == id)&&(identical(other.authorName, authorName) || other.authorName == authorName)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.text, text) || other.text == text)&&(identical(other.timeLabel, timeLabel) || other.timeLabel == timeLabel)&&(identical(other.replyLabel, replyLabel) || other.replyLabel == replyLabel));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,authorName,avatarUrl,text,timeLabel,replyLabel);
}

@override
String toString() {
    return 'SocialFeedPreviewComment(id: $id, authorName: $authorName, avatarUrl: $avatarUrl, text: $text, timeLabel: $timeLabel, replyLabel: $replyLabel)';
}


}

/// @nodoc
abstract mixin class _$SocialFeedPreviewCommentCopyWith<$Res> implements $SocialFeedPreviewCommentCopyWith<$Res> {
  factory _$SocialFeedPreviewCommentCopyWith(_SocialFeedPreviewComment value, $Res Function(_SocialFeedPreviewComment) _then) = __$SocialFeedPreviewCommentCopyWithImpl;
@override @useResult
$Res call({
 String id, String authorName, String? avatarUrl, String text, String timeLabel, String? replyLabel
});




}
/// @nodoc
class __$SocialFeedPreviewCommentCopyWithImpl<$Res>
    implements _$SocialFeedPreviewCommentCopyWith<$Res> {
  __$SocialFeedPreviewCommentCopyWithImpl(this._self, this._then);

  final _SocialFeedPreviewComment _self;
  final $Res Function(_SocialFeedPreviewComment) _then;

/// Create a copy of SocialFeedPreviewComment
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? authorName = null,Object? avatarUrl = freezed,Object? text = null,Object? timeLabel = null,Object? replyLabel = freezed,}) {
  return _then(_SocialFeedPreviewComment(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,authorName: null == authorName ? _self.authorName : authorName // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,timeLabel: null == timeLabel ? _self.timeLabel : timeLabel // ignore: cast_nullable_to_non_nullable
as String,replyLabel: freezed == replyLabel ? _self.replyLabel : replyLabel // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$SocialFeedReviewPost {

 String get postId; SocialFeedAuthor get author; String get timeLabel; String? get trendLabel; String? get placeLabel; String? get placeDetail; String? get placeId; String? get savedByLabel; String get caption; String? get tipTitle; String? get tipBody; List<SocialFeedMedia> get medias;@JsonKey(fromJson: _readInt) int get extraMediaCount; String? get primaryCtaLabel; String? get secondaryCtaLabel;@JsonKey(fromJson: _readInt) int get likesCount;@JsonKey(fromJson: _readInt) int get commentsCount;@JsonKey(fromJson: _readInt) int get savesCount; bool get liked; bool get bookmarked; SocialFeedPreviewComment? get previewComment;
/// Create a copy of SocialFeedReviewPost
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SocialFeedReviewPostCopyWith<SocialFeedReviewPost> get copyWith => _$SocialFeedReviewPostCopyWithImpl<SocialFeedReviewPost>(this as SocialFeedReviewPost, _$identity);

  /// Serializes this SocialFeedReviewPost to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SocialFeedReviewPost;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SocialFeedReviewPost&&(identical(other.postId, _this.postId) || other.postId == _this.postId)&&(identical(other.author, _this.author) || other.author == _this.author)&&(identical(other.timeLabel, _this.timeLabel) || other.timeLabel == _this.timeLabel)&&(identical(other.trendLabel, _this.trendLabel) || other.trendLabel == _this.trendLabel)&&(identical(other.placeLabel, _this.placeLabel) || other.placeLabel == _this.placeLabel)&&(identical(other.placeDetail, _this.placeDetail) || other.placeDetail == _this.placeDetail)&&(identical(other.placeId, _this.placeId) || other.placeId == _this.placeId)&&(identical(other.savedByLabel, _this.savedByLabel) || other.savedByLabel == _this.savedByLabel)&&(identical(other.caption, _this.caption) || other.caption == _this.caption)&&(identical(other.tipTitle, _this.tipTitle) || other.tipTitle == _this.tipTitle)&&(identical(other.tipBody, _this.tipBody) || other.tipBody == _this.tipBody)&&const DeepCollectionEquality().equals(other.medias, _this.medias)&&(identical(other.extraMediaCount, _this.extraMediaCount) || other.extraMediaCount == _this.extraMediaCount)&&(identical(other.primaryCtaLabel, _this.primaryCtaLabel) || other.primaryCtaLabel == _this.primaryCtaLabel)&&(identical(other.secondaryCtaLabel, _this.secondaryCtaLabel) || other.secondaryCtaLabel == _this.secondaryCtaLabel)&&(identical(other.likesCount, _this.likesCount) || other.likesCount == _this.likesCount)&&(identical(other.commentsCount, _this.commentsCount) || other.commentsCount == _this.commentsCount)&&(identical(other.savesCount, _this.savesCount) || other.savesCount == _this.savesCount)&&(identical(other.liked, _this.liked) || other.liked == _this.liked)&&(identical(other.bookmarked, _this.bookmarked) || other.bookmarked == _this.bookmarked)&&(identical(other.previewComment, _this.previewComment) || other.previewComment == _this.previewComment));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SocialFeedReviewPost;
  return Object.hashAll([runtimeType,_this.postId,_this.author,_this.timeLabel,_this.trendLabel,_this.placeLabel,_this.placeDetail,_this.placeId,_this.savedByLabel,_this.caption,_this.tipTitle,_this.tipBody,const DeepCollectionEquality().hash(_this.medias),_this.extraMediaCount,_this.primaryCtaLabel,_this.secondaryCtaLabel,_this.likesCount,_this.commentsCount,_this.savesCount,_this.liked,_this.bookmarked,_this.previewComment]);
}

@override
String toString() {
  final _this = this as SocialFeedReviewPost;
  return 'SocialFeedReviewPost(postId: ${_this.postId}, author: ${_this.author}, timeLabel: ${_this.timeLabel}, trendLabel: ${_this.trendLabel}, placeLabel: ${_this.placeLabel}, placeDetail: ${_this.placeDetail}, placeId: ${_this.placeId}, savedByLabel: ${_this.savedByLabel}, caption: ${_this.caption}, tipTitle: ${_this.tipTitle}, tipBody: ${_this.tipBody}, medias: ${_this.medias}, extraMediaCount: ${_this.extraMediaCount}, primaryCtaLabel: ${_this.primaryCtaLabel}, secondaryCtaLabel: ${_this.secondaryCtaLabel}, likesCount: ${_this.likesCount}, commentsCount: ${_this.commentsCount}, savesCount: ${_this.savesCount}, liked: ${_this.liked}, bookmarked: ${_this.bookmarked}, previewComment: ${_this.previewComment})';
}


}

/// @nodoc
abstract mixin class $SocialFeedReviewPostCopyWith<$Res>  {
  factory $SocialFeedReviewPostCopyWith(SocialFeedReviewPost value, $Res Function(SocialFeedReviewPost) _then) = _$SocialFeedReviewPostCopyWithImpl;
@useResult
$Res call({
 String postId, SocialFeedAuthor author, String timeLabel, String? trendLabel, String? placeLabel, String? placeDetail, String? placeId, String? savedByLabel, String caption, String? tipTitle, String? tipBody, List<SocialFeedMedia> medias,@JsonKey(fromJson: _readInt) int extraMediaCount, String? primaryCtaLabel, String? secondaryCtaLabel,@JsonKey(fromJson: _readInt) int likesCount,@JsonKey(fromJson: _readInt) int commentsCount,@JsonKey(fromJson: _readInt) int savesCount, bool liked, bool bookmarked, SocialFeedPreviewComment? previewComment
});


$SocialFeedAuthorCopyWith<$Res> get author;$SocialFeedPreviewCommentCopyWith<$Res>? get previewComment;

}
/// @nodoc
class _$SocialFeedReviewPostCopyWithImpl<$Res>
    implements $SocialFeedReviewPostCopyWith<$Res> {
  _$SocialFeedReviewPostCopyWithImpl(this._self, this._then);

  final SocialFeedReviewPost _self;
  final $Res Function(SocialFeedReviewPost) _then;

/// Create a copy of SocialFeedReviewPost
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? postId = null,Object? author = null,Object? timeLabel = null,Object? trendLabel = freezed,Object? placeLabel = freezed,Object? placeDetail = freezed,Object? placeId = freezed,Object? savedByLabel = freezed,Object? caption = null,Object? tipTitle = freezed,Object? tipBody = freezed,Object? medias = null,Object? extraMediaCount = null,Object? primaryCtaLabel = freezed,Object? secondaryCtaLabel = freezed,Object? likesCount = null,Object? commentsCount = null,Object? savesCount = null,Object? liked = null,Object? bookmarked = null,Object? previewComment = freezed,}) {
  return _then(SocialFeedReviewPost(
postId: null == postId ? _self.postId : postId // ignore: cast_nullable_to_non_nullable
as String,author: null == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as SocialFeedAuthor,timeLabel: null == timeLabel ? _self.timeLabel : timeLabel // ignore: cast_nullable_to_non_nullable
as String,trendLabel: freezed == trendLabel ? _self.trendLabel : trendLabel // ignore: cast_nullable_to_non_nullable
as String?,placeLabel: freezed == placeLabel ? _self.placeLabel : placeLabel // ignore: cast_nullable_to_non_nullable
as String?,placeDetail: freezed == placeDetail ? _self.placeDetail : placeDetail // ignore: cast_nullable_to_non_nullable
as String?,placeId: freezed == placeId ? _self.placeId : placeId // ignore: cast_nullable_to_non_nullable
as String?,savedByLabel: freezed == savedByLabel ? _self.savedByLabel : savedByLabel // ignore: cast_nullable_to_non_nullable
as String?,caption: null == caption ? _self.caption : caption // ignore: cast_nullable_to_non_nullable
as String,tipTitle: freezed == tipTitle ? _self.tipTitle : tipTitle // ignore: cast_nullable_to_non_nullable
as String?,tipBody: freezed == tipBody ? _self.tipBody : tipBody // ignore: cast_nullable_to_non_nullable
as String?,medias: null == medias ? _self.medias : medias // ignore: cast_nullable_to_non_nullable
as List<SocialFeedMedia>,extraMediaCount: null == extraMediaCount ? _self.extraMediaCount : extraMediaCount // ignore: cast_nullable_to_non_nullable
as int,primaryCtaLabel: freezed == primaryCtaLabel ? _self.primaryCtaLabel : primaryCtaLabel // ignore: cast_nullable_to_non_nullable
as String?,secondaryCtaLabel: freezed == secondaryCtaLabel ? _self.secondaryCtaLabel : secondaryCtaLabel // ignore: cast_nullable_to_non_nullable
as String?,likesCount: null == likesCount ? _self.likesCount : likesCount // ignore: cast_nullable_to_non_nullable
as int,commentsCount: null == commentsCount ? _self.commentsCount : commentsCount // ignore: cast_nullable_to_non_nullable
as int,savesCount: null == savesCount ? _self.savesCount : savesCount // ignore: cast_nullable_to_non_nullable
as int,liked: null == liked ? _self.liked : liked // ignore: cast_nullable_to_non_nullable
as bool,bookmarked: null == bookmarked ? _self.bookmarked : bookmarked // ignore: cast_nullable_to_non_nullable
as bool,previewComment: freezed == previewComment ? _self.previewComment : previewComment // ignore: cast_nullable_to_non_nullable
as SocialFeedPreviewComment?,
  ));
}
/// Create a copy of SocialFeedReviewPost
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SocialFeedAuthorCopyWith<$Res> get author {
  
  return $SocialFeedAuthorCopyWith<$Res>(_self.author, (value) {
    return _then(_self.copyWith(author: value));
  });
}/// Create a copy of SocialFeedReviewPost
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SocialFeedPreviewCommentCopyWith<$Res>? get previewComment {
    if (_self.previewComment == null) {
    return null;
  }

  return $SocialFeedPreviewCommentCopyWith<$Res>(_self.previewComment!, (value) {
    return _then(_self.copyWith(previewComment: value));
  });
}
}


/// Adds pattern-matching-related methods to [SocialFeedReviewPost].
extension SocialFeedReviewPostPatterns on SocialFeedReviewPost {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SocialFeedReviewPost value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SocialFeedReviewPost() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SocialFeedReviewPost value)  $default,){
final _that = this;
switch (_that) {
case _SocialFeedReviewPost():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SocialFeedReviewPost value)?  $default,){
final _that = this;
switch (_that) {
case _SocialFeedReviewPost() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String postId,  SocialFeedAuthor author,  String timeLabel,  String? trendLabel,  String? placeLabel,  String? placeDetail,  String? placeId,  String? savedByLabel,  String caption,  String? tipTitle,  String? tipBody,  List<SocialFeedMedia> medias, @JsonKey(fromJson: _readInt)  int extraMediaCount,  String? primaryCtaLabel,  String? secondaryCtaLabel, @JsonKey(fromJson: _readInt)  int likesCount, @JsonKey(fromJson: _readInt)  int commentsCount, @JsonKey(fromJson: _readInt)  int savesCount,  bool liked,  bool bookmarked,  SocialFeedPreviewComment? previewComment)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SocialFeedReviewPost() when $default != null:
return $default(_that.postId,_that.author,_that.timeLabel,_that.trendLabel,_that.placeLabel,_that.placeDetail,_that.placeId,_that.savedByLabel,_that.caption,_that.tipTitle,_that.tipBody,_that.medias,_that.extraMediaCount,_that.primaryCtaLabel,_that.secondaryCtaLabel,_that.likesCount,_that.commentsCount,_that.savesCount,_that.liked,_that.bookmarked,_that.previewComment);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String postId,  SocialFeedAuthor author,  String timeLabel,  String? trendLabel,  String? placeLabel,  String? placeDetail,  String? placeId,  String? savedByLabel,  String caption,  String? tipTitle,  String? tipBody,  List<SocialFeedMedia> medias, @JsonKey(fromJson: _readInt)  int extraMediaCount,  String? primaryCtaLabel,  String? secondaryCtaLabel, @JsonKey(fromJson: _readInt)  int likesCount, @JsonKey(fromJson: _readInt)  int commentsCount, @JsonKey(fromJson: _readInt)  int savesCount,  bool liked,  bool bookmarked,  SocialFeedPreviewComment? previewComment)  $default,) {final _that = this;
switch (_that) {
case _SocialFeedReviewPost():
return $default(_that.postId,_that.author,_that.timeLabel,_that.trendLabel,_that.placeLabel,_that.placeDetail,_that.placeId,_that.savedByLabel,_that.caption,_that.tipTitle,_that.tipBody,_that.medias,_that.extraMediaCount,_that.primaryCtaLabel,_that.secondaryCtaLabel,_that.likesCount,_that.commentsCount,_that.savesCount,_that.liked,_that.bookmarked,_that.previewComment);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String postId,  SocialFeedAuthor author,  String timeLabel,  String? trendLabel,  String? placeLabel,  String? placeDetail,  String? placeId,  String? savedByLabel,  String caption,  String? tipTitle,  String? tipBody,  List<SocialFeedMedia> medias, @JsonKey(fromJson: _readInt)  int extraMediaCount,  String? primaryCtaLabel,  String? secondaryCtaLabel, @JsonKey(fromJson: _readInt)  int likesCount, @JsonKey(fromJson: _readInt)  int commentsCount, @JsonKey(fromJson: _readInt)  int savesCount,  bool liked,  bool bookmarked,  SocialFeedPreviewComment? previewComment)?  $default,) {final _that = this;
switch (_that) {
case _SocialFeedReviewPost() when $default != null:
return $default(_that.postId,_that.author,_that.timeLabel,_that.trendLabel,_that.placeLabel,_that.placeDetail,_that.placeId,_that.savedByLabel,_that.caption,_that.tipTitle,_that.tipBody,_that.medias,_that.extraMediaCount,_that.primaryCtaLabel,_that.secondaryCtaLabel,_that.likesCount,_that.commentsCount,_that.savesCount,_that.liked,_that.bookmarked,_that.previewComment);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SocialFeedReviewPost implements SocialFeedReviewPost {
  const _SocialFeedReviewPost({required this.postId, required this.author, required this.timeLabel, this.trendLabel, this.placeLabel, this.placeDetail, this.placeId, this.savedByLabel, required this.caption, this.tipTitle, this.tipBody,  List<SocialFeedMedia> medias = const <SocialFeedMedia>[], @JsonKey(fromJson: _readInt) this.extraMediaCount = 0, this.primaryCtaLabel, this.secondaryCtaLabel, @JsonKey(fromJson: _readInt) this.likesCount = 0, @JsonKey(fromJson: _readInt) this.commentsCount = 0, @JsonKey(fromJson: _readInt) this.savesCount = 0, this.liked = false, this.bookmarked = false, this.previewComment}): _medias = medias;
  factory _SocialFeedReviewPost.fromJson(Map<String, dynamic> json) => _$SocialFeedReviewPostFromJson(json);

@override final  String postId;
@override final  SocialFeedAuthor author;
@override final  String timeLabel;
@override final  String? trendLabel;
@override final  String? placeLabel;
@override final  String? placeDetail;
@override final  String? placeId;
@override final  String? savedByLabel;
@override final  String caption;
@override final  String? tipTitle;
@override final  String? tipBody;
 final  List<SocialFeedMedia> _medias;
@override@JsonKey() List<SocialFeedMedia> get medias {
  if (_medias is EqualUnmodifiableListView) return _medias;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_medias);
}

@override@JsonKey(fromJson: _readInt) final  int extraMediaCount;
@override final  String? primaryCtaLabel;
@override final  String? secondaryCtaLabel;
@override@JsonKey(fromJson: _readInt) final  int likesCount;
@override@JsonKey(fromJson: _readInt) final  int commentsCount;
@override@JsonKey(fromJson: _readInt) final  int savesCount;
@override@JsonKey() final  bool liked;
@override@JsonKey() final  bool bookmarked;
@override final  SocialFeedPreviewComment? previewComment;

/// Create a copy of SocialFeedReviewPost
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SocialFeedReviewPostCopyWith<_SocialFeedReviewPost> get copyWith => __$SocialFeedReviewPostCopyWithImpl<_SocialFeedReviewPost>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SocialFeedReviewPostToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SocialFeedReviewPost&&(identical(other.postId, postId) || other.postId == postId)&&(identical(other.author, author) || other.author == author)&&(identical(other.timeLabel, timeLabel) || other.timeLabel == timeLabel)&&(identical(other.trendLabel, trendLabel) || other.trendLabel == trendLabel)&&(identical(other.placeLabel, placeLabel) || other.placeLabel == placeLabel)&&(identical(other.placeDetail, placeDetail) || other.placeDetail == placeDetail)&&(identical(other.placeId, placeId) || other.placeId == placeId)&&(identical(other.savedByLabel, savedByLabel) || other.savedByLabel == savedByLabel)&&(identical(other.caption, caption) || other.caption == caption)&&(identical(other.tipTitle, tipTitle) || other.tipTitle == tipTitle)&&(identical(other.tipBody, tipBody) || other.tipBody == tipBody)&&const DeepCollectionEquality().equals(other.medias, _medias)&&(identical(other.extraMediaCount, extraMediaCount) || other.extraMediaCount == extraMediaCount)&&(identical(other.primaryCtaLabel, primaryCtaLabel) || other.primaryCtaLabel == primaryCtaLabel)&&(identical(other.secondaryCtaLabel, secondaryCtaLabel) || other.secondaryCtaLabel == secondaryCtaLabel)&&(identical(other.likesCount, likesCount) || other.likesCount == likesCount)&&(identical(other.commentsCount, commentsCount) || other.commentsCount == commentsCount)&&(identical(other.savesCount, savesCount) || other.savesCount == savesCount)&&(identical(other.liked, liked) || other.liked == liked)&&(identical(other.bookmarked, bookmarked) || other.bookmarked == bookmarked)&&(identical(other.previewComment, previewComment) || other.previewComment == previewComment));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hashAll([runtimeType,postId,author,timeLabel,trendLabel,placeLabel,placeDetail,placeId,savedByLabel,caption,tipTitle,tipBody,const DeepCollectionEquality().hash(_medias),extraMediaCount,primaryCtaLabel,secondaryCtaLabel,likesCount,commentsCount,savesCount,liked,bookmarked,previewComment]);
}

@override
String toString() {
    return 'SocialFeedReviewPost(postId: $postId, author: $author, timeLabel: $timeLabel, trendLabel: $trendLabel, placeLabel: $placeLabel, placeDetail: $placeDetail, placeId: $placeId, savedByLabel: $savedByLabel, caption: $caption, tipTitle: $tipTitle, tipBody: $tipBody, medias: $medias, extraMediaCount: $extraMediaCount, primaryCtaLabel: $primaryCtaLabel, secondaryCtaLabel: $secondaryCtaLabel, likesCount: $likesCount, commentsCount: $commentsCount, savesCount: $savesCount, liked: $liked, bookmarked: $bookmarked, previewComment: $previewComment)';
}


}

/// @nodoc
abstract mixin class _$SocialFeedReviewPostCopyWith<$Res> implements $SocialFeedReviewPostCopyWith<$Res> {
  factory _$SocialFeedReviewPostCopyWith(_SocialFeedReviewPost value, $Res Function(_SocialFeedReviewPost) _then) = __$SocialFeedReviewPostCopyWithImpl;
@override @useResult
$Res call({
 String postId, SocialFeedAuthor author, String timeLabel, String? trendLabel, String? placeLabel, String? placeDetail, String? placeId, String? savedByLabel, String caption, String? tipTitle, String? tipBody, List<SocialFeedMedia> medias,@JsonKey(fromJson: _readInt) int extraMediaCount, String? primaryCtaLabel, String? secondaryCtaLabel,@JsonKey(fromJson: _readInt) int likesCount,@JsonKey(fromJson: _readInt) int commentsCount,@JsonKey(fromJson: _readInt) int savesCount, bool liked, bool bookmarked, SocialFeedPreviewComment? previewComment
});


@override $SocialFeedAuthorCopyWith<$Res> get author;@override $SocialFeedPreviewCommentCopyWith<$Res>? get previewComment;

}
/// @nodoc
class __$SocialFeedReviewPostCopyWithImpl<$Res>
    implements _$SocialFeedReviewPostCopyWith<$Res> {
  __$SocialFeedReviewPostCopyWithImpl(this._self, this._then);

  final _SocialFeedReviewPost _self;
  final $Res Function(_SocialFeedReviewPost) _then;

/// Create a copy of SocialFeedReviewPost
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? postId = null,Object? author = null,Object? timeLabel = null,Object? trendLabel = freezed,Object? placeLabel = freezed,Object? placeDetail = freezed,Object? placeId = freezed,Object? savedByLabel = freezed,Object? caption = null,Object? tipTitle = freezed,Object? tipBody = freezed,Object? medias = null,Object? extraMediaCount = null,Object? primaryCtaLabel = freezed,Object? secondaryCtaLabel = freezed,Object? likesCount = null,Object? commentsCount = null,Object? savesCount = null,Object? liked = null,Object? bookmarked = null,Object? previewComment = freezed,}) {
  return _then(_SocialFeedReviewPost(
postId: null == postId ? _self.postId : postId // ignore: cast_nullable_to_non_nullable
as String,author: null == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as SocialFeedAuthor,timeLabel: null == timeLabel ? _self.timeLabel : timeLabel // ignore: cast_nullable_to_non_nullable
as String,trendLabel: freezed == trendLabel ? _self.trendLabel : trendLabel // ignore: cast_nullable_to_non_nullable
as String?,placeLabel: freezed == placeLabel ? _self.placeLabel : placeLabel // ignore: cast_nullable_to_non_nullable
as String?,placeDetail: freezed == placeDetail ? _self.placeDetail : placeDetail // ignore: cast_nullable_to_non_nullable
as String?,placeId: freezed == placeId ? _self.placeId : placeId // ignore: cast_nullable_to_non_nullable
as String?,savedByLabel: freezed == savedByLabel ? _self.savedByLabel : savedByLabel // ignore: cast_nullable_to_non_nullable
as String?,caption: null == caption ? _self.caption : caption // ignore: cast_nullable_to_non_nullable
as String,tipTitle: freezed == tipTitle ? _self.tipTitle : tipTitle // ignore: cast_nullable_to_non_nullable
as String?,tipBody: freezed == tipBody ? _self.tipBody : tipBody // ignore: cast_nullable_to_non_nullable
as String?,medias: null == medias ? _self._medias : medias // ignore: cast_nullable_to_non_nullable
as List<SocialFeedMedia>,extraMediaCount: null == extraMediaCount ? _self.extraMediaCount : extraMediaCount // ignore: cast_nullable_to_non_nullable
as int,primaryCtaLabel: freezed == primaryCtaLabel ? _self.primaryCtaLabel : primaryCtaLabel // ignore: cast_nullable_to_non_nullable
as String?,secondaryCtaLabel: freezed == secondaryCtaLabel ? _self.secondaryCtaLabel : secondaryCtaLabel // ignore: cast_nullable_to_non_nullable
as String?,likesCount: null == likesCount ? _self.likesCount : likesCount // ignore: cast_nullable_to_non_nullable
as int,commentsCount: null == commentsCount ? _self.commentsCount : commentsCount // ignore: cast_nullable_to_non_nullable
as int,savesCount: null == savesCount ? _self.savesCount : savesCount // ignore: cast_nullable_to_non_nullable
as int,liked: null == liked ? _self.liked : liked // ignore: cast_nullable_to_non_nullable
as bool,bookmarked: null == bookmarked ? _self.bookmarked : bookmarked // ignore: cast_nullable_to_non_nullable
as bool,previewComment: freezed == previewComment ? _self.previewComment : previewComment // ignore: cast_nullable_to_non_nullable
as SocialFeedPreviewComment?,
  ));
}

/// Create a copy of SocialFeedReviewPost
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SocialFeedAuthorCopyWith<$Res> get author {
  
  return $SocialFeedAuthorCopyWith<$Res>(_self.author, (value) {
    return _then(_self.copyWith(author: value));
  });
}/// Create a copy of SocialFeedReviewPost
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SocialFeedPreviewCommentCopyWith<$Res>? get previewComment {
    if (_self.previewComment == null) {
    return null;
  }

  return $SocialFeedPreviewCommentCopyWith<$Res>(_self.previewComment!, (value) {
    return _then(_self.copyWith(previewComment: value));
  });
}
}


/// @nodoc
mixin _$SocialFeedChallenge {

 String get id; String get eyebrow; String get title; String get rewardLabel; String get progressLabel;@JsonKey(fromJson: _readDouble) double get progressRatio; String get daysLeftLabel; String get badgeLabel; String get ctaLabel;
/// Create a copy of SocialFeedChallenge
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SocialFeedChallengeCopyWith<SocialFeedChallenge> get copyWith => _$SocialFeedChallengeCopyWithImpl<SocialFeedChallenge>(this as SocialFeedChallenge, _$identity);

  /// Serializes this SocialFeedChallenge to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SocialFeedChallenge;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SocialFeedChallenge&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.eyebrow, _this.eyebrow) || other.eyebrow == _this.eyebrow)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.rewardLabel, _this.rewardLabel) || other.rewardLabel == _this.rewardLabel)&&(identical(other.progressLabel, _this.progressLabel) || other.progressLabel == _this.progressLabel)&&(identical(other.progressRatio, _this.progressRatio) || other.progressRatio == _this.progressRatio)&&(identical(other.daysLeftLabel, _this.daysLeftLabel) || other.daysLeftLabel == _this.daysLeftLabel)&&(identical(other.badgeLabel, _this.badgeLabel) || other.badgeLabel == _this.badgeLabel)&&(identical(other.ctaLabel, _this.ctaLabel) || other.ctaLabel == _this.ctaLabel));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SocialFeedChallenge;
  return Object.hash(runtimeType,_this.id,_this.eyebrow,_this.title,_this.rewardLabel,_this.progressLabel,_this.progressRatio,_this.daysLeftLabel,_this.badgeLabel,_this.ctaLabel);
}

@override
String toString() {
  final _this = this as SocialFeedChallenge;
  return 'SocialFeedChallenge(id: ${_this.id}, eyebrow: ${_this.eyebrow}, title: ${_this.title}, rewardLabel: ${_this.rewardLabel}, progressLabel: ${_this.progressLabel}, progressRatio: ${_this.progressRatio}, daysLeftLabel: ${_this.daysLeftLabel}, badgeLabel: ${_this.badgeLabel}, ctaLabel: ${_this.ctaLabel})';
}


}

/// @nodoc
abstract mixin class $SocialFeedChallengeCopyWith<$Res>  {
  factory $SocialFeedChallengeCopyWith(SocialFeedChallenge value, $Res Function(SocialFeedChallenge) _then) = _$SocialFeedChallengeCopyWithImpl;
@useResult
$Res call({
 String id, String eyebrow, String title, String rewardLabel, String progressLabel,@JsonKey(fromJson: _readDouble) double progressRatio, String daysLeftLabel, String badgeLabel, String ctaLabel
});




}
/// @nodoc
class _$SocialFeedChallengeCopyWithImpl<$Res>
    implements $SocialFeedChallengeCopyWith<$Res> {
  _$SocialFeedChallengeCopyWithImpl(this._self, this._then);

  final SocialFeedChallenge _self;
  final $Res Function(SocialFeedChallenge) _then;

/// Create a copy of SocialFeedChallenge
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? eyebrow = null,Object? title = null,Object? rewardLabel = null,Object? progressLabel = null,Object? progressRatio = null,Object? daysLeftLabel = null,Object? badgeLabel = null,Object? ctaLabel = null,}) {
  return _then(SocialFeedChallenge(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,eyebrow: null == eyebrow ? _self.eyebrow : eyebrow // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,rewardLabel: null == rewardLabel ? _self.rewardLabel : rewardLabel // ignore: cast_nullable_to_non_nullable
as String,progressLabel: null == progressLabel ? _self.progressLabel : progressLabel // ignore: cast_nullable_to_non_nullable
as String,progressRatio: null == progressRatio ? _self.progressRatio : progressRatio // ignore: cast_nullable_to_non_nullable
as double,daysLeftLabel: null == daysLeftLabel ? _self.daysLeftLabel : daysLeftLabel // ignore: cast_nullable_to_non_nullable
as String,badgeLabel: null == badgeLabel ? _self.badgeLabel : badgeLabel // ignore: cast_nullable_to_non_nullable
as String,ctaLabel: null == ctaLabel ? _self.ctaLabel : ctaLabel // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [SocialFeedChallenge].
extension SocialFeedChallengePatterns on SocialFeedChallenge {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SocialFeedChallenge value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SocialFeedChallenge() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SocialFeedChallenge value)  $default,){
final _that = this;
switch (_that) {
case _SocialFeedChallenge():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SocialFeedChallenge value)?  $default,){
final _that = this;
switch (_that) {
case _SocialFeedChallenge() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String eyebrow,  String title,  String rewardLabel,  String progressLabel, @JsonKey(fromJson: _readDouble)  double progressRatio,  String daysLeftLabel,  String badgeLabel,  String ctaLabel)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SocialFeedChallenge() when $default != null:
return $default(_that.id,_that.eyebrow,_that.title,_that.rewardLabel,_that.progressLabel,_that.progressRatio,_that.daysLeftLabel,_that.badgeLabel,_that.ctaLabel);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String eyebrow,  String title,  String rewardLabel,  String progressLabel, @JsonKey(fromJson: _readDouble)  double progressRatio,  String daysLeftLabel,  String badgeLabel,  String ctaLabel)  $default,) {final _that = this;
switch (_that) {
case _SocialFeedChallenge():
return $default(_that.id,_that.eyebrow,_that.title,_that.rewardLabel,_that.progressLabel,_that.progressRatio,_that.daysLeftLabel,_that.badgeLabel,_that.ctaLabel);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String eyebrow,  String title,  String rewardLabel,  String progressLabel, @JsonKey(fromJson: _readDouble)  double progressRatio,  String daysLeftLabel,  String badgeLabel,  String ctaLabel)?  $default,) {final _that = this;
switch (_that) {
case _SocialFeedChallenge() when $default != null:
return $default(_that.id,_that.eyebrow,_that.title,_that.rewardLabel,_that.progressLabel,_that.progressRatio,_that.daysLeftLabel,_that.badgeLabel,_that.ctaLabel);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SocialFeedChallenge implements SocialFeedChallenge {
  const _SocialFeedChallenge({required this.id, required this.eyebrow, required this.title, required this.rewardLabel, required this.progressLabel, @JsonKey(fromJson: _readDouble) this.progressRatio = 0, required this.daysLeftLabel, required this.badgeLabel, required this.ctaLabel});
  factory _SocialFeedChallenge.fromJson(Map<String, dynamic> json) => _$SocialFeedChallengeFromJson(json);

@override final  String id;
@override final  String eyebrow;
@override final  String title;
@override final  String rewardLabel;
@override final  String progressLabel;
@override@JsonKey(fromJson: _readDouble) final  double progressRatio;
@override final  String daysLeftLabel;
@override final  String badgeLabel;
@override final  String ctaLabel;

/// Create a copy of SocialFeedChallenge
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SocialFeedChallengeCopyWith<_SocialFeedChallenge> get copyWith => __$SocialFeedChallengeCopyWithImpl<_SocialFeedChallenge>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SocialFeedChallengeToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SocialFeedChallenge&&(identical(other.id, id) || other.id == id)&&(identical(other.eyebrow, eyebrow) || other.eyebrow == eyebrow)&&(identical(other.title, title) || other.title == title)&&(identical(other.rewardLabel, rewardLabel) || other.rewardLabel == rewardLabel)&&(identical(other.progressLabel, progressLabel) || other.progressLabel == progressLabel)&&(identical(other.progressRatio, progressRatio) || other.progressRatio == progressRatio)&&(identical(other.daysLeftLabel, daysLeftLabel) || other.daysLeftLabel == daysLeftLabel)&&(identical(other.badgeLabel, badgeLabel) || other.badgeLabel == badgeLabel)&&(identical(other.ctaLabel, ctaLabel) || other.ctaLabel == ctaLabel));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,eyebrow,title,rewardLabel,progressLabel,progressRatio,daysLeftLabel,badgeLabel,ctaLabel);
}

@override
String toString() {
    return 'SocialFeedChallenge(id: $id, eyebrow: $eyebrow, title: $title, rewardLabel: $rewardLabel, progressLabel: $progressLabel, progressRatio: $progressRatio, daysLeftLabel: $daysLeftLabel, badgeLabel: $badgeLabel, ctaLabel: $ctaLabel)';
}


}

/// @nodoc
abstract mixin class _$SocialFeedChallengeCopyWith<$Res> implements $SocialFeedChallengeCopyWith<$Res> {
  factory _$SocialFeedChallengeCopyWith(_SocialFeedChallenge value, $Res Function(_SocialFeedChallenge) _then) = __$SocialFeedChallengeCopyWithImpl;
@override @useResult
$Res call({
 String id, String eyebrow, String title, String rewardLabel, String progressLabel,@JsonKey(fromJson: _readDouble) double progressRatio, String daysLeftLabel, String badgeLabel, String ctaLabel
});




}
/// @nodoc
class __$SocialFeedChallengeCopyWithImpl<$Res>
    implements _$SocialFeedChallengeCopyWith<$Res> {
  __$SocialFeedChallengeCopyWithImpl(this._self, this._then);

  final _SocialFeedChallenge _self;
  final $Res Function(_SocialFeedChallenge) _then;

/// Create a copy of SocialFeedChallenge
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? eyebrow = null,Object? title = null,Object? rewardLabel = null,Object? progressLabel = null,Object? progressRatio = null,Object? daysLeftLabel = null,Object? badgeLabel = null,Object? ctaLabel = null,}) {
  return _then(_SocialFeedChallenge(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,eyebrow: null == eyebrow ? _self.eyebrow : eyebrow // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,rewardLabel: null == rewardLabel ? _self.rewardLabel : rewardLabel // ignore: cast_nullable_to_non_nullable
as String,progressLabel: null == progressLabel ? _self.progressLabel : progressLabel // ignore: cast_nullable_to_non_nullable
as String,progressRatio: null == progressRatio ? _self.progressRatio : progressRatio // ignore: cast_nullable_to_non_nullable
as double,daysLeftLabel: null == daysLeftLabel ? _self.daysLeftLabel : daysLeftLabel // ignore: cast_nullable_to_non_nullable
as String,badgeLabel: null == badgeLabel ? _self.badgeLabel : badgeLabel // ignore: cast_nullable_to_non_nullable
as String,ctaLabel: null == ctaLabel ? _self.ctaLabel : ctaLabel // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$SocialFeedTripRecruit {

 String get postId; SocialFeedAuthor get author; String get timeLabel; String get recruitBadge; String get placeLabel; String get caption; String get tripId; String get tripTitle; String get spotsLeftLabel; String get urgencyLabel; String get scheduleLabel; String get priceLabel; String get membersLabel;@JsonKey(fromJson: _readDouble) double get fillRatio; String get fillPercentLabel; List<String> get memberAvatars;@JsonKey(fromJson: _readInt) int get extraMemberCount; String? get highlightLabel; String? get highlightDetail;@JsonKey(fromJson: _readInt) int get likesCount;@JsonKey(fromJson: _readInt) int get commentsCount;@JsonKey(fromJson: _readInt) int get sharesCount; bool get liked; bool get bookmarked; String get itineraryCtaLabel; String get joinCtaLabel;
/// Create a copy of SocialFeedTripRecruit
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SocialFeedTripRecruitCopyWith<SocialFeedTripRecruit> get copyWith => _$SocialFeedTripRecruitCopyWithImpl<SocialFeedTripRecruit>(this as SocialFeedTripRecruit, _$identity);

  /// Serializes this SocialFeedTripRecruit to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SocialFeedTripRecruit;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SocialFeedTripRecruit&&(identical(other.postId, _this.postId) || other.postId == _this.postId)&&(identical(other.author, _this.author) || other.author == _this.author)&&(identical(other.timeLabel, _this.timeLabel) || other.timeLabel == _this.timeLabel)&&(identical(other.recruitBadge, _this.recruitBadge) || other.recruitBadge == _this.recruitBadge)&&(identical(other.placeLabel, _this.placeLabel) || other.placeLabel == _this.placeLabel)&&(identical(other.caption, _this.caption) || other.caption == _this.caption)&&(identical(other.tripId, _this.tripId) || other.tripId == _this.tripId)&&(identical(other.tripTitle, _this.tripTitle) || other.tripTitle == _this.tripTitle)&&(identical(other.spotsLeftLabel, _this.spotsLeftLabel) || other.spotsLeftLabel == _this.spotsLeftLabel)&&(identical(other.urgencyLabel, _this.urgencyLabel) || other.urgencyLabel == _this.urgencyLabel)&&(identical(other.scheduleLabel, _this.scheduleLabel) || other.scheduleLabel == _this.scheduleLabel)&&(identical(other.priceLabel, _this.priceLabel) || other.priceLabel == _this.priceLabel)&&(identical(other.membersLabel, _this.membersLabel) || other.membersLabel == _this.membersLabel)&&(identical(other.fillRatio, _this.fillRatio) || other.fillRatio == _this.fillRatio)&&(identical(other.fillPercentLabel, _this.fillPercentLabel) || other.fillPercentLabel == _this.fillPercentLabel)&&const DeepCollectionEquality().equals(other.memberAvatars, _this.memberAvatars)&&(identical(other.extraMemberCount, _this.extraMemberCount) || other.extraMemberCount == _this.extraMemberCount)&&(identical(other.highlightLabel, _this.highlightLabel) || other.highlightLabel == _this.highlightLabel)&&(identical(other.highlightDetail, _this.highlightDetail) || other.highlightDetail == _this.highlightDetail)&&(identical(other.likesCount, _this.likesCount) || other.likesCount == _this.likesCount)&&(identical(other.commentsCount, _this.commentsCount) || other.commentsCount == _this.commentsCount)&&(identical(other.sharesCount, _this.sharesCount) || other.sharesCount == _this.sharesCount)&&(identical(other.liked, _this.liked) || other.liked == _this.liked)&&(identical(other.bookmarked, _this.bookmarked) || other.bookmarked == _this.bookmarked)&&(identical(other.itineraryCtaLabel, _this.itineraryCtaLabel) || other.itineraryCtaLabel == _this.itineraryCtaLabel)&&(identical(other.joinCtaLabel, _this.joinCtaLabel) || other.joinCtaLabel == _this.joinCtaLabel));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SocialFeedTripRecruit;
  return Object.hashAll([runtimeType,_this.postId,_this.author,_this.timeLabel,_this.recruitBadge,_this.placeLabel,_this.caption,_this.tripId,_this.tripTitle,_this.spotsLeftLabel,_this.urgencyLabel,_this.scheduleLabel,_this.priceLabel,_this.membersLabel,_this.fillRatio,_this.fillPercentLabel,const DeepCollectionEquality().hash(_this.memberAvatars),_this.extraMemberCount,_this.highlightLabel,_this.highlightDetail,_this.likesCount,_this.commentsCount,_this.sharesCount,_this.liked,_this.bookmarked,_this.itineraryCtaLabel,_this.joinCtaLabel]);
}

@override
String toString() {
  final _this = this as SocialFeedTripRecruit;
  return 'SocialFeedTripRecruit(postId: ${_this.postId}, author: ${_this.author}, timeLabel: ${_this.timeLabel}, recruitBadge: ${_this.recruitBadge}, placeLabel: ${_this.placeLabel}, caption: ${_this.caption}, tripId: ${_this.tripId}, tripTitle: ${_this.tripTitle}, spotsLeftLabel: ${_this.spotsLeftLabel}, urgencyLabel: ${_this.urgencyLabel}, scheduleLabel: ${_this.scheduleLabel}, priceLabel: ${_this.priceLabel}, membersLabel: ${_this.membersLabel}, fillRatio: ${_this.fillRatio}, fillPercentLabel: ${_this.fillPercentLabel}, memberAvatars: ${_this.memberAvatars}, extraMemberCount: ${_this.extraMemberCount}, highlightLabel: ${_this.highlightLabel}, highlightDetail: ${_this.highlightDetail}, likesCount: ${_this.likesCount}, commentsCount: ${_this.commentsCount}, sharesCount: ${_this.sharesCount}, liked: ${_this.liked}, bookmarked: ${_this.bookmarked}, itineraryCtaLabel: ${_this.itineraryCtaLabel}, joinCtaLabel: ${_this.joinCtaLabel})';
}


}

/// @nodoc
abstract mixin class $SocialFeedTripRecruitCopyWith<$Res>  {
  factory $SocialFeedTripRecruitCopyWith(SocialFeedTripRecruit value, $Res Function(SocialFeedTripRecruit) _then) = _$SocialFeedTripRecruitCopyWithImpl;
@useResult
$Res call({
 String postId, SocialFeedAuthor author, String timeLabel, String recruitBadge, String placeLabel, String caption, String tripId, String tripTitle, String spotsLeftLabel, String urgencyLabel, String scheduleLabel, String priceLabel, String membersLabel,@JsonKey(fromJson: _readDouble) double fillRatio, String fillPercentLabel, List<String> memberAvatars,@JsonKey(fromJson: _readInt) int extraMemberCount, String? highlightLabel, String? highlightDetail,@JsonKey(fromJson: _readInt) int likesCount,@JsonKey(fromJson: _readInt) int commentsCount,@JsonKey(fromJson: _readInt) int sharesCount, bool liked, bool bookmarked, String itineraryCtaLabel, String joinCtaLabel
});


$SocialFeedAuthorCopyWith<$Res> get author;

}
/// @nodoc
class _$SocialFeedTripRecruitCopyWithImpl<$Res>
    implements $SocialFeedTripRecruitCopyWith<$Res> {
  _$SocialFeedTripRecruitCopyWithImpl(this._self, this._then);

  final SocialFeedTripRecruit _self;
  final $Res Function(SocialFeedTripRecruit) _then;

/// Create a copy of SocialFeedTripRecruit
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? postId = null,Object? author = null,Object? timeLabel = null,Object? recruitBadge = null,Object? placeLabel = null,Object? caption = null,Object? tripId = null,Object? tripTitle = null,Object? spotsLeftLabel = null,Object? urgencyLabel = null,Object? scheduleLabel = null,Object? priceLabel = null,Object? membersLabel = null,Object? fillRatio = null,Object? fillPercentLabel = null,Object? memberAvatars = null,Object? extraMemberCount = null,Object? highlightLabel = freezed,Object? highlightDetail = freezed,Object? likesCount = null,Object? commentsCount = null,Object? sharesCount = null,Object? liked = null,Object? bookmarked = null,Object? itineraryCtaLabel = null,Object? joinCtaLabel = null,}) {
  return _then(SocialFeedTripRecruit(
postId: null == postId ? _self.postId : postId // ignore: cast_nullable_to_non_nullable
as String,author: null == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as SocialFeedAuthor,timeLabel: null == timeLabel ? _self.timeLabel : timeLabel // ignore: cast_nullable_to_non_nullable
as String,recruitBadge: null == recruitBadge ? _self.recruitBadge : recruitBadge // ignore: cast_nullable_to_non_nullable
as String,placeLabel: null == placeLabel ? _self.placeLabel : placeLabel // ignore: cast_nullable_to_non_nullable
as String,caption: null == caption ? _self.caption : caption // ignore: cast_nullable_to_non_nullable
as String,tripId: null == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String,tripTitle: null == tripTitle ? _self.tripTitle : tripTitle // ignore: cast_nullable_to_non_nullable
as String,spotsLeftLabel: null == spotsLeftLabel ? _self.spotsLeftLabel : spotsLeftLabel // ignore: cast_nullable_to_non_nullable
as String,urgencyLabel: null == urgencyLabel ? _self.urgencyLabel : urgencyLabel // ignore: cast_nullable_to_non_nullable
as String,scheduleLabel: null == scheduleLabel ? _self.scheduleLabel : scheduleLabel // ignore: cast_nullable_to_non_nullable
as String,priceLabel: null == priceLabel ? _self.priceLabel : priceLabel // ignore: cast_nullable_to_non_nullable
as String,membersLabel: null == membersLabel ? _self.membersLabel : membersLabel // ignore: cast_nullable_to_non_nullable
as String,fillRatio: null == fillRatio ? _self.fillRatio : fillRatio // ignore: cast_nullable_to_non_nullable
as double,fillPercentLabel: null == fillPercentLabel ? _self.fillPercentLabel : fillPercentLabel // ignore: cast_nullable_to_non_nullable
as String,memberAvatars: null == memberAvatars ? _self.memberAvatars : memberAvatars // ignore: cast_nullable_to_non_nullable
as List<String>,extraMemberCount: null == extraMemberCount ? _self.extraMemberCount : extraMemberCount // ignore: cast_nullable_to_non_nullable
as int,highlightLabel: freezed == highlightLabel ? _self.highlightLabel : highlightLabel // ignore: cast_nullable_to_non_nullable
as String?,highlightDetail: freezed == highlightDetail ? _self.highlightDetail : highlightDetail // ignore: cast_nullable_to_non_nullable
as String?,likesCount: null == likesCount ? _self.likesCount : likesCount // ignore: cast_nullable_to_non_nullable
as int,commentsCount: null == commentsCount ? _self.commentsCount : commentsCount // ignore: cast_nullable_to_non_nullable
as int,sharesCount: null == sharesCount ? _self.sharesCount : sharesCount // ignore: cast_nullable_to_non_nullable
as int,liked: null == liked ? _self.liked : liked // ignore: cast_nullable_to_non_nullable
as bool,bookmarked: null == bookmarked ? _self.bookmarked : bookmarked // ignore: cast_nullable_to_non_nullable
as bool,itineraryCtaLabel: null == itineraryCtaLabel ? _self.itineraryCtaLabel : itineraryCtaLabel // ignore: cast_nullable_to_non_nullable
as String,joinCtaLabel: null == joinCtaLabel ? _self.joinCtaLabel : joinCtaLabel // ignore: cast_nullable_to_non_nullable
as String,
  ));
}
/// Create a copy of SocialFeedTripRecruit
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SocialFeedAuthorCopyWith<$Res> get author {
  
  return $SocialFeedAuthorCopyWith<$Res>(_self.author, (value) {
    return _then(_self.copyWith(author: value));
  });
}
}


/// Adds pattern-matching-related methods to [SocialFeedTripRecruit].
extension SocialFeedTripRecruitPatterns on SocialFeedTripRecruit {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SocialFeedTripRecruit value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SocialFeedTripRecruit() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SocialFeedTripRecruit value)  $default,){
final _that = this;
switch (_that) {
case _SocialFeedTripRecruit():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SocialFeedTripRecruit value)?  $default,){
final _that = this;
switch (_that) {
case _SocialFeedTripRecruit() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String postId,  SocialFeedAuthor author,  String timeLabel,  String recruitBadge,  String placeLabel,  String caption,  String tripId,  String tripTitle,  String spotsLeftLabel,  String urgencyLabel,  String scheduleLabel,  String priceLabel,  String membersLabel, @JsonKey(fromJson: _readDouble)  double fillRatio,  String fillPercentLabel,  List<String> memberAvatars, @JsonKey(fromJson: _readInt)  int extraMemberCount,  String? highlightLabel,  String? highlightDetail, @JsonKey(fromJson: _readInt)  int likesCount, @JsonKey(fromJson: _readInt)  int commentsCount, @JsonKey(fromJson: _readInt)  int sharesCount,  bool liked,  bool bookmarked,  String itineraryCtaLabel,  String joinCtaLabel)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SocialFeedTripRecruit() when $default != null:
return $default(_that.postId,_that.author,_that.timeLabel,_that.recruitBadge,_that.placeLabel,_that.caption,_that.tripId,_that.tripTitle,_that.spotsLeftLabel,_that.urgencyLabel,_that.scheduleLabel,_that.priceLabel,_that.membersLabel,_that.fillRatio,_that.fillPercentLabel,_that.memberAvatars,_that.extraMemberCount,_that.highlightLabel,_that.highlightDetail,_that.likesCount,_that.commentsCount,_that.sharesCount,_that.liked,_that.bookmarked,_that.itineraryCtaLabel,_that.joinCtaLabel);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String postId,  SocialFeedAuthor author,  String timeLabel,  String recruitBadge,  String placeLabel,  String caption,  String tripId,  String tripTitle,  String spotsLeftLabel,  String urgencyLabel,  String scheduleLabel,  String priceLabel,  String membersLabel, @JsonKey(fromJson: _readDouble)  double fillRatio,  String fillPercentLabel,  List<String> memberAvatars, @JsonKey(fromJson: _readInt)  int extraMemberCount,  String? highlightLabel,  String? highlightDetail, @JsonKey(fromJson: _readInt)  int likesCount, @JsonKey(fromJson: _readInt)  int commentsCount, @JsonKey(fromJson: _readInt)  int sharesCount,  bool liked,  bool bookmarked,  String itineraryCtaLabel,  String joinCtaLabel)  $default,) {final _that = this;
switch (_that) {
case _SocialFeedTripRecruit():
return $default(_that.postId,_that.author,_that.timeLabel,_that.recruitBadge,_that.placeLabel,_that.caption,_that.tripId,_that.tripTitle,_that.spotsLeftLabel,_that.urgencyLabel,_that.scheduleLabel,_that.priceLabel,_that.membersLabel,_that.fillRatio,_that.fillPercentLabel,_that.memberAvatars,_that.extraMemberCount,_that.highlightLabel,_that.highlightDetail,_that.likesCount,_that.commentsCount,_that.sharesCount,_that.liked,_that.bookmarked,_that.itineraryCtaLabel,_that.joinCtaLabel);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String postId,  SocialFeedAuthor author,  String timeLabel,  String recruitBadge,  String placeLabel,  String caption,  String tripId,  String tripTitle,  String spotsLeftLabel,  String urgencyLabel,  String scheduleLabel,  String priceLabel,  String membersLabel, @JsonKey(fromJson: _readDouble)  double fillRatio,  String fillPercentLabel,  List<String> memberAvatars, @JsonKey(fromJson: _readInt)  int extraMemberCount,  String? highlightLabel,  String? highlightDetail, @JsonKey(fromJson: _readInt)  int likesCount, @JsonKey(fromJson: _readInt)  int commentsCount, @JsonKey(fromJson: _readInt)  int sharesCount,  bool liked,  bool bookmarked,  String itineraryCtaLabel,  String joinCtaLabel)?  $default,) {final _that = this;
switch (_that) {
case _SocialFeedTripRecruit() when $default != null:
return $default(_that.postId,_that.author,_that.timeLabel,_that.recruitBadge,_that.placeLabel,_that.caption,_that.tripId,_that.tripTitle,_that.spotsLeftLabel,_that.urgencyLabel,_that.scheduleLabel,_that.priceLabel,_that.membersLabel,_that.fillRatio,_that.fillPercentLabel,_that.memberAvatars,_that.extraMemberCount,_that.highlightLabel,_that.highlightDetail,_that.likesCount,_that.commentsCount,_that.sharesCount,_that.liked,_that.bookmarked,_that.itineraryCtaLabel,_that.joinCtaLabel);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SocialFeedTripRecruit implements SocialFeedTripRecruit {
  const _SocialFeedTripRecruit({required this.postId, required this.author, required this.timeLabel, required this.recruitBadge, required this.placeLabel, required this.caption, required this.tripId, required this.tripTitle, required this.spotsLeftLabel, required this.urgencyLabel, required this.scheduleLabel, required this.priceLabel, required this.membersLabel, @JsonKey(fromJson: _readDouble) this.fillRatio = 0, required this.fillPercentLabel,  List<String> memberAvatars = const <String>[], @JsonKey(fromJson: _readInt) this.extraMemberCount = 0, this.highlightLabel, this.highlightDetail, @JsonKey(fromJson: _readInt) this.likesCount = 0, @JsonKey(fromJson: _readInt) this.commentsCount = 0, @JsonKey(fromJson: _readInt) this.sharesCount = 0, this.liked = false, this.bookmarked = false, required this.itineraryCtaLabel, required this.joinCtaLabel}): _memberAvatars = memberAvatars;
  factory _SocialFeedTripRecruit.fromJson(Map<String, dynamic> json) => _$SocialFeedTripRecruitFromJson(json);

@override final  String postId;
@override final  SocialFeedAuthor author;
@override final  String timeLabel;
@override final  String recruitBadge;
@override final  String placeLabel;
@override final  String caption;
@override final  String tripId;
@override final  String tripTitle;
@override final  String spotsLeftLabel;
@override final  String urgencyLabel;
@override final  String scheduleLabel;
@override final  String priceLabel;
@override final  String membersLabel;
@override@JsonKey(fromJson: _readDouble) final  double fillRatio;
@override final  String fillPercentLabel;
 final  List<String> _memberAvatars;
@override@JsonKey() List<String> get memberAvatars {
  if (_memberAvatars is EqualUnmodifiableListView) return _memberAvatars;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_memberAvatars);
}

@override@JsonKey(fromJson: _readInt) final  int extraMemberCount;
@override final  String? highlightLabel;
@override final  String? highlightDetail;
@override@JsonKey(fromJson: _readInt) final  int likesCount;
@override@JsonKey(fromJson: _readInt) final  int commentsCount;
@override@JsonKey(fromJson: _readInt) final  int sharesCount;
@override@JsonKey() final  bool liked;
@override@JsonKey() final  bool bookmarked;
@override final  String itineraryCtaLabel;
@override final  String joinCtaLabel;

/// Create a copy of SocialFeedTripRecruit
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SocialFeedTripRecruitCopyWith<_SocialFeedTripRecruit> get copyWith => __$SocialFeedTripRecruitCopyWithImpl<_SocialFeedTripRecruit>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SocialFeedTripRecruitToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SocialFeedTripRecruit&&(identical(other.postId, postId) || other.postId == postId)&&(identical(other.author, author) || other.author == author)&&(identical(other.timeLabel, timeLabel) || other.timeLabel == timeLabel)&&(identical(other.recruitBadge, recruitBadge) || other.recruitBadge == recruitBadge)&&(identical(other.placeLabel, placeLabel) || other.placeLabel == placeLabel)&&(identical(other.caption, caption) || other.caption == caption)&&(identical(other.tripId, tripId) || other.tripId == tripId)&&(identical(other.tripTitle, tripTitle) || other.tripTitle == tripTitle)&&(identical(other.spotsLeftLabel, spotsLeftLabel) || other.spotsLeftLabel == spotsLeftLabel)&&(identical(other.urgencyLabel, urgencyLabel) || other.urgencyLabel == urgencyLabel)&&(identical(other.scheduleLabel, scheduleLabel) || other.scheduleLabel == scheduleLabel)&&(identical(other.priceLabel, priceLabel) || other.priceLabel == priceLabel)&&(identical(other.membersLabel, membersLabel) || other.membersLabel == membersLabel)&&(identical(other.fillRatio, fillRatio) || other.fillRatio == fillRatio)&&(identical(other.fillPercentLabel, fillPercentLabel) || other.fillPercentLabel == fillPercentLabel)&&const DeepCollectionEquality().equals(other.memberAvatars, _memberAvatars)&&(identical(other.extraMemberCount, extraMemberCount) || other.extraMemberCount == extraMemberCount)&&(identical(other.highlightLabel, highlightLabel) || other.highlightLabel == highlightLabel)&&(identical(other.highlightDetail, highlightDetail) || other.highlightDetail == highlightDetail)&&(identical(other.likesCount, likesCount) || other.likesCount == likesCount)&&(identical(other.commentsCount, commentsCount) || other.commentsCount == commentsCount)&&(identical(other.sharesCount, sharesCount) || other.sharesCount == sharesCount)&&(identical(other.liked, liked) || other.liked == liked)&&(identical(other.bookmarked, bookmarked) || other.bookmarked == bookmarked)&&(identical(other.itineraryCtaLabel, itineraryCtaLabel) || other.itineraryCtaLabel == itineraryCtaLabel)&&(identical(other.joinCtaLabel, joinCtaLabel) || other.joinCtaLabel == joinCtaLabel));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hashAll([runtimeType,postId,author,timeLabel,recruitBadge,placeLabel,caption,tripId,tripTitle,spotsLeftLabel,urgencyLabel,scheduleLabel,priceLabel,membersLabel,fillRatio,fillPercentLabel,const DeepCollectionEquality().hash(_memberAvatars),extraMemberCount,highlightLabel,highlightDetail,likesCount,commentsCount,sharesCount,liked,bookmarked,itineraryCtaLabel,joinCtaLabel]);
}

@override
String toString() {
    return 'SocialFeedTripRecruit(postId: $postId, author: $author, timeLabel: $timeLabel, recruitBadge: $recruitBadge, placeLabel: $placeLabel, caption: $caption, tripId: $tripId, tripTitle: $tripTitle, spotsLeftLabel: $spotsLeftLabel, urgencyLabel: $urgencyLabel, scheduleLabel: $scheduleLabel, priceLabel: $priceLabel, membersLabel: $membersLabel, fillRatio: $fillRatio, fillPercentLabel: $fillPercentLabel, memberAvatars: $memberAvatars, extraMemberCount: $extraMemberCount, highlightLabel: $highlightLabel, highlightDetail: $highlightDetail, likesCount: $likesCount, commentsCount: $commentsCount, sharesCount: $sharesCount, liked: $liked, bookmarked: $bookmarked, itineraryCtaLabel: $itineraryCtaLabel, joinCtaLabel: $joinCtaLabel)';
}


}

/// @nodoc
abstract mixin class _$SocialFeedTripRecruitCopyWith<$Res> implements $SocialFeedTripRecruitCopyWith<$Res> {
  factory _$SocialFeedTripRecruitCopyWith(_SocialFeedTripRecruit value, $Res Function(_SocialFeedTripRecruit) _then) = __$SocialFeedTripRecruitCopyWithImpl;
@override @useResult
$Res call({
 String postId, SocialFeedAuthor author, String timeLabel, String recruitBadge, String placeLabel, String caption, String tripId, String tripTitle, String spotsLeftLabel, String urgencyLabel, String scheduleLabel, String priceLabel, String membersLabel,@JsonKey(fromJson: _readDouble) double fillRatio, String fillPercentLabel, List<String> memberAvatars,@JsonKey(fromJson: _readInt) int extraMemberCount, String? highlightLabel, String? highlightDetail,@JsonKey(fromJson: _readInt) int likesCount,@JsonKey(fromJson: _readInt) int commentsCount,@JsonKey(fromJson: _readInt) int sharesCount, bool liked, bool bookmarked, String itineraryCtaLabel, String joinCtaLabel
});


@override $SocialFeedAuthorCopyWith<$Res> get author;

}
/// @nodoc
class __$SocialFeedTripRecruitCopyWithImpl<$Res>
    implements _$SocialFeedTripRecruitCopyWith<$Res> {
  __$SocialFeedTripRecruitCopyWithImpl(this._self, this._then);

  final _SocialFeedTripRecruit _self;
  final $Res Function(_SocialFeedTripRecruit) _then;

/// Create a copy of SocialFeedTripRecruit
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? postId = null,Object? author = null,Object? timeLabel = null,Object? recruitBadge = null,Object? placeLabel = null,Object? caption = null,Object? tripId = null,Object? tripTitle = null,Object? spotsLeftLabel = null,Object? urgencyLabel = null,Object? scheduleLabel = null,Object? priceLabel = null,Object? membersLabel = null,Object? fillRatio = null,Object? fillPercentLabel = null,Object? memberAvatars = null,Object? extraMemberCount = null,Object? highlightLabel = freezed,Object? highlightDetail = freezed,Object? likesCount = null,Object? commentsCount = null,Object? sharesCount = null,Object? liked = null,Object? bookmarked = null,Object? itineraryCtaLabel = null,Object? joinCtaLabel = null,}) {
  return _then(_SocialFeedTripRecruit(
postId: null == postId ? _self.postId : postId // ignore: cast_nullable_to_non_nullable
as String,author: null == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as SocialFeedAuthor,timeLabel: null == timeLabel ? _self.timeLabel : timeLabel // ignore: cast_nullable_to_non_nullable
as String,recruitBadge: null == recruitBadge ? _self.recruitBadge : recruitBadge // ignore: cast_nullable_to_non_nullable
as String,placeLabel: null == placeLabel ? _self.placeLabel : placeLabel // ignore: cast_nullable_to_non_nullable
as String,caption: null == caption ? _self.caption : caption // ignore: cast_nullable_to_non_nullable
as String,tripId: null == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String,tripTitle: null == tripTitle ? _self.tripTitle : tripTitle // ignore: cast_nullable_to_non_nullable
as String,spotsLeftLabel: null == spotsLeftLabel ? _self.spotsLeftLabel : spotsLeftLabel // ignore: cast_nullable_to_non_nullable
as String,urgencyLabel: null == urgencyLabel ? _self.urgencyLabel : urgencyLabel // ignore: cast_nullable_to_non_nullable
as String,scheduleLabel: null == scheduleLabel ? _self.scheduleLabel : scheduleLabel // ignore: cast_nullable_to_non_nullable
as String,priceLabel: null == priceLabel ? _self.priceLabel : priceLabel // ignore: cast_nullable_to_non_nullable
as String,membersLabel: null == membersLabel ? _self.membersLabel : membersLabel // ignore: cast_nullable_to_non_nullable
as String,fillRatio: null == fillRatio ? _self.fillRatio : fillRatio // ignore: cast_nullable_to_non_nullable
as double,fillPercentLabel: null == fillPercentLabel ? _self.fillPercentLabel : fillPercentLabel // ignore: cast_nullable_to_non_nullable
as String,memberAvatars: null == memberAvatars ? _self._memberAvatars : memberAvatars // ignore: cast_nullable_to_non_nullable
as List<String>,extraMemberCount: null == extraMemberCount ? _self.extraMemberCount : extraMemberCount // ignore: cast_nullable_to_non_nullable
as int,highlightLabel: freezed == highlightLabel ? _self.highlightLabel : highlightLabel // ignore: cast_nullable_to_non_nullable
as String?,highlightDetail: freezed == highlightDetail ? _self.highlightDetail : highlightDetail // ignore: cast_nullable_to_non_nullable
as String?,likesCount: null == likesCount ? _self.likesCount : likesCount // ignore: cast_nullable_to_non_nullable
as int,commentsCount: null == commentsCount ? _self.commentsCount : commentsCount // ignore: cast_nullable_to_non_nullable
as int,sharesCount: null == sharesCount ? _self.sharesCount : sharesCount // ignore: cast_nullable_to_non_nullable
as int,liked: null == liked ? _self.liked : liked // ignore: cast_nullable_to_non_nullable
as bool,bookmarked: null == bookmarked ? _self.bookmarked : bookmarked // ignore: cast_nullable_to_non_nullable
as bool,itineraryCtaLabel: null == itineraryCtaLabel ? _self.itineraryCtaLabel : itineraryCtaLabel // ignore: cast_nullable_to_non_nullable
as String,joinCtaLabel: null == joinCtaLabel ? _self.joinCtaLabel : joinCtaLabel // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of SocialFeedTripRecruit
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SocialFeedAuthorCopyWith<$Res> get author {
  
  return $SocialFeedAuthorCopyWith<$Res>(_self.author, (value) {
    return _then(_self.copyWith(author: value));
  });
}
}

// dart format on
