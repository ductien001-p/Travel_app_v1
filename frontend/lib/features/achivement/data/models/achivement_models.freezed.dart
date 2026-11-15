// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'achivement_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TripMissionsPage {

 int get completedCount; int get totalCount; int get missionPointsEarned; int get missionPointsCap; int get missionPointsPending; List<TripMissionItem> get items;
/// Create a copy of TripMissionsPage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TripMissionsPageCopyWith<TripMissionsPage> get copyWith => _$TripMissionsPageCopyWithImpl<TripMissionsPage>(this as TripMissionsPage, _$identity);

  /// Serializes this TripMissionsPage to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TripMissionsPage;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TripMissionsPage&&(identical(other.completedCount, _this.completedCount) || other.completedCount == _this.completedCount)&&(identical(other.totalCount, _this.totalCount) || other.totalCount == _this.totalCount)&&(identical(other.missionPointsEarned, _this.missionPointsEarned) || other.missionPointsEarned == _this.missionPointsEarned)&&(identical(other.missionPointsCap, _this.missionPointsCap) || other.missionPointsCap == _this.missionPointsCap)&&(identical(other.missionPointsPending, _this.missionPointsPending) || other.missionPointsPending == _this.missionPointsPending)&&const DeepCollectionEquality().equals(other.items, _this.items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TripMissionsPage;
  return Object.hash(runtimeType,_this.completedCount,_this.totalCount,_this.missionPointsEarned,_this.missionPointsCap,_this.missionPointsPending,const DeepCollectionEquality().hash(_this.items));
}

@override
String toString() {
  final _this = this as TripMissionsPage;
  return 'TripMissionsPage(completedCount: ${_this.completedCount}, totalCount: ${_this.totalCount}, missionPointsEarned: ${_this.missionPointsEarned}, missionPointsCap: ${_this.missionPointsCap}, missionPointsPending: ${_this.missionPointsPending}, items: ${_this.items})';
}


}

/// @nodoc
abstract mixin class $TripMissionsPageCopyWith<$Res>  {
  factory $TripMissionsPageCopyWith(TripMissionsPage value, $Res Function(TripMissionsPage) _then) = _$TripMissionsPageCopyWithImpl;
@useResult
$Res call({
 int completedCount, int totalCount, int missionPointsEarned, int missionPointsCap, int missionPointsPending, List<TripMissionItem> items
});




}
/// @nodoc
class _$TripMissionsPageCopyWithImpl<$Res>
    implements $TripMissionsPageCopyWith<$Res> {
  _$TripMissionsPageCopyWithImpl(this._self, this._then);

  final TripMissionsPage _self;
  final $Res Function(TripMissionsPage) _then;

/// Create a copy of TripMissionsPage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? completedCount = null,Object? totalCount = null,Object? missionPointsEarned = null,Object? missionPointsCap = null,Object? missionPointsPending = null,Object? items = null,}) {
  return _then(TripMissionsPage(
completedCount: null == completedCount ? _self.completedCount : completedCount // ignore: cast_nullable_to_non_nullable
as int,totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,missionPointsEarned: null == missionPointsEarned ? _self.missionPointsEarned : missionPointsEarned // ignore: cast_nullable_to_non_nullable
as int,missionPointsCap: null == missionPointsCap ? _self.missionPointsCap : missionPointsCap // ignore: cast_nullable_to_non_nullable
as int,missionPointsPending: null == missionPointsPending ? _self.missionPointsPending : missionPointsPending // ignore: cast_nullable_to_non_nullable
as int,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<TripMissionItem>,
  ));
}

}


/// Adds pattern-matching-related methods to [TripMissionsPage].
extension TripMissionsPagePatterns on TripMissionsPage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TripMissionsPage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TripMissionsPage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TripMissionsPage value)  $default,){
final _that = this;
switch (_that) {
case _TripMissionsPage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TripMissionsPage value)?  $default,){
final _that = this;
switch (_that) {
case _TripMissionsPage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int completedCount,  int totalCount,  int missionPointsEarned,  int missionPointsCap,  int missionPointsPending,  List<TripMissionItem> items)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TripMissionsPage() when $default != null:
return $default(_that.completedCount,_that.totalCount,_that.missionPointsEarned,_that.missionPointsCap,_that.missionPointsPending,_that.items);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int completedCount,  int totalCount,  int missionPointsEarned,  int missionPointsCap,  int missionPointsPending,  List<TripMissionItem> items)  $default,) {final _that = this;
switch (_that) {
case _TripMissionsPage():
return $default(_that.completedCount,_that.totalCount,_that.missionPointsEarned,_that.missionPointsCap,_that.missionPointsPending,_that.items);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int completedCount,  int totalCount,  int missionPointsEarned,  int missionPointsCap,  int missionPointsPending,  List<TripMissionItem> items)?  $default,) {final _that = this;
switch (_that) {
case _TripMissionsPage() when $default != null:
return $default(_that.completedCount,_that.totalCount,_that.missionPointsEarned,_that.missionPointsCap,_that.missionPointsPending,_that.items);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TripMissionsPage extends TripMissionsPage {
  const _TripMissionsPage({this.completedCount = 0, this.totalCount = 0, this.missionPointsEarned = 0, this.missionPointsCap = 80, this.missionPointsPending = 0,  List<TripMissionItem> items = const <TripMissionItem>[]}): _items = items,super._();
  factory _TripMissionsPage.fromJson(Map<String, dynamic> json) => _$TripMissionsPageFromJson(json);

@override@JsonKey() final  int completedCount;
@override@JsonKey() final  int totalCount;
@override@JsonKey() final  int missionPointsEarned;
@override@JsonKey() final  int missionPointsCap;
@override@JsonKey() final  int missionPointsPending;
 final  List<TripMissionItem> _items;
@override@JsonKey() List<TripMissionItem> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}


/// Create a copy of TripMissionsPage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TripMissionsPageCopyWith<_TripMissionsPage> get copyWith => __$TripMissionsPageCopyWithImpl<_TripMissionsPage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TripMissionsPageToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TripMissionsPage&&(identical(other.completedCount, completedCount) || other.completedCount == completedCount)&&(identical(other.totalCount, totalCount) || other.totalCount == totalCount)&&(identical(other.missionPointsEarned, missionPointsEarned) || other.missionPointsEarned == missionPointsEarned)&&(identical(other.missionPointsCap, missionPointsCap) || other.missionPointsCap == missionPointsCap)&&(identical(other.missionPointsPending, missionPointsPending) || other.missionPointsPending == missionPointsPending)&&const DeepCollectionEquality().equals(other.items, _items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,completedCount,totalCount,missionPointsEarned,missionPointsCap,missionPointsPending,const DeepCollectionEquality().hash(_items));
}

@override
String toString() {
    return 'TripMissionsPage(completedCount: $completedCount, totalCount: $totalCount, missionPointsEarned: $missionPointsEarned, missionPointsCap: $missionPointsCap, missionPointsPending: $missionPointsPending, items: $items)';
}


}

