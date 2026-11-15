// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'trip_chat_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TripChatThread {

 String get tripId; String get title; String get memberSummaryLabel; bool get isLive; TripChatPinnedActivity? get pinnedActivity; String get dateLabel; List<TripChatMessage> get messages; bool get isSomeoneTyping; String? get typingLabel; String? get typingAvatarUrl; List<TripChatUtility> get utilities;
/// Create a copy of TripChatThread
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TripChatThreadCopyWith<TripChatThread> get copyWith => _$TripChatThreadCopyWithImpl<TripChatThread>(this as TripChatThread, _$identity);

  /// Serializes this TripChatThread to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TripChatThread;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TripChatThread&&(identical(other.tripId, _this.tripId) || other.tripId == _this.tripId)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.memberSummaryLabel, _this.memberSummaryLabel) || other.memberSummaryLabel == _this.memberSummaryLabel)&&(identical(other.isLive, _this.isLive) || other.isLive == _this.isLive)&&(identical(other.pinnedActivity, _this.pinnedActivity) || other.pinnedActivity == _this.pinnedActivity)&&(identical(other.dateLabel, _this.dateLabel) || other.dateLabel == _this.dateLabel)&&const DeepCollectionEquality().equals(other.messages, _this.messages)&&(identical(other.isSomeoneTyping, _this.isSomeoneTyping) || other.isSomeoneTyping == _this.isSomeoneTyping)&&(identical(other.typingLabel, _this.typingLabel) || other.typingLabel == _this.typingLabel)&&(identical(other.typingAvatarUrl, _this.typingAvatarUrl) || other.typingAvatarUrl == _this.typingAvatarUrl)&&const DeepCollectionEquality().equals(other.utilities, _this.utilities));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TripChatThread;
  return Object.hash(runtimeType,_this.tripId,_this.title,_this.memberSummaryLabel,_this.isLive,_this.pinnedActivity,_this.dateLabel,const DeepCollectionEquality().hash(_this.messages),_this.isSomeoneTyping,_this.typingLabel,_this.typingAvatarUrl,const DeepCollectionEquality().hash(_this.utilities));
}

@override
String toString() {
  final _this = this as TripChatThread;
  return 'TripChatThread(tripId: ${_this.tripId}, title: ${_this.title}, memberSummaryLabel: ${_this.memberSummaryLabel}, isLive: ${_this.isLive}, pinnedActivity: ${_this.pinnedActivity}, dateLabel: ${_this.dateLabel}, messages: ${_this.messages}, isSomeoneTyping: ${_this.isSomeoneTyping}, typingLabel: ${_this.typingLabel}, typingAvatarUrl: ${_this.typingAvatarUrl}, utilities: ${_this.utilities})';
}


}

/// @nodoc
abstract mixin class $TripChatThreadCopyWith<$Res>  {
  factory $TripChatThreadCopyWith(TripChatThread value, $Res Function(TripChatThread) _then) = _$TripChatThreadCopyWithImpl;
@useResult
$Res call({
 String tripId, String title, String memberSummaryLabel, bool isLive, TripChatPinnedActivity? pinnedActivity, String dateLabel, List<TripChatMessage> messages, bool isSomeoneTyping, String? typingLabel, String? typingAvatarUrl, List<TripChatUtility> utilities
});


$TripChatPinnedActivityCopyWith<$Res>? get pinnedActivity;

}
/// @nodoc
class _$TripChatThreadCopyWithImpl<$Res>
    implements $TripChatThreadCopyWith<$Res> {
  _$TripChatThreadCopyWithImpl(this._self, this._then);

  final TripChatThread _self;
  final $Res Function(TripChatThread) _then;

/// Create a copy of TripChatThread
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? tripId = null,Object? title = null,Object? memberSummaryLabel = null,Object? isLive = null,Object? pinnedActivity = freezed,Object? dateLabel = null,Object? messages = null,Object? isSomeoneTyping = null,Object? typingLabel = freezed,Object? typingAvatarUrl = freezed,Object? utilities = null,}) {
  return _then(TripChatThread(
tripId: null == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,memberSummaryLabel: null == memberSummaryLabel ? _self.memberSummaryLabel : memberSummaryLabel // ignore: cast_nullable_to_non_nullable
as String,isLive: null == isLive ? _self.isLive : isLive // ignore: cast_nullable_to_non_nullable
as bool,pinnedActivity: freezed == pinnedActivity ? _self.pinnedActivity : pinnedActivity // ignore: cast_nullable_to_non_nullable
as TripChatPinnedActivity?,dateLabel: null == dateLabel ? _self.dateLabel : dateLabel // ignore: cast_nullable_to_non_nullable
as String,messages: null == messages ? _self.messages : messages // ignore: cast_nullable_to_non_nullable
as List<TripChatMessage>,isSomeoneTyping: null == isSomeoneTyping ? _self.isSomeoneTyping : isSomeoneTyping // ignore: cast_nullable_to_non_nullable
as bool,typingLabel: freezed == typingLabel ? _self.typingLabel : typingLabel // ignore: cast_nullable_to_non_nullable
as String?,typingAvatarUrl: freezed == typingAvatarUrl ? _self.typingAvatarUrl : typingAvatarUrl // ignore: cast_nullable_to_non_nullable
as String?,utilities: null == utilities ? _self.utilities : utilities // ignore: cast_nullable_to_non_nullable
as List<TripChatUtility>,
  ));
}
/// Create a copy of TripChatThread
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TripChatPinnedActivityCopyWith<$Res>? get pinnedActivity {
    if (_self.pinnedActivity == null) {
    return null;
  }

  return $TripChatPinnedActivityCopyWith<$Res>(_self.pinnedActivity!, (value) {
    return _then(_self.copyWith(pinnedActivity: value));
  });
}
}


/// Adds pattern-matching-related methods to [TripChatThread].
extension TripChatThreadPatterns on TripChatThread {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TripChatThread value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TripChatThread() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TripChatThread value)  $default,){
final _that = this;
switch (_that) {
case _TripChatThread():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TripChatThread value)?  $default,){
final _that = this;
switch (_that) {
case _TripChatThread() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String tripId,  String title,  String memberSummaryLabel,  bool isLive,  TripChatPinnedActivity? pinnedActivity,  String dateLabel,  List<TripChatMessage> messages,  bool isSomeoneTyping,  String? typingLabel,  String? typingAvatarUrl,  List<TripChatUtility> utilities)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TripChatThread() when $default != null:
return $default(_that.tripId,_that.title,_that.memberSummaryLabel,_that.isLive,_that.pinnedActivity,_that.dateLabel,_that.messages,_that.isSomeoneTyping,_that.typingLabel,_that.typingAvatarUrl,_that.utilities);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String tripId,  String title,  String memberSummaryLabel,  bool isLive,  TripChatPinnedActivity? pinnedActivity,  String dateLabel,  List<TripChatMessage> messages,  bool isSomeoneTyping,  String? typingLabel,  String? typingAvatarUrl,  List<TripChatUtility> utilities)  $default,) {final _that = this;
switch (_that) {
case _TripChatThread():
return $default(_that.tripId,_that.title,_that.memberSummaryLabel,_that.isLive,_that.pinnedActivity,_that.dateLabel,_that.messages,_that.isSomeoneTyping,_that.typingLabel,_that.typingAvatarUrl,_that.utilities);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String tripId,  String title,  String memberSummaryLabel,  bool isLive,  TripChatPinnedActivity? pinnedActivity,  String dateLabel,  List<TripChatMessage> messages,  bool isSomeoneTyping,  String? typingLabel,  String? typingAvatarUrl,  List<TripChatUtility> utilities)?  $default,) {final _that = this;
switch (_that) {
case _TripChatThread() when $default != null:
return $default(_that.tripId,_that.title,_that.memberSummaryLabel,_that.isLive,_that.pinnedActivity,_that.dateLabel,_that.messages,_that.isSomeoneTyping,_that.typingLabel,_that.typingAvatarUrl,_that.utilities);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TripChatThread implements TripChatThread {
  const _TripChatThread({required this.tripId, required this.title, required this.memberSummaryLabel, this.isLive = true, this.pinnedActivity, required this.dateLabel,  List<TripChatMessage> messages = const <TripChatMessage>[], this.isSomeoneTyping = false, this.typingLabel, this.typingAvatarUrl,  List<TripChatUtility> utilities = const <TripChatUtility>[]}): _messages = messages,_utilities = utilities;
  factory _TripChatThread.fromJson(Map<String, dynamic> json) => _$TripChatThreadFromJson(json);

@override final  String tripId;
@override final  String title;
@override final  String memberSummaryLabel;
@override@JsonKey() final  bool isLive;
@override final  TripChatPinnedActivity? pinnedActivity;
@override final  String dateLabel;
 final  List<TripChatMessage> _messages;
@override@JsonKey() List<TripChatMessage> get messages {
  if (_messages is EqualUnmodifiableListView) return _messages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_messages);
}

@override@JsonKey() final  bool isSomeoneTyping;
@override final  String? typingLabel;
@override final  String? typingAvatarUrl;
 final  List<TripChatUtility> _utilities;
@override@JsonKey() List<TripChatUtility> get utilities {
  if (_utilities is EqualUnmodifiableListView) return _utilities;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_utilities);
}


/// Create a copy of TripChatThread
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TripChatThreadCopyWith<_TripChatThread> get copyWith => __$TripChatThreadCopyWithImpl<_TripChatThread>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TripChatThreadToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TripChatThread&&(identical(other.tripId, tripId) || other.tripId == tripId)&&(identical(other.title, title) || other.title == title)&&(identical(other.memberSummaryLabel, memberSummaryLabel) || other.memberSummaryLabel == memberSummaryLabel)&&(identical(other.isLive, isLive) || other.isLive == isLive)&&(identical(other.pinnedActivity, pinnedActivity) || other.pinnedActivity == pinnedActivity)&&(identical(other.dateLabel, dateLabel) || other.dateLabel == dateLabel)&&const DeepCollectionEquality().equals(other.messages, _messages)&&(identical(other.isSomeoneTyping, isSomeoneTyping) || other.isSomeoneTyping == isSomeoneTyping)&&(identical(other.typingLabel, typingLabel) || other.typingLabel == typingLabel)&&(identical(other.typingAvatarUrl, typingAvatarUrl) || other.typingAvatarUrl == typingAvatarUrl)&&const DeepCollectionEquality().equals(other.utilities, _utilities));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,tripId,title,memberSummaryLabel,isLive,pinnedActivity,dateLabel,const DeepCollectionEquality().hash(_messages),isSomeoneTyping,typingLabel,typingAvatarUrl,const DeepCollectionEquality().hash(_utilities));
}

