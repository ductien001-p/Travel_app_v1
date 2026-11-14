// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'trip_join_request_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TripJoinRequestsPage {

@JsonKey(name: 'data') List<TripJoinRequest> get items; TripJoinRequestsMeta get meta;
/// Create a copy of TripJoinRequestsPage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TripJoinRequestsPageCopyWith<TripJoinRequestsPage> get copyWith => _$TripJoinRequestsPageCopyWithImpl<TripJoinRequestsPage>(this as TripJoinRequestsPage, _$identity);

  /// Serializes this TripJoinRequestsPage to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TripJoinRequestsPage;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TripJoinRequestsPage&&const DeepCollectionEquality().equals(other.items, _this.items)&&(identical(other.meta, _this.meta) || other.meta == _this.meta));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TripJoinRequestsPage;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.items),_this.meta);
}

@override
String toString() {
  final _this = this as TripJoinRequestsPage;
  return 'TripJoinRequestsPage(items: ${_this.items}, meta: ${_this.meta})';
}


}

/// @nodoc
abstract mixin class $TripJoinRequestsPageCopyWith<$Res>  {
  factory $TripJoinRequestsPageCopyWith(TripJoinRequestsPage value, $Res Function(TripJoinRequestsPage) _then) = _$TripJoinRequestsPageCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'data') List<TripJoinRequest> items, TripJoinRequestsMeta meta
});


$TripJoinRequestsMetaCopyWith<$Res> get meta;

}
/// @nodoc
class _$TripJoinRequestsPageCopyWithImpl<$Res>
    implements $TripJoinRequestsPageCopyWith<$Res> {
  _$TripJoinRequestsPageCopyWithImpl(this._self, this._then);

  final TripJoinRequestsPage _self;
  final $Res Function(TripJoinRequestsPage) _then;

/// Create a copy of TripJoinRequestsPage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,Object? meta = null,}) {
  return _then(TripJoinRequestsPage(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<TripJoinRequest>,meta: null == meta ? _self.meta : meta // ignore: cast_nullable_to_non_nullable
as TripJoinRequestsMeta,
  ));
}
/// Create a copy of TripJoinRequestsPage
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TripJoinRequestsMetaCopyWith<$Res> get meta {
  
  return $TripJoinRequestsMetaCopyWith<$Res>(_self.meta, (value) {
    return _then(_self.copyWith(meta: value));
  });
}
}


/// Adds pattern-matching-related methods to [TripJoinRequestsPage].
extension TripJoinRequestsPagePatterns on TripJoinRequestsPage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TripJoinRequestsPage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TripJoinRequestsPage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TripJoinRequestsPage value)  $default,){
final _that = this;
switch (_that) {
case _TripJoinRequestsPage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TripJoinRequestsPage value)?  $default,){
final _that = this;
switch (_that) {
case _TripJoinRequestsPage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'data')  List<TripJoinRequest> items,  TripJoinRequestsMeta meta)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TripJoinRequestsPage() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'data')  List<TripJoinRequest> items,  TripJoinRequestsMeta meta)  $default,) {final _that = this;
switch (_that) {
case _TripJoinRequestsPage():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'data')  List<TripJoinRequest> items,  TripJoinRequestsMeta meta)?  $default,) {final _that = this;
switch (_that) {
case _TripJoinRequestsPage() when $default != null:
return $default(_that.items,_that.meta);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TripJoinRequestsPage implements TripJoinRequestsPage {
  const _TripJoinRequestsPage({@JsonKey(name: 'data')  List<TripJoinRequest> items = const <TripJoinRequest>[], required this.meta}): _items = items;
  factory _TripJoinRequestsPage.fromJson(Map<String, dynamic> json) => _$TripJoinRequestsPageFromJson(json);

 final  List<TripJoinRequest> _items;
@override@JsonKey(name: 'data') List<TripJoinRequest> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override final  TripJoinRequestsMeta meta;

/// Create a copy of TripJoinRequestsPage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TripJoinRequestsPageCopyWith<_TripJoinRequestsPage> get copyWith => __$TripJoinRequestsPageCopyWithImpl<_TripJoinRequestsPage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TripJoinRequestsPageToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TripJoinRequestsPage&&const DeepCollectionEquality().equals(other.items, _items)&&(identical(other.meta, meta) || other.meta == meta));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),meta);
}

@override
String toString() {
    return 'TripJoinRequestsPage(items: $items, meta: $meta)';
}


}

/// @nodoc
abstract mixin class _$TripJoinRequestsPageCopyWith<$Res> implements $TripJoinRequestsPageCopyWith<$Res> {
  factory _$TripJoinRequestsPageCopyWith(_TripJoinRequestsPage value, $Res Function(_TripJoinRequestsPage) _then) = __$TripJoinRequestsPageCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'data') List<TripJoinRequest> items, TripJoinRequestsMeta meta
});


