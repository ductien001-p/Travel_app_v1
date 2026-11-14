// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'trip_memory_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TripMemoriesPage {

@JsonKey(name: 'data') List<TripMemoryEntry> get items; TripMemoriesCursor get meta;
/// Create a copy of TripMemoriesPage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TripMemoriesPageCopyWith<TripMemoriesPage> get copyWith => _$TripMemoriesPageCopyWithImpl<TripMemoriesPage>(this as TripMemoriesPage, _$identity);

  /// Serializes this TripMemoriesPage to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TripMemoriesPage;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TripMemoriesPage&&const DeepCollectionEquality().equals(other.items, _this.items)&&(identical(other.meta, _this.meta) || other.meta == _this.meta));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TripMemoriesPage;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.items),_this.meta);
}

@override
String toString() {
  final _this = this as TripMemoriesPage;
  return 'TripMemoriesPage(items: ${_this.items}, meta: ${_this.meta})';
}


}

/// @nodoc
abstract mixin class $TripMemoriesPageCopyWith<$Res>  {
  factory $TripMemoriesPageCopyWith(TripMemoriesPage value, $Res Function(TripMemoriesPage) _then) = _$TripMemoriesPageCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'data') List<TripMemoryEntry> items, TripMemoriesCursor meta
});


$TripMemoriesCursorCopyWith<$Res> get meta;

}
/// @nodoc
class _$TripMemoriesPageCopyWithImpl<$Res>
    implements $TripMemoriesPageCopyWith<$Res> {
  _$TripMemoriesPageCopyWithImpl(this._self, this._then);

  final TripMemoriesPage _self;
  final $Res Function(TripMemoriesPage) _then;

/// Create a copy of TripMemoriesPage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,Object? meta = null,}) {
  return _then(TripMemoriesPage(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<TripMemoryEntry>,meta: null == meta ? _self.meta : meta // ignore: cast_nullable_to_non_nullable
as TripMemoriesCursor,
  ));
}
/// Create a copy of TripMemoriesPage
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TripMemoriesCursorCopyWith<$Res> get meta {
  
  return $TripMemoriesCursorCopyWith<$Res>(_self.meta, (value) {
    return _then(_self.copyWith(meta: value));
  });
}
}


/// Adds pattern-matching-related methods to [TripMemoriesPage].
extension TripMemoriesPagePatterns on TripMemoriesPage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TripMemoriesPage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TripMemoriesPage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TripMemoriesPage value)  $default,){
final _that = this;
switch (_that) {
case _TripMemoriesPage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TripMemoriesPage value)?  $default,){
final _that = this;
switch (_that) {
case _TripMemoriesPage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'data')  List<TripMemoryEntry> items,  TripMemoriesCursor meta)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TripMemoriesPage() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'data')  List<TripMemoryEntry> items,  TripMemoriesCursor meta)  $default,) {final _that = this;
switch (_that) {
case _TripMemoriesPage():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'data')  List<TripMemoryEntry> items,  TripMemoriesCursor meta)?  $default,) {final _that = this;
switch (_that) {
case _TripMemoriesPage() when $default != null:
return $default(_that.items,_that.meta);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TripMemoriesPage implements TripMemoriesPage {
  const _TripMemoriesPage({@JsonKey(name: 'data')  List<TripMemoryEntry> items = const <TripMemoryEntry>[], required this.meta}): _items = items;
  factory _TripMemoriesPage.fromJson(Map<String, dynamic> json) => _$TripMemoriesPageFromJson(json);

 final  List<TripMemoryEntry> _items;
@override@JsonKey(name: 'data') List<TripMemoryEntry> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override final  TripMemoriesCursor meta;

/// Create a copy of TripMemoriesPage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TripMemoriesPageCopyWith<_TripMemoriesPage> get copyWith => __$TripMemoriesPageCopyWithImpl<_TripMemoriesPage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TripMemoriesPageToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TripMemoriesPage&&const DeepCollectionEquality().equals(other.items, _items)&&(identical(other.meta, meta) || other.meta == meta));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),meta);
}

@override
String toString() {
    return 'TripMemoriesPage(items: $items, meta: $meta)';
}


}

/// @nodoc
abstract mixin class _$TripMemoriesPageCopyWith<$Res> implements $TripMemoriesPageCopyWith<$Res> {
  factory _$TripMemoriesPageCopyWith(_TripMemoriesPage value, $Res Function(_TripMemoriesPage) _then) = __$TripMemoriesPageCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'data') List<TripMemoryEntry> items, TripMemoriesCursor meta
});


@override $TripMemoriesCursorCopyWith<$Res> get meta;

}
/// @nodoc
class __$TripMemoriesPageCopyWithImpl<$Res>
    implements _$TripMemoriesPageCopyWith<$Res> {
  __$TripMemoriesPageCopyWithImpl(this._self, this._then);

  final _TripMemoriesPage _self;
  final $Res Function(_TripMemoriesPage) _then;

/// Create a copy of TripMemoriesPage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,Object? meta = null,}) {
  return _then(_TripMemoriesPage(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<TripMemoryEntry>,meta: null == meta ? _self.meta : meta // ignore: cast_nullable_to_non_nullable
as TripMemoriesCursor,
  ));
}

