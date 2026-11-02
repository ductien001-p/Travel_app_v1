// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'trip_timeline_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TripTimelinePage {

@JsonKey(name: 'data') List<TripTimelineEntry> get items; TripTimelineCursor get meta;
/// Create a copy of TripTimelinePage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TripTimelinePageCopyWith<TripTimelinePage> get copyWith => _$TripTimelinePageCopyWithImpl<TripTimelinePage>(this as TripTimelinePage, _$identity);

  /// Serializes this TripTimelinePage to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TripTimelinePage;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TripTimelinePage&&const DeepCollectionEquality().equals(other.items, _this.items)&&(identical(other.meta, _this.meta) || other.meta == _this.meta));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TripTimelinePage;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.items),_this.meta);
}

@override
String toString() {
  final _this = this as TripTimelinePage;
  return 'TripTimelinePage(items: ${_this.items}, meta: ${_this.meta})';
}


}

/// @nodoc
abstract mixin class $TripTimelinePageCopyWith<$Res>  {
  factory $TripTimelinePageCopyWith(TripTimelinePage value, $Res Function(TripTimelinePage) _then) = _$TripTimelinePageCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'data') List<TripTimelineEntry> items, TripTimelineCursor meta
});


$TripTimelineCursorCopyWith<$Res> get meta;

}
/// @nodoc
class _$TripTimelinePageCopyWithImpl<$Res>
    implements $TripTimelinePageCopyWith<$Res> {
  _$TripTimelinePageCopyWithImpl(this._self, this._then);

  final TripTimelinePage _self;
  final $Res Function(TripTimelinePage) _then;

/// Create a copy of TripTimelinePage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,Object? meta = null,}) {
  return _then(TripTimelinePage(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<TripTimelineEntry>,meta: null == meta ? _self.meta : meta // ignore: cast_nullable_to_non_nullable
as TripTimelineCursor,
  ));
}
/// Create a copy of TripTimelinePage
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TripTimelineCursorCopyWith<$Res> get meta {
  
  return $TripTimelineCursorCopyWith<$Res>(_self.meta, (value) {
    return _then(_self.copyWith(meta: value));
  });
}
}


/// Adds pattern-matching-related methods to [TripTimelinePage].
extension TripTimelinePagePatterns on TripTimelinePage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TripTimelinePage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TripTimelinePage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TripTimelinePage value)  $default,){
final _that = this;
switch (_that) {
case _TripTimelinePage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TripTimelinePage value)?  $default,){
final _that = this;
switch (_that) {
case _TripTimelinePage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'data')  List<TripTimelineEntry> items,  TripTimelineCursor meta)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TripTimelinePage() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'data')  List<TripTimelineEntry> items,  TripTimelineCursor meta)  $default,) {final _that = this;
switch (_that) {
case _TripTimelinePage():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'data')  List<TripTimelineEntry> items,  TripTimelineCursor meta)?  $default,) {final _that = this;
switch (_that) {
case _TripTimelinePage() when $default != null:
return $default(_that.items,_that.meta);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TripTimelinePage implements TripTimelinePage {
  const _TripTimelinePage({@JsonKey(name: 'data')  List<TripTimelineEntry> items = const <TripTimelineEntry>[], required this.meta}): _items = items;
  factory _TripTimelinePage.fromJson(Map<String, dynamic> json) => _$TripTimelinePageFromJson(json);

 final  List<TripTimelineEntry> _items;
@override@JsonKey(name: 'data') List<TripTimelineEntry> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override final  TripTimelineCursor meta;

/// Create a copy of TripTimelinePage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TripTimelinePageCopyWith<_TripTimelinePage> get copyWith => __$TripTimelinePageCopyWithImpl<_TripTimelinePage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TripTimelinePageToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TripTimelinePage&&const DeepCollectionEquality().equals(other.items, _items)&&(identical(other.meta, meta) || other.meta == meta));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),meta);
}

@override
String toString() {
    return 'TripTimelinePage(items: $items, meta: $meta)';
}


}

/// @nodoc
abstract mixin class _$TripTimelinePageCopyWith<$Res> implements $TripTimelinePageCopyWith<$Res> {
  factory _$TripTimelinePageCopyWith(_TripTimelinePage value, $Res Function(_TripTimelinePage) _then) = __$TripTimelinePageCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'data') List<TripTimelineEntry> items, TripTimelineCursor meta
});


@override $TripTimelineCursorCopyWith<$Res> get meta;

}
/// @nodoc
class __$TripTimelinePageCopyWithImpl<$Res>
    implements _$TripTimelinePageCopyWith<$Res> {
  __$TripTimelinePageCopyWithImpl(this._self, this._then);

  final _TripTimelinePage _self;
  final $Res Function(_TripTimelinePage) _then;

/// Create a copy of TripTimelinePage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,Object? meta = null,}) {
  return _then(_TripTimelinePage(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<TripTimelineEntry>,meta: null == meta ? _self.meta : meta // ignore: cast_nullable_to_non_nullable
as TripTimelineCursor,
  ));
}

/// Create a copy of TripTimelinePage
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TripTimelineCursorCopyWith<$Res> get meta {
  
  return $TripTimelineCursorCopyWith<$Res>(_self.meta, (value) {
    return _then(_self.copyWith(meta: value));
  });
}
}


/// @nodoc
mixin _$TripTimelineCursor {

 String? get nextCursor; bool get hasMore;/// Totals of the whole trip per filter chip; only sent with the first page.
 TripTimelineCounts? get counts;
/// Create a copy of TripTimelineCursor
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TripTimelineCursorCopyWith<TripTimelineCursor> get copyWith => _$TripTimelineCursorCopyWithImpl<TripTimelineCursor>(this as TripTimelineCursor, _$identity);

  /// Serializes this TripTimelineCursor to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TripTimelineCursor;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TripTimelineCursor&&(identical(other.nextCursor, _this.nextCursor) || other.nextCursor == _this.nextCursor)&&(identical(other.hasMore, _this.hasMore) || other.hasMore == _this.hasMore)&&(identical(other.counts, _this.counts) || other.counts == _this.counts));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TripTimelineCursor;
  return Object.hash(runtimeType,_this.nextCursor,_this.hasMore,_this.counts);
}

@override
String toString() {
  final _this = this as TripTimelineCursor;
  return 'TripTimelineCursor(nextCursor: ${_this.nextCursor}, hasMore: ${_this.hasMore}, counts: ${_this.counts})';
}


}

/// @nodoc
abstract mixin class $TripTimelineCursorCopyWith<$Res>  {
  factory $TripTimelineCursorCopyWith(TripTimelineCursor value, $Res Function(TripTimelineCursor) _then) = _$TripTimelineCursorCopyWithImpl;
@useResult
$Res call({
 String? nextCursor, bool hasMore, TripTimelineCounts? counts
});


$TripTimelineCountsCopyWith<$Res>? get counts;

}
/// @nodoc
class _$TripTimelineCursorCopyWithImpl<$Res>
    implements $TripTimelineCursorCopyWith<$Res> {
  _$TripTimelineCursorCopyWithImpl(this._self, this._then);

  final TripTimelineCursor _self;
  final $Res Function(TripTimelineCursor) _then;

/// Create a copy of TripTimelineCursor
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? nextCursor = freezed,Object? hasMore = null,Object? counts = freezed,}) {
  return _then(TripTimelineCursor(
nextCursor: freezed == nextCursor ? _self.nextCursor : nextCursor // ignore: cast_nullable_to_non_nullable
as String?,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,counts: freezed == counts ? _self.counts : counts // ignore: cast_nullable_to_non_nullable
as TripTimelineCounts?,
  ));
}
/// Create a copy of TripTimelineCursor
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TripTimelineCountsCopyWith<$Res>? get counts {
    if (_self.counts == null) {
    return null;
  }

  return $TripTimelineCountsCopyWith<$Res>(_self.counts!, (value) {
    return _then(_self.copyWith(counts: value));
  });
}
}


