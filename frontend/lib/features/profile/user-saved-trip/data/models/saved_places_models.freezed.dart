// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'saved_places_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SavedPlacesPage {

@JsonKey(name: 'data') List<SavedPlace> get items; SavedPlacesPageMeta get meta;
/// Create a copy of SavedPlacesPage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SavedPlacesPageCopyWith<SavedPlacesPage> get copyWith => _$SavedPlacesPageCopyWithImpl<SavedPlacesPage>(this as SavedPlacesPage, _$identity);

  /// Serializes this SavedPlacesPage to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SavedPlacesPage;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SavedPlacesPage&&const DeepCollectionEquality().equals(other.items, _this.items)&&(identical(other.meta, _this.meta) || other.meta == _this.meta));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SavedPlacesPage;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.items),_this.meta);
}

@override
String toString() {
  final _this = this as SavedPlacesPage;
  return 'SavedPlacesPage(items: ${_this.items}, meta: ${_this.meta})';
}


}

/// @nodoc
abstract mixin class $SavedPlacesPageCopyWith<$Res>  {
  factory $SavedPlacesPageCopyWith(SavedPlacesPage value, $Res Function(SavedPlacesPage) _then) = _$SavedPlacesPageCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'data') List<SavedPlace> items, SavedPlacesPageMeta meta
});


$SavedPlacesPageMetaCopyWith<$Res> get meta;

}
/// @nodoc
class _$SavedPlacesPageCopyWithImpl<$Res>
    implements $SavedPlacesPageCopyWith<$Res> {
  _$SavedPlacesPageCopyWithImpl(this._self, this._then);

  final SavedPlacesPage _self;
  final $Res Function(SavedPlacesPage) _then;

/// Create a copy of SavedPlacesPage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,Object? meta = null,}) {
  return _then(SavedPlacesPage(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<SavedPlace>,meta: null == meta ? _self.meta : meta // ignore: cast_nullable_to_non_nullable
as SavedPlacesPageMeta,
  ));
}
/// Create a copy of SavedPlacesPage
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SavedPlacesPageMetaCopyWith<$Res> get meta {
  
  return $SavedPlacesPageMetaCopyWith<$Res>(_self.meta, (value) {
    return _then(_self.copyWith(meta: value));
  });
}
}


/// Adds pattern-matching-related methods to [SavedPlacesPage].
extension SavedPlacesPagePatterns on SavedPlacesPage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SavedPlacesPage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SavedPlacesPage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SavedPlacesPage value)  $default,){
final _that = this;
switch (_that) {
case _SavedPlacesPage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SavedPlacesPage value)?  $default,){
final _that = this;
switch (_that) {
case _SavedPlacesPage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'data')  List<SavedPlace> items,  SavedPlacesPageMeta meta)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SavedPlacesPage() when $default != null:
return $default(_that.items,_that.meta);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'data')  List<SavedPlace> items,  SavedPlacesPageMeta meta)  $default,) {final _that = this;
switch (_that) {
case _SavedPlacesPage():
return $default(_that.items,_that.meta);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'data')  List<SavedPlace> items,  SavedPlacesPageMeta meta)?  $default,) {final _that = this;
switch (_that) {
case _SavedPlacesPage() when $default != null:
return $default(_that.items,_that.meta);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SavedPlacesPage implements SavedPlacesPage {
  const _SavedPlacesPage({@JsonKey(name: 'data')  List<SavedPlace> items = const <SavedPlace>[], required this.meta}): _items = items;
  factory _SavedPlacesPage.fromJson(Map<String, dynamic> json) => _$SavedPlacesPageFromJson(json);

 final  List<SavedPlace> _items;
@override@JsonKey(name: 'data') List<SavedPlace> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override final  SavedPlacesPageMeta meta;

/// Create a copy of SavedPlacesPage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SavedPlacesPageCopyWith<_SavedPlacesPage> get copyWith => __$SavedPlacesPageCopyWithImpl<_SavedPlacesPage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SavedPlacesPageToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SavedPlacesPage&&const DeepCollectionEquality().equals(other.items, _items)&&(identical(other.meta, meta) || other.meta == meta));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),meta);
}

@override
String toString() {
    return 'SavedPlacesPage(items: $items, meta: $meta)';
}


}

/// @nodoc
abstract mixin class _$SavedPlacesPageCopyWith<$Res> implements $SavedPlacesPageCopyWith<$Res> {
  factory _$SavedPlacesPageCopyWith(_SavedPlacesPage value, $Res Function(_SavedPlacesPage) _then) = __$SavedPlacesPageCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'data') List<SavedPlace> items, SavedPlacesPageMeta meta
});