@override $TripJoinRequestsMetaCopyWith<$Res> get meta;

}
/// @nodoc
class __$TripJoinRequestsPageCopyWithImpl<$Res>
    implements _$TripJoinRequestsPageCopyWith<$Res> {
  __$TripJoinRequestsPageCopyWithImpl(this._self, this._then);

  final _TripJoinRequestsPage _self;
  final $Res Function(_TripJoinRequestsPage) _then;

/// Create a copy of TripJoinRequestsPage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,Object? meta = null,}) {
  return _then(_TripJoinRequestsPage(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<TripJoinRequest>,meta: null == meta ? _self.meta : meta // ignore: cast_nullable_to_non_nullable
as TripJoinRequestsMeta,
  ));
}

/// Create a copy of TripJoinRequestsPage
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TripJoinRequestsMetaCopyWith<$Res> get meta {
  
  return $TripJoinRequestsMetaCopyWith<$Res>(_self.meta, (value) {
    return _then(_self.copyWith(meta: value));
  });
}
}


/// @nodoc
mixin _$TripJoinRequestsMeta {

 String? get nextCursor; bool get hasMore;/// Requests of the whole trip per status, ignoring the `status` filter so
/// every tab keeps its count.
 TripJoinRequestCounts get counts;
/// Create a copy of TripJoinRequestsMeta
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TripJoinRequestsMetaCopyWith<TripJoinRequestsMeta> get copyWith => _$TripJoinRequestsMetaCopyWithImpl<TripJoinRequestsMeta>(this as TripJoinRequestsMeta, _$identity);

  /// Serializes this TripJoinRequestsMeta to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TripJoinRequestsMeta;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TripJoinRequestsMeta&&(identical(other.nextCursor, _this.nextCursor) || other.nextCursor == _this.nextCursor)&&(identical(other.hasMore, _this.hasMore) || other.hasMore == _this.hasMore)&&(identical(other.counts, _this.counts) || other.counts == _this.counts));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TripJoinRequestsMeta;
  return Object.hash(runtimeType,_this.nextCursor,_this.hasMore,_this.counts);
}

@override
String toString() {
  final _this = this as TripJoinRequestsMeta;
  return 'TripJoinRequestsMeta(nextCursor: ${_this.nextCursor}, hasMore: ${_this.hasMore}, counts: ${_this.counts})';
}


}

/// @nodoc
abstract mixin class $TripJoinRequestsMetaCopyWith<$Res>  {
  factory $TripJoinRequestsMetaCopyWith(TripJoinRequestsMeta value, $Res Function(TripJoinRequestsMeta) _then) = _$TripJoinRequestsMetaCopyWithImpl;
@useResult
$Res call({
 String? nextCursor, bool hasMore, TripJoinRequestCounts counts
});


$TripJoinRequestCountsCopyWith<$Res> get counts;

}
/// @nodoc
class _$TripJoinRequestsMetaCopyWithImpl<$Res>
    implements $TripJoinRequestsMetaCopyWith<$Res> {
  _$TripJoinRequestsMetaCopyWithImpl(this._self, this._then);

  final TripJoinRequestsMeta _self;
  final $Res Function(TripJoinRequestsMeta) _then;

/// Create a copy of TripJoinRequestsMeta
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? nextCursor = freezed,Object? hasMore = null,Object? counts = null,}) {
  return _then(TripJoinRequestsMeta(
nextCursor: freezed == nextCursor ? _self.nextCursor : nextCursor // ignore: cast_nullable_to_non_nullable
as String?,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,counts: null == counts ? _self.counts : counts // ignore: cast_nullable_to_non_nullable
as TripJoinRequestCounts,
  ));
}
/// Create a copy of TripJoinRequestsMeta
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TripJoinRequestCountsCopyWith<$Res> get counts {
  
  return $TripJoinRequestCountsCopyWith<$Res>(_self.counts, (value) {
    return _then(_self.copyWith(counts: value));
  });
}
}


/// Adds pattern-matching-related methods to [TripJoinRequestsMeta].
extension TripJoinRequestsMetaPatterns on TripJoinRequestsMeta {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TripJoinRequestsMeta value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TripJoinRequestsMeta() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TripJoinRequestsMeta value)  $default,){
final _that = this;
switch (_that) {
case _TripJoinRequestsMeta():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TripJoinRequestsMeta value)?  $default,){
final _that = this;
switch (_that) {
case _TripJoinRequestsMeta() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? nextCursor,  bool hasMore,  TripJoinRequestCounts counts)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TripJoinRequestsMeta() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? nextCursor,  bool hasMore,  TripJoinRequestCounts counts)  $default,) {final _that = this;
switch (_that) {
case _TripJoinRequestsMeta():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? nextCursor,  bool hasMore,  TripJoinRequestCounts counts)?  $default,) {final _that = this;
switch (_that) {
case _TripJoinRequestsMeta() when $default != null:
return $default(_that.nextCursor,_that.hasMore,_that.counts);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TripJoinRequestsMeta implements TripJoinRequestsMeta {
  const _TripJoinRequestsMeta({this.nextCursor, this.hasMore = false, this.counts = const TripJoinRequestCounts()});
  factory _TripJoinRequestsMeta.fromJson(Map<String, dynamic> json) => _$TripJoinRequestsMetaFromJson(json);

@override final  String? nextCursor;
@override@JsonKey() final  bool hasMore;
/// Requests of the whole trip per status, ignoring the `status` filter so
/// every tab keeps its count.
@override@JsonKey() final  TripJoinRequestCounts counts;

/// Create a copy of TripJoinRequestsMeta
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TripJoinRequestsMetaCopyWith<_TripJoinRequestsMeta> get copyWith => __$TripJoinRequestsMetaCopyWithImpl<_TripJoinRequestsMeta>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TripJoinRequestsMetaToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TripJoinRequestsMeta&&(identical(other.nextCursor, nextCursor) || other.nextCursor == nextCursor)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.counts, counts) || other.counts == counts));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,nextCursor,hasMore,counts);
}

