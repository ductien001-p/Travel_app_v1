// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ranking_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RankingPage {

 String get seasonLabel; String get updatedLabel; String get listRangeLabel; int get questsTotal; RankingPeriod get selectedPeriod; List<RankingPeriodOption> get periods; List<RankingTraveler> get podium; RankingMeCard? get me; List<RankingTraveler> get entries; List<RankingQuest> get quests;
/// Create a copy of RankingPage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RankingPageCopyWith<RankingPage> get copyWith => _$RankingPageCopyWithImpl<RankingPage>(this as RankingPage, _$identity);

  /// Serializes this RankingPage to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as RankingPage;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RankingPage&&(identical(other.seasonLabel, _this.seasonLabel) || other.seasonLabel == _this.seasonLabel)&&(identical(other.updatedLabel, _this.updatedLabel) || other.updatedLabel == _this.updatedLabel)&&(identical(other.listRangeLabel, _this.listRangeLabel) || other.listRangeLabel == _this.listRangeLabel)&&(identical(other.questsTotal, _this.questsTotal) || other.questsTotal == _this.questsTotal)&&(identical(other.selectedPeriod, _this.selectedPeriod) || other.selectedPeriod == _this.selectedPeriod)&&const DeepCollectionEquality().equals(other.periods, _this.periods)&&const DeepCollectionEquality().equals(other.podium, _this.podium)&&(identical(other.me, _this.me) || other.me == _this.me)&&const DeepCollectionEquality().equals(other.entries, _this.entries)&&const DeepCollectionEquality().equals(other.quests, _this.quests));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as RankingPage;
  return Object.hash(runtimeType,_this.seasonLabel,_this.updatedLabel,_this.listRangeLabel,_this.questsTotal,_this.selectedPeriod,const DeepCollectionEquality().hash(_this.periods),const DeepCollectionEquality().hash(_this.podium),_this.me,const DeepCollectionEquality().hash(_this.entries),const DeepCollectionEquality().hash(_this.quests));
}

@override
String toString() {
  final _this = this as RankingPage;
  return 'RankingPage(seasonLabel: ${_this.seasonLabel}, updatedLabel: ${_this.updatedLabel}, listRangeLabel: ${_this.listRangeLabel}, questsTotal: ${_this.questsTotal}, selectedPeriod: ${_this.selectedPeriod}, periods: ${_this.periods}, podium: ${_this.podium}, me: ${_this.me}, entries: ${_this.entries}, quests: ${_this.quests})';
}


}

/// @nodoc
abstract mixin class $RankingPageCopyWith<$Res>  {
  factory $RankingPageCopyWith(RankingPage value, $Res Function(RankingPage) _then) = _$RankingPageCopyWithImpl;
@useResult
$Res call({
 String seasonLabel, String updatedLabel, String listRangeLabel, int questsTotal, RankingPeriod selectedPeriod, List<RankingPeriodOption> periods, List<RankingTraveler> podium, RankingMeCard? me, List<RankingTraveler> entries, List<RankingQuest> quests
});


$RankingMeCardCopyWith<$Res>? get me;

}
/// @nodoc
class _$RankingPageCopyWithImpl<$Res>
    implements $RankingPageCopyWith<$Res> {
  _$RankingPageCopyWithImpl(this._self, this._then);

  final RankingPage _self;
  final $Res Function(RankingPage) _then;

/// Create a copy of RankingPage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? seasonLabel = null,Object? updatedLabel = null,Object? listRangeLabel = null,Object? questsTotal = null,Object? selectedPeriod = null,Object? periods = null,Object? podium = null,Object? me = freezed,Object? entries = null,Object? quests = null,}) {
  return _then(RankingPage(
seasonLabel: null == seasonLabel ? _self.seasonLabel : seasonLabel // ignore: cast_nullable_to_non_nullable
as String,updatedLabel: null == updatedLabel ? _self.updatedLabel : updatedLabel // ignore: cast_nullable_to_non_nullable
as String,listRangeLabel: null == listRangeLabel ? _self.listRangeLabel : listRangeLabel // ignore: cast_nullable_to_non_nullable
as String,questsTotal: null == questsTotal ? _self.questsTotal : questsTotal // ignore: cast_nullable_to_non_nullable
as int,selectedPeriod: null == selectedPeriod ? _self.selectedPeriod : selectedPeriod // ignore: cast_nullable_to_non_nullable
as RankingPeriod,periods: null == periods ? _self.periods : periods // ignore: cast_nullable_to_non_nullable
as List<RankingPeriodOption>,podium: null == podium ? _self.podium : podium // ignore: cast_nullable_to_non_nullable
as List<RankingTraveler>,me: freezed == me ? _self.me : me // ignore: cast_nullable_to_non_nullable
as RankingMeCard?,entries: null == entries ? _self.entries : entries // ignore: cast_nullable_to_non_nullable
as List<RankingTraveler>,quests: null == quests ? _self.quests : quests // ignore: cast_nullable_to_non_nullable
as List<RankingQuest>,
  ));
}
/// Create a copy of RankingPage
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RankingMeCardCopyWith<$Res>? get me {
    if (_self.me == null) {
    return null;
  }

  return $RankingMeCardCopyWith<$Res>(_self.me!, (value) {
    return _then(_self.copyWith(me: value));
  });
}
}


