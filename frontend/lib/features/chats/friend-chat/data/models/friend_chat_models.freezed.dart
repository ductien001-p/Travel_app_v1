// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'friend_chat_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FriendChatThread {

 String get conversationId; FriendChatPeer get peer; FriendChatSharedTrip? get sharedTrip; String get dateLabel; List<FriendChatMessage> get messages; bool get isPeerTyping; String? get typingLabel; List<FriendChatShortcut> get shortcuts; List<FriendChatInviteCandidate> get inviteCandidates;
/// Create a copy of FriendChatThread
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FriendChatThreadCopyWith<FriendChatThread> get copyWith => _$FriendChatThreadCopyWithImpl<FriendChatThread>(this as FriendChatThread, _$identity);

  /// Serializes this FriendChatThread to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as FriendChatThread;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FriendChatThread&&(identical(other.conversationId, _this.conversationId) || other.conversationId == _this.conversationId)&&(identical(other.peer, _this.peer) || other.peer == _this.peer)&&(identical(other.sharedTrip, _this.sharedTrip) || other.sharedTrip == _this.sharedTrip)&&(identical(other.dateLabel, _this.dateLabel) || other.dateLabel == _this.dateLabel)&&const DeepCollectionEquality().equals(other.messages, _this.messages)&&(identical(other.isPeerTyping, _this.isPeerTyping) || other.isPeerTyping == _this.isPeerTyping)&&(identical(other.typingLabel, _this.typingLabel) || other.typingLabel == _this.typingLabel)&&const DeepCollectionEquality().equals(other.shortcuts, _this.shortcuts)&&const DeepCollectionEquality().equals(other.inviteCandidates, _this.inviteCandidates));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as FriendChatThread;
  return Object.hash(runtimeType,_this.conversationId,_this.peer,_this.sharedTrip,_this.dateLabel,const DeepCollectionEquality().hash(_this.messages),_this.isPeerTyping,_this.typingLabel,const DeepCollectionEquality().hash(_this.shortcuts),const DeepCollectionEquality().hash(_this.inviteCandidates));
}

@override
String toString() {
  final _this = this as FriendChatThread;
  return 'FriendChatThread(conversationId: ${_this.conversationId}, peer: ${_this.peer}, sharedTrip: ${_this.sharedTrip}, dateLabel: ${_this.dateLabel}, messages: ${_this.messages}, isPeerTyping: ${_this.isPeerTyping}, typingLabel: ${_this.typingLabel}, shortcuts: ${_this.shortcuts}, inviteCandidates: ${_this.inviteCandidates})';
}


}

/// @nodoc
abstract mixin class $FriendChatThreadCopyWith<$Res>  {
  factory $FriendChatThreadCopyWith(FriendChatThread value, $Res Function(FriendChatThread) _then) = _$FriendChatThreadCopyWithImpl;
@useResult
$Res call({
 String conversationId, FriendChatPeer peer, FriendChatSharedTrip? sharedTrip, String dateLabel, List<FriendChatMessage> messages, bool isPeerTyping, String? typingLabel, List<FriendChatShortcut> shortcuts, List<FriendChatInviteCandidate> inviteCandidates
});


$FriendChatPeerCopyWith<$Res> get peer;$FriendChatSharedTripCopyWith<$Res>? get sharedTrip;

}
/// @nodoc
class _$FriendChatThreadCopyWithImpl<$Res>
    implements $FriendChatThreadCopyWith<$Res> {
  _$FriendChatThreadCopyWithImpl(this._self, this._then);

  final FriendChatThread _self;
  final $Res Function(FriendChatThread) _then;

/// Create a copy of FriendChatThread
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? conversationId = null,Object? peer = null,Object? sharedTrip = freezed,Object? dateLabel = null,Object? messages = null,Object? isPeerTyping = null,Object? typingLabel = freezed,Object? shortcuts = null,Object? inviteCandidates = null,}) {
  return _then(FriendChatThread(
conversationId: null == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as String,peer: null == peer ? _self.peer : peer // ignore: cast_nullable_to_non_nullable
as FriendChatPeer,sharedTrip: freezed == sharedTrip ? _self.sharedTrip : sharedTrip // ignore: cast_nullable_to_non_nullable
as FriendChatSharedTrip?,dateLabel: null == dateLabel ? _self.dateLabel : dateLabel // ignore: cast_nullable_to_non_nullable
as String,messages: null == messages ? _self.messages : messages // ignore: cast_nullable_to_non_nullable
as List<FriendChatMessage>,isPeerTyping: null == isPeerTyping ? _self.isPeerTyping : isPeerTyping // ignore: cast_nullable_to_non_nullable
as bool,typingLabel: freezed == typingLabel ? _self.typingLabel : typingLabel // ignore: cast_nullable_to_non_nullable
as String?,shortcuts: null == shortcuts ? _self.shortcuts : shortcuts // ignore: cast_nullable_to_non_nullable
as List<FriendChatShortcut>,inviteCandidates: null == inviteCandidates ? _self.inviteCandidates : inviteCandidates // ignore: cast_nullable_to_non_nullable
as List<FriendChatInviteCandidate>,
  ));
}
/// Create a copy of FriendChatThread
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FriendChatPeerCopyWith<$Res> get peer {
  
  return $FriendChatPeerCopyWith<$Res>(_self.peer, (value) {
    return _then(_self.copyWith(peer: value));
  });
}/// Create a copy of FriendChatThread
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FriendChatSharedTripCopyWith<$Res>? get sharedTrip {
    if (_self.sharedTrip == null) {
    return null;
  }

  return $FriendChatSharedTripCopyWith<$Res>(_self.sharedTrip!, (value) {
    return _then(_self.copyWith(sharedTrip: value));
  });
}
}


/// Adds pattern-matching-related methods to [FriendChatThread].
extension FriendChatThreadPatterns on FriendChatThread {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FriendChatThread value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FriendChatThread() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FriendChatThread value)  $default,){
final _that = this;
switch (_that) {
case _FriendChatThread():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FriendChatThread value)?  $default,){
final _that = this;
switch (_that) {
case _FriendChatThread() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String conversationId,  FriendChatPeer peer,  FriendChatSharedTrip? sharedTrip,  String dateLabel,  List<FriendChatMessage> messages,  bool isPeerTyping,  String? typingLabel,  List<FriendChatShortcut> shortcuts,  List<FriendChatInviteCandidate> inviteCandidates)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FriendChatThread() when $default != null:
return $default(_that.conversationId,_that.peer,_that.sharedTrip,_that.dateLabel,_that.messages,_that.isPeerTyping,_that.typingLabel,_that.shortcuts,_that.inviteCandidates);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String conversationId,  FriendChatPeer peer,  FriendChatSharedTrip? sharedTrip,  String dateLabel,  List<FriendChatMessage> messages,  bool isPeerTyping,  String? typingLabel,  List<FriendChatShortcut> shortcuts,  List<FriendChatInviteCandidate> inviteCandidates)  $default,) {final _that = this;
switch (_that) {
case _FriendChatThread():
return $default(_that.conversationId,_that.peer,_that.sharedTrip,_that.dateLabel,_that.messages,_that.isPeerTyping,_that.typingLabel,_that.shortcuts,_that.inviteCandidates);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String conversationId,  FriendChatPeer peer,  FriendChatSharedTrip? sharedTrip,  String dateLabel,  List<FriendChatMessage> messages,  bool isPeerTyping,  String? typingLabel,  List<FriendChatShortcut> shortcuts,  List<FriendChatInviteCandidate> inviteCandidates)?  $default,) {final _that = this;
switch (_that) {
case _FriendChatThread() when $default != null:
return $default(_that.conversationId,_that.peer,_that.sharedTrip,_that.dateLabel,_that.messages,_that.isPeerTyping,_that.typingLabel,_that.shortcuts,_that.inviteCandidates);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FriendChatThread implements FriendChatThread {
  const _FriendChatThread({required this.conversationId, required this.peer, this.sharedTrip, required this.dateLabel,  List<FriendChatMessage> messages = const <FriendChatMessage>[], this.isPeerTyping = false, this.typingLabel,  List<FriendChatShortcut> shortcuts = const <FriendChatShortcut>[],  List<FriendChatInviteCandidate> inviteCandidates = const <FriendChatInviteCandidate>[]}): _messages = messages,_shortcuts = shortcuts,_inviteCandidates = inviteCandidates;
  factory _FriendChatThread.fromJson(Map<String, dynamic> json) => _$FriendChatThreadFromJson(json);

@override final  String conversationId;
@override final  FriendChatPeer peer;
@override final  FriendChatSharedTrip? sharedTrip;
@override final  String dateLabel;
 final  List<FriendChatMessage> _messages;
@override@JsonKey() List<FriendChatMessage> get messages {
  if (_messages is EqualUnmodifiableListView) return _messages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_messages);
}

@override@JsonKey() final  bool isPeerTyping;
@override final  String? typingLabel;
 final  List<FriendChatShortcut> _shortcuts;
@override@JsonKey() List<FriendChatShortcut> get shortcuts {
  if (_shortcuts is EqualUnmodifiableListView) return _shortcuts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_shortcuts);
}

 final  List<FriendChatInviteCandidate> _inviteCandidates;
@override@JsonKey() List<FriendChatInviteCandidate> get inviteCandidates {
  if (_inviteCandidates is EqualUnmodifiableListView) return _inviteCandidates;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_inviteCandidates);
}