@override
String toString() {
    return 'TripJoinRequestsMeta(nextCursor: $nextCursor, hasMore: $hasMore, counts: $counts)';
}


}

/// @nodoc
abstract mixin class _$TripJoinRequestsMetaCopyWith<$Res> implements $TripJoinRequestsMetaCopyWith<$Res> {
  factory _$TripJoinRequestsMetaCopyWith(_TripJoinRequestsMeta value, $Res Function(_TripJoinRequestsMeta) _then) = __$TripJoinRequestsMetaCopyWithImpl;
@override @useResult
$Res call({
 String? nextCursor, bool hasMore, TripJoinRequestCounts counts
});


@override $TripJoinRequestCountsCopyWith<$Res> get counts;

}
/// @nodoc
class __$TripJoinRequestsMetaCopyWithImpl<$Res>
    implements _$TripJoinRequestsMetaCopyWith<$Res> {
  __$TripJoinRequestsMetaCopyWithImpl(this._self, this._then);

  final _TripJoinRequestsMeta _self;
  final $Res Function(_TripJoinRequestsMeta) _then;

/// Create a copy of TripJoinRequestsMeta
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? nextCursor = freezed,Object? hasMore = null,Object? counts = null,}) {
  return _then(_TripJoinRequestsMeta(
nextCursor: freezed == nextCursor ? _self.nextCursor : nextCursor // ignore: cast_nullable_to_non_nullable
as String?,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,counts: null == counts ? _self.counts : counts // ignore: cast_nullable_to_non_nullable
as TripJoinRequestCounts,
  ));
}

/// Create a copy of TripJoinRequestsMeta
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TripJoinRequestCountsCopyWith<$Res> get counts {
  
  return $TripJoinRequestCountsCopyWith<$Res>(_self.counts, (value) {
    return _then(_self.copyWith(counts: value));
  });
}
}


/// @nodoc
mixin _$TripJoinRequestCounts {

 int get pending; int get approved; int get rejected;
/// Create a copy of TripJoinRequestCounts
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TripJoinRequestCountsCopyWith<TripJoinRequestCounts> get copyWith => _$TripJoinRequestCountsCopyWithImpl<TripJoinRequestCounts>(this as TripJoinRequestCounts, _$identity);

  /// Serializes this TripJoinRequestCounts to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TripJoinRequestCounts;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TripJoinRequestCounts&&(identical(other.pending, _this.pending) || other.pending == _this.pending)&&(identical(other.approved, _this.approved) || other.approved == _this.approved)&&(identical(other.rejected, _this.rejected) || other.rejected == _this.rejected));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TripJoinRequestCounts;
  return Object.hash(runtimeType,_this.pending,_this.approved,_this.rejected);
}

@override
String toString() {
  final _this = this as TripJoinRequestCounts;
  return 'TripJoinRequestCounts(pending: ${_this.pending}, approved: ${_this.approved}, rejected: ${_this.rejected})';
}


}