@override $SavedPlacesPageMetaCopyWith<$Res> get meta;

}
/// @nodoc
class __$SavedPlacesPageCopyWithImpl<$Res>
    implements _$SavedPlacesPageCopyWith<$Res> {
  __$SavedPlacesPageCopyWithImpl(this._self, this._then);

  final _SavedPlacesPage _self;
  final $Res Function(_SavedPlacesPage) _then;

/// Create a copy of SavedPlacesPage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,Object? meta = null,}) {
  return _then(_SavedPlacesPage(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<SavedPlace>,meta: null == meta ? _self.meta : meta // ignore: cast_nullable_to_non_nullable
as SavedPlacesPageMeta,
  ));
}

/// Create a copy of SavedPlacesPage
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SavedPlacesPageMetaCopyWith<$Res> get meta {
  
  return $SavedPlacesPageMetaCopyWith<$Res>(_self.meta, (value) {
    return _then(_self.copyWith(meta: value));
  });
}
}


/// @nodoc
mixin _$SavedPlacesPageMeta {

@JsonKey(fromJson: _readInt) int get page;@JsonKey(fromJson: _readInt) int get limit;@JsonKey(fromJson: _readInt) int get total;@JsonKey(fromJson: _readInt) int get totalPages; bool get hasNextPage; bool get hasPreviousPage;
/// Create a copy of SavedPlacesPageMeta
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SavedPlacesPageMetaCopyWith<SavedPlacesPageMeta> get copyWith => _$SavedPlacesPageMetaCopyWithImpl<SavedPlacesPageMeta>(this as SavedPlacesPageMeta, _$identity);

  /// Serializes this SavedPlacesPageMeta to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SavedPlacesPageMeta;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SavedPlacesPageMeta&&(identical(other.page, _this.page) || other.page == _this.page)&&(identical(other.limit, _this.limit) || other.limit == _this.limit)&&(identical(other.total, _this.total) || other.total == _this.total)&&(identical(other.totalPages, _this.totalPages) || other.totalPages == _this.totalPages)&&(identical(other.hasNextPage, _this.hasNextPage) || other.hasNextPage == _this.hasNextPage)&&(identical(other.hasPreviousPage, _this.hasPreviousPage) || other.hasPreviousPage == _this.hasPreviousPage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SavedPlacesPageMeta;
  return Object.hash(runtimeType,_this.page,_this.limit,_this.total,_this.totalPages,_this.hasNextPage,_this.hasPreviousPage);
}

@override
String toString() {
  final _this = this as SavedPlacesPageMeta;
  return 'SavedPlacesPageMeta(page: ${_this.page}, limit: ${_this.limit}, total: ${_this.total}, totalPages: ${_this.totalPages}, hasNextPage: ${_this.hasNextPage}, hasPreviousPage: ${_this.hasPreviousPage})';
}


}