/// Create a copy of TripMemoriesPage
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TripMemoriesCursorCopyWith<$Res> get meta {
  
  return $TripMemoriesCursorCopyWith<$Res>(_self.meta, (value) {
    return _then(_self.copyWith(meta: value));
  });
}
}


/// @nodoc
mixin _$TripMemoriesCursor {

 String? get nextCursor; bool get hasMore;/// Memories of the whole trip matching the request filters; only sent
/// with the first page (no cursor).
 int? get totalCount;/// Memories per trip day (1-based, UTC) of the whole trip, ignoring the
/// `day` filter so every day chip keeps its count. Days without memories
/// are left out; only sent with the first page.
 List<TripMemoriesDayCount>? get dayCounts;
/// Create a copy of TripMemoriesCursor
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TripMemoriesCursorCopyWith<TripMemoriesCursor> get copyWith => _$TripMemoriesCursorCopyWithImpl<TripMemoriesCursor>(this as TripMemoriesCursor, _$identity);

  /// Serializes this TripMemoriesCursor to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TripMemoriesCursor;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TripMemoriesCursor&&(identical(other.nextCursor, _this.nextCursor) || other.nextCursor == _this.nextCursor)&&(identical(other.hasMore, _this.hasMore) || other.hasMore == _this.hasMore)&&(identical(other.totalCount, _this.totalCount) || other.totalCount == _this.totalCount)&&const DeepCollectionEquality().equals(other.dayCounts, _this.dayCounts));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TripMemoriesCursor;
  return Object.hash(runtimeType,_this.nextCursor,_this.hasMore,_this.totalCount,const DeepCollectionEquality().hash(_this.dayCounts));
}

@override
String toString() {
  final _this = this as TripMemoriesCursor;
  return 'TripMemoriesCursor(nextCursor: ${_this.nextCursor}, hasMore: ${_this.hasMore}, totalCount: ${_this.totalCount}, dayCounts: ${_this.dayCounts})';
}


}

/// @nodoc
abstract mixin class $TripMemoriesCursorCopyWith<$Res>  {
  factory $TripMemoriesCursorCopyWith(TripMemoriesCursor value, $Res Function(TripMemoriesCursor) _then) = _$TripMemoriesCursorCopyWithImpl;
@useResult
$Res call({
 String? nextCursor, bool hasMore, int? totalCount, List<TripMemoriesDayCount>? dayCounts
});




}
/// @nodoc
class _$TripMemoriesCursorCopyWithImpl<$Res>
    implements $TripMemoriesCursorCopyWith<$Res> {
  _$TripMemoriesCursorCopyWithImpl(this._self, this._then);

  final TripMemoriesCursor _self;
  final $Res Function(TripMemoriesCursor) _then;

/// Create a copy of TripMemoriesCursor
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? nextCursor = freezed,Object? hasMore = null,Object? totalCount = freezed,Object? dayCounts = freezed,}) {
  return _then(TripMemoriesCursor(
nextCursor: freezed == nextCursor ? _self.nextCursor : nextCursor // ignore: cast_nullable_to_non_nullable
as String?,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,totalCount: freezed == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int?,dayCounts: freezed == dayCounts ? _self.dayCounts : dayCounts // ignore: cast_nullable_to_non_nullable
as List<TripMemoriesDayCount>?,
  ));
}

}


/// Adds pattern-matching-related methods to [TripMemoriesCursor].
extension TripMemoriesCursorPatterns on TripMemoriesCursor {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TripMemoriesCursor value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TripMemoriesCursor() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TripMemoriesCursor value)  $default,){
final _that = this;
switch (_that) {
case _TripMemoriesCursor():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TripMemoriesCursor value)?  $default,){
final _that = this;
switch (_that) {
case _TripMemoriesCursor() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? nextCursor,  bool hasMore,  int? totalCount,  List<TripMemoriesDayCount>? dayCounts)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TripMemoriesCursor() when $default != null:
return $default(_that.nextCursor,_that.hasMore,_that.totalCount,_that.dayCounts);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? nextCursor,  bool hasMore,  int? totalCount,  List<TripMemoriesDayCount>? dayCounts)  $default,) {final _that = this;
switch (_that) {
case _TripMemoriesCursor():
return $default(_that.nextCursor,_that.hasMore,_that.totalCount,_that.dayCounts);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? nextCursor,  bool hasMore,  int? totalCount,  List<TripMemoriesDayCount>? dayCounts)?  $default,) {final _that = this;
switch (_that) {
case _TripMemoriesCursor() when $default != null:
return $default(_that.nextCursor,_that.hasMore,_that.totalCount,_that.dayCounts);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TripMemoriesCursor implements TripMemoriesCursor {
  const _TripMemoriesCursor({this.nextCursor, this.hasMore = false, this.totalCount,  List<TripMemoriesDayCount>? dayCounts}): _dayCounts = dayCounts;
  factory _TripMemoriesCursor.fromJson(Map<String, dynamic> json) => _$TripMemoriesCursorFromJson(json);

@override final  String? nextCursor;
@override@JsonKey() final  bool hasMore;
/// Memories of the whole trip matching the request filters; only sent
/// with the first page (no cursor).
@override final  int? totalCount;
/// Memories per trip day (1-based, UTC) of the whole trip, ignoring the
/// `day` filter so every day chip keeps its count. Days without memories
/// are left out; only sent with the first page.
 final  List<TripMemoriesDayCount>? _dayCounts;
/// Memories per trip day (1-based, UTC) of the whole trip, ignoring the
/// `day` filter so every day chip keeps its count. Days without memories
/// are left out; only sent with the first page.
@override List<TripMemoriesDayCount>? get dayCounts {
  final value = _dayCounts;
  if (value == null) return null;
  if (_dayCounts is EqualUnmodifiableListView) return _dayCounts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of TripMemoriesCursor
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TripMemoriesCursorCopyWith<_TripMemoriesCursor> get copyWith => __$TripMemoriesCursorCopyWithImpl<_TripMemoriesCursor>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TripMemoriesCursorToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TripMemoriesCursor&&(identical(other.nextCursor, nextCursor) || other.nextCursor == nextCursor)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.totalCount, totalCount) || other.totalCount == totalCount)&&const DeepCollectionEquality().equals(other.dayCounts, _dayCounts));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,nextCursor,hasMore,totalCount,const DeepCollectionEquality().hash(_dayCounts));
}