/// @nodoc
abstract mixin class _$TripMissionsPageCopyWith<$Res> implements $TripMissionsPageCopyWith<$Res> {
  factory _$TripMissionsPageCopyWith(_TripMissionsPage value, $Res Function(_TripMissionsPage) _then) = __$TripMissionsPageCopyWithImpl;
@override @useResult
$Res call({
 int completedCount, int totalCount, int missionPointsEarned, int missionPointsCap, int missionPointsPending, List<TripMissionItem> items
});




}
/// @nodoc
class __$TripMissionsPageCopyWithImpl<$Res>
    implements _$TripMissionsPageCopyWith<$Res> {
  __$TripMissionsPageCopyWithImpl(this._self, this._then);

  final _TripMissionsPage _self;
  final $Res Function(_TripMissionsPage) _then;

/// Create a copy of TripMissionsPage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? completedCount = null,Object? totalCount = null,Object? missionPointsEarned = null,Object? missionPointsCap = null,Object? missionPointsPending = null,Object? items = null,}) {
  return _then(_TripMissionsPage(
completedCount: null == completedCount ? _self.completedCount : completedCount // ignore: cast_nullable_to_non_nullable
as int,totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,missionPointsEarned: null == missionPointsEarned ? _self.missionPointsEarned : missionPointsEarned // ignore: cast_nullable_to_non_nullable
as int,missionPointsCap: null == missionPointsCap ? _self.missionPointsCap : missionPointsCap // ignore: cast_nullable_to_non_nullable
as int,missionPointsPending: null == missionPointsPending ? _self.missionPointsPending : missionPointsPending // ignore: cast_nullable_to_non_nullable
as int,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<TripMissionItem>,
  ));
}


}


/// @nodoc
mixin _$TripMissionItem {

 String get id; String get code;@JsonKey(unknownEnumValue: TripMissionGroup.exploration) TripMissionGroup get group; String get title; String get subtitle; String get icon;@JsonKey(unknownEnumValue: TripMissionVerifyType.checkinCount) TripMissionVerifyType get verifyType; int get pointsReward; int get progressCurrent; int get progressTarget; bool get completed;@JsonKey(unknownEnumValue: TripMissionCta.itinerary) TripMissionCta get cta;
/// Create a copy of TripMissionItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TripMissionItemCopyWith<TripMissionItem> get copyWith => _$TripMissionItemCopyWithImpl<TripMissionItem>(this as TripMissionItem, _$identity);

  /// Serializes this TripMissionItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TripMissionItem;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TripMissionItem&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.code, _this.code) || other.code == _this.code)&&(identical(other.group, _this.group) || other.group == _this.group)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.subtitle, _this.subtitle) || other.subtitle == _this.subtitle)&&(identical(other.icon, _this.icon) || other.icon == _this.icon)&&(identical(other.verifyType, _this.verifyType) || other.verifyType == _this.verifyType)&&(identical(other.pointsReward, _this.pointsReward) || other.pointsReward == _this.pointsReward)&&(identical(other.progressCurrent, _this.progressCurrent) || other.progressCurrent == _this.progressCurrent)&&(identical(other.progressTarget, _this.progressTarget) || other.progressTarget == _this.progressTarget)&&(identical(other.completed, _this.completed) || other.completed == _this.completed)&&(identical(other.cta, _this.cta) || other.cta == _this.cta));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TripMissionItem;
  return Object.hash(runtimeType,_this.id,_this.code,_this.group,_this.title,_this.subtitle,_this.icon,_this.verifyType,_this.pointsReward,_this.progressCurrent,_this.progressTarget,_this.completed,_this.cta);
}

@override
String toString() {
  final _this = this as TripMissionItem;
  return 'TripMissionItem(id: ${_this.id}, code: ${_this.code}, group: ${_this.group}, title: ${_this.title}, subtitle: ${_this.subtitle}, icon: ${_this.icon}, verifyType: ${_this.verifyType}, pointsReward: ${_this.pointsReward}, progressCurrent: ${_this.progressCurrent}, progressTarget: ${_this.progressTarget}, completed: ${_this.completed}, cta: ${_this.cta})';
}


}

/// @nodoc
abstract mixin class $TripMissionItemCopyWith<$Res>  {
  factory $TripMissionItemCopyWith(TripMissionItem value, $Res Function(TripMissionItem) _then) = _$TripMissionItemCopyWithImpl;
@useResult
$Res call({
 String id, String code,@JsonKey(unknownEnumValue: TripMissionGroup.exploration) TripMissionGroup group, String title, String subtitle, String icon,@JsonKey(unknownEnumValue: TripMissionVerifyType.checkinCount) TripMissionVerifyType verifyType, int pointsReward, int progressCurrent, int progressTarget, bool completed,@JsonKey(unknownEnumValue: TripMissionCta.itinerary) TripMissionCta cta
});




}
/// @nodoc
class _$TripMissionItemCopyWithImpl<$Res>
    implements $TripMissionItemCopyWith<$Res> {
  _$TripMissionItemCopyWithImpl(this._self, this._then);

  final TripMissionItem _self;
  final $Res Function(TripMissionItem) _then;

/// Create a copy of TripMissionItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? code = null,Object? group = null,Object? title = null,Object? subtitle = null,Object? icon = null,Object? verifyType = null,Object? pointsReward = null,Object? progressCurrent = null,Object? progressTarget = null,Object? completed = null,Object? cta = null,}) {
  return _then(TripMissionItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,group: null == group ? _self.group : group // ignore: cast_nullable_to_non_nullable
as TripMissionGroup,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,subtitle: null == subtitle ? _self.subtitle : subtitle // ignore: cast_nullable_to_non_nullable
as String,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String,verifyType: null == verifyType ? _self.verifyType : verifyType // ignore: cast_nullable_to_non_nullable
as TripMissionVerifyType,pointsReward: null == pointsReward ? _self.pointsReward : pointsReward // ignore: cast_nullable_to_non_nullable
as int,progressCurrent: null == progressCurrent ? _self.progressCurrent : progressCurrent // ignore: cast_nullable_to_non_nullable
as int,progressTarget: null == progressTarget ? _self.progressTarget : progressTarget // ignore: cast_nullable_to_non_nullable
as int,completed: null == completed ? _self.completed : completed // ignore: cast_nullable_to_non_nullable
as bool,cta: null == cta ? _self.cta : cta // ignore: cast_nullable_to_non_nullable
as TripMissionCta,
  ));
}

}