/// @nodoc
abstract mixin class $TripJoinRequestCountsCopyWith<$Res>  {
  factory $TripJoinRequestCountsCopyWith(TripJoinRequestCounts value, $Res Function(TripJoinRequestCounts) _then) = _$TripJoinRequestCountsCopyWithImpl;
@useResult
$Res call({
 int pending, int approved, int rejected
});




}
/// @nodoc
class _$TripJoinRequestCountsCopyWithImpl<$Res>
    implements $TripJoinRequestCountsCopyWith<$Res> {
  _$TripJoinRequestCountsCopyWithImpl(this._self, this._then);

  final TripJoinRequestCounts _self;
  final $Res Function(TripJoinRequestCounts) _then;

/// Create a copy of TripJoinRequestCounts
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? pending = null,Object? approved = null,Object? rejected = null,}) {
  return _then(TripJoinRequestCounts(
pending: null == pending ? _self.pending : pending // ignore: cast_nullable_to_non_nullable
as int,approved: null == approved ? _self.approved : approved // ignore: cast_nullable_to_non_nullable
as int,rejected: null == rejected ? _self.rejected : rejected // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [TripJoinRequestCounts].
extension TripJoinRequestCountsPatterns on TripJoinRequestCounts {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TripJoinRequestCounts value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TripJoinRequestCounts() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TripJoinRequestCounts value)  $default,){
final _that = this;
switch (_that) {
case _TripJoinRequestCounts():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TripJoinRequestCounts value)?  $default,){
final _that = this;
switch (_that) {
case _TripJoinRequestCounts() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int pending,  int approved,  int rejected)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TripJoinRequestCounts() when $default != null:
return $default(_that.pending,_that.approved,_that.rejected);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int pending,  int approved,  int rejected)  $default,) {final _that = this;
switch (_that) {
case _TripJoinRequestCounts():
return $default(_that.pending,_that.approved,_that.rejected);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int pending,  int approved,  int rejected)?  $default,) {final _that = this;
switch (_that) {
case _TripJoinRequestCounts() when $default != null:
return $default(_that.pending,_that.approved,_that.rejected);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TripJoinRequestCounts extends TripJoinRequestCounts {
  const _TripJoinRequestCounts({this.pending = 0, this.approved = 0, this.rejected = 0}): super._();
  factory _TripJoinRequestCounts.fromJson(Map<String, dynamic> json) => _$TripJoinRequestCountsFromJson(json);

@override@JsonKey() final  int pending;
@override@JsonKey() final  int approved;
@override@JsonKey() final  int rejected;

/// Create a copy of TripJoinRequestCounts
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TripJoinRequestCountsCopyWith<_TripJoinRequestCounts> get copyWith => __$TripJoinRequestCountsCopyWithImpl<_TripJoinRequestCounts>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TripJoinRequestCountsToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TripJoinRequestCounts&&(identical(other.pending, pending) || other.pending == pending)&&(identical(other.approved, approved) || other.approved == approved)&&(identical(other.rejected, rejected) || other.rejected == rejected));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,pending,approved,rejected);
}

@override
String toString() {
    return 'TripJoinRequestCounts(pending: $pending, approved: $approved, rejected: $rejected)';
}


}

/// @nodoc
abstract mixin class _$TripJoinRequestCountsCopyWith<$Res> implements $TripJoinRequestCountsCopyWith<$Res> {
  factory _$TripJoinRequestCountsCopyWith(_TripJoinRequestCounts value, $Res Function(_TripJoinRequestCounts) _then) = __$TripJoinRequestCountsCopyWithImpl;
@override @useResult
$Res call({
 int pending, int approved, int rejected
});




}
/// @nodoc
class __$TripJoinRequestCountsCopyWithImpl<$Res>
    implements _$TripJoinRequestCountsCopyWith<$Res> {
  __$TripJoinRequestCountsCopyWithImpl(this._self, this._then);

  final _TripJoinRequestCounts _self;
  final $Res Function(_TripJoinRequestCounts) _then;

/// Create a copy of TripJoinRequestCounts
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? pending = null,Object? approved = null,Object? rejected = null,}) {
  return _then(_TripJoinRequestCounts(
pending: null == pending ? _self.pending : pending // ignore: cast_nullable_to_non_nullable
as int,approved: null == approved ? _self.approved : approved // ignore: cast_nullable_to_non_nullable
as int,rejected: null == rejected ? _self.rejected : rejected // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$TripJoinRequest {

 String get id; String get tripId; TripJoinRequestStatus get status; TripJoinRequester get requester;/// Note the requester wrote to the trip.
 String? get message;/// Highest travel DNA of the requester, as a display label.
 String? get travelPersona;@JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue) TripJoinRequestPersonaType? get personaType;/// 0..100 fit between the requester and the trip; null when unknown.
 int? get matchScore;/// Why the requester fits the trip, written by the matchmaker.
 String? get matchNote; DateTime get createdAt; DateTime? get decidedAt;
/// Create a copy of TripJoinRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TripJoinRequestCopyWith<TripJoinRequest> get copyWith => _$TripJoinRequestCopyWithImpl<TripJoinRequest>(this as TripJoinRequest, _$identity);

  /// Serializes this TripJoinRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TripJoinRequest;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TripJoinRequest&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.tripId, _this.tripId) || other.tripId == _this.tripId)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.requester, _this.requester) || other.requester == _this.requester)&&(identical(other.message, _this.message) || other.message == _this.message)&&(identical(other.travelPersona, _this.travelPersona) || other.travelPersona == _this.travelPersona)&&(identical(other.personaType, _this.personaType) || other.personaType == _this.personaType)&&(identical(other.matchScore, _this.matchScore) || other.matchScore == _this.matchScore)&&(identical(other.matchNote, _this.matchNote) || other.matchNote == _this.matchNote)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.decidedAt, _this.decidedAt) || other.decidedAt == _this.decidedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TripJoinRequest;
  return Object.hash(runtimeType,_this.id,_this.tripId,_this.status,_this.requester,_this.message,_this.travelPersona,_this.personaType,_this.matchScore,_this.matchNote,_this.createdAt,_this.decidedAt);
}

@override
String toString() {
  final _this = this as TripJoinRequest;
  return 'TripJoinRequest(id: ${_this.id}, tripId: ${_this.tripId}, status: ${_this.status}, requester: ${_this.requester}, message: ${_this.message}, travelPersona: ${_this.travelPersona}, personaType: ${_this.personaType}, matchScore: ${_this.matchScore}, matchNote: ${_this.matchNote}, createdAt: ${_this.createdAt}, decidedAt: ${_this.decidedAt})';
}


}