/// Adds pattern-matching-related methods to [TripTimelineCursor].
extension TripTimelineCursorPatterns on TripTimelineCursor {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TripTimelineCursor value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TripTimelineCursor() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TripTimelineCursor value)  $default,){
final _that = this;
switch (_that) {
case _TripTimelineCursor():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TripTimelineCursor value)?  $default,){
final _that = this;
switch (_that) {
case _TripTimelineCursor() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? nextCursor,  bool hasMore,  TripTimelineCounts? counts)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TripTimelineCursor() when $default != null:
return $default(_that.nextCursor,_that.hasMore,_that.counts);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? nextCursor,  bool hasMore,  TripTimelineCounts? counts)  $default,) {final _that = this;
switch (_that) {
case _TripTimelineCursor():
return $default(_that.nextCursor,_that.hasMore,_that.counts);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? nextCursor,  bool hasMore,  TripTimelineCounts? counts)?  $default,) {final _that = this;
switch (_that) {
case _TripTimelineCursor() when $default != null:
return $default(_that.nextCursor,_that.hasMore,_that.counts);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TripTimelineCursor implements TripTimelineCursor {
  const _TripTimelineCursor({this.nextCursor, this.hasMore = false, this.counts});
  factory _TripTimelineCursor.fromJson(Map<String, dynamic> json) => _$TripTimelineCursorFromJson(json);

@override final  String? nextCursor;
@override@JsonKey() final  bool hasMore;
/// Totals of the whole trip per filter chip; only sent with the first page.
@override final  TripTimelineCounts? counts;

/// Create a copy of TripTimelineCursor
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TripTimelineCursorCopyWith<_TripTimelineCursor> get copyWith => __$TripTimelineCursorCopyWithImpl<_TripTimelineCursor>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TripTimelineCursorToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TripTimelineCursor&&(identical(other.nextCursor, nextCursor) || other.nextCursor == nextCursor)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.counts, counts) || other.counts == counts));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,nextCursor,hasMore,counts);
}

@override
String toString() {
    return 'TripTimelineCursor(nextCursor: $nextCursor, hasMore: $hasMore, counts: $counts)';
}


}

/// @nodoc
abstract mixin class _$TripTimelineCursorCopyWith<$Res> implements $TripTimelineCursorCopyWith<$Res> {
  factory _$TripTimelineCursorCopyWith(_TripTimelineCursor value, $Res Function(_TripTimelineCursor) _then) = __$TripTimelineCursorCopyWithImpl;
@override @useResult
$Res call({
 String? nextCursor, bool hasMore, TripTimelineCounts? counts
});


@override $TripTimelineCountsCopyWith<$Res>? get counts;

}
/// @nodoc
class __$TripTimelineCursorCopyWithImpl<$Res>
    implements _$TripTimelineCursorCopyWith<$Res> {
  __$TripTimelineCursorCopyWithImpl(this._self, this._then);

  final _TripTimelineCursor _self;
  final $Res Function(_TripTimelineCursor) _then;

/// Create a copy of TripTimelineCursor
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? nextCursor = freezed,Object? hasMore = null,Object? counts = freezed,}) {
  return _then(_TripTimelineCursor(
nextCursor: freezed == nextCursor ? _self.nextCursor : nextCursor // ignore: cast_nullable_to_non_nullable
as String?,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,counts: freezed == counts ? _self.counts : counts // ignore: cast_nullable_to_non_nullable
as TripTimelineCounts?,
  ));
}

/// Create a copy of TripTimelineCursor
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TripTimelineCountsCopyWith<$Res>? get counts {
    if (_self.counts == null) {
    return null;
  }

  return $TripTimelineCountsCopyWith<$Res>(_self.counts!, (value) {
    return _then(_self.copyWith(counts: value));
  });
}
}


/// @nodoc
mixin _$TripTimelineCounts {

 int get all; int get checkin; int get expense; int get memory; int get member;
/// Create a copy of TripTimelineCounts
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TripTimelineCountsCopyWith<TripTimelineCounts> get copyWith => _$TripTimelineCountsCopyWithImpl<TripTimelineCounts>(this as TripTimelineCounts, _$identity);

  /// Serializes this TripTimelineCounts to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TripTimelineCounts;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TripTimelineCounts&&(identical(other.all, _this.all) || other.all == _this.all)&&(identical(other.checkin, _this.checkin) || other.checkin == _this.checkin)&&(identical(other.expense, _this.expense) || other.expense == _this.expense)&&(identical(other.memory, _this.memory) || other.memory == _this.memory)&&(identical(other.member, _this.member) || other.member == _this.member));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TripTimelineCounts;
  return Object.hash(runtimeType,_this.all,_this.checkin,_this.expense,_this.memory,_this.member);
}

@override
String toString() {
  final _this = this as TripTimelineCounts;
  return 'TripTimelineCounts(all: ${_this.all}, checkin: ${_this.checkin}, expense: ${_this.expense}, memory: ${_this.memory}, member: ${_this.member})';
}


}

/// @nodoc
abstract mixin class $TripTimelineCountsCopyWith<$Res>  {
  factory $TripTimelineCountsCopyWith(TripTimelineCounts value, $Res Function(TripTimelineCounts) _then) = _$TripTimelineCountsCopyWithImpl;
@useResult
$Res call({
 int all, int checkin, int expense, int memory, int member
});




}
/// @nodoc
class _$TripTimelineCountsCopyWithImpl<$Res>
    implements $TripTimelineCountsCopyWith<$Res> {
  _$TripTimelineCountsCopyWithImpl(this._self, this._then);

  final TripTimelineCounts _self;
  final $Res Function(TripTimelineCounts) _then;

/// Create a copy of TripTimelineCounts
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? all = null,Object? checkin = null,Object? expense = null,Object? memory = null,Object? member = null,}) {
  return _then(TripTimelineCounts(
all: null == all ? _self.all : all // ignore: cast_nullable_to_non_nullable
as int,checkin: null == checkin ? _self.checkin : checkin // ignore: cast_nullable_to_non_nullable
as int,expense: null == expense ? _self.expense : expense // ignore: cast_nullable_to_non_nullable
as int,memory: null == memory ? _self.memory : memory // ignore: cast_nullable_to_non_nullable
as int,member: null == member ? _self.member : member // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [TripTimelineCounts].
extension TripTimelineCountsPatterns on TripTimelineCounts {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TripTimelineCounts value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TripTimelineCounts() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TripTimelineCounts value)  $default,){
final _that = this;
switch (_that) {
case _TripTimelineCounts():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TripTimelineCounts value)?  $default,){
final _that = this;
switch (_that) {
case _TripTimelineCounts() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int all,  int checkin,  int expense,  int memory,  int member)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TripTimelineCounts() when $default != null:
return $default(_that.all,_that.checkin,_that.expense,_that.memory,_that.member);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int all,  int checkin,  int expense,  int memory,  int member)  $default,) {final _that = this;
switch (_that) {
case _TripTimelineCounts():
return $default(_that.all,_that.checkin,_that.expense,_that.memory,_that.member);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int all,  int checkin,  int expense,  int memory,  int member)?  $default,) {final _that = this;
switch (_that) {
case _TripTimelineCounts() when $default != null:
return $default(_that.all,_that.checkin,_that.expense,_that.memory,_that.member);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TripTimelineCounts implements TripTimelineCounts {
  const _TripTimelineCounts({this.all = 0, this.checkin = 0, this.expense = 0, this.memory = 0, this.member = 0});
  factory _TripTimelineCounts.fromJson(Map<String, dynamic> json) => _$TripTimelineCountsFromJson(json);

@override@JsonKey() final  int all;
@override@JsonKey() final  int checkin;
@override@JsonKey() final  int expense;
@override@JsonKey() final  int memory;
@override@JsonKey() final  int member;

/// Create a copy of TripTimelineCounts
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TripTimelineCountsCopyWith<_TripTimelineCounts> get copyWith => __$TripTimelineCountsCopyWithImpl<_TripTimelineCounts>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TripTimelineCountsToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TripTimelineCounts&&(identical(other.all, all) || other.all == all)&&(identical(other.checkin, checkin) || other.checkin == checkin)&&(identical(other.expense, expense) || other.expense == expense)&&(identical(other.memory, memory) || other.memory == memory)&&(identical(other.member, member) || other.member == member));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,all,checkin,expense,memory,member);
}

@override
String toString() {
    return 'TripTimelineCounts(all: $all, checkin: $checkin, expense: $expense, memory: $memory, member: $member)';
}


}