/// Create a copy of FriendChatThread
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FriendChatThreadCopyWith<_FriendChatThread> get copyWith => __$FriendChatThreadCopyWithImpl<_FriendChatThread>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FriendChatThreadToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _FriendChatThread&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId)&&(identical(other.peer, peer) || other.peer == peer)&&(identical(other.sharedTrip, sharedTrip) || other.sharedTrip == sharedTrip)&&(identical(other.dateLabel, dateLabel) || other.dateLabel == dateLabel)&&const DeepCollectionEquality().equals(other.messages, _messages)&&(identical(other.isPeerTyping, isPeerTyping) || other.isPeerTyping == isPeerTyping)&&(identical(other.typingLabel, typingLabel) || other.typingLabel == typingLabel)&&const DeepCollectionEquality().equals(other.shortcuts, _shortcuts)&&const DeepCollectionEquality().equals(other.inviteCandidates, _inviteCandidates));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,conversationId,peer,sharedTrip,dateLabel,const DeepCollectionEquality().hash(_messages),isPeerTyping,typingLabel,const DeepCollectionEquality().hash(_shortcuts),const DeepCollectionEquality().hash(_inviteCandidates));
}

@override
String toString() {
    return 'FriendChatThread(conversationId: $conversationId, peer: $peer, sharedTrip: $sharedTrip, dateLabel: $dateLabel, messages: $messages, isPeerTyping: $isPeerTyping, typingLabel: $typingLabel, shortcuts: $shortcuts, inviteCandidates: $inviteCandidates)';
}


}

/// @nodoc
abstract mixin class _$FriendChatThreadCopyWith<$Res> implements $FriendChatThreadCopyWith<$Res> {
  factory _$FriendChatThreadCopyWith(_FriendChatThread value, $Res Function(_FriendChatThread) _then) = __$FriendChatThreadCopyWithImpl;
@override @useResult
$Res call({
 String conversationId, FriendChatPeer peer, FriendChatSharedTrip? sharedTrip, String dateLabel, List<FriendChatMessage> messages, bool isPeerTyping, String? typingLabel, List<FriendChatShortcut> shortcuts, List<FriendChatInviteCandidate> inviteCandidates
});


@override $FriendChatPeerCopyWith<$Res> get peer;@override $FriendChatSharedTripCopyWith<$Res>? get sharedTrip;

}
/// @nodoc
class __$FriendChatThreadCopyWithImpl<$Res>
    implements _$FriendChatThreadCopyWith<$Res> {
  __$FriendChatThreadCopyWithImpl(this._self, this._then);

  final _FriendChatThread _self;
  final $Res Function(_FriendChatThread) _then;

/// Create a copy of FriendChatThread
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? conversationId = null,Object? peer = null,Object? sharedTrip = freezed,Object? dateLabel = null,Object? messages = null,Object? isPeerTyping = null,Object? typingLabel = freezed,Object? shortcuts = null,Object? inviteCandidates = null,}) {
  return _then(_FriendChatThread(
conversationId: null == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as String,peer: null == peer ? _self.peer : peer // ignore: cast_nullable_to_non_nullable
as FriendChatPeer,sharedTrip: freezed == sharedTrip ? _self.sharedTrip : sharedTrip // ignore: cast_nullable_to_non_nullable
as FriendChatSharedTrip?,dateLabel: null == dateLabel ? _self.dateLabel : dateLabel // ignore: cast_nullable_to_non_nullable
as String,messages: null == messages ? _self._messages : messages // ignore: cast_nullable_to_non_nullable
as List<FriendChatMessage>,isPeerTyping: null == isPeerTyping ? _self.isPeerTyping : isPeerTyping // ignore: cast_nullable_to_non_nullable
as bool,typingLabel: freezed == typingLabel ? _self.typingLabel : typingLabel // ignore: cast_nullable_to_non_nullable
as String?,shortcuts: null == shortcuts ? _self._shortcuts : shortcuts // ignore: cast_nullable_to_non_nullable
as List<FriendChatShortcut>,inviteCandidates: null == inviteCandidates ? _self._inviteCandidates : inviteCandidates // ignore: cast_nullable_to_non_nullable
as List<FriendChatInviteCandidate>,
  ));
}

/// Create a copy of FriendChatThread
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FriendChatPeerCopyWith<$Res> get peer {
  
  return $FriendChatPeerCopyWith<$Res>(_self.peer, (value) {
    return _then(_self.copyWith(peer: value));
  });
}/// Create a copy of FriendChatThread
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FriendChatSharedTripCopyWith<$Res>? get sharedTrip {
    if (_self.sharedTrip == null) {
    return null;
  }

  return $FriendChatSharedTripCopyWith<$Res>(_self.sharedTrip!, (value) {
    return _then(_self.copyWith(sharedTrip: value));
  });
}
}


/// @nodoc
mixin _$FriendChatPeer {

 String get userId; String get displayName; String? get avatarUrl; String? get roleBadge; bool get isOnline; String? get presenceLabel; String? get sharedTripsLabel;
/// Create a copy of FriendChatPeer
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FriendChatPeerCopyWith<FriendChatPeer> get copyWith => _$FriendChatPeerCopyWithImpl<FriendChatPeer>(this as FriendChatPeer, _$identity);

  /// Serializes this FriendChatPeer to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as FriendChatPeer;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FriendChatPeer&&(identical(other.userId, _this.userId) || other.userId == _this.userId)&&(identical(other.displayName, _this.displayName) || other.displayName == _this.displayName)&&(identical(other.avatarUrl, _this.avatarUrl) || other.avatarUrl == _this.avatarUrl)&&(identical(other.roleBadge, _this.roleBadge) || other.roleBadge == _this.roleBadge)&&(identical(other.isOnline, _this.isOnline) || other.isOnline == _this.isOnline)&&(identical(other.presenceLabel, _this.presenceLabel) || other.presenceLabel == _this.presenceLabel)&&(identical(other.sharedTripsLabel, _this.sharedTripsLabel) || other.sharedTripsLabel == _this.sharedTripsLabel));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as FriendChatPeer;
  return Object.hash(runtimeType,_this.userId,_this.displayName,_this.avatarUrl,_this.roleBadge,_this.isOnline,_this.presenceLabel,_this.sharedTripsLabel);
}

@override
String toString() {
  final _this = this as FriendChatPeer;
  return 'FriendChatPeer(userId: ${_this.userId}, displayName: ${_this.displayName}, avatarUrl: ${_this.avatarUrl}, roleBadge: ${_this.roleBadge}, isOnline: ${_this.isOnline}, presenceLabel: ${_this.presenceLabel}, sharedTripsLabel: ${_this.sharedTripsLabel})';
}


}

