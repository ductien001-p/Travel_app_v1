// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_memories_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserMemoriesPage {

@JsonKey(name: 'data') List<UserMemoryPhoto> get items; List<UserMemoryCollection>? get collections; UserMemoryPhoto? get highlight; UserMemoriesMeta get meta;
/// Create a copy of UserMemoriesPage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserMemoriesPageCopyWith<UserMemoriesPage> get copyWith => _$UserMemoriesPageCopyWithImpl<UserMemoriesPage>(this as UserMemoriesPage, _$identity);

  /// Serializes this UserMemoriesPage to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as UserMemoriesPage;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserMemoriesPage&&const DeepCollectionEquality().equals(other.items, _this.items)&&const DeepCollectionEquality().equals(other.collections, _this.collections)&&(identical(other.highlight, _this.highlight) || other.highlight == _this.highlight)&&(identical(other.meta, _this.meta) || other.meta == _this.meta));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as UserMemoriesPage;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.items),const DeepCollectionEquality().hash(_this.collections),_this.highlight,_this.meta);
}

@override
String toString() {
  final _this = this as UserMemoriesPage;
  return 'UserMemoriesPage(items: ${_this.items}, collections: ${_this.collections}, highlight: ${_this.highlight}, meta: ${_this.meta})';
}


}

/// @nodoc
abstract mixin class $UserMemoriesPageCopyWith<$Res>  {
  factory $UserMemoriesPageCopyWith(UserMemoriesPage value, $Res Function(UserMemoriesPage) _then) = _$UserMemoriesPageCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'data') List<UserMemoryPhoto> items, List<UserMemoryCollection>? collections, UserMemoryPhoto? highlight, UserMemoriesMeta meta
});


$UserMemoryPhotoCopyWith<$Res>? get highlight;$UserMemoriesMetaCopyWith<$Res> get meta;

}
/// @nodoc
class _$UserMemoriesPageCopyWithImpl<$Res>
    implements $UserMemoriesPageCopyWith<$Res> {
  _$UserMemoriesPageCopyWithImpl(this._self, this._then);

  final UserMemoriesPage _self;
  final $Res Function(UserMemoriesPage) _then;

/// Create a copy of UserMemoriesPage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,Object? collections = freezed,Object? highlight = freezed,Object? meta = null,}) {
  return _then(UserMemoriesPage(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<UserMemoryPhoto>,collections: freezed == collections ? _self.collections : collections // ignore: cast_nullable_to_non_nullable
as List<UserMemoryCollection>?,highlight: freezed == highlight ? _self.highlight : highlight // ignore: cast_nullable_to_non_nullable
as UserMemoryPhoto?,meta: null == meta ? _self.meta : meta // ignore: cast_nullable_to_non_nullable
as UserMemoriesMeta,
  ));
}
/// Create a copy of UserMemoriesPage
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserMemoryPhotoCopyWith<$Res>? get highlight {
    if (_self.highlight == null) {
    return null;
  }

  return $UserMemoryPhotoCopyWith<$Res>(_self.highlight!, (value) {
    return _then(_self.copyWith(highlight: value));
  });
}/// Create a copy of UserMemoriesPage
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserMemoriesMetaCopyWith<$Res> get meta {
  
  return $UserMemoriesMetaCopyWith<$Res>(_self.meta, (value) {
    return _then(_self.copyWith(meta: value));
  });
}
}