@override
String toString() {
    return 'TripMemoriesCursor(nextCursor: $nextCursor, hasMore: $hasMore, totalCount: $totalCount, dayCounts: $dayCounts)';
}


}

/// @nodoc
abstract mixin class _$TripMemoriesCursorCopyWith<$Res> implements $TripMemoriesCursorCopyWith<$Res> {
  factory _$TripMemoriesCursorCopyWith(_TripMemoriesCursor value, $Res Function(_TripMemoriesCursor) _then) = __$TripMemoriesCursorCopyWithImpl;
@override @useResult
$Res call({
 String? nextCursor, bool hasMore, int? totalCount, List<TripMemoriesDayCount>? dayCounts
});




}
/// @nodoc
class __$TripMemoriesCursorCopyWithImpl<$Res>
    implements _$TripMemoriesCursorCopyWith<$Res> {
  __$TripMemoriesCursorCopyWithImpl(this._self, this._then);

  final _TripMemoriesCursor _self;
  final $Res Function(_TripMemoriesCursor) _then;

/// Create a copy of TripMemoriesCursor
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? nextCursor = freezed,Object? hasMore = null,Object? totalCount = freezed,Object? dayCounts = freezed,}) {
  return _then(_TripMemoriesCursor(
nextCursor: freezed == nextCursor ? _self.nextCursor : nextCursor // ignore: cast_nullable_to_non_nullable
as String?,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,totalCount: freezed == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int?,dayCounts: freezed == dayCounts ? _self._dayCounts : dayCounts // ignore: cast_nullable_to_non_nullable
as List<TripMemoriesDayCount>?,
  ));
}


}


/// @nodoc
mixin _$TripMemoriesDayCount {

 int get day; int get count;
/// Create a copy of TripMemoriesDayCount
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TripMemoriesDayCountCopyWith<TripMemoriesDayCount> get copyWith => _$TripMemoriesDayCountCopyWithImpl<TripMemoriesDayCount>(this as TripMemoriesDayCount, _$identity);

  /// Serializes this TripMemoriesDayCount to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TripMemoriesDayCount;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TripMemoriesDayCount&&(identical(other.day, _this.day) || other.day == _this.day)&&(identical(other.count, _this.count) || other.count == _this.count));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TripMemoriesDayCount;
  return Object.hash(runtimeType,_this.day,_this.count);
}

@override
String toString() {
  final _this = this as TripMemoriesDayCount;
  return 'TripMemoriesDayCount(day: ${_this.day}, count: ${_this.count})';
}


}