/// @nodoc
abstract mixin class $SavedPlacesPageMetaCopyWith<$Res>  {
  factory $SavedPlacesPageMetaCopyWith(SavedPlacesPageMeta value, $Res Function(SavedPlacesPageMeta) _then) = _$SavedPlacesPageMetaCopyWithImpl;
@useResult
$Res call({
@JsonKey(fromJson: _readInt) int page,@JsonKey(fromJson: _readInt) int limit,@JsonKey(fromJson: _readInt) int total,@JsonKey(fromJson: _readInt) int totalPages, bool hasNextPage, bool hasPreviousPage
});




}
/// @nodoc
class _$SavedPlacesPageMetaCopyWithImpl<$Res>
    implements $SavedPlacesPageMetaCopyWith<$Res> {
  _$SavedPlacesPageMetaCopyWithImpl(this._self, this._then);

  final SavedPlacesPageMeta _self;
  final $Res Function(SavedPlacesPageMeta) _then;

/// Create a copy of SavedPlacesPageMeta
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? page = null,Object? limit = null,Object? total = null,Object? totalPages = null,Object? hasNextPage = null,Object? hasPreviousPage = null,}) {
  return _then(SavedPlacesPageMeta(
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


/// Adds pattern-matching-related methods to [SavedPlacesPageMeta].
extension SavedPlacesPageMetaPatterns on SavedPlacesPageMeta {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SavedPlacesPageMeta value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SavedPlacesPageMeta() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SavedPlacesPageMeta value)  $default,){
final _that = this;
switch (_that) {
case _SavedPlacesPageMeta():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SavedPlacesPageMeta value)?  $default,){
final _that = this;
switch (_that) {
case _SavedPlacesPageMeta() when $default != null:
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
case _SavedPlacesPageMeta() when $default != null:
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
case _SavedPlacesPageMeta():
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
case _SavedPlacesPageMeta() when $default != null:
return $default(_that.page,_that.limit,_that.total,_that.totalPages,_that.hasNextPage,_that.hasPreviousPage);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SavedPlacesPageMeta implements SavedPlacesPageMeta {
  const _SavedPlacesPageMeta({@JsonKey(fromJson: _readInt) required this.page, @JsonKey(fromJson: _readInt) required this.limit, @JsonKey(fromJson: _readInt) required this.total, @JsonKey(fromJson: _readInt) required this.totalPages, required this.hasNextPage, required this.hasPreviousPage});
  factory _SavedPlacesPageMeta.fromJson(Map<String, dynamic> json) => _$SavedPlacesPageMetaFromJson(json);

@override@JsonKey(fromJson: _readInt) final  int page;
@override@JsonKey(fromJson: _readInt) final  int limit;
@override@JsonKey(fromJson: _readInt) final  int total;
@override@JsonKey(fromJson: _readInt) final  int totalPages;
@override final  bool hasNextPage;
@override final  bool hasPreviousPage;

/// Create a copy of SavedPlacesPageMeta
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SavedPlacesPageMetaCopyWith<_SavedPlacesPageMeta> get copyWith => __$SavedPlacesPageMetaCopyWithImpl<_SavedPlacesPageMeta>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SavedPlacesPageMetaToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SavedPlacesPageMeta&&(identical(other.page, page) || other.page == page)&&(identical(other.limit, limit) || other.limit == limit)&&(identical(other.total, total) || other.total == total)&&(identical(other.totalPages, totalPages) || other.totalPages == totalPages)&&(identical(other.hasNextPage, hasNextPage) || other.hasNextPage == hasNextPage)&&(identical(other.hasPreviousPage, hasPreviousPage) || other.hasPreviousPage == hasPreviousPage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,page,limit,total,totalPages,hasNextPage,hasPreviousPage);
}

@override
String toString() {
    return 'SavedPlacesPageMeta(page: $page, limit: $limit, total: $total, totalPages: $totalPages, hasNextPage: $hasNextPage, hasPreviousPage: $hasPreviousPage)';
}


}

/// @nodoc
abstract mixin class _$SavedPlacesPageMetaCopyWith<$Res> implements $SavedPlacesPageMetaCopyWith<$Res> {
  factory _$SavedPlacesPageMetaCopyWith(_SavedPlacesPageMeta value, $Res Function(_SavedPlacesPageMeta) _then) = __$SavedPlacesPageMetaCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(fromJson: _readInt) int page,@JsonKey(fromJson: _readInt) int limit,@JsonKey(fromJson: _readInt) int total,@JsonKey(fromJson: _readInt) int totalPages, bool hasNextPage, bool hasPreviousPage
});




}
/// @nodoc
class __$SavedPlacesPageMetaCopyWithImpl<$Res>
    implements _$SavedPlacesPageMetaCopyWith<$Res> {
  __$SavedPlacesPageMetaCopyWithImpl(this._self, this._then);

  final _SavedPlacesPageMeta _self;
  final $Res Function(_SavedPlacesPageMeta) _then;

/// Create a copy of SavedPlacesPageMeta
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? page = null,Object? limit = null,Object? total = null,Object? totalPages = null,Object? hasNextPage = null,Object? hasPreviousPage = null,}) {
  return _then(_SavedPlacesPageMeta(
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
mixin _$SavedPlacesCountEnvelope {

 SavedPlacesCount get data;
/// Create a copy of SavedPlacesCountEnvelope
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SavedPlacesCountEnvelopeCopyWith<SavedPlacesCountEnvelope> get copyWith => _$SavedPlacesCountEnvelopeCopyWithImpl<SavedPlacesCountEnvelope>(this as SavedPlacesCountEnvelope, _$identity);

  /// Serializes this SavedPlacesCountEnvelope to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SavedPlacesCountEnvelope;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SavedPlacesCountEnvelope&&(identical(other.data, _this.data) || other.data == _this.data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SavedPlacesCountEnvelope;
  return Object.hash(runtimeType,_this.data);
}

@override
String toString() {
  final _this = this as SavedPlacesCountEnvelope;
  return 'SavedPlacesCountEnvelope(data: ${_this.data})';
}


}

/// @nodoc
abstract mixin class $SavedPlacesCountEnvelopeCopyWith<$Res>  {
  factory $SavedPlacesCountEnvelopeCopyWith(SavedPlacesCountEnvelope value, $Res Function(SavedPlacesCountEnvelope) _then) = _$SavedPlacesCountEnvelopeCopyWithImpl;
@useResult
$Res call({
 SavedPlacesCount data
});


$SavedPlacesCountCopyWith<$Res> get data;

}
/// @nodoc
class _$SavedPlacesCountEnvelopeCopyWithImpl<$Res>
    implements $SavedPlacesCountEnvelopeCopyWith<$Res> {
  _$SavedPlacesCountEnvelopeCopyWithImpl(this._self, this._then);

  final SavedPlacesCountEnvelope _self;
  final $Res Function(SavedPlacesCountEnvelope) _then;

/// Create a copy of SavedPlacesCountEnvelope
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? data = null,}) {
  return _then(SavedPlacesCountEnvelope(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as SavedPlacesCount,
  ));
}
/// Create a copy of SavedPlacesCountEnvelope
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SavedPlacesCountCopyWith<$Res> get data {
  
  return $SavedPlacesCountCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// Adds pattern-matching-related methods to [SavedPlacesCountEnvelope].
extension SavedPlacesCountEnvelopePatterns on SavedPlacesCountEnvelope {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SavedPlacesCountEnvelope value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SavedPlacesCountEnvelope() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SavedPlacesCountEnvelope value)  $default,){
final _that = this;
switch (_that) {
case _SavedPlacesCountEnvelope():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SavedPlacesCountEnvelope value)?  $default,){
final _that = this;
switch (_that) {
case _SavedPlacesCountEnvelope() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( SavedPlacesCount data)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SavedPlacesCountEnvelope() when $default != null:
return $default(_that.data);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( SavedPlacesCount data)  $default,) {final _that = this;
switch (_that) {
case _SavedPlacesCountEnvelope():
return $default(_that.data);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( SavedPlacesCount data)?  $default,) {final _that = this;
switch (_that) {
case _SavedPlacesCountEnvelope() when $default != null:
return $default(_that.data);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SavedPlacesCountEnvelope implements SavedPlacesCountEnvelope {
  const _SavedPlacesCountEnvelope({required this.data});
  factory _SavedPlacesCountEnvelope.fromJson(Map<String, dynamic> json) => _$SavedPlacesCountEnvelopeFromJson(json);

@override final  SavedPlacesCount data;

/// Create a copy of SavedPlacesCountEnvelope
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SavedPlacesCountEnvelopeCopyWith<_SavedPlacesCountEnvelope> get copyWith => __$SavedPlacesCountEnvelopeCopyWithImpl<_SavedPlacesCountEnvelope>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SavedPlacesCountEnvelopeToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SavedPlacesCountEnvelope&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,data);
}

@override
String toString() {
    return 'SavedPlacesCountEnvelope(data: $data)';
}


}

/// @nodoc
abstract mixin class _$SavedPlacesCountEnvelopeCopyWith<$Res> implements $SavedPlacesCountEnvelopeCopyWith<$Res> {
  factory _$SavedPlacesCountEnvelopeCopyWith(_SavedPlacesCountEnvelope value, $Res Function(_SavedPlacesCountEnvelope) _then) = __$SavedPlacesCountEnvelopeCopyWithImpl;
@override @useResult
$Res call({
 SavedPlacesCount data
});


@override $SavedPlacesCountCopyWith<$Res> get data;

}
/// @nodoc
class __$SavedPlacesCountEnvelopeCopyWithImpl<$Res>
    implements _$SavedPlacesCountEnvelopeCopyWith<$Res> {
  __$SavedPlacesCountEnvelopeCopyWithImpl(this._self, this._then);

  final _SavedPlacesCountEnvelope _self;
  final $Res Function(_SavedPlacesCountEnvelope) _then;

/// Create a copy of SavedPlacesCountEnvelope
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? data = null,}) {
  return _then(_SavedPlacesCountEnvelope(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as SavedPlacesCount,
  ));
}

/// Create a copy of SavedPlacesCountEnvelope
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SavedPlacesCountCopyWith<$Res> get data {
  
  return $SavedPlacesCountCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// @nodoc
mixin _$SavedPlacesCount {

@JsonKey(fromJson: _readInt) int get count;
/// Create a copy of SavedPlacesCount
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SavedPlacesCountCopyWith<SavedPlacesCount> get copyWith => _$SavedPlacesCountCopyWithImpl<SavedPlacesCount>(this as SavedPlacesCount, _$identity);

  /// Serializes this SavedPlacesCount to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SavedPlacesCount;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SavedPlacesCount&&(identical(other.count, _this.count) || other.count == _this.count));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SavedPlacesCount;
  return Object.hash(runtimeType,_this.count);
}

@override
String toString() {
  final _this = this as SavedPlacesCount;
  return 'SavedPlacesCount(count: ${_this.count})';
}


}

/// @nodoc
abstract mixin class $SavedPlacesCountCopyWith<$Res>  {
  factory $SavedPlacesCountCopyWith(SavedPlacesCount value, $Res Function(SavedPlacesCount) _then) = _$SavedPlacesCountCopyWithImpl;
@useResult
$Res call({
@JsonKey(fromJson: _readInt) int count
});




}
/// @nodoc
class _$SavedPlacesCountCopyWithImpl<$Res>
    implements $SavedPlacesCountCopyWith<$Res> {
  _$SavedPlacesCountCopyWithImpl(this._self, this._then);

  final SavedPlacesCount _self;
  final $Res Function(SavedPlacesCount) _then;

/// Create a copy of SavedPlacesCount
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? count = null,}) {
  return _then(SavedPlacesCount(
count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [SavedPlacesCount].
extension SavedPlacesCountPatterns on SavedPlacesCount {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SavedPlacesCount value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SavedPlacesCount() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SavedPlacesCount value)  $default,){
final _that = this;
switch (_that) {
case _SavedPlacesCount():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SavedPlacesCount value)?  $default,){
final _that = this;
switch (_that) {
case _SavedPlacesCount() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(fromJson: _readInt)  int count)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SavedPlacesCount() when $default != null:
return $default(_that.count);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(fromJson: _readInt)  int count)  $default,) {final _that = this;
switch (_that) {
case _SavedPlacesCount():
return $default(_that.count);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(fromJson: _readInt)  int count)?  $default,) {final _that = this;
switch (_that) {
case _SavedPlacesCount() when $default != null:
return $default(_that.count);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SavedPlacesCount implements SavedPlacesCount {
  const _SavedPlacesCount({@JsonKey(fromJson: _readInt) required this.count});
  factory _SavedPlacesCount.fromJson(Map<String, dynamic> json) => _$SavedPlacesCountFromJson(json);

@override@JsonKey(fromJson: _readInt) final  int count;

/// Create a copy of SavedPlacesCount
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SavedPlacesCountCopyWith<_SavedPlacesCount> get copyWith => __$SavedPlacesCountCopyWithImpl<_SavedPlacesCount>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SavedPlacesCountToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SavedPlacesCount&&(identical(other.count, count) || other.count == count));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,count);
}

@override
String toString() {
    return 'SavedPlacesCount(count: $count)';
}


}

/// @nodoc
abstract mixin class _$SavedPlacesCountCopyWith<$Res> implements $SavedPlacesCountCopyWith<$Res> {
  factory _$SavedPlacesCountCopyWith(_SavedPlacesCount value, $Res Function(_SavedPlacesCount) _then) = __$SavedPlacesCountCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(fromJson: _readInt) int count
});




}
/// @nodoc
class __$SavedPlacesCountCopyWithImpl<$Res>
    implements _$SavedPlacesCountCopyWith<$Res> {
  __$SavedPlacesCountCopyWithImpl(this._self, this._then);

  final _SavedPlacesCount _self;
  final $Res Function(_SavedPlacesCount) _then;

/// Create a copy of SavedPlacesCount
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? count = null,}) {
  return _then(_SavedPlacesCount(
count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$SavedPlace {

 String get id; String get userId; String get placeId; DateTime get createdAt; SavedPlaceDetails get place;
/// Create a copy of SavedPlace
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SavedPlaceCopyWith<SavedPlace> get copyWith => _$SavedPlaceCopyWithImpl<SavedPlace>(this as SavedPlace, _$identity);

  /// Serializes this SavedPlace to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SavedPlace;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SavedPlace&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.userId, _this.userId) || other.userId == _this.userId)&&(identical(other.placeId, _this.placeId) || other.placeId == _this.placeId)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.place, _this.place) || other.place == _this.place));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SavedPlace;
  return Object.hash(runtimeType,_this.id,_this.userId,_this.placeId,_this.createdAt,_this.place);
}

@override
String toString() {
  final _this = this as SavedPlace;
  return 'SavedPlace(id: ${_this.id}, userId: ${_this.userId}, placeId: ${_this.placeId}, createdAt: ${_this.createdAt}, place: ${_this.place})';
}


}

/// @nodoc
abstract mixin class $SavedPlaceCopyWith<$Res>  {
  factory $SavedPlaceCopyWith(SavedPlace value, $Res Function(SavedPlace) _then) = _$SavedPlaceCopyWithImpl;
@useResult
$Res call({
 String id, String userId, String placeId, DateTime createdAt, SavedPlaceDetails place
});


$SavedPlaceDetailsCopyWith<$Res> get place;

}
/// @nodoc
class _$SavedPlaceCopyWithImpl<$Res>
    implements $SavedPlaceCopyWith<$Res> {
  _$SavedPlaceCopyWithImpl(this._self, this._then);

  final SavedPlace _self;
  final $Res Function(SavedPlace) _then;

/// Create a copy of SavedPlace
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? placeId = null,Object? createdAt = null,Object? place = null,}) {
  return _then(SavedPlace(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,placeId: null == placeId ? _self.placeId : placeId // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,place: null == place ? _self.place : place // ignore: cast_nullable_to_non_nullable
as SavedPlaceDetails,
  ));
}
/// Create a copy of SavedPlace
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SavedPlaceDetailsCopyWith<$Res> get place {
  
  return $SavedPlaceDetailsCopyWith<$Res>(_self.place, (value) {
    return _then(_self.copyWith(place: value));
  });
}
}