/// Adds pattern-matching-related methods to [UserMemoriesPage].
extension UserMemoriesPagePatterns on UserMemoriesPage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserMemoriesPage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserMemoriesPage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserMemoriesPage value)  $default,){
final _that = this;
switch (_that) {
case _UserMemoriesPage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserMemoriesPage value)?  $default,){
final _that = this;
switch (_that) {
case _UserMemoriesPage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'data')  List<UserMemoryPhoto> items,  List<UserMemoryCollection>? collections,  UserMemoryPhoto? highlight,  UserMemoriesMeta meta)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserMemoriesPage() when $default != null:
return $default(_that.items,_that.collections,_that.highlight,_that.meta);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'data')  List<UserMemoryPhoto> items,  List<UserMemoryCollection>? collections,  UserMemoryPhoto? highlight,  UserMemoriesMeta meta)  $default,) {final _that = this;
switch (_that) {
case _UserMemoriesPage():
return $default(_that.items,_that.collections,_that.highlight,_that.meta);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'data')  List<UserMemoryPhoto> items,  List<UserMemoryCollection>? collections,  UserMemoryPhoto? highlight,  UserMemoriesMeta meta)?  $default,) {final _that = this;
switch (_that) {
case _UserMemoriesPage() when $default != null:
return $default(_that.items,_that.collections,_that.highlight,_that.meta);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserMemoriesPage implements UserMemoriesPage {
  const _UserMemoriesPage({@JsonKey(name: 'data')  List<UserMemoryPhoto> items = const <UserMemoryPhoto>[],  List<UserMemoryCollection>? collections, this.highlight, required this.meta}): _items = items,_collections = collections;
  factory _UserMemoriesPage.fromJson(Map<String, dynamic> json) => _$UserMemoriesPageFromJson(json);

 final  List<UserMemoryPhoto> _items;
@override@JsonKey(name: 'data') List<UserMemoryPhoto> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

 final  List<UserMemoryCollection>? _collections;
@override List<UserMemoryCollection>? get collections {
  final value = _collections;
  if (value == null) return null;
  if (_collections is EqualUnmodifiableListView) return _collections;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  UserMemoryPhoto? highlight;
@override final  UserMemoriesMeta meta;

/// Create a copy of UserMemoriesPage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserMemoriesPageCopyWith<_UserMemoriesPage> get copyWith => __$UserMemoriesPageCopyWithImpl<_UserMemoriesPage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserMemoriesPageToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserMemoriesPage&&const DeepCollectionEquality().equals(other.items, _items)&&const DeepCollectionEquality().equals(other.collections, _collections)&&(identical(other.highlight, highlight) || other.highlight == highlight)&&(identical(other.meta, meta) || other.meta == meta));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),const DeepCollectionEquality().hash(_collections),highlight,meta);
}

@override
String toString() {
    return 'UserMemoriesPage(items: $items, collections: $collections, highlight: $highlight, meta: $meta)';
}


}

/// @nodoc
abstract mixin class _$UserMemoriesPageCopyWith<$Res> implements $UserMemoriesPageCopyWith<$Res> {
  factory _$UserMemoriesPageCopyWith(_UserMemoriesPage value, $Res Function(_UserMemoriesPage) _then) = __$UserMemoriesPageCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'data') List<UserMemoryPhoto> items, List<UserMemoryCollection>? collections, UserMemoryPhoto? highlight, UserMemoriesMeta meta
});


@override $UserMemoryPhotoCopyWith<$Res>? get highlight;@override $UserMemoriesMetaCopyWith<$Res> get meta;

}
/// @nodoc
class __$UserMemoriesPageCopyWithImpl<$Res>
    implements _$UserMemoriesPageCopyWith<$Res> {
  __$UserMemoriesPageCopyWithImpl(this._self, this._then);

  final _UserMemoriesPage _self;
  final $Res Function(_UserMemoriesPage) _then;

/// Create a copy of UserMemoriesPage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,Object? collections = freezed,Object? highlight = freezed,Object? meta = null,}) {
  return _then(_UserMemoriesPage(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<UserMemoryPhoto>,collections: freezed == collections ? _self._collections : collections // ignore: cast_nullable_to_non_nullable
as List<UserMemoryCollection>?,highlight: freezed == highlight ? _self.highlight : highlight // ignore: cast_nullable_to_non_nullable
as UserMemoryPhoto?,meta: null == meta ? _self.meta : meta // ignore: cast_nullable_to_non_nullable
as UserMemoriesMeta,
  ));
}