/// Adds pattern-matching-related methods to [RankingPage].
extension RankingPagePatterns on RankingPage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RankingPage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RankingPage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RankingPage value)  $default,){
final _that = this;
switch (_that) {
case _RankingPage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RankingPage value)?  $default,){
final _that = this;
switch (_that) {
case _RankingPage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String seasonLabel,  String updatedLabel,  String listRangeLabel,  int questsTotal,  RankingPeriod selectedPeriod,  List<RankingPeriodOption> periods,  List<RankingTraveler> podium,  RankingMeCard? me,  List<RankingTraveler> entries,  List<RankingQuest> quests)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RankingPage() when $default != null:
return $default(_that.seasonLabel,_that.updatedLabel,_that.listRangeLabel,_that.questsTotal,_that.selectedPeriod,_that.periods,_that.podium,_that.me,_that.entries,_that.quests);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String seasonLabel,  String updatedLabel,  String listRangeLabel,  int questsTotal,  RankingPeriod selectedPeriod,  List<RankingPeriodOption> periods,  List<RankingTraveler> podium,  RankingMeCard? me,  List<RankingTraveler> entries,  List<RankingQuest> quests)  $default,) {final _that = this;
switch (_that) {
case _RankingPage():
return $default(_that.seasonLabel,_that.updatedLabel,_that.listRangeLabel,_that.questsTotal,_that.selectedPeriod,_that.periods,_that.podium,_that.me,_that.entries,_that.quests);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String seasonLabel,  String updatedLabel,  String listRangeLabel,  int questsTotal,  RankingPeriod selectedPeriod,  List<RankingPeriodOption> periods,  List<RankingTraveler> podium,  RankingMeCard? me,  List<RankingTraveler> entries,  List<RankingQuest> quests)?  $default,) {final _that = this;
switch (_that) {
case _RankingPage() when $default != null:
return $default(_that.seasonLabel,_that.updatedLabel,_that.listRangeLabel,_that.questsTotal,_that.selectedPeriod,_that.periods,_that.podium,_that.me,_that.entries,_that.quests);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RankingPage implements RankingPage {
  const _RankingPage({this.seasonLabel = 'Bảng Xếp Hạng', this.updatedLabel = 'Cập nhật vừa xong', this.listRangeLabel = 'Hiển thị Top 4 - 10', this.questsTotal = 0, this.selectedPeriod = RankingPeriod.season,  List<RankingPeriodOption> periods = const <RankingPeriodOption>[],  List<RankingTraveler> podium = const <RankingTraveler>[], this.me,  List<RankingTraveler> entries = const <RankingTraveler>[],  List<RankingQuest> quests = const <RankingQuest>[]}): _periods = periods,_podium = podium,_entries = entries,_quests = quests;
  factory _RankingPage.fromJson(Map<String, dynamic> json) => _$RankingPageFromJson(json);

@override@JsonKey() final  String seasonLabel;
@override@JsonKey() final  String updatedLabel;
@override@JsonKey() final  String listRangeLabel;
@override@JsonKey() final  int questsTotal;
@override@JsonKey() final  RankingPeriod selectedPeriod;
 final  List<RankingPeriodOption> _periods;
@override@JsonKey() List<RankingPeriodOption> get periods {
  if (_periods is EqualUnmodifiableListView) return _periods;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_periods);
}

 final  List<RankingTraveler> _podium;
@override@JsonKey() List<RankingTraveler> get podium {
  if (_podium is EqualUnmodifiableListView) return _podium;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_podium);
}

@override final  RankingMeCard? me;
 final  List<RankingTraveler> _entries;
@override@JsonKey() List<RankingTraveler> get entries {
  if (_entries is EqualUnmodifiableListView) return _entries;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_entries);
}

 final  List<RankingQuest> _quests;
@override@JsonKey() List<RankingQuest> get quests {
  if (_quests is EqualUnmodifiableListView) return _quests;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_quests);
}


/// Create a copy of RankingPage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RankingPageCopyWith<_RankingPage> get copyWith => __$RankingPageCopyWithImpl<_RankingPage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RankingPageToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _RankingPage&&(identical(other.seasonLabel, seasonLabel) || other.seasonLabel == seasonLabel)&&(identical(other.updatedLabel, updatedLabel) || other.updatedLabel == updatedLabel)&&(identical(other.listRangeLabel, listRangeLabel) || other.listRangeLabel == listRangeLabel)&&(identical(other.questsTotal, questsTotal) || other.questsTotal == questsTotal)&&(identical(other.selectedPeriod, selectedPeriod) || other.selectedPeriod == selectedPeriod)&&const DeepCollectionEquality().equals(other.periods, _periods)&&const DeepCollectionEquality().equals(other.podium, _podium)&&(identical(other.me, me) || other.me == me)&&const DeepCollectionEquality().equals(other.entries, _entries)&&const DeepCollectionEquality().equals(other.quests, _quests));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,seasonLabel,updatedLabel,listRangeLabel,questsTotal,selectedPeriod,const DeepCollectionEquality().hash(_periods),const DeepCollectionEquality().hash(_podium),me,const DeepCollectionEquality().hash(_entries),const DeepCollectionEquality().hash(_quests));
}

@override
String toString() {
    return 'RankingPage(seasonLabel: $seasonLabel, updatedLabel: $updatedLabel, listRangeLabel: $listRangeLabel, questsTotal: $questsTotal, selectedPeriod: $selectedPeriod, periods: $periods, podium: $podium, me: $me, entries: $entries, quests: $quests)';
}


}

/// @nodoc
abstract mixin class _$RankingPageCopyWith<$Res> implements $RankingPageCopyWith<$Res> {
  factory _$RankingPageCopyWith(_RankingPage value, $Res Function(_RankingPage) _then) = __$RankingPageCopyWithImpl;
@override @useResult
$Res call({
 String seasonLabel, String updatedLabel, String listRangeLabel, int questsTotal, RankingPeriod selectedPeriod, List<RankingPeriodOption> periods, List<RankingTraveler> podium, RankingMeCard? me, List<RankingTraveler> entries, List<RankingQuest> quests
});


@override $RankingMeCardCopyWith<$Res>? get me;

}
/// @nodoc
class __$RankingPageCopyWithImpl<$Res>
    implements _$RankingPageCopyWith<$Res> {
  __$RankingPageCopyWithImpl(this._self, this._then);

  final _RankingPage _self;
  final $Res Function(_RankingPage) _then;

/// Create a copy of RankingPage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? seasonLabel = null,Object? updatedLabel = null,Object? listRangeLabel = null,Object? questsTotal = null,Object? selectedPeriod = null,Object? periods = null,Object? podium = null,Object? me = freezed,Object? entries = null,Object? quests = null,}) {
  return _then(_RankingPage(
seasonLabel: null == seasonLabel ? _self.seasonLabel : seasonLabel // ignore: cast_nullable_to_non_nullable
as String,updatedLabel: null == updatedLabel ? _self.updatedLabel : updatedLabel // ignore: cast_nullable_to_non_nullable
as String,listRangeLabel: null == listRangeLabel ? _self.listRangeLabel : listRangeLabel // ignore: cast_nullable_to_non_nullable
as String,questsTotal: null == questsTotal ? _self.questsTotal : questsTotal // ignore: cast_nullable_to_non_nullable
as int,selectedPeriod: null == selectedPeriod ? _self.selectedPeriod : selectedPeriod // ignore: cast_nullable_to_non_nullable
as RankingPeriod,periods: null == periods ? _self._periods : periods // ignore: cast_nullable_to_non_nullable
as List<RankingPeriodOption>,podium: null == podium ? _self._podium : podium // ignore: cast_nullable_to_non_nullable
as List<RankingTraveler>,me: freezed == me ? _self.me : me // ignore: cast_nullable_to_non_nullable
as RankingMeCard?,entries: null == entries ? _self._entries : entries // ignore: cast_nullable_to_non_nullable
as List<RankingTraveler>,quests: null == quests ? _self._quests : quests // ignore: cast_nullable_to_non_nullable
as List<RankingQuest>,
  ));
}