/// Adds pattern-matching-related methods to [SavedPlace].
extension SavedPlacePatterns on SavedPlace {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SavedPlace value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SavedPlace() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SavedPlace value)  $default,){
final _that = this;
switch (_that) {
case _SavedPlace():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SavedPlace value)?  $default,){
final _that = this;
switch (_that) {
case _SavedPlace() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String userId,  String placeId,  DateTime createdAt,  SavedPlaceDetails place)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SavedPlace() when $default != null:
return $default(_that.id,_that.userId,_that.placeId,_that.createdAt,_that.place);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String userId,  String placeId,  DateTime createdAt,  SavedPlaceDetails place)  $default,) {final _that = this;
switch (_that) {
case _SavedPlace():
return $default(_that.id,_that.userId,_that.placeId,_that.createdAt,_that.place);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String userId,  String placeId,  DateTime createdAt,  SavedPlaceDetails place)?  $default,) {final _that = this;
switch (_that) {
case _SavedPlace() when $default != null:
return $default(_that.id,_that.userId,_that.placeId,_that.createdAt,_that.place);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SavedPlace implements SavedPlace {
  const _SavedPlace({required this.id, required this.userId, required this.placeId, required this.createdAt, required this.place});
  factory _SavedPlace.fromJson(Map<String, dynamic> json) => _$SavedPlaceFromJson(json);

@override final  String id;
@override final  String userId;
@override final  String placeId;
@override final  DateTime createdAt;
@override final  SavedPlaceDetails place;

/// Create a copy of SavedPlace
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SavedPlaceCopyWith<_SavedPlace> get copyWith => __$SavedPlaceCopyWithImpl<_SavedPlace>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SavedPlaceToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SavedPlace&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.placeId, placeId) || other.placeId == placeId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.place, place) || other.place == place));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,userId,placeId,createdAt,place);
}

