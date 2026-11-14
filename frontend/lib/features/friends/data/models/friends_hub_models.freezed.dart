// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'friends_hub_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FriendsHubPage {

 int get friendsCount; String get friendsCountLabel; String get syncNotice; List<FriendsHubRequest> get received; List<FriendsHubRequest> get sent; List<FriendsHubFriend> get friends;
/// Create a copy of FriendsHubPage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FriendsHubPageCopyWith<FriendsHubPage> get copyWith => _$FriendsHubPageCopyWithImpl<FriendsHubPage>(this as FriendsHubPage, _$identity);

  /// Serializes this FriendsHubPage to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as FriendsHubPage;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FriendsHubPage&&(identical(other.friendsCount, _this.friendsCount) || other.friendsCount == _this.friendsCount)&&(identical(other.friendsCountLabel, _this.friendsCountLabel) || other.friendsCountLabel == _this.friendsCountLabel)&&(identical(other.syncNotice, _this.syncNotice) || other.syncNotice == _this.syncNotice)&&const DeepCollectionEquality().equals(other.received, _this.received)&&const DeepCollectionEquality().equals(other.sent, _this.sent)&&const DeepCollectionEquality().equals(other.friends, _this.friends));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as FriendsHubPage;
  return Object.hash(runtimeType,_this.friendsCount,_this.friendsCountLabel,_this.syncNotice,const DeepCollectionEquality().hash(_this.received),const DeepCollectionEquality().hash(_this.sent),const DeepCollectionEquality().hash(_this.friends));
}

@override
String toString() {
  final _this = this as FriendsHubPage;
  return 'FriendsHubPage(friendsCount: ${_this.friendsCount}, friendsCountLabel: ${_this.friendsCountLabel}, syncNotice: ${_this.syncNotice}, received: ${_this.received}, sent: ${_this.sent}, friends: ${_this.friends})';
}


}

/// @nodoc
abstract mixin class $FriendsHubPageCopyWith<$Res>  {
  factory $FriendsHubPageCopyWith(FriendsHubPage value, $Res Function(FriendsHubPage) _then) = _$FriendsHubPageCopyWithImpl;
@useResult
$Res call({
 int friendsCount, String friendsCountLabel, String syncNotice, List<FriendsHubRequest> received, List<FriendsHubRequest> sent, List<FriendsHubFriend> friends
});




}
/// @nodoc
class _$FriendsHubPageCopyWithImpl<$Res>
    implements $FriendsHubPageCopyWith<$Res> {
  _$FriendsHubPageCopyWithImpl(this._self, this._then);

  final FriendsHubPage _self;
  final $Res Function(FriendsHubPage) _then;

/// Create a copy of FriendsHubPage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? friendsCount = null,Object? friendsCountLabel = null,Object? syncNotice = null,Object? received = null,Object? sent = null,Object? friends = null,}) {
  return _then(FriendsHubPage(
friendsCount: null == friendsCount ? _self.friendsCount : friendsCount // ignore: cast_nullable_to_non_nullable
as int,friendsCountLabel: null == friendsCountLabel ? _self.friendsCountLabel : friendsCountLabel // ignore: cast_nullable_to_non_nullable
as String,syncNotice: null == syncNotice ? _self.syncNotice : syncNotice // ignore: cast_nullable_to_non_nullable
as String,received: null == received ? _self.received : received // ignore: cast_nullable_to_non_nullable
as List<FriendsHubRequest>,sent: null == sent ? _self.sent : sent // ignore: cast_nullable_to_non_nullable
as List<FriendsHubRequest>,friends: null == friends ? _self.friends : friends // ignore: cast_nullable_to_non_nullable
as List<FriendsHubFriend>,
  ));
}

}