/// Create a copy of RankingPage
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RankingMeCardCopyWith<$Res>? get me {
    if (_self.me == null) {
    return null;
  }

  return $RankingMeCardCopyWith<$Res>(_self.me!, (value) {
    return _then(_self.copyWith(me: value));
  });
}
}


/// @nodoc
mixin _$RankingPeriodOption {

 RankingPeriod get id; String get label;
/// Create a copy of RankingPeriodOption
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RankingPeriodOptionCopyWith<RankingPeriodOption> get copyWith => _$RankingPeriodOptionCopyWithImpl<RankingPeriodOption>(this as RankingPeriodOption, _$identity);

  /// Serializes this RankingPeriodOption to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as RankingPeriodOption;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RankingPeriodOption&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.label, _this.label) || other.label == _this.label));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as RankingPeriodOption;
  return Object.hash(runtimeType,_this.id,_this.label);
}

@override
String toString() {
  final _this = this as RankingPeriodOption;
  return 'RankingPeriodOption(id: ${_this.id}, label: ${_this.label})';
}


}

/// @nodoc
abstract mixin class $RankingPeriodOptionCopyWith<$Res>  {
  factory $RankingPeriodOptionCopyWith(RankingPeriodOption value, $Res Function(RankingPeriodOption) _then) = _$RankingPeriodOptionCopyWithImpl;
@useResult
$Res call({
 RankingPeriod id, String label
});




}
/// @nodoc
class _$RankingPeriodOptionCopyWithImpl<$Res>
    implements $RankingPeriodOptionCopyWith<$Res> {
  _$RankingPeriodOptionCopyWithImpl(this._self, this._then);

  final RankingPeriodOption _self;
  final $Res Function(RankingPeriodOption) _then;

/// Create a copy of RankingPeriodOption
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? label = null,}) {
  return _then(RankingPeriodOption(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as RankingPeriod,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [RankingPeriodOption].
extension RankingPeriodOptionPatterns on RankingPeriodOption {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RankingPeriodOption value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RankingPeriodOption() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RankingPeriodOption value)  $default,){
final _that = this;
switch (_that) {
case _RankingPeriodOption():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RankingPeriodOption value)?  $default,){
final _that = this;
switch (_that) {
case _RankingPeriodOption() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( RankingPeriod id,  String label)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RankingPeriodOption() when $default != null:
return $default(_that.id,_that.label);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( RankingPeriod id,  String label)  $default,) {final _that = this;
switch (_that) {
case _RankingPeriodOption():
return $default(_that.id,_that.label);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( RankingPeriod id,  String label)?  $default,) {final _that = this;
switch (_that) {
case _RankingPeriodOption() when $default != null:
return $default(_that.id,_that.label);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RankingPeriodOption implements RankingPeriodOption {
  const _RankingPeriodOption({required this.id, required this.label});
  factory _RankingPeriodOption.fromJson(Map<String, dynamic> json) => _$RankingPeriodOptionFromJson(json);

@override final  RankingPeriod id;
@override final  String label;

/// Create a copy of RankingPeriodOption
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RankingPeriodOptionCopyWith<_RankingPeriodOption> get copyWith => __$RankingPeriodOptionCopyWithImpl<_RankingPeriodOption>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RankingPeriodOptionToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _RankingPeriodOption&&(identical(other.id, id) || other.id == id)&&(identical(other.label, label) || other.label == label));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,label);
}

@override
String toString() {
    return 'RankingPeriodOption(id: $id, label: $label)';
}


}

/// @nodoc
abstract mixin class _$RankingPeriodOptionCopyWith<$Res> implements $RankingPeriodOptionCopyWith<$Res> {
  factory _$RankingPeriodOptionCopyWith(_RankingPeriodOption value, $Res Function(_RankingPeriodOption) _then) = __$RankingPeriodOptionCopyWithImpl;
@override @useResult
$Res call({
 RankingPeriod id, String label
});




}
/// @nodoc
class __$RankingPeriodOptionCopyWithImpl<$Res>
    implements _$RankingPeriodOptionCopyWith<$Res> {
  __$RankingPeriodOptionCopyWithImpl(this._self, this._then);

  final _RankingPeriodOption _self;
  final $Res Function(_RankingPeriodOption) _then;

/// Create a copy of RankingPeriodOption
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? label = null,}) {
  return _then(_RankingPeriodOption(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as RankingPeriod,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$RankingTraveler {

 String get userId; int get rank; String get displayName; String get username; String? get avatarUrl; String? get badgeLabel; String? get badgeIcon; int get points; int get tripsCompleted; String? get tier; bool get verified; bool get highlight;
/// Create a copy of RankingTraveler
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RankingTravelerCopyWith<RankingTraveler> get copyWith => _$RankingTravelerCopyWithImpl<RankingTraveler>(this as RankingTraveler, _$identity);

  /// Serializes this RankingTraveler to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as RankingTraveler;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RankingTraveler&&(identical(other.userId, _this.userId) || other.userId == _this.userId)&&(identical(other.rank, _this.rank) || other.rank == _this.rank)&&(identical(other.displayName, _this.displayName) || other.displayName == _this.displayName)&&(identical(other.username, _this.username) || other.username == _this.username)&&(identical(other.avatarUrl, _this.avatarUrl) || other.avatarUrl == _this.avatarUrl)&&(identical(other.badgeLabel, _this.badgeLabel) || other.badgeLabel == _this.badgeLabel)&&(identical(other.badgeIcon, _this.badgeIcon) || other.badgeIcon == _this.badgeIcon)&&(identical(other.points, _this.points) || other.points == _this.points)&&(identical(other.tripsCompleted, _this.tripsCompleted) || other.tripsCompleted == _this.tripsCompleted)&&(identical(other.tier, _this.tier) || other.tier == _this.tier)&&(identical(other.verified, _this.verified) || other.verified == _this.verified)&&(identical(other.highlight, _this.highlight) || other.highlight == _this.highlight));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as RankingTraveler;
  return Object.hash(runtimeType,_this.userId,_this.rank,_this.displayName,_this.username,_this.avatarUrl,_this.badgeLabel,_this.badgeIcon,_this.points,_this.tripsCompleted,_this.tier,_this.verified,_this.highlight);
}

@override
String toString() {
  final _this = this as RankingTraveler;
  return 'RankingTraveler(userId: ${_this.userId}, rank: ${_this.rank}, displayName: ${_this.displayName}, username: ${_this.username}, avatarUrl: ${_this.avatarUrl}, badgeLabel: ${_this.badgeLabel}, badgeIcon: ${_this.badgeIcon}, points: ${_this.points}, tripsCompleted: ${_this.tripsCompleted}, tier: ${_this.tier}, verified: ${_this.verified}, highlight: ${_this.highlight})';
}


}

/// @nodoc
abstract mixin class $RankingTravelerCopyWith<$Res>  {
  factory $RankingTravelerCopyWith(RankingTraveler value, $Res Function(RankingTraveler) _then) = _$RankingTravelerCopyWithImpl;
@useResult
$Res call({
 String userId, int rank, String displayName, String username, String? avatarUrl, String? badgeLabel, String? badgeIcon, int points, int tripsCompleted, String? tier, bool verified, bool highlight
});




}
/// @nodoc
class _$RankingTravelerCopyWithImpl<$Res>
    implements $RankingTravelerCopyWith<$Res> {
  _$RankingTravelerCopyWithImpl(this._self, this._then);

  final RankingTraveler _self;
  final $Res Function(RankingTraveler) _then;

/// Create a copy of RankingTraveler
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? rank = null,Object? displayName = null,Object? username = null,Object? avatarUrl = freezed,Object? badgeLabel = freezed,Object? badgeIcon = freezed,Object? points = null,Object? tripsCompleted = null,Object? tier = freezed,Object? verified = null,Object? highlight = null,}) {
  return _then(RankingTraveler(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,rank: null == rank ? _self.rank : rank // ignore: cast_nullable_to_non_nullable
as int,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,badgeLabel: freezed == badgeLabel ? _self.badgeLabel : badgeLabel // ignore: cast_nullable_to_non_nullable
as String?,badgeIcon: freezed == badgeIcon ? _self.badgeIcon : badgeIcon // ignore: cast_nullable_to_non_nullable
as String?,points: null == points ? _self.points : points // ignore: cast_nullable_to_non_nullable
as int,tripsCompleted: null == tripsCompleted ? _self.tripsCompleted : tripsCompleted // ignore: cast_nullable_to_non_nullable
as int,tier: freezed == tier ? _self.tier : tier // ignore: cast_nullable_to_non_nullable
as String?,verified: null == verified ? _self.verified : verified // ignore: cast_nullable_to_non_nullable
as bool,highlight: null == highlight ? _self.highlight : highlight // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [RankingTraveler].
extension RankingTravelerPatterns on RankingTraveler {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RankingTraveler value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RankingTraveler() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RankingTraveler value)  $default,){
final _that = this;
switch (_that) {
case _RankingTraveler():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RankingTraveler value)?  $default,){
final _that = this;
switch (_that) {
case _RankingTraveler() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String userId,  int rank,  String displayName,  String username,  String? avatarUrl,  String? badgeLabel,  String? badgeIcon,  int points,  int tripsCompleted,  String? tier,  bool verified,  bool highlight)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RankingTraveler() when $default != null:
return $default(_that.userId,_that.rank,_that.displayName,_that.username,_that.avatarUrl,_that.badgeLabel,_that.badgeIcon,_that.points,_that.tripsCompleted,_that.tier,_that.verified,_that.highlight);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String userId,  int rank,  String displayName,  String username,  String? avatarUrl,  String? badgeLabel,  String? badgeIcon,  int points,  int tripsCompleted,  String? tier,  bool verified,  bool highlight)  $default,) {final _that = this;
switch (_that) {
case _RankingTraveler():
return $default(_that.userId,_that.rank,_that.displayName,_that.username,_that.avatarUrl,_that.badgeLabel,_that.badgeIcon,_that.points,_that.tripsCompleted,_that.tier,_that.verified,_that.highlight);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String userId,  int rank,  String displayName,  String username,  String? avatarUrl,  String? badgeLabel,  String? badgeIcon,  int points,  int tripsCompleted,  String? tier,  bool verified,  bool highlight)?  $default,) {final _that = this;
switch (_that) {
case _RankingTraveler() when $default != null:
return $default(_that.userId,_that.rank,_that.displayName,_that.username,_that.avatarUrl,_that.badgeLabel,_that.badgeIcon,_that.points,_that.tripsCompleted,_that.tier,_that.verified,_that.highlight);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RankingTraveler implements RankingTraveler {
  const _RankingTraveler({required this.userId, required this.rank, required this.displayName, required this.username, this.avatarUrl, this.badgeLabel, this.badgeIcon, this.points = 0, this.tripsCompleted = 0, this.tier, this.verified = false, this.highlight = false});
  factory _RankingTraveler.fromJson(Map<String, dynamic> json) => _$RankingTravelerFromJson(json);

@override final  String userId;
@override final  int rank;
@override final  String displayName;
@override final  String username;
@override final  String? avatarUrl;
@override final  String? badgeLabel;
@override final  String? badgeIcon;
@override@JsonKey() final  int points;
@override@JsonKey() final  int tripsCompleted;
@override final  String? tier;
@override@JsonKey() final  bool verified;
@override@JsonKey() final  bool highlight;

/// Create a copy of RankingTraveler
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RankingTravelerCopyWith<_RankingTraveler> get copyWith => __$RankingTravelerCopyWithImpl<_RankingTraveler>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RankingTravelerToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _RankingTraveler&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.rank, rank) || other.rank == rank)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.username, username) || other.username == username)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.badgeLabel, badgeLabel) || other.badgeLabel == badgeLabel)&&(identical(other.badgeIcon, badgeIcon) || other.badgeIcon == badgeIcon)&&(identical(other.points, points) || other.points == points)&&(identical(other.tripsCompleted, tripsCompleted) || other.tripsCompleted == tripsCompleted)&&(identical(other.tier, tier) || other.tier == tier)&&(identical(other.verified, verified) || other.verified == verified)&&(identical(other.highlight, highlight) || other.highlight == highlight));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,userId,rank,displayName,username,avatarUrl,badgeLabel,badgeIcon,points,tripsCompleted,tier,verified,highlight);
}