@override
String toString() {
    return 'TripChatThread(tripId: $tripId, title: $title, memberSummaryLabel: $memberSummaryLabel, isLive: $isLive, pinnedActivity: $pinnedActivity, dateLabel: $dateLabel, messages: $messages, isSomeoneTyping: $isSomeoneTyping, typingLabel: $typingLabel, typingAvatarUrl: $typingAvatarUrl, utilities: $utilities)';
}


}

/// @nodoc
abstract mixin class _$TripChatThreadCopyWith<$Res> implements $TripChatThreadCopyWith<$Res> {
  factory _$TripChatThreadCopyWith(_TripChatThread value, $Res Function(_TripChatThread) _then) = __$TripChatThreadCopyWithImpl;
@override @useResult
$Res call({
 String tripId, String title, String memberSummaryLabel, bool isLive, TripChatPinnedActivity? pinnedActivity, String dateLabel, List<TripChatMessage> messages, bool isSomeoneTyping, String? typingLabel, String? typingAvatarUrl, List<TripChatUtility> utilities
});


@override $TripChatPinnedActivityCopyWith<$Res>? get pinnedActivity;

}
/// @nodoc
class __$TripChatThreadCopyWithImpl<$Res>
    implements _$TripChatThreadCopyWith<$Res> {
  __$TripChatThreadCopyWithImpl(this._self, this._then);

  final _TripChatThread _self;
  final $Res Function(_TripChatThread) _then;

/// Create a copy of TripChatThread
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? tripId = null,Object? title = null,Object? memberSummaryLabel = null,Object? isLive = null,Object? pinnedActivity = freezed,Object? dateLabel = null,Object? messages = null,Object? isSomeoneTyping = null,Object? typingLabel = freezed,Object? typingAvatarUrl = freezed,Object? utilities = null,}) {
  return _then(_TripChatThread(
tripId: null == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,memberSummaryLabel: null == memberSummaryLabel ? _self.memberSummaryLabel : memberSummaryLabel // ignore: cast_nullable_to_non_nullable
as String,isLive: null == isLive ? _self.isLive : isLive // ignore: cast_nullable_to_non_nullable
as bool,pinnedActivity: freezed == pinnedActivity ? _self.pinnedActivity : pinnedActivity // ignore: cast_nullable_to_non_nullable
as TripChatPinnedActivity?,dateLabel: null == dateLabel ? _self.dateLabel : dateLabel // ignore: cast_nullable_to_non_nullable
as String,messages: null == messages ? _self._messages : messages // ignore: cast_nullable_to_non_nullable
as List<TripChatMessage>,isSomeoneTyping: null == isSomeoneTyping ? _self.isSomeoneTyping : isSomeoneTyping // ignore: cast_nullable_to_non_nullable
as bool,typingLabel: freezed == typingLabel ? _self.typingLabel : typingLabel // ignore: cast_nullable_to_non_nullable
as String?,typingAvatarUrl: freezed == typingAvatarUrl ? _self.typingAvatarUrl : typingAvatarUrl // ignore: cast_nullable_to_non_nullable
as String?,utilities: null == utilities ? _self._utilities : utilities // ignore: cast_nullable_to_non_nullable
as List<TripChatUtility>,
  ));
}

/// Create a copy of TripChatThread
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TripChatPinnedActivityCopyWith<$Res>? get pinnedActivity {
    if (_self.pinnedActivity == null) {
    return null;
  }

  return $TripChatPinnedActivityCopyWith<$Res>(_self.pinnedActivity!, (value) {
    return _then(_self.copyWith(pinnedActivity: value));
  });
}
}


/// @nodoc
mixin _$TripChatPinnedActivity {

 String get badgeLabel; String? get dayChipLabel; String get title; String? get checkInLabel; String? get itineraryDayId;
/// Create a copy of TripChatPinnedActivity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TripChatPinnedActivityCopyWith<TripChatPinnedActivity> get copyWith => _$TripChatPinnedActivityCopyWithImpl<TripChatPinnedActivity>(this as TripChatPinnedActivity, _$identity);

  /// Serializes this TripChatPinnedActivity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TripChatPinnedActivity;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TripChatPinnedActivity&&(identical(other.badgeLabel, _this.badgeLabel) || other.badgeLabel == _this.badgeLabel)&&(identical(other.dayChipLabel, _this.dayChipLabel) || other.dayChipLabel == _this.dayChipLabel)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.checkInLabel, _this.checkInLabel) || other.checkInLabel == _this.checkInLabel)&&(identical(other.itineraryDayId, _this.itineraryDayId) || other.itineraryDayId == _this.itineraryDayId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TripChatPinnedActivity;
  return Object.hash(runtimeType,_this.badgeLabel,_this.dayChipLabel,_this.title,_this.checkInLabel,_this.itineraryDayId);
}

@override
String toString() {
  final _this = this as TripChatPinnedActivity;
  return 'TripChatPinnedActivity(badgeLabel: ${_this.badgeLabel}, dayChipLabel: ${_this.dayChipLabel}, title: ${_this.title}, checkInLabel: ${_this.checkInLabel}, itineraryDayId: ${_this.itineraryDayId})';
}


}