/// @nodoc
abstract mixin class _$TripTimelineCountsCopyWith<$Res> implements $TripTimelineCountsCopyWith<$Res> {
  factory _$TripTimelineCountsCopyWith(_TripTimelineCounts value, $Res Function(_TripTimelineCounts) _then) = __$TripTimelineCountsCopyWithImpl;
@override @useResult
$Res call({
 int all, int checkin, int expense, int memory, int member
});




}
/// @nodoc
class __$TripTimelineCountsCopyWithImpl<$Res>
    implements _$TripTimelineCountsCopyWith<$Res> {
  __$TripTimelineCountsCopyWithImpl(this._self, this._then);

  final _TripTimelineCounts _self;
  final $Res Function(_TripTimelineCounts) _then;

/// Create a copy of TripTimelineCounts
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? all = null,Object? checkin = null,Object? expense = null,Object? memory = null,Object? member = null,}) {
  return _then(_TripTimelineCounts(
all: null == all ? _self.all : all // ignore: cast_nullable_to_non_nullable
as int,checkin: null == checkin ? _self.checkin : checkin // ignore: cast_nullable_to_non_nullable
as int,expense: null == expense ? _self.expense : expense // ignore: cast_nullable_to_non_nullable
as int,memory: null == memory ? _self.memory : memory // ignore: cast_nullable_to_non_nullable
as int,member: null == member ? _self.member : member // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$TripTimelineEntry {

 String get id; String get tripId; String get memberId;@JsonKey(unknownEnumValue: TripTimelineEntryType.system) TripTimelineEntryType get type; String get content; DateTime get createdAt; TripTimelineEntryMember get member;@JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue) TripTimelineTargetType? get targetType; String? get targetId;/// Null for events recorded before the backend stored metadata.
 TripTimelineEntryMetadata? get metadata;
/// Create a copy of TripTimelineEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TripTimelineEntryCopyWith<TripTimelineEntry> get copyWith => _$TripTimelineEntryCopyWithImpl<TripTimelineEntry>(this as TripTimelineEntry, _$identity);

  /// Serializes this TripTimelineEntry to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TripTimelineEntry;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TripTimelineEntry&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.tripId, _this.tripId) || other.tripId == _this.tripId)&&(identical(other.memberId, _this.memberId) || other.memberId == _this.memberId)&&(identical(other.type, _this.type) || other.type == _this.type)&&(identical(other.content, _this.content) || other.content == _this.content)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.member, _this.member) || other.member == _this.member)&&(identical(other.targetType, _this.targetType) || other.targetType == _this.targetType)&&(identical(other.targetId, _this.targetId) || other.targetId == _this.targetId)&&(identical(other.metadata, _this.metadata) || other.metadata == _this.metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TripTimelineEntry;
  return Object.hash(runtimeType,_this.id,_this.tripId,_this.memberId,_this.type,_this.content,_this.createdAt,_this.member,_this.targetType,_this.targetId,_this.metadata);
}

@override
String toString() {
  final _this = this as TripTimelineEntry;
  return 'TripTimelineEntry(id: ${_this.id}, tripId: ${_this.tripId}, memberId: ${_this.memberId}, type: ${_this.type}, content: ${_this.content}, createdAt: ${_this.createdAt}, member: ${_this.member}, targetType: ${_this.targetType}, targetId: ${_this.targetId}, metadata: ${_this.metadata})';
}


}

/// @nodoc
abstract mixin class $TripTimelineEntryCopyWith<$Res>  {
  factory $TripTimelineEntryCopyWith(TripTimelineEntry value, $Res Function(TripTimelineEntry) _then) = _$TripTimelineEntryCopyWithImpl;
@useResult
$Res call({
 String id, String tripId, String memberId,@JsonKey(unknownEnumValue: TripTimelineEntryType.system) TripTimelineEntryType type, String content, DateTime createdAt, TripTimelineEntryMember member,@JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue) TripTimelineTargetType? targetType, String? targetId, TripTimelineEntryMetadata? metadata
});


$TripTimelineEntryMemberCopyWith<$Res> get member;$TripTimelineEntryMetadataCopyWith<$Res>? get metadata;

}
/// @nodoc
class _$TripTimelineEntryCopyWithImpl<$Res>
    implements $TripTimelineEntryCopyWith<$Res> {
  _$TripTimelineEntryCopyWithImpl(this._self, this._then);

  final TripTimelineEntry _self;
  final $Res Function(TripTimelineEntry) _then;

/// Create a copy of TripTimelineEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? tripId = null,Object? memberId = null,Object? type = null,Object? content = null,Object? createdAt = null,Object? member = null,Object? targetType = freezed,Object? targetId = freezed,Object? metadata = freezed,}) {
  return _then(TripTimelineEntry(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,tripId: null == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String,memberId: null == memberId ? _self.memberId : memberId // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as TripTimelineEntryType,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,member: null == member ? _self.member : member // ignore: cast_nullable_to_non_nullable
as TripTimelineEntryMember,targetType: freezed == targetType ? _self.targetType : targetType // ignore: cast_nullable_to_non_nullable
as TripTimelineTargetType?,targetId: freezed == targetId ? _self.targetId : targetId // ignore: cast_nullable_to_non_nullable
as String?,metadata: freezed == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as TripTimelineEntryMetadata?,
  ));
}
/// Create a copy of TripTimelineEntry
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TripTimelineEntryMemberCopyWith<$Res> get member {
  
  return $TripTimelineEntryMemberCopyWith<$Res>(_self.member, (value) {
    return _then(_self.copyWith(member: value));
  });
}/// Create a copy of TripTimelineEntry
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TripTimelineEntryMetadataCopyWith<$Res>? get metadata {
    if (_self.metadata == null) {
    return null;
  }

  return $TripTimelineEntryMetadataCopyWith<$Res>(_self.metadata!, (value) {
    return _then(_self.copyWith(metadata: value));
  });
}
}


/// Adds pattern-matching-related methods to [TripTimelineEntry].
extension TripTimelineEntryPatterns on TripTimelineEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TripTimelineEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TripTimelineEntry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TripTimelineEntry value)  $default,){
final _that = this;
switch (_that) {
case _TripTimelineEntry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TripTimelineEntry value)?  $default,){
final _that = this;
switch (_that) {
case _TripTimelineEntry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String tripId,  String memberId, @JsonKey(unknownEnumValue: TripTimelineEntryType.system)  TripTimelineEntryType type,  String content,  DateTime createdAt,  TripTimelineEntryMember member, @JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue)  TripTimelineTargetType? targetType,  String? targetId,  TripTimelineEntryMetadata? metadata)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TripTimelineEntry() when $default != null:
return $default(_that.id,_that.tripId,_that.memberId,_that.type,_that.content,_that.createdAt,_that.member,_that.targetType,_that.targetId,_that.metadata);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String tripId,  String memberId, @JsonKey(unknownEnumValue: TripTimelineEntryType.system)  TripTimelineEntryType type,  String content,  DateTime createdAt,  TripTimelineEntryMember member, @JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue)  TripTimelineTargetType? targetType,  String? targetId,  TripTimelineEntryMetadata? metadata)  $default,) {final _that = this;
switch (_that) {
case _TripTimelineEntry():
return $default(_that.id,_that.tripId,_that.memberId,_that.type,_that.content,_that.createdAt,_that.member,_that.targetType,_that.targetId,_that.metadata);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String tripId,  String memberId, @JsonKey(unknownEnumValue: TripTimelineEntryType.system)  TripTimelineEntryType type,  String content,  DateTime createdAt,  TripTimelineEntryMember member, @JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue)  TripTimelineTargetType? targetType,  String? targetId,  TripTimelineEntryMetadata? metadata)?  $default,) {final _that = this;
switch (_that) {
case _TripTimelineEntry() when $default != null:
return $default(_that.id,_that.tripId,_that.memberId,_that.type,_that.content,_that.createdAt,_that.member,_that.targetType,_that.targetId,_that.metadata);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TripTimelineEntry implements TripTimelineEntry {
  const _TripTimelineEntry({required this.id, required this.tripId, required this.memberId, @JsonKey(unknownEnumValue: TripTimelineEntryType.system) required this.type, required this.content, required this.createdAt, required this.member, @JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue) this.targetType, this.targetId, this.metadata});
  factory _TripTimelineEntry.fromJson(Map<String, dynamic> json) => _$TripTimelineEntryFromJson(json);

@override final  String id;
@override final  String tripId;
@override final  String memberId;
@override@JsonKey(unknownEnumValue: TripTimelineEntryType.system) final  TripTimelineEntryType type;
@override final  String content;
@override final  DateTime createdAt;
@override final  TripTimelineEntryMember member;
@override@JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue) final  TripTimelineTargetType? targetType;
@override final  String? targetId;
/// Null for events recorded before the backend stored metadata.
@override final  TripTimelineEntryMetadata? metadata;

/// Create a copy of TripTimelineEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TripTimelineEntryCopyWith<_TripTimelineEntry> get copyWith => __$TripTimelineEntryCopyWithImpl<_TripTimelineEntry>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TripTimelineEntryToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TripTimelineEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.tripId, tripId) || other.tripId == tripId)&&(identical(other.memberId, memberId) || other.memberId == memberId)&&(identical(other.type, type) || other.type == type)&&(identical(other.content, content) || other.content == content)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.member, member) || other.member == member)&&(identical(other.targetType, targetType) || other.targetType == targetType)&&(identical(other.targetId, targetId) || other.targetId == targetId)&&(identical(other.metadata, metadata) || other.metadata == metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,tripId,memberId,type,content,createdAt,member,targetType,targetId,metadata);
}