/// @nodoc
abstract mixin class $TripJoinRequestCopyWith<$Res>  {
  factory $TripJoinRequestCopyWith(TripJoinRequest value, $Res Function(TripJoinRequest) _then) = _$TripJoinRequestCopyWithImpl;
@useResult
$Res call({
 String id, String tripId, TripJoinRequestStatus status, TripJoinRequester requester, String? message, String? travelPersona,@JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue) TripJoinRequestPersonaType? personaType, int? matchScore, String? matchNote, DateTime createdAt, DateTime? decidedAt
});


$TripJoinRequesterCopyWith<$Res> get requester;

}
/// @nodoc
class _$TripJoinRequestCopyWithImpl<$Res>
    implements $TripJoinRequestCopyWith<$Res> {
  _$TripJoinRequestCopyWithImpl(this._self, this._then);

  final TripJoinRequest _self;
  final $Res Function(TripJoinRequest) _then;

/// Create a copy of TripJoinRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? tripId = null,Object? status = null,Object? requester = null,Object? message = freezed,Object? travelPersona = freezed,Object? personaType = freezed,Object? matchScore = freezed,Object? matchNote = freezed,Object? createdAt = null,Object? decidedAt = freezed,}) {
  return _then(TripJoinRequest(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,tripId: null == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TripJoinRequestStatus,requester: null == requester ? _self.requester : requester // ignore: cast_nullable_to_non_nullable
as TripJoinRequester,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,travelPersona: freezed == travelPersona ? _self.travelPersona : travelPersona // ignore: cast_nullable_to_non_nullable
as String?,personaType: freezed == personaType ? _self.personaType : personaType // ignore: cast_nullable_to_non_nullable
as TripJoinRequestPersonaType?,matchScore: freezed == matchScore ? _self.matchScore : matchScore // ignore: cast_nullable_to_non_nullable
as int?,matchNote: freezed == matchNote ? _self.matchNote : matchNote // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,decidedAt: freezed == decidedAt ? _self.decidedAt : decidedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}
/// Create a copy of TripJoinRequest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TripJoinRequesterCopyWith<$Res> get requester {
  
  return $TripJoinRequesterCopyWith<$Res>(_self.requester, (value) {
    return _then(_self.copyWith(requester: value));
  });
}
}


/// Adds pattern-matching-related methods to [TripJoinRequest].
extension TripJoinRequestPatterns on TripJoinRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TripJoinRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TripJoinRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TripJoinRequest value)  $default,){
final _that = this;
switch (_that) {
case _TripJoinRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TripJoinRequest value)?  $default,){
final _that = this;
switch (_that) {
case _TripJoinRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String tripId,  TripJoinRequestStatus status,  TripJoinRequester requester,  String? message,  String? travelPersona, @JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue)  TripJoinRequestPersonaType? personaType,  int? matchScore,  String? matchNote,  DateTime createdAt,  DateTime? decidedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TripJoinRequest() when $default != null:
return $default(_that.id,_that.tripId,_that.status,_that.requester,_that.message,_that.travelPersona,_that.personaType,_that.matchScore,_that.matchNote,_that.createdAt,_that.decidedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String tripId,  TripJoinRequestStatus status,  TripJoinRequester requester,  String? message,  String? travelPersona, @JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue)  TripJoinRequestPersonaType? personaType,  int? matchScore,  String? matchNote,  DateTime createdAt,  DateTime? decidedAt)  $default,) {final _that = this;
switch (_that) {
case _TripJoinRequest():
return $default(_that.id,_that.tripId,_that.status,_that.requester,_that.message,_that.travelPersona,_that.personaType,_that.matchScore,_that.matchNote,_that.createdAt,_that.decidedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String tripId,  TripJoinRequestStatus status,  TripJoinRequester requester,  String? message,  String? travelPersona, @JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue)  TripJoinRequestPersonaType? personaType,  int? matchScore,  String? matchNote,  DateTime createdAt,  DateTime? decidedAt)?  $default,) {final _that = this;
switch (_that) {
case _TripJoinRequest() when $default != null:
return $default(_that.id,_that.tripId,_that.status,_that.requester,_that.message,_that.travelPersona,_that.personaType,_that.matchScore,_that.matchNote,_that.createdAt,_that.decidedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TripJoinRequest implements TripJoinRequest {
  const _TripJoinRequest({required this.id, required this.tripId, required this.status, required this.requester, this.message, this.travelPersona, @JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue) this.personaType, this.matchScore, this.matchNote, required this.createdAt, this.decidedAt});
  factory _TripJoinRequest.fromJson(Map<String, dynamic> json) => _$TripJoinRequestFromJson(json);

@override final  String id;
@override final  String tripId;
@override final  TripJoinRequestStatus status;
@override final  TripJoinRequester requester;
/// Note the requester wrote to the trip.
@override final  String? message;
/// Highest travel DNA of the requester, as a display label.
@override final  String? travelPersona;
@override@JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue) final  TripJoinRequestPersonaType? personaType;
/// 0..100 fit between the requester and the trip; null when unknown.
@override final  int? matchScore;
/// Why the requester fits the trip, written by the matchmaker.
@override final  String? matchNote;
@override final  DateTime createdAt;
@override final  DateTime? decidedAt;

/// Create a copy of TripJoinRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TripJoinRequestCopyWith<_TripJoinRequest> get copyWith => __$TripJoinRequestCopyWithImpl<_TripJoinRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TripJoinRequestToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TripJoinRequest&&(identical(other.id, id) || other.id == id)&&(identical(other.tripId, tripId) || other.tripId == tripId)&&(identical(other.status, status) || other.status == status)&&(identical(other.requester, requester) || other.requester == requester)&&(identical(other.message, message) || other.message == message)&&(identical(other.travelPersona, travelPersona) || other.travelPersona == travelPersona)&&(identical(other.personaType, personaType) || other.personaType == personaType)&&(identical(other.matchScore, matchScore) || other.matchScore == matchScore)&&(identical(other.matchNote, matchNote) || other.matchNote == matchNote)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.decidedAt, decidedAt) || other.decidedAt == decidedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,tripId,status,requester,message,travelPersona,personaType,matchScore,matchNote,createdAt,decidedAt);
}

@override
String toString() {
    return 'TripJoinRequest(id: $id, tripId: $tripId, status: $status, requester: $requester, message: $message, travelPersona: $travelPersona, personaType: $personaType, matchScore: $matchScore, matchNote: $matchNote, createdAt: $createdAt, decidedAt: $decidedAt)';
}


}