/// Create a copy of UserMemoriesPage
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserMemoryPhotoCopyWith<$Res>? get highlight {
    if (_self.highlight == null) {
    return null;
  }

  return $UserMemoryPhotoCopyWith<$Res>(_self.highlight!, (value) {
    return _then(_self.copyWith(highlight: value));
  });
}/// Create a copy of UserMemoriesPage
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserMemoriesMetaCopyWith<$Res> get meta {
  
  return $UserMemoriesMetaCopyWith<$Res>(_self.meta, (value) {
    return _then(_self.copyWith(meta: value));
  });
}
}


/// @nodoc
mixin _$UserMemoriesMeta {

 String? get nextCursor; bool get hasMore; int? get totalCount;
/// Create a copy of UserMemoriesMeta
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserMemoriesMetaCopyWith<UserMemoriesMeta> get copyWith => _$UserMemoriesMetaCopyWithImpl<UserMemoriesMeta>(this as UserMemoriesMeta, _$identity);

  /// Serializes this UserMemoriesMeta to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as UserMemoriesMeta;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserMemoriesMeta&&(identical(other.nextCursor, _this.nextCursor) || other.nextCursor == _this.nextCursor)&&(identical(other.hasMore, _this.hasMore) || other.hasMore == _this.hasMore)&&(identical(other.totalCount, _this.totalCount) || other.totalCount == _this.totalCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as UserMemoriesMeta;
  return Object.hash(runtimeType,_this.nextCursor,_this.hasMore,_this.totalCount);
}

@override
String toString() {
  final _this = this as UserMemoriesMeta;
  return 'UserMemoriesMeta(nextCursor: ${_this.nextCursor}, hasMore: ${_this.hasMore}, totalCount: ${_this.totalCount})';
}


}