@override
String toString() {
    return 'TripTimelineEntry(id: $id, tripId: $tripId, memberId: $memberId, type: $type, content: $content, createdAt: $createdAt, member: $member, targetType: $targetType, targetId: $targetId, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class _$TripTimelineEntryCopyWith<$Res> implements $TripTimelineEntryCopyWith<$Res> {
  factory _$TripTimelineEntryCopyWith(_TripTimelineEntry value, $Res Function(_TripTimelineEntry) _then) = __$TripTimelineEntryCopyWithImpl;
@override @useResult
$Res call({
 String id, String tripId, String memberId,@JsonKey(unknownEnumValue: TripTimelineEntryType.system) TripTimelineEntryType type, String content, DateTime createdAt, TripTimelineEntryMember member,@JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue) TripTimelineTargetType? targetType, String? targetId, TripTimelineEntryMetadata? metadata
});


@override $TripTimelineEntryMemberCopyWith<$Res> get member;@override $TripTimelineEntryMetadataCopyWith<$Res>? get metadata;

}
/// @nodoc
class __$TripTimelineEntryCopyWithImpl<$Res>
    implements _$TripTimelineEntryCopyWith<$Res> {
  __$TripTimelineEntryCopyWithImpl(this._self, this._then);

  final _TripTimelineEntry _self;
  final $Res Function(_TripTimelineEntry) _then;

/// Create a copy of TripTimelineEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? tripId = null,Object? memberId = null,Object? type = null,Object? content = null,Object? createdAt = null,Object? member = null,Object? targetType = freezed,Object? targetId = freezed,Object? metadata = freezed,}) {
  return _then(_TripTimelineEntry(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,tripId: null == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String,memberId: null == memberId ? _self.memberId : memberId // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as TripTimelineEntryType,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,member: null == member ? _self.member : member // ignore: cast_nullable_to_non_nullable
as TripTimelineEntryMember,targetType: freezed == targetType ? _self.targetType : targetType // ignore: cast_nullable_to_non_nullable
as TripTimelineTargetType?,targetId: freezed == targetId ? _self.targetId : targetId // ignore: cast_nullable_to_non_nullable
as String?,metadata: freezed == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as TripTimelineEntryMetadata?,
  ));
}

/// Create a copy of TripTimelineEntry
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TripTimelineEntryMemberCopyWith<$Res> get member {
  
  return $TripTimelineEntryMemberCopyWith<$Res>(_self.member, (value) {
    return _then(_self.copyWith(member: value));
  });
}/// Create a copy of TripTimelineEntry
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TripTimelineEntryMetadataCopyWith<$Res>? get metadata {
    if (_self.metadata == null) {
    return null;
  }

  return $TripTimelineEntryMetadataCopyWith<$Res>(_self.metadata!, (value) {
    return _then(_self.copyWith(metadata: value));
  });
}
}


/// @nodoc
mixin _$TripTimelineEntryMember {

 String get id; TripTimelineEntryUser get user;
/// Create a copy of TripTimelineEntryMember
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TripTimelineEntryMemberCopyWith<TripTimelineEntryMember> get copyWith => _$TripTimelineEntryMemberCopyWithImpl<TripTimelineEntryMember>(this as TripTimelineEntryMember, _$identity);

  /// Serializes this TripTimelineEntryMember to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TripTimelineEntryMember;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TripTimelineEntryMember&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.user, _this.user) || other.user == _this.user));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TripTimelineEntryMember;
  return Object.hash(runtimeType,_this.id,_this.user);
}

@override
String toString() {
  final _this = this as TripTimelineEntryMember;
  return 'TripTimelineEntryMember(id: ${_this.id}, user: ${_this.user})';
}


}

/// @nodoc
abstract mixin class $TripTimelineEntryMemberCopyWith<$Res>  {
  factory $TripTimelineEntryMemberCopyWith(TripTimelineEntryMember value, $Res Function(TripTimelineEntryMember) _then) = _$TripTimelineEntryMemberCopyWithImpl;
@useResult
$Res call({
 String id, TripTimelineEntryUser user
});


$TripTimelineEntryUserCopyWith<$Res> get user;

}
/// @nodoc
class _$TripTimelineEntryMemberCopyWithImpl<$Res>
    implements $TripTimelineEntryMemberCopyWith<$Res> {
  _$TripTimelineEntryMemberCopyWithImpl(this._self, this._then);

  final TripTimelineEntryMember _self;
  final $Res Function(TripTimelineEntryMember) _then;

/// Create a copy of TripTimelineEntryMember
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? user = null,}) {
  return _then(TripTimelineEntryMember(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as TripTimelineEntryUser,
  ));
}
/// Create a copy of TripTimelineEntryMember
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TripTimelineEntryUserCopyWith<$Res> get user {
  
  return $TripTimelineEntryUserCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}


/// Adds pattern-matching-related methods to [TripTimelineEntryMember].
extension TripTimelineEntryMemberPatterns on TripTimelineEntryMember {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TripTimelineEntryMember value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TripTimelineEntryMember() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TripTimelineEntryMember value)  $default,){
final _that = this;
switch (_that) {
case _TripTimelineEntryMember():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TripTimelineEntryMember value)?  $default,){
final _that = this;
switch (_that) {
case _TripTimelineEntryMember() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  TripTimelineEntryUser user)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TripTimelineEntryMember() when $default != null:
return $default(_that.id,_that.user);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  TripTimelineEntryUser user)  $default,) {final _that = this;
switch (_that) {
case _TripTimelineEntryMember():
return $default(_that.id,_that.user);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  TripTimelineEntryUser user)?  $default,) {final _that = this;
switch (_that) {
case _TripTimelineEntryMember() when $default != null:
return $default(_that.id,_that.user);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TripTimelineEntryMember implements TripTimelineEntryMember {
  const _TripTimelineEntryMember({required this.id, required this.user});
  factory _TripTimelineEntryMember.fromJson(Map<String, dynamic> json) => _$TripTimelineEntryMemberFromJson(json);

@override final  String id;
@override final  TripTimelineEntryUser user;

/// Create a copy of TripTimelineEntryMember
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TripTimelineEntryMemberCopyWith<_TripTimelineEntryMember> get copyWith => __$TripTimelineEntryMemberCopyWithImpl<_TripTimelineEntryMember>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TripTimelineEntryMemberToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TripTimelineEntryMember&&(identical(other.id, id) || other.id == id)&&(identical(other.user, user) || other.user == user));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,user);
}

@override
String toString() {
    return 'TripTimelineEntryMember(id: $id, user: $user)';
}


}

/// @nodoc
abstract mixin class _$TripTimelineEntryMemberCopyWith<$Res> implements $TripTimelineEntryMemberCopyWith<$Res> {
  factory _$TripTimelineEntryMemberCopyWith(_TripTimelineEntryMember value, $Res Function(_TripTimelineEntryMember) _then) = __$TripTimelineEntryMemberCopyWithImpl;
@override @useResult
$Res call({
 String id, TripTimelineEntryUser user
});


@override $TripTimelineEntryUserCopyWith<$Res> get user;

}
/// @nodoc
class __$TripTimelineEntryMemberCopyWithImpl<$Res>
    implements _$TripTimelineEntryMemberCopyWith<$Res> {
  __$TripTimelineEntryMemberCopyWithImpl(this._self, this._then);

  final _TripTimelineEntryMember _self;
  final $Res Function(_TripTimelineEntryMember) _then;

/// Create a copy of TripTimelineEntryMember
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? user = null,}) {
  return _then(_TripTimelineEntryMember(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as TripTimelineEntryUser,
  ));
}