/// @nodoc
abstract mixin class _$TripJoinRequestCopyWith<$Res> implements $TripJoinRequestCopyWith<$Res> {
  factory _$TripJoinRequestCopyWith(_TripJoinRequest value, $Res Function(_TripJoinRequest) _then) = __$TripJoinRequestCopyWithImpl;
@override @useResult
$Res call({
 String id, String tripId, TripJoinRequestStatus status, TripJoinRequester requester, String? message, String? travelPersona,@JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue) TripJoinRequestPersonaType? personaType, int? matchScore, String? matchNote, DateTime createdAt, DateTime? decidedAt
});


@override $TripJoinRequesterCopyWith<$Res> get requester;

}
/// @nodoc
class __$TripJoinRequestCopyWithImpl<$Res>
    implements _$TripJoinRequestCopyWith<$Res> {
  __$TripJoinRequestCopyWithImpl(this._self, this._then);

  final _TripJoinRequest _self;
  final $Res Function(_TripJoinRequest) _then;

/// Create a copy of TripJoinRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? tripId = null,Object? status = null,Object? requester = null,Object? message = freezed,Object? travelPersona = freezed,Object? personaType = freezed,Object? matchScore = freezed,Object? matchNote = freezed,Object? createdAt = null,Object? decidedAt = freezed,}) {
  return _then(_TripJoinRequest(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,tripId: null == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TripJoinRequestStatus,requester: null == requester ? _self.requester : requester // ignore: cast_nullable_to_non_nullable
as TripJoinRequester,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,travelPersona: freezed == travelPersona ? _self.travelPersona : travelPersona // ignore: cast_nullable_to_non_nullable
as String?,personaType: freezed == personaType ? _self.personaType : personaType // ignore: cast_nullable_to_non_nullable
as TripJoinRequestPersonaType?,matchScore: freezed == matchScore ? _self.matchScore : matchScore // ignore: cast_nullable_to_non_nullable
as int?,matchNote: freezed == matchNote ? _self.matchNote : matchNote // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,decidedAt: freezed == decidedAt ? _self.decidedAt : decidedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

/// Create a copy of TripJoinRequest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TripJoinRequesterCopyWith<$Res> get requester {
  
  return $TripJoinRequesterCopyWith<$Res>(_self.requester, (value) {
    return _then(_self.copyWith(requester: value));
  });
}
}


/// @nodoc
mixin _$TripJoinRequester {

 String get id; String get displayName; String get username; String? get avatarUrl; bool get isVerified; bool get isOnline;
/// Create a copy of TripJoinRequester
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TripJoinRequesterCopyWith<TripJoinRequester> get copyWith => _$TripJoinRequesterCopyWithImpl<TripJoinRequester>(this as TripJoinRequester, _$identity);

  /// Serializes this TripJoinRequester to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TripJoinRequester;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TripJoinRequester&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.displayName, _this.displayName) || other.displayName == _this.displayName)&&(identical(other.username, _this.username) || other.username == _this.username)&&(identical(other.avatarUrl, _this.avatarUrl) || other.avatarUrl == _this.avatarUrl)&&(identical(other.isVerified, _this.isVerified) || other.isVerified == _this.isVerified)&&(identical(other.isOnline, _this.isOnline) || other.isOnline == _this.isOnline));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TripJoinRequester;
  return Object.hash(runtimeType,_this.id,_this.displayName,_this.username,_this.avatarUrl,_this.isVerified,_this.isOnline);
}

@override
String toString() {
  final _this = this as TripJoinRequester;
  return 'TripJoinRequester(id: ${_this.id}, displayName: ${_this.displayName}, username: ${_this.username}, avatarUrl: ${_this.avatarUrl}, isVerified: ${_this.isVerified}, isOnline: ${_this.isOnline})';
}


}