/// @nodoc
abstract mixin class $TripChatPinnedActivityCopyWith<$Res>  {
  factory $TripChatPinnedActivityCopyWith(TripChatPinnedActivity value, $Res Function(TripChatPinnedActivity) _then) = _$TripChatPinnedActivityCopyWithImpl;
@useResult
$Res call({
 String badgeLabel, String? dayChipLabel, String title, String? checkInLabel, String? itineraryDayId
});




}
/// @nodoc
class _$TripChatPinnedActivityCopyWithImpl<$Res>
    implements $TripChatPinnedActivityCopyWith<$Res> {
  _$TripChatPinnedActivityCopyWithImpl(this._self, this._then);

  final TripChatPinnedActivity _self;
  final $Res Function(TripChatPinnedActivity) _then;

/// Create a copy of TripChatPinnedActivity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? badgeLabel = null,Object? dayChipLabel = freezed,Object? title = null,Object? checkInLabel = freezed,Object? itineraryDayId = freezed,}) {
  return _then(TripChatPinnedActivity(
badgeLabel: null == badgeLabel ? _self.badgeLabel : badgeLabel // ignore: cast_nullable_to_non_nullable
as String,dayChipLabel: freezed == dayChipLabel ? _self.dayChipLabel : dayChipLabel // ignore: cast_nullable_to_non_nullable
as String?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,checkInLabel: freezed == checkInLabel ? _self.checkInLabel : checkInLabel // ignore: cast_nullable_to_non_nullable
as String?,itineraryDayId: freezed == itineraryDayId ? _self.itineraryDayId : itineraryDayId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TripChatPinnedActivity].
extension TripChatPinnedActivityPatterns on TripChatPinnedActivity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TripChatPinnedActivity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TripChatPinnedActivity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TripChatPinnedActivity value)  $default,){
final _that = this;
switch (_that) {
case _TripChatPinnedActivity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TripChatPinnedActivity value)?  $default,){
final _that = this;
switch (_that) {
case _TripChatPinnedActivity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String badgeLabel,  String? dayChipLabel,  String title,  String? checkInLabel,  String? itineraryDayId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TripChatPinnedActivity() when $default != null:
return $default(_that.badgeLabel,_that.dayChipLabel,_that.title,_that.checkInLabel,_that.itineraryDayId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String badgeLabel,  String? dayChipLabel,  String title,  String? checkInLabel,  String? itineraryDayId)  $default,) {final _that = this;
switch (_that) {
case _TripChatPinnedActivity():
return $default(_that.badgeLabel,_that.dayChipLabel,_that.title,_that.checkInLabel,_that.itineraryDayId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String badgeLabel,  String? dayChipLabel,  String title,  String? checkInLabel,  String? itineraryDayId)?  $default,) {final _that = this;
switch (_that) {
case _TripChatPinnedActivity() when $default != null:
return $default(_that.badgeLabel,_that.dayChipLabel,_that.title,_that.checkInLabel,_that.itineraryDayId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TripChatPinnedActivity implements TripChatPinnedActivity {
  const _TripChatPinnedActivity({required this.badgeLabel, this.dayChipLabel, required this.title, this.checkInLabel, this.itineraryDayId});
  factory _TripChatPinnedActivity.fromJson(Map<String, dynamic> json) => _$TripChatPinnedActivityFromJson(json);

@override final  String badgeLabel;
@override final  String? dayChipLabel;
@override final  String title;
@override final  String? checkInLabel;
@override final  String? itineraryDayId;

/// Create a copy of TripChatPinnedActivity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TripChatPinnedActivityCopyWith<_TripChatPinnedActivity> get copyWith => __$TripChatPinnedActivityCopyWithImpl<_TripChatPinnedActivity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TripChatPinnedActivityToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TripChatPinnedActivity&&(identical(other.badgeLabel, badgeLabel) || other.badgeLabel == badgeLabel)&&(identical(other.dayChipLabel, dayChipLabel) || other.dayChipLabel == dayChipLabel)&&(identical(other.title, title) || other.title == title)&&(identical(other.checkInLabel, checkInLabel) || other.checkInLabel == checkInLabel)&&(identical(other.itineraryDayId, itineraryDayId) || other.itineraryDayId == itineraryDayId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,badgeLabel,dayChipLabel,title,checkInLabel,itineraryDayId);
}

@override
String toString() {
    return 'TripChatPinnedActivity(badgeLabel: $badgeLabel, dayChipLabel: $dayChipLabel, title: $title, checkInLabel: $checkInLabel, itineraryDayId: $itineraryDayId)';
}


}

/// @nodoc
abstract mixin class _$TripChatPinnedActivityCopyWith<$Res> implements $TripChatPinnedActivityCopyWith<$Res> {
  factory _$TripChatPinnedActivityCopyWith(_TripChatPinnedActivity value, $Res Function(_TripChatPinnedActivity) _then) = __$TripChatPinnedActivityCopyWithImpl;
@override @useResult
$Res call({
 String badgeLabel, String? dayChipLabel, String title, String? checkInLabel, String? itineraryDayId
});




}
/// @nodoc
class __$TripChatPinnedActivityCopyWithImpl<$Res>
    implements _$TripChatPinnedActivityCopyWith<$Res> {
  __$TripChatPinnedActivityCopyWithImpl(this._self, this._then);

  final _TripChatPinnedActivity _self;
  final $Res Function(_TripChatPinnedActivity) _then;

/// Create a copy of TripChatPinnedActivity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? badgeLabel = null,Object? dayChipLabel = freezed,Object? title = null,Object? checkInLabel = freezed,Object? itineraryDayId = freezed,}) {
  return _then(_TripChatPinnedActivity(
badgeLabel: null == badgeLabel ? _self.badgeLabel : badgeLabel // ignore: cast_nullable_to_non_nullable
as String,dayChipLabel: freezed == dayChipLabel ? _self.dayChipLabel : dayChipLabel // ignore: cast_nullable_to_non_nullable
as String?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,checkInLabel: freezed == checkInLabel ? _self.checkInLabel : checkInLabel // ignore: cast_nullable_to_non_nullable
as String?,itineraryDayId: freezed == itineraryDayId ? _self.itineraryDayId : itineraryDayId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$TripChatSender {

 String get userId; String get displayName; String? get avatarUrl; String? get roleBadge; TripChatRoleTone get roleTone; bool get isLeader;
/// Create a copy of TripChatSender
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TripChatSenderCopyWith<TripChatSender> get copyWith => _$TripChatSenderCopyWithImpl<TripChatSender>(this as TripChatSender, _$identity);

  /// Serializes this TripChatSender to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TripChatSender;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TripChatSender&&(identical(other.userId, _this.userId) || other.userId == _this.userId)&&(identical(other.displayName, _this.displayName) || other.displayName == _this.displayName)&&(identical(other.avatarUrl, _this.avatarUrl) || other.avatarUrl == _this.avatarUrl)&&(identical(other.roleBadge, _this.roleBadge) || other.roleBadge == _this.roleBadge)&&(identical(other.roleTone, _this.roleTone) || other.roleTone == _this.roleTone)&&(identical(other.isLeader, _this.isLeader) || other.isLeader == _this.isLeader));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TripChatSender;
  return Object.hash(runtimeType,_this.userId,_this.displayName,_this.avatarUrl,_this.roleBadge,_this.roleTone,_this.isLeader);
}

@override
String toString() {
  final _this = this as TripChatSender;
  return 'TripChatSender(userId: ${_this.userId}, displayName: ${_this.displayName}, avatarUrl: ${_this.avatarUrl}, roleBadge: ${_this.roleBadge}, roleTone: ${_this.roleTone}, isLeader: ${_this.isLeader})';
}


}

/// @nodoc
abstract mixin class $TripChatSenderCopyWith<$Res>  {
  factory $TripChatSenderCopyWith(TripChatSender value, $Res Function(TripChatSender) _then) = _$TripChatSenderCopyWithImpl;
@useResult
$Res call({
 String userId, String displayName, String? avatarUrl, String? roleBadge, TripChatRoleTone roleTone, bool isLeader
});




}
/// @nodoc
class _$TripChatSenderCopyWithImpl<$Res>
    implements $TripChatSenderCopyWith<$Res> {
  _$TripChatSenderCopyWithImpl(this._self, this._then);

  final TripChatSender _self;
  final $Res Function(TripChatSender) _then;

/// Create a copy of TripChatSender
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? displayName = null,Object? avatarUrl = freezed,Object? roleBadge = freezed,Object? roleTone = null,Object? isLeader = null,}) {
  return _then(TripChatSender(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,roleBadge: freezed == roleBadge ? _self.roleBadge : roleBadge // ignore: cast_nullable_to_non_nullable
as String?,roleTone: null == roleTone ? _self.roleTone : roleTone // ignore: cast_nullable_to_non_nullable
as TripChatRoleTone,isLeader: null == isLeader ? _self.isLeader : isLeader // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [TripChatSender].
extension TripChatSenderPatterns on TripChatSender {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TripChatSender value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TripChatSender() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TripChatSender value)  $default,){
final _that = this;
switch (_that) {
case _TripChatSender():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TripChatSender value)?  $default,){
final _that = this;
switch (_that) {
case _TripChatSender() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String userId,  String displayName,  String? avatarUrl,  String? roleBadge,  TripChatRoleTone roleTone,  bool isLeader)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TripChatSender() when $default != null:
return $default(_that.userId,_that.displayName,_that.avatarUrl,_that.roleBadge,_that.roleTone,_that.isLeader);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String userId,  String displayName,  String? avatarUrl,  String? roleBadge,  TripChatRoleTone roleTone,  bool isLeader)  $default,) {final _that = this;
switch (_that) {
case _TripChatSender():
return $default(_that.userId,_that.displayName,_that.avatarUrl,_that.roleBadge,_that.roleTone,_that.isLeader);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String userId,  String displayName,  String? avatarUrl,  String? roleBadge,  TripChatRoleTone roleTone,  bool isLeader)?  $default,) {final _that = this;
switch (_that) {
case _TripChatSender() when $default != null:
return $default(_that.userId,_that.displayName,_that.avatarUrl,_that.roleBadge,_that.roleTone,_that.isLeader);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TripChatSender implements TripChatSender {
  const _TripChatSender({required this.userId, required this.displayName, this.avatarUrl, this.roleBadge, this.roleTone = TripChatRoleTone.member, this.isLeader = false});
  factory _TripChatSender.fromJson(Map<String, dynamic> json) => _$TripChatSenderFromJson(json);

@override final  String userId;
@override final  String displayName;
@override final  String? avatarUrl;
@override final  String? roleBadge;
@override@JsonKey() final  TripChatRoleTone roleTone;
@override@JsonKey() final  bool isLeader;

/// Create a copy of TripChatSender
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TripChatSenderCopyWith<_TripChatSender> get copyWith => __$TripChatSenderCopyWithImpl<_TripChatSender>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TripChatSenderToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TripChatSender&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.roleBadge, roleBadge) || other.roleBadge == roleBadge)&&(identical(other.roleTone, roleTone) || other.roleTone == roleTone)&&(identical(other.isLeader, isLeader) || other.isLeader == isLeader));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,userId,displayName,avatarUrl,roleBadge,roleTone,isLeader);
}

@override
String toString() {
    return 'TripChatSender(userId: $userId, displayName: $displayName, avatarUrl: $avatarUrl, roleBadge: $roleBadge, roleTone: $roleTone, isLeader: $isLeader)';
}


}

/// @nodoc
abstract mixin class _$TripChatSenderCopyWith<$Res> implements $TripChatSenderCopyWith<$Res> {
  factory _$TripChatSenderCopyWith(_TripChatSender value, $Res Function(_TripChatSender) _then) = __$TripChatSenderCopyWithImpl;
@override @useResult
$Res call({
 String userId, String displayName, String? avatarUrl, String? roleBadge, TripChatRoleTone roleTone, bool isLeader
});




}
/// @nodoc
class __$TripChatSenderCopyWithImpl<$Res>
    implements _$TripChatSenderCopyWith<$Res> {
  __$TripChatSenderCopyWithImpl(this._self, this._then);

  final _TripChatSender _self;
  final $Res Function(_TripChatSender) _then;

/// Create a copy of TripChatSender
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? displayName = null,Object? avatarUrl = freezed,Object? roleBadge = freezed,Object? roleTone = null,Object? isLeader = null,}) {
  return _then(_TripChatSender(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,roleBadge: freezed == roleBadge ? _self.roleBadge : roleBadge // ignore: cast_nullable_to_non_nullable
as String?,roleTone: null == roleTone ? _self.roleTone : roleTone // ignore: cast_nullable_to_non_nullable
as TripChatRoleTone,isLeader: null == isLeader ? _self.isLeader : isLeader // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$TripChatMessage {

 String get id; TripChatMessageKind get kind; bool get isMine; String? get text; String get timeLabel; TripChatReadStatus? get readStatus; bool get showAvatar; TripChatSender? get sender; TripChatSystemPayload? get system; TripChatPhotoPayload? get photo; TripChatExpensePayload? get expense; List<TripChatReaction> get reactions;
/// Create a copy of TripChatMessage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TripChatMessageCopyWith<TripChatMessage> get copyWith => _$TripChatMessageCopyWithImpl<TripChatMessage>(this as TripChatMessage, _$identity);

  /// Serializes this TripChatMessage to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TripChatMessage;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TripChatMessage&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.kind, _this.kind) || other.kind == _this.kind)&&(identical(other.isMine, _this.isMine) || other.isMine == _this.isMine)&&(identical(other.text, _this.text) || other.text == _this.text)&&(identical(other.timeLabel, _this.timeLabel) || other.timeLabel == _this.timeLabel)&&(identical(other.readStatus, _this.readStatus) || other.readStatus == _this.readStatus)&&(identical(other.showAvatar, _this.showAvatar) || other.showAvatar == _this.showAvatar)&&(identical(other.sender, _this.sender) || other.sender == _this.sender)&&(identical(other.system, _this.system) || other.system == _this.system)&&(identical(other.photo, _this.photo) || other.photo == _this.photo)&&(identical(other.expense, _this.expense) || other.expense == _this.expense)&&const DeepCollectionEquality().equals(other.reactions, _this.reactions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TripChatMessage;
  return Object.hash(runtimeType,_this.id,_this.kind,_this.isMine,_this.text,_this.timeLabel,_this.readStatus,_this.showAvatar,_this.sender,_this.system,_this.photo,_this.expense,const DeepCollectionEquality().hash(_this.reactions));
}

@override
String toString() {
  final _this = this as TripChatMessage;
  return 'TripChatMessage(id: ${_this.id}, kind: ${_this.kind}, isMine: ${_this.isMine}, text: ${_this.text}, timeLabel: ${_this.timeLabel}, readStatus: ${_this.readStatus}, showAvatar: ${_this.showAvatar}, sender: ${_this.sender}, system: ${_this.system}, photo: ${_this.photo}, expense: ${_this.expense}, reactions: ${_this.reactions})';
}


}

/// @nodoc
abstract mixin class $TripChatMessageCopyWith<$Res>  {
  factory $TripChatMessageCopyWith(TripChatMessage value, $Res Function(TripChatMessage) _then) = _$TripChatMessageCopyWithImpl;
@useResult
$Res call({
 String id, TripChatMessageKind kind, bool isMine, String? text, String timeLabel, TripChatReadStatus? readStatus, bool showAvatar, TripChatSender? sender, TripChatSystemPayload? system, TripChatPhotoPayload? photo, TripChatExpensePayload? expense, List<TripChatReaction> reactions
});


$TripChatSenderCopyWith<$Res>? get sender;$TripChatSystemPayloadCopyWith<$Res>? get system;$TripChatPhotoPayloadCopyWith<$Res>? get photo;$TripChatExpensePayloadCopyWith<$Res>? get expense;

}
/// @nodoc
class _$TripChatMessageCopyWithImpl<$Res>
    implements $TripChatMessageCopyWith<$Res> {
  _$TripChatMessageCopyWithImpl(this._self, this._then);

  final TripChatMessage _self;
  final $Res Function(TripChatMessage) _then;

/// Create a copy of TripChatMessage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? kind = null,Object? isMine = null,Object? text = freezed,Object? timeLabel = null,Object? readStatus = freezed,Object? showAvatar = null,Object? sender = freezed,Object? system = freezed,Object? photo = freezed,Object? expense = freezed,Object? reactions = null,}) {
  return _then(TripChatMessage(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as TripChatMessageKind,isMine: null == isMine ? _self.isMine : isMine // ignore: cast_nullable_to_non_nullable
as bool,text: freezed == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String?,timeLabel: null == timeLabel ? _self.timeLabel : timeLabel // ignore: cast_nullable_to_non_nullable
as String,readStatus: freezed == readStatus ? _self.readStatus : readStatus // ignore: cast_nullable_to_non_nullable
as TripChatReadStatus?,showAvatar: null == showAvatar ? _self.showAvatar : showAvatar // ignore: cast_nullable_to_non_nullable
as bool,sender: freezed == sender ? _self.sender : sender // ignore: cast_nullable_to_non_nullable
as TripChatSender?,system: freezed == system ? _self.system : system // ignore: cast_nullable_to_non_nullable
as TripChatSystemPayload?,photo: freezed == photo ? _self.photo : photo // ignore: cast_nullable_to_non_nullable
as TripChatPhotoPayload?,expense: freezed == expense ? _self.expense : expense // ignore: cast_nullable_to_non_nullable
as TripChatExpensePayload?,reactions: null == reactions ? _self.reactions : reactions // ignore: cast_nullable_to_non_nullable
as List<TripChatReaction>,
  ));
}
/// Create a copy of TripChatMessage
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TripChatSenderCopyWith<$Res>? get sender {
    if (_self.sender == null) {
    return null;
  }

  return $TripChatSenderCopyWith<$Res>(_self.sender!, (value) {
    return _then(_self.copyWith(sender: value));
  });
}/// Create a copy of TripChatMessage
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TripChatSystemPayloadCopyWith<$Res>? get system {
    if (_self.system == null) {
    return null;
  }

  return $TripChatSystemPayloadCopyWith<$Res>(_self.system!, (value) {
    return _then(_self.copyWith(system: value));
  });
}/// Create a copy of TripChatMessage
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TripChatPhotoPayloadCopyWith<$Res>? get photo {
    if (_self.photo == null) {
    return null;
  }

  return $TripChatPhotoPayloadCopyWith<$Res>(_self.photo!, (value) {
    return _then(_self.copyWith(photo: value));
  });
}/// Create a copy of TripChatMessage
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TripChatExpensePayloadCopyWith<$Res>? get expense {
    if (_self.expense == null) {
    return null;
  }

  return $TripChatExpensePayloadCopyWith<$Res>(_self.expense!, (value) {
    return _then(_self.copyWith(expense: value));
  });
}
}


/// Adds pattern-matching-related methods to [TripChatMessage].
extension TripChatMessagePatterns on TripChatMessage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TripChatMessage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TripChatMessage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TripChatMessage value)  $default,){
final _that = this;
switch (_that) {
case _TripChatMessage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TripChatMessage value)?  $default,){
final _that = this;
switch (_that) {
case _TripChatMessage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  TripChatMessageKind kind,  bool isMine,  String? text,  String timeLabel,  TripChatReadStatus? readStatus,  bool showAvatar,  TripChatSender? sender,  TripChatSystemPayload? system,  TripChatPhotoPayload? photo,  TripChatExpensePayload? expense,  List<TripChatReaction> reactions)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TripChatMessage() when $default != null:
return $default(_that.id,_that.kind,_that.isMine,_that.text,_that.timeLabel,_that.readStatus,_that.showAvatar,_that.sender,_that.system,_that.photo,_that.expense,_that.reactions);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  TripChatMessageKind kind,  bool isMine,  String? text,  String timeLabel,  TripChatReadStatus? readStatus,  bool showAvatar,  TripChatSender? sender,  TripChatSystemPayload? system,  TripChatPhotoPayload? photo,  TripChatExpensePayload? expense,  List<TripChatReaction> reactions)  $default,) {final _that = this;
switch (_that) {
case _TripChatMessage():
return $default(_that.id,_that.kind,_that.isMine,_that.text,_that.timeLabel,_that.readStatus,_that.showAvatar,_that.sender,_that.system,_that.photo,_that.expense,_that.reactions);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  TripChatMessageKind kind,  bool isMine,  String? text,  String timeLabel,  TripChatReadStatus? readStatus,  bool showAvatar,  TripChatSender? sender,  TripChatSystemPayload? system,  TripChatPhotoPayload? photo,  TripChatExpensePayload? expense,  List<TripChatReaction> reactions)?  $default,) {final _that = this;
switch (_that) {
case _TripChatMessage() when $default != null:
return $default(_that.id,_that.kind,_that.isMine,_that.text,_that.timeLabel,_that.readStatus,_that.showAvatar,_that.sender,_that.system,_that.photo,_that.expense,_that.reactions);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TripChatMessage implements TripChatMessage {
  const _TripChatMessage({required this.id, required this.kind, this.isMine = false, this.text, required this.timeLabel, this.readStatus, this.showAvatar = true, this.sender, this.system, this.photo, this.expense,  List<TripChatReaction> reactions = const <TripChatReaction>[]}): _reactions = reactions;
  factory _TripChatMessage.fromJson(Map<String, dynamic> json) => _$TripChatMessageFromJson(json);

@override final  String id;
@override final  TripChatMessageKind kind;
@override@JsonKey() final  bool isMine;
@override final  String? text;
@override final  String timeLabel;
@override final  TripChatReadStatus? readStatus;
@override@JsonKey() final  bool showAvatar;
@override final  TripChatSender? sender;
@override final  TripChatSystemPayload? system;
@override final  TripChatPhotoPayload? photo;
@override final  TripChatExpensePayload? expense;
 final  List<TripChatReaction> _reactions;
@override@JsonKey() List<TripChatReaction> get reactions {
  if (_reactions is EqualUnmodifiableListView) return _reactions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_reactions);
}


/// Create a copy of TripChatMessage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TripChatMessageCopyWith<_TripChatMessage> get copyWith => __$TripChatMessageCopyWithImpl<_TripChatMessage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TripChatMessageToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TripChatMessage&&(identical(other.id, id) || other.id == id)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.isMine, isMine) || other.isMine == isMine)&&(identical(other.text, text) || other.text == text)&&(identical(other.timeLabel, timeLabel) || other.timeLabel == timeLabel)&&(identical(other.readStatus, readStatus) || other.readStatus == readStatus)&&(identical(other.showAvatar, showAvatar) || other.showAvatar == showAvatar)&&(identical(other.sender, sender) || other.sender == sender)&&(identical(other.system, system) || other.system == system)&&(identical(other.photo, photo) || other.photo == photo)&&(identical(other.expense, expense) || other.expense == expense)&&const DeepCollectionEquality().equals(other.reactions, _reactions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,kind,isMine,text,timeLabel,readStatus,showAvatar,sender,system,photo,expense,const DeepCollectionEquality().hash(_reactions));
}

@override
String toString() {
    return 'TripChatMessage(id: $id, kind: $kind, isMine: $isMine, text: $text, timeLabel: $timeLabel, readStatus: $readStatus, showAvatar: $showAvatar, sender: $sender, system: $system, photo: $photo, expense: $expense, reactions: $reactions)';
}


}

