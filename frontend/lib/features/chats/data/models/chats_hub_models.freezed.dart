// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chats_hub_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ChatsHub {

 ChatsHubViewer get viewer;@JsonKey(fromJson: _readInt) int get totalThreadCount; bool get hasUnread; ChatsActiveTripPulse? get activeTripPulse; List<ChatsTripThread> get tripThreads; List<ChatsFriendThread> get friendThreads;
/// Create a copy of ChatsHub
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatsHubCopyWith<ChatsHub> get copyWith => _$ChatsHubCopyWithImpl<ChatsHub>(this as ChatsHub, _$identity);

  /// Serializes this ChatsHub to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ChatsHub;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatsHub&&(identical(other.viewer, _this.viewer) || other.viewer == _this.viewer)&&(identical(other.totalThreadCount, _this.totalThreadCount) || other.totalThreadCount == _this.totalThreadCount)&&(identical(other.hasUnread, _this.hasUnread) || other.hasUnread == _this.hasUnread)&&(identical(other.activeTripPulse, _this.activeTripPulse) || other.activeTripPulse == _this.activeTripPulse)&&const DeepCollectionEquality().equals(other.tripThreads, _this.tripThreads)&&const DeepCollectionEquality().equals(other.friendThreads, _this.friendThreads));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ChatsHub;
  return Object.hash(runtimeType,_this.viewer,_this.totalThreadCount,_this.hasUnread,_this.activeTripPulse,const DeepCollectionEquality().hash(_this.tripThreads),const DeepCollectionEquality().hash(_this.friendThreads));
}

@override
String toString() {
  final _this = this as ChatsHub;
  return 'ChatsHub(viewer: ${_this.viewer}, totalThreadCount: ${_this.totalThreadCount}, hasUnread: ${_this.hasUnread}, activeTripPulse: ${_this.activeTripPulse}, tripThreads: ${_this.tripThreads}, friendThreads: ${_this.friendThreads})';
}


}

/// @nodoc
abstract mixin class $ChatsHubCopyWith<$Res>  {
  factory $ChatsHubCopyWith(ChatsHub value, $Res Function(ChatsHub) _then) = _$ChatsHubCopyWithImpl;
@useResult
$Res call({
 ChatsHubViewer viewer,@JsonKey(fromJson: _readInt) int totalThreadCount, bool hasUnread, ChatsActiveTripPulse? activeTripPulse, List<ChatsTripThread> tripThreads, List<ChatsFriendThread> friendThreads
});


$ChatsHubViewerCopyWith<$Res> get viewer;$ChatsActiveTripPulseCopyWith<$Res>? get activeTripPulse;

}
/// @nodoc
class _$ChatsHubCopyWithImpl<$Res>
    implements $ChatsHubCopyWith<$Res> {
  _$ChatsHubCopyWithImpl(this._self, this._then);

  final ChatsHub _self;
  final $Res Function(ChatsHub) _then;

/// Create a copy of ChatsHub
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? viewer = null,Object? totalThreadCount = null,Object? hasUnread = null,Object? activeTripPulse = freezed,Object? tripThreads = null,Object? friendThreads = null,}) {
  return _then(ChatsHub(
viewer: null == viewer ? _self.viewer : viewer // ignore: cast_nullable_to_non_nullable
as ChatsHubViewer,totalThreadCount: null == totalThreadCount ? _self.totalThreadCount : totalThreadCount // ignore: cast_nullable_to_non_nullable
as int,hasUnread: null == hasUnread ? _self.hasUnread : hasUnread // ignore: cast_nullable_to_non_nullable
as bool,activeTripPulse: freezed == activeTripPulse ? _self.activeTripPulse : activeTripPulse // ignore: cast_nullable_to_non_nullable
as ChatsActiveTripPulse?,tripThreads: null == tripThreads ? _self.tripThreads : tripThreads // ignore: cast_nullable_to_non_nullable
as List<ChatsTripThread>,friendThreads: null == friendThreads ? _self.friendThreads : friendThreads // ignore: cast_nullable_to_non_nullable
as List<ChatsFriendThread>,
  ));
}
/// Create a copy of ChatsHub
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ChatsHubViewerCopyWith<$Res> get viewer {
  
  return $ChatsHubViewerCopyWith<$Res>(_self.viewer, (value) {
    return _then(_self.copyWith(viewer: value));
  });
}/// Create a copy of ChatsHub
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ChatsActiveTripPulseCopyWith<$Res>? get activeTripPulse {
    if (_self.activeTripPulse == null) {
    return null;
  }

  return $ChatsActiveTripPulseCopyWith<$Res>(_self.activeTripPulse!, (value) {
    return _then(_self.copyWith(activeTripPulse: value));
  });
}
}


/// Adds pattern-matching-related methods to [ChatsHub].
extension ChatsHubPatterns on ChatsHub {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChatsHub value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChatsHub() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChatsHub value)  $default,){
final _that = this;
switch (_that) {
case _ChatsHub():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChatsHub value)?  $default,){
final _that = this;
switch (_that) {
case _ChatsHub() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ChatsHubViewer viewer, @JsonKey(fromJson: _readInt)  int totalThreadCount,  bool hasUnread,  ChatsActiveTripPulse? activeTripPulse,  List<ChatsTripThread> tripThreads,  List<ChatsFriendThread> friendThreads)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChatsHub() when $default != null:
return $default(_that.viewer,_that.totalThreadCount,_that.hasUnread,_that.activeTripPulse,_that.tripThreads,_that.friendThreads);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ChatsHubViewer viewer, @JsonKey(fromJson: _readInt)  int totalThreadCount,  bool hasUnread,  ChatsActiveTripPulse? activeTripPulse,  List<ChatsTripThread> tripThreads,  List<ChatsFriendThread> friendThreads)  $default,) {final _that = this;
switch (_that) {
case _ChatsHub():
return $default(_that.viewer,_that.totalThreadCount,_that.hasUnread,_that.activeTripPulse,_that.tripThreads,_that.friendThreads);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ChatsHubViewer viewer, @JsonKey(fromJson: _readInt)  int totalThreadCount,  bool hasUnread,  ChatsActiveTripPulse? activeTripPulse,  List<ChatsTripThread> tripThreads,  List<ChatsFriendThread> friendThreads)?  $default,) {final _that = this;
switch (_that) {
case _ChatsHub() when $default != null:
return $default(_that.viewer,_that.totalThreadCount,_that.hasUnread,_that.activeTripPulse,_that.tripThreads,_that.friendThreads);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChatsHub implements ChatsHub {
  const _ChatsHub({required this.viewer, @JsonKey(fromJson: _readInt) required this.totalThreadCount, this.hasUnread = false, this.activeTripPulse,  List<ChatsTripThread> tripThreads = const <ChatsTripThread>[],  List<ChatsFriendThread> friendThreads = const <ChatsFriendThread>[]}): _tripThreads = tripThreads,_friendThreads = friendThreads;
  factory _ChatsHub.fromJson(Map<String, dynamic> json) => _$ChatsHubFromJson(json);

@override final  ChatsHubViewer viewer;
@override@JsonKey(fromJson: _readInt) final  int totalThreadCount;
@override@JsonKey() final  bool hasUnread;
@override final  ChatsActiveTripPulse? activeTripPulse;
 final  List<ChatsTripThread> _tripThreads;
@override@JsonKey() List<ChatsTripThread> get tripThreads {
  if (_tripThreads is EqualUnmodifiableListView) return _tripThreads;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tripThreads);
}

 final  List<ChatsFriendThread> _friendThreads;
@override@JsonKey() List<ChatsFriendThread> get friendThreads {
  if (_friendThreads is EqualUnmodifiableListView) return _friendThreads;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_friendThreads);
}


/// Create a copy of ChatsHub
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatsHubCopyWith<_ChatsHub> get copyWith => __$ChatsHubCopyWithImpl<_ChatsHub>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChatsHubToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatsHub&&(identical(other.viewer, viewer) || other.viewer == viewer)&&(identical(other.totalThreadCount, totalThreadCount) || other.totalThreadCount == totalThreadCount)&&(identical(other.hasUnread, hasUnread) || other.hasUnread == hasUnread)&&(identical(other.activeTripPulse, activeTripPulse) || other.activeTripPulse == activeTripPulse)&&const DeepCollectionEquality().equals(other.tripThreads, _tripThreads)&&const DeepCollectionEquality().equals(other.friendThreads, _friendThreads));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,viewer,totalThreadCount,hasUnread,activeTripPulse,const DeepCollectionEquality().hash(_tripThreads),const DeepCollectionEquality().hash(_friendThreads));
}