/// Create a copy of TripTimelineEntryMember
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TripTimelineEntryUserCopyWith<$Res> get user {
  
  return $TripTimelineEntryUserCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}


/// @nodoc
mixin _$TripTimelineEntryUser {

 String get id; String get username; String? get displayName; String? get avatarUrl;
/// Create a copy of TripTimelineEntryUser
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TripTimelineEntryUserCopyWith<TripTimelineEntryUser> get copyWith => _$TripTimelineEntryUserCopyWithImpl<TripTimelineEntryUser>(this as TripTimelineEntryUser, _$identity);

  /// Serializes this TripTimelineEntryUser to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TripTimelineEntryUser;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TripTimelineEntryUser&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.username, _this.username) || other.username == _this.username)&&(identical(other.displayName, _this.displayName) || other.displayName == _this.displayName)&&(identical(other.avatarUrl, _this.avatarUrl) || other.avatarUrl == _this.avatarUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TripTimelineEntryUser;
  return Object.hash(runtimeType,_this.id,_this.username,_this.displayName,_this.avatarUrl);
}

@override
String toString() {
  final _this = this as TripTimelineEntryUser;
  return 'TripTimelineEntryUser(id: ${_this.id}, username: ${_this.username}, displayName: ${_this.displayName}, avatarUrl: ${_this.avatarUrl})';
}


}