/// @nodoc
abstract mixin class $TripMemoriesDayCountCopyWith<$Res>  {
  factory $TripMemoriesDayCountCopyWith(TripMemoriesDayCount value, $Res Function(TripMemoriesDayCount) _then) = _$TripMemoriesDayCountCopyWithImpl;
@useResult
$Res call({
 int day, int count
});




}
/// @nodoc
class _$TripMemoriesDayCountCopyWithImpl<$Res>
    implements $TripMemoriesDayCountCopyWith<$Res> {
  _$TripMemoriesDayCountCopyWithImpl(this._self, this._then);

  final TripMemoriesDayCount _self;
  final $Res Function(TripMemoriesDayCount) _then;

/// Create a copy of TripMemoriesDayCount
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? day = null,Object? count = null,}) {
  return _then(TripMemoriesDayCount(
day: null == day ? _self.day : day // ignore: cast_nullable_to_non_nullable
as int,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [TripMemoriesDayCount].
extension TripMemoriesDayCountPatterns on TripMemoriesDayCount {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TripMemoriesDayCount value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TripMemoriesDayCount() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TripMemoriesDayCount value)  $default,){
final _that = this;
switch (_that) {
case _TripMemoriesDayCount():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TripMemoriesDayCount value)?  $default,){
final _that = this;
switch (_that) {
case _TripMemoriesDayCount() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int day,  int count)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TripMemoriesDayCount() when $default != null:
return $default(_that.day,_that.count);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int day,  int count)  $default,) {final _that = this;
switch (_that) {
case _TripMemoriesDayCount():
return $default(_that.day,_that.count);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int day,  int count)?  $default,) {final _that = this;
switch (_that) {
case _TripMemoriesDayCount() when $default != null:
return $default(_that.day,_that.count);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TripMemoriesDayCount implements TripMemoriesDayCount {
  const _TripMemoriesDayCount({required this.day, required this.count});
  factory _TripMemoriesDayCount.fromJson(Map<String, dynamic> json) => _$TripMemoriesDayCountFromJson(json);

@override final  int day;
@override final  int count;

/// Create a copy of TripMemoriesDayCount
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TripMemoriesDayCountCopyWith<_TripMemoriesDayCount> get copyWith => __$TripMemoriesDayCountCopyWithImpl<_TripMemoriesDayCount>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TripMemoriesDayCountToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TripMemoriesDayCount&&(identical(other.day, day) || other.day == day)&&(identical(other.count, count) || other.count == count));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,day,count);
}

@override
String toString() {
    return 'TripMemoriesDayCount(day: $day, count: $count)';
}


}