/// @nodoc
abstract mixin class $UserMemoriesMetaCopyWith<$Res>  {
  factory $UserMemoriesMetaCopyWith(UserMemoriesMeta value, $Res Function(UserMemoriesMeta) _then) = _$UserMemoriesMetaCopyWithImpl;
@useResult
$Res call({
 String? nextCursor, bool hasMore, int? totalCount
});




}
/// @nodoc
class _$UserMemoriesMetaCopyWithImpl<$Res>
    implements $UserMemoriesMetaCopyWith<$Res> {
  _$UserMemoriesMetaCopyWithImpl(this._self, this._then);

  final UserMemoriesMeta _self;
  final $Res Function(UserMemoriesMeta) _then;

/// Create a copy of UserMemoriesMeta
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? nextCursor = freezed,Object? hasMore = null,Object? totalCount = freezed,}) {
  return _then(UserMemoriesMeta(
nextCursor: freezed == nextCursor ? _self.nextCursor : nextCursor // ignore: cast_nullable_to_non_nullable
as String?,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,totalCount: freezed == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [UserMemoriesMeta].
extension UserMemoriesMetaPatterns on UserMemoriesMeta {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserMemoriesMeta value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserMemoriesMeta() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserMemoriesMeta value)  $default,){
final _that = this;
switch (_that) {
case _UserMemoriesMeta():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserMemoriesMeta value)?  $default,){
final _that = this;
switch (_that) {
case _UserMemoriesMeta() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? nextCursor,  bool hasMore,  int? totalCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserMemoriesMeta() when $default != null:
return $default(_that.nextCursor,_that.hasMore,_that.totalCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? nextCursor,  bool hasMore,  int? totalCount)  $default,) {final _that = this;
switch (_that) {
case _UserMemoriesMeta():
return $default(_that.nextCursor,_that.hasMore,_that.totalCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? nextCursor,  bool hasMore,  int? totalCount)?  $default,) {final _that = this;
switch (_that) {
case _UserMemoriesMeta() when $default != null:
return $default(_that.nextCursor,_that.hasMore,_that.totalCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserMemoriesMeta implements UserMemoriesMeta {
  const _UserMemoriesMeta({this.nextCursor, this.hasMore = false, this.totalCount});
  factory _UserMemoriesMeta.fromJson(Map<String, dynamic> json) => _$UserMemoriesMetaFromJson(json);

@override final  String? nextCursor;
@override@JsonKey() final  bool hasMore;
@override final  int? totalCount;

/// Create a copy of UserMemoriesMeta
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserMemoriesMetaCopyWith<_UserMemoriesMeta> get copyWith => __$UserMemoriesMetaCopyWithImpl<_UserMemoriesMeta>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserMemoriesMetaToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserMemoriesMeta&&(identical(other.nextCursor, nextCursor) || other.nextCursor == nextCursor)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.totalCount, totalCount) || other.totalCount == totalCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,nextCursor,hasMore,totalCount);
}

@override
String toString() {
    return 'UserMemoriesMeta(nextCursor: $nextCursor, hasMore: $hasMore, totalCount: $totalCount)';
}


}

/// @nodoc
abstract mixin class _$UserMemoriesMetaCopyWith<$Res> implements $UserMemoriesMetaCopyWith<$Res> {
  factory _$UserMemoriesMetaCopyWith(_UserMemoriesMeta value, $Res Function(_UserMemoriesMeta) _then) = __$UserMemoriesMetaCopyWithImpl;
@override @useResult
$Res call({
 String? nextCursor, bool hasMore, int? totalCount
});




}
/// @nodoc
class __$UserMemoriesMetaCopyWithImpl<$Res>
    implements _$UserMemoriesMetaCopyWith<$Res> {
  __$UserMemoriesMetaCopyWithImpl(this._self, this._then);

  final _UserMemoriesMeta _self;
  final $Res Function(_UserMemoriesMeta) _then;

/// Create a copy of UserMemoriesMeta
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? nextCursor = freezed,Object? hasMore = null,Object? totalCount = freezed,}) {
  return _then(_UserMemoriesMeta(
nextCursor: freezed == nextCursor ? _self.nextCursor : nextCursor // ignore: cast_nullable_to_non_nullable
as String?,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,totalCount: freezed == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$UserMemoryCollection {

 String get tripId; String get name; String get status; int get memoryCount;
/// Create a copy of UserMemoryCollection
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserMemoryCollectionCopyWith<UserMemoryCollection> get copyWith => _$UserMemoryCollectionCopyWithImpl<UserMemoryCollection>(this as UserMemoryCollection, _$identity);

  /// Serializes this UserMemoryCollection to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as UserMemoryCollection;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserMemoryCollection&&(identical(other.tripId, _this.tripId) || other.tripId == _this.tripId)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.memoryCount, _this.memoryCount) || other.memoryCount == _this.memoryCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as UserMemoryCollection;
  return Object.hash(runtimeType,_this.tripId,_this.name,_this.status,_this.memoryCount);
}

@override
String toString() {
  final _this = this as UserMemoryCollection;
  return 'UserMemoryCollection(tripId: ${_this.tripId}, name: ${_this.name}, status: ${_this.status}, memoryCount: ${_this.memoryCount})';
}


}

/// @nodoc
abstract mixin class $UserMemoryCollectionCopyWith<$Res>  {
  factory $UserMemoryCollectionCopyWith(UserMemoryCollection value, $Res Function(UserMemoryCollection) _then) = _$UserMemoryCollectionCopyWithImpl;
@useResult
$Res call({
 String tripId, String name, String status, int memoryCount
});




}
/// @nodoc
class _$UserMemoryCollectionCopyWithImpl<$Res>
    implements $UserMemoryCollectionCopyWith<$Res> {
  _$UserMemoryCollectionCopyWithImpl(this._self, this._then);

  final UserMemoryCollection _self;
  final $Res Function(UserMemoryCollection) _then;

/// Create a copy of UserMemoryCollection
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? tripId = null,Object? name = null,Object? status = null,Object? memoryCount = null,}) {
  return _then(UserMemoryCollection(
tripId: null == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,memoryCount: null == memoryCount ? _self.memoryCount : memoryCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [UserMemoryCollection].
extension UserMemoryCollectionPatterns on UserMemoryCollection {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserMemoryCollection value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserMemoryCollection() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserMemoryCollection value)  $default,){
final _that = this;
switch (_that) {
case _UserMemoryCollection():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserMemoryCollection value)?  $default,){
final _that = this;
switch (_that) {
case _UserMemoryCollection() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String tripId,  String name,  String status,  int memoryCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserMemoryCollection() when $default != null:
return $default(_that.tripId,_that.name,_that.status,_that.memoryCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String tripId,  String name,  String status,  int memoryCount)  $default,) {final _that = this;
switch (_that) {
case _UserMemoryCollection():
return $default(_that.tripId,_that.name,_that.status,_that.memoryCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String tripId,  String name,  String status,  int memoryCount)?  $default,) {final _that = this;
switch (_that) {
case _UserMemoryCollection() when $default != null:
return $default(_that.tripId,_that.name,_that.status,_that.memoryCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserMemoryCollection implements UserMemoryCollection {
  const _UserMemoryCollection({required this.tripId, required this.name, required this.status, required this.memoryCount});
  factory _UserMemoryCollection.fromJson(Map<String, dynamic> json) => _$UserMemoryCollectionFromJson(json);

@override final  String tripId;
@override final  String name;
@override final  String status;
@override final  int memoryCount;

/// Create a copy of UserMemoryCollection
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserMemoryCollectionCopyWith<_UserMemoryCollection> get copyWith => __$UserMemoryCollectionCopyWithImpl<_UserMemoryCollection>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserMemoryCollectionToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserMemoryCollection&&(identical(other.tripId, tripId) || other.tripId == tripId)&&(identical(other.name, name) || other.name == name)&&(identical(other.status, status) || other.status == status)&&(identical(other.memoryCount, memoryCount) || other.memoryCount == memoryCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,tripId,name,status,memoryCount);
}

@override
String toString() {
    return 'UserMemoryCollection(tripId: $tripId, name: $name, status: $status, memoryCount: $memoryCount)';
}


}

/// @nodoc
abstract mixin class _$UserMemoryCollectionCopyWith<$Res> implements $UserMemoryCollectionCopyWith<$Res> {
  factory _$UserMemoryCollectionCopyWith(_UserMemoryCollection value, $Res Function(_UserMemoryCollection) _then) = __$UserMemoryCollectionCopyWithImpl;
@override @useResult
$Res call({
 String tripId, String name, String status, int memoryCount
});




}
/// @nodoc
class __$UserMemoryCollectionCopyWithImpl<$Res>
    implements _$UserMemoryCollectionCopyWith<$Res> {
  __$UserMemoryCollectionCopyWithImpl(this._self, this._then);

  final _UserMemoryCollection _self;
  final $Res Function(_UserMemoryCollection) _then;

/// Create a copy of UserMemoryCollection
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? tripId = null,Object? name = null,Object? status = null,Object? memoryCount = null,}) {
  return _then(_UserMemoryCollection(
tripId: null == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,memoryCount: null == memoryCount ? _self.memoryCount : memoryCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$UserMemoryPhoto {

 String get id; String get tripId; String get tripName; String? get caption; DateTime get createdAt; String get imageUrl; String? get badge; int get likeCount; bool get liked;
/// Create a copy of UserMemoryPhoto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserMemoryPhotoCopyWith<UserMemoryPhoto> get copyWith => _$UserMemoryPhotoCopyWithImpl<UserMemoryPhoto>(this as UserMemoryPhoto, _$identity);

  /// Serializes this UserMemoryPhoto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as UserMemoryPhoto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserMemoryPhoto&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.tripId, _this.tripId) || other.tripId == _this.tripId)&&(identical(other.tripName, _this.tripName) || other.tripName == _this.tripName)&&(identical(other.caption, _this.caption) || other.caption == _this.caption)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.imageUrl, _this.imageUrl) || other.imageUrl == _this.imageUrl)&&(identical(other.badge, _this.badge) || other.badge == _this.badge)&&(identical(other.likeCount, _this.likeCount) || other.likeCount == _this.likeCount)&&(identical(other.liked, _this.liked) || other.liked == _this.liked));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as UserMemoryPhoto;
  return Object.hash(runtimeType,_this.id,_this.tripId,_this.tripName,_this.caption,_this.createdAt,_this.imageUrl,_this.badge,_this.likeCount,_this.liked);
}

@override
String toString() {
  final _this = this as UserMemoryPhoto;
  return 'UserMemoryPhoto(id: ${_this.id}, tripId: ${_this.tripId}, tripName: ${_this.tripName}, caption: ${_this.caption}, createdAt: ${_this.createdAt}, imageUrl: ${_this.imageUrl}, badge: ${_this.badge}, likeCount: ${_this.likeCount}, liked: ${_this.liked})';
}


}

/// @nodoc
abstract mixin class $UserMemoryPhotoCopyWith<$Res>  {
  factory $UserMemoryPhotoCopyWith(UserMemoryPhoto value, $Res Function(UserMemoryPhoto) _then) = _$UserMemoryPhotoCopyWithImpl;
@useResult
$Res call({
 String id, String tripId, String tripName, String? caption, DateTime createdAt, String imageUrl, String? badge, int likeCount, bool liked
});




}
/// @nodoc
class _$UserMemoryPhotoCopyWithImpl<$Res>
    implements $UserMemoryPhotoCopyWith<$Res> {
  _$UserMemoryPhotoCopyWithImpl(this._self, this._then);

  final UserMemoryPhoto _self;
  final $Res Function(UserMemoryPhoto) _then;

/// Create a copy of UserMemoryPhoto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? tripId = null,Object? tripName = null,Object? caption = freezed,Object? createdAt = null,Object? imageUrl = null,Object? badge = freezed,Object? likeCount = null,Object? liked = null,}) {
  return _then(UserMemoryPhoto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,tripId: null == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String,tripName: null == tripName ? _self.tripName : tripName // ignore: cast_nullable_to_non_nullable
as String,caption: freezed == caption ? _self.caption : caption // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,badge: freezed == badge ? _self.badge : badge // ignore: cast_nullable_to_non_nullable
as String?,likeCount: null == likeCount ? _self.likeCount : likeCount // ignore: cast_nullable_to_non_nullable
as int,liked: null == liked ? _self.liked : liked // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [UserMemoryPhoto].
extension UserMemoryPhotoPatterns on UserMemoryPhoto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserMemoryPhoto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserMemoryPhoto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserMemoryPhoto value)  $default,){
final _that = this;
switch (_that) {
case _UserMemoryPhoto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserMemoryPhoto value)?  $default,){
final _that = this;
switch (_that) {
case _UserMemoryPhoto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String tripId,  String tripName,  String? caption,  DateTime createdAt,  String imageUrl,  String? badge,  int likeCount,  bool liked)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserMemoryPhoto() when $default != null:
return $default(_that.id,_that.tripId,_that.tripName,_that.caption,_that.createdAt,_that.imageUrl,_that.badge,_that.likeCount,_that.liked);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String tripId,  String tripName,  String? caption,  DateTime createdAt,  String imageUrl,  String? badge,  int likeCount,  bool liked)  $default,) {final _that = this;
switch (_that) {
case _UserMemoryPhoto():
return $default(_that.id,_that.tripId,_that.tripName,_that.caption,_that.createdAt,_that.imageUrl,_that.badge,_that.likeCount,_that.liked);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String tripId,  String tripName,  String? caption,  DateTime createdAt,  String imageUrl,  String? badge,  int likeCount,  bool liked)?  $default,) {final _that = this;
switch (_that) {
case _UserMemoryPhoto() when $default != null:
return $default(_that.id,_that.tripId,_that.tripName,_that.caption,_that.createdAt,_that.imageUrl,_that.badge,_that.likeCount,_that.liked);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserMemoryPhoto implements UserMemoryPhoto {
  const _UserMemoryPhoto({required this.id, required this.tripId, required this.tripName, this.caption, required this.createdAt, required this.imageUrl, this.badge, required this.likeCount, this.liked = false});
  factory _UserMemoryPhoto.fromJson(Map<String, dynamic> json) => _$UserMemoryPhotoFromJson(json);

@override final  String id;
@override final  String tripId;
@override final  String tripName;
@override final  String? caption;
@override final  DateTime createdAt;
@override final  String imageUrl;
@override final  String? badge;
@override final  int likeCount;
@override@JsonKey() final  bool liked;

/// Create a copy of UserMemoryPhoto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserMemoryPhotoCopyWith<_UserMemoryPhoto> get copyWith => __$UserMemoryPhotoCopyWithImpl<_UserMemoryPhoto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserMemoryPhotoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserMemoryPhoto&&(identical(other.id, id) || other.id == id)&&(identical(other.tripId, tripId) || other.tripId == tripId)&&(identical(other.tripName, tripName) || other.tripName == tripName)&&(identical(other.caption, caption) || other.caption == caption)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.badge, badge) || other.badge == badge)&&(identical(other.likeCount, likeCount) || other.likeCount == likeCount)&&(identical(other.liked, liked) || other.liked == liked));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,tripId,tripName,caption,createdAt,imageUrl,badge,likeCount,liked);
}

@override
String toString() {
    return 'UserMemoryPhoto(id: $id, tripId: $tripId, tripName: $tripName, caption: $caption, createdAt: $createdAt, imageUrl: $imageUrl, badge: $badge, likeCount: $likeCount, liked: $liked)';
}


}

/// @nodoc
abstract mixin class _$UserMemoryPhotoCopyWith<$Res> implements $UserMemoryPhotoCopyWith<$Res> {
  factory _$UserMemoryPhotoCopyWith(_UserMemoryPhoto value, $Res Function(_UserMemoryPhoto) _then) = __$UserMemoryPhotoCopyWithImpl;
@override @useResult
$Res call({
 String id, String tripId, String tripName, String? caption, DateTime createdAt, String imageUrl, String? badge, int likeCount, bool liked
});




}
/// @nodoc
class __$UserMemoryPhotoCopyWithImpl<$Res>
    implements _$UserMemoryPhotoCopyWith<$Res> {
  __$UserMemoryPhotoCopyWithImpl(this._self, this._then);

  final _UserMemoryPhoto _self;
  final $Res Function(_UserMemoryPhoto) _then;

/// Create a copy of UserMemoryPhoto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? tripId = null,Object? tripName = null,Object? caption = freezed,Object? createdAt = null,Object? imageUrl = null,Object? badge = freezed,Object? likeCount = null,Object? liked = null,}) {
  return _then(_UserMemoryPhoto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,tripId: null == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String,tripName: null == tripName ? _self.tripName : tripName // ignore: cast_nullable_to_non_nullable
as String,caption: freezed == caption ? _self.caption : caption // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,badge: freezed == badge ? _self.badge : badge // ignore: cast_nullable_to_non_nullable
as String?,likeCount: null == likeCount ? _self.likeCount : likeCount // ignore: cast_nullable_to_non_nullable
as int,liked: null == liked ? _self.liked : liked // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$UserMemoryLike {

 int get likeCount; bool get liked;
/// Create a copy of UserMemoryLike
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserMemoryLikeCopyWith<UserMemoryLike> get copyWith => _$UserMemoryLikeCopyWithImpl<UserMemoryLike>(this as UserMemoryLike, _$identity);

  /// Serializes this UserMemoryLike to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as UserMemoryLike;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserMemoryLike&&(identical(other.likeCount, _this.likeCount) || other.likeCount == _this.likeCount)&&(identical(other.liked, _this.liked) || other.liked == _this.liked));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as UserMemoryLike;
  return Object.hash(runtimeType,_this.likeCount,_this.liked);
}

@override
String toString() {
  final _this = this as UserMemoryLike;
  return 'UserMemoryLike(likeCount: ${_this.likeCount}, liked: ${_this.liked})';
}


}

/// @nodoc
abstract mixin class $UserMemoryLikeCopyWith<$Res>  {
  factory $UserMemoryLikeCopyWith(UserMemoryLike value, $Res Function(UserMemoryLike) _then) = _$UserMemoryLikeCopyWithImpl;
@useResult
$Res call({
 int likeCount, bool liked
});




}
/// @nodoc
class _$UserMemoryLikeCopyWithImpl<$Res>
    implements $UserMemoryLikeCopyWith<$Res> {
  _$UserMemoryLikeCopyWithImpl(this._self, this._then);

  final UserMemoryLike _self;
  final $Res Function(UserMemoryLike) _then;

/// Create a copy of UserMemoryLike
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? likeCount = null,Object? liked = null,}) {
  return _then(UserMemoryLike(
likeCount: null == likeCount ? _self.likeCount : likeCount // ignore: cast_nullable_to_non_nullable
as int,liked: null == liked ? _self.liked : liked // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [UserMemoryLike].
extension UserMemoryLikePatterns on UserMemoryLike {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserMemoryLike value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserMemoryLike() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserMemoryLike value)  $default,){
final _that = this;
switch (_that) {
case _UserMemoryLike():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserMemoryLike value)?  $default,){
final _that = this;
switch (_that) {
case _UserMemoryLike() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int likeCount,  bool liked)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserMemoryLike() when $default != null:
return $default(_that.likeCount,_that.liked);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int likeCount,  bool liked)  $default,) {final _that = this;
switch (_that) {
case _UserMemoryLike():
return $default(_that.likeCount,_that.liked);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int likeCount,  bool liked)?  $default,) {final _that = this;
switch (_that) {
case _UserMemoryLike() when $default != null:
return $default(_that.likeCount,_that.liked);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserMemoryLike implements UserMemoryLike {
  const _UserMemoryLike({required this.likeCount, required this.liked});
  factory _UserMemoryLike.fromJson(Map<String, dynamic> json) => _$UserMemoryLikeFromJson(json);

@override final  int likeCount;
@override final  bool liked;

/// Create a copy of UserMemoryLike
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserMemoryLikeCopyWith<_UserMemoryLike> get copyWith => __$UserMemoryLikeCopyWithImpl<_UserMemoryLike>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserMemoryLikeToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserMemoryLike&&(identical(other.likeCount, likeCount) || other.likeCount == likeCount)&&(identical(other.liked, liked) || other.liked == liked));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,likeCount,liked);
}

@override
String toString() {
    return 'UserMemoryLike(likeCount: $likeCount, liked: $liked)';
}


}

/// @nodoc
abstract mixin class _$UserMemoryLikeCopyWith<$Res> implements $UserMemoryLikeCopyWith<$Res> {
  factory _$UserMemoryLikeCopyWith(_UserMemoryLike value, $Res Function(_UserMemoryLike) _then) = __$UserMemoryLikeCopyWithImpl;
@override @useResult
$Res call({
 int likeCount, bool liked
});




}
/// @nodoc
class __$UserMemoryLikeCopyWithImpl<$Res>
    implements _$UserMemoryLikeCopyWith<$Res> {
  __$UserMemoryLikeCopyWithImpl(this._self, this._then);

  final _UserMemoryLike _self;
  final $Res Function(_UserMemoryLike) _then;

/// Create a copy of UserMemoryLike
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? likeCount = null,Object? liked = null,}) {
  return _then(_UserMemoryLike(
likeCount: null == likeCount ? _self.likeCount : likeCount // ignore: cast_nullable_to_non_nullable
as int,liked: null == liked ? _self.liked : liked // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