/// @nodoc
abstract mixin class _$TripChatMessageCopyWith<$Res> implements $TripChatMessageCopyWith<$Res> {
  factory _$TripChatMessageCopyWith(_TripChatMessage value, $Res Function(_TripChatMessage) _then) = __$TripChatMessageCopyWithImpl;
@override @useResult
$Res call({
 String id, TripChatMessageKind kind, bool isMine, String? text, String timeLabel, TripChatReadStatus? readStatus, bool showAvatar, TripChatSender? sender, TripChatSystemPayload? system, TripChatPhotoPayload? photo, TripChatExpensePayload? expense, List<TripChatReaction> reactions
});


@override $TripChatSenderCopyWith<$Res>? get sender;@override $TripChatSystemPayloadCopyWith<$Res>? get system;@override $TripChatPhotoPayloadCopyWith<$Res>? get photo;@override $TripChatExpensePayloadCopyWith<$Res>? get expense;

}
/// @nodoc
class __$TripChatMessageCopyWithImpl<$Res>
    implements _$TripChatMessageCopyWith<$Res> {
  __$TripChatMessageCopyWithImpl(this._self, this._then);

  final _TripChatMessage _self;
  final $Res Function(_TripChatMessage) _then;

/// Create a copy of TripChatMessage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? kind = null,Object? isMine = null,Object? text = freezed,Object? timeLabel = null,Object? readStatus = freezed,Object? showAvatar = null,Object? sender = freezed,Object? system = freezed,Object? photo = freezed,Object? expense = freezed,Object? reactions = null,}) {
  return _then(_TripChatMessage(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as TripChatMessageKind,isMine: null == isMine ? _self.isMine : isMine // ignore: cast_nullable_to_non_nullable
as bool,text: freezed == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String?,timeLabel: null == timeLabel ? _self.timeLabel : timeLabel // ignore: cast_nullable_to_non_nullable
as String,readStatus: freezed == readStatus ? _self.readStatus : readStatus // ignore: cast_nullable_to_non_nullable
as TripChatReadStatus?,showAvatar: null == showAvatar ? _self.showAvatar : showAvatar // ignore: cast_nullable_to_non_nullable
as bool,sender: freezed == sender ? _self.sender : sender // ignore: cast_nullable_to_non_nullable
as TripChatSender?,system: freezed == system ? _self.system : system // ignore: cast_nullable_to_non_nullable
as TripChatSystemPayload?,photo: freezed == photo ? _self.photo : photo // ignore: cast_nullable_to_non_nullable
as TripChatPhotoPayload?,expense: freezed == expense ? _self.expense : expense // ignore: cast_nullable_to_non_nullable
as TripChatExpensePayload?,reactions: null == reactions ? _self._reactions : reactions // ignore: cast_nullable_to_non_nullable
as List<TripChatReaction>,
  ));
}