/// @nodoc
abstract mixin class _$TripMemoriesDayCountCopyWith<$Res> implements $TripMemoriesDayCountCopyWith<$Res> {
  factory _$TripMemoriesDayCountCopyWith(_TripMemoriesDayCount value, $Res Function(_TripMemoriesDayCount) _then) = __$TripMemoriesDayCountCopyWithImpl;
@override @useResult
$Res call({
 int day, int count
});




}
/// @nodoc
class __$TripMemoriesDayCountCopyWithImpl<$Res>
    implements _$TripMemoriesDayCountCopyWith<$Res> {
  __$TripMemoriesDayCountCopyWithImpl(this._self, this._then);

  final _TripMemoriesDayCount _self;
  final $Res Function(_TripMemoriesDayCount) _then;

/// Create a copy of TripMemoriesDayCount
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? day = null,Object? count = null,}) {
  return _then(_TripMemoriesDayCount(
day: null == day ? _self.day : day // ignore: cast_nullable_to_non_nullable
as int,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$TripMemoryEntry {

 String get id; String get tripId; String? get caption; DateTime get createdAt; String get imageUrl;/// Null when the uploader deleted their account.
 TripMemoryUploader? get user; TripMemoryAsset get media;/// Label the backend suggests from the photo content ("Khoảnh khắc đêm",
/// "Khoảnh khắc nổi bật"...); null while unclassified or when none fits.
 String? get badge;
/// Create a copy of TripMemoryEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TripMemoryEntryCopyWith<TripMemoryEntry> get copyWith => _$TripMemoryEntryCopyWithImpl<TripMemoryEntry>(this as TripMemoryEntry, _$identity);

  /// Serializes this TripMemoryEntry to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TripMemoryEntry;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TripMemoryEntry&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.tripId, _this.tripId) || other.tripId == _this.tripId)&&(identical(other.caption, _this.caption) || other.caption == _this.caption)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.imageUrl, _this.imageUrl) || other.imageUrl == _this.imageUrl)&&(identical(other.user, _this.user) || other.user == _this.user)&&(identical(other.media, _this.media) || other.media == _this.media)&&(identical(other.badge, _this.badge) || other.badge == _this.badge));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TripMemoryEntry;
  return Object.hash(runtimeType,_this.id,_this.tripId,_this.caption,_this.createdAt,_this.imageUrl,_this.user,_this.media,_this.badge);
}

@override
String toString() {
  final _this = this as TripMemoryEntry;
  return 'TripMemoryEntry(id: ${_this.id}, tripId: ${_this.tripId}, caption: ${_this.caption}, createdAt: ${_this.createdAt}, imageUrl: ${_this.imageUrl}, user: ${_this.user}, media: ${_this.media}, badge: ${_this.badge})';
}


}

/// @nodoc
abstract mixin class $TripMemoryEntryCopyWith<$Res>  {
  factory $TripMemoryEntryCopyWith(TripMemoryEntry value, $Res Function(TripMemoryEntry) _then) = _$TripMemoryEntryCopyWithImpl;
@useResult
$Res call({
 String id, String tripId, String? caption, DateTime createdAt, String imageUrl, TripMemoryUploader? user, TripMemoryAsset media, String? badge
});


$TripMemoryUploaderCopyWith<$Res>? get user;$TripMemoryAssetCopyWith<$Res> get media;

}
/// @nodoc
class _$TripMemoryEntryCopyWithImpl<$Res>
    implements $TripMemoryEntryCopyWith<$Res> {
  _$TripMemoryEntryCopyWithImpl(this._self, this._then);

  final TripMemoryEntry _self;
  final $Res Function(TripMemoryEntry) _then;

/// Create a copy of TripMemoryEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? tripId = null,Object? caption = freezed,Object? createdAt = null,Object? imageUrl = null,Object? user = freezed,Object? media = null,Object? badge = freezed,}) {
  return _then(TripMemoryEntry(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,tripId: null == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String,caption: freezed == caption ? _self.caption : caption // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,user: freezed == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as TripMemoryUploader?,media: null == media ? _self.media : media // ignore: cast_nullable_to_non_nullable
as TripMemoryAsset,badge: freezed == badge ? _self.badge : badge // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of TripMemoryEntry
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TripMemoryUploaderCopyWith<$Res>? get user {
    if (_self.user == null) {
    return null;
  }

  return $TripMemoryUploaderCopyWith<$Res>(_self.user!, (value) {
    return _then(_self.copyWith(user: value));
  });
}/// Create a copy of TripMemoryEntry
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TripMemoryAssetCopyWith<$Res> get media {
  
  return $TripMemoryAssetCopyWith<$Res>(_self.media, (value) {
    return _then(_self.copyWith(media: value));
  });
}
}


/// Adds pattern-matching-related methods to [TripMemoryEntry].
extension TripMemoryEntryPatterns on TripMemoryEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TripMemoryEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TripMemoryEntry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TripMemoryEntry value)  $default,){
final _that = this;
switch (_that) {
case _TripMemoryEntry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TripMemoryEntry value)?  $default,){
final _that = this;
switch (_that) {
case _TripMemoryEntry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String tripId,  String? caption,  DateTime createdAt,  String imageUrl,  TripMemoryUploader? user,  TripMemoryAsset media,  String? badge)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TripMemoryEntry() when $default != null:
return $default(_that.id,_that.tripId,_that.caption,_that.createdAt,_that.imageUrl,_that.user,_that.media,_that.badge);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String tripId,  String? caption,  DateTime createdAt,  String imageUrl,  TripMemoryUploader? user,  TripMemoryAsset media,  String? badge)  $default,) {final _that = this;
switch (_that) {
case _TripMemoryEntry():
return $default(_that.id,_that.tripId,_that.caption,_that.createdAt,_that.imageUrl,_that.user,_that.media,_that.badge);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String tripId,  String? caption,  DateTime createdAt,  String imageUrl,  TripMemoryUploader? user,  TripMemoryAsset media,  String? badge)?  $default,) {final _that = this;
switch (_that) {
case _TripMemoryEntry() when $default != null:
return $default(_that.id,_that.tripId,_that.caption,_that.createdAt,_that.imageUrl,_that.user,_that.media,_that.badge);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TripMemoryEntry implements TripMemoryEntry {
  const _TripMemoryEntry({required this.id, required this.tripId, this.caption, required this.createdAt, required this.imageUrl, this.user, required this.media, this.badge});
  factory _TripMemoryEntry.fromJson(Map<String, dynamic> json) => _$TripMemoryEntryFromJson(json);

@override final  String id;
@override final  String tripId;
@override final  String? caption;
@override final  DateTime createdAt;
@override final  String imageUrl;
/// Null when the uploader deleted their account.
@override final  TripMemoryUploader? user;
@override final  TripMemoryAsset media;
/// Label the backend suggests from the photo content ("Khoảnh khắc đêm",
/// "Khoảnh khắc nổi bật"...); null while unclassified or when none fits.
@override final  String? badge;

/// Create a copy of TripMemoryEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TripMemoryEntryCopyWith<_TripMemoryEntry> get copyWith => __$TripMemoryEntryCopyWithImpl<_TripMemoryEntry>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TripMemoryEntryToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TripMemoryEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.tripId, tripId) || other.tripId == tripId)&&(identical(other.caption, caption) || other.caption == caption)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.user, user) || other.user == user)&&(identical(other.media, media) || other.media == media)&&(identical(other.badge, badge) || other.badge == badge));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,tripId,caption,createdAt,imageUrl,user,media,badge);
}

@override
String toString() {
    return 'TripMemoryEntry(id: $id, tripId: $tripId, caption: $caption, createdAt: $createdAt, imageUrl: $imageUrl, user: $user, media: $media, badge: $badge)';
}


}

/// @nodoc
abstract mixin class _$TripMemoryEntryCopyWith<$Res> implements $TripMemoryEntryCopyWith<$Res> {
  factory _$TripMemoryEntryCopyWith(_TripMemoryEntry value, $Res Function(_TripMemoryEntry) _then) = __$TripMemoryEntryCopyWithImpl;
@override @useResult
$Res call({
 String id, String tripId, String? caption, DateTime createdAt, String imageUrl, TripMemoryUploader? user, TripMemoryAsset media, String? badge
});


@override $TripMemoryUploaderCopyWith<$Res>? get user;@override $TripMemoryAssetCopyWith<$Res> get media;

}
/// @nodoc
class __$TripMemoryEntryCopyWithImpl<$Res>
    implements _$TripMemoryEntryCopyWith<$Res> {
  __$TripMemoryEntryCopyWithImpl(this._self, this._then);

  final _TripMemoryEntry _self;
  final $Res Function(_TripMemoryEntry) _then;

/// Create a copy of TripMemoryEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? tripId = null,Object? caption = freezed,Object? createdAt = null,Object? imageUrl = null,Object? user = freezed,Object? media = null,Object? badge = freezed,}) {
  return _then(_TripMemoryEntry(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,tripId: null == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String,caption: freezed == caption ? _self.caption : caption // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,user: freezed == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as TripMemoryUploader?,media: null == media ? _self.media : media // ignore: cast_nullable_to_non_nullable
as TripMemoryAsset,badge: freezed == badge ? _self.badge : badge // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of TripMemoryEntry
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TripMemoryUploaderCopyWith<$Res>? get user {
    if (_self.user == null) {
    return null;
  }

  return $TripMemoryUploaderCopyWith<$Res>(_self.user!, (value) {
    return _then(_self.copyWith(user: value));
  });
}/// Create a copy of TripMemoryEntry
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TripMemoryAssetCopyWith<$Res> get media {
  
  return $TripMemoryAssetCopyWith<$Res>(_self.media, (value) {
    return _then(_self.copyWith(media: value));
  });
}
}


/// @nodoc
mixin _$TripMemoryUploader {

 String get id; String get username; String? get avatarId;
/// Create a copy of TripMemoryUploader
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TripMemoryUploaderCopyWith<TripMemoryUploader> get copyWith => _$TripMemoryUploaderCopyWithImpl<TripMemoryUploader>(this as TripMemoryUploader, _$identity);

  /// Serializes this TripMemoryUploader to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TripMemoryUploader;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TripMemoryUploader&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.username, _this.username) || other.username == _this.username)&&(identical(other.avatarId, _this.avatarId) || other.avatarId == _this.avatarId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TripMemoryUploader;
  return Object.hash(runtimeType,_this.id,_this.username,_this.avatarId);
}

@override
String toString() {
  final _this = this as TripMemoryUploader;
  return 'TripMemoryUploader(id: ${_this.id}, username: ${_this.username}, avatarId: ${_this.avatarId})';
}


}

/// @nodoc
abstract mixin class $TripMemoryUploaderCopyWith<$Res>  {
  factory $TripMemoryUploaderCopyWith(TripMemoryUploader value, $Res Function(TripMemoryUploader) _then) = _$TripMemoryUploaderCopyWithImpl;
@useResult
$Res call({
 String id, String username, String? avatarId
});




}
/// @nodoc
class _$TripMemoryUploaderCopyWithImpl<$Res>
    implements $TripMemoryUploaderCopyWith<$Res> {
  _$TripMemoryUploaderCopyWithImpl(this._self, this._then);

  final TripMemoryUploader _self;
  final $Res Function(TripMemoryUploader) _then;

/// Create a copy of TripMemoryUploader
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? username = null,Object? avatarId = freezed,}) {
  return _then(TripMemoryUploader(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,avatarId: freezed == avatarId ? _self.avatarId : avatarId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TripMemoryUploader].
extension TripMemoryUploaderPatterns on TripMemoryUploader {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TripMemoryUploader value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TripMemoryUploader() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TripMemoryUploader value)  $default,){
final _that = this;
switch (_that) {
case _TripMemoryUploader():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TripMemoryUploader value)?  $default,){
final _that = this;
switch (_that) {
case _TripMemoryUploader() when $default != null:
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
case _TripMemoryUploader() when $default != null:
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
case _TripMemoryUploader():
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
case _TripMemoryUploader() when $default != null:
return $default(_that.id,_that.username,_that.avatarId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TripMemoryUploader implements TripMemoryUploader {
  const _TripMemoryUploader({required this.id, required this.username, this.avatarId});
  factory _TripMemoryUploader.fromJson(Map<String, dynamic> json) => _$TripMemoryUploaderFromJson(json);

@override final  String id;
@override final  String username;
@override final  String? avatarId;

/// Create a copy of TripMemoryUploader
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TripMemoryUploaderCopyWith<_TripMemoryUploader> get copyWith => __$TripMemoryUploaderCopyWithImpl<_TripMemoryUploader>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TripMemoryUploaderToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TripMemoryUploader&&(identical(other.id, id) || other.id == id)&&(identical(other.username, username) || other.username == username)&&(identical(other.avatarId, avatarId) || other.avatarId == avatarId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,username,avatarId);
}

@override
String toString() {
    return 'TripMemoryUploader(id: $id, username: $username, avatarId: $avatarId)';
}


}

/// @nodoc
abstract mixin class _$TripMemoryUploaderCopyWith<$Res> implements $TripMemoryUploaderCopyWith<$Res> {
  factory _$TripMemoryUploaderCopyWith(_TripMemoryUploader value, $Res Function(_TripMemoryUploader) _then) = __$TripMemoryUploaderCopyWithImpl;
@override @useResult
$Res call({
 String id, String username, String? avatarId
});




}
/// @nodoc
class __$TripMemoryUploaderCopyWithImpl<$Res>
    implements _$TripMemoryUploaderCopyWith<$Res> {
  __$TripMemoryUploaderCopyWithImpl(this._self, this._then);

  final _TripMemoryUploader _self;
  final $Res Function(_TripMemoryUploader) _then;

/// Create a copy of TripMemoryUploader
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? username = null,Object? avatarId = freezed,}) {
  return _then(_TripMemoryUploader(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,avatarId: freezed == avatarId ? _self.avatarId : avatarId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$TripMemoryAsset {

 String get id; String get mimeType; int? get width; int? get height;
/// Create a copy of TripMemoryAsset
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TripMemoryAssetCopyWith<TripMemoryAsset> get copyWith => _$TripMemoryAssetCopyWithImpl<TripMemoryAsset>(this as TripMemoryAsset, _$identity);

  /// Serializes this TripMemoryAsset to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TripMemoryAsset;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TripMemoryAsset&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.mimeType, _this.mimeType) || other.mimeType == _this.mimeType)&&(identical(other.width, _this.width) || other.width == _this.width)&&(identical(other.height, _this.height) || other.height == _this.height));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TripMemoryAsset;
  return Object.hash(runtimeType,_this.id,_this.mimeType,_this.width,_this.height);
}

@override
String toString() {
  final _this = this as TripMemoryAsset;
  return 'TripMemoryAsset(id: ${_this.id}, mimeType: ${_this.mimeType}, width: ${_this.width}, height: ${_this.height})';
}


}

/// @nodoc
abstract mixin class $TripMemoryAssetCopyWith<$Res>  {
  factory $TripMemoryAssetCopyWith(TripMemoryAsset value, $Res Function(TripMemoryAsset) _then) = _$TripMemoryAssetCopyWithImpl;
@useResult
$Res call({
 String id, String mimeType, int? width, int? height
});




}
/// @nodoc
class _$TripMemoryAssetCopyWithImpl<$Res>
    implements $TripMemoryAssetCopyWith<$Res> {
  _$TripMemoryAssetCopyWithImpl(this._self, this._then);

  final TripMemoryAsset _self;
  final $Res Function(TripMemoryAsset) _then;

/// Create a copy of TripMemoryAsset
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? mimeType = null,Object? width = freezed,Object? height = freezed,}) {
  return _then(TripMemoryAsset(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,mimeType: null == mimeType ? _self.mimeType : mimeType // ignore: cast_nullable_to_non_nullable
as String,width: freezed == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as int?,height: freezed == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [TripMemoryAsset].
extension TripMemoryAssetPatterns on TripMemoryAsset {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TripMemoryAsset value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TripMemoryAsset() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TripMemoryAsset value)  $default,){
final _that = this;
switch (_that) {
case _TripMemoryAsset():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TripMemoryAsset value)?  $default,){
final _that = this;
switch (_that) {
case _TripMemoryAsset() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String mimeType,  int? width,  int? height)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TripMemoryAsset() when $default != null:
return $default(_that.id,_that.mimeType,_that.width,_that.height);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String mimeType,  int? width,  int? height)  $default,) {final _that = this;
switch (_that) {
case _TripMemoryAsset():
return $default(_that.id,_that.mimeType,_that.width,_that.height);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String mimeType,  int? width,  int? height)?  $default,) {final _that = this;
switch (_that) {
case _TripMemoryAsset() when $default != null:
return $default(_that.id,_that.mimeType,_that.width,_that.height);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TripMemoryAsset implements TripMemoryAsset {
  const _TripMemoryAsset({required this.id, this.mimeType = 'application/octet-stream', this.width, this.height});
  factory _TripMemoryAsset.fromJson(Map<String, dynamic> json) => _$TripMemoryAssetFromJson(json);

@override final  String id;
@override@JsonKey() final  String mimeType;
@override final  int? width;
@override final  int? height;

/// Create a copy of TripMemoryAsset
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TripMemoryAssetCopyWith<_TripMemoryAsset> get copyWith => __$TripMemoryAssetCopyWithImpl<_TripMemoryAsset>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TripMemoryAssetToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TripMemoryAsset&&(identical(other.id, id) || other.id == id)&&(identical(other.mimeType, mimeType) || other.mimeType == mimeType)&&(identical(other.width, width) || other.width == width)&&(identical(other.height, height) || other.height == height));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,mimeType,width,height);
}

@override
String toString() {
    return 'TripMemoryAsset(id: $id, mimeType: $mimeType, width: $width, height: $height)';
}


}

/// @nodoc
abstract mixin class _$TripMemoryAssetCopyWith<$Res> implements $TripMemoryAssetCopyWith<$Res> {
  factory _$TripMemoryAssetCopyWith(_TripMemoryAsset value, $Res Function(_TripMemoryAsset) _then) = __$TripMemoryAssetCopyWithImpl;
@override @useResult
$Res call({
 String id, String mimeType, int? width, int? height
});




}
/// @nodoc
class __$TripMemoryAssetCopyWithImpl<$Res>
    implements _$TripMemoryAssetCopyWith<$Res> {
  __$TripMemoryAssetCopyWithImpl(this._self, this._then);

  final _TripMemoryAsset _self;
  final $Res Function(_TripMemoryAsset) _then;

/// Create a copy of TripMemoryAsset
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? mimeType = null,Object? width = freezed,Object? height = freezed,}) {
  return _then(_TripMemoryAsset(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,mimeType: null == mimeType ? _self.mimeType : mimeType // ignore: cast_nullable_to_non_nullable
as String,width: freezed == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as int?,height: freezed == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$NewTripMemory {

 String get mediaId;@JsonKey(includeIfNull: false) String? get caption;
/// Create a copy of NewTripMemory
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NewTripMemoryCopyWith<NewTripMemory> get copyWith => _$NewTripMemoryCopyWithImpl<NewTripMemory>(this as NewTripMemory, _$identity);

  /// Serializes this NewTripMemory to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as NewTripMemory;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NewTripMemory&&(identical(other.mediaId, _this.mediaId) || other.mediaId == _this.mediaId)&&(identical(other.caption, _this.caption) || other.caption == _this.caption));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as NewTripMemory;
  return Object.hash(runtimeType,_this.mediaId,_this.caption);
}

@override
String toString() {
  final _this = this as NewTripMemory;
  return 'NewTripMemory(mediaId: ${_this.mediaId}, caption: ${_this.caption})';
}


}

/// @nodoc
abstract mixin class $NewTripMemoryCopyWith<$Res>  {
  factory $NewTripMemoryCopyWith(NewTripMemory value, $Res Function(NewTripMemory) _then) = _$NewTripMemoryCopyWithImpl;
@useResult
$Res call({
 String mediaId,@JsonKey(includeIfNull: false) String? caption
});




}
/// @nodoc
class _$NewTripMemoryCopyWithImpl<$Res>
    implements $NewTripMemoryCopyWith<$Res> {
  _$NewTripMemoryCopyWithImpl(this._self, this._then);

  final NewTripMemory _self;
  final $Res Function(NewTripMemory) _then;

/// Create a copy of NewTripMemory
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? mediaId = null,Object? caption = freezed,}) {
  return _then(NewTripMemory(
mediaId: null == mediaId ? _self.mediaId : mediaId // ignore: cast_nullable_to_non_nullable
as String,caption: freezed == caption ? _self.caption : caption // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [NewTripMemory].
extension NewTripMemoryPatterns on NewTripMemory {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NewTripMemory value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NewTripMemory() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NewTripMemory value)  $default,){
final _that = this;
switch (_that) {
case _NewTripMemory():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NewTripMemory value)?  $default,){
final _that = this;
switch (_that) {
case _NewTripMemory() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String mediaId, @JsonKey(includeIfNull: false)  String? caption)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NewTripMemory() when $default != null:
return $default(_that.mediaId,_that.caption);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String mediaId, @JsonKey(includeIfNull: false)  String? caption)  $default,) {final _that = this;
switch (_that) {
case _NewTripMemory():
return $default(_that.mediaId,_that.caption);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String mediaId, @JsonKey(includeIfNull: false)  String? caption)?  $default,) {final _that = this;
switch (_that) {
case _NewTripMemory() when $default != null:
return $default(_that.mediaId,_that.caption);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NewTripMemory implements NewTripMemory {
  const _NewTripMemory({required this.mediaId, @JsonKey(includeIfNull: false) this.caption});
  factory _NewTripMemory.fromJson(Map<String, dynamic> json) => _$NewTripMemoryFromJson(json);

@override final  String mediaId;
@override@JsonKey(includeIfNull: false) final  String? caption;

/// Create a copy of NewTripMemory
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NewTripMemoryCopyWith<_NewTripMemory> get copyWith => __$NewTripMemoryCopyWithImpl<_NewTripMemory>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NewTripMemoryToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _NewTripMemory&&(identical(other.mediaId, mediaId) || other.mediaId == mediaId)&&(identical(other.caption, caption) || other.caption == caption));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,mediaId,caption);
}

@override
String toString() {
    return 'NewTripMemory(mediaId: $mediaId, caption: $caption)';
}


}

/// @nodoc
abstract mixin class _$NewTripMemoryCopyWith<$Res> implements $NewTripMemoryCopyWith<$Res> {
  factory _$NewTripMemoryCopyWith(_NewTripMemory value, $Res Function(_NewTripMemory) _then) = __$NewTripMemoryCopyWithImpl;
@override @useResult
$Res call({
 String mediaId,@JsonKey(includeIfNull: false) String? caption
});




}
/// @nodoc
class __$NewTripMemoryCopyWithImpl<$Res>
    implements _$NewTripMemoryCopyWith<$Res> {
  __$NewTripMemoryCopyWithImpl(this._self, this._then);

  final _NewTripMemory _self;
  final $Res Function(_NewTripMemory) _then;

/// Create a copy of NewTripMemory
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? mediaId = null,Object? caption = freezed,}) {
  return _then(_NewTripMemory(
mediaId: null == mediaId ? _self.mediaId : mediaId // ignore: cast_nullable_to_non_nullable
as String,caption: freezed == caption ? _self.caption : caption // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