/// @nodoc
abstract mixin class $FriendChatPeerCopyWith<$Res>  {
  factory $FriendChatPeerCopyWith(FriendChatPeer value, $Res Function(FriendChatPeer) _then) = _$FriendChatPeerCopyWithImpl;
@useResult
$Res call({
 String userId, String displayName, String? avatarUrl, String? roleBadge, bool isOnline, String? presenceLabel, String? sharedTripsLabel
});




}
/// @nodoc
class _$FriendChatPeerCopyWithImpl<$Res>
    implements $FriendChatPeerCopyWith<$Res> {
  _$FriendChatPeerCopyWithImpl(this._self, this._then);

  final FriendChatPeer _self;
  final $Res Function(FriendChatPeer) _then;

/// Create a copy of FriendChatPeer
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? displayName = null,Object? avatarUrl = freezed,Object? roleBadge = freezed,Object? isOnline = null,Object? presenceLabel = freezed,Object? sharedTripsLabel = freezed,}) {
  return _then(FriendChatPeer(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,roleBadge: freezed == roleBadge ? _self.roleBadge : roleBadge // ignore: cast_nullable_to_non_nullable
as String?,isOnline: null == isOnline ? _self.isOnline : isOnline // ignore: cast_nullable_to_non_nullable
as bool,presenceLabel: freezed == presenceLabel ? _self.presenceLabel : presenceLabel // ignore: cast_nullable_to_non_nullable
as String?,sharedTripsLabel: freezed == sharedTripsLabel ? _self.sharedTripsLabel : sharedTripsLabel // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [FriendChatPeer].
extension FriendChatPeerPatterns on FriendChatPeer {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FriendChatPeer value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FriendChatPeer() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FriendChatPeer value)  $default,){
final _that = this;
switch (_that) {
case _FriendChatPeer():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FriendChatPeer value)?  $default,){
final _that = this;
switch (_that) {
case _FriendChatPeer() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String userId,  String displayName,  String? avatarUrl,  String? roleBadge,  bool isOnline,  String? presenceLabel,  String? sharedTripsLabel)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FriendChatPeer() when $default != null:
return $default(_that.userId,_that.displayName,_that.avatarUrl,_that.roleBadge,_that.isOnline,_that.presenceLabel,_that.sharedTripsLabel);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String userId,  String displayName,  String? avatarUrl,  String? roleBadge,  bool isOnline,  String? presenceLabel,  String? sharedTripsLabel)  $default,) {final _that = this;
switch (_that) {
case _FriendChatPeer():
return $default(_that.userId,_that.displayName,_that.avatarUrl,_that.roleBadge,_that.isOnline,_that.presenceLabel,_that.sharedTripsLabel);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String userId,  String displayName,  String? avatarUrl,  String? roleBadge,  bool isOnline,  String? presenceLabel,  String? sharedTripsLabel)?  $default,) {final _that = this;
switch (_that) {
case _FriendChatPeer() when $default != null:
return $default(_that.userId,_that.displayName,_that.avatarUrl,_that.roleBadge,_that.isOnline,_that.presenceLabel,_that.sharedTripsLabel);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FriendChatPeer implements FriendChatPeer {
  const _FriendChatPeer({required this.userId, required this.displayName, this.avatarUrl, this.roleBadge, this.isOnline = false, this.presenceLabel, this.sharedTripsLabel});
  factory _FriendChatPeer.fromJson(Map<String, dynamic> json) => _$FriendChatPeerFromJson(json);

@override final  String userId;
@override final  String displayName;
@override final  String? avatarUrl;
@override final  String? roleBadge;
@override@JsonKey() final  bool isOnline;
@override final  String? presenceLabel;
@override final  String? sharedTripsLabel;

/// Create a copy of FriendChatPeer
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FriendChatPeerCopyWith<_FriendChatPeer> get copyWith => __$FriendChatPeerCopyWithImpl<_FriendChatPeer>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FriendChatPeerToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _FriendChatPeer&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.roleBadge, roleBadge) || other.roleBadge == roleBadge)&&(identical(other.isOnline, isOnline) || other.isOnline == isOnline)&&(identical(other.presenceLabel, presenceLabel) || other.presenceLabel == presenceLabel)&&(identical(other.sharedTripsLabel, sharedTripsLabel) || other.sharedTripsLabel == sharedTripsLabel));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,userId,displayName,avatarUrl,roleBadge,isOnline,presenceLabel,sharedTripsLabel);
}

@override
String toString() {
    return 'FriendChatPeer(userId: $userId, displayName: $displayName, avatarUrl: $avatarUrl, roleBadge: $roleBadge, isOnline: $isOnline, presenceLabel: $presenceLabel, sharedTripsLabel: $sharedTripsLabel)';
}


}

/// @nodoc
abstract mixin class _$FriendChatPeerCopyWith<$Res> implements $FriendChatPeerCopyWith<$Res> {
  factory _$FriendChatPeerCopyWith(_FriendChatPeer value, $Res Function(_FriendChatPeer) _then) = __$FriendChatPeerCopyWithImpl;
@override @useResult
$Res call({
 String userId, String displayName, String? avatarUrl, String? roleBadge, bool isOnline, String? presenceLabel, String? sharedTripsLabel
});




}
/// @nodoc
class __$FriendChatPeerCopyWithImpl<$Res>
    implements _$FriendChatPeerCopyWith<$Res> {
  __$FriendChatPeerCopyWithImpl(this._self, this._then);

  final _FriendChatPeer _self;
  final $Res Function(_FriendChatPeer) _then;

/// Create a copy of FriendChatPeer
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? displayName = null,Object? avatarUrl = freezed,Object? roleBadge = freezed,Object? isOnline = null,Object? presenceLabel = freezed,Object? sharedTripsLabel = freezed,}) {
  return _then(_FriendChatPeer(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,roleBadge: freezed == roleBadge ? _self.roleBadge : roleBadge // ignore: cast_nullable_to_non_nullable
as String?,isOnline: null == isOnline ? _self.isOnline : isOnline // ignore: cast_nullable_to_non_nullable
as bool,presenceLabel: freezed == presenceLabel ? _self.presenceLabel : presenceLabel // ignore: cast_nullable_to_non_nullable
as String?,sharedTripsLabel: freezed == sharedTripsLabel ? _self.sharedTripsLabel : sharedTripsLabel // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$FriendChatSharedTrip {

 String get tripId; String get title; String? get destinationHint; String get statusLabel;
/// Create a copy of FriendChatSharedTrip
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FriendChatSharedTripCopyWith<FriendChatSharedTrip> get copyWith => _$FriendChatSharedTripCopyWithImpl<FriendChatSharedTrip>(this as FriendChatSharedTrip, _$identity);

  /// Serializes this FriendChatSharedTrip to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as FriendChatSharedTrip;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FriendChatSharedTrip&&(identical(other.tripId, _this.tripId) || other.tripId == _this.tripId)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.destinationHint, _this.destinationHint) || other.destinationHint == _this.destinationHint)&&(identical(other.statusLabel, _this.statusLabel) || other.statusLabel == _this.statusLabel));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as FriendChatSharedTrip;
  return Object.hash(runtimeType,_this.tripId,_this.title,_this.destinationHint,_this.statusLabel);
}

@override
String toString() {
  final _this = this as FriendChatSharedTrip;
  return 'FriendChatSharedTrip(tripId: ${_this.tripId}, title: ${_this.title}, destinationHint: ${_this.destinationHint}, statusLabel: ${_this.statusLabel})';
}


}

/// @nodoc
abstract mixin class $FriendChatSharedTripCopyWith<$Res>  {
  factory $FriendChatSharedTripCopyWith(FriendChatSharedTrip value, $Res Function(FriendChatSharedTrip) _then) = _$FriendChatSharedTripCopyWithImpl;
@useResult
$Res call({
 String tripId, String title, String? destinationHint, String statusLabel
});




}
/// @nodoc
class _$FriendChatSharedTripCopyWithImpl<$Res>
    implements $FriendChatSharedTripCopyWith<$Res> {
  _$FriendChatSharedTripCopyWithImpl(this._self, this._then);

  final FriendChatSharedTrip _self;
  final $Res Function(FriendChatSharedTrip) _then;

/// Create a copy of FriendChatSharedTrip
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? tripId = null,Object? title = null,Object? destinationHint = freezed,Object? statusLabel = null,}) {
  return _then(FriendChatSharedTrip(
tripId: null == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,destinationHint: freezed == destinationHint ? _self.destinationHint : destinationHint // ignore: cast_nullable_to_non_nullable
as String?,statusLabel: null == statusLabel ? _self.statusLabel : statusLabel // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [FriendChatSharedTrip].
extension FriendChatSharedTripPatterns on FriendChatSharedTrip {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FriendChatSharedTrip value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FriendChatSharedTrip() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FriendChatSharedTrip value)  $default,){
final _that = this;
switch (_that) {
case _FriendChatSharedTrip():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FriendChatSharedTrip value)?  $default,){
final _that = this;
switch (_that) {
case _FriendChatSharedTrip() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String tripId,  String title,  String? destinationHint,  String statusLabel)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FriendChatSharedTrip() when $default != null:
return $default(_that.tripId,_that.title,_that.destinationHint,_that.statusLabel);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String tripId,  String title,  String? destinationHint,  String statusLabel)  $default,) {final _that = this;
switch (_that) {
case _FriendChatSharedTrip():
return $default(_that.tripId,_that.title,_that.destinationHint,_that.statusLabel);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String tripId,  String title,  String? destinationHint,  String statusLabel)?  $default,) {final _that = this;
switch (_that) {
case _FriendChatSharedTrip() when $default != null:
return $default(_that.tripId,_that.title,_that.destinationHint,_that.statusLabel);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FriendChatSharedTrip implements FriendChatSharedTrip {
  const _FriendChatSharedTrip({required this.tripId, required this.title, this.destinationHint, required this.statusLabel});
  factory _FriendChatSharedTrip.fromJson(Map<String, dynamic> json) => _$FriendChatSharedTripFromJson(json);

@override final  String tripId;
@override final  String title;
@override final  String? destinationHint;
@override final  String statusLabel;

/// Create a copy of FriendChatSharedTrip
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FriendChatSharedTripCopyWith<_FriendChatSharedTrip> get copyWith => __$FriendChatSharedTripCopyWithImpl<_FriendChatSharedTrip>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FriendChatSharedTripToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _FriendChatSharedTrip&&(identical(other.tripId, tripId) || other.tripId == tripId)&&(identical(other.title, title) || other.title == title)&&(identical(other.destinationHint, destinationHint) || other.destinationHint == destinationHint)&&(identical(other.statusLabel, statusLabel) || other.statusLabel == statusLabel));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,tripId,title,destinationHint,statusLabel);
}

@override
String toString() {
    return 'FriendChatSharedTrip(tripId: $tripId, title: $title, destinationHint: $destinationHint, statusLabel: $statusLabel)';
}


}