/// @nodoc
abstract mixin class $TripTimelineEntryUserCopyWith<$Res>  {
  factory $TripTimelineEntryUserCopyWith(TripTimelineEntryUser value, $Res Function(TripTimelineEntryUser) _then) = _$TripTimelineEntryUserCopyWithImpl;
@useResult
$Res call({
 String id, String username, String? displayName, String? avatarUrl
});




}
/// @nodoc
class _$TripTimelineEntryUserCopyWithImpl<$Res>
    implements $TripTimelineEntryUserCopyWith<$Res> {
  _$TripTimelineEntryUserCopyWithImpl(this._self, this._then);

  final TripTimelineEntryUser _self;
  final $Res Function(TripTimelineEntryUser) _then;

/// Create a copy of TripTimelineEntryUser
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? username = null,Object? displayName = freezed,Object? avatarUrl = freezed,}) {
  return _then(TripTimelineEntryUser(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,displayName: freezed == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TripTimelineEntryUser].
extension TripTimelineEntryUserPatterns on TripTimelineEntryUser {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TripTimelineEntryUser value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TripTimelineEntryUser() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TripTimelineEntryUser value)  $default,){
final _that = this;
switch (_that) {
case _TripTimelineEntryUser():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TripTimelineEntryUser value)?  $default,){
final _that = this;
switch (_that) {
case _TripTimelineEntryUser() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String username,  String? displayName,  String? avatarUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TripTimelineEntryUser() when $default != null:
return $default(_that.id,_that.username,_that.displayName,_that.avatarUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String username,  String? displayName,  String? avatarUrl)  $default,) {final _that = this;
switch (_that) {
case _TripTimelineEntryUser():
return $default(_that.id,_that.username,_that.displayName,_that.avatarUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String username,  String? displayName,  String? avatarUrl)?  $default,) {final _that = this;
switch (_that) {
case _TripTimelineEntryUser() when $default != null:
return $default(_that.id,_that.username,_that.displayName,_that.avatarUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TripTimelineEntryUser extends TripTimelineEntryUser {
  const _TripTimelineEntryUser({required this.id, required this.username, this.displayName, this.avatarUrl}): super._();
  factory _TripTimelineEntryUser.fromJson(Map<String, dynamic> json) => _$TripTimelineEntryUserFromJson(json);

@override final  String id;
@override final  String username;
@override final  String? displayName;
@override final  String? avatarUrl;

/// Create a copy of TripTimelineEntryUser
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TripTimelineEntryUserCopyWith<_TripTimelineEntryUser> get copyWith => __$TripTimelineEntryUserCopyWithImpl<_TripTimelineEntryUser>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TripTimelineEntryUserToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TripTimelineEntryUser&&(identical(other.id, id) || other.id == id)&&(identical(other.username, username) || other.username == username)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,username,displayName,avatarUrl);
}

@override
String toString() {
    return 'TripTimelineEntryUser(id: $id, username: $username, displayName: $displayName, avatarUrl: $avatarUrl)';
}


}

/// @nodoc
abstract mixin class _$TripTimelineEntryUserCopyWith<$Res> implements $TripTimelineEntryUserCopyWith<$Res> {
  factory _$TripTimelineEntryUserCopyWith(_TripTimelineEntryUser value, $Res Function(_TripTimelineEntryUser) _then) = __$TripTimelineEntryUserCopyWithImpl;
@override @useResult
$Res call({
 String id, String username, String? displayName, String? avatarUrl
});




}
/// @nodoc
class __$TripTimelineEntryUserCopyWithImpl<$Res>
    implements _$TripTimelineEntryUserCopyWith<$Res> {
  __$TripTimelineEntryUserCopyWithImpl(this._self, this._then);

  final _TripTimelineEntryUser _self;
  final $Res Function(_TripTimelineEntryUser) _then;

/// Create a copy of TripTimelineEntryUser
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? username = null,Object? displayName = freezed,Object? avatarUrl = freezed,}) {
  return _then(_TripTimelineEntryUser(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,displayName: freezed == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$TripTimelineEntryMetadata {

 String? get tripName; DateTime? get startDate; DateTime? get endDate; int? get destinationCount;@JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue) TripTimelineJoinVia? get via; String? get targetMemberId; String? get targetName; String? get activityTitle; String? get placeName; String? get placeArea; int? get dayNumber; DateTime? get startTime; DateTime? get previousStartTime; double? get latitude; double? get longitude; String? get imageUrl; bool get verified; int? get pointsEarned;@JsonKey(fromJson: _moneyFromJson) double? get amount; String get currency; String? get category; String? get description;@JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue) TripTimelineSplitType? get splitType; int? get splitCount; String? get payerMemberId; String? get payerName; String? get debtorMemberId; String? get debtorName; List<String> get memoryIds; List<String> get photoUrls; int? get photoCount; String? get caption;
/// Create a copy of TripTimelineEntryMetadata
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TripTimelineEntryMetadataCopyWith<TripTimelineEntryMetadata> get copyWith => _$TripTimelineEntryMetadataCopyWithImpl<TripTimelineEntryMetadata>(this as TripTimelineEntryMetadata, _$identity);

  /// Serializes this TripTimelineEntryMetadata to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TripTimelineEntryMetadata;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TripTimelineEntryMetadata&&(identical(other.tripName, _this.tripName) || other.tripName == _this.tripName)&&(identical(other.startDate, _this.startDate) || other.startDate == _this.startDate)&&(identical(other.endDate, _this.endDate) || other.endDate == _this.endDate)&&(identical(other.destinationCount, _this.destinationCount) || other.destinationCount == _this.destinationCount)&&(identical(other.via, _this.via) || other.via == _this.via)&&(identical(other.targetMemberId, _this.targetMemberId) || other.targetMemberId == _this.targetMemberId)&&(identical(other.targetName, _this.targetName) || other.targetName == _this.targetName)&&(identical(other.activityTitle, _this.activityTitle) || other.activityTitle == _this.activityTitle)&&(identical(other.placeName, _this.placeName) || other.placeName == _this.placeName)&&(identical(other.placeArea, _this.placeArea) || other.placeArea == _this.placeArea)&&(identical(other.dayNumber, _this.dayNumber) || other.dayNumber == _this.dayNumber)&&(identical(other.startTime, _this.startTime) || other.startTime == _this.startTime)&&(identical(other.previousStartTime, _this.previousStartTime) || other.previousStartTime == _this.previousStartTime)&&(identical(other.latitude, _this.latitude) || other.latitude == _this.latitude)&&(identical(other.longitude, _this.longitude) || other.longitude == _this.longitude)&&(identical(other.imageUrl, _this.imageUrl) || other.imageUrl == _this.imageUrl)&&(identical(other.verified, _this.verified) || other.verified == _this.verified)&&(identical(other.pointsEarned, _this.pointsEarned) || other.pointsEarned == _this.pointsEarned)&&(identical(other.amount, _this.amount) || other.amount == _this.amount)&&(identical(other.currency, _this.currency) || other.currency == _this.currency)&&(identical(other.category, _this.category) || other.category == _this.category)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.splitType, _this.splitType) || other.splitType == _this.splitType)&&(identical(other.splitCount, _this.splitCount) || other.splitCount == _this.splitCount)&&(identical(other.payerMemberId, _this.payerMemberId) || other.payerMemberId == _this.payerMemberId)&&(identical(other.payerName, _this.payerName) || other.payerName == _this.payerName)&&(identical(other.debtorMemberId, _this.debtorMemberId) || other.debtorMemberId == _this.debtorMemberId)&&(identical(other.debtorName, _this.debtorName) || other.debtorName == _this.debtorName)&&const DeepCollectionEquality().equals(other.memoryIds, _this.memoryIds)&&const DeepCollectionEquality().equals(other.photoUrls, _this.photoUrls)&&(identical(other.photoCount, _this.photoCount) || other.photoCount == _this.photoCount)&&(identical(other.caption, _this.caption) || other.caption == _this.caption));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TripTimelineEntryMetadata;
  return Object.hashAll([runtimeType,_this.tripName,_this.startDate,_this.endDate,_this.destinationCount,_this.via,_this.targetMemberId,_this.targetName,_this.activityTitle,_this.placeName,_this.placeArea,_this.dayNumber,_this.startTime,_this.previousStartTime,_this.latitude,_this.longitude,_this.imageUrl,_this.verified,_this.pointsEarned,_this.amount,_this.currency,_this.category,_this.description,_this.splitType,_this.splitCount,_this.payerMemberId,_this.payerName,_this.debtorMemberId,_this.debtorName,const DeepCollectionEquality().hash(_this.memoryIds),const DeepCollectionEquality().hash(_this.photoUrls),_this.photoCount,_this.caption]);
}

@override
String toString() {
  final _this = this as TripTimelineEntryMetadata;
  return 'TripTimelineEntryMetadata(tripName: ${_this.tripName}, startDate: ${_this.startDate}, endDate: ${_this.endDate}, destinationCount: ${_this.destinationCount}, via: ${_this.via}, targetMemberId: ${_this.targetMemberId}, targetName: ${_this.targetName}, activityTitle: ${_this.activityTitle}, placeName: ${_this.placeName}, placeArea: ${_this.placeArea}, dayNumber: ${_this.dayNumber}, startTime: ${_this.startTime}, previousStartTime: ${_this.previousStartTime}, latitude: ${_this.latitude}, longitude: ${_this.longitude}, imageUrl: ${_this.imageUrl}, verified: ${_this.verified}, pointsEarned: ${_this.pointsEarned}, amount: ${_this.amount}, currency: ${_this.currency}, category: ${_this.category}, description: ${_this.description}, splitType: ${_this.splitType}, splitCount: ${_this.splitCount}, payerMemberId: ${_this.payerMemberId}, payerName: ${_this.payerName}, debtorMemberId: ${_this.debtorMemberId}, debtorName: ${_this.debtorName}, memoryIds: ${_this.memoryIds}, photoUrls: ${_this.photoUrls}, photoCount: ${_this.photoCount}, caption: ${_this.caption})';
}


}

/// @nodoc
abstract mixin class $TripTimelineEntryMetadataCopyWith<$Res>  {
  factory $TripTimelineEntryMetadataCopyWith(TripTimelineEntryMetadata value, $Res Function(TripTimelineEntryMetadata) _then) = _$TripTimelineEntryMetadataCopyWithImpl;
@useResult
$Res call({
 String? tripName, DateTime? startDate, DateTime? endDate, int? destinationCount,@JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue) TripTimelineJoinVia? via, String? targetMemberId, String? targetName, String? activityTitle, String? placeName, String? placeArea, int? dayNumber, DateTime? startTime, DateTime? previousStartTime, double? latitude, double? longitude, String? imageUrl, bool verified, int? pointsEarned,@JsonKey(fromJson: _moneyFromJson) double? amount, String currency, String? category, String? description,@JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue) TripTimelineSplitType? splitType, int? splitCount, String? payerMemberId, String? payerName, String? debtorMemberId, String? debtorName, List<String> memoryIds, List<String> photoUrls, int? photoCount, String? caption
});




}
/// @nodoc
class _$TripTimelineEntryMetadataCopyWithImpl<$Res>
    implements $TripTimelineEntryMetadataCopyWith<$Res> {
  _$TripTimelineEntryMetadataCopyWithImpl(this._self, this._then);

  final TripTimelineEntryMetadata _self;
  final $Res Function(TripTimelineEntryMetadata) _then;

/// Create a copy of TripTimelineEntryMetadata
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? tripName = freezed,Object? startDate = freezed,Object? endDate = freezed,Object? destinationCount = freezed,Object? via = freezed,Object? targetMemberId = freezed,Object? targetName = freezed,Object? activityTitle = freezed,Object? placeName = freezed,Object? placeArea = freezed,Object? dayNumber = freezed,Object? startTime = freezed,Object? previousStartTime = freezed,Object? latitude = freezed,Object? longitude = freezed,Object? imageUrl = freezed,Object? verified = null,Object? pointsEarned = freezed,Object? amount = freezed,Object? currency = null,Object? category = freezed,Object? description = freezed,Object? splitType = freezed,Object? splitCount = freezed,Object? payerMemberId = freezed,Object? payerName = freezed,Object? debtorMemberId = freezed,Object? debtorName = freezed,Object? memoryIds = null,Object? photoUrls = null,Object? photoCount = freezed,Object? caption = freezed,}) {
  return _then(TripTimelineEntryMetadata(
tripName: freezed == tripName ? _self.tripName : tripName // ignore: cast_nullable_to_non_nullable
as String?,startDate: freezed == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime?,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime?,destinationCount: freezed == destinationCount ? _self.destinationCount : destinationCount // ignore: cast_nullable_to_non_nullable
as int?,via: freezed == via ? _self.via : via // ignore: cast_nullable_to_non_nullable
as TripTimelineJoinVia?,targetMemberId: freezed == targetMemberId ? _self.targetMemberId : targetMemberId // ignore: cast_nullable_to_non_nullable
as String?,targetName: freezed == targetName ? _self.targetName : targetName // ignore: cast_nullable_to_non_nullable
as String?,activityTitle: freezed == activityTitle ? _self.activityTitle : activityTitle // ignore: cast_nullable_to_non_nullable
as String?,placeName: freezed == placeName ? _self.placeName : placeName // ignore: cast_nullable_to_non_nullable
as String?,placeArea: freezed == placeArea ? _self.placeArea : placeArea // ignore: cast_nullable_to_non_nullable
as String?,dayNumber: freezed == dayNumber ? _self.dayNumber : dayNumber // ignore: cast_nullable_to_non_nullable
as int?,startTime: freezed == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as DateTime?,previousStartTime: freezed == previousStartTime ? _self.previousStartTime : previousStartTime // ignore: cast_nullable_to_non_nullable
as DateTime?,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,verified: null == verified ? _self.verified : verified // ignore: cast_nullable_to_non_nullable
as bool,pointsEarned: freezed == pointsEarned ? _self.pointsEarned : pointsEarned // ignore: cast_nullable_to_non_nullable
as int?,amount: freezed == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double?,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,splitType: freezed == splitType ? _self.splitType : splitType // ignore: cast_nullable_to_non_nullable
as TripTimelineSplitType?,splitCount: freezed == splitCount ? _self.splitCount : splitCount // ignore: cast_nullable_to_non_nullable
as int?,payerMemberId: freezed == payerMemberId ? _self.payerMemberId : payerMemberId // ignore: cast_nullable_to_non_nullable
as String?,payerName: freezed == payerName ? _self.payerName : payerName // ignore: cast_nullable_to_non_nullable
as String?,debtorMemberId: freezed == debtorMemberId ? _self.debtorMemberId : debtorMemberId // ignore: cast_nullable_to_non_nullable
as String?,debtorName: freezed == debtorName ? _self.debtorName : debtorName // ignore: cast_nullable_to_non_nullable
as String?,memoryIds: null == memoryIds ? _self.memoryIds : memoryIds // ignore: cast_nullable_to_non_nullable
as List<String>,photoUrls: null == photoUrls ? _self.photoUrls : photoUrls // ignore: cast_nullable_to_non_nullable
as List<String>,photoCount: freezed == photoCount ? _self.photoCount : photoCount // ignore: cast_nullable_to_non_nullable
as int?,caption: freezed == caption ? _self.caption : caption // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TripTimelineEntryMetadata].
extension TripTimelineEntryMetadataPatterns on TripTimelineEntryMetadata {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TripTimelineEntryMetadata value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TripTimelineEntryMetadata() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TripTimelineEntryMetadata value)  $default,){
final _that = this;
switch (_that) {
case _TripTimelineEntryMetadata():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TripTimelineEntryMetadata value)?  $default,){
final _that = this;
switch (_that) {
case _TripTimelineEntryMetadata() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? tripName,  DateTime? startDate,  DateTime? endDate,  int? destinationCount, @JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue)  TripTimelineJoinVia? via,  String? targetMemberId,  String? targetName,  String? activityTitle,  String? placeName,  String? placeArea,  int? dayNumber,  DateTime? startTime,  DateTime? previousStartTime,  double? latitude,  double? longitude,  String? imageUrl,  bool verified,  int? pointsEarned, @JsonKey(fromJson: _moneyFromJson)  double? amount,  String currency,  String? category,  String? description, @JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue)  TripTimelineSplitType? splitType,  int? splitCount,  String? payerMemberId,  String? payerName,  String? debtorMemberId,  String? debtorName,  List<String> memoryIds,  List<String> photoUrls,  int? photoCount,  String? caption)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TripTimelineEntryMetadata() when $default != null:
return $default(_that.tripName,_that.startDate,_that.endDate,_that.destinationCount,_that.via,_that.targetMemberId,_that.targetName,_that.activityTitle,_that.placeName,_that.placeArea,_that.dayNumber,_that.startTime,_that.previousStartTime,_that.latitude,_that.longitude,_that.imageUrl,_that.verified,_that.pointsEarned,_that.amount,_that.currency,_that.category,_that.description,_that.splitType,_that.splitCount,_that.payerMemberId,_that.payerName,_that.debtorMemberId,_that.debtorName,_that.memoryIds,_that.photoUrls,_that.photoCount,_that.caption);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? tripName,  DateTime? startDate,  DateTime? endDate,  int? destinationCount, @JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue)  TripTimelineJoinVia? via,  String? targetMemberId,  String? targetName,  String? activityTitle,  String? placeName,  String? placeArea,  int? dayNumber,  DateTime? startTime,  DateTime? previousStartTime,  double? latitude,  double? longitude,  String? imageUrl,  bool verified,  int? pointsEarned, @JsonKey(fromJson: _moneyFromJson)  double? amount,  String currency,  String? category,  String? description, @JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue)  TripTimelineSplitType? splitType,  int? splitCount,  String? payerMemberId,  String? payerName,  String? debtorMemberId,  String? debtorName,  List<String> memoryIds,  List<String> photoUrls,  int? photoCount,  String? caption)  $default,) {final _that = this;
switch (_that) {
case _TripTimelineEntryMetadata():
return $default(_that.tripName,_that.startDate,_that.endDate,_that.destinationCount,_that.via,_that.targetMemberId,_that.targetName,_that.activityTitle,_that.placeName,_that.placeArea,_that.dayNumber,_that.startTime,_that.previousStartTime,_that.latitude,_that.longitude,_that.imageUrl,_that.verified,_that.pointsEarned,_that.amount,_that.currency,_that.category,_that.description,_that.splitType,_that.splitCount,_that.payerMemberId,_that.payerName,_that.debtorMemberId,_that.debtorName,_that.memoryIds,_that.photoUrls,_that.photoCount,_that.caption);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? tripName,  DateTime? startDate,  DateTime? endDate,  int? destinationCount, @JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue)  TripTimelineJoinVia? via,  String? targetMemberId,  String? targetName,  String? activityTitle,  String? placeName,  String? placeArea,  int? dayNumber,  DateTime? startTime,  DateTime? previousStartTime,  double? latitude,  double? longitude,  String? imageUrl,  bool verified,  int? pointsEarned, @JsonKey(fromJson: _moneyFromJson)  double? amount,  String currency,  String? category,  String? description, @JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue)  TripTimelineSplitType? splitType,  int? splitCount,  String? payerMemberId,  String? payerName,  String? debtorMemberId,  String? debtorName,  List<String> memoryIds,  List<String> photoUrls,  int? photoCount,  String? caption)?  $default,) {final _that = this;
switch (_that) {
case _TripTimelineEntryMetadata() when $default != null:
return $default(_that.tripName,_that.startDate,_that.endDate,_that.destinationCount,_that.via,_that.targetMemberId,_that.targetName,_that.activityTitle,_that.placeName,_that.placeArea,_that.dayNumber,_that.startTime,_that.previousStartTime,_that.latitude,_that.longitude,_that.imageUrl,_that.verified,_that.pointsEarned,_that.amount,_that.currency,_that.category,_that.description,_that.splitType,_that.splitCount,_that.payerMemberId,_that.payerName,_that.debtorMemberId,_that.debtorName,_that.memoryIds,_that.photoUrls,_that.photoCount,_that.caption);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TripTimelineEntryMetadata implements TripTimelineEntryMetadata {
  const _TripTimelineEntryMetadata({this.tripName, this.startDate, this.endDate, this.destinationCount, @JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue) this.via, this.targetMemberId, this.targetName, this.activityTitle, this.placeName, this.placeArea, this.dayNumber, this.startTime, this.previousStartTime, this.latitude, this.longitude, this.imageUrl, this.verified = false, this.pointsEarned, @JsonKey(fromJson: _moneyFromJson) this.amount, this.currency = 'VND', this.category, this.description, @JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue) this.splitType, this.splitCount, this.payerMemberId, this.payerName, this.debtorMemberId, this.debtorName,  List<String> memoryIds = const <String>[],  List<String> photoUrls = const <String>[], this.photoCount, this.caption}): _memoryIds = memoryIds,_photoUrls = photoUrls;
  factory _TripTimelineEntryMetadata.fromJson(Map<String, dynamic> json) => _$TripTimelineEntryMetadataFromJson(json);

@override final  String? tripName;
@override final  DateTime? startDate;
@override final  DateTime? endDate;
@override final  int? destinationCount;
@override@JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue) final  TripTimelineJoinVia? via;
@override final  String? targetMemberId;
@override final  String? targetName;
@override final  String? activityTitle;
@override final  String? placeName;
@override final  String? placeArea;
@override final  int? dayNumber;
@override final  DateTime? startTime;
@override final  DateTime? previousStartTime;
@override final  double? latitude;
@override final  double? longitude;
@override final  String? imageUrl;
@override@JsonKey() final  bool verified;
@override final  int? pointsEarned;
@override@JsonKey(fromJson: _moneyFromJson) final  double? amount;
@override@JsonKey() final  String currency;
@override final  String? category;
@override final  String? description;
@override@JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue) final  TripTimelineSplitType? splitType;
@override final  int? splitCount;
@override final  String? payerMemberId;
@override final  String? payerName;
@override final  String? debtorMemberId;
@override final  String? debtorName;
 final  List<String> _memoryIds;