/// Adds pattern-matching-related methods to [TripMissionItem].
extension TripMissionItemPatterns on TripMissionItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TripMissionItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TripMissionItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TripMissionItem value)  $default,){
final _that = this;
switch (_that) {
case _TripMissionItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TripMissionItem value)?  $default,){
final _that = this;
switch (_that) {
case _TripMissionItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String code, @JsonKey(unknownEnumValue: TripMissionGroup.exploration)  TripMissionGroup group,  String title,  String subtitle,  String icon, @JsonKey(unknownEnumValue: TripMissionVerifyType.checkinCount)  TripMissionVerifyType verifyType,  int pointsReward,  int progressCurrent,  int progressTarget,  bool completed, @JsonKey(unknownEnumValue: TripMissionCta.itinerary)  TripMissionCta cta)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TripMissionItem() when $default != null:
return $default(_that.id,_that.code,_that.group,_that.title,_that.subtitle,_that.icon,_that.verifyType,_that.pointsReward,_that.progressCurrent,_that.progressTarget,_that.completed,_that.cta);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String code, @JsonKey(unknownEnumValue: TripMissionGroup.exploration)  TripMissionGroup group,  String title,  String subtitle,  String icon, @JsonKey(unknownEnumValue: TripMissionVerifyType.checkinCount)  TripMissionVerifyType verifyType,  int pointsReward,  int progressCurrent,  int progressTarget,  bool completed, @JsonKey(unknownEnumValue: TripMissionCta.itinerary)  TripMissionCta cta)  $default,) {final _that = this;
switch (_that) {
case _TripMissionItem():
return $default(_that.id,_that.code,_that.group,_that.title,_that.subtitle,_that.icon,_that.verifyType,_that.pointsReward,_that.progressCurrent,_that.progressTarget,_that.completed,_that.cta);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String code, @JsonKey(unknownEnumValue: TripMissionGroup.exploration)  TripMissionGroup group,  String title,  String subtitle,  String icon, @JsonKey(unknownEnumValue: TripMissionVerifyType.checkinCount)  TripMissionVerifyType verifyType,  int pointsReward,  int progressCurrent,  int progressTarget,  bool completed, @JsonKey(unknownEnumValue: TripMissionCta.itinerary)  TripMissionCta cta)?  $default,) {final _that = this;
switch (_that) {
case _TripMissionItem() when $default != null:
return $default(_that.id,_that.code,_that.group,_that.title,_that.subtitle,_that.icon,_that.verifyType,_that.pointsReward,_that.progressCurrent,_that.progressTarget,_that.completed,_that.cta);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TripMissionItem extends TripMissionItem {
  const _TripMissionItem({required this.id, required this.code, @JsonKey(unknownEnumValue: TripMissionGroup.exploration) this.group = TripMissionGroup.exploration, required this.title, this.subtitle = '', this.icon = 'explore', @JsonKey(unknownEnumValue: TripMissionVerifyType.checkinCount) this.verifyType = TripMissionVerifyType.checkinCount, this.pointsReward = 0, this.progressCurrent = 0, this.progressTarget = 1, this.completed = false, @JsonKey(unknownEnumValue: TripMissionCta.itinerary) this.cta = TripMissionCta.itinerary}): super._();
  factory _TripMissionItem.fromJson(Map<String, dynamic> json) => _$TripMissionItemFromJson(json);

@override final  String id;
@override final  String code;
@override@JsonKey(unknownEnumValue: TripMissionGroup.exploration) final  TripMissionGroup group;
@override final  String title;
@override@JsonKey() final  String subtitle;
@override@JsonKey() final  String icon;
@override@JsonKey(unknownEnumValue: TripMissionVerifyType.checkinCount) final  TripMissionVerifyType verifyType;
@override@JsonKey() final  int pointsReward;
@override@JsonKey() final  int progressCurrent;
@override@JsonKey() final  int progressTarget;
@override@JsonKey() final  bool completed;
@override@JsonKey(unknownEnumValue: TripMissionCta.itinerary) final  TripMissionCta cta;

/// Create a copy of TripMissionItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TripMissionItemCopyWith<_TripMissionItem> get copyWith => __$TripMissionItemCopyWithImpl<_TripMissionItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TripMissionItemToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TripMissionItem&&(identical(other.id, id) || other.id == id)&&(identical(other.code, code) || other.code == code)&&(identical(other.group, group) || other.group == group)&&(identical(other.title, title) || other.title == title)&&(identical(other.subtitle, subtitle) || other.subtitle == subtitle)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.verifyType, verifyType) || other.verifyType == verifyType)&&(identical(other.pointsReward, pointsReward) || other.pointsReward == pointsReward)&&(identical(other.progressCurrent, progressCurrent) || other.progressCurrent == progressCurrent)&&(identical(other.progressTarget, progressTarget) || other.progressTarget == progressTarget)&&(identical(other.completed, completed) || other.completed == completed)&&(identical(other.cta, cta) || other.cta == cta));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,code,group,title,subtitle,icon,verifyType,pointsReward,progressCurrent,progressTarget,completed,cta);
}

@override
String toString() {
    return 'TripMissionItem(id: $id, code: $code, group: $group, title: $title, subtitle: $subtitle, icon: $icon, verifyType: $verifyType, pointsReward: $pointsReward, progressCurrent: $progressCurrent, progressTarget: $progressTarget, completed: $completed, cta: $cta)';
}


}

/// @nodoc
abstract mixin class _$TripMissionItemCopyWith<$Res> implements $TripMissionItemCopyWith<$Res> {
  factory _$TripMissionItemCopyWith(_TripMissionItem value, $Res Function(_TripMissionItem) _then) = __$TripMissionItemCopyWithImpl;
@override @useResult
$Res call({
 String id, String code,@JsonKey(unknownEnumValue: TripMissionGroup.exploration) TripMissionGroup group, String title, String subtitle, String icon,@JsonKey(unknownEnumValue: TripMissionVerifyType.checkinCount) TripMissionVerifyType verifyType, int pointsReward, int progressCurrent, int progressTarget, bool completed,@JsonKey(unknownEnumValue: TripMissionCta.itinerary) TripMissionCta cta
});




}
/// @nodoc
class __$TripMissionItemCopyWithImpl<$Res>
    implements _$TripMissionItemCopyWith<$Res> {
  __$TripMissionItemCopyWithImpl(this._self, this._then);

  final _TripMissionItem _self;
  final $Res Function(_TripMissionItem) _then;

/// Create a copy of TripMissionItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? code = null,Object? group = null,Object? title = null,Object? subtitle = null,Object? icon = null,Object? verifyType = null,Object? pointsReward = null,Object? progressCurrent = null,Object? progressTarget = null,Object? completed = null,Object? cta = null,}) {
  return _then(_TripMissionItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,group: null == group ? _self.group : group // ignore: cast_nullable_to_non_nullable
as TripMissionGroup,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,subtitle: null == subtitle ? _self.subtitle : subtitle // ignore: cast_nullable_to_non_nullable
as String,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String,verifyType: null == verifyType ? _self.verifyType : verifyType // ignore: cast_nullable_to_non_nullable
as TripMissionVerifyType,pointsReward: null == pointsReward ? _self.pointsReward : pointsReward // ignore: cast_nullable_to_non_nullable
as int,progressCurrent: null == progressCurrent ? _self.progressCurrent : progressCurrent // ignore: cast_nullable_to_non_nullable
as int,progressTarget: null == progressTarget ? _self.progressTarget : progressTarget // ignore: cast_nullable_to_non_nullable
as int,completed: null == completed ? _self.completed : completed // ignore: cast_nullable_to_non_nullable
as bool,cta: null == cta ? _self.cta : cta // ignore: cast_nullable_to_non_nullable
as TripMissionCta,
  ));
}


}


/// @nodoc
mixin _$TravelTier {

 String get code; String get label; double get multiplier; int get tripsCompleted; int get distinctCities; TravelTierNext? get next;
/// Create a copy of TravelTier
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TravelTierCopyWith<TravelTier> get copyWith => _$TravelTierCopyWithImpl<TravelTier>(this as TravelTier, _$identity);

  /// Serializes this TravelTier to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TravelTier;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TravelTier&&(identical(other.code, _this.code) || other.code == _this.code)&&(identical(other.label, _this.label) || other.label == _this.label)&&(identical(other.multiplier, _this.multiplier) || other.multiplier == _this.multiplier)&&(identical(other.tripsCompleted, _this.tripsCompleted) || other.tripsCompleted == _this.tripsCompleted)&&(identical(other.distinctCities, _this.distinctCities) || other.distinctCities == _this.distinctCities)&&(identical(other.next, _this.next) || other.next == _this.next));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TravelTier;
  return Object.hash(runtimeType,_this.code,_this.label,_this.multiplier,_this.tripsCompleted,_this.distinctCities,_this.next);
}

@override
String toString() {
  final _this = this as TravelTier;
  return 'TravelTier(code: ${_this.code}, label: ${_this.label}, multiplier: ${_this.multiplier}, tripsCompleted: ${_this.tripsCompleted}, distinctCities: ${_this.distinctCities}, next: ${_this.next})';
}


}