/// @nodoc
abstract mixin class _$FriendChatSharedTripCopyWith<$Res> implements $FriendChatSharedTripCopyWith<$Res> {
  factory _$FriendChatSharedTripCopyWith(_FriendChatSharedTrip value, $Res Function(_FriendChatSharedTrip) _then) = __$FriendChatSharedTripCopyWithImpl;
@override @useResult
$Res call({
 String tripId, String title, String? destinationHint, String statusLabel
});




}
/// @nodoc
class __$FriendChatSharedTripCopyWithImpl<$Res>
    implements _$FriendChatSharedTripCopyWith<$Res> {
  __$FriendChatSharedTripCopyWithImpl(this._self, this._then);

  final _FriendChatSharedTrip _self;
  final $Res Function(_FriendChatSharedTrip) _then;

/// Create a copy of FriendChatSharedTrip
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? tripId = null,Object? title = null,Object? destinationHint = freezed,Object? statusLabel = null,}) {
  return _then(_FriendChatSharedTrip(
tripId: null == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,destinationHint: freezed == destinationHint ? _self.destinationHint : destinationHint // ignore: cast_nullable_to_non_nullable
as String?,statusLabel: null == statusLabel ? _self.statusLabel : statusLabel // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$FriendChatMessage {

 String get id; FriendChatMessageKind get kind; bool get isMine; String? get text; String get timeLabel; FriendChatReadStatus? get readStatus; bool get showAvatar; FriendChatPlaceCard? get placeCard; FriendChatTripInviteCard? get tripInvite;
/// Create a copy of FriendChatMessage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FriendChatMessageCopyWith<FriendChatMessage> get copyWith => _$FriendChatMessageCopyWithImpl<FriendChatMessage>(this as FriendChatMessage, _$identity);

  /// Serializes this FriendChatMessage to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as FriendChatMessage;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FriendChatMessage&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.kind, _this.kind) || other.kind == _this.kind)&&(identical(other.isMine, _this.isMine) || other.isMine == _this.isMine)&&(identical(other.text, _this.text) || other.text == _this.text)&&(identical(other.timeLabel, _this.timeLabel) || other.timeLabel == _this.timeLabel)&&(identical(other.readStatus, _this.readStatus) || other.readStatus == _this.readStatus)&&(identical(other.showAvatar, _this.showAvatar) || other.showAvatar == _this.showAvatar)&&(identical(other.placeCard, _this.placeCard) || other.placeCard == _this.placeCard)&&(identical(other.tripInvite, _this.tripInvite) || other.tripInvite == _this.tripInvite));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as FriendChatMessage;
  return Object.hash(runtimeType,_this.id,_this.kind,_this.isMine,_this.text,_this.timeLabel,_this.readStatus,_this.showAvatar,_this.placeCard,_this.tripInvite);
}

@override
String toString() {
  final _this = this as FriendChatMessage;
  return 'FriendChatMessage(id: ${_this.id}, kind: ${_this.kind}, isMine: ${_this.isMine}, text: ${_this.text}, timeLabel: ${_this.timeLabel}, readStatus: ${_this.readStatus}, showAvatar: ${_this.showAvatar}, placeCard: ${_this.placeCard}, tripInvite: ${_this.tripInvite})';
}


}

/// @nodoc
abstract mixin class $FriendChatMessageCopyWith<$Res>  {
  factory $FriendChatMessageCopyWith(FriendChatMessage value, $Res Function(FriendChatMessage) _then) = _$FriendChatMessageCopyWithImpl;
@useResult
$Res call({
 String id, FriendChatMessageKind kind, bool isMine, String? text, String timeLabel, FriendChatReadStatus? readStatus, bool showAvatar, FriendChatPlaceCard? placeCard, FriendChatTripInviteCard? tripInvite
});


$FriendChatPlaceCardCopyWith<$Res>? get placeCard;$FriendChatTripInviteCardCopyWith<$Res>? get tripInvite;

}
/// @nodoc
class _$FriendChatMessageCopyWithImpl<$Res>
    implements $FriendChatMessageCopyWith<$Res> {
  _$FriendChatMessageCopyWithImpl(this._self, this._then);

  final FriendChatMessage _self;
  final $Res Function(FriendChatMessage) _then;

/// Create a copy of FriendChatMessage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? kind = null,Object? isMine = null,Object? text = freezed,Object? timeLabel = null,Object? readStatus = freezed,Object? showAvatar = null,Object? placeCard = freezed,Object? tripInvite = freezed,}) {
  return _then(FriendChatMessage(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as FriendChatMessageKind,isMine: null == isMine ? _self.isMine : isMine // ignore: cast_nullable_to_non_nullable
as bool,text: freezed == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String?,timeLabel: null == timeLabel ? _self.timeLabel : timeLabel // ignore: cast_nullable_to_non_nullable
as String,readStatus: freezed == readStatus ? _self.readStatus : readStatus // ignore: cast_nullable_to_non_nullable
as FriendChatReadStatus?,showAvatar: null == showAvatar ? _self.showAvatar : showAvatar // ignore: cast_nullable_to_non_nullable
as bool,placeCard: freezed == placeCard ? _self.placeCard : placeCard // ignore: cast_nullable_to_non_nullable
as FriendChatPlaceCard?,tripInvite: freezed == tripInvite ? _self.tripInvite : tripInvite // ignore: cast_nullable_to_non_nullable
as FriendChatTripInviteCard?,
  ));
}
/// Create a copy of FriendChatMessage
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FriendChatPlaceCardCopyWith<$Res>? get placeCard {
    if (_self.placeCard == null) {
    return null;
  }

  return $FriendChatPlaceCardCopyWith<$Res>(_self.placeCard!, (value) {
    return _then(_self.copyWith(placeCard: value));
  });
}/// Create a copy of FriendChatMessage
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FriendChatTripInviteCardCopyWith<$Res>? get tripInvite {
    if (_self.tripInvite == null) {
    return null;
  }

  return $FriendChatTripInviteCardCopyWith<$Res>(_self.tripInvite!, (value) {
    return _then(_self.copyWith(tripInvite: value));
  });
}
}