@override@JsonKey() List<String> get memoryIds {
  if (_memoryIds is EqualUnmodifiableListView) return _memoryIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_memoryIds);
}

 final  List<String> _photoUrls;
@override@JsonKey() List<String> get photoUrls {
  if (_photoUrls is EqualUnmodifiableListView) return _photoUrls;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_photoUrls);
}

@override final  int? photoCount;
@override final  String? caption;

/// Create a copy of TripTimelineEntryMetadata
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TripTimelineEntryMetadataCopyWith<_TripTimelineEntryMetadata> get copyWith => __$TripTimelineEntryMetadataCopyWithImpl<_TripTimelineEntryMetadata>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TripTimelineEntryMetadataToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TripTimelineEntryMetadata&&(identical(other.tripName, tripName) || other.tripName == tripName)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.destinationCount, destinationCount) || other.destinationCount == destinationCount)&&(identical(other.via, via) || other.via == via)&&(identical(other.targetMemberId, targetMemberId) || other.targetMemberId == targetMemberId)&&(identical(other.targetName, targetName) || other.targetName == targetName)&&(identical(other.activityTitle, activityTitle) || other.activityTitle == activityTitle)&&(identical(other.placeName, placeName) || other.placeName == placeName)&&(identical(other.placeArea, placeArea) || other.placeArea == placeArea)&&(identical(other.dayNumber, dayNumber) || other.dayNumber == dayNumber)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.previousStartTime, previousStartTime) || other.previousStartTime == previousStartTime)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.verified, verified) || other.verified == verified)&&(identical(other.pointsEarned, pointsEarned) || other.pointsEarned == pointsEarned)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.category, category) || other.category == category)&&(identical(other.description, description) || other.description == description)&&(identical(other.splitType, splitType) || other.splitType == splitType)&&(identical(other.splitCount, splitCount) || other.splitCount == splitCount)&&(identical(other.payerMemberId, payerMemberId) || other.payerMemberId == payerMemberId)&&(identical(other.payerName, payerName) || other.payerName == payerName)&&(identical(other.debtorMemberId, debtorMemberId) || other.debtorMemberId == debtorMemberId)&&(identical(other.debtorName, debtorName) || other.debtorName == debtorName)&&const DeepCollectionEquality().equals(other.memoryIds, _memoryIds)&&const DeepCollectionEquality().equals(other.photoUrls, _photoUrls)&&(identical(other.photoCount, photoCount) || other.photoCount == photoCount)&&(identical(other.caption, caption) || other.caption == caption));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hashAll([runtimeType,tripName,startDate,endDate,destinationCount,via,targetMemberId,targetName,activityTitle,placeName,placeArea,dayNumber,startTime,previousStartTime,latitude,longitude,imageUrl,verified,pointsEarned,amount,currency,category,description,splitType,splitCount,payerMemberId,payerName,debtorMemberId,debtorName,const DeepCollectionEquality().hash(_memoryIds),const DeepCollectionEquality().hash(_photoUrls),photoCount,caption]);
}