@override
String toString() {
    return 'RankingTraveler(userId: $userId, rank: $rank, displayName: $displayName, username: $username, avatarUrl: $avatarUrl, badgeLabel: $badgeLabel, badgeIcon: $badgeIcon, points: $points, tripsCompleted: $tripsCompleted, tier: $tier, verified: $verified, highlight: $highlight)';
}


}

/// @nodoc
abstract mixin class _$RankingTravelerCopyWith<$Res> implements $RankingTravelerCopyWith<$Res> {
  factory _$RankingTravelerCopyWith(_RankingTraveler value, $Res Function(_RankingTraveler) _then) = __$RankingTravelerCopyWithImpl;
@override @useResult
$Res call({
 String userId, int rank, String displayName, String username, String? avatarUrl, String? badgeLabel, String? badgeIcon, int points, int tripsCompleted, String? tier, bool verified, bool highlight
});




}
/// @nodoc
class __$RankingTravelerCopyWithImpl<$Res>
    implements _$RankingTravelerCopyWith<$Res> {
  __$RankingTravelerCopyWithImpl(this._self, this._then);

  final _RankingTraveler _self;
  final $Res Function(_RankingTraveler) _then;

/// Create a copy of RankingTraveler
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? rank = null,Object? displayName = null,Object? username = null,Object? avatarUrl = freezed,Object? badgeLabel = freezed,Object? badgeIcon = freezed,Object? points = null,Object? tripsCompleted = null,Object? tier = freezed,Object? verified = null,Object? highlight = null,}) {
  return _then(_RankingTraveler(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,rank: null == rank ? _self.rank : rank // ignore: cast_nullable_to_non_nullable
as int,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,badgeLabel: freezed == badgeLabel ? _self.badgeLabel : badgeLabel // ignore: cast_nullable_to_non_nullable
as String?,badgeIcon: freezed == badgeIcon ? _self.badgeIcon : badgeIcon // ignore: cast_nullable_to_non_nullable
as String?,points: null == points ? _self.points : points // ignore: cast_nullable_to_non_nullable
as int,tripsCompleted: null == tripsCompleted ? _self.tripsCompleted : tripsCompleted // ignore: cast_nullable_to_non_nullable
as int,tier: freezed == tier ? _self.tier : tier // ignore: cast_nullable_to_non_nullable
as String?,verified: null == verified ? _self.verified : verified // ignore: cast_nullable_to_non_nullable
as bool,highlight: null == highlight ? _self.highlight : highlight // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$RankingMeCard {

 String get userId; int get rank; String get displayName; String get username; String? get avatarUrl; bool get verified; String get tierLabel; int get rankDelta; int get points; int get tripsCompleted; String get nextTierLabel; int get nextTierPoints; String get progressHint;
/// Create a copy of RankingMeCard
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RankingMeCardCopyWith<RankingMeCard> get copyWith => _$RankingMeCardCopyWithImpl<RankingMeCard>(this as RankingMeCard, _$identity);

  /// Serializes this RankingMeCard to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as RankingMeCard;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RankingMeCard&&(identical(other.userId, _this.userId) || other.userId == _this.userId)&&(identical(other.rank, _this.rank) || other.rank == _this.rank)&&(identical(other.displayName, _this.displayName) || other.displayName == _this.displayName)&&(identical(other.username, _this.username) || other.username == _this.username)&&(identical(other.avatarUrl, _this.avatarUrl) || other.avatarUrl == _this.avatarUrl)&&(identical(other.verified, _this.verified) || other.verified == _this.verified)&&(identical(other.tierLabel, _this.tierLabel) || other.tierLabel == _this.tierLabel)&&(identical(other.rankDelta, _this.rankDelta) || other.rankDelta == _this.rankDelta)&&(identical(other.points, _this.points) || other.points == _this.points)&&(identical(other.tripsCompleted, _this.tripsCompleted) || other.tripsCompleted == _this.tripsCompleted)&&(identical(other.nextTierLabel, _this.nextTierLabel) || other.nextTierLabel == _this.nextTierLabel)&&(identical(other.nextTierPoints, _this.nextTierPoints) || other.nextTierPoints == _this.nextTierPoints)&&(identical(other.progressHint, _this.progressHint) || other.progressHint == _this.progressHint));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as RankingMeCard;
  return Object.hash(runtimeType,_this.userId,_this.rank,_this.displayName,_this.username,_this.avatarUrl,_this.verified,_this.tierLabel,_this.rankDelta,_this.points,_this.tripsCompleted,_this.nextTierLabel,_this.nextTierPoints,_this.progressHint);
}

@override
String toString() {
  final _this = this as RankingMeCard;
  return 'RankingMeCard(userId: ${_this.userId}, rank: ${_this.rank}, displayName: ${_this.displayName}, username: ${_this.username}, avatarUrl: ${_this.avatarUrl}, verified: ${_this.verified}, tierLabel: ${_this.tierLabel}, rankDelta: ${_this.rankDelta}, points: ${_this.points}, tripsCompleted: ${_this.tripsCompleted}, nextTierLabel: ${_this.nextTierLabel}, nextTierPoints: ${_this.nextTierPoints}, progressHint: ${_this.progressHint})';
}


}

/// @nodoc
abstract mixin class $RankingMeCardCopyWith<$Res>  {
  factory $RankingMeCardCopyWith(RankingMeCard value, $Res Function(RankingMeCard) _then) = _$RankingMeCardCopyWithImpl;
@useResult
$Res call({
 String userId, int rank, String displayName, String username, String? avatarUrl, bool verified, String tierLabel, int rankDelta, int points, int tripsCompleted, String nextTierLabel, int nextTierPoints, String progressHint
});




}
/// @nodoc
class _$RankingMeCardCopyWithImpl<$Res>
    implements $RankingMeCardCopyWith<$Res> {
  _$RankingMeCardCopyWithImpl(this._self, this._then);

  final RankingMeCard _self;
  final $Res Function(RankingMeCard) _then;

/// Create a copy of RankingMeCard
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? rank = null,Object? displayName = null,Object? username = null,Object? avatarUrl = freezed,Object? verified = null,Object? tierLabel = null,Object? rankDelta = null,Object? points = null,Object? tripsCompleted = null,Object? nextTierLabel = null,Object? nextTierPoints = null,Object? progressHint = null,}) {
  return _then(RankingMeCard(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,rank: null == rank ? _self.rank : rank // ignore: cast_nullable_to_non_nullable
as int,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,verified: null == verified ? _self.verified : verified // ignore: cast_nullable_to_non_nullable
as bool,tierLabel: null == tierLabel ? _self.tierLabel : tierLabel // ignore: cast_nullable_to_non_nullable
as String,rankDelta: null == rankDelta ? _self.rankDelta : rankDelta // ignore: cast_nullable_to_non_nullable
as int,points: null == points ? _self.points : points // ignore: cast_nullable_to_non_nullable
as int,tripsCompleted: null == tripsCompleted ? _self.tripsCompleted : tripsCompleted // ignore: cast_nullable_to_non_nullable
as int,nextTierLabel: null == nextTierLabel ? _self.nextTierLabel : nextTierLabel // ignore: cast_nullable_to_non_nullable
as String,nextTierPoints: null == nextTierPoints ? _self.nextTierPoints : nextTierPoints // ignore: cast_nullable_to_non_nullable
as int,progressHint: null == progressHint ? _self.progressHint : progressHint // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [RankingMeCard].
extension RankingMeCardPatterns on RankingMeCard {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RankingMeCard value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RankingMeCard() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RankingMeCard value)  $default,){
final _that = this;
switch (_that) {
case _RankingMeCard():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RankingMeCard value)?  $default,){
final _that = this;
switch (_that) {
case _RankingMeCard() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String userId,  int rank,  String displayName,  String username,  String? avatarUrl,  bool verified,  String tierLabel,  int rankDelta,  int points,  int tripsCompleted,  String nextTierLabel,  int nextTierPoints,  String progressHint)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RankingMeCard() when $default != null:
return $default(_that.userId,_that.rank,_that.displayName,_that.username,_that.avatarUrl,_that.verified,_that.tierLabel,_that.rankDelta,_that.points,_that.tripsCompleted,_that.nextTierLabel,_that.nextTierPoints,_that.progressHint);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String userId,  int rank,  String displayName,  String username,  String? avatarUrl,  bool verified,  String tierLabel,  int rankDelta,  int points,  int tripsCompleted,  String nextTierLabel,  int nextTierPoints,  String progressHint)  $default,) {final _that = this;
switch (_that) {
case _RankingMeCard():
return $default(_that.userId,_that.rank,_that.displayName,_that.username,_that.avatarUrl,_that.verified,_that.tierLabel,_that.rankDelta,_that.points,_that.tripsCompleted,_that.nextTierLabel,_that.nextTierPoints,_that.progressHint);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String userId,  int rank,  String displayName,  String username,  String? avatarUrl,  bool verified,  String tierLabel,  int rankDelta,  int points,  int tripsCompleted,  String nextTierLabel,  int nextTierPoints,  String progressHint)?  $default,) {final _that = this;
switch (_that) {
case _RankingMeCard() when $default != null:
return $default(_that.userId,_that.rank,_that.displayName,_that.username,_that.avatarUrl,_that.verified,_that.tierLabel,_that.rankDelta,_that.points,_that.tripsCompleted,_that.nextTierLabel,_that.nextTierPoints,_that.progressHint);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RankingMeCard implements RankingMeCard {
  const _RankingMeCard({required this.userId, required this.rank, required this.displayName, required this.username, this.avatarUrl, this.verified = false, this.tierLabel = 'Gold Tier', this.rankDelta = 0, this.points = 0, this.tripsCompleted = 0, this.nextTierLabel = 'Bạch Kim (Top 10)', this.nextTierPoints = 0, this.progressHint = ''});
  factory _RankingMeCard.fromJson(Map<String, dynamic> json) => _$RankingMeCardFromJson(json);

@override final  String userId;
@override final  int rank;
@override final  String displayName;
@override final  String username;
@override final  String? avatarUrl;
@override@JsonKey() final  bool verified;
@override@JsonKey() final  String tierLabel;
@override@JsonKey() final  int rankDelta;
@override@JsonKey() final  int points;
@override@JsonKey() final  int tripsCompleted;
@override@JsonKey() final  String nextTierLabel;
@override@JsonKey() final  int nextTierPoints;
@override@JsonKey() final  String progressHint;

/// Create a copy of RankingMeCard
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RankingMeCardCopyWith<_RankingMeCard> get copyWith => __$RankingMeCardCopyWithImpl<_RankingMeCard>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RankingMeCardToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _RankingMeCard&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.rank, rank) || other.rank == rank)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.username, username) || other.username == username)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.verified, verified) || other.verified == verified)&&(identical(other.tierLabel, tierLabel) || other.tierLabel == tierLabel)&&(identical(other.rankDelta, rankDelta) || other.rankDelta == rankDelta)&&(identical(other.points, points) || other.points == points)&&(identical(other.tripsCompleted, tripsCompleted) || other.tripsCompleted == tripsCompleted)&&(identical(other.nextTierLabel, nextTierLabel) || other.nextTierLabel == nextTierLabel)&&(identical(other.nextTierPoints, nextTierPoints) || other.nextTierPoints == nextTierPoints)&&(identical(other.progressHint, progressHint) || other.progressHint == progressHint));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,userId,rank,displayName,username,avatarUrl,verified,tierLabel,rankDelta,points,tripsCompleted,nextTierLabel,nextTierPoints,progressHint);
}