/// Adds pattern-matching-related methods to [FriendChatMessage].
extension FriendChatMessagePatterns on FriendChatMessage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FriendChatMessage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FriendChatMessage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FriendChatMessage value)  $default,){
final _that = this;
switch (_that) {
case _FriendChatMessage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FriendChatMessage value)?  $default,){
final _that = this;
switch (_that) {
case _FriendChatMessage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  FriendChatMessageKind kind,  bool isMine,  String? text,  String timeLabel,  FriendChatReadStatus? readStatus,  bool showAvatar,  FriendChatPlaceCard? placeCard,  FriendChatTripInviteCard? tripInvite)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FriendChatMessage() when $default != null:
return $default(_that.id,_that.kind,_that.isMine,_that.text,_that.timeLabel,_that.readStatus,_that.showAvatar,_that.placeCard,_that.tripInvite);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  FriendChatMessageKind kind,  bool isMine,  String? text,  String timeLabel,  FriendChatReadStatus? readStatus,  bool showAvatar,  FriendChatPlaceCard? placeCard,  FriendChatTripInviteCard? tripInvite)  $default,) {final _that = this;
switch (_that) {
case _FriendChatMessage():
return $default(_that.id,_that.kind,_that.isMine,_that.text,_that.timeLabel,_that.readStatus,_that.showAvatar,_that.placeCard,_that.tripInvite);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  FriendChatMessageKind kind,  bool isMine,  String? text,  String timeLabel,  FriendChatReadStatus? readStatus,  bool showAvatar,  FriendChatPlaceCard? placeCard,  FriendChatTripInviteCard? tripInvite)?  $default,) {final _that = this;
switch (_that) {
case _FriendChatMessage() when $default != null:
return $default(_that.id,_that.kind,_that.isMine,_that.text,_that.timeLabel,_that.readStatus,_that.showAvatar,_that.placeCard,_that.tripInvite);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FriendChatMessage implements FriendChatMessage {
  const _FriendChatMessage({required this.id, required this.kind, this.isMine = false, this.text, required this.timeLabel, this.readStatus, this.showAvatar = true, this.placeCard, this.tripInvite});
  factory _FriendChatMessage.fromJson(Map<String, dynamic> json) => _$FriendChatMessageFromJson(json);

@override final  String id;
@override final  FriendChatMessageKind kind;
@override@JsonKey() final  bool isMine;
@override final  String? text;
@override final  String timeLabel;
@override final  FriendChatReadStatus? readStatus;
@override@JsonKey() final  bool showAvatar;
@override final  FriendChatPlaceCard? placeCard;
@override final  FriendChatTripInviteCard? tripInvite;

/// Create a copy of FriendChatMessage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FriendChatMessageCopyWith<_FriendChatMessage> get copyWith => __$FriendChatMessageCopyWithImpl<_FriendChatMessage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FriendChatMessageToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _FriendChatMessage&&(identical(other.id, id) || other.id == id)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.isMine, isMine) || other.isMine == isMine)&&(identical(other.text, text) || other.text == text)&&(identical(other.timeLabel, timeLabel) || other.timeLabel == timeLabel)&&(identical(other.readStatus, readStatus) || other.readStatus == readStatus)&&(identical(other.showAvatar, showAvatar) || other.showAvatar == showAvatar)&&(identical(other.placeCard, placeCard) || other.placeCard == placeCard)&&(identical(other.tripInvite, tripInvite) || other.tripInvite == tripInvite));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,kind,isMine,text,timeLabel,readStatus,showAvatar,placeCard,tripInvite);
}

@override
String toString() {
    return 'FriendChatMessage(id: $id, kind: $kind, isMine: $isMine, text: $text, timeLabel: $timeLabel, readStatus: $readStatus, showAvatar: $showAvatar, placeCard: $placeCard, tripInvite: $tripInvite)';
}


}

/// @nodoc
abstract mixin class _$FriendChatMessageCopyWith<$Res> implements $FriendChatMessageCopyWith<$Res> {
  factory _$FriendChatMessageCopyWith(_FriendChatMessage value, $Res Function(_FriendChatMessage) _then) = __$FriendChatMessageCopyWithImpl;
@override @useResult
$Res call({
 String id, FriendChatMessageKind kind, bool isMine, String? text, String timeLabel, FriendChatReadStatus? readStatus, bool showAvatar, FriendChatPlaceCard? placeCard, FriendChatTripInviteCard? tripInvite
});


@override $FriendChatPlaceCardCopyWith<$Res>? get placeCard;@override $FriendChatTripInviteCardCopyWith<$Res>? get tripInvite;

}
/// @nodoc
class __$FriendChatMessageCopyWithImpl<$Res>
    implements _$FriendChatMessageCopyWith<$Res> {
  __$FriendChatMessageCopyWithImpl(this._self, this._then);

  final _FriendChatMessage _self;
  final $Res Function(_FriendChatMessage) _then;

/// Create a copy of FriendChatMessage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? kind = null,Object? isMine = null,Object? text = freezed,Object? timeLabel = null,Object? readStatus = freezed,Object? showAvatar = null,Object? placeCard = freezed,Object? tripInvite = freezed,}) {
  return _then(_FriendChatMessage(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as FriendChatMessageKind,isMine: null == isMine ? _self.isMine : isMine // ignore: cast_nullable_to_non_nullable
as bool,text: freezed == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String?,timeLabel: null == timeLabel ? _self.timeLabel : timeLabel // ignore: cast_nullable_to_non_nullable
as String,readStatus: freezed == readStatus ? _self.readStatus : readStatus // ignore: cast_nullable_to_non_nullable
as FriendChatReadStatus?,showAvatar: null == showAvatar ? _self.showAvatar : showAvatar // ignore: cast_nullable_to_non_nullable
as bool,placeCard: freezed == placeCard ? _self.placeCard : placeCard // ignore: cast_nullable_to_non_nullable
as FriendChatPlaceCard?,tripInvite: freezed == tripInvite ? _self.tripInvite : tripInvite // ignore: cast_nullable_to_non_nullable
as FriendChatTripInviteCard?,
  ));
}

/// Create a copy of FriendChatMessage
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FriendChatPlaceCardCopyWith<$Res>? get placeCard {
    if (_self.placeCard == null) {
    return null;
  }

  return $FriendChatPlaceCardCopyWith<$Res>(_self.placeCard!, (value) {
    return _then(_self.copyWith(placeCard: value));
  });
}/// Create a copy of FriendChatMessage
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FriendChatTripInviteCardCopyWith<$Res>? get tripInvite {
    if (_self.tripInvite == null) {
    return null;
  }

  return $FriendChatTripInviteCardCopyWith<$Res>(_self.tripInvite!, (value) {
    return _then(_self.copyWith(tripInvite: value));
  });
}
}


/// @nodoc
mixin _$FriendChatPlaceCard {

 String get placeId; String get name; String get address; String get imageUrl;@JsonKey(fromJson: _readDouble) double get rating;@JsonKey(fromJson: _readInt) int get reviewCount; String? get badgeLabel; String? get footerLabel; String? get actionLabel;
/// Create a copy of FriendChatPlaceCard
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FriendChatPlaceCardCopyWith<FriendChatPlaceCard> get copyWith => _$FriendChatPlaceCardCopyWithImpl<FriendChatPlaceCard>(this as FriendChatPlaceCard, _$identity);

  /// Serializes this FriendChatPlaceCard to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as FriendChatPlaceCard;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FriendChatPlaceCard&&(identical(other.placeId, _this.placeId) || other.placeId == _this.placeId)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.address, _this.address) || other.address == _this.address)&&(identical(other.imageUrl, _this.imageUrl) || other.imageUrl == _this.imageUrl)&&(identical(other.rating, _this.rating) || other.rating == _this.rating)&&(identical(other.reviewCount, _this.reviewCount) || other.reviewCount == _this.reviewCount)&&(identical(other.badgeLabel, _this.badgeLabel) || other.badgeLabel == _this.badgeLabel)&&(identical(other.footerLabel, _this.footerLabel) || other.footerLabel == _this.footerLabel)&&(identical(other.actionLabel, _this.actionLabel) || other.actionLabel == _this.actionLabel));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as FriendChatPlaceCard;
  return Object.hash(runtimeType,_this.placeId,_this.name,_this.address,_this.imageUrl,_this.rating,_this.reviewCount,_this.badgeLabel,_this.footerLabel,_this.actionLabel);
}

@override
String toString() {
  final _this = this as FriendChatPlaceCard;
  return 'FriendChatPlaceCard(placeId: ${_this.placeId}, name: ${_this.name}, address: ${_this.address}, imageUrl: ${_this.imageUrl}, rating: ${_this.rating}, reviewCount: ${_this.reviewCount}, badgeLabel: ${_this.badgeLabel}, footerLabel: ${_this.footerLabel}, actionLabel: ${_this.actionLabel})';
}


}

/// @nodoc
abstract mixin class $FriendChatPlaceCardCopyWith<$Res>  {
  factory $FriendChatPlaceCardCopyWith(FriendChatPlaceCard value, $Res Function(FriendChatPlaceCard) _then) = _$FriendChatPlaceCardCopyWithImpl;
@useResult
$Res call({
 String placeId, String name, String address, String imageUrl,@JsonKey(fromJson: _readDouble) double rating,@JsonKey(fromJson: _readInt) int reviewCount, String? badgeLabel, String? footerLabel, String? actionLabel
});




}
/// @nodoc
class _$FriendChatPlaceCardCopyWithImpl<$Res>
    implements $FriendChatPlaceCardCopyWith<$Res> {
  _$FriendChatPlaceCardCopyWithImpl(this._self, this._then);

  final FriendChatPlaceCard _self;
  final $Res Function(FriendChatPlaceCard) _then;

/// Create a copy of FriendChatPlaceCard
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? placeId = null,Object? name = null,Object? address = null,Object? imageUrl = null,Object? rating = null,Object? reviewCount = null,Object? badgeLabel = freezed,Object? footerLabel = freezed,Object? actionLabel = freezed,}) {
  return _then(FriendChatPlaceCard(
placeId: null == placeId ? _self.placeId : placeId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,reviewCount: null == reviewCount ? _self.reviewCount : reviewCount // ignore: cast_nullable_to_non_nullable
as int,badgeLabel: freezed == badgeLabel ? _self.badgeLabel : badgeLabel // ignore: cast_nullable_to_non_nullable
as String?,footerLabel: freezed == footerLabel ? _self.footerLabel : footerLabel // ignore: cast_nullable_to_non_nullable
as String?,actionLabel: freezed == actionLabel ? _self.actionLabel : actionLabel // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [FriendChatPlaceCard].
extension FriendChatPlaceCardPatterns on FriendChatPlaceCard {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FriendChatPlaceCard value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FriendChatPlaceCard() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FriendChatPlaceCard value)  $default,){
final _that = this;
switch (_that) {
case _FriendChatPlaceCard():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FriendChatPlaceCard value)?  $default,){
final _that = this;
switch (_that) {
case _FriendChatPlaceCard() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String placeId,  String name,  String address,  String imageUrl, @JsonKey(fromJson: _readDouble)  double rating, @JsonKey(fromJson: _readInt)  int reviewCount,  String? badgeLabel,  String? footerLabel,  String? actionLabel)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FriendChatPlaceCard() when $default != null:
return $default(_that.placeId,_that.name,_that.address,_that.imageUrl,_that.rating,_that.reviewCount,_that.badgeLabel,_that.footerLabel,_that.actionLabel);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String placeId,  String name,  String address,  String imageUrl, @JsonKey(fromJson: _readDouble)  double rating, @JsonKey(fromJson: _readInt)  int reviewCount,  String? badgeLabel,  String? footerLabel,  String? actionLabel)  $default,) {final _that = this;
switch (_that) {
case _FriendChatPlaceCard():
return $default(_that.placeId,_that.name,_that.address,_that.imageUrl,_that.rating,_that.reviewCount,_that.badgeLabel,_that.footerLabel,_that.actionLabel);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String placeId,  String name,  String address,  String imageUrl, @JsonKey(fromJson: _readDouble)  double rating, @JsonKey(fromJson: _readInt)  int reviewCount,  String? badgeLabel,  String? footerLabel,  String? actionLabel)?  $default,) {final _that = this;
switch (_that) {
case _FriendChatPlaceCard() when $default != null:
return $default(_that.placeId,_that.name,_that.address,_that.imageUrl,_that.rating,_that.reviewCount,_that.badgeLabel,_that.footerLabel,_that.actionLabel);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FriendChatPlaceCard implements FriendChatPlaceCard {
  const _FriendChatPlaceCard({required this.placeId, required this.name, required this.address, required this.imageUrl, @JsonKey(fromJson: _readDouble) required this.rating, @JsonKey(fromJson: _readInt) required this.reviewCount, this.badgeLabel, this.footerLabel, this.actionLabel});
  factory _FriendChatPlaceCard.fromJson(Map<String, dynamic> json) => _$FriendChatPlaceCardFromJson(json);

@override final  String placeId;
@override final  String name;
@override final  String address;
@override final  String imageUrl;
@override@JsonKey(fromJson: _readDouble) final  double rating;
@override@JsonKey(fromJson: _readInt) final  int reviewCount;
@override final  String? badgeLabel;
@override final  String? footerLabel;
@override final  String? actionLabel;

/// Create a copy of FriendChatPlaceCard
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FriendChatPlaceCardCopyWith<_FriendChatPlaceCard> get copyWith => __$FriendChatPlaceCardCopyWithImpl<_FriendChatPlaceCard>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FriendChatPlaceCardToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _FriendChatPlaceCard&&(identical(other.placeId, placeId) || other.placeId == placeId)&&(identical(other.name, name) || other.name == name)&&(identical(other.address, address) || other.address == address)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.reviewCount, reviewCount) || other.reviewCount == reviewCount)&&(identical(other.badgeLabel, badgeLabel) || other.badgeLabel == badgeLabel)&&(identical(other.footerLabel, footerLabel) || other.footerLabel == footerLabel)&&(identical(other.actionLabel, actionLabel) || other.actionLabel == actionLabel));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,placeId,name,address,imageUrl,rating,reviewCount,badgeLabel,footerLabel,actionLabel);
}

