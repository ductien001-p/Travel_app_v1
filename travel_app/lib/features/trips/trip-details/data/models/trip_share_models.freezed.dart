// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'trip_share_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TripShareLink {

 String get url; DateTime get expiresAt;
/// Create a copy of TripShareLink
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TripShareLinkCopyWith<TripShareLink> get copyWith => _$TripShareLinkCopyWithImpl<TripShareLink>(this as TripShareLink, _$identity);

  /// Serializes this TripShareLink to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TripShareLink;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TripShareLink&&(identical(other.url, _this.url) || other.url == _this.url)&&(identical(other.expiresAt, _this.expiresAt) || other.expiresAt == _this.expiresAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TripShareLink;
  return Object.hash(runtimeType,_this.url,_this.expiresAt);
}

@override
String toString() {
  final _this = this as TripShareLink;
  return 'TripShareLink(url: ${_this.url}, expiresAt: ${_this.expiresAt})';
}


}

/// @nodoc
abstract mixin class $TripShareLinkCopyWith<$Res>  {
  factory $TripShareLinkCopyWith(TripShareLink value, $Res Function(TripShareLink) _then) = _$TripShareLinkCopyWithImpl;
@useResult
$Res call({
 String url, DateTime expiresAt
});




}
/// @nodoc
class _$TripShareLinkCopyWithImpl<$Res>
    implements $TripShareLinkCopyWith<$Res> {
  _$TripShareLinkCopyWithImpl(this._self, this._then);

  final TripShareLink _self;
  final $Res Function(TripShareLink) _then;

/// Create a copy of TripShareLink
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? url = null,Object? expiresAt = null,}) {
  return _then(TripShareLink(
url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [TripShareLink].
extension TripShareLinkPatterns on TripShareLink {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TripShareLink value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TripShareLink() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TripShareLink value)  $default,){
final _that = this;
switch (_that) {
case _TripShareLink():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TripShareLink value)?  $default,){
final _that = this;
switch (_that) {
case _TripShareLink() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String url,  DateTime expiresAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TripShareLink() when $default != null:
return $default(_that.url,_that.expiresAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String url,  DateTime expiresAt)  $default,) {final _that = this;
switch (_that) {
case _TripShareLink():
return $default(_that.url,_that.expiresAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String url,  DateTime expiresAt)?  $default,) {final _that = this;
switch (_that) {
case _TripShareLink() when $default != null:
return $default(_that.url,_that.expiresAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TripShareLink implements TripShareLink {
  const _TripShareLink({required this.url, required this.expiresAt});
  factory _TripShareLink.fromJson(Map<String, dynamic> json) => _$TripShareLinkFromJson(json);

@override final  String url;
@override final  DateTime expiresAt;

/// Create a copy of TripShareLink
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TripShareLinkCopyWith<_TripShareLink> get copyWith => __$TripShareLinkCopyWithImpl<_TripShareLink>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TripShareLinkToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TripShareLink&&(identical(other.url, url) || other.url == url)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,url,expiresAt);
}

@override
String toString() {
    return 'TripShareLink(url: $url, expiresAt: $expiresAt)';
}


}

/// @nodoc
abstract mixin class _$TripShareLinkCopyWith<$Res> implements $TripShareLinkCopyWith<$Res> {
  factory _$TripShareLinkCopyWith(_TripShareLink value, $Res Function(_TripShareLink) _then) = __$TripShareLinkCopyWithImpl;
@override @useResult
$Res call({
 String url, DateTime expiresAt
});




}
/// @nodoc
class __$TripShareLinkCopyWithImpl<$Res>
    implements _$TripShareLinkCopyWith<$Res> {
  __$TripShareLinkCopyWithImpl(this._self, this._then);

  final _TripShareLink _self;
  final $Res Function(_TripShareLink) _then;

/// Create a copy of TripShareLink
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? url = null,Object? expiresAt = null,}) {
  return _then(_TripShareLink(
url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}


/// @nodoc
mixin _$SharedTripSummary {

 String get id; String get name; DateTime get startDate; DateTime get endDate; TripDetailStatus get status; String? get coverImageUrl;
/// Create a copy of SharedTripSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SharedTripSummaryCopyWith<SharedTripSummary> get copyWith => _$SharedTripSummaryCopyWithImpl<SharedTripSummary>(this as SharedTripSummary, _$identity);

  /// Serializes this SharedTripSummary to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SharedTripSummary;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SharedTripSummary&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.startDate, _this.startDate) || other.startDate == _this.startDate)&&(identical(other.endDate, _this.endDate) || other.endDate == _this.endDate)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.coverImageUrl, _this.coverImageUrl) || other.coverImageUrl == _this.coverImageUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SharedTripSummary;
  return Object.hash(runtimeType,_this.id,_this.name,_this.startDate,_this.endDate,_this.status,_this.coverImageUrl);
}

@override
String toString() {
  final _this = this as SharedTripSummary;
  return 'SharedTripSummary(id: ${_this.id}, name: ${_this.name}, startDate: ${_this.startDate}, endDate: ${_this.endDate}, status: ${_this.status}, coverImageUrl: ${_this.coverImageUrl})';
}


}

/// @nodoc
abstract mixin class $SharedTripSummaryCopyWith<$Res>  {
  factory $SharedTripSummaryCopyWith(SharedTripSummary value, $Res Function(SharedTripSummary) _then) = _$SharedTripSummaryCopyWithImpl;
@useResult
$Res call({
 String id, String name, DateTime startDate, DateTime endDate, TripDetailStatus status, String? coverImageUrl
});




}
/// @nodoc
class _$SharedTripSummaryCopyWithImpl<$Res>
    implements $SharedTripSummaryCopyWith<$Res> {
  _$SharedTripSummaryCopyWithImpl(this._self, this._then);

  final SharedTripSummary _self;
  final $Res Function(SharedTripSummary) _then;

/// Create a copy of SharedTripSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? startDate = null,Object? endDate = null,Object? status = null,Object? coverImageUrl = freezed,}) {
  return _then(SharedTripSummary(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,endDate: null == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TripDetailStatus,coverImageUrl: freezed == coverImageUrl ? _self.coverImageUrl : coverImageUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SharedTripSummary].
extension SharedTripSummaryPatterns on SharedTripSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SharedTripSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SharedTripSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SharedTripSummary value)  $default,){
final _that = this;
switch (_that) {
case _SharedTripSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SharedTripSummary value)?  $default,){
final _that = this;
switch (_that) {
case _SharedTripSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  DateTime startDate,  DateTime endDate,  TripDetailStatus status,  String? coverImageUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SharedTripSummary() when $default != null:
return $default(_that.id,_that.name,_that.startDate,_that.endDate,_that.status,_that.coverImageUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  DateTime startDate,  DateTime endDate,  TripDetailStatus status,  String? coverImageUrl)  $default,) {final _that = this;
switch (_that) {
case _SharedTripSummary():
return $default(_that.id,_that.name,_that.startDate,_that.endDate,_that.status,_that.coverImageUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  DateTime startDate,  DateTime endDate,  TripDetailStatus status,  String? coverImageUrl)?  $default,) {final _that = this;
switch (_that) {
case _SharedTripSummary() when $default != null:
return $default(_that.id,_that.name,_that.startDate,_that.endDate,_that.status,_that.coverImageUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SharedTripSummary implements SharedTripSummary {
  const _SharedTripSummary({required this.id, required this.name, required this.startDate, required this.endDate, required this.status, this.coverImageUrl});
  factory _SharedTripSummary.fromJson(Map<String, dynamic> json) => _$SharedTripSummaryFromJson(json);

@override final  String id;
@override final  String name;
@override final  DateTime startDate;
@override final  DateTime endDate;
@override final  TripDetailStatus status;
@override final  String? coverImageUrl;

/// Create a copy of SharedTripSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SharedTripSummaryCopyWith<_SharedTripSummary> get copyWith => __$SharedTripSummaryCopyWithImpl<_SharedTripSummary>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SharedTripSummaryToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SharedTripSummary&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.status, status) || other.status == status)&&(identical(other.coverImageUrl, coverImageUrl) || other.coverImageUrl == coverImageUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,name,startDate,endDate,status,coverImageUrl);
}

@override
String toString() {
    return 'SharedTripSummary(id: $id, name: $name, startDate: $startDate, endDate: $endDate, status: $status, coverImageUrl: $coverImageUrl)';
}


}

/// @nodoc
abstract mixin class _$SharedTripSummaryCopyWith<$Res> implements $SharedTripSummaryCopyWith<$Res> {
  factory _$SharedTripSummaryCopyWith(_SharedTripSummary value, $Res Function(_SharedTripSummary) _then) = __$SharedTripSummaryCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, DateTime startDate, DateTime endDate, TripDetailStatus status, String? coverImageUrl
});




}
/// @nodoc
class __$SharedTripSummaryCopyWithImpl<$Res>
    implements _$SharedTripSummaryCopyWith<$Res> {
  __$SharedTripSummaryCopyWithImpl(this._self, this._then);

  final _SharedTripSummary _self;
  final $Res Function(_SharedTripSummary) _then;

/// Create a copy of SharedTripSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? startDate = null,Object? endDate = null,Object? status = null,Object? coverImageUrl = freezed,}) {
  return _then(_SharedTripSummary(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,endDate: null == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TripDetailStatus,coverImageUrl: freezed == coverImageUrl ? _self.coverImageUrl : coverImageUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$SharedItinerary {

 SharedTripSummary get trip; TripItineraryData get itinerary; bool get viewerIsMember;
/// Create a copy of SharedItinerary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SharedItineraryCopyWith<SharedItinerary> get copyWith => _$SharedItineraryCopyWithImpl<SharedItinerary>(this as SharedItinerary, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as SharedItinerary;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SharedItinerary&&(identical(other.trip, _this.trip) || other.trip == _this.trip)&&(identical(other.itinerary, _this.itinerary) || other.itinerary == _this.itinerary)&&(identical(other.viewerIsMember, _this.viewerIsMember) || other.viewerIsMember == _this.viewerIsMember));
}


@override
int get hashCode {
  final _this = this as SharedItinerary;
  return Object.hash(runtimeType,_this.trip,_this.itinerary,_this.viewerIsMember);
}

@override
String toString() {
  final _this = this as SharedItinerary;
  return 'SharedItinerary(trip: ${_this.trip}, itinerary: ${_this.itinerary}, viewerIsMember: ${_this.viewerIsMember})';
}


}

/// @nodoc
abstract mixin class $SharedItineraryCopyWith<$Res>  {
  factory $SharedItineraryCopyWith(SharedItinerary value, $Res Function(SharedItinerary) _then) = _$SharedItineraryCopyWithImpl;
@useResult
$Res call({
 SharedTripSummary trip, TripItineraryData itinerary, bool viewerIsMember
});


$SharedTripSummaryCopyWith<$Res> get trip;

}
/// @nodoc
class _$SharedItineraryCopyWithImpl<$Res>
    implements $SharedItineraryCopyWith<$Res> {
  _$SharedItineraryCopyWithImpl(this._self, this._then);

  final SharedItinerary _self;
  final $Res Function(SharedItinerary) _then;

/// Create a copy of SharedItinerary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? trip = null,Object? itinerary = null,Object? viewerIsMember = null,}) {
  return _then(SharedItinerary(
trip: null == trip ? _self.trip : trip // ignore: cast_nullable_to_non_nullable
as SharedTripSummary,itinerary: null == itinerary ? _self.itinerary : itinerary // ignore: cast_nullable_to_non_nullable
as TripItineraryData,viewerIsMember: null == viewerIsMember ? _self.viewerIsMember : viewerIsMember // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of SharedItinerary
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SharedTripSummaryCopyWith<$Res> get trip {
  
  return $SharedTripSummaryCopyWith<$Res>(_self.trip, (value) {
    return _then(_self.copyWith(trip: value));
  });
}
}


/// Adds pattern-matching-related methods to [SharedItinerary].
extension SharedItineraryPatterns on SharedItinerary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SharedItinerary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SharedItinerary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SharedItinerary value)  $default,){
final _that = this;
switch (_that) {
case _SharedItinerary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SharedItinerary value)?  $default,){
final _that = this;
switch (_that) {
case _SharedItinerary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( SharedTripSummary trip,  TripItineraryData itinerary,  bool viewerIsMember)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SharedItinerary() when $default != null:
return $default(_that.trip,_that.itinerary,_that.viewerIsMember);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( SharedTripSummary trip,  TripItineraryData itinerary,  bool viewerIsMember)  $default,) {final _that = this;
switch (_that) {
case _SharedItinerary():
return $default(_that.trip,_that.itinerary,_that.viewerIsMember);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( SharedTripSummary trip,  TripItineraryData itinerary,  bool viewerIsMember)?  $default,) {final _that = this;
switch (_that) {
case _SharedItinerary() when $default != null:
return $default(_that.trip,_that.itinerary,_that.viewerIsMember);case _:
  return null;

}
}

}

/// @nodoc


class _SharedItinerary extends SharedItinerary {
  const _SharedItinerary({required this.trip, required this.itinerary, required this.viewerIsMember}): super._();
  

@override final  SharedTripSummary trip;
@override final  TripItineraryData itinerary;
@override final  bool viewerIsMember;

/// Create a copy of SharedItinerary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SharedItineraryCopyWith<_SharedItinerary> get copyWith => __$SharedItineraryCopyWithImpl<_SharedItinerary>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SharedItinerary&&(identical(other.trip, trip) || other.trip == trip)&&(identical(other.itinerary, itinerary) || other.itinerary == itinerary)&&(identical(other.viewerIsMember, viewerIsMember) || other.viewerIsMember == viewerIsMember));
}


@override
int get hashCode {
    return Object.hash(runtimeType,trip,itinerary,viewerIsMember);
}

@override
String toString() {
    return 'SharedItinerary(trip: $trip, itinerary: $itinerary, viewerIsMember: $viewerIsMember)';
}


}

/// @nodoc
abstract mixin class _$SharedItineraryCopyWith<$Res> implements $SharedItineraryCopyWith<$Res> {
  factory _$SharedItineraryCopyWith(_SharedItinerary value, $Res Function(_SharedItinerary) _then) = __$SharedItineraryCopyWithImpl;
@override @useResult
$Res call({
 SharedTripSummary trip, TripItineraryData itinerary, bool viewerIsMember
});


@override $SharedTripSummaryCopyWith<$Res> get trip;

}
/// @nodoc
class __$SharedItineraryCopyWithImpl<$Res>
    implements _$SharedItineraryCopyWith<$Res> {
  __$SharedItineraryCopyWithImpl(this._self, this._then);

  final _SharedItinerary _self;
  final $Res Function(_SharedItinerary) _then;

/// Create a copy of SharedItinerary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? trip = null,Object? itinerary = null,Object? viewerIsMember = null,}) {
  return _then(_SharedItinerary(
trip: null == trip ? _self.trip : trip // ignore: cast_nullable_to_non_nullable
as SharedTripSummary,itinerary: null == itinerary ? _self.itinerary : itinerary // ignore: cast_nullable_to_non_nullable
as TripItineraryData,viewerIsMember: null == viewerIsMember ? _self.viewerIsMember : viewerIsMember // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of SharedItinerary
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SharedTripSummaryCopyWith<$Res> get trip {
  
  return $SharedTripSummaryCopyWith<$Res>(_self.trip, (value) {
    return _then(_self.copyWith(trip: value));
  });
}
}

// dart format on