/// Adds pattern-matching-related methods to [FriendsHubPage].
extension FriendsHubPagePatterns on FriendsHubPage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FriendsHubPage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FriendsHubPage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FriendsHubPage value)  $default,){
final _that = this;
switch (_that) {
case _FriendsHubPage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FriendsHubPage value)?  $default,){
final _that = this;
switch (_that) {
case _FriendsHubPage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int friendsCount,  String friendsCountLabel,  String syncNotice,  List<FriendsHubRequest> received,  List<FriendsHubRequest> sent,  List<FriendsHubFriend> friends)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FriendsHubPage() when $default != null:
return $default(_that.friendsCount,_that.friendsCountLabel,_that.syncNotice,_that.received,_that.sent,_that.friends);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int friendsCount,  String friendsCountLabel,  String syncNotice,  List<FriendsHubRequest> received,  List<FriendsHubRequest> sent,  List<FriendsHubFriend> friends)  $default,) {final _that = this;
switch (_that) {
case _FriendsHubPage():
return $default(_that.friendsCount,_that.friendsCountLabel,_that.syncNotice,_that.received,_that.sent,_that.friends);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int friendsCount,  String friendsCountLabel,  String syncNotice,  List<FriendsHubRequest> received,  List<FriendsHubRequest> sent,  List<FriendsHubFriend> friends)?  $default,) {final _that = this;
switch (_that) {
case _FriendsHubPage() when $default != null:
return $default(_that.friendsCount,_that.friendsCountLabel,_that.syncNotice,_that.received,_that.sent,_that.friends);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FriendsHubPage implements FriendsHubPage {
  const _FriendsHubPage({this.friendsCount = 0, this.friendsCountLabel = 'Bạn bè đồng hành', this.syncNotice = 'Đã đồng bộ hóa danh bạ du lịch và chuyến đi chung gần nhất.',  List<FriendsHubRequest> received = const <FriendsHubRequest>[],  List<FriendsHubRequest> sent = const <FriendsHubRequest>[],  List<FriendsHubFriend> friends = const <FriendsHubFriend>[]}): _received = received,_sent = sent,_friends = friends;
  factory _FriendsHubPage.fromJson(Map<String, dynamic> json) => _$FriendsHubPageFromJson(json);

@override@JsonKey() final  int friendsCount;
@override@JsonKey() final  String friendsCountLabel;
@override@JsonKey() final  String syncNotice;
 final  List<FriendsHubRequest> _received;
@override@JsonKey() List<FriendsHubRequest> get received {
  if (_received is EqualUnmodifiableListView) return _received;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_received);
}

 final  List<FriendsHubRequest> _sent;
@override@JsonKey() List<FriendsHubRequest> get sent {
  if (_sent is EqualUnmodifiableListView) return _sent;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sent);
}

 final  List<FriendsHubFriend> _friends;
@override@JsonKey() List<FriendsHubFriend> get friends {
  if (_friends is EqualUnmodifiableListView) return _friends;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_friends);
}


/// Create a copy of FriendsHubPage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FriendsHubPageCopyWith<_FriendsHubPage> get copyWith => __$FriendsHubPageCopyWithImpl<_FriendsHubPage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FriendsHubPageToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _FriendsHubPage&&(identical(other.friendsCount, friendsCount) || other.friendsCount == friendsCount)&&(identical(other.friendsCountLabel, friendsCountLabel) || other.friendsCountLabel == friendsCountLabel)&&(identical(other.syncNotice, syncNotice) || other.syncNotice == syncNotice)&&const DeepCollectionEquality().equals(other.received, _received)&&const DeepCollectionEquality().equals(other.sent, _sent)&&const DeepCollectionEquality().equals(other.friends, _friends));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,friendsCount,friendsCountLabel,syncNotice,const DeepCollectionEquality().hash(_received),const DeepCollectionEquality().hash(_sent),const DeepCollectionEquality().hash(_friends));
}

@override
String toString() {
    return 'FriendsHubPage(friendsCount: $friendsCount, friendsCountLabel: $friendsCountLabel, syncNotice: $syncNotice, received: $received, sent: $sent, friends: $friends)';
}


}