@override
String toString() {
    return 'FriendChatPlaceCard(placeId: $placeId, name: $name, address: $address, imageUrl: $imageUrl, rating: $rating, reviewCount: $reviewCount, badgeLabel: $badgeLabel, footerLabel: $footerLabel, actionLabel: $actionLabel)';
}


}

/// @nodoc
abstract mixin class _$FriendChatPlaceCardCopyWith<$Res> implements $FriendChatPlaceCardCopyWith<$Res> {
  factory _$FriendChatPlaceCardCopyWith(_FriendChatPlaceCard value, $Res Function(_FriendChatPlaceCard) _then) = __$FriendChatPlaceCardCopyWithImpl;
@override @useResult
$Res call({
 String placeId, String name, String address, String imageUrl,@JsonKey(fromJson: _readDouble) double rating,@JsonKey(fromJson: _readInt) int reviewCount, String? badgeLabel, String? footerLabel, String? actionLabel
});




}
/// @nodoc
class __$FriendChatPlaceCardCopyWithImpl<$Res>
    implements _$FriendChatPlaceCardCopyWith<$Res> {
  __$FriendChatPlaceCardCopyWithImpl(this._self, this._then);

  final _FriendChatPlaceCard _self;
  final $Res Function(_FriendChatPlaceCard) _then;

/// Create a copy of FriendChatPlaceCard
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? placeId = null,Object? name = null,Object? address = null,Object? imageUrl = null,Object? rating = null,Object? reviewCount = null,Object? badgeLabel = freezed,Object? footerLabel = freezed,Object? actionLabel = freezed,}) {
  return _then(_FriendChatPlaceCard(
placeId: null == placeId ? _self.placeId : placeId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,reviewCount: null == reviewCount ? _self.reviewCount : reviewCount // ignore: cast_nullable_to_non_nullable
as int,badgeLabel: freezed == badgeLabel ? _self.badgeLabel : badgeLabel // ignore: cast_nullable_to_non_nullable
as String?,footerLabel: freezed == footerLabel ? _self.footerLabel : footerLabel // ignore: cast_nullable_to_non_nullable
as String?,actionLabel: freezed == actionLabel ? _self.actionLabel : actionLabel // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$FriendChatTripInviteCard {

 String get tripId; String get title; String get imageUrl; String get dateLabel; String get priceLabel; String get seatsLabel; String? get badgeLabel; String? get primaryActionLabel; String? get secondaryActionLabel;
/// Create a copy of FriendChatTripInviteCard
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FriendChatTripInviteCardCopyWith<FriendChatTripInviteCard> get copyWith => _$FriendChatTripInviteCardCopyWithImpl<FriendChatTripInviteCard>(this as FriendChatTripInviteCard, _$identity);

  /// Serializes this FriendChatTripInviteCard to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as FriendChatTripInviteCard;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FriendChatTripInviteCard&&(identical(other.tripId, _this.tripId) || other.tripId == _this.tripId)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.imageUrl, _this.imageUrl) || other.imageUrl == _this.imageUrl)&&(identical(other.dateLabel, _this.dateLabel) || other.dateLabel == _this.dateLabel)&&(identical(other.priceLabel, _this.priceLabel) || other.priceLabel == _this.priceLabel)&&(identical(other.seatsLabel, _this.seatsLabel) || other.seatsLabel == _this.seatsLabel)&&(identical(other.badgeLabel, _this.badgeLabel) || other.badgeLabel == _this.badgeLabel)&&(identical(other.primaryActionLabel, _this.primaryActionLabel) || other.primaryActionLabel == _this.primaryActionLabel)&&(identical(other.secondaryActionLabel, _this.secondaryActionLabel) || other.secondaryActionLabel == _this.secondaryActionLabel));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as FriendChatTripInviteCard;
  return Object.hash(runtimeType,_this.tripId,_this.title,_this.imageUrl,_this.dateLabel,_this.priceLabel,_this.seatsLabel,_this.badgeLabel,_this.primaryActionLabel,_this.secondaryActionLabel);
}

@override
String toString() {
  final _this = this as FriendChatTripInviteCard;
  return 'FriendChatTripInviteCard(tripId: ${_this.tripId}, title: ${_this.title}, imageUrl: ${_this.imageUrl}, dateLabel: ${_this.dateLabel}, priceLabel: ${_this.priceLabel}, seatsLabel: ${_this.seatsLabel}, badgeLabel: ${_this.badgeLabel}, primaryActionLabel: ${_this.primaryActionLabel}, secondaryActionLabel: ${_this.secondaryActionLabel})';
}


}

/// @nodoc
abstract mixin class $FriendChatTripInviteCardCopyWith<$Res>  {
  factory $FriendChatTripInviteCardCopyWith(FriendChatTripInviteCard value, $Res Function(FriendChatTripInviteCard) _then) = _$FriendChatTripInviteCardCopyWithImpl;
@useResult
$Res call({
 String tripId, String title, String imageUrl, String dateLabel, String priceLabel, String seatsLabel, String? badgeLabel, String? primaryActionLabel, String? secondaryActionLabel
});




}
/// @nodoc
class _$FriendChatTripInviteCardCopyWithImpl<$Res>
    implements $FriendChatTripInviteCardCopyWith<$Res> {
  _$FriendChatTripInviteCardCopyWithImpl(this._self, this._then);

  final FriendChatTripInviteCard _self;
  final $Res Function(FriendChatTripInviteCard) _then;

/// Create a copy of FriendChatTripInviteCard
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? tripId = null,Object? title = null,Object? imageUrl = null,Object? dateLabel = null,Object? priceLabel = null,Object? seatsLabel = null,Object? badgeLabel = freezed,Object? primaryActionLabel = freezed,Object? secondaryActionLabel = freezed,}) {
  return _then(FriendChatTripInviteCard(
tripId: null == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,dateLabel: null == dateLabel ? _self.dateLabel : dateLabel // ignore: cast_nullable_to_non_nullable
as String,priceLabel: null == priceLabel ? _self.priceLabel : priceLabel // ignore: cast_nullable_to_non_nullable
as String,seatsLabel: null == seatsLabel ? _self.seatsLabel : seatsLabel // ignore: cast_nullable_to_non_nullable
as String,badgeLabel: freezed == badgeLabel ? _self.badgeLabel : badgeLabel // ignore: cast_nullable_to_non_nullable
as String?,primaryActionLabel: freezed == primaryActionLabel ? _self.primaryActionLabel : primaryActionLabel // ignore: cast_nullable_to_non_nullable
as String?,secondaryActionLabel: freezed == secondaryActionLabel ? _self.secondaryActionLabel : secondaryActionLabel // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [FriendChatTripInviteCard].
extension FriendChatTripInviteCardPatterns on FriendChatTripInviteCard {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FriendChatTripInviteCard value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FriendChatTripInviteCard() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FriendChatTripInviteCard value)  $default,){
final _that = this;
switch (_that) {
case _FriendChatTripInviteCard():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FriendChatTripInviteCard value)?  $default,){
final _that = this;
switch (_that) {
case _FriendChatTripInviteCard() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String tripId,  String title,  String imageUrl,  String dateLabel,  String priceLabel,  String seatsLabel,  String? badgeLabel,  String? primaryActionLabel,  String? secondaryActionLabel)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FriendChatTripInviteCard() when $default != null:
return $default(_that.tripId,_that.title,_that.imageUrl,_that.dateLabel,_that.priceLabel,_that.seatsLabel,_that.badgeLabel,_that.primaryActionLabel,_that.secondaryActionLabel);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String tripId,  String title,  String imageUrl,  String dateLabel,  String priceLabel,  String seatsLabel,  String? badgeLabel,  String? primaryActionLabel,  String? secondaryActionLabel)  $default,) {final _that = this;
switch (_that) {
case _FriendChatTripInviteCard():
return $default(_that.tripId,_that.title,_that.imageUrl,_that.dateLabel,_that.priceLabel,_that.seatsLabel,_that.badgeLabel,_that.primaryActionLabel,_that.secondaryActionLabel);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String tripId,  String title,  String imageUrl,  String dateLabel,  String priceLabel,  String seatsLabel,  String? badgeLabel,  String? primaryActionLabel,  String? secondaryActionLabel)?  $default,) {final _that = this;
switch (_that) {
case _FriendChatTripInviteCard() when $default != null:
return $default(_that.tripId,_that.title,_that.imageUrl,_that.dateLabel,_that.priceLabel,_that.seatsLabel,_that.badgeLabel,_that.primaryActionLabel,_that.secondaryActionLabel);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FriendChatTripInviteCard implements FriendChatTripInviteCard {
  const _FriendChatTripInviteCard({required this.tripId, required this.title, required this.imageUrl, required this.dateLabel, required this.priceLabel, required this.seatsLabel, this.badgeLabel, this.primaryActionLabel, this.secondaryActionLabel});
  factory _FriendChatTripInviteCard.fromJson(Map<String, dynamic> json) => _$FriendChatTripInviteCardFromJson(json);

@override final  String tripId;
@override final  String title;
@override final  String imageUrl;
@override final  String dateLabel;
@override final  String priceLabel;
@override final  String seatsLabel;
@override final  String? badgeLabel;
@override final  String? primaryActionLabel;
@override final  String? secondaryActionLabel;

/// Create a copy of FriendChatTripInviteCard
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FriendChatTripInviteCardCopyWith<_FriendChatTripInviteCard> get copyWith => __$FriendChatTripInviteCardCopyWithImpl<_FriendChatTripInviteCard>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FriendChatTripInviteCardToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _FriendChatTripInviteCard&&(identical(other.tripId, tripId) || other.tripId == tripId)&&(identical(other.title, title) || other.title == title)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.dateLabel, dateLabel) || other.dateLabel == dateLabel)&&(identical(other.priceLabel, priceLabel) || other.priceLabel == priceLabel)&&(identical(other.seatsLabel, seatsLabel) || other.seatsLabel == seatsLabel)&&(identical(other.badgeLabel, badgeLabel) || other.badgeLabel == badgeLabel)&&(identical(other.primaryActionLabel, primaryActionLabel) || other.primaryActionLabel == primaryActionLabel)&&(identical(other.secondaryActionLabel, secondaryActionLabel) || other.secondaryActionLabel == secondaryActionLabel));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,tripId,title,imageUrl,dateLabel,priceLabel,seatsLabel,badgeLabel,primaryActionLabel,secondaryActionLabel);
}