/// @nodoc
abstract mixin class $TravelTierCopyWith<$Res>  {
  factory $TravelTierCopyWith(TravelTier value, $Res Function(TravelTier) _then) = _$TravelTierCopyWithImpl;
@useResult
$Res call({
 String code, String label, double multiplier, int tripsCompleted, int distinctCities, TravelTierNext? next
});


$TravelTierNextCopyWith<$Res>? get next;

}
/// @nodoc
class _$TravelTierCopyWithImpl<$Res>
    implements $TravelTierCopyWith<$Res> {
  _$TravelTierCopyWithImpl(this._self, this._then);

  final TravelTier _self;
  final $Res Function(TravelTier) _then;

/// Create a copy of TravelTier
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? label = null,Object? multiplier = null,Object? tripsCompleted = null,Object? distinctCities = null,Object? next = freezed,}) {
  return _then(TravelTier(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,multiplier: null == multiplier ? _self.multiplier : multiplier // ignore: cast_nullable_to_non_nullable
as double,tripsCompleted: null == tripsCompleted ? _self.tripsCompleted : tripsCompleted // ignore: cast_nullable_to_non_nullable
as int,distinctCities: null == distinctCities ? _self.distinctCities : distinctCities // ignore: cast_nullable_to_non_nullable
as int,next: freezed == next ? _self.next : next // ignore: cast_nullable_to_non_nullable
as TravelTierNext?,
  ));
}
/// Create a copy of TravelTier
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TravelTierNextCopyWith<$Res>? get next {
    if (_self.next == null) {
    return null;
  }

  return $TravelTierNextCopyWith<$Res>(_self.next!, (value) {
    return _then(_self.copyWith(next: value));
  });
}
}


/// Adds pattern-matching-related methods to [TravelTier].
extension TravelTierPatterns on TravelTier {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TravelTier value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TravelTier() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TravelTier value)  $default,){
final _that = this;
switch (_that) {
case _TravelTier():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TravelTier value)?  $default,){
final _that = this;
switch (_that) {
case _TravelTier() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String code,  String label,  double multiplier,  int tripsCompleted,  int distinctCities,  TravelTierNext? next)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TravelTier() when $default != null:
return $default(_that.code,_that.label,_that.multiplier,_that.tripsCompleted,_that.distinctCities,_that.next);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String code,  String label,  double multiplier,  int tripsCompleted,  int distinctCities,  TravelTierNext? next)  $default,) {final _that = this;
switch (_that) {
case _TravelTier():
return $default(_that.code,_that.label,_that.multiplier,_that.tripsCompleted,_that.distinctCities,_that.next);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String code,  String label,  double multiplier,  int tripsCompleted,  int distinctCities,  TravelTierNext? next)?  $default,) {final _that = this;
switch (_that) {
case _TravelTier() when $default != null:
return $default(_that.code,_that.label,_that.multiplier,_that.tripsCompleted,_that.distinctCities,_that.next);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TravelTier extends TravelTier {
  const _TravelTier({required this.code, required this.label, this.multiplier = 1.0, this.tripsCompleted = 0, this.distinctCities = 0, this.next}): super._();
  factory _TravelTier.fromJson(Map<String, dynamic> json) => _$TravelTierFromJson(json);

@override final  String code;
@override final  String label;
@override@JsonKey() final  double multiplier;
@override@JsonKey() final  int tripsCompleted;
@override@JsonKey() final  int distinctCities;
@override final  TravelTierNext? next;

/// Create a copy of TravelTier
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TravelTierCopyWith<_TravelTier> get copyWith => __$TravelTierCopyWithImpl<_TravelTier>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TravelTierToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TravelTier&&(identical(other.code, code) || other.code == code)&&(identical(other.label, label) || other.label == label)&&(identical(other.multiplier, multiplier) || other.multiplier == multiplier)&&(identical(other.tripsCompleted, tripsCompleted) || other.tripsCompleted == tripsCompleted)&&(identical(other.distinctCities, distinctCities) || other.distinctCities == distinctCities)&&(identical(other.next, next) || other.next == next));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,code,label,multiplier,tripsCompleted,distinctCities,next);
}

@override
String toString() {
    return 'TravelTier(code: $code, label: $label, multiplier: $multiplier, tripsCompleted: $tripsCompleted, distinctCities: $distinctCities, next: $next)';
}


}

/// @nodoc
abstract mixin class _$TravelTierCopyWith<$Res> implements $TravelTierCopyWith<$Res> {
  factory _$TravelTierCopyWith(_TravelTier value, $Res Function(_TravelTier) _then) = __$TravelTierCopyWithImpl;
@override @useResult
$Res call({
 String code, String label, double multiplier, int tripsCompleted, int distinctCities, TravelTierNext? next
});


@override $TravelTierNextCopyWith<$Res>? get next;

}
/// @nodoc
class __$TravelTierCopyWithImpl<$Res>
    implements _$TravelTierCopyWith<$Res> {
  __$TravelTierCopyWithImpl(this._self, this._then);

  final _TravelTier _self;
  final $Res Function(_TravelTier) _then;

/// Create a copy of TravelTier
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? label = null,Object? multiplier = null,Object? tripsCompleted = null,Object? distinctCities = null,Object? next = freezed,}) {
  return _then(_TravelTier(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,multiplier: null == multiplier ? _self.multiplier : multiplier // ignore: cast_nullable_to_non_nullable
as double,tripsCompleted: null == tripsCompleted ? _self.tripsCompleted : tripsCompleted // ignore: cast_nullable_to_non_nullable
as int,distinctCities: null == distinctCities ? _self.distinctCities : distinctCities // ignore: cast_nullable_to_non_nullable
as int,next: freezed == next ? _self.next : next // ignore: cast_nullable_to_non_nullable
as TravelTierNext?,
  ));
}

/// Create a copy of TravelTier
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TravelTierNextCopyWith<$Res>? get next {
    if (_self.next == null) {
    return null;
  }

  return $TravelTierNextCopyWith<$Res>(_self.next!, (value) {
    return _then(_self.copyWith(next: value));
  });
}
}


/// @nodoc
mixin _$TravelTierNext {

 String get code; double get multiplier; int get tripsRemaining; int get citiesRemaining;
/// Create a copy of TravelTierNext
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TravelTierNextCopyWith<TravelTierNext> get copyWith => _$TravelTierNextCopyWithImpl<TravelTierNext>(this as TravelTierNext, _$identity);

  /// Serializes this TravelTierNext to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TravelTierNext;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TravelTierNext&&(identical(other.code, _this.code) || other.code == _this.code)&&(identical(other.multiplier, _this.multiplier) || other.multiplier == _this.multiplier)&&(identical(other.tripsRemaining, _this.tripsRemaining) || other.tripsRemaining == _this.tripsRemaining)&&(identical(other.citiesRemaining, _this.citiesRemaining) || other.citiesRemaining == _this.citiesRemaining));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TravelTierNext;
  return Object.hash(runtimeType,_this.code,_this.multiplier,_this.tripsRemaining,_this.citiesRemaining);
}

@override
String toString() {
  final _this = this as TravelTierNext;
  return 'TravelTierNext(code: ${_this.code}, multiplier: ${_this.multiplier}, tripsRemaining: ${_this.tripsRemaining}, citiesRemaining: ${_this.citiesRemaining})';
}


}