/// Create a copy of TripChatMessage
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TripChatSenderCopyWith<$Res>? get sender {
    if (_self.sender == null) {
    return null;
  }

  return $TripChatSenderCopyWith<$Res>(_self.sender!, (value) {
    return _then(_self.copyWith(sender: value));
  });
}/// Create a copy of TripChatMessage
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TripChatSystemPayloadCopyWith<$Res>? get system {
    if (_self.system == null) {
    return null;
  }

  return $TripChatSystemPayloadCopyWith<$Res>(_self.system!, (value) {
    return _then(_self.copyWith(system: value));
  });
}/// Create a copy of TripChatMessage
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TripChatPhotoPayloadCopyWith<$Res>? get photo {
    if (_self.photo == null) {
    return null;
  }

  return $TripChatPhotoPayloadCopyWith<$Res>(_self.photo!, (value) {
    return _then(_self.copyWith(photo: value));
  });
}/// Create a copy of TripChatMessage
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TripChatExpensePayloadCopyWith<$Res>? get expense {
    if (_self.expense == null) {
    return null;
  }

  return $TripChatExpensePayloadCopyWith<$Res>(_self.expense!, (value) {
    return _then(_self.copyWith(expense: value));
  });
}
}


/// @nodoc
mixin _$TripChatSystemPayload {

 String get icon; String get richText;
/// Create a copy of TripChatSystemPayload
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TripChatSystemPayloadCopyWith<TripChatSystemPayload> get copyWith => _$TripChatSystemPayloadCopyWithImpl<TripChatSystemPayload>(this as TripChatSystemPayload, _$identity);

  /// Serializes this TripChatSystemPayload to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TripChatSystemPayload;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TripChatSystemPayload&&(identical(other.icon, _this.icon) || other.icon == _this.icon)&&(identical(other.richText, _this.richText) || other.richText == _this.richText));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TripChatSystemPayload;
  return Object.hash(runtimeType,_this.icon,_this.richText);
}

@override
String toString() {
  final _this = this as TripChatSystemPayload;
  return 'TripChatSystemPayload(icon: ${_this.icon}, richText: ${_this.richText})';
}


}