/// @nodoc
abstract mixin class $TripJoinRequesterCopyWith<$Res>  {
  factory $TripJoinRequesterCopyWith(TripJoinRequester value, $Res Function(TripJoinRequester) _then) = _$TripJoinRequesterCopyWithImpl;
@useResult
$Res call({
 String id, String displayName, String username, String? avatarUrl, bool isVerified, bool isOnline
});




}
/// @nodoc
class _$TripJoinRequesterCopyWithImpl<$Res>
    implements $TripJoinRequesterCopyWith<$Res> {
  _$TripJoinRequesterCopyWithImpl(this._self, this._then);

  final TripJoinRequester _self;
  final $Res Function(TripJoinRequester) _then;

/// Create a copy of TripJoinRequester
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? displayName = null,Object? username = null,Object? avatarUrl = freezed,Object? isVerified = null,Object? isOnline = null,}) {
  return _then(TripJoinRequester(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,isVerified: null == isVerified ? _self.isVerified : isVerified // ignore: cast_nullable_to_non_nullable
as bool,isOnline: null == isOnline ? _self.isOnline : isOnline // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [TripJoinRequester].
extension TripJoinRequesterPatterns on TripJoinRequester {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TripJoinRequester value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TripJoinRequester() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TripJoinRequester value)  $default,){
final _that = this;
switch (_that) {
case _TripJoinRequester():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TripJoinRequester value)?  $default,){
final _that = this;
switch (_that) {
case _TripJoinRequester() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String displayName,  String username,  String? avatarUrl,  bool isVerified,  bool isOnline)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TripJoinRequester() when $default != null:
return $default(_that.id,_that.displayName,_that.username,_that.avatarUrl,_that.isVerified,_that.isOnline);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String displayName,  String username,  String? avatarUrl,  bool isVerified,  bool isOnline)  $default,) {final _that = this;
switch (_that) {
case _TripJoinRequester():
return $default(_that.id,_that.displayName,_that.username,_that.avatarUrl,_that.isVerified,_that.isOnline);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String displayName,  String username,  String? avatarUrl,  bool isVerified,  bool isOnline)?  $default,) {final _that = this;
switch (_that) {
case _TripJoinRequester() when $default != null:
return $default(_that.id,_that.displayName,_that.username,_that.avatarUrl,_that.isVerified,_that.isOnline);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TripJoinRequester implements TripJoinRequester {
  const _TripJoinRequester({required this.id, required this.displayName, required this.username, this.avatarUrl, this.isVerified = false, this.isOnline = false});
  factory _TripJoinRequester.fromJson(Map<String, dynamic> json) => _$TripJoinRequesterFromJson(json);

@override final  String id;
@override final  String displayName;
@override final  String username;
@override final  String? avatarUrl;
@override@JsonKey() final  bool isVerified;
@override@JsonKey() final  bool isOnline;

/// Create a copy of TripJoinRequester
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TripJoinRequesterCopyWith<_TripJoinRequester> get copyWith => __$TripJoinRequesterCopyWithImpl<_TripJoinRequester>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TripJoinRequesterToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TripJoinRequester&&(identical(other.id, id) || other.id == id)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.username, username) || other.username == username)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.isVerified, isVerified) || other.isVerified == isVerified)&&(identical(other.isOnline, isOnline) || other.isOnline == isOnline));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,displayName,username,avatarUrl,isVerified,isOnline);
}

@override
String toString() {
    return 'TripJoinRequester(id: $id, displayName: $displayName, username: $username, avatarUrl: $avatarUrl, isVerified: $isVerified, isOnline: $isOnline)';
}


}