/// @nodoc
abstract mixin class $TravelTierNextCopyWith<$Res>  {
  factory $TravelTierNextCopyWith(TravelTierNext value, $Res Function(TravelTierNext) _then) = _$TravelTierNextCopyWithImpl;
@useResult
$Res call({
 String code, double multiplier, int tripsRemaining, int citiesRemaining
});




}
/// @nodoc
class _$TravelTierNextCopyWithImpl<$Res>
    implements $TravelTierNextCopyWith<$Res> {
  _$TravelTierNextCopyWithImpl(this._self, this._then);

  final TravelTierNext _self;
  final $Res Function(TravelTierNext) _then;

/// Create a copy of TravelTierNext
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? multiplier = null,Object? tripsRemaining = null,Object? citiesRemaining = null,}) {
  return _then(TravelTierNext(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,multiplier: null == multiplier ? _self.multiplier : multiplier // ignore: cast_nullable_to_non_nullable
as double,tripsRemaining: null == tripsRemaining ? _self.tripsRemaining : tripsRemaining // ignore: cast_nullable_to_non_nullable
as int,citiesRemaining: null == citiesRemaining ? _self.citiesRemaining : citiesRemaining // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [TravelTierNext].
extension TravelTierNextPatterns on TravelTierNext {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TravelTierNext value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TravelTierNext() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TravelTierNext value)  $default,){
final _that = this;
switch (_that) {
case _TravelTierNext():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TravelTierNext value)?  $default,){
final _that = this;
switch (_that) {
case _TravelTierNext() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String code,  double multiplier,  int tripsRemaining,  int citiesRemaining)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TravelTierNext() when $default != null:
return $default(_that.code,_that.multiplier,_that.tripsRemaining,_that.citiesRemaining);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String code,  double multiplier,  int tripsRemaining,  int citiesRemaining)  $default,) {final _that = this;
switch (_that) {
case _TravelTierNext():
return $default(_that.code,_that.multiplier,_that.tripsRemaining,_that.citiesRemaining);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String code,  double multiplier,  int tripsRemaining,  int citiesRemaining)?  $default,) {final _that = this;
switch (_that) {
case _TravelTierNext() when $default != null:
return $default(_that.code,_that.multiplier,_that.tripsRemaining,_that.citiesRemaining);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TravelTierNext implements TravelTierNext {
  const _TravelTierNext({required this.code, this.multiplier = 1.0, this.tripsRemaining = 0, this.citiesRemaining = 0});
  factory _TravelTierNext.fromJson(Map<String, dynamic> json) => _$TravelTierNextFromJson(json);

@override final  String code;
@override@JsonKey() final  double multiplier;
@override@JsonKey() final  int tripsRemaining;
@override@JsonKey() final  int citiesRemaining;

/// Create a copy of TravelTierNext
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TravelTierNextCopyWith<_TravelTierNext> get copyWith => __$TravelTierNextCopyWithImpl<_TravelTierNext>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TravelTierNextToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TravelTierNext&&(identical(other.code, code) || other.code == code)&&(identical(other.multiplier, multiplier) || other.multiplier == multiplier)&&(identical(other.tripsRemaining, tripsRemaining) || other.tripsRemaining == tripsRemaining)&&(identical(other.citiesRemaining, citiesRemaining) || other.citiesRemaining == citiesRemaining));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,code,multiplier,tripsRemaining,citiesRemaining);
}

@override
String toString() {
    return 'TravelTierNext(code: $code, multiplier: $multiplier, tripsRemaining: $tripsRemaining, citiesRemaining: $citiesRemaining)';
}


}

/// @nodoc
abstract mixin class _$TravelTierNextCopyWith<$Res> implements $TravelTierNextCopyWith<$Res> {
  factory _$TravelTierNextCopyWith(_TravelTierNext value, $Res Function(_TravelTierNext) _then) = __$TravelTierNextCopyWithImpl;
@override @useResult
$Res call({
 String code, double multiplier, int tripsRemaining, int citiesRemaining
});




}
/// @nodoc
class __$TravelTierNextCopyWithImpl<$Res>
    implements _$TravelTierNextCopyWith<$Res> {
  __$TravelTierNextCopyWithImpl(this._self, this._then);

  final _TravelTierNext _self;
  final $Res Function(_TravelTierNext) _then;

/// Create a copy of TravelTierNext
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? multiplier = null,Object? tripsRemaining = null,Object? citiesRemaining = null,}) {
  return _then(_TravelTierNext(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,multiplier: null == multiplier ? _self.multiplier : multiplier // ignore: cast_nullable_to_non_nullable
as double,tripsRemaining: null == tripsRemaining ? _self.tripsRemaining : tripsRemaining // ignore: cast_nullable_to_non_nullable
as int,citiesRemaining: null == citiesRemaining ? _self.citiesRemaining : citiesRemaining // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$AchievementProgress {

 String get code; String get title; String get rarity; int get current; int get target; bool get unlocked;
/// Create a copy of AchievementProgress
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AchievementProgressCopyWith<AchievementProgress> get copyWith => _$AchievementProgressCopyWithImpl<AchievementProgress>(this as AchievementProgress, _$identity);

  /// Serializes this AchievementProgress to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as AchievementProgress;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AchievementProgress&&(identical(other.code, _this.code) || other.code == _this.code)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.rarity, _this.rarity) || other.rarity == _this.rarity)&&(identical(other.current, _this.current) || other.current == _this.current)&&(identical(other.target, _this.target) || other.target == _this.target)&&(identical(other.unlocked, _this.unlocked) || other.unlocked == _this.unlocked));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as AchievementProgress;
  return Object.hash(runtimeType,_this.code,_this.title,_this.rarity,_this.current,_this.target,_this.unlocked);
}

@override
String toString() {
  final _this = this as AchievementProgress;
  return 'AchievementProgress(code: ${_this.code}, title: ${_this.title}, rarity: ${_this.rarity}, current: ${_this.current}, target: ${_this.target}, unlocked: ${_this.unlocked})';
}


}

/// @nodoc
abstract mixin class $AchievementProgressCopyWith<$Res>  {
  factory $AchievementProgressCopyWith(AchievementProgress value, $Res Function(AchievementProgress) _then) = _$AchievementProgressCopyWithImpl;
@useResult
$Res call({
 String code, String title, String rarity, int current, int target, bool unlocked
});




}
/// @nodoc
class _$AchievementProgressCopyWithImpl<$Res>
    implements $AchievementProgressCopyWith<$Res> {
  _$AchievementProgressCopyWithImpl(this._self, this._then);

  final AchievementProgress _self;
  final $Res Function(AchievementProgress) _then;

/// Create a copy of AchievementProgress
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? title = null,Object? rarity = null,Object? current = null,Object? target = null,Object? unlocked = null,}) {
  return _then(AchievementProgress(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,rarity: null == rarity ? _self.rarity : rarity // ignore: cast_nullable_to_non_nullable
as String,current: null == current ? _self.current : current // ignore: cast_nullable_to_non_nullable
as int,target: null == target ? _self.target : target // ignore: cast_nullable_to_non_nullable
as int,unlocked: null == unlocked ? _self.unlocked : unlocked // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [AchievementProgress].
extension AchievementProgressPatterns on AchievementProgress {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AchievementProgress value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AchievementProgress() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AchievementProgress value)  $default,){
final _that = this;
switch (_that) {
case _AchievementProgress():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AchievementProgress value)?  $default,){
final _that = this;
switch (_that) {
case _AchievementProgress() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String code,  String title,  String rarity,  int current,  int target,  bool unlocked)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AchievementProgress() when $default != null:
return $default(_that.code,_that.title,_that.rarity,_that.current,_that.target,_that.unlocked);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String code,  String title,  String rarity,  int current,  int target,  bool unlocked)  $default,) {final _that = this;
switch (_that) {
case _AchievementProgress():
return $default(_that.code,_that.title,_that.rarity,_that.current,_that.target,_that.unlocked);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String code,  String title,  String rarity,  int current,  int target,  bool unlocked)?  $default,) {final _that = this;
switch (_that) {
case _AchievementProgress() when $default != null:
return $default(_that.code,_that.title,_that.rarity,_that.current,_that.target,_that.unlocked);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AchievementProgress extends AchievementProgress {
  const _AchievementProgress({required this.code, required this.title, this.rarity = 'COMMON', this.current = 0, this.target = 1, this.unlocked = false}): super._();
  factory _AchievementProgress.fromJson(Map<String, dynamic> json) => _$AchievementProgressFromJson(json);

@override final  String code;
@override final  String title;
@override@JsonKey() final  String rarity;
@override@JsonKey() final  int current;
@override@JsonKey() final  int target;
@override@JsonKey() final  bool unlocked;

/// Create a copy of AchievementProgress
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AchievementProgressCopyWith<_AchievementProgress> get copyWith => __$AchievementProgressCopyWithImpl<_AchievementProgress>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AchievementProgressToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AchievementProgress&&(identical(other.code, code) || other.code == code)&&(identical(other.title, title) || other.title == title)&&(identical(other.rarity, rarity) || other.rarity == rarity)&&(identical(other.current, current) || other.current == current)&&(identical(other.target, target) || other.target == target)&&(identical(other.unlocked, unlocked) || other.unlocked == unlocked));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,code,title,rarity,current,target,unlocked);
}

@override
String toString() {
    return 'AchievementProgress(code: $code, title: $title, rarity: $rarity, current: $current, target: $target, unlocked: $unlocked)';
}


}