/// @nodoc
abstract mixin class _$FriendsHubPageCopyWith<$Res> implements $FriendsHubPageCopyWith<$Res> {
  factory _$FriendsHubPageCopyWith(_FriendsHubPage value, $Res Function(_FriendsHubPage) _then) = __$FriendsHubPageCopyWithImpl;
@override @useResult
$Res call({
 int friendsCount, String friendsCountLabel, String syncNotice, List<FriendsHubRequest> received, List<FriendsHubRequest> sent, List<FriendsHubFriend> friends
});




}
/// @nodoc
class __$FriendsHubPageCopyWithImpl<$Res>
    implements _$FriendsHubPageCopyWith<$Res> {
  __$FriendsHubPageCopyWithImpl(this._self, this._then);

  final _FriendsHubPage _self;
  final $Res Function(_FriendsHubPage) _then;

/// Create a copy of FriendsHubPage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? friendsCount = null,Object? friendsCountLabel = null,Object? syncNotice = null,Object? received = null,Object? sent = null,Object? friends = null,}) {
  return _then(_FriendsHubPage(
friendsCount: null == friendsCount ? _self.friendsCount : friendsCount // ignore: cast_nullable_to_non_nullable
as int,friendsCountLabel: null == friendsCountLabel ? _self.friendsCountLabel : friendsCountLabel // ignore: cast_nullable_to_non_nullable
as String,syncNotice: null == syncNotice ? _self.syncNotice : syncNotice // ignore: cast_nullable_to_non_nullable
as String,received: null == received ? _self._received : received // ignore: cast_nullable_to_non_nullable
as List<FriendsHubRequest>,sent: null == sent ? _self._sent : sent // ignore: cast_nullable_to_non_nullable
as List<FriendsHubRequest>,friends: null == friends ? _self._friends : friends // ignore: cast_nullable_to_non_nullable
as List<FriendsHubFriend>,
  ));
}


}


/// @nodoc
mixin _$FriendsHubUser {

 String get id; String get displayName; String get username; String? get avatarUrl; bool get isOnline; bool get verified; String? get subtitle; String? get metaIcon; String? get metaLine; String? get badgeLabel; FriendsHubBadgeTone get badgeTone;
/// Create a copy of FriendsHubUser
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FriendsHubUserCopyWith<FriendsHubUser> get copyWith => _$FriendsHubUserCopyWithImpl<FriendsHubUser>(this as FriendsHubUser, _$identity);

  /// Serializes this FriendsHubUser to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as FriendsHubUser;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FriendsHubUser&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.displayName, _this.displayName) || other.displayName == _this.displayName)&&(identical(other.username, _this.username) || other.username == _this.username)&&(identical(other.avatarUrl, _this.avatarUrl) || other.avatarUrl == _this.avatarUrl)&&(identical(other.isOnline, _this.isOnline) || other.isOnline == _this.isOnline)&&(identical(other.verified, _this.verified) || other.verified == _this.verified)&&(identical(other.subtitle, _this.subtitle) || other.subtitle == _this.subtitle)&&(identical(other.metaIcon, _this.metaIcon) || other.metaIcon == _this.metaIcon)&&(identical(other.metaLine, _this.metaLine) || other.metaLine == _this.metaLine)&&(identical(other.badgeLabel, _this.badgeLabel) || other.badgeLabel == _this.badgeLabel)&&(identical(other.badgeTone, _this.badgeTone) || other.badgeTone == _this.badgeTone));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as FriendsHubUser;
  return Object.hash(runtimeType,_this.id,_this.displayName,_this.username,_this.avatarUrl,_this.isOnline,_this.verified,_this.subtitle,_this.metaIcon,_this.metaLine,_this.badgeLabel,_this.badgeTone);
}

@override
String toString() {
  final _this = this as FriendsHubUser;
  return 'FriendsHubUser(id: ${_this.id}, displayName: ${_this.displayName}, username: ${_this.username}, avatarUrl: ${_this.avatarUrl}, isOnline: ${_this.isOnline}, verified: ${_this.verified}, subtitle: ${_this.subtitle}, metaIcon: ${_this.metaIcon}, metaLine: ${_this.metaLine}, badgeLabel: ${_this.badgeLabel}, badgeTone: ${_this.badgeTone})';
}


}