@override
String toString() {
    return 'SavedPlace(id: $id, userId: $userId, placeId: $placeId, createdAt: $createdAt, place: $place)';
}


}

/// @nodoc
abstract mixin class _$SavedPlaceCopyWith<$Res> implements $SavedPlaceCopyWith<$Res> {
  factory _$SavedPlaceCopyWith(_SavedPlace value, $Res Function(_SavedPlace) _then) = __$SavedPlaceCopyWithImpl;
@override @useResult
$Res call({
 String id, String userId, String placeId, DateTime createdAt, SavedPlaceDetails place
});


@override $SavedPlaceDetailsCopyWith<$Res> get place;

}
/// @nodoc
class __$SavedPlaceCopyWithImpl<$Res>
    implements _$SavedPlaceCopyWith<$Res> {
  __$SavedPlaceCopyWithImpl(this._self, this._then);

  final _SavedPlace _self;
  final $Res Function(_SavedPlace) _then;

/// Create a copy of SavedPlace
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? placeId = null,Object? createdAt = null,Object? place = null,}) {
  return _then(_SavedPlace(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,placeId: null == placeId ? _self.placeId : placeId // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,place: null == place ? _self.place : place // ignore: cast_nullable_to_non_nullable
as SavedPlaceDetails,
  ));
}