@override
String toString() {
    return 'RankingMeCard(userId: $userId, rank: $rank, displayName: $displayName, username: $username, avatarUrl: $avatarUrl, verified: $verified, tierLabel: $tierLabel, rankDelta: $rankDelta, points: $points, tripsCompleted: $tripsCompleted, nextTierLabel: $nextTierLabel, nextTierPoints: $nextTierPoints, progressHint: $progressHint)';
}


}

/// @nodoc
abstract mixin class _$RankingMeCardCopyWith<$Res> implements $RankingMeCardCopyWith<$Res> {
  factory _$RankingMeCardCopyWith(_RankingMeCard value, $Res Function(_RankingMeCard) _then) = __$RankingMeCardCopyWithImpl;
@override @useResult
$Res call({
 String userId, int rank, String displayName, String username, String? avatarUrl, bool verified, String tierLabel, int rankDelta, int points, int tripsCompleted, String nextTierLabel, int nextTierPoints, String progressHint
});




}
/// @nodoc
class __$RankingMeCardCopyWithImpl<$Res>
    implements _$RankingMeCardCopyWith<$Res> {
  __$RankingMeCardCopyWithImpl(this._self, this._then);

  final _RankingMeCard _self;
  final $Res Function(_RankingMeCard) _then;

/// Create a copy of RankingMeCard
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? rank = null,Object? displayName = null,Object? username = null,Object? avatarUrl = freezed,Object? verified = null,Object? tierLabel = null,Object? rankDelta = null,Object? points = null,Object? tripsCompleted = null,Object? nextTierLabel = null,Object? nextTierPoints = null,Object? progressHint = null,}) {
  return _then(_RankingMeCard(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,rank: null == rank ? _self.rank : rank // ignore: cast_nullable_to_non_nullable
as int,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,verified: null == verified ? _self.verified : verified // ignore: cast_nullable_to_non_nullable
as bool,tierLabel: null == tierLabel ? _self.tierLabel : tierLabel // ignore: cast_nullable_to_non_nullable
as String,rankDelta: null == rankDelta ? _self.rankDelta : rankDelta // ignore: cast_nullable_to_non_nullable
as int,points: null == points ? _self.points : points // ignore: cast_nullable_to_non_nullable
as int,tripsCompleted: null == tripsCompleted ? _self.tripsCompleted : tripsCompleted // ignore: cast_nullable_to_non_nullable
as int,nextTierLabel: null == nextTierLabel ? _self.nextTierLabel : nextTierLabel // ignore: cast_nullable_to_non_nullable
as String,nextTierPoints: null == nextTierPoints ? _self.nextTierPoints : nextTierPoints // ignore: cast_nullable_to_non_nullable
as int,progressHint: null == progressHint ? _self.progressHint : progressHint // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$RankingQuest {

 String get id; String get code; String get title; String get subtitle; String get icon; int get pointsReward; RankingQuestAction get action; RankingQuestTone get tone; int? get progressCurrent; int? get progressTarget; bool get claimed; bool get claimable;
/// Create a copy of RankingQuest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RankingQuestCopyWith<RankingQuest> get copyWith => _$RankingQuestCopyWithImpl<RankingQuest>(this as RankingQuest, _$identity);

  /// Serializes this RankingQuest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as RankingQuest;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RankingQuest&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.code, _this.code) || other.code == _this.code)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.subtitle, _this.subtitle) || other.subtitle == _this.subtitle)&&(identical(other.icon, _this.icon) || other.icon == _this.icon)&&(identical(other.pointsReward, _this.pointsReward) || other.pointsReward == _this.pointsReward)&&(identical(other.action, _this.action) || other.action == _this.action)&&(identical(other.tone, _this.tone) || other.tone == _this.tone)&&(identical(other.progressCurrent, _this.progressCurrent) || other.progressCurrent == _this.progressCurrent)&&(identical(other.progressTarget, _this.progressTarget) || other.progressTarget == _this.progressTarget)&&(identical(other.claimed, _this.claimed) || other.claimed == _this.claimed)&&(identical(other.claimable, _this.claimable) || other.claimable == _this.claimable));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as RankingQuest;
  return Object.hash(runtimeType,_this.id,_this.code,_this.title,_this.subtitle,_this.icon,_this.pointsReward,_this.action,_this.tone,_this.progressCurrent,_this.progressTarget,_this.claimed,_this.claimable);
}

@override
String toString() {
  final _this = this as RankingQuest;
  return 'RankingQuest(id: ${_this.id}, code: ${_this.code}, title: ${_this.title}, subtitle: ${_this.subtitle}, icon: ${_this.icon}, pointsReward: ${_this.pointsReward}, action: ${_this.action}, tone: ${_this.tone}, progressCurrent: ${_this.progressCurrent}, progressTarget: ${_this.progressTarget}, claimed: ${_this.claimed}, claimable: ${_this.claimable})';
}


}

/// @nodoc
abstract mixin class $RankingQuestCopyWith<$Res>  {
  factory $RankingQuestCopyWith(RankingQuest value, $Res Function(RankingQuest) _then) = _$RankingQuestCopyWithImpl;
@useResult
$Res call({
 String id, String code, String title, String subtitle, String icon, int pointsReward, RankingQuestAction action, RankingQuestTone tone, int? progressCurrent, int? progressTarget, bool claimed, bool claimable
});




}
/// @nodoc
class _$RankingQuestCopyWithImpl<$Res>
    implements $RankingQuestCopyWith<$Res> {
  _$RankingQuestCopyWithImpl(this._self, this._then);

  final RankingQuest _self;
  final $Res Function(RankingQuest) _then;

/// Create a copy of RankingQuest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? code = null,Object? title = null,Object? subtitle = null,Object? icon = null,Object? pointsReward = null,Object? action = null,Object? tone = null,Object? progressCurrent = freezed,Object? progressTarget = freezed,Object? claimed = null,Object? claimable = null,}) {
  return _then(RankingQuest(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,subtitle: null == subtitle ? _self.subtitle : subtitle // ignore: cast_nullable_to_non_nullable
as String,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String,pointsReward: null == pointsReward ? _self.pointsReward : pointsReward // ignore: cast_nullable_to_non_nullable
as int,action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as RankingQuestAction,tone: null == tone ? _self.tone : tone // ignore: cast_nullable_to_non_nullable
as RankingQuestTone,progressCurrent: freezed == progressCurrent ? _self.progressCurrent : progressCurrent // ignore: cast_nullable_to_non_nullable
as int?,progressTarget: freezed == progressTarget ? _self.progressTarget : progressTarget // ignore: cast_nullable_to_non_nullable
as int?,claimed: null == claimed ? _self.claimed : claimed // ignore: cast_nullable_to_non_nullable
as bool,claimable: null == claimable ? _self.claimable : claimable // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [RankingQuest].
extension RankingQuestPatterns on RankingQuest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RankingQuest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RankingQuest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RankingQuest value)  $default,){
final _that = this;
switch (_that) {
case _RankingQuest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RankingQuest value)?  $default,){
final _that = this;
switch (_that) {
case _RankingQuest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String code,  String title,  String subtitle,  String icon,  int pointsReward,  RankingQuestAction action,  RankingQuestTone tone,  int? progressCurrent,  int? progressTarget,  bool claimed,  bool claimable)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RankingQuest() when $default != null:
return $default(_that.id,_that.code,_that.title,_that.subtitle,_that.icon,_that.pointsReward,_that.action,_that.tone,_that.progressCurrent,_that.progressTarget,_that.claimed,_that.claimable);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String code,  String title,  String subtitle,  String icon,  int pointsReward,  RankingQuestAction action,  RankingQuestTone tone,  int? progressCurrent,  int? progressTarget,  bool claimed,  bool claimable)  $default,) {final _that = this;
switch (_that) {
case _RankingQuest():
return $default(_that.id,_that.code,_that.title,_that.subtitle,_that.icon,_that.pointsReward,_that.action,_that.tone,_that.progressCurrent,_that.progressTarget,_that.claimed,_that.claimable);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String code,  String title,  String subtitle,  String icon,  int pointsReward,  RankingQuestAction action,  RankingQuestTone tone,  int? progressCurrent,  int? progressTarget,  bool claimed,  bool claimable)?  $default,) {final _that = this;
switch (_that) {
case _RankingQuest() when $default != null:
return $default(_that.id,_that.code,_that.title,_that.subtitle,_that.icon,_that.pointsReward,_that.action,_that.tone,_that.progressCurrent,_that.progressTarget,_that.claimed,_that.claimable);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RankingQuest implements RankingQuest {
  const _RankingQuest({required this.id, this.code = '', required this.title, required this.subtitle, required this.icon, this.pointsReward = 0, this.action = RankingQuestAction.start, this.tone = RankingQuestTone.primary, this.progressCurrent, this.progressTarget, this.claimed = false, this.claimable = false});
  factory _RankingQuest.fromJson(Map<String, dynamic> json) => _$RankingQuestFromJson(json);

@override final  String id;
@override@JsonKey() final  String code;
@override final  String title;
@override final  String subtitle;
@override final  String icon;
@override@JsonKey() final  int pointsReward;
@override@JsonKey() final  RankingQuestAction action;
@override@JsonKey() final  RankingQuestTone tone;
@override final  int? progressCurrent;
@override final  int? progressTarget;
@override@JsonKey() final  bool claimed;
@override@JsonKey() final  bool claimable;

/// Create a copy of RankingQuest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RankingQuestCopyWith<_RankingQuest> get copyWith => __$RankingQuestCopyWithImpl<_RankingQuest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RankingQuestToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _RankingQuest&&(identical(other.id, id) || other.id == id)&&(identical(other.code, code) || other.code == code)&&(identical(other.title, title) || other.title == title)&&(identical(other.subtitle, subtitle) || other.subtitle == subtitle)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.pointsReward, pointsReward) || other.pointsReward == pointsReward)&&(identical(other.action, action) || other.action == action)&&(identical(other.tone, tone) || other.tone == tone)&&(identical(other.progressCurrent, progressCurrent) || other.progressCurrent == progressCurrent)&&(identical(other.progressTarget, progressTarget) || other.progressTarget == progressTarget)&&(identical(other.claimed, claimed) || other.claimed == claimed)&&(identical(other.claimable, claimable) || other.claimable == claimable));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,code,title,subtitle,icon,pointsReward,action,tone,progressCurrent,progressTarget,claimed,claimable);
}

@override
String toString() {
    return 'RankingQuest(id: $id, code: $code, title: $title, subtitle: $subtitle, icon: $icon, pointsReward: $pointsReward, action: $action, tone: $tone, progressCurrent: $progressCurrent, progressTarget: $progressTarget, claimed: $claimed, claimable: $claimable)';
}


}

/// @nodoc
abstract mixin class _$RankingQuestCopyWith<$Res> implements $RankingQuestCopyWith<$Res> {
  factory _$RankingQuestCopyWith(_RankingQuest value, $Res Function(_RankingQuest) _then) = __$RankingQuestCopyWithImpl;
@override @useResult
$Res call({
 String id, String code, String title, String subtitle, String icon, int pointsReward, RankingQuestAction action, RankingQuestTone tone, int? progressCurrent, int? progressTarget, bool claimed, bool claimable
});




}
/// @nodoc
class __$RankingQuestCopyWithImpl<$Res>
    implements _$RankingQuestCopyWith<$Res> {
  __$RankingQuestCopyWithImpl(this._self, this._then);

  final _RankingQuest _self;
  final $Res Function(_RankingQuest) _then;

/// Create a copy of RankingQuest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? code = null,Object? title = null,Object? subtitle = null,Object? icon = null,Object? pointsReward = null,Object? action = null,Object? tone = null,Object? progressCurrent = freezed,Object? progressTarget = freezed,Object? claimed = null,Object? claimable = null,}) {
  return _then(_RankingQuest(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,subtitle: null == subtitle ? _self.subtitle : subtitle // ignore: cast_nullable_to_non_nullable
as String,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String,pointsReward: null == pointsReward ? _self.pointsReward : pointsReward // ignore: cast_nullable_to_non_nullable
as int,action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as RankingQuestAction,tone: null == tone ? _self.tone : tone // ignore: cast_nullable_to_non_nullable
as RankingQuestTone,progressCurrent: freezed == progressCurrent ? _self.progressCurrent : progressCurrent // ignore: cast_nullable_to_non_nullable
as int?,progressTarget: freezed == progressTarget ? _self.progressTarget : progressTarget // ignore: cast_nullable_to_non_nullable
as int?,claimed: null == claimed ? _self.claimed : claimed // ignore: cast_nullable_to_non_nullable
as bool,claimable: null == claimable ? _self.claimable : claimable // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