/// @nodoc
abstract mixin class $FriendsHubUserCopyWith<$Res>  {
  factory $FriendsHubUserCopyWith(FriendsHubUser value, $Res Function(FriendsHubUser) _then) = _$FriendsHubUserCopyWithImpl;
@useResult
$Res call({
 String id, String displayName, String username, String? avatarUrl, bool isOnline, bool verified, String? subtitle, String? metaIcon, String? metaLine, String? badgeLabel, FriendsHubBadgeTone badgeTone
});




}
/// @nodoc
class _$FriendsHubUserCopyWithImpl<$Res>
    implements $FriendsHubUserCopyWith<$Res> {
  _$FriendsHubUserCopyWithImpl(this._self, this._then);

  final FriendsHubUser _self;
  final $Res Function(FriendsHubUser) _then;

/// Create a copy of FriendsHubUser
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? displayName = null,Object? username = null,Object? avatarUrl = freezed,Object? isOnline = null,Object? verified = null,Object? subtitle = freezed,Object? metaIcon = freezed,Object? metaLine = freezed,Object? badgeLabel = freezed,Object? badgeTone = null,}) {
  return _then(FriendsHubUser(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,isOnline: null == isOnline ? _self.isOnline : isOnline // ignore: cast_nullable_to_non_nullable
as bool,verified: null == verified ? _self.verified : verified // ignore: cast_nullable_to_non_nullable
as bool,subtitle: freezed == subtitle ? _self.subtitle : subtitle // ignore: cast_nullable_to_non_nullable
as String?,metaIcon: freezed == metaIcon ? _self.metaIcon : metaIcon // ignore: cast_nullable_to_non_nullable
as String?,metaLine: freezed == metaLine ? _self.metaLine : metaLine // ignore: cast_nullable_to_non_nullable
as String?,badgeLabel: freezed == badgeLabel ? _self.badgeLabel : badgeLabel // ignore: cast_nullable_to_non_nullable
as String?,badgeTone: null == badgeTone ? _self.badgeTone : badgeTone // ignore: cast_nullable_to_non_nullable
as FriendsHubBadgeTone,
  ));
}

}