/// Create a copy of SavedPlace
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SavedPlaceDetailsCopyWith<$Res> get place {
  
  return $SavedPlaceDetailsCopyWith<$Res>(_self.place, (value) {
    return _then(_self.copyWith(place: value));
  });
}
}


/// @nodoc
mixin _$SavedPlaceDetails {

 String get id; String get name; String? get description; String? get category; String get city; String get country; String? get address;@JsonKey(fromJson: _readDouble) double get latitude;@JsonKey(fromJson: _readDouble) double get longitude;@JsonKey(fromJson: _readDouble) double get averageRating;
/// Create a copy of SavedPlaceDetails
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SavedPlaceDetailsCopyWith<SavedPlaceDetails> get copyWith => _$SavedPlaceDetailsCopyWithImpl<SavedPlaceDetails>(this as SavedPlaceDetails, _$identity);

  /// Serializes this SavedPlaceDetails to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SavedPlaceDetails;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SavedPlaceDetails&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.category, _this.category) || other.category == _this.category)&&(identical(other.city, _this.city) || other.city == _this.city)&&(identical(other.country, _this.country) || other.country == _this.country)&&(identical(other.address, _this.address) || other.address == _this.address)&&(identical(other.latitude, _this.latitude) || other.latitude == _this.latitude)&&(identical(other.longitude, _this.longitude) || other.longitude == _this.longitude)&&(identical(other.averageRating, _this.averageRating) || other.averageRating == _this.averageRating));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SavedPlaceDetails;
  return Object.hash(runtimeType,_this.id,_this.name,_this.description,_this.category,_this.city,_this.country,_this.address,_this.latitude,_this.longitude,_this.averageRating);
}