@override
String toString() {
    return 'FriendChatTripInviteCard(tripId: $tripId, title: $title, imageUrl: $imageUrl, dateLabel: $dateLabel, priceLabel: $priceLabel, seatsLabel: $seatsLabel, badgeLabel: $badgeLabel, primaryActionLabel: $primaryActionLabel, secondaryActionLabel: $secondaryActionLabel)';
}


}

/// @nodoc
abstract mixin class _$FriendChatTripInviteCardCopyWith<$Res> implements $FriendChatTripInviteCardCopyWith<$Res> {
  factory _$FriendChatTripInviteCardCopyWith(_FriendChatTripInviteCard value, $Res Function(_FriendChatTripInviteCard) _then) = __$FriendChatTripInviteCardCopyWithImpl;
@override @useResult
$Res call({
 String tripId, String title, String imageUrl, String dateLabel, String priceLabel, String seatsLabel, String? badgeLabel, String? primaryActionLabel, String? secondaryActionLabel
});




}
/// @nodoc
class __$FriendChatTripInviteCardCopyWithImpl<$Res>
    implements _$FriendChatTripInviteCardCopyWith<$Res> {
  __$FriendChatTripInviteCardCopyWithImpl(this._self, this._then);

  final _FriendChatTripInviteCard _self;
  final $Res Function(_FriendChatTripInviteCard) _then;

/// Create a copy of FriendChatTripInviteCard
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? tripId = null,Object? title = null,Object? imageUrl = null,Object? dateLabel = null,Object? priceLabel = null,Object? seatsLabel = null,Object? badgeLabel = freezed,Object? primaryActionLabel = freezed,Object? secondaryActionLabel = freezed,}) {
  return _then(_FriendChatTripInviteCard(
tripId: null == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,dateLabel: null == dateLabel ? _self.dateLabel : dateLabel // ignore: cast_nullable_to_non_nullable
as String,priceLabel: null == priceLabel ? _self.priceLabel : priceLabel // ignore: cast_nullable_to_non_nullable
as String,seatsLabel: null == seatsLabel ? _self.seatsLabel : seatsLabel // ignore: cast_nullable_to_non_nullable
as String,badgeLabel: freezed == badgeLabel ? _self.badgeLabel : badgeLabel // ignore: cast_nullable_to_non_nullable
as String?,primaryActionLabel: freezed == primaryActionLabel ? _self.primaryActionLabel : primaryActionLabel // ignore: cast_nullable_to_non_nullable
as String?,secondaryActionLabel: freezed == secondaryActionLabel ? _self.secondaryActionLabel : secondaryActionLabel // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$FriendChatShortcut {

 FriendChatShortcutKind get kind; String get label; bool get emphasized;
/// Create a copy of FriendChatShortcut
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FriendChatShortcutCopyWith<FriendChatShortcut> get copyWith => _$FriendChatShortcutCopyWithImpl<FriendChatShortcut>(this as FriendChatShortcut, _$identity);

  /// Serializes this FriendChatShortcut to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as FriendChatShortcut;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FriendChatShortcut&&(identical(other.kind, _this.kind) || other.kind == _this.kind)&&(identical(other.label, _this.label) || other.label == _this.label)&&(identical(other.emphasized, _this.emphasized) || other.emphasized == _this.emphasized));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as FriendChatShortcut;
  return Object.hash(runtimeType,_this.kind,_this.label,_this.emphasized);
}

@override
String toString() {
  final _this = this as FriendChatShortcut;
  return 'FriendChatShortcut(kind: ${_this.kind}, label: ${_this.label}, emphasized: ${_this.emphasized})';
}


}

/// @nodoc
abstract mixin class $FriendChatShortcutCopyWith<$Res>  {
  factory $FriendChatShortcutCopyWith(FriendChatShortcut value, $Res Function(FriendChatShortcut) _then) = _$FriendChatShortcutCopyWithImpl;
@useResult
$Res call({
 FriendChatShortcutKind kind, String label, bool emphasized
});




}
/// @nodoc
class _$FriendChatShortcutCopyWithImpl<$Res>
    implements $FriendChatShortcutCopyWith<$Res> {
  _$FriendChatShortcutCopyWithImpl(this._self, this._then);

  final FriendChatShortcut _self;
  final $Res Function(FriendChatShortcut) _then;

/// Create a copy of FriendChatShortcut
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? kind = null,Object? label = null,Object? emphasized = null,}) {
  return _then(FriendChatShortcut(
kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as FriendChatShortcutKind,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,emphasized: null == emphasized ? _self.emphasized : emphasized // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [FriendChatShortcut].
extension FriendChatShortcutPatterns on FriendChatShortcut {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FriendChatShortcut value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FriendChatShortcut() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FriendChatShortcut value)  $default,){
final _that = this;
switch (_that) {
case _FriendChatShortcut():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FriendChatShortcut value)?  $default,){
final _that = this;
switch (_that) {
case _FriendChatShortcut() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( FriendChatShortcutKind kind,  String label,  bool emphasized)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FriendChatShortcut() when $default != null:
return $default(_that.kind,_that.label,_that.emphasized);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( FriendChatShortcutKind kind,  String label,  bool emphasized)  $default,) {final _that = this;
switch (_that) {
case _FriendChatShortcut():
return $default(_that.kind,_that.label,_that.emphasized);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( FriendChatShortcutKind kind,  String label,  bool emphasized)?  $default,) {final _that = this;
switch (_that) {
case _FriendChatShortcut() when $default != null:
return $default(_that.kind,_that.label,_that.emphasized);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FriendChatShortcut implements FriendChatShortcut {
  const _FriendChatShortcut({required this.kind, required this.label, this.emphasized = false});
  factory _FriendChatShortcut.fromJson(Map<String, dynamic> json) => _$FriendChatShortcutFromJson(json);

@override final  FriendChatShortcutKind kind;
@override final  String label;
@override@JsonKey() final  bool emphasized;

/// Create a copy of FriendChatShortcut
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FriendChatShortcutCopyWith<_FriendChatShortcut> get copyWith => __$FriendChatShortcutCopyWithImpl<_FriendChatShortcut>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FriendChatShortcutToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _FriendChatShortcut&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.label, label) || other.label == label)&&(identical(other.emphasized, emphasized) || other.emphasized == emphasized));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,kind,label,emphasized);
}

@override
String toString() {
    return 'FriendChatShortcut(kind: $kind, label: $label, emphasized: $emphasized)';
}


}

/// @nodoc
abstract mixin class _$FriendChatShortcutCopyWith<$Res> implements $FriendChatShortcutCopyWith<$Res> {
  factory _$FriendChatShortcutCopyWith(_FriendChatShortcut value, $Res Function(_FriendChatShortcut) _then) = __$FriendChatShortcutCopyWithImpl;
@override @useResult
$Res call({
 FriendChatShortcutKind kind, String label, bool emphasized
});




}
/// @nodoc
class __$FriendChatShortcutCopyWithImpl<$Res>
    implements _$FriendChatShortcutCopyWith<$Res> {
  __$FriendChatShortcutCopyWithImpl(this._self, this._then);

  final _FriendChatShortcut _self;
  final $Res Function(_FriendChatShortcut) _then;

/// Create a copy of FriendChatShortcut
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? kind = null,Object? label = null,Object? emphasized = null,}) {
  return _then(_FriendChatShortcut(
kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as FriendChatShortcutKind,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,emphasized: null == emphasized ? _self.emphasized : emphasized // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$FriendChatInviteCandidate {

 String get tripId; String get title; String get imageUrl; String get metaLabel; String get badgeLabel; String get actionLabel;
/// Create a copy of FriendChatInviteCandidate
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FriendChatInviteCandidateCopyWith<FriendChatInviteCandidate> get copyWith => _$FriendChatInviteCandidateCopyWithImpl<FriendChatInviteCandidate>(this as FriendChatInviteCandidate, _$identity);

  /// Serializes this FriendChatInviteCandidate to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as FriendChatInviteCandidate;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FriendChatInviteCandidate&&(identical(other.tripId, _this.tripId) || other.tripId == _this.tripId)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.imageUrl, _this.imageUrl) || other.imageUrl == _this.imageUrl)&&(identical(other.metaLabel, _this.metaLabel) || other.metaLabel == _this.metaLabel)&&(identical(other.badgeLabel, _this.badgeLabel) || other.badgeLabel == _this.badgeLabel)&&(identical(other.actionLabel, _this.actionLabel) || other.actionLabel == _this.actionLabel));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as FriendChatInviteCandidate;
  return Object.hash(runtimeType,_this.tripId,_this.title,_this.imageUrl,_this.metaLabel,_this.badgeLabel,_this.actionLabel);
}

@override
String toString() {
  final _this = this as FriendChatInviteCandidate;
  return 'FriendChatInviteCandidate(tripId: ${_this.tripId}, title: ${_this.title}, imageUrl: ${_this.imageUrl}, metaLabel: ${_this.metaLabel}, badgeLabel: ${_this.badgeLabel}, actionLabel: ${_this.actionLabel})';
}


}

/// @nodoc
abstract mixin class $FriendChatInviteCandidateCopyWith<$Res>  {
  factory $FriendChatInviteCandidateCopyWith(FriendChatInviteCandidate value, $Res Function(FriendChatInviteCandidate) _then) = _$FriendChatInviteCandidateCopyWithImpl;
@useResult
$Res call({
 String tripId, String title, String imageUrl, String metaLabel, String badgeLabel, String actionLabel
});




}
/// @nodoc
class _$FriendChatInviteCandidateCopyWithImpl<$Res>
    implements $FriendChatInviteCandidateCopyWith<$Res> {
  _$FriendChatInviteCandidateCopyWithImpl(this._self, this._then);

  final FriendChatInviteCandidate _self;
  final $Res Function(FriendChatInviteCandidate) _then;

/// Create a copy of FriendChatInviteCandidate
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? tripId = null,Object? title = null,Object? imageUrl = null,Object? metaLabel = null,Object? badgeLabel = null,Object? actionLabel = null,}) {
  return _then(FriendChatInviteCandidate(
tripId: null == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,metaLabel: null == metaLabel ? _self.metaLabel : metaLabel // ignore: cast_nullable_to_non_nullable
as String,badgeLabel: null == badgeLabel ? _self.badgeLabel : badgeLabel // ignore: cast_nullable_to_non_nullable
as String,actionLabel: null == actionLabel ? _self.actionLabel : actionLabel // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [FriendChatInviteCandidate].
extension FriendChatInviteCandidatePatterns on FriendChatInviteCandidate {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FriendChatInviteCandidate value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FriendChatInviteCandidate() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FriendChatInviteCandidate value)  $default,){
final _that = this;
switch (_that) {
case _FriendChatInviteCandidate():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FriendChatInviteCandidate value)?  $default,){
final _that = this;
switch (_that) {
case _FriendChatInviteCandidate() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String tripId,  String title,  String imageUrl,  String metaLabel,  String badgeLabel,  String actionLabel)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FriendChatInviteCandidate() when $default != null:
return $default(_that.tripId,_that.title,_that.imageUrl,_that.metaLabel,_that.badgeLabel,_that.actionLabel);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String tripId,  String title,  String imageUrl,  String metaLabel,  String badgeLabel,  String actionLabel)  $default,) {final _that = this;
switch (_that) {
case _FriendChatInviteCandidate():
return $default(_that.tripId,_that.title,_that.imageUrl,_that.metaLabel,_that.badgeLabel,_that.actionLabel);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String tripId,  String title,  String imageUrl,  String metaLabel,  String badgeLabel,  String actionLabel)?  $default,) {final _that = this;
switch (_that) {
case _FriendChatInviteCandidate() when $default != null:
return $default(_that.tripId,_that.title,_that.imageUrl,_that.metaLabel,_that.badgeLabel,_that.actionLabel);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FriendChatInviteCandidate implements FriendChatInviteCandidate {
  const _FriendChatInviteCandidate({required this.tripId, required this.title, required this.imageUrl, required this.metaLabel, required this.badgeLabel, required this.actionLabel});
  factory _FriendChatInviteCandidate.fromJson(Map<String, dynamic> json) => _$FriendChatInviteCandidateFromJson(json);

@override final  String tripId;
@override final  String title;
@override final  String imageUrl;
@override final  String metaLabel;
@override final  String badgeLabel;
@override final  String actionLabel;

/// Create a copy of FriendChatInviteCandidate
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FriendChatInviteCandidateCopyWith<_FriendChatInviteCandidate> get copyWith => __$FriendChatInviteCandidateCopyWithImpl<_FriendChatInviteCandidate>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FriendChatInviteCandidateToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _FriendChatInviteCandidate&&(identical(other.tripId, tripId) || other.tripId == tripId)&&(identical(other.title, title) || other.title == title)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.metaLabel, metaLabel) || other.metaLabel == metaLabel)&&(identical(other.badgeLabel, badgeLabel) || other.badgeLabel == badgeLabel)&&(identical(other.actionLabel, actionLabel) || other.actionLabel == actionLabel));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,tripId,title,imageUrl,metaLabel,badgeLabel,actionLabel);
}