/// @nodoc
abstract mixin class $TripChatSystemPayloadCopyWith<$Res>  {
  factory $TripChatSystemPayloadCopyWith(TripChatSystemPayload value, $Res Function(TripChatSystemPayload) _then) = _$TripChatSystemPayloadCopyWithImpl;
@useResult
$Res call({
 String icon, String richText
});




}
/// @nodoc
class _$TripChatSystemPayloadCopyWithImpl<$Res>
    implements $TripChatSystemPayloadCopyWith<$Res> {
  _$TripChatSystemPayloadCopyWithImpl(this._self, this._then);

  final TripChatSystemPayload _self;
  final $Res Function(TripChatSystemPayload) _then;

/// Create a copy of TripChatSystemPayload
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? icon = null,Object? richText = null,}) {
  return _then(TripChatSystemPayload(
icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String,richText: null == richText ? _self.richText : richText // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [TripChatSystemPayload].
extension TripChatSystemPayloadPatterns on TripChatSystemPayload {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TripChatSystemPayload value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TripChatSystemPayload() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TripChatSystemPayload value)  $default,){
final _that = this;
switch (_that) {
case _TripChatSystemPayload():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TripChatSystemPayload value)?  $default,){
final _that = this;
switch (_that) {
case _TripChatSystemPayload() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String icon,  String richText)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TripChatSystemPayload() when $default != null:
return $default(_that.icon,_that.richText);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String icon,  String richText)  $default,) {final _that = this;
switch (_that) {
case _TripChatSystemPayload():
return $default(_that.icon,_that.richText);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String icon,  String richText)?  $default,) {final _that = this;
switch (_that) {
case _TripChatSystemPayload() when $default != null:
return $default(_that.icon,_that.richText);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TripChatSystemPayload implements TripChatSystemPayload {
  const _TripChatSystemPayload({required this.icon, required this.richText});
  factory _TripChatSystemPayload.fromJson(Map<String, dynamic> json) => _$TripChatSystemPayloadFromJson(json);

@override final  String icon;
@override final  String richText;

/// Create a copy of TripChatSystemPayload
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TripChatSystemPayloadCopyWith<_TripChatSystemPayload> get copyWith => __$TripChatSystemPayloadCopyWithImpl<_TripChatSystemPayload>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TripChatSystemPayloadToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TripChatSystemPayload&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.richText, richText) || other.richText == richText));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,icon,richText);
}

@override
String toString() {
    return 'TripChatSystemPayload(icon: $icon, richText: $richText)';
}


}

/// @nodoc
abstract mixin class _$TripChatSystemPayloadCopyWith<$Res> implements $TripChatSystemPayloadCopyWith<$Res> {
  factory _$TripChatSystemPayloadCopyWith(_TripChatSystemPayload value, $Res Function(_TripChatSystemPayload) _then) = __$TripChatSystemPayloadCopyWithImpl;
@override @useResult
$Res call({
 String icon, String richText
});




}
/// @nodoc
class __$TripChatSystemPayloadCopyWithImpl<$Res>
    implements _$TripChatSystemPayloadCopyWith<$Res> {
  __$TripChatSystemPayloadCopyWithImpl(this._self, this._then);

  final _TripChatSystemPayload _self;
  final $Res Function(_TripChatSystemPayload) _then;

/// Create a copy of TripChatSystemPayload
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? icon = null,Object? richText = null,}) {
  return _then(_TripChatSystemPayload(
icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String,richText: null == richText ? _self.richText : richText // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$TripChatPhotoPayload {

 String get imageUrl; String? get caption; String? get locationLabel; List<TripChatReaction> get reactions;
/// Create a copy of TripChatPhotoPayload
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TripChatPhotoPayloadCopyWith<TripChatPhotoPayload> get copyWith => _$TripChatPhotoPayloadCopyWithImpl<TripChatPhotoPayload>(this as TripChatPhotoPayload, _$identity);

  /// Serializes this TripChatPhotoPayload to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TripChatPhotoPayload;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TripChatPhotoPayload&&(identical(other.imageUrl, _this.imageUrl) || other.imageUrl == _this.imageUrl)&&(identical(other.caption, _this.caption) || other.caption == _this.caption)&&(identical(other.locationLabel, _this.locationLabel) || other.locationLabel == _this.locationLabel)&&const DeepCollectionEquality().equals(other.reactions, _this.reactions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TripChatPhotoPayload;
  return Object.hash(runtimeType,_this.imageUrl,_this.caption,_this.locationLabel,const DeepCollectionEquality().hash(_this.reactions));
}

@override
String toString() {
  final _this = this as TripChatPhotoPayload;
  return 'TripChatPhotoPayload(imageUrl: ${_this.imageUrl}, caption: ${_this.caption}, locationLabel: ${_this.locationLabel}, reactions: ${_this.reactions})';
}


}

/// @nodoc
abstract mixin class $TripChatPhotoPayloadCopyWith<$Res>  {
  factory $TripChatPhotoPayloadCopyWith(TripChatPhotoPayload value, $Res Function(TripChatPhotoPayload) _then) = _$TripChatPhotoPayloadCopyWithImpl;
@useResult
$Res call({
 String imageUrl, String? caption, String? locationLabel, List<TripChatReaction> reactions
});




}
/// @nodoc
class _$TripChatPhotoPayloadCopyWithImpl<$Res>
    implements $TripChatPhotoPayloadCopyWith<$Res> {
  _$TripChatPhotoPayloadCopyWithImpl(this._self, this._then);

  final TripChatPhotoPayload _self;
  final $Res Function(TripChatPhotoPayload) _then;

/// Create a copy of TripChatPhotoPayload
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? imageUrl = null,Object? caption = freezed,Object? locationLabel = freezed,Object? reactions = null,}) {
  return _then(TripChatPhotoPayload(
imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,caption: freezed == caption ? _self.caption : caption // ignore: cast_nullable_to_non_nullable
as String?,locationLabel: freezed == locationLabel ? _self.locationLabel : locationLabel // ignore: cast_nullable_to_non_nullable
as String?,reactions: null == reactions ? _self.reactions : reactions // ignore: cast_nullable_to_non_nullable
as List<TripChatReaction>,
  ));
}

}


/// Adds pattern-matching-related methods to [TripChatPhotoPayload].
extension TripChatPhotoPayloadPatterns on TripChatPhotoPayload {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TripChatPhotoPayload value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TripChatPhotoPayload() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TripChatPhotoPayload value)  $default,){
final _that = this;
switch (_that) {
case _TripChatPhotoPayload():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TripChatPhotoPayload value)?  $default,){
final _that = this;
switch (_that) {
case _TripChatPhotoPayload() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String imageUrl,  String? caption,  String? locationLabel,  List<TripChatReaction> reactions)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TripChatPhotoPayload() when $default != null:
return $default(_that.imageUrl,_that.caption,_that.locationLabel,_that.reactions);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String imageUrl,  String? caption,  String? locationLabel,  List<TripChatReaction> reactions)  $default,) {final _that = this;
switch (_that) {
case _TripChatPhotoPayload():
return $default(_that.imageUrl,_that.caption,_that.locationLabel,_that.reactions);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String imageUrl,  String? caption,  String? locationLabel,  List<TripChatReaction> reactions)?  $default,) {final _that = this;
switch (_that) {
case _TripChatPhotoPayload() when $default != null:
return $default(_that.imageUrl,_that.caption,_that.locationLabel,_that.reactions);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TripChatPhotoPayload implements TripChatPhotoPayload {
  const _TripChatPhotoPayload({required this.imageUrl, this.caption, this.locationLabel,  List<TripChatReaction> reactions = const <TripChatReaction>[]}): _reactions = reactions;
  factory _TripChatPhotoPayload.fromJson(Map<String, dynamic> json) => _$TripChatPhotoPayloadFromJson(json);

@override final  String imageUrl;
@override final  String? caption;
@override final  String? locationLabel;
 final  List<TripChatReaction> _reactions;
@override@JsonKey() List<TripChatReaction> get reactions {
  if (_reactions is EqualUnmodifiableListView) return _reactions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_reactions);
}


/// Create a copy of TripChatPhotoPayload
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TripChatPhotoPayloadCopyWith<_TripChatPhotoPayload> get copyWith => __$TripChatPhotoPayloadCopyWithImpl<_TripChatPhotoPayload>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TripChatPhotoPayloadToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TripChatPhotoPayload&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.caption, caption) || other.caption == caption)&&(identical(other.locationLabel, locationLabel) || other.locationLabel == locationLabel)&&const DeepCollectionEquality().equals(other.reactions, _reactions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,imageUrl,caption,locationLabel,const DeepCollectionEquality().hash(_reactions));
}

@override
String toString() {
    return 'TripChatPhotoPayload(imageUrl: $imageUrl, caption: $caption, locationLabel: $locationLabel, reactions: $reactions)';
}


}