/// @nodoc
abstract mixin class _$AchievementProgressCopyWith<$Res> implements $AchievementProgressCopyWith<$Res> {
  factory _$AchievementProgressCopyWith(_AchievementProgress value, $Res Function(_AchievementProgress) _then) = __$AchievementProgressCopyWithImpl;
@override @useResult
$Res call({
 String code, String title, String rarity, int current, int target, bool unlocked
});




}
/// @nodoc
class __$AchievementProgressCopyWithImpl<$Res>
    implements _$AchievementProgressCopyWith<$Res> {
  __$AchievementProgressCopyWithImpl(this._self, this._then);

  final _AchievementProgress _self;
  final $Res Function(_AchievementProgress) _then;

/// Create a copy of AchievementProgress
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? title = null,Object? rarity = null,Object? current = null,Object? target = null,Object? unlocked = null,}) {
  return _then(_AchievementProgress(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,rarity: null == rarity ? _self.rarity : rarity // ignore: cast_nullable_to_non_nullable
as String,current: null == current ? _self.current : current // ignore: cast_nullable_to_non_nullable
as int,target: null == target ? _self.target : target // ignore: cast_nullable_to_non_nullable
as int,unlocked: null == unlocked ? _self.unlocked : unlocked // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$AchivementProgressPage {

 TravelTier? get travelTier; List<AchievementProgress> get achievements;
/// Create a copy of AchivementProgressPage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AchivementProgressPageCopyWith<AchivementProgressPage> get copyWith => _$AchivementProgressPageCopyWithImpl<AchivementProgressPage>(this as AchivementProgressPage, _$identity);

  /// Serializes this AchivementProgressPage to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as AchivementProgressPage;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AchivementProgressPage&&(identical(other.travelTier, _this.travelTier) || other.travelTier == _this.travelTier)&&const DeepCollectionEquality().equals(other.achievements, _this.achievements));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as AchivementProgressPage;
  return Object.hash(runtimeType,_this.travelTier,const DeepCollectionEquality().hash(_this.achievements));
}

@override
String toString() {
  final _this = this as AchivementProgressPage;
  return 'AchivementProgressPage(travelTier: ${_this.travelTier}, achievements: ${_this.achievements})';
}


}

/// @nodoc
abstract mixin class $AchivementProgressPageCopyWith<$Res>  {
  factory $AchivementProgressPageCopyWith(AchivementProgressPage value, $Res Function(AchivementProgressPage) _then) = _$AchivementProgressPageCopyWithImpl;
@useResult
$Res call({
 TravelTier? travelTier, List<AchievementProgress> achievements
});


$TravelTierCopyWith<$Res>? get travelTier;

}
/// @nodoc
class _$AchivementProgressPageCopyWithImpl<$Res>
    implements $AchivementProgressPageCopyWith<$Res> {
  _$AchivementProgressPageCopyWithImpl(this._self, this._then);

  final AchivementProgressPage _self;
  final $Res Function(AchivementProgressPage) _then;

/// Create a copy of AchivementProgressPage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? travelTier = freezed,Object? achievements = null,}) {
  return _then(AchivementProgressPage(
travelTier: freezed == travelTier ? _self.travelTier : travelTier // ignore: cast_nullable_to_non_nullable
as TravelTier?,achievements: null == achievements ? _self.achievements : achievements // ignore: cast_nullable_to_non_nullable
as List<AchievementProgress>,
  ));
}
/// Create a copy of AchivementProgressPage
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TravelTierCopyWith<$Res>? get travelTier {
    if (_self.travelTier == null) {
    return null;
  }

  return $TravelTierCopyWith<$Res>(_self.travelTier!, (value) {
    return _then(_self.copyWith(travelTier: value));
  });
}
}