@override
String toString() {
    return 'TripTimelineEntryMetadata(tripName: $tripName, startDate: $startDate, endDate: $endDate, destinationCount: $destinationCount, via: $via, targetMemberId: $targetMemberId, targetName: $targetName, activityTitle: $activityTitle, placeName: $placeName, placeArea: $placeArea, dayNumber: $dayNumber, startTime: $startTime, previousStartTime: $previousStartTime, latitude: $latitude, longitude: $longitude, imageUrl: $imageUrl, verified: $verified, pointsEarned: $pointsEarned, amount: $amount, currency: $currency, category: $category, description: $description, splitType: $splitType, splitCount: $splitCount, payerMemberId: $payerMemberId, payerName: $payerName, debtorMemberId: $debtorMemberId, debtorName: $debtorName, memoryIds: $memoryIds, photoUrls: $photoUrls, photoCount: $photoCount, caption: $caption)';
}


}

/// @nodoc
abstract mixin class _$TripTimelineEntryMetadataCopyWith<$Res> implements $TripTimelineEntryMetadataCopyWith<$Res> {
  factory _$TripTimelineEntryMetadataCopyWith(_TripTimelineEntryMetadata value, $Res Function(_TripTimelineEntryMetadata) _then) = __$TripTimelineEntryMetadataCopyWithImpl;
@override @useResult
$Res call({
 String? tripName, DateTime? startDate, DateTime? endDate, int? destinationCount,@JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue) TripTimelineJoinVia? via, String? targetMemberId, String? targetName, String? activityTitle, String? placeName, String? placeArea, int? dayNumber, DateTime? startTime, DateTime? previousStartTime, double? latitude, double? longitude, String? imageUrl, bool verified, int? pointsEarned,@JsonKey(fromJson: _moneyFromJson) double? amount, String currency, String? category, String? description,@JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue) TripTimelineSplitType? splitType, int? splitCount, String? payerMemberId, String? payerName, String? debtorMemberId, String? debtorName, List<String> memoryIds, List<String> photoUrls, int? photoCount, String? caption
});




}
/// @nodoc
class __$TripTimelineEntryMetadataCopyWithImpl<$Res>
    implements _$TripTimelineEntryMetadataCopyWith<$Res> {
  __$TripTimelineEntryMetadataCopyWithImpl(this._self, this._then);

  final _TripTimelineEntryMetadata _self;
  final $Res Function(_TripTimelineEntryMetadata) _then;

/// Create a copy of TripTimelineEntryMetadata
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? tripName = freezed,Object? startDate = freezed,Object? endDate = freezed,Object? destinationCount = freezed,Object? via = freezed,Object? targetMemberId = freezed,Object? targetName = freezed,Object? activityTitle = freezed,Object? placeName = freezed,Object? placeArea = freezed,Object? dayNumber = freezed,Object? startTime = freezed,Object? previousStartTime = freezed,Object? latitude = freezed,Object? longitude = freezed,Object? imageUrl = freezed,Object? verified = null,Object? pointsEarned = freezed,Object? amount = freezed,Object? currency = null,Object? category = freezed,Object? description = freezed,Object? splitType = freezed,Object? splitCount = freezed,Object? payerMemberId = freezed,Object? payerName = freezed,Object? debtorMemberId = freezed,Object? debtorName = freezed,Object? memoryIds = null,Object? photoUrls = null,Object? photoCount = freezed,Object? caption = freezed,}) {
  return _then(_TripTimelineEntryMetadata(
tripName: freezed == tripName ? _self.tripName : tripName // ignore: cast_nullable_to_non_nullable
as String?,startDate: freezed == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime?,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime?,destinationCount: freezed == destinationCount ? _self.destinationCount : destinationCount // ignore: cast_nullable_to_non_nullable
as int?,via: freezed == via ? _self.via : via // ignore: cast_nullable_to_non_nullable
as TripTimelineJoinVia?,targetMemberId: freezed == targetMemberId ? _self.targetMemberId : targetMemberId // ignore: cast_nullable_to_non_nullable
as String?,targetName: freezed == targetName ? _self.targetName : targetName // ignore: cast_nullable_to_non_nullable
as String?,activityTitle: freezed == activityTitle ? _self.activityTitle : activityTitle // ignore: cast_nullable_to_non_nullable
as String?,placeName: freezed == placeName ? _self.placeName : placeName // ignore: cast_nullable_to_non_nullable
as String?,placeArea: freezed == placeArea ? _self.placeArea : placeArea // ignore: cast_nullable_to_non_nullable
as String?,dayNumber: freezed == dayNumber ? _self.dayNumber : dayNumber // ignore: cast_nullable_to_non_nullable
as int?,startTime: freezed == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as DateTime?,previousStartTime: freezed == previousStartTime ? _self.previousStartTime : previousStartTime // ignore: cast_nullable_to_non_nullable
as DateTime?,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,verified: null == verified ? _self.verified : verified // ignore: cast_nullable_to_non_nullable
as bool,pointsEarned: freezed == pointsEarned ? _self.pointsEarned : pointsEarned // ignore: cast_nullable_to_non_nullable
as int?,amount: freezed == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double?,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,splitType: freezed == splitType ? _self.splitType : splitType // ignore: cast_nullable_to_non_nullable
as TripTimelineSplitType?,splitCount: freezed == splitCount ? _self.splitCount : splitCount // ignore: cast_nullable_to_non_nullable
as int?,payerMemberId: freezed == payerMemberId ? _self.payerMemberId : payerMemberId // ignore: cast_nullable_to_non_nullable
as String?,payerName: freezed == payerName ? _self.payerName : payerName // ignore: cast_nullable_to_non_nullable
as String?,debtorMemberId: freezed == debtorMemberId ? _self.debtorMemberId : debtorMemberId // ignore: cast_nullable_to_non_nullable
as String?,debtorName: freezed == debtorName ? _self.debtorName : debtorName // ignore: cast_nullable_to_non_nullable
as String?,memoryIds: null == memoryIds ? _self._memoryIds : memoryIds // ignore: cast_nullable_to_non_nullable
as List<String>,photoUrls: null == photoUrls ? _self._photoUrls : photoUrls // ignore: cast_nullable_to_non_nullable
as List<String>,photoCount: freezed == photoCount ? _self.photoCount : photoCount // ignore: cast_nullable_to_non_nullable
as int?,caption: freezed == caption ? _self.caption : caption // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