/// @nodoc
abstract mixin class _$TripChatPhotoPayloadCopyWith<$Res> implements $TripChatPhotoPayloadCopyWith<$Res> {
  factory _$TripChatPhotoPayloadCopyWith(_TripChatPhotoPayload value, $Res Function(_TripChatPhotoPayload) _then) = __$TripChatPhotoPayloadCopyWithImpl;
@override @useResult
$Res call({
 String imageUrl, String? caption, String? locationLabel, List<TripChatReaction> reactions
});




}
/// @nodoc
class __$TripChatPhotoPayloadCopyWithImpl<$Res>
    implements _$TripChatPhotoPayloadCopyWith<$Res> {
  __$TripChatPhotoPayloadCopyWithImpl(this._self, this._then);

  final _TripChatPhotoPayload _self;
  final $Res Function(_TripChatPhotoPayload) _then;

/// Create a copy of TripChatPhotoPayload
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? imageUrl = null,Object? caption = freezed,Object? locationLabel = freezed,Object? reactions = null,}) {
  return _then(_TripChatPhotoPayload(
imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,caption: freezed == caption ? _self.caption : caption // ignore: cast_nullable_to_non_nullable
as String?,locationLabel: freezed == locationLabel ? _self.locationLabel : locationLabel // ignore: cast_nullable_to_non_nullable
as String?,reactions: null == reactions ? _self._reactions : reactions // ignore: cast_nullable_to_non_nullable
as List<TripChatReaction>,
  ));
}


}


/// @nodoc
mixin _$TripChatReaction {

 String get emoji;@JsonKey(fromJson: _readInt) int get count;
/// Create a copy of TripChatReaction
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TripChatReactionCopyWith<TripChatReaction> get copyWith => _$TripChatReactionCopyWithImpl<TripChatReaction>(this as TripChatReaction, _$identity);

  /// Serializes this TripChatReaction to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TripChatReaction;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TripChatReaction&&(identical(other.emoji, _this.emoji) || other.emoji == _this.emoji)&&(identical(other.count, _this.count) || other.count == _this.count));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TripChatReaction;
  return Object.hash(runtimeType,_this.emoji,_this.count);
}

@override
String toString() {
  final _this = this as TripChatReaction;
  return 'TripChatReaction(emoji: ${_this.emoji}, count: ${_this.count})';
}


}

/// @nodoc
abstract mixin class $TripChatReactionCopyWith<$Res>  {
  factory $TripChatReactionCopyWith(TripChatReaction value, $Res Function(TripChatReaction) _then) = _$TripChatReactionCopyWithImpl;
@useResult
$Res call({
 String emoji,@JsonKey(fromJson: _readInt) int count
});




}
/// @nodoc
class _$TripChatReactionCopyWithImpl<$Res>
    implements $TripChatReactionCopyWith<$Res> {
  _$TripChatReactionCopyWithImpl(this._self, this._then);

  final TripChatReaction _self;
  final $Res Function(TripChatReaction) _then;

/// Create a copy of TripChatReaction
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? emoji = null,Object? count = null,}) {
  return _then(TripChatReaction(
emoji: null == emoji ? _self.emoji : emoji // ignore: cast_nullable_to_non_nullable
as String,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [TripChatReaction].
extension TripChatReactionPatterns on TripChatReaction {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TripChatReaction value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TripChatReaction() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TripChatReaction value)  $default,){
final _that = this;
switch (_that) {
case _TripChatReaction():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TripChatReaction value)?  $default,){
final _that = this;
switch (_that) {
case _TripChatReaction() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String emoji, @JsonKey(fromJson: _readInt)  int count)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TripChatReaction() when $default != null:
return $default(_that.emoji,_that.count);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String emoji, @JsonKey(fromJson: _readInt)  int count)  $default,) {final _that = this;
switch (_that) {
case _TripChatReaction():
return $default(_that.emoji,_that.count);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String emoji, @JsonKey(fromJson: _readInt)  int count)?  $default,) {final _that = this;
switch (_that) {
case _TripChatReaction() when $default != null:
return $default(_that.emoji,_that.count);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TripChatReaction implements TripChatReaction {
  const _TripChatReaction({required this.emoji, @JsonKey(fromJson: _readInt) required this.count});
  factory _TripChatReaction.fromJson(Map<String, dynamic> json) => _$TripChatReactionFromJson(json);

@override final  String emoji;
@override@JsonKey(fromJson: _readInt) final  int count;

/// Create a copy of TripChatReaction
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TripChatReactionCopyWith<_TripChatReaction> get copyWith => __$TripChatReactionCopyWithImpl<_TripChatReaction>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TripChatReactionToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TripChatReaction&&(identical(other.emoji, emoji) || other.emoji == emoji)&&(identical(other.count, count) || other.count == count));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,emoji,count);
}

@override
String toString() {
    return 'TripChatReaction(emoji: $emoji, count: $count)';
}


}