@override
String toString() {
    return 'FriendChatInviteCandidate(tripId: $tripId, title: $title, imageUrl: $imageUrl, metaLabel: $metaLabel, badgeLabel: $badgeLabel, actionLabel: $actionLabel)';
}


}

/// @nodoc
abstract mixin class _$FriendChatInviteCandidateCopyWith<$Res> implements $FriendChatInviteCandidateCopyWith<$Res> {
  factory _$FriendChatInviteCandidateCopyWith(_FriendChatInviteCandidate value, $Res Function(_FriendChatInviteCandidate) _then) = __$FriendChatInviteCandidateCopyWithImpl;
@override @useResult
$Res call({
 String tripId, String title, String imageUrl, String metaLabel, String badgeLabel, String actionLabel
});




}
/// @nodoc
class __$FriendChatInviteCandidateCopyWithImpl<$Res>
    implements _$FriendChatInviteCandidateCopyWith<$Res> {
  __$FriendChatInviteCandidateCopyWithImpl(this._self, this._then);

  final _FriendChatInviteCandidate _self;
  final $Res Function(_FriendChatInviteCandidate) _then;

/// Create a copy of FriendChatInviteCandidate
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? tripId = null,Object? title = null,Object? imageUrl = null,Object? metaLabel = null,Object? badgeLabel = null,Object? actionLabel = null,}) {
  return _then(_FriendChatInviteCandidate(
tripId: null == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,metaLabel: null == metaLabel ? _self.metaLabel : metaLabel // ignore: cast_nullable_to_non_nullable
as String,badgeLabel: null == badgeLabel ? _self.badgeLabel : badgeLabel // ignore: cast_nullable_to_non_nullable
as String,actionLabel: null == actionLabel ? _self.actionLabel : actionLabel // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