/// @nodoc
abstract mixin class _$TripJoinRequesterCopyWith<$Res> implements $TripJoinRequesterCopyWith<$Res> {
  factory _$TripJoinRequesterCopyWith(_TripJoinRequester value, $Res Function(_TripJoinRequester) _then) = __$TripJoinRequesterCopyWithImpl;
@override @useResult
$Res call({
 String id, String displayName, String username, String? avatarUrl, bool isVerified, bool isOnline
});




}
/// @nodoc
class __$TripJoinRequesterCopyWithImpl<$Res>
    implements _$TripJoinRequesterCopyWith<$Res> {
  __$TripJoinRequesterCopyWithImpl(this._self, this._then);

  final _TripJoinRequester _self;
  final $Res Function(_TripJoinRequester) _then;

/// Create a copy of TripJoinRequester
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? displayName = null,Object? username = null,Object? avatarUrl = freezed,Object? isVerified = null,Object? isOnline = null,}) {
  return _then(_TripJoinRequester(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,isVerified: null == isVerified ? _self.isVerified : isVerified // ignore: cast_nullable_to_non_nullable
as bool,isOnline: null == isOnline ? _self.isOnline : isOnline // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$TripJoinRequestSettings {

/// Approves requests of the owner's friends without review.
 bool get autoApproveFriends;
/// Create a copy of TripJoinRequestSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TripJoinRequestSettingsCopyWith<TripJoinRequestSettings> get copyWith => _$TripJoinRequestSettingsCopyWithImpl<TripJoinRequestSettings>(this as TripJoinRequestSettings, _$identity);

  /// Serializes this TripJoinRequestSettings to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TripJoinRequestSettings;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TripJoinRequestSettings&&(identical(other.autoApproveFriends, _this.autoApproveFriends) || other.autoApproveFriends == _this.autoApproveFriends));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TripJoinRequestSettings;
  return Object.hash(runtimeType,_this.autoApproveFriends);
}

@override
String toString() {
  final _this = this as TripJoinRequestSettings;
  return 'TripJoinRequestSettings(autoApproveFriends: ${_this.autoApproveFriends})';
}


}

/// @nodoc
abstract mixin class $TripJoinRequestSettingsCopyWith<$Res>  {
  factory $TripJoinRequestSettingsCopyWith(TripJoinRequestSettings value, $Res Function(TripJoinRequestSettings) _then) = _$TripJoinRequestSettingsCopyWithImpl;
@useResult
$Res call({
 bool autoApproveFriends
});




}
/// @nodoc
class _$TripJoinRequestSettingsCopyWithImpl<$Res>
    implements $TripJoinRequestSettingsCopyWith<$Res> {
  _$TripJoinRequestSettingsCopyWithImpl(this._self, this._then);

  final TripJoinRequestSettings _self;
  final $Res Function(TripJoinRequestSettings) _then;

/// Create a copy of TripJoinRequestSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? autoApproveFriends = null,}) {
  return _then(TripJoinRequestSettings(
autoApproveFriends: null == autoApproveFriends ? _self.autoApproveFriends : autoApproveFriends // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [TripJoinRequestSettings].
extension TripJoinRequestSettingsPatterns on TripJoinRequestSettings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TripJoinRequestSettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TripJoinRequestSettings() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TripJoinRequestSettings value)  $default,){
final _that = this;
switch (_that) {
case _TripJoinRequestSettings():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TripJoinRequestSettings value)?  $default,){
final _that = this;
switch (_that) {
case _TripJoinRequestSettings() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool autoApproveFriends)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TripJoinRequestSettings() when $default != null:
return $default(_that.autoApproveFriends);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool autoApproveFriends)  $default,) {final _that = this;
switch (_that) {
case _TripJoinRequestSettings():
return $default(_that.autoApproveFriends);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool autoApproveFriends)?  $default,) {final _that = this;
switch (_that) {
case _TripJoinRequestSettings() when $default != null:
return $default(_that.autoApproveFriends);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TripJoinRequestSettings implements TripJoinRequestSettings {
  const _TripJoinRequestSettings({this.autoApproveFriends = false});
  factory _TripJoinRequestSettings.fromJson(Map<String, dynamic> json) => _$TripJoinRequestSettingsFromJson(json);

/// Approves requests of the owner's friends without review.
@override@JsonKey() final  bool autoApproveFriends;

/// Create a copy of TripJoinRequestSettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TripJoinRequestSettingsCopyWith<_TripJoinRequestSettings> get copyWith => __$TripJoinRequestSettingsCopyWithImpl<_TripJoinRequestSettings>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TripJoinRequestSettingsToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TripJoinRequestSettings&&(identical(other.autoApproveFriends, autoApproveFriends) || other.autoApproveFriends == autoApproveFriends));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,autoApproveFriends);
}

@override
String toString() {
    return 'TripJoinRequestSettings(autoApproveFriends: $autoApproveFriends)';
}


}

/// @nodoc
abstract mixin class _$TripJoinRequestSettingsCopyWith<$Res> implements $TripJoinRequestSettingsCopyWith<$Res> {
  factory _$TripJoinRequestSettingsCopyWith(_TripJoinRequestSettings value, $Res Function(_TripJoinRequestSettings) _then) = __$TripJoinRequestSettingsCopyWithImpl;
@override @useResult
$Res call({
 bool autoApproveFriends
});




}
/// @nodoc
class __$TripJoinRequestSettingsCopyWithImpl<$Res>
    implements _$TripJoinRequestSettingsCopyWith<$Res> {
  __$TripJoinRequestSettingsCopyWithImpl(this._self, this._then);

  final _TripJoinRequestSettings _self;
  final $Res Function(_TripJoinRequestSettings) _then;

/// Create a copy of TripJoinRequestSettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? autoApproveFriends = null,}) {
  return _then(_TripJoinRequestSettings(
autoApproveFriends: null == autoApproveFriends ? _self.autoApproveFriends : autoApproveFriends // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