/// @nodoc
abstract mixin class _$TripChatReactionCopyWith<$Res> implements $TripChatReactionCopyWith<$Res> {
  factory _$TripChatReactionCopyWith(_TripChatReaction value, $Res Function(_TripChatReaction) _then) = __$TripChatReactionCopyWithImpl;
@override @useResult
$Res call({
 String emoji,@JsonKey(fromJson: _readInt) int count
});




}
/// @nodoc
class __$TripChatReactionCopyWithImpl<$Res>
    implements _$TripChatReactionCopyWith<$Res> {
  __$TripChatReactionCopyWithImpl(this._self, this._then);

  final _TripChatReaction _self;
  final $Res Function(_TripChatReaction) _then;

/// Create a copy of TripChatReaction
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? emoji = null,Object? count = null,}) {
  return _then(_TripChatReaction(
emoji: null == emoji ? _self.emoji : emoji // ignore: cast_nullable_to_non_nullable
as String,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$TripChatExpensePayload {

 String get expenseId; String get title; String get subtitle; String get amountLabel; String get splitLabel; String get perPersonLabel; String? get actionLabel;
/// Create a copy of TripChatExpensePayload
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TripChatExpensePayloadCopyWith<TripChatExpensePayload> get copyWith => _$TripChatExpensePayloadCopyWithImpl<TripChatExpensePayload>(this as TripChatExpensePayload, _$identity);

  /// Serializes this TripChatExpensePayload to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TripChatExpensePayload;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TripChatExpensePayload&&(identical(other.expenseId, _this.expenseId) || other.expenseId == _this.expenseId)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.subtitle, _this.subtitle) || other.subtitle == _this.subtitle)&&(identical(other.amountLabel, _this.amountLabel) || other.amountLabel == _this.amountLabel)&&(identical(other.splitLabel, _this.splitLabel) || other.splitLabel == _this.splitLabel)&&(identical(other.perPersonLabel, _this.perPersonLabel) || other.perPersonLabel == _this.perPersonLabel)&&(identical(other.actionLabel, _this.actionLabel) || other.actionLabel == _this.actionLabel));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TripChatExpensePayload;
  return Object.hash(runtimeType,_this.expenseId,_this.title,_this.subtitle,_this.amountLabel,_this.splitLabel,_this.perPersonLabel,_this.actionLabel);
}

@override
String toString() {
  final _this = this as TripChatExpensePayload;
  return 'TripChatExpensePayload(expenseId: ${_this.expenseId}, title: ${_this.title}, subtitle: ${_this.subtitle}, amountLabel: ${_this.amountLabel}, splitLabel: ${_this.splitLabel}, perPersonLabel: ${_this.perPersonLabel}, actionLabel: ${_this.actionLabel})';
}


}

/// @nodoc
abstract mixin class $TripChatExpensePayloadCopyWith<$Res>  {
  factory $TripChatExpensePayloadCopyWith(TripChatExpensePayload value, $Res Function(TripChatExpensePayload) _then) = _$TripChatExpensePayloadCopyWithImpl;
@useResult
$Res call({
 String expenseId, String title, String subtitle, String amountLabel, String splitLabel, String perPersonLabel, String? actionLabel
});




}
/// @nodoc
class _$TripChatExpensePayloadCopyWithImpl<$Res>
    implements $TripChatExpensePayloadCopyWith<$Res> {
  _$TripChatExpensePayloadCopyWithImpl(this._self, this._then);

  final TripChatExpensePayload _self;
  final $Res Function(TripChatExpensePayload) _then;

/// Create a copy of TripChatExpensePayload
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? expenseId = null,Object? title = null,Object? subtitle = null,Object? amountLabel = null,Object? splitLabel = null,Object? perPersonLabel = null,Object? actionLabel = freezed,}) {
  return _then(TripChatExpensePayload(
expenseId: null == expenseId ? _self.expenseId : expenseId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,subtitle: null == subtitle ? _self.subtitle : subtitle // ignore: cast_nullable_to_non_nullable
as String,amountLabel: null == amountLabel ? _self.amountLabel : amountLabel // ignore: cast_nullable_to_non_nullable
as String,splitLabel: null == splitLabel ? _self.splitLabel : splitLabel // ignore: cast_nullable_to_non_nullable
as String,perPersonLabel: null == perPersonLabel ? _self.perPersonLabel : perPersonLabel // ignore: cast_nullable_to_non_nullable
as String,actionLabel: freezed == actionLabel ? _self.actionLabel : actionLabel // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TripChatExpensePayload].
extension TripChatExpensePayloadPatterns on TripChatExpensePayload {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TripChatExpensePayload value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TripChatExpensePayload() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TripChatExpensePayload value)  $default,){
final _that = this;
switch (_that) {
case _TripChatExpensePayload():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TripChatExpensePayload value)?  $default,){
final _that = this;
switch (_that) {
case _TripChatExpensePayload() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String expenseId,  String title,  String subtitle,  String amountLabel,  String splitLabel,  String perPersonLabel,  String? actionLabel)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TripChatExpensePayload() when $default != null:
return $default(_that.expenseId,_that.title,_that.subtitle,_that.amountLabel,_that.splitLabel,_that.perPersonLabel,_that.actionLabel);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String expenseId,  String title,  String subtitle,  String amountLabel,  String splitLabel,  String perPersonLabel,  String? actionLabel)  $default,) {final _that = this;
switch (_that) {
case _TripChatExpensePayload():
return $default(_that.expenseId,_that.title,_that.subtitle,_that.amountLabel,_that.splitLabel,_that.perPersonLabel,_that.actionLabel);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String expenseId,  String title,  String subtitle,  String amountLabel,  String splitLabel,  String perPersonLabel,  String? actionLabel)?  $default,) {final _that = this;
switch (_that) {
case _TripChatExpensePayload() when $default != null:
return $default(_that.expenseId,_that.title,_that.subtitle,_that.amountLabel,_that.splitLabel,_that.perPersonLabel,_that.actionLabel);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TripChatExpensePayload implements TripChatExpensePayload {
  const _TripChatExpensePayload({required this.expenseId, required this.title, required this.subtitle, required this.amountLabel, required this.splitLabel, required this.perPersonLabel, this.actionLabel});
  factory _TripChatExpensePayload.fromJson(Map<String, dynamic> json) => _$TripChatExpensePayloadFromJson(json);

@override final  String expenseId;
@override final  String title;
@override final  String subtitle;
@override final  String amountLabel;
@override final  String splitLabel;
@override final  String perPersonLabel;
@override final  String? actionLabel;

/// Create a copy of TripChatExpensePayload
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TripChatExpensePayloadCopyWith<_TripChatExpensePayload> get copyWith => __$TripChatExpensePayloadCopyWithImpl<_TripChatExpensePayload>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TripChatExpensePayloadToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TripChatExpensePayload&&(identical(other.expenseId, expenseId) || other.expenseId == expenseId)&&(identical(other.title, title) || other.title == title)&&(identical(other.subtitle, subtitle) || other.subtitle == subtitle)&&(identical(other.amountLabel, amountLabel) || other.amountLabel == amountLabel)&&(identical(other.splitLabel, splitLabel) || other.splitLabel == splitLabel)&&(identical(other.perPersonLabel, perPersonLabel) || other.perPersonLabel == perPersonLabel)&&(identical(other.actionLabel, actionLabel) || other.actionLabel == actionLabel));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,expenseId,title,subtitle,amountLabel,splitLabel,perPersonLabel,actionLabel);
}

@override
String toString() {
    return 'TripChatExpensePayload(expenseId: $expenseId, title: $title, subtitle: $subtitle, amountLabel: $amountLabel, splitLabel: $splitLabel, perPersonLabel: $perPersonLabel, actionLabel: $actionLabel)';
}


}

/// @nodoc
abstract mixin class _$TripChatExpensePayloadCopyWith<$Res> implements $TripChatExpensePayloadCopyWith<$Res> {
  factory _$TripChatExpensePayloadCopyWith(_TripChatExpensePayload value, $Res Function(_TripChatExpensePayload) _then) = __$TripChatExpensePayloadCopyWithImpl;
@override @useResult
$Res call({
 String expenseId, String title, String subtitle, String amountLabel, String splitLabel, String perPersonLabel, String? actionLabel
});




}
/// @nodoc
class __$TripChatExpensePayloadCopyWithImpl<$Res>
    implements _$TripChatExpensePayloadCopyWith<$Res> {
  __$TripChatExpensePayloadCopyWithImpl(this._self, this._then);

  final _TripChatExpensePayload _self;
  final $Res Function(_TripChatExpensePayload) _then;

/// Create a copy of TripChatExpensePayload
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? expenseId = null,Object? title = null,Object? subtitle = null,Object? amountLabel = null,Object? splitLabel = null,Object? perPersonLabel = null,Object? actionLabel = freezed,}) {
  return _then(_TripChatExpensePayload(
expenseId: null == expenseId ? _self.expenseId : expenseId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,subtitle: null == subtitle ? _self.subtitle : subtitle // ignore: cast_nullable_to_non_nullable
as String,amountLabel: null == amountLabel ? _self.amountLabel : amountLabel // ignore: cast_nullable_to_non_nullable
as String,splitLabel: null == splitLabel ? _self.splitLabel : splitLabel // ignore: cast_nullable_to_non_nullable
as String,perPersonLabel: null == perPersonLabel ? _self.perPersonLabel : perPersonLabel // ignore: cast_nullable_to_non_nullable
as String,actionLabel: freezed == actionLabel ? _self.actionLabel : actionLabel // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$TripChatUtility {

 TripChatUtilityKind get kind; String get label;
/// Create a copy of TripChatUtility
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TripChatUtilityCopyWith<TripChatUtility> get copyWith => _$TripChatUtilityCopyWithImpl<TripChatUtility>(this as TripChatUtility, _$identity);

  /// Serializes this TripChatUtility to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TripChatUtility;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TripChatUtility&&(identical(other.kind, _this.kind) || other.kind == _this.kind)&&(identical(other.label, _this.label) || other.label == _this.label));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TripChatUtility;
  return Object.hash(runtimeType,_this.kind,_this.label);
}

@override
String toString() {
  final _this = this as TripChatUtility;
  return 'TripChatUtility(kind: ${_this.kind}, label: ${_this.label})';
}


}

/// @nodoc
abstract mixin class $TripChatUtilityCopyWith<$Res>  {
  factory $TripChatUtilityCopyWith(TripChatUtility value, $Res Function(TripChatUtility) _then) = _$TripChatUtilityCopyWithImpl;
@useResult
$Res call({
 TripChatUtilityKind kind, String label
});




}
/// @nodoc
class _$TripChatUtilityCopyWithImpl<$Res>
    implements $TripChatUtilityCopyWith<$Res> {
  _$TripChatUtilityCopyWithImpl(this._self, this._then);

  final TripChatUtility _self;
  final $Res Function(TripChatUtility) _then;

/// Create a copy of TripChatUtility
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? kind = null,Object? label = null,}) {
  return _then(TripChatUtility(
kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as TripChatUtilityKind,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [TripChatUtility].
extension TripChatUtilityPatterns on TripChatUtility {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TripChatUtility value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TripChatUtility() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TripChatUtility value)  $default,){
final _that = this;
switch (_that) {
case _TripChatUtility():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TripChatUtility value)?  $default,){
final _that = this;
switch (_that) {
case _TripChatUtility() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( TripChatUtilityKind kind,  String label)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TripChatUtility() when $default != null:
return $default(_that.kind,_that.label);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( TripChatUtilityKind kind,  String label)  $default,) {final _that = this;
switch (_that) {
case _TripChatUtility():
return $default(_that.kind,_that.label);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( TripChatUtilityKind kind,  String label)?  $default,) {final _that = this;
switch (_that) {
case _TripChatUtility() when $default != null:
return $default(_that.kind,_that.label);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TripChatUtility implements TripChatUtility {
  const _TripChatUtility({required this.kind, required this.label});
  factory _TripChatUtility.fromJson(Map<String, dynamic> json) => _$TripChatUtilityFromJson(json);

@override final  TripChatUtilityKind kind;
@override final  String label;

/// Create a copy of TripChatUtility
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TripChatUtilityCopyWith<_TripChatUtility> get copyWith => __$TripChatUtilityCopyWithImpl<_TripChatUtility>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TripChatUtilityToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TripChatUtility&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.label, label) || other.label == label));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,kind,label);
}

@override
String toString() {
    return 'TripChatUtility(kind: $kind, label: $label)';
}


}

/// @nodoc
abstract mixin class _$TripChatUtilityCopyWith<$Res> implements $TripChatUtilityCopyWith<$Res> {
  factory _$TripChatUtilityCopyWith(_TripChatUtility value, $Res Function(_TripChatUtility) _then) = __$TripChatUtilityCopyWithImpl;
@override @useResult
$Res call({
 TripChatUtilityKind kind, String label
});




}
/// @nodoc
class __$TripChatUtilityCopyWithImpl<$Res>
    implements _$TripChatUtilityCopyWith<$Res> {
  __$TripChatUtilityCopyWithImpl(this._self, this._then);

  final _TripChatUtility _self;
  final $Res Function(_TripChatUtility) _then;

/// Create a copy of TripChatUtility
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? kind = null,Object? label = null,}) {
  return _then(_TripChatUtility(
kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as TripChatUtilityKind,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