/// Adds pattern-matching-related methods to [FriendsHubUser].
extension FriendsHubUserPatterns on FriendsHubUser {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FriendsHubUser value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FriendsHubUser() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FriendsHubUser value)  $default,){
final _that = this;
switch (_that) {
case _FriendsHubUser():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FriendsHubUser value)?  $default,){
final _that = this;
switch (_that) {
case _FriendsHubUser() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String displayName,  String username,  String? avatarUrl,  bool isOnline,  bool verified,  String? subtitle,  String? metaIcon,  String? metaLine,  String? badgeLabel,  FriendsHubBadgeTone badgeTone)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FriendsHubUser() when $default != null:
return $default(_that.id,_that.displayName,_that.username,_that.avatarUrl,_that.isOnline,_that.verified,_that.subtitle,_that.metaIcon,_that.metaLine,_that.badgeLabel,_that.badgeTone);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String displayName,  String username,  String? avatarUrl,  bool isOnline,  bool verified,  String? subtitle,  String? metaIcon,  String? metaLine,  String? badgeLabel,  FriendsHubBadgeTone badgeTone)  $default,) {final _that = this;
switch (_that) {
case _FriendsHubUser():
return $default(_that.id,_that.displayName,_that.username,_that.avatarUrl,_that.isOnline,_that.verified,_that.subtitle,_that.metaIcon,_that.metaLine,_that.badgeLabel,_that.badgeTone);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String displayName,  String username,  String? avatarUrl,  bool isOnline,  bool verified,  String? subtitle,  String? metaIcon,  String? metaLine,  String? badgeLabel,  FriendsHubBadgeTone badgeTone)?  $default,) {final _that = this;
switch (_that) {
case _FriendsHubUser() when $default != null:
return $default(_that.id,_that.displayName,_that.username,_that.avatarUrl,_that.isOnline,_that.verified,_that.subtitle,_that.metaIcon,_that.metaLine,_that.badgeLabel,_that.badgeTone);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FriendsHubUser implements FriendsHubUser {
  const _FriendsHubUser({required this.id, required this.displayName, required this.username, this.avatarUrl, this.isOnline = false, this.verified = false, this.subtitle, this.metaIcon, this.metaLine, this.badgeLabel, this.badgeTone = FriendsHubBadgeTone.subdued});
  factory _FriendsHubUser.fromJson(Map<String, dynamic> json) => _$FriendsHubUserFromJson(json);

@override final  String id;
@override final  String displayName;
@override final  String username;
@override final  String? avatarUrl;
@override@JsonKey() final  bool isOnline;
@override@JsonKey() final  bool verified;
@override final  String? subtitle;
@override final  String? metaIcon;
@override final  String? metaLine;
@override final  String? badgeLabel;
@override@JsonKey() final  FriendsHubBadgeTone badgeTone;

/// Create a copy of FriendsHubUser
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FriendsHubUserCopyWith<_FriendsHubUser> get copyWith => __$FriendsHubUserCopyWithImpl<_FriendsHubUser>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FriendsHubUserToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _FriendsHubUser&&(identical(other.id, id) || other.id == id)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.username, username) || other.username == username)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.isOnline, isOnline) || other.isOnline == isOnline)&&(identical(other.verified, verified) || other.verified == verified)&&(identical(other.subtitle, subtitle) || other.subtitle == subtitle)&&(identical(other.metaIcon, metaIcon) || other.metaIcon == metaIcon)&&(identical(other.metaLine, metaLine) || other.metaLine == metaLine)&&(identical(other.badgeLabel, badgeLabel) || other.badgeLabel == badgeLabel)&&(identical(other.badgeTone, badgeTone) || other.badgeTone == badgeTone));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,displayName,username,avatarUrl,isOnline,verified,subtitle,metaIcon,metaLine,badgeLabel,badgeTone);
}

@override
String toString() {
    return 'FriendsHubUser(id: $id, displayName: $displayName, username: $username, avatarUrl: $avatarUrl, isOnline: $isOnline, verified: $verified, subtitle: $subtitle, metaIcon: $metaIcon, metaLine: $metaLine, badgeLabel: $badgeLabel, badgeTone: $badgeTone)';
}


}

/// @nodoc
abstract mixin class _$FriendsHubUserCopyWith<$Res> implements $FriendsHubUserCopyWith<$Res> {
  factory _$FriendsHubUserCopyWith(_FriendsHubUser value, $Res Function(_FriendsHubUser) _then) = __$FriendsHubUserCopyWithImpl;
@override @useResult
$Res call({
 String id, String displayName, String username, String? avatarUrl, bool isOnline, bool verified, String? subtitle, String? metaIcon, String? metaLine, String? badgeLabel, FriendsHubBadgeTone badgeTone
});




}
/// @nodoc
class __$FriendsHubUserCopyWithImpl<$Res>
    implements _$FriendsHubUserCopyWith<$Res> {
  __$FriendsHubUserCopyWithImpl(this._self, this._then);

  final _FriendsHubUser _self;
  final $Res Function(_FriendsHubUser) _then;

/// Create a copy of FriendsHubUser
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? displayName = null,Object? username = null,Object? avatarUrl = freezed,Object? isOnline = null,Object? verified = null,Object? subtitle = freezed,Object? metaIcon = freezed,Object? metaLine = freezed,Object? badgeLabel = freezed,Object? badgeTone = null,}) {
  return _then(_FriendsHubUser(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,isOnline: null == isOnline ? _self.isOnline : isOnline // ignore: cast_nullable_to_non_nullable
as bool,verified: null == verified ? _self.verified : verified // ignore: cast_nullable_to_non_nullable
as bool,subtitle: freezed == subtitle ? _self.subtitle : subtitle // ignore: cast_nullable_to_non_nullable
as String?,metaIcon: freezed == metaIcon ? _self.metaIcon : metaIcon // ignore: cast_nullable_to_non_nullable
as String?,metaLine: freezed == metaLine ? _self.metaLine : metaLine // ignore: cast_nullable_to_non_nullable
as String?,badgeLabel: freezed == badgeLabel ? _self.badgeLabel : badgeLabel // ignore: cast_nullable_to_non_nullable
as String?,badgeTone: null == badgeTone ? _self.badgeTone : badgeTone // ignore: cast_nullable_to_non_nullable
as FriendsHubBadgeTone,
  ));
}


}