/// Adds pattern-matching-related methods to [AchivementProgressPage].
extension AchivementProgressPagePatterns on AchivementProgressPage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AchivementProgressPage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AchivementProgressPage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AchivementProgressPage value)  $default,){
final _that = this;
switch (_that) {
case _AchivementProgressPage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AchivementProgressPage value)?  $default,){
final _that = this;
switch (_that) {
case _AchivementProgressPage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( TravelTier? travelTier,  List<AchievementProgress> achievements)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AchivementProgressPage() when $default != null:
return $default(_that.travelTier,_that.achievements);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( TravelTier? travelTier,  List<AchievementProgress> achievements)  $default,) {final _that = this;
switch (_that) {
case _AchivementProgressPage():
return $default(_that.travelTier,_that.achievements);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( TravelTier? travelTier,  List<AchievementProgress> achievements)?  $default,) {final _that = this;
switch (_that) {
case _AchivementProgressPage() when $default != null:
return $default(_that.travelTier,_that.achievements);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AchivementProgressPage implements AchivementProgressPage {
  const _AchivementProgressPage({this.travelTier,  List<AchievementProgress> achievements = const <AchievementProgress>[]}): _achievements = achievements;
  factory _AchivementProgressPage.fromJson(Map<String, dynamic> json) => _$AchivementProgressPageFromJson(json);

@override final  TravelTier? travelTier;
 final  List<AchievementProgress> _achievements;
@override@JsonKey() List<AchievementProgress> get achievements {
  if (_achievements is EqualUnmodifiableListView) return _achievements;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_achievements);
}


/// Create a copy of AchivementProgressPage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AchivementProgressPageCopyWith<_AchivementProgressPage> get copyWith => __$AchivementProgressPageCopyWithImpl<_AchivementProgressPage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AchivementProgressPageToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AchivementProgressPage&&(identical(other.travelTier, travelTier) || other.travelTier == travelTier)&&const DeepCollectionEquality().equals(other.achievements, _achievements));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,travelTier,const DeepCollectionEquality().hash(_achievements));
}

@override
String toString() {
    return 'AchivementProgressPage(travelTier: $travelTier, achievements: $achievements)';
}


}

/// @nodoc
abstract mixin class _$AchivementProgressPageCopyWith<$Res> implements $AchivementProgressPageCopyWith<$Res> {
  factory _$AchivementProgressPageCopyWith(_AchivementProgressPage value, $Res Function(_AchivementProgressPage) _then) = __$AchivementProgressPageCopyWithImpl;
@override @useResult
$Res call({
 TravelTier? travelTier, List<AchievementProgress> achievements
});


@override $TravelTierCopyWith<$Res>? get travelTier;

}
/// @nodoc
class __$AchivementProgressPageCopyWithImpl<$Res>
    implements _$AchivementProgressPageCopyWith<$Res> {
  __$AchivementProgressPageCopyWithImpl(this._self, this._then);

  final _AchivementProgressPage _self;
  final $Res Function(_AchivementProgressPage) _then;

/// Create a copy of AchivementProgressPage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? travelTier = freezed,Object? achievements = null,}) {
  return _then(_AchivementProgressPage(
travelTier: freezed == travelTier ? _self.travelTier : travelTier // ignore: cast_nullable_to_non_nullable
as TravelTier?,achievements: null == achievements ? _self._achievements : achievements // ignore: cast_nullable_to_non_nullable
as List<AchievementProgress>,
  ));
}

/// Create a copy of AchivementProgressPage
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TravelTierCopyWith<$Res>? get travelTier {
    if (_self.travelTier == null) {
    return null;
  }

  return $TravelTierCopyWith<$Res>(_self.travelTier!, (value) {
    return _then(_self.copyWith(travelTier: value));
  });
}
}


/// @nodoc
mixin _$AchivementCompletionResult {

 String get tripId; String get tripName; int get pointsAwarded; int get basePoints; int get missionPoints; double get multiplierUsed; int get missionsCompleted; int get totalCheckins; int get totalPlaces; int get completionPercent; String? get tierLabel; String? get nextTierHint; double get nextTierProgress;
/// Create a copy of AchivementCompletionResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AchivementCompletionResultCopyWith<AchivementCompletionResult> get copyWith => _$AchivementCompletionResultCopyWithImpl<AchivementCompletionResult>(this as AchivementCompletionResult, _$identity);

  /// Serializes this AchivementCompletionResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as AchivementCompletionResult;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AchivementCompletionResult&&(identical(other.tripId, _this.tripId) || other.tripId == _this.tripId)&&(identical(other.tripName, _this.tripName) || other.tripName == _this.tripName)&&(identical(other.pointsAwarded, _this.pointsAwarded) || other.pointsAwarded == _this.pointsAwarded)&&(identical(other.basePoints, _this.basePoints) || other.basePoints == _this.basePoints)&&(identical(other.missionPoints, _this.missionPoints) || other.missionPoints == _this.missionPoints)&&(identical(other.multiplierUsed, _this.multiplierUsed) || other.multiplierUsed == _this.multiplierUsed)&&(identical(other.missionsCompleted, _this.missionsCompleted) || other.missionsCompleted == _this.missionsCompleted)&&(identical(other.totalCheckins, _this.totalCheckins) || other.totalCheckins == _this.totalCheckins)&&(identical(other.totalPlaces, _this.totalPlaces) || other.totalPlaces == _this.totalPlaces)&&(identical(other.completionPercent, _this.completionPercent) || other.completionPercent == _this.completionPercent)&&(identical(other.tierLabel, _this.tierLabel) || other.tierLabel == _this.tierLabel)&&(identical(other.nextTierHint, _this.nextTierHint) || other.nextTierHint == _this.nextTierHint)&&(identical(other.nextTierProgress, _this.nextTierProgress) || other.nextTierProgress == _this.nextTierProgress));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as AchivementCompletionResult;
  return Object.hash(runtimeType,_this.tripId,_this.tripName,_this.pointsAwarded,_this.basePoints,_this.missionPoints,_this.multiplierUsed,_this.missionsCompleted,_this.totalCheckins,_this.totalPlaces,_this.completionPercent,_this.tierLabel,_this.nextTierHint,_this.nextTierProgress);
}

@override
String toString() {
  final _this = this as AchivementCompletionResult;
  return 'AchivementCompletionResult(tripId: ${_this.tripId}, tripName: ${_this.tripName}, pointsAwarded: ${_this.pointsAwarded}, basePoints: ${_this.basePoints}, missionPoints: ${_this.missionPoints}, multiplierUsed: ${_this.multiplierUsed}, missionsCompleted: ${_this.missionsCompleted}, totalCheckins: ${_this.totalCheckins}, totalPlaces: ${_this.totalPlaces}, completionPercent: ${_this.completionPercent}, tierLabel: ${_this.tierLabel}, nextTierHint: ${_this.nextTierHint}, nextTierProgress: ${_this.nextTierProgress})';
}


}