@override
String toString() {
  final _this = this as SavedPlaceDetails;
  return 'SavedPlaceDetails(id: ${_this.id}, name: ${_this.name}, description: ${_this.description}, category: ${_this.category}, city: ${_this.city}, country: ${_this.country}, address: ${_this.address}, latitude: ${_this.latitude}, longitude: ${_this.longitude}, averageRating: ${_this.averageRating})';
}


}

/// @nodoc
abstract mixin class $SavedPlaceDetailsCopyWith<$Res>  {
  factory $SavedPlaceDetailsCopyWith(SavedPlaceDetails value, $Res Function(SavedPlaceDetails) _then) = _$SavedPlaceDetailsCopyWithImpl;
@useResult
$Res call({
 String id, String name, String? description, String? category, String city, String country, String? address,@JsonKey(fromJson: _readDouble) double latitude,@JsonKey(fromJson: _readDouble) double longitude,@JsonKey(fromJson: _readDouble) double averageRating
});




}
/// @nodoc
class _$SavedPlaceDetailsCopyWithImpl<$Res>
    implements $SavedPlaceDetailsCopyWith<$Res> {
  _$SavedPlaceDetailsCopyWithImpl(this._self, this._then);

  final SavedPlaceDetails _self;
  final $Res Function(SavedPlaceDetails) _then;

/// Create a copy of SavedPlaceDetails
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? description = freezed,Object? category = freezed,Object? city = null,Object? country = null,Object? address = freezed,Object? latitude = null,Object? longitude = null,Object? averageRating = null,}) {
  return _then(SavedPlaceDetails(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,country: null == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,averageRating: null == averageRating ? _self.averageRating : averageRating // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [SavedPlaceDetails].
extension SavedPlaceDetailsPatterns on SavedPlaceDetails {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SavedPlaceDetails value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SavedPlaceDetails() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SavedPlaceDetails value)  $default,){
final _that = this;
switch (_that) {
case _SavedPlaceDetails():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SavedPlaceDetails value)?  $default,){
final _that = this;
switch (_that) {
case _SavedPlaceDetails() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String? description,  String? category,  String city,  String country,  String? address, @JsonKey(fromJson: _readDouble)  double latitude, @JsonKey(fromJson: _readDouble)  double longitude, @JsonKey(fromJson: _readDouble)  double averageRating)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SavedPlaceDetails() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.category,_that.city,_that.country,_that.address,_that.latitude,_that.longitude,_that.averageRating);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String? description,  String? category,  String city,  String country,  String? address, @JsonKey(fromJson: _readDouble)  double latitude, @JsonKey(fromJson: _readDouble)  double longitude, @JsonKey(fromJson: _readDouble)  double averageRating)  $default,) {final _that = this;
switch (_that) {
case _SavedPlaceDetails():
return $default(_that.id,_that.name,_that.description,_that.category,_that.city,_that.country,_that.address,_that.latitude,_that.longitude,_that.averageRating);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String? description,  String? category,  String city,  String country,  String? address, @JsonKey(fromJson: _readDouble)  double latitude, @JsonKey(fromJson: _readDouble)  double longitude, @JsonKey(fromJson: _readDouble)  double averageRating)?  $default,) {final _that = this;
switch (_that) {
case _SavedPlaceDetails() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.category,_that.city,_that.country,_that.address,_that.latitude,_that.longitude,_that.averageRating);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SavedPlaceDetails implements SavedPlaceDetails {
  const _SavedPlaceDetails({required this.id, required this.name, this.description, this.category, required this.city, required this.country, this.address, @JsonKey(fromJson: _readDouble) required this.latitude, @JsonKey(fromJson: _readDouble) required this.longitude, @JsonKey(fromJson: _readDouble) required this.averageRating});
  factory _SavedPlaceDetails.fromJson(Map<String, dynamic> json) => _$SavedPlaceDetailsFromJson(json);

@override final  String id;
@override final  String name;
@override final  String? description;
@override final  String? category;
@override final  String city;
@override final  String country;
@override final  String? address;
@override@JsonKey(fromJson: _readDouble) final  double latitude;
@override@JsonKey(fromJson: _readDouble) final  double longitude;
@override@JsonKey(fromJson: _readDouble) final  double averageRating;

/// Create a copy of SavedPlaceDetails
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SavedPlaceDetailsCopyWith<_SavedPlaceDetails> get copyWith => __$SavedPlaceDetailsCopyWithImpl<_SavedPlaceDetails>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SavedPlaceDetailsToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SavedPlaceDetails&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.category, category) || other.category == category)&&(identical(other.city, city) || other.city == city)&&(identical(other.country, country) || other.country == country)&&(identical(other.address, address) || other.address == address)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.averageRating, averageRating) || other.averageRating == averageRating));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,name,description,category,city,country,address,latitude,longitude,averageRating);
}