/// @nodoc
mixin _$FriendsHubRequest {

 String get id; FriendsHubUser get user; DateTime get createdAt;
/// Create a copy of FriendsHubRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FriendsHubRequestCopyWith<FriendsHubRequest> get copyWith => _$FriendsHubRequestCopyWithImpl<FriendsHubRequest>(this as FriendsHubRequest, _$identity);

  /// Serializes this FriendsHubRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as FriendsHubRequest;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FriendsHubRequest&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.user, _this.user) || other.user == _this.user)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as FriendsHubRequest;
  return Object.hash(runtimeType,_this.id,_this.user,_this.createdAt);
}

@override
String toString() {
  final _this = this as FriendsHubRequest;
  return 'FriendsHubRequest(id: ${_this.id}, user: ${_this.user}, createdAt: ${_this.createdAt})';
}


}

/// @nodoc
abstract mixin class $FriendsHubRequestCopyWith<$Res>  {
  factory $FriendsHubRequestCopyWith(FriendsHubRequest value, $Res Function(FriendsHubRequest) _then) = _$FriendsHubRequestCopyWithImpl;
@useResult
$Res call({
 String id, FriendsHubUser user, DateTime createdAt
});


$FriendsHubUserCopyWith<$Res> get user;

}
/// @nodoc
class _$FriendsHubRequestCopyWithImpl<$Res>
    implements $FriendsHubRequestCopyWith<$Res> {
  _$FriendsHubRequestCopyWithImpl(this._self, this._then);

  final FriendsHubRequest _self;
  final $Res Function(FriendsHubRequest) _then;

/// Create a copy of FriendsHubRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? user = null,Object? createdAt = null,}) {
  return _then(FriendsHubRequest(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as FriendsHubUser,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}
/// Create a copy of FriendsHubRequest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FriendsHubUserCopyWith<$Res> get user {
  
  return $FriendsHubUserCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}


/// Adds pattern-matching-related methods to [FriendsHubRequest].
extension FriendsHubRequestPatterns on FriendsHubRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FriendsHubRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FriendsHubRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FriendsHubRequest value)  $default,){
final _that = this;
switch (_that) {
case _FriendsHubRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FriendsHubRequest value)?  $default,){
final _that = this;
switch (_that) {
case _FriendsHubRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  FriendsHubUser user,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FriendsHubRequest() when $default != null:
return $default(_that.id,_that.user,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  FriendsHubUser user,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _FriendsHubRequest():
return $default(_that.id,_that.user,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  FriendsHubUser user,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _FriendsHubRequest() when $default != null:
return $default(_that.id,_that.user,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FriendsHubRequest implements FriendsHubRequest {
  const _FriendsHubRequest({required this.id, required this.user, required this.createdAt});
  factory _FriendsHubRequest.fromJson(Map<String, dynamic> json) => _$FriendsHubRequestFromJson(json);

@override final  String id;
@override final  FriendsHubUser user;
@override final  DateTime createdAt;

/// Create a copy of FriendsHubRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FriendsHubRequestCopyWith<_FriendsHubRequest> get copyWith => __$FriendsHubRequestCopyWithImpl<_FriendsHubRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FriendsHubRequestToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _FriendsHubRequest&&(identical(other.id, id) || other.id == id)&&(identical(other.user, user) || other.user == user)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,user,createdAt);
}

@override
String toString() {
    return 'FriendsHubRequest(id: $id, user: $user, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$FriendsHubRequestCopyWith<$Res> implements $FriendsHubRequestCopyWith<$Res> {
  factory _$FriendsHubRequestCopyWith(_FriendsHubRequest value, $Res Function(_FriendsHubRequest) _then) = __$FriendsHubRequestCopyWithImpl;
@override @useResult
$Res call({
 String id, FriendsHubUser user, DateTime createdAt
});


@override $FriendsHubUserCopyWith<$Res> get user;

}
/// @nodoc
class __$FriendsHubRequestCopyWithImpl<$Res>
    implements _$FriendsHubRequestCopyWith<$Res> {
  __$FriendsHubRequestCopyWithImpl(this._self, this._then);

  final _FriendsHubRequest _self;
  final $Res Function(_FriendsHubRequest) _then;

/// Create a copy of FriendsHubRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? user = null,Object? createdAt = null,}) {
  return _then(_FriendsHubRequest(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as FriendsHubUser,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

/// Create a copy of FriendsHubRequest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FriendsHubUserCopyWith<$Res> get user {
  
  return $FriendsHubUserCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}


/// @nodoc
mixin _$FriendsHubFriend {

 String get friendshipId; String get friendId; FriendsHubUser get user; DateTime get createdAt; String? get conversationId;
/// Create a copy of FriendsHubFriend
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FriendsHubFriendCopyWith<FriendsHubFriend> get copyWith => _$FriendsHubFriendCopyWithImpl<FriendsHubFriend>(this as FriendsHubFriend, _$identity);

  /// Serializes this FriendsHubFriend to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as FriendsHubFriend;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FriendsHubFriend&&(identical(other.friendshipId, _this.friendshipId) || other.friendshipId == _this.friendshipId)&&(identical(other.friendId, _this.friendId) || other.friendId == _this.friendId)&&(identical(other.user, _this.user) || other.user == _this.user)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.conversationId, _this.conversationId) || other.conversationId == _this.conversationId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as FriendsHubFriend;
  return Object.hash(runtimeType,_this.friendshipId,_this.friendId,_this.user,_this.createdAt,_this.conversationId);
}

@override
String toString() {
  final _this = this as FriendsHubFriend;
  return 'FriendsHubFriend(friendshipId: ${_this.friendshipId}, friendId: ${_this.friendId}, user: ${_this.user}, createdAt: ${_this.createdAt}, conversationId: ${_this.conversationId})';
}


}

/// @nodoc
abstract mixin class $FriendsHubFriendCopyWith<$Res>  {
  factory $FriendsHubFriendCopyWith(FriendsHubFriend value, $Res Function(FriendsHubFriend) _then) = _$FriendsHubFriendCopyWithImpl;
@useResult
$Res call({
 String friendshipId, String friendId, FriendsHubUser user, DateTime createdAt, String? conversationId
});


$FriendsHubUserCopyWith<$Res> get user;

}
/// @nodoc
class _$FriendsHubFriendCopyWithImpl<$Res>
    implements $FriendsHubFriendCopyWith<$Res> {
  _$FriendsHubFriendCopyWithImpl(this._self, this._then);

  final FriendsHubFriend _self;
  final $Res Function(FriendsHubFriend) _then;

/// Create a copy of FriendsHubFriend
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? friendshipId = null,Object? friendId = null,Object? user = null,Object? createdAt = null,Object? conversationId = freezed,}) {
  return _then(FriendsHubFriend(
friendshipId: null == friendshipId ? _self.friendshipId : friendshipId // ignore: cast_nullable_to_non_nullable
as String,friendId: null == friendId ? _self.friendId : friendId // ignore: cast_nullable_to_non_nullable
as String,user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as FriendsHubUser,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,conversationId: freezed == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of FriendsHubFriend
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FriendsHubUserCopyWith<$Res> get user {
  
  return $FriendsHubUserCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}


/// Adds pattern-matching-related methods to [FriendsHubFriend].
extension FriendsHubFriendPatterns on FriendsHubFriend {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FriendsHubFriend value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FriendsHubFriend() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FriendsHubFriend value)  $default,){
final _that = this;
switch (_that) {
case _FriendsHubFriend():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FriendsHubFriend value)?  $default,){
final _that = this;
switch (_that) {
case _FriendsHubFriend() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String friendshipId,  String friendId,  FriendsHubUser user,  DateTime createdAt,  String? conversationId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FriendsHubFriend() when $default != null:
return $default(_that.friendshipId,_that.friendId,_that.user,_that.createdAt,_that.conversationId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String friendshipId,  String friendId,  FriendsHubUser user,  DateTime createdAt,  String? conversationId)  $default,) {final _that = this;
switch (_that) {
case _FriendsHubFriend():
return $default(_that.friendshipId,_that.friendId,_that.user,_that.createdAt,_that.conversationId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String friendshipId,  String friendId,  FriendsHubUser user,  DateTime createdAt,  String? conversationId)?  $default,) {final _that = this;
switch (_that) {
case _FriendsHubFriend() when $default != null:
return $default(_that.friendshipId,_that.friendId,_that.user,_that.createdAt,_that.conversationId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FriendsHubFriend implements FriendsHubFriend {
  const _FriendsHubFriend({required this.friendshipId, required this.friendId, required this.user, required this.createdAt, this.conversationId});
  factory _FriendsHubFriend.fromJson(Map<String, dynamic> json) => _$FriendsHubFriendFromJson(json);

@override final  String friendshipId;
@override final  String friendId;
@override final  FriendsHubUser user;
@override final  DateTime createdAt;
@override final  String? conversationId;

/// Create a copy of FriendsHubFriend
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FriendsHubFriendCopyWith<_FriendsHubFriend> get copyWith => __$FriendsHubFriendCopyWithImpl<_FriendsHubFriend>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FriendsHubFriendToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _FriendsHubFriend&&(identical(other.friendshipId, friendshipId) || other.friendshipId == friendshipId)&&(identical(other.friendId, friendId) || other.friendId == friendId)&&(identical(other.user, user) || other.user == user)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,friendshipId,friendId,user,createdAt,conversationId);
}

@override
String toString() {
    return 'FriendsHubFriend(friendshipId: $friendshipId, friendId: $friendId, user: $user, createdAt: $createdAt, conversationId: $conversationId)';
}


}

/// @nodoc
abstract mixin class _$FriendsHubFriendCopyWith<$Res> implements $FriendsHubFriendCopyWith<$Res> {
  factory _$FriendsHubFriendCopyWith(_FriendsHubFriend value, $Res Function(_FriendsHubFriend) _then) = __$FriendsHubFriendCopyWithImpl;
@override @useResult
$Res call({
 String friendshipId, String friendId, FriendsHubUser user, DateTime createdAt, String? conversationId
});


@override $FriendsHubUserCopyWith<$Res> get user;

}
/// @nodoc
class __$FriendsHubFriendCopyWithImpl<$Res>
    implements _$FriendsHubFriendCopyWith<$Res> {
  __$FriendsHubFriendCopyWithImpl(this._self, this._then);

  final _FriendsHubFriend _self;
  final $Res Function(_FriendsHubFriend) _then;

/// Create a copy of FriendsHubFriend
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? friendshipId = null,Object? friendId = null,Object? user = null,Object? createdAt = null,Object? conversationId = freezed,}) {
  return _then(_FriendsHubFriend(
friendshipId: null == friendshipId ? _self.friendshipId : friendshipId // ignore: cast_nullable_to_non_nullable
as String,friendId: null == friendId ? _self.friendId : friendId // ignore: cast_nullable_to_non_nullable
as String,user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as FriendsHubUser,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,conversationId: freezed == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of FriendsHubFriend
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FriendsHubUserCopyWith<$Res> get user {
  
  return $FriendsHubUserCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}

// dart format on