@override
String toString() {
    return 'ChatsHub(viewer: $viewer, totalThreadCount: $totalThreadCount, hasUnread: $hasUnread, activeTripPulse: $activeTripPulse, tripThreads: $tripThreads, friendThreads: $friendThreads)';
}


}

/// @nodoc
abstract mixin class _$ChatsHubCopyWith<$Res> implements $ChatsHubCopyWith<$Res> {
  factory _$ChatsHubCopyWith(_ChatsHub value, $Res Function(_ChatsHub) _then) = __$ChatsHubCopyWithImpl;
@override @useResult
$Res call({
 ChatsHubViewer viewer,@JsonKey(fromJson: _readInt) int totalThreadCount, bool hasUnread, ChatsActiveTripPulse? activeTripPulse, List<ChatsTripThread> tripThreads, List<ChatsFriendThread> friendThreads
});


@override $ChatsHubViewerCopyWith<$Res> get viewer;@override $ChatsActiveTripPulseCopyWith<$Res>? get activeTripPulse;

}
/// @nodoc
class __$ChatsHubCopyWithImpl<$Res>
    implements _$ChatsHubCopyWith<$Res> {
  __$ChatsHubCopyWithImpl(this._self, this._then);

  final _ChatsHub _self;
  final $Res Function(_ChatsHub) _then;

/// Create a copy of ChatsHub
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? viewer = null,Object? totalThreadCount = null,Object? hasUnread = null,Object? activeTripPulse = freezed,Object? tripThreads = null,Object? friendThreads = null,}) {
  return _then(_ChatsHub(
viewer: null == viewer ? _self.viewer : viewer // ignore: cast_nullable_to_non_nullable
as ChatsHubViewer,totalThreadCount: null == totalThreadCount ? _self.totalThreadCount : totalThreadCount // ignore: cast_nullable_to_non_nullable
as int,hasUnread: null == hasUnread ? _self.hasUnread : hasUnread // ignore: cast_nullable_to_non_nullable
as bool,activeTripPulse: freezed == activeTripPulse ? _self.activeTripPulse : activeTripPulse // ignore: cast_nullable_to_non_nullable
as ChatsActiveTripPulse?,tripThreads: null == tripThreads ? _self._tripThreads : tripThreads // ignore: cast_nullable_to_non_nullable
as List<ChatsTripThread>,friendThreads: null == friendThreads ? _self._friendThreads : friendThreads // ignore: cast_nullable_to_non_nullable
as List<ChatsFriendThread>,
  ));
}

/// Create a copy of ChatsHub
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ChatsHubViewerCopyWith<$Res> get viewer {
  
  return $ChatsHubViewerCopyWith<$Res>(_self.viewer, (value) {
    return _then(_self.copyWith(viewer: value));
  });
}/// Create a copy of ChatsHub
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ChatsActiveTripPulseCopyWith<$Res>? get activeTripPulse {
    if (_self.activeTripPulse == null) {
    return null;
  }

  return $ChatsActiveTripPulseCopyWith<$Res>(_self.activeTripPulse!, (value) {
    return _then(_self.copyWith(activeTripPulse: value));
  });
}
}


/// @nodoc
mixin _$ChatsHubViewer {

 String get displayName; String? get avatarUrl; bool get isOnline;
/// Create a copy of ChatsHubViewer
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatsHubViewerCopyWith<ChatsHubViewer> get copyWith => _$ChatsHubViewerCopyWithImpl<ChatsHubViewer>(this as ChatsHubViewer, _$identity);

  /// Serializes this ChatsHubViewer to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ChatsHubViewer;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatsHubViewer&&(identical(other.displayName, _this.displayName) || other.displayName == _this.displayName)&&(identical(other.avatarUrl, _this.avatarUrl) || other.avatarUrl == _this.avatarUrl)&&(identical(other.isOnline, _this.isOnline) || other.isOnline == _this.isOnline));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ChatsHubViewer;
  return Object.hash(runtimeType,_this.displayName,_this.avatarUrl,_this.isOnline);
}

@override
String toString() {
  final _this = this as ChatsHubViewer;
  return 'ChatsHubViewer(displayName: ${_this.displayName}, avatarUrl: ${_this.avatarUrl}, isOnline: ${_this.isOnline})';
}


}

/// @nodoc
abstract mixin class $ChatsHubViewerCopyWith<$Res>  {
  factory $ChatsHubViewerCopyWith(ChatsHubViewer value, $Res Function(ChatsHubViewer) _then) = _$ChatsHubViewerCopyWithImpl;
@useResult
$Res call({
 String displayName, String? avatarUrl, bool isOnline
});




}
/// @nodoc
class _$ChatsHubViewerCopyWithImpl<$Res>
    implements $ChatsHubViewerCopyWith<$Res> {
  _$ChatsHubViewerCopyWithImpl(this._self, this._then);

  final ChatsHubViewer _self;
  final $Res Function(ChatsHubViewer) _then;

/// Create a copy of ChatsHubViewer
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? displayName = null,Object? avatarUrl = freezed,Object? isOnline = null,}) {
  return _then(ChatsHubViewer(
displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,isOnline: null == isOnline ? _self.isOnline : isOnline // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ChatsHubViewer].
extension ChatsHubViewerPatterns on ChatsHubViewer {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChatsHubViewer value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChatsHubViewer() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChatsHubViewer value)  $default,){
final _that = this;
switch (_that) {
case _ChatsHubViewer():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChatsHubViewer value)?  $default,){
final _that = this;
switch (_that) {
case _ChatsHubViewer() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String displayName,  String? avatarUrl,  bool isOnline)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChatsHubViewer() when $default != null:
return $default(_that.displayName,_that.avatarUrl,_that.isOnline);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String displayName,  String? avatarUrl,  bool isOnline)  $default,) {final _that = this;
switch (_that) {
case _ChatsHubViewer():
return $default(_that.displayName,_that.avatarUrl,_that.isOnline);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String displayName,  String? avatarUrl,  bool isOnline)?  $default,) {final _that = this;
switch (_that) {
case _ChatsHubViewer() when $default != null:
return $default(_that.displayName,_that.avatarUrl,_that.isOnline);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChatsHubViewer implements ChatsHubViewer {
  const _ChatsHubViewer({required this.displayName, this.avatarUrl, this.isOnline = false});
  factory _ChatsHubViewer.fromJson(Map<String, dynamic> json) => _$ChatsHubViewerFromJson(json);

@override final  String displayName;
@override final  String? avatarUrl;
@override@JsonKey() final  bool isOnline;

/// Create a copy of ChatsHubViewer
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatsHubViewerCopyWith<_ChatsHubViewer> get copyWith => __$ChatsHubViewerCopyWithImpl<_ChatsHubViewer>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChatsHubViewerToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatsHubViewer&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.isOnline, isOnline) || other.isOnline == isOnline));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,displayName,avatarUrl,isOnline);
}