@override
String toString() {
    return 'SavedPlaceDetails(id: $id, name: $name, description: $description, category: $category, city: $city, country: $country, address: $address, latitude: $latitude, longitude: $longitude, averageRating: $averageRating)';
}


}

/// @nodoc
abstract mixin class _$SavedPlaceDetailsCopyWith<$Res> implements $SavedPlaceDetailsCopyWith<$Res> {
  factory _$SavedPlaceDetailsCopyWith(_SavedPlaceDetails value, $Res Function(_SavedPlaceDetails) _then) = __$SavedPlaceDetailsCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String? description, String? category, String city, String country, String? address,@JsonKey(fromJson: _readDouble) double latitude,@JsonKey(fromJson: _readDouble) double longitude,@JsonKey(fromJson: _readDouble) double averageRating
});




}
/// @nodoc
class __$SavedPlaceDetailsCopyWithImpl<$Res>
    implements _$SavedPlaceDetailsCopyWith<$Res> {
  __$SavedPlaceDetailsCopyWithImpl(this._self, this._then);

  final _SavedPlaceDetails _self;
  final $Res Function(_SavedPlaceDetails) _then;

/// Create a copy of SavedPlaceDetails
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? description = freezed,Object? category = freezed,Object? city = null,Object? country = null,Object? address = freezed,Object? latitude = null,Object? longitude = null,Object? averageRating = null,}) {
  return _then(_SavedPlaceDetails(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,country: null == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,averageRating: null == averageRating ? _self.averageRating : averageRating // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