/// @nodoc
abstract mixin class $AchivementCompletionResultCopyWith<$Res>  {
  factory $AchivementCompletionResultCopyWith(AchivementCompletionResult value, $Res Function(AchivementCompletionResult) _then) = _$AchivementCompletionResultCopyWithImpl;
@useResult
$Res call({
 String tripId, String tripName, int pointsAwarded, int basePoints, int missionPoints, double multiplierUsed, int missionsCompleted, int totalCheckins, int totalPlaces, int completionPercent, String? tierLabel, String? nextTierHint, double nextTierProgress
});




}
/// @nodoc
class _$AchivementCompletionResultCopyWithImpl<$Res>
    implements $AchivementCompletionResultCopyWith<$Res> {
  _$AchivementCompletionResultCopyWithImpl(this._self, this._then);

  final AchivementCompletionResult _self;
  final $Res Function(AchivementCompletionResult) _then;

/// Create a copy of AchivementCompletionResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? tripId = null,Object? tripName = null,Object? pointsAwarded = null,Object? basePoints = null,Object? missionPoints = null,Object? multiplierUsed = null,Object? missionsCompleted = null,Object? totalCheckins = null,Object? totalPlaces = null,Object? completionPercent = null,Object? tierLabel = freezed,Object? nextTierHint = freezed,Object? nextTierProgress = null,}) {
  return _then(AchivementCompletionResult(
tripId: null == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String,tripName: null == tripName ? _self.tripName : tripName // ignore: cast_nullable_to_non_nullable
as String,pointsAwarded: null == pointsAwarded ? _self.pointsAwarded : pointsAwarded // ignore: cast_nullable_to_non_nullable
as int,basePoints: null == basePoints ? _self.basePoints : basePoints // ignore: cast_nullable_to_non_nullable
as int,missionPoints: null == missionPoints ? _self.missionPoints : missionPoints // ignore: cast_nullable_to_non_nullable
as int,multiplierUsed: null == multiplierUsed ? _self.multiplierUsed : multiplierUsed // ignore: cast_nullable_to_non_nullable
as double,missionsCompleted: null == missionsCompleted ? _self.missionsCompleted : missionsCompleted // ignore: cast_nullable_to_non_nullable
as int,totalCheckins: null == totalCheckins ? _self.totalCheckins : totalCheckins // ignore: cast_nullable_to_non_nullable
as int,totalPlaces: null == totalPlaces ? _self.totalPlaces : totalPlaces // ignore: cast_nullable_to_non_nullable
as int,completionPercent: null == completionPercent ? _self.completionPercent : completionPercent // ignore: cast_nullable_to_non_nullable
as int,tierLabel: freezed == tierLabel ? _self.tierLabel : tierLabel // ignore: cast_nullable_to_non_nullable
as String?,nextTierHint: freezed == nextTierHint ? _self.nextTierHint : nextTierHint // ignore: cast_nullable_to_non_nullable
as String?,nextTierProgress: null == nextTierProgress ? _self.nextTierProgress : nextTierProgress // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [AchivementCompletionResult].
extension AchivementCompletionResultPatterns on AchivementCompletionResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AchivementCompletionResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AchivementCompletionResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AchivementCompletionResult value)  $default,){
final _that = this;
switch (_that) {
case _AchivementCompletionResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AchivementCompletionResult value)?  $default,){
final _that = this;
switch (_that) {
case _AchivementCompletionResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String tripId,  String tripName,  int pointsAwarded,  int basePoints,  int missionPoints,  double multiplierUsed,  int missionsCompleted,  int totalCheckins,  int totalPlaces,  int completionPercent,  String? tierLabel,  String? nextTierHint,  double nextTierProgress)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AchivementCompletionResult() when $default != null:
return $default(_that.tripId,_that.tripName,_that.pointsAwarded,_that.basePoints,_that.missionPoints,_that.multiplierUsed,_that.missionsCompleted,_that.totalCheckins,_that.totalPlaces,_that.completionPercent,_that.tierLabel,_that.nextTierHint,_that.nextTierProgress);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String tripId,  String tripName,  int pointsAwarded,  int basePoints,  int missionPoints,  double multiplierUsed,  int missionsCompleted,  int totalCheckins,  int totalPlaces,  int completionPercent,  String? tierLabel,  String? nextTierHint,  double nextTierProgress)  $default,) {final _that = this;
switch (_that) {
case _AchivementCompletionResult():
return $default(_that.tripId,_that.tripName,_that.pointsAwarded,_that.basePoints,_that.missionPoints,_that.multiplierUsed,_that.missionsCompleted,_that.totalCheckins,_that.totalPlaces,_that.completionPercent,_that.tierLabel,_that.nextTierHint,_that.nextTierProgress);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String tripId,  String tripName,  int pointsAwarded,  int basePoints,  int missionPoints,  double multiplierUsed,  int missionsCompleted,  int totalCheckins,  int totalPlaces,  int completionPercent,  String? tierLabel,  String? nextTierHint,  double nextTierProgress)?  $default,) {final _that = this;
switch (_that) {
case _AchivementCompletionResult() when $default != null:
return $default(_that.tripId,_that.tripName,_that.pointsAwarded,_that.basePoints,_that.missionPoints,_that.multiplierUsed,_that.missionsCompleted,_that.totalCheckins,_that.totalPlaces,_that.completionPercent,_that.tierLabel,_that.nextTierHint,_that.nextTierProgress);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AchivementCompletionResult extends AchivementCompletionResult {
  const _AchivementCompletionResult({required this.tripId, this.tripName = '', this.pointsAwarded = 0, this.basePoints = 0, this.missionPoints = 0, this.multiplierUsed = 1.0, this.missionsCompleted = 0, this.totalCheckins = 0, this.totalPlaces = 0, this.completionPercent = 0, this.tierLabel, this.nextTierHint, this.nextTierProgress = 0.0}): super._();
  factory _AchivementCompletionResult.fromJson(Map<String, dynamic> json) => _$AchivementCompletionResultFromJson(json);

@override final  String tripId;
@override@JsonKey() final  String tripName;
@override@JsonKey() final  int pointsAwarded;
@override@JsonKey() final  int basePoints;
@override@JsonKey() final  int missionPoints;
@override@JsonKey() final  double multiplierUsed;
@override@JsonKey() final  int missionsCompleted;
@override@JsonKey() final  int totalCheckins;
@override@JsonKey() final  int totalPlaces;
@override@JsonKey() final  int completionPercent;
@override final  String? tierLabel;
@override final  String? nextTierHint;
@override@JsonKey() final  double nextTierProgress;

/// Create a copy of AchivementCompletionResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AchivementCompletionResultCopyWith<_AchivementCompletionResult> get copyWith => __$AchivementCompletionResultCopyWithImpl<_AchivementCompletionResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AchivementCompletionResultToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AchivementCompletionResult&&(identical(other.tripId, tripId) || other.tripId == tripId)&&(identical(other.tripName, tripName) || other.tripName == tripName)&&(identical(other.pointsAwarded, pointsAwarded) || other.pointsAwarded == pointsAwarded)&&(identical(other.basePoints, basePoints) || other.basePoints == basePoints)&&(identical(other.missionPoints, missionPoints) || other.missionPoints == missionPoints)&&(identical(other.multiplierUsed, multiplierUsed) || other.multiplierUsed == multiplierUsed)&&(identical(other.missionsCompleted, missionsCompleted) || other.missionsCompleted == missionsCompleted)&&(identical(other.totalCheckins, totalCheckins) || other.totalCheckins == totalCheckins)&&(identical(other.totalPlaces, totalPlaces) || other.totalPlaces == totalPlaces)&&(identical(other.completionPercent, completionPercent) || other.completionPercent == completionPercent)&&(identical(other.tierLabel, tierLabel) || other.tierLabel == tierLabel)&&(identical(other.nextTierHint, nextTierHint) || other.nextTierHint == nextTierHint)&&(identical(other.nextTierProgress, nextTierProgress) || other.nextTierProgress == nextTierProgress));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,tripId,tripName,pointsAwarded,basePoints,missionPoints,multiplierUsed,missionsCompleted,totalCheckins,totalPlaces,completionPercent,tierLabel,nextTierHint,nextTierProgress);
}

@override
String toString() {
    return 'AchivementCompletionResult(tripId: $tripId, tripName: $tripName, pointsAwarded: $pointsAwarded, basePoints: $basePoints, missionPoints: $missionPoints, multiplierUsed: $multiplierUsed, missionsCompleted: $missionsCompleted, totalCheckins: $totalCheckins, totalPlaces: $totalPlaces, completionPercent: $completionPercent, tierLabel: $tierLabel, nextTierHint: $nextTierHint, nextTierProgress: $nextTierProgress)';
}


}

/// @nodoc
abstract mixin class _$AchivementCompletionResultCopyWith<$Res> implements $AchivementCompletionResultCopyWith<$Res> {
  factory _$AchivementCompletionResultCopyWith(_AchivementCompletionResult value, $Res Function(_AchivementCompletionResult) _then) = __$AchivementCompletionResultCopyWithImpl;
@override @useResult
$Res call({
 String tripId, String tripName, int pointsAwarded, int basePoints, int missionPoints, double multiplierUsed, int missionsCompleted, int totalCheckins, int totalPlaces, int completionPercent, String? tierLabel, String? nextTierHint, double nextTierProgress
});




}
/// @nodoc
class __$AchivementCompletionResultCopyWithImpl<$Res>
    implements _$AchivementCompletionResultCopyWith<$Res> {
  __$AchivementCompletionResultCopyWithImpl(this._self, this._then);

  final _AchivementCompletionResult _self;
  final $Res Function(_AchivementCompletionResult) _then;

/// Create a copy of AchivementCompletionResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? tripId = null,Object? tripName = null,Object? pointsAwarded = null,Object? basePoints = null,Object? missionPoints = null,Object? multiplierUsed = null,Object? missionsCompleted = null,Object? totalCheckins = null,Object? totalPlaces = null,Object? completionPercent = null,Object? tierLabel = freezed,Object? nextTierHint = freezed,Object? nextTierProgress = null,}) {
  return _then(_AchivementCompletionResult(
tripId: null == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String,tripName: null == tripName ? _self.tripName : tripName // ignore: cast_nullable_to_non_nullable
as String,pointsAwarded: null == pointsAwarded ? _self.pointsAwarded : pointsAwarded // ignore: cast_nullable_to_non_nullable
as int,basePoints: null == basePoints ? _self.basePoints : basePoints // ignore: cast_nullable_to_non_nullable
as int,missionPoints: null == missionPoints ? _self.missionPoints : missionPoints // ignore: cast_nullable_to_non_nullable
as int,multiplierUsed: null == multiplierUsed ? _self.multiplierUsed : multiplierUsed // ignore: cast_nullable_to_non_nullable
as double,missionsCompleted: null == missionsCompleted ? _self.missionsCompleted : missionsCompleted // ignore: cast_nullable_to_non_nullable
as int,totalCheckins: null == totalCheckins ? _self.totalCheckins : totalCheckins // ignore: cast_nullable_to_non_nullable
as int,totalPlaces: null == totalPlaces ? _self.totalPlaces : totalPlaces // ignore: cast_nullable_to_non_nullable
as int,completionPercent: null == completionPercent ? _self.completionPercent : completionPercent // ignore: cast_nullable_to_non_nullable
as int,tierLabel: freezed == tierLabel ? _self.tierLabel : tierLabel // ignore: cast_nullable_to_non_nullable
as String?,nextTierHint: freezed == nextTierHint ? _self.nextTierHint : nextTierHint // ignore: cast_nullable_to_non_nullable
as String?,nextTierProgress: null == nextTierProgress ? _self.nextTierProgress : nextTierProgress // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