@override
String toString() {
    return 'ChatsHubViewer(displayName: $displayName, avatarUrl: $avatarUrl, isOnline: $isOnline)';
}


}

/// @nodoc
abstract mixin class _$ChatsHubViewerCopyWith<$Res> implements $ChatsHubViewerCopyWith<$Res> {
  factory _$ChatsHubViewerCopyWith(_ChatsHubViewer value, $Res Function(_ChatsHubViewer) _then) = __$ChatsHubViewerCopyWithImpl;
@override @useResult
$Res call({
 String displayName, String? avatarUrl, bool isOnline
});




}
/// @nodoc
class __$ChatsHubViewerCopyWithImpl<$Res>
    implements _$ChatsHubViewerCopyWith<$Res> {
  __$ChatsHubViewerCopyWithImpl(this._self, this._then);

  final _ChatsHubViewer _self;
  final $Res Function(_ChatsHubViewer) _then;

/// Create a copy of ChatsHubViewer
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? displayName = null,Object? avatarUrl = freezed,Object? isOnline = null,}) {
  return _then(_ChatsHubViewer(
displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,isOnline: null == isOnline ? _self.isOnline : isOnline // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$ChatsActiveTripPulse {

 String get tripId; String get title; String get statusLabel;@JsonKey(fromJson: _readInt) int get onlineMemberCount;@JsonKey(fromJson: _readInt) int get memberCapacity; List<String> get memberAvatars;@JsonKey(fromJson: _readInt) int get extraMemberCount; String get pinnedSenderName; String get pinnedMessage; String get pinnedTimeLabel;@JsonKey(fromJson: _readInt) int get newExchangeCount;
/// Create a copy of ChatsActiveTripPulse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatsActiveTripPulseCopyWith<ChatsActiveTripPulse> get copyWith => _$ChatsActiveTripPulseCopyWithImpl<ChatsActiveTripPulse>(this as ChatsActiveTripPulse, _$identity);

  /// Serializes this ChatsActiveTripPulse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ChatsActiveTripPulse;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatsActiveTripPulse&&(identical(other.tripId, _this.tripId) || other.tripId == _this.tripId)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.statusLabel, _this.statusLabel) || other.statusLabel == _this.statusLabel)&&(identical(other.onlineMemberCount, _this.onlineMemberCount) || other.onlineMemberCount == _this.onlineMemberCount)&&(identical(other.memberCapacity, _this.memberCapacity) || other.memberCapacity == _this.memberCapacity)&&const DeepCollectionEquality().equals(other.memberAvatars, _this.memberAvatars)&&(identical(other.extraMemberCount, _this.extraMemberCount) || other.extraMemberCount == _this.extraMemberCount)&&(identical(other.pinnedSenderName, _this.pinnedSenderName) || other.pinnedSenderName == _this.pinnedSenderName)&&(identical(other.pinnedMessage, _this.pinnedMessage) || other.pinnedMessage == _this.pinnedMessage)&&(identical(other.pinnedTimeLabel, _this.pinnedTimeLabel) || other.pinnedTimeLabel == _this.pinnedTimeLabel)&&(identical(other.newExchangeCount, _this.newExchangeCount) || other.newExchangeCount == _this.newExchangeCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ChatsActiveTripPulse;
  return Object.hash(runtimeType,_this.tripId,_this.title,_this.statusLabel,_this.onlineMemberCount,_this.memberCapacity,const DeepCollectionEquality().hash(_this.memberAvatars),_this.extraMemberCount,_this.pinnedSenderName,_this.pinnedMessage,_this.pinnedTimeLabel,_this.newExchangeCount);
}

@override
String toString() {
  final _this = this as ChatsActiveTripPulse;
  return 'ChatsActiveTripPulse(tripId: ${_this.tripId}, title: ${_this.title}, statusLabel: ${_this.statusLabel}, onlineMemberCount: ${_this.onlineMemberCount}, memberCapacity: ${_this.memberCapacity}, memberAvatars: ${_this.memberAvatars}, extraMemberCount: ${_this.extraMemberCount}, pinnedSenderName: ${_this.pinnedSenderName}, pinnedMessage: ${_this.pinnedMessage}, pinnedTimeLabel: ${_this.pinnedTimeLabel}, newExchangeCount: ${_this.newExchangeCount})';
}


}

/// @nodoc
abstract mixin class $ChatsActiveTripPulseCopyWith<$Res>  {
  factory $ChatsActiveTripPulseCopyWith(ChatsActiveTripPulse value, $Res Function(ChatsActiveTripPulse) _then) = _$ChatsActiveTripPulseCopyWithImpl;
@useResult
$Res call({
 String tripId, String title, String statusLabel,@JsonKey(fromJson: _readInt) int onlineMemberCount,@JsonKey(fromJson: _readInt) int memberCapacity, List<String> memberAvatars,@JsonKey(fromJson: _readInt) int extraMemberCount, String pinnedSenderName, String pinnedMessage, String pinnedTimeLabel,@JsonKey(fromJson: _readInt) int newExchangeCount
});




}
/// @nodoc
class _$ChatsActiveTripPulseCopyWithImpl<$Res>
    implements $ChatsActiveTripPulseCopyWith<$Res> {
  _$ChatsActiveTripPulseCopyWithImpl(this._self, this._then);

  final ChatsActiveTripPulse _self;
  final $Res Function(ChatsActiveTripPulse) _then;

/// Create a copy of ChatsActiveTripPulse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? tripId = null,Object? title = null,Object? statusLabel = null,Object? onlineMemberCount = null,Object? memberCapacity = null,Object? memberAvatars = null,Object? extraMemberCount = null,Object? pinnedSenderName = null,Object? pinnedMessage = null,Object? pinnedTimeLabel = null,Object? newExchangeCount = null,}) {
  return _then(ChatsActiveTripPulse(
tripId: null == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,statusLabel: null == statusLabel ? _self.statusLabel : statusLabel // ignore: cast_nullable_to_non_nullable
as String,onlineMemberCount: null == onlineMemberCount ? _self.onlineMemberCount : onlineMemberCount // ignore: cast_nullable_to_non_nullable
as int,memberCapacity: null == memberCapacity ? _self.memberCapacity : memberCapacity // ignore: cast_nullable_to_non_nullable
as int,memberAvatars: null == memberAvatars ? _self.memberAvatars : memberAvatars // ignore: cast_nullable_to_non_nullable
as List<String>,extraMemberCount: null == extraMemberCount ? _self.extraMemberCount : extraMemberCount // ignore: cast_nullable_to_non_nullable
as int,pinnedSenderName: null == pinnedSenderName ? _self.pinnedSenderName : pinnedSenderName // ignore: cast_nullable_to_non_nullable
as String,pinnedMessage: null == pinnedMessage ? _self.pinnedMessage : pinnedMessage // ignore: cast_nullable_to_non_nullable
as String,pinnedTimeLabel: null == pinnedTimeLabel ? _self.pinnedTimeLabel : pinnedTimeLabel // ignore: cast_nullable_to_non_nullable
as String,newExchangeCount: null == newExchangeCount ? _self.newExchangeCount : newExchangeCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ChatsActiveTripPulse].
extension ChatsActiveTripPulsePatterns on ChatsActiveTripPulse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChatsActiveTripPulse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChatsActiveTripPulse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChatsActiveTripPulse value)  $default,){
final _that = this;
switch (_that) {
case _ChatsActiveTripPulse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChatsActiveTripPulse value)?  $default,){
final _that = this;
switch (_that) {
case _ChatsActiveTripPulse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String tripId,  String title,  String statusLabel, @JsonKey(fromJson: _readInt)  int onlineMemberCount, @JsonKey(fromJson: _readInt)  int memberCapacity,  List<String> memberAvatars, @JsonKey(fromJson: _readInt)  int extraMemberCount,  String pinnedSenderName,  String pinnedMessage,  String pinnedTimeLabel, @JsonKey(fromJson: _readInt)  int newExchangeCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChatsActiveTripPulse() when $default != null:
return $default(_that.tripId,_that.title,_that.statusLabel,_that.onlineMemberCount,_that.memberCapacity,_that.memberAvatars,_that.extraMemberCount,_that.pinnedSenderName,_that.pinnedMessage,_that.pinnedTimeLabel,_that.newExchangeCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String tripId,  String title,  String statusLabel, @JsonKey(fromJson: _readInt)  int onlineMemberCount, @JsonKey(fromJson: _readInt)  int memberCapacity,  List<String> memberAvatars, @JsonKey(fromJson: _readInt)  int extraMemberCount,  String pinnedSenderName,  String pinnedMessage,  String pinnedTimeLabel, @JsonKey(fromJson: _readInt)  int newExchangeCount)  $default,) {final _that = this;
switch (_that) {
case _ChatsActiveTripPulse():
return $default(_that.tripId,_that.title,_that.statusLabel,_that.onlineMemberCount,_that.memberCapacity,_that.memberAvatars,_that.extraMemberCount,_that.pinnedSenderName,_that.pinnedMessage,_that.pinnedTimeLabel,_that.newExchangeCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String tripId,  String title,  String statusLabel, @JsonKey(fromJson: _readInt)  int onlineMemberCount, @JsonKey(fromJson: _readInt)  int memberCapacity,  List<String> memberAvatars, @JsonKey(fromJson: _readInt)  int extraMemberCount,  String pinnedSenderName,  String pinnedMessage,  String pinnedTimeLabel, @JsonKey(fromJson: _readInt)  int newExchangeCount)?  $default,) {final _that = this;
switch (_that) {
case _ChatsActiveTripPulse() when $default != null:
return $default(_that.tripId,_that.title,_that.statusLabel,_that.onlineMemberCount,_that.memberCapacity,_that.memberAvatars,_that.extraMemberCount,_that.pinnedSenderName,_that.pinnedMessage,_that.pinnedTimeLabel,_that.newExchangeCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChatsActiveTripPulse implements ChatsActiveTripPulse {
  const _ChatsActiveTripPulse({required this.tripId, required this.title, required this.statusLabel, @JsonKey(fromJson: _readInt) required this.onlineMemberCount, @JsonKey(fromJson: _readInt) required this.memberCapacity,  List<String> memberAvatars = const <String>[], @JsonKey(fromJson: _readInt) this.extraMemberCount = 0, required this.pinnedSenderName, required this.pinnedMessage, required this.pinnedTimeLabel, @JsonKey(fromJson: _readInt) this.newExchangeCount = 0}): _memberAvatars = memberAvatars;
  factory _ChatsActiveTripPulse.fromJson(Map<String, dynamic> json) => _$ChatsActiveTripPulseFromJson(json);

@override final  String tripId;
@override final  String title;
@override final  String statusLabel;
@override@JsonKey(fromJson: _readInt) final  int onlineMemberCount;
@override@JsonKey(fromJson: _readInt) final  int memberCapacity;
 final  List<String> _memberAvatars;
@override@JsonKey() List<String> get memberAvatars {
  if (_memberAvatars is EqualUnmodifiableListView) return _memberAvatars;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_memberAvatars);
}

@override@JsonKey(fromJson: _readInt) final  int extraMemberCount;
@override final  String pinnedSenderName;
@override final  String pinnedMessage;
@override final  String pinnedTimeLabel;
@override@JsonKey(fromJson: _readInt) final  int newExchangeCount;

/// Create a copy of ChatsActiveTripPulse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatsActiveTripPulseCopyWith<_ChatsActiveTripPulse> get copyWith => __$ChatsActiveTripPulseCopyWithImpl<_ChatsActiveTripPulse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChatsActiveTripPulseToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatsActiveTripPulse&&(identical(other.tripId, tripId) || other.tripId == tripId)&&(identical(other.title, title) || other.title == title)&&(identical(other.statusLabel, statusLabel) || other.statusLabel == statusLabel)&&(identical(other.onlineMemberCount, onlineMemberCount) || other.onlineMemberCount == onlineMemberCount)&&(identical(other.memberCapacity, memberCapacity) || other.memberCapacity == memberCapacity)&&const DeepCollectionEquality().equals(other.memberAvatars, _memberAvatars)&&(identical(other.extraMemberCount, extraMemberCount) || other.extraMemberCount == extraMemberCount)&&(identical(other.pinnedSenderName, pinnedSenderName) || other.pinnedSenderName == pinnedSenderName)&&(identical(other.pinnedMessage, pinnedMessage) || other.pinnedMessage == pinnedMessage)&&(identical(other.pinnedTimeLabel, pinnedTimeLabel) || other.pinnedTimeLabel == pinnedTimeLabel)&&(identical(other.newExchangeCount, newExchangeCount) || other.newExchangeCount == newExchangeCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,tripId,title,statusLabel,onlineMemberCount,memberCapacity,const DeepCollectionEquality().hash(_memberAvatars),extraMemberCount,pinnedSenderName,pinnedMessage,pinnedTimeLabel,newExchangeCount);
}

@override
String toString() {
    return 'ChatsActiveTripPulse(tripId: $tripId, title: $title, statusLabel: $statusLabel, onlineMemberCount: $onlineMemberCount, memberCapacity: $memberCapacity, memberAvatars: $memberAvatars, extraMemberCount: $extraMemberCount, pinnedSenderName: $pinnedSenderName, pinnedMessage: $pinnedMessage, pinnedTimeLabel: $pinnedTimeLabel, newExchangeCount: $newExchangeCount)';
}


}

/// @nodoc
abstract mixin class _$ChatsActiveTripPulseCopyWith<$Res> implements $ChatsActiveTripPulseCopyWith<$Res> {
  factory _$ChatsActiveTripPulseCopyWith(_ChatsActiveTripPulse value, $Res Function(_ChatsActiveTripPulse) _then) = __$ChatsActiveTripPulseCopyWithImpl;
@override @useResult
$Res call({
 String tripId, String title, String statusLabel,@JsonKey(fromJson: _readInt) int onlineMemberCount,@JsonKey(fromJson: _readInt) int memberCapacity, List<String> memberAvatars,@JsonKey(fromJson: _readInt) int extraMemberCount, String pinnedSenderName, String pinnedMessage, String pinnedTimeLabel,@JsonKey(fromJson: _readInt) int newExchangeCount
});




}
/// @nodoc
class __$ChatsActiveTripPulseCopyWithImpl<$Res>
    implements _$ChatsActiveTripPulseCopyWith<$Res> {
  __$ChatsActiveTripPulseCopyWithImpl(this._self, this._then);

  final _ChatsActiveTripPulse _self;
  final $Res Function(_ChatsActiveTripPulse) _then;

/// Create a copy of ChatsActiveTripPulse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? tripId = null,Object? title = null,Object? statusLabel = null,Object? onlineMemberCount = null,Object? memberCapacity = null,Object? memberAvatars = null,Object? extraMemberCount = null,Object? pinnedSenderName = null,Object? pinnedMessage = null,Object? pinnedTimeLabel = null,Object? newExchangeCount = null,}) {
  return _then(_ChatsActiveTripPulse(
tripId: null == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,statusLabel: null == statusLabel ? _self.statusLabel : statusLabel // ignore: cast_nullable_to_non_nullable
as String,onlineMemberCount: null == onlineMemberCount ? _self.onlineMemberCount : onlineMemberCount // ignore: cast_nullable_to_non_nullable
as int,memberCapacity: null == memberCapacity ? _self.memberCapacity : memberCapacity // ignore: cast_nullable_to_non_nullable
as int,memberAvatars: null == memberAvatars ? _self._memberAvatars : memberAvatars // ignore: cast_nullable_to_non_nullable
as List<String>,extraMemberCount: null == extraMemberCount ? _self.extraMemberCount : extraMemberCount // ignore: cast_nullable_to_non_nullable
as int,pinnedSenderName: null == pinnedSenderName ? _self.pinnedSenderName : pinnedSenderName // ignore: cast_nullable_to_non_nullable
as String,pinnedMessage: null == pinnedMessage ? _self.pinnedMessage : pinnedMessage // ignore: cast_nullable_to_non_nullable
as String,pinnedTimeLabel: null == pinnedTimeLabel ? _self.pinnedTimeLabel : pinnedTimeLabel // ignore: cast_nullable_to_non_nullable
as String,newExchangeCount: null == newExchangeCount ? _self.newExchangeCount : newExchangeCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$ChatsTripThread {

 String get id; String get tripId; String get title; String get coverUrl; String get badgeIcon; ChatsTripThreadStatus get status;@JsonKey(fromJson: _readInt) int get memberCount; String get memberLabel; String get lastSenderName; String get lastMessage; String get timeLabel;@JsonKey(fromJson: _readInt) int get unreadCount; bool get isReadReceipt; bool get emphasize;
/// Create a copy of ChatsTripThread
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatsTripThreadCopyWith<ChatsTripThread> get copyWith => _$ChatsTripThreadCopyWithImpl<ChatsTripThread>(this as ChatsTripThread, _$identity);

  /// Serializes this ChatsTripThread to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ChatsTripThread;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatsTripThread&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.tripId, _this.tripId) || other.tripId == _this.tripId)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.coverUrl, _this.coverUrl) || other.coverUrl == _this.coverUrl)&&(identical(other.badgeIcon, _this.badgeIcon) || other.badgeIcon == _this.badgeIcon)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.memberCount, _this.memberCount) || other.memberCount == _this.memberCount)&&(identical(other.memberLabel, _this.memberLabel) || other.memberLabel == _this.memberLabel)&&(identical(other.lastSenderName, _this.lastSenderName) || other.lastSenderName == _this.lastSenderName)&&(identical(other.lastMessage, _this.lastMessage) || other.lastMessage == _this.lastMessage)&&(identical(other.timeLabel, _this.timeLabel) || other.timeLabel == _this.timeLabel)&&(identical(other.unreadCount, _this.unreadCount) || other.unreadCount == _this.unreadCount)&&(identical(other.isReadReceipt, _this.isReadReceipt) || other.isReadReceipt == _this.isReadReceipt)&&(identical(other.emphasize, _this.emphasize) || other.emphasize == _this.emphasize));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ChatsTripThread;
  return Object.hash(runtimeType,_this.id,_this.tripId,_this.title,_this.coverUrl,_this.badgeIcon,_this.status,_this.memberCount,_this.memberLabel,_this.lastSenderName,_this.lastMessage,_this.timeLabel,_this.unreadCount,_this.isReadReceipt,_this.emphasize);
}

@override
String toString() {
  final _this = this as ChatsTripThread;
  return 'ChatsTripThread(id: ${_this.id}, tripId: ${_this.tripId}, title: ${_this.title}, coverUrl: ${_this.coverUrl}, badgeIcon: ${_this.badgeIcon}, status: ${_this.status}, memberCount: ${_this.memberCount}, memberLabel: ${_this.memberLabel}, lastSenderName: ${_this.lastSenderName}, lastMessage: ${_this.lastMessage}, timeLabel: ${_this.timeLabel}, unreadCount: ${_this.unreadCount}, isReadReceipt: ${_this.isReadReceipt}, emphasize: ${_this.emphasize})';
}


}

/// @nodoc
abstract mixin class $ChatsTripThreadCopyWith<$Res>  {
  factory $ChatsTripThreadCopyWith(ChatsTripThread value, $Res Function(ChatsTripThread) _then) = _$ChatsTripThreadCopyWithImpl;
@useResult
$Res call({
 String id, String tripId, String title, String coverUrl, String badgeIcon, ChatsTripThreadStatus status,@JsonKey(fromJson: _readInt) int memberCount, String memberLabel, String lastSenderName, String lastMessage, String timeLabel,@JsonKey(fromJson: _readInt) int unreadCount, bool isReadReceipt, bool emphasize
});




}
/// @nodoc
class _$ChatsTripThreadCopyWithImpl<$Res>
    implements $ChatsTripThreadCopyWith<$Res> {
  _$ChatsTripThreadCopyWithImpl(this._self, this._then);

  final ChatsTripThread _self;
  final $Res Function(ChatsTripThread) _then;

/// Create a copy of ChatsTripThread
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? tripId = null,Object? title = null,Object? coverUrl = null,Object? badgeIcon = null,Object? status = null,Object? memberCount = null,Object? memberLabel = null,Object? lastSenderName = null,Object? lastMessage = null,Object? timeLabel = null,Object? unreadCount = null,Object? isReadReceipt = null,Object? emphasize = null,}) {
  return _then(ChatsTripThread(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,tripId: null == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,coverUrl: null == coverUrl ? _self.coverUrl : coverUrl // ignore: cast_nullable_to_non_nullable
as String,badgeIcon: null == badgeIcon ? _self.badgeIcon : badgeIcon // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ChatsTripThreadStatus,memberCount: null == memberCount ? _self.memberCount : memberCount // ignore: cast_nullable_to_non_nullable
as int,memberLabel: null == memberLabel ? _self.memberLabel : memberLabel // ignore: cast_nullable_to_non_nullable
as String,lastSenderName: null == lastSenderName ? _self.lastSenderName : lastSenderName // ignore: cast_nullable_to_non_nullable
as String,lastMessage: null == lastMessage ? _self.lastMessage : lastMessage // ignore: cast_nullable_to_non_nullable
as String,timeLabel: null == timeLabel ? _self.timeLabel : timeLabel // ignore: cast_nullable_to_non_nullable
as String,unreadCount: null == unreadCount ? _self.unreadCount : unreadCount // ignore: cast_nullable_to_non_nullable
as int,isReadReceipt: null == isReadReceipt ? _self.isReadReceipt : isReadReceipt // ignore: cast_nullable_to_non_nullable
as bool,emphasize: null == emphasize ? _self.emphasize : emphasize // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ChatsTripThread].
extension ChatsTripThreadPatterns on ChatsTripThread {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChatsTripThread value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChatsTripThread() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChatsTripThread value)  $default,){
final _that = this;
switch (_that) {
case _ChatsTripThread():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChatsTripThread value)?  $default,){
final _that = this;
switch (_that) {
case _ChatsTripThread() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String tripId,  String title,  String coverUrl,  String badgeIcon,  ChatsTripThreadStatus status, @JsonKey(fromJson: _readInt)  int memberCount,  String memberLabel,  String lastSenderName,  String lastMessage,  String timeLabel, @JsonKey(fromJson: _readInt)  int unreadCount,  bool isReadReceipt,  bool emphasize)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChatsTripThread() when $default != null:
return $default(_that.id,_that.tripId,_that.title,_that.coverUrl,_that.badgeIcon,_that.status,_that.memberCount,_that.memberLabel,_that.lastSenderName,_that.lastMessage,_that.timeLabel,_that.unreadCount,_that.isReadReceipt,_that.emphasize);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String tripId,  String title,  String coverUrl,  String badgeIcon,  ChatsTripThreadStatus status, @JsonKey(fromJson: _readInt)  int memberCount,  String memberLabel,  String lastSenderName,  String lastMessage,  String timeLabel, @JsonKey(fromJson: _readInt)  int unreadCount,  bool isReadReceipt,  bool emphasize)  $default,) {final _that = this;
switch (_that) {
case _ChatsTripThread():
return $default(_that.id,_that.tripId,_that.title,_that.coverUrl,_that.badgeIcon,_that.status,_that.memberCount,_that.memberLabel,_that.lastSenderName,_that.lastMessage,_that.timeLabel,_that.unreadCount,_that.isReadReceipt,_that.emphasize);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String tripId,  String title,  String coverUrl,  String badgeIcon,  ChatsTripThreadStatus status, @JsonKey(fromJson: _readInt)  int memberCount,  String memberLabel,  String lastSenderName,  String lastMessage,  String timeLabel, @JsonKey(fromJson: _readInt)  int unreadCount,  bool isReadReceipt,  bool emphasize)?  $default,) {final _that = this;
switch (_that) {
case _ChatsTripThread() when $default != null:
return $default(_that.id,_that.tripId,_that.title,_that.coverUrl,_that.badgeIcon,_that.status,_that.memberCount,_that.memberLabel,_that.lastSenderName,_that.lastMessage,_that.timeLabel,_that.unreadCount,_that.isReadReceipt,_that.emphasize);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChatsTripThread implements ChatsTripThread {
  const _ChatsTripThread({required this.id, required this.tripId, required this.title, required this.coverUrl, required this.badgeIcon, required this.status, @JsonKey(fromJson: _readInt) required this.memberCount, required this.memberLabel, required this.lastSenderName, required this.lastMessage, required this.timeLabel, @JsonKey(fromJson: _readInt) this.unreadCount = 0, this.isReadReceipt = false, this.emphasize = false});
  factory _ChatsTripThread.fromJson(Map<String, dynamic> json) => _$ChatsTripThreadFromJson(json);

@override final  String id;
@override final  String tripId;
@override final  String title;
@override final  String coverUrl;
@override final  String badgeIcon;
@override final  ChatsTripThreadStatus status;
@override@JsonKey(fromJson: _readInt) final  int memberCount;
@override final  String memberLabel;
@override final  String lastSenderName;
@override final  String lastMessage;
@override final  String timeLabel;
@override@JsonKey(fromJson: _readInt) final  int unreadCount;
@override@JsonKey() final  bool isReadReceipt;
@override@JsonKey() final  bool emphasize;

/// Create a copy of ChatsTripThread
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatsTripThreadCopyWith<_ChatsTripThread> get copyWith => __$ChatsTripThreadCopyWithImpl<_ChatsTripThread>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChatsTripThreadToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatsTripThread&&(identical(other.id, id) || other.id == id)&&(identical(other.tripId, tripId) || other.tripId == tripId)&&(identical(other.title, title) || other.title == title)&&(identical(other.coverUrl, coverUrl) || other.coverUrl == coverUrl)&&(identical(other.badgeIcon, badgeIcon) || other.badgeIcon == badgeIcon)&&(identical(other.status, status) || other.status == status)&&(identical(other.memberCount, memberCount) || other.memberCount == memberCount)&&(identical(other.memberLabel, memberLabel) || other.memberLabel == memberLabel)&&(identical(other.lastSenderName, lastSenderName) || other.lastSenderName == lastSenderName)&&(identical(other.lastMessage, lastMessage) || other.lastMessage == lastMessage)&&(identical(other.timeLabel, timeLabel) || other.timeLabel == timeLabel)&&(identical(other.unreadCount, unreadCount) || other.unreadCount == unreadCount)&&(identical(other.isReadReceipt, isReadReceipt) || other.isReadReceipt == isReadReceipt)&&(identical(other.emphasize, emphasize) || other.emphasize == emphasize));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,tripId,title,coverUrl,badgeIcon,status,memberCount,memberLabel,lastSenderName,lastMessage,timeLabel,unreadCount,isReadReceipt,emphasize);
}

@override
String toString() {
    return 'ChatsTripThread(id: $id, tripId: $tripId, title: $title, coverUrl: $coverUrl, badgeIcon: $badgeIcon, status: $status, memberCount: $memberCount, memberLabel: $memberLabel, lastSenderName: $lastSenderName, lastMessage: $lastMessage, timeLabel: $timeLabel, unreadCount: $unreadCount, isReadReceipt: $isReadReceipt, emphasize: $emphasize)';
}


}

/// @nodoc
abstract mixin class _$ChatsTripThreadCopyWith<$Res> implements $ChatsTripThreadCopyWith<$Res> {
  factory _$ChatsTripThreadCopyWith(_ChatsTripThread value, $Res Function(_ChatsTripThread) _then) = __$ChatsTripThreadCopyWithImpl;
@override @useResult
$Res call({
 String id, String tripId, String title, String coverUrl, String badgeIcon, ChatsTripThreadStatus status,@JsonKey(fromJson: _readInt) int memberCount, String memberLabel, String lastSenderName, String lastMessage, String timeLabel,@JsonKey(fromJson: _readInt) int unreadCount, bool isReadReceipt, bool emphasize
});




}
/// @nodoc
class __$ChatsTripThreadCopyWithImpl<$Res>
    implements _$ChatsTripThreadCopyWith<$Res> {
  __$ChatsTripThreadCopyWithImpl(this._self, this._then);

  final _ChatsTripThread _self;
  final $Res Function(_ChatsTripThread) _then;

/// Create a copy of ChatsTripThread
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? tripId = null,Object? title = null,Object? coverUrl = null,Object? badgeIcon = null,Object? status = null,Object? memberCount = null,Object? memberLabel = null,Object? lastSenderName = null,Object? lastMessage = null,Object? timeLabel = null,Object? unreadCount = null,Object? isReadReceipt = null,Object? emphasize = null,}) {
  return _then(_ChatsTripThread(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,tripId: null == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,coverUrl: null == coverUrl ? _self.coverUrl : coverUrl // ignore: cast_nullable_to_non_nullable
as String,badgeIcon: null == badgeIcon ? _self.badgeIcon : badgeIcon // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ChatsTripThreadStatus,memberCount: null == memberCount ? _self.memberCount : memberCount // ignore: cast_nullable_to_non_nullable
as int,memberLabel: null == memberLabel ? _self.memberLabel : memberLabel // ignore: cast_nullable_to_non_nullable
as String,lastSenderName: null == lastSenderName ? _self.lastSenderName : lastSenderName // ignore: cast_nullable_to_non_nullable
as String,lastMessage: null == lastMessage ? _self.lastMessage : lastMessage // ignore: cast_nullable_to_non_nullable
as String,timeLabel: null == timeLabel ? _self.timeLabel : timeLabel // ignore: cast_nullable_to_non_nullable
as String,unreadCount: null == unreadCount ? _self.unreadCount : unreadCount // ignore: cast_nullable_to_non_nullable
as int,isReadReceipt: null == isReadReceipt ? _self.isReadReceipt : isReadReceipt // ignore: cast_nullable_to_non_nullable
as bool,emphasize: null == emphasize ? _self.emphasize : emphasize // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$ChatsFriendThread {

 String get id; String get conversationId; String get peerUserId; String get displayName; String? get avatarUrl; String? get roleBadge; ChatsFriendRoleTone? get roleTone; bool get isOnline; String get lastMessage; String get timeLabel;@JsonKey(fromJson: _readInt) int get unreadCount; bool get timeEmphasized;
/// Create a copy of ChatsFriendThread
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatsFriendThreadCopyWith<ChatsFriendThread> get copyWith => _$ChatsFriendThreadCopyWithImpl<ChatsFriendThread>(this as ChatsFriendThread, _$identity);

  /// Serializes this ChatsFriendThread to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ChatsFriendThread;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatsFriendThread&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.conversationId, _this.conversationId) || other.conversationId == _this.conversationId)&&(identical(other.peerUserId, _this.peerUserId) || other.peerUserId == _this.peerUserId)&&(identical(other.displayName, _this.displayName) || other.displayName == _this.displayName)&&(identical(other.avatarUrl, _this.avatarUrl) || other.avatarUrl == _this.avatarUrl)&&(identical(other.roleBadge, _this.roleBadge) || other.roleBadge == _this.roleBadge)&&(identical(other.roleTone, _this.roleTone) || other.roleTone == _this.roleTone)&&(identical(other.isOnline, _this.isOnline) || other.isOnline == _this.isOnline)&&(identical(other.lastMessage, _this.lastMessage) || other.lastMessage == _this.lastMessage)&&(identical(other.timeLabel, _this.timeLabel) || other.timeLabel == _this.timeLabel)&&(identical(other.unreadCount, _this.unreadCount) || other.unreadCount == _this.unreadCount)&&(identical(other.timeEmphasized, _this.timeEmphasized) || other.timeEmphasized == _this.timeEmphasized));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ChatsFriendThread;
  return Object.hash(runtimeType,_this.id,_this.conversationId,_this.peerUserId,_this.displayName,_this.avatarUrl,_this.roleBadge,_this.roleTone,_this.isOnline,_this.lastMessage,_this.timeLabel,_this.unreadCount,_this.timeEmphasized);
}

@override
String toString() {
  final _this = this as ChatsFriendThread;
  return 'ChatsFriendThread(id: ${_this.id}, conversationId: ${_this.conversationId}, peerUserId: ${_this.peerUserId}, displayName: ${_this.displayName}, avatarUrl: ${_this.avatarUrl}, roleBadge: ${_this.roleBadge}, roleTone: ${_this.roleTone}, isOnline: ${_this.isOnline}, lastMessage: ${_this.lastMessage}, timeLabel: ${_this.timeLabel}, unreadCount: ${_this.unreadCount}, timeEmphasized: ${_this.timeEmphasized})';
}


}

/// @nodoc
abstract mixin class $ChatsFriendThreadCopyWith<$Res>  {
  factory $ChatsFriendThreadCopyWith(ChatsFriendThread value, $Res Function(ChatsFriendThread) _then) = _$ChatsFriendThreadCopyWithImpl;
@useResult
$Res call({
 String id, String conversationId, String peerUserId, String displayName, String? avatarUrl, String? roleBadge, ChatsFriendRoleTone? roleTone, bool isOnline, String lastMessage, String timeLabel,@JsonKey(fromJson: _readInt) int unreadCount, bool timeEmphasized
});




}
/// @nodoc
class _$ChatsFriendThreadCopyWithImpl<$Res>
    implements $ChatsFriendThreadCopyWith<$Res> {
  _$ChatsFriendThreadCopyWithImpl(this._self, this._then);

  final ChatsFriendThread _self;
  final $Res Function(ChatsFriendThread) _then;

/// Create a copy of ChatsFriendThread
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? conversationId = null,Object? peerUserId = null,Object? displayName = null,Object? avatarUrl = freezed,Object? roleBadge = freezed,Object? roleTone = freezed,Object? isOnline = null,Object? lastMessage = null,Object? timeLabel = null,Object? unreadCount = null,Object? timeEmphasized = null,}) {
  return _then(ChatsFriendThread(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,conversationId: null == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as String,peerUserId: null == peerUserId ? _self.peerUserId : peerUserId // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,roleBadge: freezed == roleBadge ? _self.roleBadge : roleBadge // ignore: cast_nullable_to_non_nullable
as String?,roleTone: freezed == roleTone ? _self.roleTone : roleTone // ignore: cast_nullable_to_non_nullable
as ChatsFriendRoleTone?,isOnline: null == isOnline ? _self.isOnline : isOnline // ignore: cast_nullable_to_non_nullable
as bool,lastMessage: null == lastMessage ? _self.lastMessage : lastMessage // ignore: cast_nullable_to_non_nullable
as String,timeLabel: null == timeLabel ? _self.timeLabel : timeLabel // ignore: cast_nullable_to_non_nullable
as String,unreadCount: null == unreadCount ? _self.unreadCount : unreadCount // ignore: cast_nullable_to_non_nullable
as int,timeEmphasized: null == timeEmphasized ? _self.timeEmphasized : timeEmphasized // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ChatsFriendThread].
extension ChatsFriendThreadPatterns on ChatsFriendThread {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChatsFriendThread value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChatsFriendThread() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChatsFriendThread value)  $default,){
final _that = this;
switch (_that) {
case _ChatsFriendThread():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChatsFriendThread value)?  $default,){
final _that = this;
switch (_that) {
case _ChatsFriendThread() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String conversationId,  String peerUserId,  String displayName,  String? avatarUrl,  String? roleBadge,  ChatsFriendRoleTone? roleTone,  bool isOnline,  String lastMessage,  String timeLabel, @JsonKey(fromJson: _readInt)  int unreadCount,  bool timeEmphasized)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChatsFriendThread() when $default != null:
return $default(_that.id,_that.conversationId,_that.peerUserId,_that.displayName,_that.avatarUrl,_that.roleBadge,_that.roleTone,_that.isOnline,_that.lastMessage,_that.timeLabel,_that.unreadCount,_that.timeEmphasized);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String conversationId,  String peerUserId,  String displayName,  String? avatarUrl,  String? roleBadge,  ChatsFriendRoleTone? roleTone,  bool isOnline,  String lastMessage,  String timeLabel, @JsonKey(fromJson: _readInt)  int unreadCount,  bool timeEmphasized)  $default,) {final _that = this;
switch (_that) {
case _ChatsFriendThread():
return $default(_that.id,_that.conversationId,_that.peerUserId,_that.displayName,_that.avatarUrl,_that.roleBadge,_that.roleTone,_that.isOnline,_that.lastMessage,_that.timeLabel,_that.unreadCount,_that.timeEmphasized);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String conversationId,  String peerUserId,  String displayName,  String? avatarUrl,  String? roleBadge,  ChatsFriendRoleTone? roleTone,  bool isOnline,  String lastMessage,  String timeLabel, @JsonKey(fromJson: _readInt)  int unreadCount,  bool timeEmphasized)?  $default,) {final _that = this;
switch (_that) {
case _ChatsFriendThread() when $default != null:
return $default(_that.id,_that.conversationId,_that.peerUserId,_that.displayName,_that.avatarUrl,_that.roleBadge,_that.roleTone,_that.isOnline,_that.lastMessage,_that.timeLabel,_that.unreadCount,_that.timeEmphasized);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChatsFriendThread implements ChatsFriendThread {
  const _ChatsFriendThread({required this.id, required this.conversationId, required this.peerUserId, required this.displayName, this.avatarUrl, this.roleBadge, this.roleTone, this.isOnline = false, required this.lastMessage, required this.timeLabel, @JsonKey(fromJson: _readInt) this.unreadCount = 0, this.timeEmphasized = false});
  factory _ChatsFriendThread.fromJson(Map<String, dynamic> json) => _$ChatsFriendThreadFromJson(json);

@override final  String id;
@override final  String conversationId;
@override final  String peerUserId;
@override final  String displayName;
@override final  String? avatarUrl;
@override final  String? roleBadge;
@override final  ChatsFriendRoleTone? roleTone;
@override@JsonKey() final  bool isOnline;
@override final  String lastMessage;
@override final  String timeLabel;
@override@JsonKey(fromJson: _readInt) final  int unreadCount;
@override@JsonKey() final  bool timeEmphasized;

/// Create a copy of ChatsFriendThread
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatsFriendThreadCopyWith<_ChatsFriendThread> get copyWith => __$ChatsFriendThreadCopyWithImpl<_ChatsFriendThread>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChatsFriendThreadToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatsFriendThread&&(identical(other.id, id) || other.id == id)&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId)&&(identical(other.peerUserId, peerUserId) || other.peerUserId == peerUserId)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.roleBadge, roleBadge) || other.roleBadge == roleBadge)&&(identical(other.roleTone, roleTone) || other.roleTone == roleTone)&&(identical(other.isOnline, isOnline) || other.isOnline == isOnline)&&(identical(other.lastMessage, lastMessage) || other.lastMessage == lastMessage)&&(identical(other.timeLabel, timeLabel) || other.timeLabel == timeLabel)&&(identical(other.unreadCount, unreadCount) || other.unreadCount == unreadCount)&&(identical(other.timeEmphasized, timeEmphasized) || other.timeEmphasized == timeEmphasized));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,conversationId,peerUserId,displayName,avatarUrl,roleBadge,roleTone,isOnline,lastMessage,timeLabel,unreadCount,timeEmphasized);
}

@override
String toString() {
    return 'ChatsFriendThread(id: $id, conversationId: $conversationId, peerUserId: $peerUserId, displayName: $displayName, avatarUrl: $avatarUrl, roleBadge: $roleBadge, roleTone: $roleTone, isOnline: $isOnline, lastMessage: $lastMessage, timeLabel: $timeLabel, unreadCount: $unreadCount, timeEmphasized: $timeEmphasized)';
}


}

/// @nodoc
abstract mixin class _$ChatsFriendThreadCopyWith<$Res> implements $ChatsFriendThreadCopyWith<$Res> {
  factory _$ChatsFriendThreadCopyWith(_ChatsFriendThread value, $Res Function(_ChatsFriendThread) _then) = __$ChatsFriendThreadCopyWithImpl;
@override @useResult
$Res call({
 String id, String conversationId, String peerUserId, String displayName, String? avatarUrl, String? roleBadge, ChatsFriendRoleTone? roleTone, bool isOnline, String lastMessage, String timeLabel,@JsonKey(fromJson: _readInt) int unreadCount, bool timeEmphasized
});




}
/// @nodoc
class __$ChatsFriendThreadCopyWithImpl<$Res>
    implements _$ChatsFriendThreadCopyWith<$Res> {
  __$ChatsFriendThreadCopyWithImpl(this._self, this._then);

  final _ChatsFriendThread _self;
  final $Res Function(_ChatsFriendThread) _then;

/// Create a copy of ChatsFriendThread
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? conversationId = null,Object? peerUserId = null,Object? displayName = null,Object? avatarUrl = freezed,Object? roleBadge = freezed,Object? roleTone = freezed,Object? isOnline = null,Object? lastMessage = null,Object? timeLabel = null,Object? unreadCount = null,Object? timeEmphasized = null,}) {
  return _then(_ChatsFriendThread(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,conversationId: null == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as String,peerUserId: null == peerUserId ? _self.peerUserId : peerUserId // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,roleBadge: freezed == roleBadge ? _self.roleBadge : roleBadge // ignore: cast_nullable_to_non_nullable
as String?,roleTone: freezed == roleTone ? _self.roleTone : roleTone // ignore: cast_nullable_to_non_nullable
as ChatsFriendRoleTone?,isOnline: null == isOnline ? _self.isOnline : isOnline // ignore: cast_nullable_to_non_nullable
as bool,lastMessage: null == lastMessage ? _self.lastMessage : lastMessage // ignore: cast_nullable_to_non_nullable
as String,timeLabel: null == timeLabel ? _self.timeLabel : timeLabel // ignore: cast_nullable_to_non_nullable
as String,unreadCount: null == unreadCount ? _self.unreadCount : unreadCount // ignore: cast_nullable_to_non_nullable
as int,timeEmphasized: null == timeEmphasized ? _self.timeEmphasized : timeEmphasized // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
