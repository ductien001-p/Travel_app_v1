// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'trip_detail_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TripDetailOverview {

 String get id; String get name; String? get description; String? get coverImageUrl; TripDetailStatus get status; TripDetailVisibility get visibility; TripDetailType get tripType; DateTime get startDate; DateTime get endDate; int get maxMembers; TripDetailBudgetLevel? get budgetLevel; String? get inviteCode; TripDetailViewer get viewer; TripDetailExpenseSummary? get expenseSummary; TripDetailCheckinProgress get checkinProgress; List<TripDetailMember> get members; List<TripDetailDestination> get destinations; TripDetailNextActivity? get nextActivity; String? get requirements; String? get estimatedBudgetPerPerson; int? get slotsRemaining; DateTime? get expiresAt; TripDetailMemoriesPreview? get memories; TripDetailCompletionReward? get completionReward; TripDetailTimelinePreview? get timeline;
/// Create a copy of TripDetailOverview
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TripDetailOverviewCopyWith<TripDetailOverview> get copyWith => _$TripDetailOverviewCopyWithImpl<TripDetailOverview>(this as TripDetailOverview, _$identity);

  /// Serializes this TripDetailOverview to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TripDetailOverview;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TripDetailOverview&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.coverImageUrl, _this.coverImageUrl) || other.coverImageUrl == _this.coverImageUrl)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.visibility, _this.visibility) || other.visibility == _this.visibility)&&(identical(other.tripType, _this.tripType) || other.tripType == _this.tripType)&&(identical(other.startDate, _this.startDate) || other.startDate == _this.startDate)&&(identical(other.endDate, _this.endDate) || other.endDate == _this.endDate)&&(identical(other.maxMembers, _this.maxMembers) || other.maxMembers == _this.maxMembers)&&(identical(other.budgetLevel, _this.budgetLevel) || other.budgetLevel == _this.budgetLevel)&&(identical(other.inviteCode, _this.inviteCode) || other.inviteCode == _this.inviteCode)&&(identical(other.viewer, _this.viewer) || other.viewer == _this.viewer)&&(identical(other.expenseSummary, _this.expenseSummary) || other.expenseSummary == _this.expenseSummary)&&(identical(other.checkinProgress, _this.checkinProgress) || other.checkinProgress == _this.checkinProgress)&&const DeepCollectionEquality().equals(other.members, _this.members)&&const DeepCollectionEquality().equals(other.destinations, _this.destinations)&&(identical(other.nextActivity, _this.nextActivity) || other.nextActivity == _this.nextActivity)&&(identical(other.requirements, _this.requirements) || other.requirements == _this.requirements)&&(identical(other.estimatedBudgetPerPerson, _this.estimatedBudgetPerPerson) || other.estimatedBudgetPerPerson == _this.estimatedBudgetPerPerson)&&(identical(other.slotsRemaining, _this.slotsRemaining) || other.slotsRemaining == _this.slotsRemaining)&&(identical(other.expiresAt, _this.expiresAt) || other.expiresAt == _this.expiresAt)&&(identical(other.memories, _this.memories) || other.memories == _this.memories)&&(identical(other.completionReward, _this.completionReward) || other.completionReward == _this.completionReward)&&(identical(other.timeline, _this.timeline) || other.timeline == _this.timeline));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TripDetailOverview;
  return Object.hashAll([runtimeType,_this.id,_this.name,_this.description,_this.coverImageUrl,_this.status,_this.visibility,_this.tripType,_this.startDate,_this.endDate,_this.maxMembers,_this.budgetLevel,_this.inviteCode,_this.viewer,_this.expenseSummary,_this.checkinProgress,const DeepCollectionEquality().hash(_this.members),const DeepCollectionEquality().hash(_this.destinations),_this.nextActivity,_this.requirements,_this.estimatedBudgetPerPerson,_this.slotsRemaining,_this.expiresAt,_this.memories,_this.completionReward,_this.timeline]);
}

@override
String toString() {
  final _this = this as TripDetailOverview;
  return 'TripDetailOverview(id: ${_this.id}, name: ${_this.name}, description: ${_this.description}, coverImageUrl: ${_this.coverImageUrl}, status: ${_this.status}, visibility: ${_this.visibility}, tripType: ${_this.tripType}, startDate: ${_this.startDate}, endDate: ${_this.endDate}, maxMembers: ${_this.maxMembers}, budgetLevel: ${_this.budgetLevel}, inviteCode: ${_this.inviteCode}, viewer: ${_this.viewer}, expenseSummary: ${_this.expenseSummary}, checkinProgress: ${_this.checkinProgress}, members: ${_this.members}, destinations: ${_this.destinations}, nextActivity: ${_this.nextActivity}, requirements: ${_this.requirements}, estimatedBudgetPerPerson: ${_this.estimatedBudgetPerPerson}, slotsRemaining: ${_this.slotsRemaining}, expiresAt: ${_this.expiresAt}, memories: ${_this.memories}, completionReward: ${_this.completionReward}, timeline: ${_this.timeline})';
}


}

/// @nodoc
abstract mixin class $TripDetailOverviewCopyWith<$Res>  {
  factory $TripDetailOverviewCopyWith(TripDetailOverview value, $Res Function(TripDetailOverview) _then) = _$TripDetailOverviewCopyWithImpl;
@useResult
$Res call({
 String id, String name, String? description, String? coverImageUrl, TripDetailStatus status, TripDetailVisibility visibility, TripDetailType tripType, DateTime startDate, DateTime endDate, int maxMembers, TripDetailBudgetLevel? budgetLevel, String? inviteCode, TripDetailViewer viewer, TripDetailExpenseSummary? expenseSummary, TripDetailCheckinProgress checkinProgress, List<TripDetailMember> members, List<TripDetailDestination> destinations, TripDetailNextActivity? nextActivity, String? requirements, String? estimatedBudgetPerPerson, int? slotsRemaining, DateTime? expiresAt, TripDetailMemoriesPreview? memories, TripDetailCompletionReward? completionReward, TripDetailTimelinePreview? timeline
});


$TripDetailViewerCopyWith<$Res> get viewer;$TripDetailExpenseSummaryCopyWith<$Res>? get expenseSummary;$TripDetailCheckinProgressCopyWith<$Res> get checkinProgress;$TripDetailNextActivityCopyWith<$Res>? get nextActivity;$TripDetailMemoriesPreviewCopyWith<$Res>? get memories;$TripDetailCompletionRewardCopyWith<$Res>? get completionReward;$TripDetailTimelinePreviewCopyWith<$Res>? get timeline;

}
/// @nodoc
class _$TripDetailOverviewCopyWithImpl<$Res>
    implements $TripDetailOverviewCopyWith<$Res> {
  _$TripDetailOverviewCopyWithImpl(this._self, this._then);

  final TripDetailOverview _self;
  final $Res Function(TripDetailOverview) _then;

/// Create a copy of TripDetailOverview
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? description = freezed,Object? coverImageUrl = freezed,Object? status = null,Object? visibility = null,Object? tripType = null,Object? startDate = null,Object? endDate = null,Object? maxMembers = null,Object? budgetLevel = freezed,Object? inviteCode = freezed,Object? viewer = null,Object? expenseSummary = freezed,Object? checkinProgress = null,Object? members = null,Object? destinations = null,Object? nextActivity = freezed,Object? requirements = freezed,Object? estimatedBudgetPerPerson = freezed,Object? slotsRemaining = freezed,Object? expiresAt = freezed,Object? memories = freezed,Object? completionReward = freezed,Object? timeline = freezed,}) {
  return _then(TripDetailOverview(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,coverImageUrl: freezed == coverImageUrl ? _self.coverImageUrl : coverImageUrl // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TripDetailStatus,visibility: null == visibility ? _self.visibility : visibility // ignore: cast_nullable_to_non_nullable
as TripDetailVisibility,tripType: null == tripType ? _self.tripType : tripType // ignore: cast_nullable_to_non_nullable
as TripDetailType,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,endDate: null == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime,maxMembers: null == maxMembers ? _self.maxMembers : maxMembers // ignore: cast_nullable_to_non_nullable
as int,budgetLevel: freezed == budgetLevel ? _self.budgetLevel : budgetLevel // ignore: cast_nullable_to_non_nullable
as TripDetailBudgetLevel?,inviteCode: freezed == inviteCode ? _self.inviteCode : inviteCode // ignore: cast_nullable_to_non_nullable
as String?,viewer: null == viewer ? _self.viewer : viewer // ignore: cast_nullable_to_non_nullable
as TripDetailViewer,expenseSummary: freezed == expenseSummary ? _self.expenseSummary : expenseSummary // ignore: cast_nullable_to_non_nullable
as TripDetailExpenseSummary?,checkinProgress: null == checkinProgress ? _self.checkinProgress : checkinProgress // ignore: cast_nullable_to_non_nullable
as TripDetailCheckinProgress,members: null == members ? _self.members : members // ignore: cast_nullable_to_non_nullable
as List<TripDetailMember>,destinations: null == destinations ? _self.destinations : destinations // ignore: cast_nullable_to_non_nullable
as List<TripDetailDestination>,nextActivity: freezed == nextActivity ? _self.nextActivity : nextActivity // ignore: cast_nullable_to_non_nullable
as TripDetailNextActivity?,requirements: freezed == requirements ? _self.requirements : requirements // ignore: cast_nullable_to_non_nullable
as String?,estimatedBudgetPerPerson: freezed == estimatedBudgetPerPerson ? _self.estimatedBudgetPerPerson : estimatedBudgetPerPerson // ignore: cast_nullable_to_non_nullable
as String?,slotsRemaining: freezed == slotsRemaining ? _self.slotsRemaining : slotsRemaining // ignore: cast_nullable_to_non_nullable
as int?,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,memories: freezed == memories ? _self.memories : memories // ignore: cast_nullable_to_non_nullable
as TripDetailMemoriesPreview?,completionReward: freezed == completionReward ? _self.completionReward : completionReward // ignore: cast_nullable_to_non_nullable
as TripDetailCompletionReward?,timeline: freezed == timeline ? _self.timeline : timeline // ignore: cast_nullable_to_non_nullable
as TripDetailTimelinePreview?,
  ));
}
/// Create a copy of TripDetailOverview
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TripDetailViewerCopyWith<$Res> get viewer {
  
  return $TripDetailViewerCopyWith<$Res>(_self.viewer, (value) {
    return _then(_self.copyWith(viewer: value));
  });
}/// Create a copy of TripDetailOverview
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TripDetailExpenseSummaryCopyWith<$Res>? get expenseSummary {
    if (_self.expenseSummary == null) {
    return null;
  }

  return $TripDetailExpenseSummaryCopyWith<$Res>(_self.expenseSummary!, (value) {
    return _then(_self.copyWith(expenseSummary: value));
  });
}/// Create a copy of TripDetailOverview
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TripDetailCheckinProgressCopyWith<$Res> get checkinProgress {
  
  return $TripDetailCheckinProgressCopyWith<$Res>(_self.checkinProgress, (value) {
    return _then(_self.copyWith(checkinProgress: value));
  });
}/// Create a copy of TripDetailOverview
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TripDetailNextActivityCopyWith<$Res>? get nextActivity {
    if (_self.nextActivity == null) {
    return null;
  }

  return $TripDetailNextActivityCopyWith<$Res>(_self.nextActivity!, (value) {
    return _then(_self.copyWith(nextActivity: value));
  });
}/// Create a copy of TripDetailOverview
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TripDetailMemoriesPreviewCopyWith<$Res>? get memories {
    if (_self.memories == null) {
    return null;
  }

  return $TripDetailMemoriesPreviewCopyWith<$Res>(_self.memories!, (value) {
    return _then(_self.copyWith(memories: value));
  });
}/// Create a copy of TripDetailOverview
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TripDetailCompletionRewardCopyWith<$Res>? get completionReward {
    if (_self.completionReward == null) {
    return null;
  }

  return $TripDetailCompletionRewardCopyWith<$Res>(_self.completionReward!, (value) {
    return _then(_self.copyWith(completionReward: value));
  });
}/// Create a copy of TripDetailOverview
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TripDetailTimelinePreviewCopyWith<$Res>? get timeline {
    if (_self.timeline == null) {
    return null;
  }

  return $TripDetailTimelinePreviewCopyWith<$Res>(_self.timeline!, (value) {
    return _then(_self.copyWith(timeline: value));
  });
}
}


/// Adds pattern-matching-related methods to [TripDetailOverview].
extension TripDetailOverviewPatterns on TripDetailOverview {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TripDetailOverview value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TripDetailOverview() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TripDetailOverview value)  $default,){
final _that = this;
switch (_that) {
case _TripDetailOverview():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TripDetailOverview value)?  $default,){
final _that = this;
switch (_that) {
case _TripDetailOverview() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String? description,  String? coverImageUrl,  TripDetailStatus status,  TripDetailVisibility visibility,  TripDetailType tripType,  DateTime startDate,  DateTime endDate,  int maxMembers,  TripDetailBudgetLevel? budgetLevel,  String? inviteCode,  TripDetailViewer viewer,  TripDetailExpenseSummary? expenseSummary,  TripDetailCheckinProgress checkinProgress,  List<TripDetailMember> members,  List<TripDetailDestination> destinations,  TripDetailNextActivity? nextActivity,  String? requirements,  String? estimatedBudgetPerPerson,  int? slotsRemaining,  DateTime? expiresAt,  TripDetailMemoriesPreview? memories,  TripDetailCompletionReward? completionReward,  TripDetailTimelinePreview? timeline)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TripDetailOverview() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.coverImageUrl,_that.status,_that.visibility,_that.tripType,_that.startDate,_that.endDate,_that.maxMembers,_that.budgetLevel,_that.inviteCode,_that.viewer,_that.expenseSummary,_that.checkinProgress,_that.members,_that.destinations,_that.nextActivity,_that.requirements,_that.estimatedBudgetPerPerson,_that.slotsRemaining,_that.expiresAt,_that.memories,_that.completionReward,_that.timeline);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String? description,  String? coverImageUrl,  TripDetailStatus status,  TripDetailVisibility visibility,  TripDetailType tripType,  DateTime startDate,  DateTime endDate,  int maxMembers,  TripDetailBudgetLevel? budgetLevel,  String? inviteCode,  TripDetailViewer viewer,  TripDetailExpenseSummary? expenseSummary,  TripDetailCheckinProgress checkinProgress,  List<TripDetailMember> members,  List<TripDetailDestination> destinations,  TripDetailNextActivity? nextActivity,  String? requirements,  String? estimatedBudgetPerPerson,  int? slotsRemaining,  DateTime? expiresAt,  TripDetailMemoriesPreview? memories,  TripDetailCompletionReward? completionReward,  TripDetailTimelinePreview? timeline)  $default,) {final _that = this;
switch (_that) {
case _TripDetailOverview():
return $default(_that.id,_that.name,_that.description,_that.coverImageUrl,_that.status,_that.visibility,_that.tripType,_that.startDate,_that.endDate,_that.maxMembers,_that.budgetLevel,_that.inviteCode,_that.viewer,_that.expenseSummary,_that.checkinProgress,_that.members,_that.destinations,_that.nextActivity,_that.requirements,_that.estimatedBudgetPerPerson,_that.slotsRemaining,_that.expiresAt,_that.memories,_that.completionReward,_that.timeline);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String? description,  String? coverImageUrl,  TripDetailStatus status,  TripDetailVisibility visibility,  TripDetailType tripType,  DateTime startDate,  DateTime endDate,  int maxMembers,  TripDetailBudgetLevel? budgetLevel,  String? inviteCode,  TripDetailViewer viewer,  TripDetailExpenseSummary? expenseSummary,  TripDetailCheckinProgress checkinProgress,  List<TripDetailMember> members,  List<TripDetailDestination> destinations,  TripDetailNextActivity? nextActivity,  String? requirements,  String? estimatedBudgetPerPerson,  int? slotsRemaining,  DateTime? expiresAt,  TripDetailMemoriesPreview? memories,  TripDetailCompletionReward? completionReward,  TripDetailTimelinePreview? timeline)?  $default,) {final _that = this;
switch (_that) {
case _TripDetailOverview() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.coverImageUrl,_that.status,_that.visibility,_that.tripType,_that.startDate,_that.endDate,_that.maxMembers,_that.budgetLevel,_that.inviteCode,_that.viewer,_that.expenseSummary,_that.checkinProgress,_that.members,_that.destinations,_that.nextActivity,_that.requirements,_that.estimatedBudgetPerPerson,_that.slotsRemaining,_that.expiresAt,_that.memories,_that.completionReward,_that.timeline);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TripDetailOverview extends TripDetailOverview {
  const _TripDetailOverview({required this.id, required this.name, this.description, this.coverImageUrl, required this.status, required this.visibility, required this.tripType, required this.startDate, required this.endDate, required this.maxMembers, this.budgetLevel, this.inviteCode, required this.viewer, this.expenseSummary, required this.checkinProgress,  List<TripDetailMember> members = const <TripDetailMember>[],  List<TripDetailDestination> destinations = const <TripDetailDestination>[], this.nextActivity, this.requirements, this.estimatedBudgetPerPerson, this.slotsRemaining, this.expiresAt, this.memories, this.completionReward, this.timeline}): _members = members,_destinations = destinations,super._();
  factory _TripDetailOverview.fromJson(Map<String, dynamic> json) => _$TripDetailOverviewFromJson(json);

@override final  String id;
@override final  String name;
@override final  String? description;
@override final  String? coverImageUrl;
@override final  TripDetailStatus status;
@override final  TripDetailVisibility visibility;
@override final  TripDetailType tripType;
@override final  DateTime startDate;
@override final  DateTime endDate;
@override final  int maxMembers;
@override final  TripDetailBudgetLevel? budgetLevel;
@override final  String? inviteCode;
@override final  TripDetailViewer viewer;
@override final  TripDetailExpenseSummary? expenseSummary;
@override final  TripDetailCheckinProgress checkinProgress;
 final  List<TripDetailMember> _members;
@override@JsonKey() List<TripDetailMember> get members {
  if (_members is EqualUnmodifiableListView) return _members;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_members);
}

 final  List<TripDetailDestination> _destinations;
@override@JsonKey() List<TripDetailDestination> get destinations {
  if (_destinations is EqualUnmodifiableListView) return _destinations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_destinations);
}

@override final  TripDetailNextActivity? nextActivity;
@override final  String? requirements;
@override final  String? estimatedBudgetPerPerson;
@override final  int? slotsRemaining;
@override final  DateTime? expiresAt;
@override final  TripDetailMemoriesPreview? memories;
@override final  TripDetailCompletionReward? completionReward;
@override final  TripDetailTimelinePreview? timeline;

/// Create a copy of TripDetailOverview
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TripDetailOverviewCopyWith<_TripDetailOverview> get copyWith => __$TripDetailOverviewCopyWithImpl<_TripDetailOverview>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TripDetailOverviewToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TripDetailOverview&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.coverImageUrl, coverImageUrl) || other.coverImageUrl == coverImageUrl)&&(identical(other.status, status) || other.status == status)&&(identical(other.visibility, visibility) || other.visibility == visibility)&&(identical(other.tripType, tripType) || other.tripType == tripType)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.maxMembers, maxMembers) || other.maxMembers == maxMembers)&&(identical(other.budgetLevel, budgetLevel) || other.budgetLevel == budgetLevel)&&(identical(other.inviteCode, inviteCode) || other.inviteCode == inviteCode)&&(identical(other.viewer, viewer) || other.viewer == viewer)&&(identical(other.expenseSummary, expenseSummary) || other.expenseSummary == expenseSummary)&&(identical(other.checkinProgress, checkinProgress) || other.checkinProgress == checkinProgress)&&const DeepCollectionEquality().equals(other.members, _members)&&const DeepCollectionEquality().equals(other.destinations, _destinations)&&(identical(other.nextActivity, nextActivity) || other.nextActivity == nextActivity)&&(identical(other.requirements, requirements) || other.requirements == requirements)&&(identical(other.estimatedBudgetPerPerson, estimatedBudgetPerPerson) || other.estimatedBudgetPerPerson == estimatedBudgetPerPerson)&&(identical(other.slotsRemaining, slotsRemaining) || other.slotsRemaining == slotsRemaining)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.memories, memories) || other.memories == memories)&&(identical(other.completionReward, completionReward) || other.completionReward == completionReward)&&(identical(other.timeline, timeline) || other.timeline == timeline));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hashAll([runtimeType,id,name,description,coverImageUrl,status,visibility,tripType,startDate,endDate,maxMembers,budgetLevel,inviteCode,viewer,expenseSummary,checkinProgress,const DeepCollectionEquality().hash(_members),const DeepCollectionEquality().hash(_destinations),nextActivity,requirements,estimatedBudgetPerPerson,slotsRemaining,expiresAt,memories,completionReward,timeline]);
}

@override
String toString() {
    return 'TripDetailOverview(id: $id, name: $name, description: $description, coverImageUrl: $coverImageUrl, status: $status, visibility: $visibility, tripType: $tripType, startDate: $startDate, endDate: $endDate, maxMembers: $maxMembers, budgetLevel: $budgetLevel, inviteCode: $inviteCode, viewer: $viewer, expenseSummary: $expenseSummary, checkinProgress: $checkinProgress, members: $members, destinations: $destinations, nextActivity: $nextActivity, requirements: $requirements, estimatedBudgetPerPerson: $estimatedBudgetPerPerson, slotsRemaining: $slotsRemaining, expiresAt: $expiresAt, memories: $memories, completionReward: $completionReward, timeline: $timeline)';
}


}

/// @nodoc
abstract mixin class _$TripDetailOverviewCopyWith<$Res> implements $TripDetailOverviewCopyWith<$Res> {
  factory _$TripDetailOverviewCopyWith(_TripDetailOverview value, $Res Function(_TripDetailOverview) _then) = __$TripDetailOverviewCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String? description, String? coverImageUrl, TripDetailStatus status, TripDetailVisibility visibility, TripDetailType tripType, DateTime startDate, DateTime endDate, int maxMembers, TripDetailBudgetLevel? budgetLevel, String? inviteCode, TripDetailViewer viewer, TripDetailExpenseSummary? expenseSummary, TripDetailCheckinProgress checkinProgress, List<TripDetailMember> members, List<TripDetailDestination> destinations, TripDetailNextActivity? nextActivity, String? requirements, String? estimatedBudgetPerPerson, int? slotsRemaining, DateTime? expiresAt, TripDetailMemoriesPreview? memories, TripDetailCompletionReward? completionReward, TripDetailTimelinePreview? timeline
});


@override $TripDetailViewerCopyWith<$Res> get viewer;@override $TripDetailExpenseSummaryCopyWith<$Res>? get expenseSummary;@override $TripDetailCheckinProgressCopyWith<$Res> get checkinProgress;@override $TripDetailNextActivityCopyWith<$Res>? get nextActivity;@override $TripDetailMemoriesPreviewCopyWith<$Res>? get memories;@override $TripDetailCompletionRewardCopyWith<$Res>? get completionReward;@override $TripDetailTimelinePreviewCopyWith<$Res>? get timeline;

}
/// @nodoc
class __$TripDetailOverviewCopyWithImpl<$Res>
    implements _$TripDetailOverviewCopyWith<$Res> {
  __$TripDetailOverviewCopyWithImpl(this._self, this._then);

  final _TripDetailOverview _self;
  final $Res Function(_TripDetailOverview) _then;

/// Create a copy of TripDetailOverview
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? description = freezed,Object? coverImageUrl = freezed,Object? status = null,Object? visibility = null,Object? tripType = null,Object? startDate = null,Object? endDate = null,Object? maxMembers = null,Object? budgetLevel = freezed,Object? inviteCode = freezed,Object? viewer = null,Object? expenseSummary = freezed,Object? checkinProgress = null,Object? members = null,Object? destinations = null,Object? nextActivity = freezed,Object? requirements = freezed,Object? estimatedBudgetPerPerson = freezed,Object? slotsRemaining = freezed,Object? expiresAt = freezed,Object? memories = freezed,Object? completionReward = freezed,Object? timeline = freezed,}) {
  return _then(_TripDetailOverview(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,coverImageUrl: freezed == coverImageUrl ? _self.coverImageUrl : coverImageUrl // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TripDetailStatus,visibility: null == visibility ? _self.visibility : visibility // ignore: cast_nullable_to_non_nullable
as TripDetailVisibility,tripType: null == tripType ? _self.tripType : tripType // ignore: cast_nullable_to_non_nullable
as TripDetailType,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,endDate: null == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime,maxMembers: null == maxMembers ? _self.maxMembers : maxMembers // ignore: cast_nullable_to_non_nullable
as int,budgetLevel: freezed == budgetLevel ? _self.budgetLevel : budgetLevel // ignore: cast_nullable_to_non_nullable
as TripDetailBudgetLevel?,inviteCode: freezed == inviteCode ? _self.inviteCode : inviteCode // ignore: cast_nullable_to_non_nullable
as String?,viewer: null == viewer ? _self.viewer : viewer // ignore: cast_nullable_to_non_nullable
as TripDetailViewer,expenseSummary: freezed == expenseSummary ? _self.expenseSummary : expenseSummary // ignore: cast_nullable_to_non_nullable
as TripDetailExpenseSummary?,checkinProgress: null == checkinProgress ? _self.checkinProgress : checkinProgress // ignore: cast_nullable_to_non_nullable
as TripDetailCheckinProgress,members: null == members ? _self._members : members // ignore: cast_nullable_to_non_nullable
as List<TripDetailMember>,destinations: null == destinations ? _self._destinations : destinations // ignore: cast_nullable_to_non_nullable
as List<TripDetailDestination>,nextActivity: freezed == nextActivity ? _self.nextActivity : nextActivity // ignore: cast_nullable_to_non_nullable
as TripDetailNextActivity?,requirements: freezed == requirements ? _self.requirements : requirements // ignore: cast_nullable_to_non_nullable
as String?,estimatedBudgetPerPerson: freezed == estimatedBudgetPerPerson ? _self.estimatedBudgetPerPerson : estimatedBudgetPerPerson // ignore: cast_nullable_to_non_nullable
as String?,slotsRemaining: freezed == slotsRemaining ? _self.slotsRemaining : slotsRemaining // ignore: cast_nullable_to_non_nullable
as int?,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,memories: freezed == memories ? _self.memories : memories // ignore: cast_nullable_to_non_nullable
as TripDetailMemoriesPreview?,completionReward: freezed == completionReward ? _self.completionReward : completionReward // ignore: cast_nullable_to_non_nullable
as TripDetailCompletionReward?,timeline: freezed == timeline ? _self.timeline : timeline // ignore: cast_nullable_to_non_nullable
as TripDetailTimelinePreview?,
  ));
}

/// Create a copy of TripDetailOverview
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TripDetailViewerCopyWith<$Res> get viewer {
  
  return $TripDetailViewerCopyWith<$Res>(_self.viewer, (value) {
    return _then(_self.copyWith(viewer: value));
  });
}/// Create a copy of TripDetailOverview
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TripDetailExpenseSummaryCopyWith<$Res>? get expenseSummary {
    if (_self.expenseSummary == null) {
    return null;
  }

  return $TripDetailExpenseSummaryCopyWith<$Res>(_self.expenseSummary!, (value) {
    return _then(_self.copyWith(expenseSummary: value));
  });
}/// Create a copy of TripDetailOverview
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TripDetailCheckinProgressCopyWith<$Res> get checkinProgress {
  
  return $TripDetailCheckinProgressCopyWith<$Res>(_self.checkinProgress, (value) {
    return _then(_self.copyWith(checkinProgress: value));
  });
}/// Create a copy of TripDetailOverview
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TripDetailNextActivityCopyWith<$Res>? get nextActivity {
    if (_self.nextActivity == null) {
    return null;
  }

  return $TripDetailNextActivityCopyWith<$Res>(_self.nextActivity!, (value) {
    return _then(_self.copyWith(nextActivity: value));
  });
}/// Create a copy of TripDetailOverview
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TripDetailMemoriesPreviewCopyWith<$Res>? get memories {
    if (_self.memories == null) {
    return null;
  }

  return $TripDetailMemoriesPreviewCopyWith<$Res>(_self.memories!, (value) {
    return _then(_self.copyWith(memories: value));
  });
}/// Create a copy of TripDetailOverview
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TripDetailCompletionRewardCopyWith<$Res>? get completionReward {
    if (_self.completionReward == null) {
    return null;
  }

  return $TripDetailCompletionRewardCopyWith<$Res>(_self.completionReward!, (value) {
    return _then(_self.copyWith(completionReward: value));
  });
}/// Create a copy of TripDetailOverview
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TripDetailTimelinePreviewCopyWith<$Res>? get timeline {
    if (_self.timeline == null) {
    return null;
  }

  return $TripDetailTimelinePreviewCopyWith<$Res>(_self.timeline!, (value) {
    return _then(_self.copyWith(timeline: value));
  });
}
}


/// @nodoc
mixin _$TripDetailViewer {

 String get userId;/// Null when the viewer is not an active member of the trip.
 TripDetailMemberRole? get role;
/// Create a copy of TripDetailViewer
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TripDetailViewerCopyWith<TripDetailViewer> get copyWith => _$TripDetailViewerCopyWithImpl<TripDetailViewer>(this as TripDetailViewer, _$identity);

  /// Serializes this TripDetailViewer to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TripDetailViewer;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TripDetailViewer&&(identical(other.userId, _this.userId) || other.userId == _this.userId)&&(identical(other.role, _this.role) || other.role == _this.role));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TripDetailViewer;
  return Object.hash(runtimeType,_this.userId,_this.role);
}

@override
String toString() {
  final _this = this as TripDetailViewer;
  return 'TripDetailViewer(userId: ${_this.userId}, role: ${_this.role})';
}


}

/// @nodoc
abstract mixin class $TripDetailViewerCopyWith<$Res>  {
  factory $TripDetailViewerCopyWith(TripDetailViewer value, $Res Function(TripDetailViewer) _then) = _$TripDetailViewerCopyWithImpl;
@useResult
$Res call({
 String userId, TripDetailMemberRole? role
});




}
/// @nodoc
class _$TripDetailViewerCopyWithImpl<$Res>
    implements $TripDetailViewerCopyWith<$Res> {
  _$TripDetailViewerCopyWithImpl(this._self, this._then);

  final TripDetailViewer _self;
  final $Res Function(TripDetailViewer) _then;

/// Create a copy of TripDetailViewer
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? role = freezed,}) {
  return _then(TripDetailViewer(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,role: freezed == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as TripDetailMemberRole?,
  ));
}

}


/// Adds pattern-matching-related methods to [TripDetailViewer].
extension TripDetailViewerPatterns on TripDetailViewer {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TripDetailViewer value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TripDetailViewer() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TripDetailViewer value)  $default,){
final _that = this;
switch (_that) {
case _TripDetailViewer():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TripDetailViewer value)?  $default,){
final _that = this;
switch (_that) {
case _TripDetailViewer() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String userId,  TripDetailMemberRole? role)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TripDetailViewer() when $default != null:
return $default(_that.userId,_that.role);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String userId,  TripDetailMemberRole? role)  $default,) {final _that = this;
switch (_that) {
case _TripDetailViewer():
return $default(_that.userId,_that.role);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String userId,  TripDetailMemberRole? role)?  $default,) {final _that = this;
switch (_that) {
case _TripDetailViewer() when $default != null:
return $default(_that.userId,_that.role);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TripDetailViewer implements TripDetailViewer {
  const _TripDetailViewer({required this.userId, this.role});
  factory _TripDetailViewer.fromJson(Map<String, dynamic> json) => _$TripDetailViewerFromJson(json);

@override final  String userId;
/// Null when the viewer is not an active member of the trip.
@override final  TripDetailMemberRole? role;

/// Create a copy of TripDetailViewer
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TripDetailViewerCopyWith<_TripDetailViewer> get copyWith => __$TripDetailViewerCopyWithImpl<_TripDetailViewer>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TripDetailViewerToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TripDetailViewer&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.role, role) || other.role == role));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,userId,role);
}

@override
String toString() {
    return 'TripDetailViewer(userId: $userId, role: $role)';
}


}

/// @nodoc
abstract mixin class _$TripDetailViewerCopyWith<$Res> implements $TripDetailViewerCopyWith<$Res> {
  factory _$TripDetailViewerCopyWith(_TripDetailViewer value, $Res Function(_TripDetailViewer) _then) = __$TripDetailViewerCopyWithImpl;
@override @useResult
$Res call({
 String userId, TripDetailMemberRole? role
});




}
/// @nodoc
class __$TripDetailViewerCopyWithImpl<$Res>
    implements _$TripDetailViewerCopyWith<$Res> {
  __$TripDetailViewerCopyWithImpl(this._self, this._then);

  final _TripDetailViewer _self;
  final $Res Function(_TripDetailViewer) _then;

/// Create a copy of TripDetailViewer
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? role = freezed,}) {
  return _then(_TripDetailViewer(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,role: freezed == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as TripDetailMemberRole?,
  ));
}


}


/// @nodoc
mixin _$TripDetailExpenseSummary {

 double get totalAmount; String get currency;
/// Create a copy of TripDetailExpenseSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TripDetailExpenseSummaryCopyWith<TripDetailExpenseSummary> get copyWith => _$TripDetailExpenseSummaryCopyWithImpl<TripDetailExpenseSummary>(this as TripDetailExpenseSummary, _$identity);

  /// Serializes this TripDetailExpenseSummary to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TripDetailExpenseSummary;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TripDetailExpenseSummary&&(identical(other.totalAmount, _this.totalAmount) || other.totalAmount == _this.totalAmount)&&(identical(other.currency, _this.currency) || other.currency == _this.currency));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TripDetailExpenseSummary;
  return Object.hash(runtimeType,_this.totalAmount,_this.currency);
}

@override
String toString() {
  final _this = this as TripDetailExpenseSummary;
  return 'TripDetailExpenseSummary(totalAmount: ${_this.totalAmount}, currency: ${_this.currency})';
}


}

/// @nodoc
abstract mixin class $TripDetailExpenseSummaryCopyWith<$Res>  {
  factory $TripDetailExpenseSummaryCopyWith(TripDetailExpenseSummary value, $Res Function(TripDetailExpenseSummary) _then) = _$TripDetailExpenseSummaryCopyWithImpl;
@useResult
$Res call({
 double totalAmount, String currency
});




}
/// @nodoc
class _$TripDetailExpenseSummaryCopyWithImpl<$Res>
    implements $TripDetailExpenseSummaryCopyWith<$Res> {
  _$TripDetailExpenseSummaryCopyWithImpl(this._self, this._then);

  final TripDetailExpenseSummary _self;
  final $Res Function(TripDetailExpenseSummary) _then;

/// Create a copy of TripDetailExpenseSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalAmount = null,Object? currency = null,}) {
  return _then(TripDetailExpenseSummary(
totalAmount: null == totalAmount ? _self.totalAmount : totalAmount // ignore: cast_nullable_to_non_nullable
as double,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [TripDetailExpenseSummary].
extension TripDetailExpenseSummaryPatterns on TripDetailExpenseSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TripDetailExpenseSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TripDetailExpenseSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TripDetailExpenseSummary value)  $default,){
final _that = this;
switch (_that) {
case _TripDetailExpenseSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TripDetailExpenseSummary value)?  $default,){
final _that = this;
switch (_that) {
case _TripDetailExpenseSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double totalAmount,  String currency)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TripDetailExpenseSummary() when $default != null:
return $default(_that.totalAmount,_that.currency);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double totalAmount,  String currency)  $default,) {final _that = this;
switch (_that) {
case _TripDetailExpenseSummary():
return $default(_that.totalAmount,_that.currency);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double totalAmount,  String currency)?  $default,) {final _that = this;
switch (_that) {
case _TripDetailExpenseSummary() when $default != null:
return $default(_that.totalAmount,_that.currency);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TripDetailExpenseSummary implements TripDetailExpenseSummary {
  const _TripDetailExpenseSummary({required this.totalAmount, this.currency = 'VND'});
  factory _TripDetailExpenseSummary.fromJson(Map<String, dynamic> json) => _$TripDetailExpenseSummaryFromJson(json);

@override final  double totalAmount;
@override@JsonKey() final  String currency;

/// Create a copy of TripDetailExpenseSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TripDetailExpenseSummaryCopyWith<_TripDetailExpenseSummary> get copyWith => __$TripDetailExpenseSummaryCopyWithImpl<_TripDetailExpenseSummary>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TripDetailExpenseSummaryToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TripDetailExpenseSummary&&(identical(other.totalAmount, totalAmount) || other.totalAmount == totalAmount)&&(identical(other.currency, currency) || other.currency == currency));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,totalAmount,currency);
}

@override
String toString() {
    return 'TripDetailExpenseSummary(totalAmount: $totalAmount, currency: $currency)';
}


}

/// @nodoc
abstract mixin class _$TripDetailExpenseSummaryCopyWith<$Res> implements $TripDetailExpenseSummaryCopyWith<$Res> {
  factory _$TripDetailExpenseSummaryCopyWith(_TripDetailExpenseSummary value, $Res Function(_TripDetailExpenseSummary) _then) = __$TripDetailExpenseSummaryCopyWithImpl;
@override @useResult
$Res call({
 double totalAmount, String currency
});




}
/// @nodoc
class __$TripDetailExpenseSummaryCopyWithImpl<$Res>
    implements _$TripDetailExpenseSummaryCopyWith<$Res> {
  __$TripDetailExpenseSummaryCopyWithImpl(this._self, this._then);

  final _TripDetailExpenseSummary _self;
  final $Res Function(_TripDetailExpenseSummary) _then;

/// Create a copy of TripDetailExpenseSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalAmount = null,Object? currency = null,}) {
  return _then(_TripDetailExpenseSummary(
totalAmount: null == totalAmount ? _self.totalAmount : totalAmount // ignore: cast_nullable_to_non_nullable
as double,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$TripDetailCheckinProgress {

 int get completedCount; int get totalCount; int get pointsEarned;
/// Create a copy of TripDetailCheckinProgress
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TripDetailCheckinProgressCopyWith<TripDetailCheckinProgress> get copyWith => _$TripDetailCheckinProgressCopyWithImpl<TripDetailCheckinProgress>(this as TripDetailCheckinProgress, _$identity);

  /// Serializes this TripDetailCheckinProgress to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TripDetailCheckinProgress;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TripDetailCheckinProgress&&(identical(other.completedCount, _this.completedCount) || other.completedCount == _this.completedCount)&&(identical(other.totalCount, _this.totalCount) || other.totalCount == _this.totalCount)&&(identical(other.pointsEarned, _this.pointsEarned) || other.pointsEarned == _this.pointsEarned));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TripDetailCheckinProgress;
  return Object.hash(runtimeType,_this.completedCount,_this.totalCount,_this.pointsEarned);
}

@override
String toString() {
  final _this = this as TripDetailCheckinProgress;
  return 'TripDetailCheckinProgress(completedCount: ${_this.completedCount}, totalCount: ${_this.totalCount}, pointsEarned: ${_this.pointsEarned})';
}


}

/// @nodoc
abstract mixin class $TripDetailCheckinProgressCopyWith<$Res>  {
  factory $TripDetailCheckinProgressCopyWith(TripDetailCheckinProgress value, $Res Function(TripDetailCheckinProgress) _then) = _$TripDetailCheckinProgressCopyWithImpl;
@useResult
$Res call({
 int completedCount, int totalCount, int pointsEarned
});




}
/// @nodoc
class _$TripDetailCheckinProgressCopyWithImpl<$Res>
    implements $TripDetailCheckinProgressCopyWith<$Res> {
  _$TripDetailCheckinProgressCopyWithImpl(this._self, this._then);

  final TripDetailCheckinProgress _self;
  final $Res Function(TripDetailCheckinProgress) _then;

/// Create a copy of TripDetailCheckinProgress
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? completedCount = null,Object? totalCount = null,Object? pointsEarned = null,}) {
  return _then(TripDetailCheckinProgress(
completedCount: null == completedCount ? _self.completedCount : completedCount // ignore: cast_nullable_to_non_nullable
as int,totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,pointsEarned: null == pointsEarned ? _self.pointsEarned : pointsEarned // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [TripDetailCheckinProgress].
extension TripDetailCheckinProgressPatterns on TripDetailCheckinProgress {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TripDetailCheckinProgress value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TripDetailCheckinProgress() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TripDetailCheckinProgress value)  $default,){
final _that = this;
switch (_that) {
case _TripDetailCheckinProgress():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TripDetailCheckinProgress value)?  $default,){
final _that = this;
switch (_that) {
case _TripDetailCheckinProgress() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int completedCount,  int totalCount,  int pointsEarned)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TripDetailCheckinProgress() when $default != null:
return $default(_that.completedCount,_that.totalCount,_that.pointsEarned);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int completedCount,  int totalCount,  int pointsEarned)  $default,) {final _that = this;
switch (_that) {
case _TripDetailCheckinProgress():
return $default(_that.completedCount,_that.totalCount,_that.pointsEarned);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int completedCount,  int totalCount,  int pointsEarned)?  $default,) {final _that = this;
switch (_that) {
case _TripDetailCheckinProgress() when $default != null:
return $default(_that.completedCount,_that.totalCount,_that.pointsEarned);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TripDetailCheckinProgress extends TripDetailCheckinProgress {
  const _TripDetailCheckinProgress({required this.completedCount, required this.totalCount, this.pointsEarned = 0}): super._();
  factory _TripDetailCheckinProgress.fromJson(Map<String, dynamic> json) => _$TripDetailCheckinProgressFromJson(json);

@override final  int completedCount;
@override final  int totalCount;
@override@JsonKey() final  int pointsEarned;

/// Create a copy of TripDetailCheckinProgress
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TripDetailCheckinProgressCopyWith<_TripDetailCheckinProgress> get copyWith => __$TripDetailCheckinProgressCopyWithImpl<_TripDetailCheckinProgress>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TripDetailCheckinProgressToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TripDetailCheckinProgress&&(identical(other.completedCount, completedCount) || other.completedCount == completedCount)&&(identical(other.totalCount, totalCount) || other.totalCount == totalCount)&&(identical(other.pointsEarned, pointsEarned) || other.pointsEarned == pointsEarned));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,completedCount,totalCount,pointsEarned);
}

@override
String toString() {
    return 'TripDetailCheckinProgress(completedCount: $completedCount, totalCount: $totalCount, pointsEarned: $pointsEarned)';
}


}

/// @nodoc
abstract mixin class _$TripDetailCheckinProgressCopyWith<$Res> implements $TripDetailCheckinProgressCopyWith<$Res> {
  factory _$TripDetailCheckinProgressCopyWith(_TripDetailCheckinProgress value, $Res Function(_TripDetailCheckinProgress) _then) = __$TripDetailCheckinProgressCopyWithImpl;
@override @useResult
$Res call({
 int completedCount, int totalCount, int pointsEarned
});




}
/// @nodoc
class __$TripDetailCheckinProgressCopyWithImpl<$Res>
    implements _$TripDetailCheckinProgressCopyWith<$Res> {
  __$TripDetailCheckinProgressCopyWithImpl(this._self, this._then);

  final _TripDetailCheckinProgress _self;
  final $Res Function(_TripDetailCheckinProgress) _then;

/// Create a copy of TripDetailCheckinProgress
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? completedCount = null,Object? totalCount = null,Object? pointsEarned = null,}) {
  return _then(_TripDetailCheckinProgress(
completedCount: null == completedCount ? _self.completedCount : completedCount // ignore: cast_nullable_to_non_nullable
as int,totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,pointsEarned: null == pointsEarned ? _self.pointsEarned : pointsEarned // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$TripDetailMember {

 String get id; String get userId; String get displayName; String? get avatarUrl; TripDetailMemberRole get role; DateTime get joinedAt; String? get travelPersona; String? get activityNote; bool get isOnline; bool get isNewMember; double? get amountSpent; int get memoryCount;
/// Create a copy of TripDetailMember
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TripDetailMemberCopyWith<TripDetailMember> get copyWith => _$TripDetailMemberCopyWithImpl<TripDetailMember>(this as TripDetailMember, _$identity);

  /// Serializes this TripDetailMember to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TripDetailMember;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TripDetailMember&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.userId, _this.userId) || other.userId == _this.userId)&&(identical(other.displayName, _this.displayName) || other.displayName == _this.displayName)&&(identical(other.avatarUrl, _this.avatarUrl) || other.avatarUrl == _this.avatarUrl)&&(identical(other.role, _this.role) || other.role == _this.role)&&(identical(other.joinedAt, _this.joinedAt) || other.joinedAt == _this.joinedAt)&&(identical(other.travelPersona, _this.travelPersona) || other.travelPersona == _this.travelPersona)&&(identical(other.activityNote, _this.activityNote) || other.activityNote == _this.activityNote)&&(identical(other.isOnline, _this.isOnline) || other.isOnline == _this.isOnline)&&(identical(other.isNewMember, _this.isNewMember) || other.isNewMember == _this.isNewMember)&&(identical(other.amountSpent, _this.amountSpent) || other.amountSpent == _this.amountSpent)&&(identical(other.memoryCount, _this.memoryCount) || other.memoryCount == _this.memoryCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TripDetailMember;
  return Object.hash(runtimeType,_this.id,_this.userId,_this.displayName,_this.avatarUrl,_this.role,_this.joinedAt,_this.travelPersona,_this.activityNote,_this.isOnline,_this.isNewMember,_this.amountSpent,_this.memoryCount);
}

@override
String toString() {
  final _this = this as TripDetailMember;
  return 'TripDetailMember(id: ${_this.id}, userId: ${_this.userId}, displayName: ${_this.displayName}, avatarUrl: ${_this.avatarUrl}, role: ${_this.role}, joinedAt: ${_this.joinedAt}, travelPersona: ${_this.travelPersona}, activityNote: ${_this.activityNote}, isOnline: ${_this.isOnline}, isNewMember: ${_this.isNewMember}, amountSpent: ${_this.amountSpent}, memoryCount: ${_this.memoryCount})';
}


}

/// @nodoc
abstract mixin class $TripDetailMemberCopyWith<$Res>  {
  factory $TripDetailMemberCopyWith(TripDetailMember value, $Res Function(TripDetailMember) _then) = _$TripDetailMemberCopyWithImpl;
@useResult
$Res call({
 String id, String userId, String displayName, String? avatarUrl, TripDetailMemberRole role, DateTime joinedAt, String? travelPersona, String? activityNote, bool isOnline, bool isNewMember, double? amountSpent, int memoryCount
});




}
/// @nodoc
class _$TripDetailMemberCopyWithImpl<$Res>
    implements $TripDetailMemberCopyWith<$Res> {
  _$TripDetailMemberCopyWithImpl(this._self, this._then);

  final TripDetailMember _self;
  final $Res Function(TripDetailMember) _then;

/// Create a copy of TripDetailMember
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? displayName = null,Object? avatarUrl = freezed,Object? role = null,Object? joinedAt = null,Object? travelPersona = freezed,Object? activityNote = freezed,Object? isOnline = null,Object? isNewMember = null,Object? amountSpent = freezed,Object? memoryCount = null,}) {
  return _then(TripDetailMember(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as TripDetailMemberRole,joinedAt: null == joinedAt ? _self.joinedAt : joinedAt // ignore: cast_nullable_to_non_nullable
as DateTime,travelPersona: freezed == travelPersona ? _self.travelPersona : travelPersona // ignore: cast_nullable_to_non_nullable
as String?,activityNote: freezed == activityNote ? _self.activityNote : activityNote // ignore: cast_nullable_to_non_nullable
as String?,isOnline: null == isOnline ? _self.isOnline : isOnline // ignore: cast_nullable_to_non_nullable
as bool,isNewMember: null == isNewMember ? _self.isNewMember : isNewMember // ignore: cast_nullable_to_non_nullable
as bool,amountSpent: freezed == amountSpent ? _self.amountSpent : amountSpent // ignore: cast_nullable_to_non_nullable
as double?,memoryCount: null == memoryCount ? _self.memoryCount : memoryCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [TripDetailMember].
extension TripDetailMemberPatterns on TripDetailMember {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TripDetailMember value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TripDetailMember() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TripDetailMember value)  $default,){
final _that = this;
switch (_that) {
case _TripDetailMember():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TripDetailMember value)?  $default,){
final _that = this;
switch (_that) {
case _TripDetailMember() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String userId,  String displayName,  String? avatarUrl,  TripDetailMemberRole role,  DateTime joinedAt,  String? travelPersona,  String? activityNote,  bool isOnline,  bool isNewMember,  double? amountSpent,  int memoryCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TripDetailMember() when $default != null:
return $default(_that.id,_that.userId,_that.displayName,_that.avatarUrl,_that.role,_that.joinedAt,_that.travelPersona,_that.activityNote,_that.isOnline,_that.isNewMember,_that.amountSpent,_that.memoryCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String userId,  String displayName,  String? avatarUrl,  TripDetailMemberRole role,  DateTime joinedAt,  String? travelPersona,  String? activityNote,  bool isOnline,  bool isNewMember,  double? amountSpent,  int memoryCount)  $default,) {final _that = this;
switch (_that) {
case _TripDetailMember():
return $default(_that.id,_that.userId,_that.displayName,_that.avatarUrl,_that.role,_that.joinedAt,_that.travelPersona,_that.activityNote,_that.isOnline,_that.isNewMember,_that.amountSpent,_that.memoryCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String userId,  String displayName,  String? avatarUrl,  TripDetailMemberRole role,  DateTime joinedAt,  String? travelPersona,  String? activityNote,  bool isOnline,  bool isNewMember,  double? amountSpent,  int memoryCount)?  $default,) {final _that = this;
switch (_that) {
case _TripDetailMember() when $default != null:
return $default(_that.id,_that.userId,_that.displayName,_that.avatarUrl,_that.role,_that.joinedAt,_that.travelPersona,_that.activityNote,_that.isOnline,_that.isNewMember,_that.amountSpent,_that.memoryCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TripDetailMember implements TripDetailMember {
  const _TripDetailMember({required this.id, required this.userId, required this.displayName, this.avatarUrl, required this.role, required this.joinedAt, this.travelPersona, this.activityNote, this.isOnline = false, this.isNewMember = false, this.amountSpent, this.memoryCount = 0});
  factory _TripDetailMember.fromJson(Map<String, dynamic> json) => _$TripDetailMemberFromJson(json);

@override final  String id;
@override final  String userId;
@override final  String displayName;
@override final  String? avatarUrl;
@override final  TripDetailMemberRole role;
@override final  DateTime joinedAt;
@override final  String? travelPersona;
@override final  String? activityNote;
@override@JsonKey() final  bool isOnline;
@override@JsonKey() final  bool isNewMember;
@override final  double? amountSpent;
@override@JsonKey() final  int memoryCount;

/// Create a copy of TripDetailMember
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TripDetailMemberCopyWith<_TripDetailMember> get copyWith => __$TripDetailMemberCopyWithImpl<_TripDetailMember>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TripDetailMemberToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TripDetailMember&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.role, role) || other.role == role)&&(identical(other.joinedAt, joinedAt) || other.joinedAt == joinedAt)&&(identical(other.travelPersona, travelPersona) || other.travelPersona == travelPersona)&&(identical(other.activityNote, activityNote) || other.activityNote == activityNote)&&(identical(other.isOnline, isOnline) || other.isOnline == isOnline)&&(identical(other.isNewMember, isNewMember) || other.isNewMember == isNewMember)&&(identical(other.amountSpent, amountSpent) || other.amountSpent == amountSpent)&&(identical(other.memoryCount, memoryCount) || other.memoryCount == memoryCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,userId,displayName,avatarUrl,role,joinedAt,travelPersona,activityNote,isOnline,isNewMember,amountSpent,memoryCount);
}

@override
String toString() {
    return 'TripDetailMember(id: $id, userId: $userId, displayName: $displayName, avatarUrl: $avatarUrl, role: $role, joinedAt: $joinedAt, travelPersona: $travelPersona, activityNote: $activityNote, isOnline: $isOnline, isNewMember: $isNewMember, amountSpent: $amountSpent, memoryCount: $memoryCount)';
}


}

/// @nodoc
abstract mixin class _$TripDetailMemberCopyWith<$Res> implements $TripDetailMemberCopyWith<$Res> {
  factory _$TripDetailMemberCopyWith(_TripDetailMember value, $Res Function(_TripDetailMember) _then) = __$TripDetailMemberCopyWithImpl;
@override @useResult
$Res call({
 String id, String userId, String displayName, String? avatarUrl, TripDetailMemberRole role, DateTime joinedAt, String? travelPersona, String? activityNote, bool isOnline, bool isNewMember, double? amountSpent, int memoryCount
});




}
/// @nodoc
class __$TripDetailMemberCopyWithImpl<$Res>
    implements _$TripDetailMemberCopyWith<$Res> {
  __$TripDetailMemberCopyWithImpl(this._self, this._then);

  final _TripDetailMember _self;
  final $Res Function(_TripDetailMember) _then;

/// Create a copy of TripDetailMember
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? displayName = null,Object? avatarUrl = freezed,Object? role = null,Object? joinedAt = null,Object? travelPersona = freezed,Object? activityNote = freezed,Object? isOnline = null,Object? isNewMember = null,Object? amountSpent = freezed,Object? memoryCount = null,}) {
  return _then(_TripDetailMember(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as TripDetailMemberRole,joinedAt: null == joinedAt ? _self.joinedAt : joinedAt // ignore: cast_nullable_to_non_nullable
as DateTime,travelPersona: freezed == travelPersona ? _self.travelPersona : travelPersona // ignore: cast_nullable_to_non_nullable
as String?,activityNote: freezed == activityNote ? _self.activityNote : activityNote // ignore: cast_nullable_to_non_nullable
as String?,isOnline: null == isOnline ? _self.isOnline : isOnline // ignore: cast_nullable_to_non_nullable
as bool,isNewMember: null == isNewMember ? _self.isNewMember : isNewMember // ignore: cast_nullable_to_non_nullable
as bool,amountSpent: freezed == amountSpent ? _self.amountSpent : amountSpent // ignore: cast_nullable_to_non_nullable
as double?,memoryCount: null == memoryCount ? _self.memoryCount : memoryCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$TripDetailDestination {

 String get id; String get city; String get country; int get order; DateTime get startDate; DateTime get endDate; bool get isCurrent;
/// Create a copy of TripDetailDestination
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TripDetailDestinationCopyWith<TripDetailDestination> get copyWith => _$TripDetailDestinationCopyWithImpl<TripDetailDestination>(this as TripDetailDestination, _$identity);

  /// Serializes this TripDetailDestination to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TripDetailDestination;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TripDetailDestination&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.city, _this.city) || other.city == _this.city)&&(identical(other.country, _this.country) || other.country == _this.country)&&(identical(other.order, _this.order) || other.order == _this.order)&&(identical(other.startDate, _this.startDate) || other.startDate == _this.startDate)&&(identical(other.endDate, _this.endDate) || other.endDate == _this.endDate)&&(identical(other.isCurrent, _this.isCurrent) || other.isCurrent == _this.isCurrent));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TripDetailDestination;
  return Object.hash(runtimeType,_this.id,_this.city,_this.country,_this.order,_this.startDate,_this.endDate,_this.isCurrent);
}

@override
String toString() {
  final _this = this as TripDetailDestination;
  return 'TripDetailDestination(id: ${_this.id}, city: ${_this.city}, country: ${_this.country}, order: ${_this.order}, startDate: ${_this.startDate}, endDate: ${_this.endDate}, isCurrent: ${_this.isCurrent})';
}


}

/// @nodoc
abstract mixin class $TripDetailDestinationCopyWith<$Res>  {
  factory $TripDetailDestinationCopyWith(TripDetailDestination value, $Res Function(TripDetailDestination) _then) = _$TripDetailDestinationCopyWithImpl;
@useResult
$Res call({
 String id, String city, String country, int order, DateTime startDate, DateTime endDate, bool isCurrent
});




}
/// @nodoc
class _$TripDetailDestinationCopyWithImpl<$Res>
    implements $TripDetailDestinationCopyWith<$Res> {
  _$TripDetailDestinationCopyWithImpl(this._self, this._then);

  final TripDetailDestination _self;
  final $Res Function(TripDetailDestination) _then;

/// Create a copy of TripDetailDestination
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? city = null,Object? country = null,Object? order = null,Object? startDate = null,Object? endDate = null,Object? isCurrent = null,}) {
  return _then(TripDetailDestination(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,country: null == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String,order: null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as int,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,endDate: null == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime,isCurrent: null == isCurrent ? _self.isCurrent : isCurrent // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [TripDetailDestination].
extension TripDetailDestinationPatterns on TripDetailDestination {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TripDetailDestination value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TripDetailDestination() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TripDetailDestination value)  $default,){
final _that = this;
switch (_that) {
case _TripDetailDestination():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TripDetailDestination value)?  $default,){
final _that = this;
switch (_that) {
case _TripDetailDestination() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String city,  String country,  int order,  DateTime startDate,  DateTime endDate,  bool isCurrent)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TripDetailDestination() when $default != null:
return $default(_that.id,_that.city,_that.country,_that.order,_that.startDate,_that.endDate,_that.isCurrent);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String city,  String country,  int order,  DateTime startDate,  DateTime endDate,  bool isCurrent)  $default,) {final _that = this;
switch (_that) {
case _TripDetailDestination():
return $default(_that.id,_that.city,_that.country,_that.order,_that.startDate,_that.endDate,_that.isCurrent);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String city,  String country,  int order,  DateTime startDate,  DateTime endDate,  bool isCurrent)?  $default,) {final _that = this;
switch (_that) {
case _TripDetailDestination() when $default != null:
return $default(_that.id,_that.city,_that.country,_that.order,_that.startDate,_that.endDate,_that.isCurrent);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TripDetailDestination implements TripDetailDestination {
  const _TripDetailDestination({required this.id, required this.city, required this.country, required this.order, required this.startDate, required this.endDate, this.isCurrent = false});
  factory _TripDetailDestination.fromJson(Map<String, dynamic> json) => _$TripDetailDestinationFromJson(json);

@override final  String id;
@override final  String city;
@override final  String country;
@override final  int order;
@override final  DateTime startDate;
@override final  DateTime endDate;
@override@JsonKey() final  bool isCurrent;

/// Create a copy of TripDetailDestination
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TripDetailDestinationCopyWith<_TripDetailDestination> get copyWith => __$TripDetailDestinationCopyWithImpl<_TripDetailDestination>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TripDetailDestinationToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TripDetailDestination&&(identical(other.id, id) || other.id == id)&&(identical(other.city, city) || other.city == city)&&(identical(other.country, country) || other.country == country)&&(identical(other.order, order) || other.order == order)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.isCurrent, isCurrent) || other.isCurrent == isCurrent));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,city,country,order,startDate,endDate,isCurrent);
}

@override
String toString() {
    return 'TripDetailDestination(id: $id, city: $city, country: $country, order: $order, startDate: $startDate, endDate: $endDate, isCurrent: $isCurrent)';
}


}

/// @nodoc
abstract mixin class _$TripDetailDestinationCopyWith<$Res> implements $TripDetailDestinationCopyWith<$Res> {
  factory _$TripDetailDestinationCopyWith(_TripDetailDestination value, $Res Function(_TripDetailDestination) _then) = __$TripDetailDestinationCopyWithImpl;
@override @useResult
$Res call({
 String id, String city, String country, int order, DateTime startDate, DateTime endDate, bool isCurrent
});




}
/// @nodoc
class __$TripDetailDestinationCopyWithImpl<$Res>
    implements _$TripDetailDestinationCopyWith<$Res> {
  __$TripDetailDestinationCopyWithImpl(this._self, this._then);

  final _TripDetailDestination _self;
  final $Res Function(_TripDetailDestination) _then;

/// Create a copy of TripDetailDestination
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? city = null,Object? country = null,Object? order = null,Object? startDate = null,Object? endDate = null,Object? isCurrent = null,}) {
  return _then(_TripDetailDestination(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,country: null == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String,order: null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as int,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,endDate: null == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime,isCurrent: null == isCurrent ? _self.isCurrent : isCurrent // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$TripDetailNextActivity {

 String get id; String get title; String? get description; DateTime get startTime;/// Active members already checked in at the activity's place.
 int get confirmedCount; int get totalCount;
/// Create a copy of TripDetailNextActivity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TripDetailNextActivityCopyWith<TripDetailNextActivity> get copyWith => _$TripDetailNextActivityCopyWithImpl<TripDetailNextActivity>(this as TripDetailNextActivity, _$identity);

  /// Serializes this TripDetailNextActivity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TripDetailNextActivity;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TripDetailNextActivity&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.startTime, _this.startTime) || other.startTime == _this.startTime)&&(identical(other.confirmedCount, _this.confirmedCount) || other.confirmedCount == _this.confirmedCount)&&(identical(other.totalCount, _this.totalCount) || other.totalCount == _this.totalCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TripDetailNextActivity;
  return Object.hash(runtimeType,_this.id,_this.title,_this.description,_this.startTime,_this.confirmedCount,_this.totalCount);
}

@override
String toString() {
  final _this = this as TripDetailNextActivity;
  return 'TripDetailNextActivity(id: ${_this.id}, title: ${_this.title}, description: ${_this.description}, startTime: ${_this.startTime}, confirmedCount: ${_this.confirmedCount}, totalCount: ${_this.totalCount})';
}


}

/// @nodoc
abstract mixin class $TripDetailNextActivityCopyWith<$Res>  {
  factory $TripDetailNextActivityCopyWith(TripDetailNextActivity value, $Res Function(TripDetailNextActivity) _then) = _$TripDetailNextActivityCopyWithImpl;
@useResult
$Res call({
 String id, String title, String? description, DateTime startTime, int confirmedCount, int totalCount
});




}
/// @nodoc
class _$TripDetailNextActivityCopyWithImpl<$Res>
    implements $TripDetailNextActivityCopyWith<$Res> {
  _$TripDetailNextActivityCopyWithImpl(this._self, this._then);

  final TripDetailNextActivity _self;
  final $Res Function(TripDetailNextActivity) _then;

/// Create a copy of TripDetailNextActivity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? description = freezed,Object? startTime = null,Object? confirmedCount = null,Object? totalCount = null,}) {
  return _then(TripDetailNextActivity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as DateTime,confirmedCount: null == confirmedCount ? _self.confirmedCount : confirmedCount // ignore: cast_nullable_to_non_nullable
as int,totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [TripDetailNextActivity].
extension TripDetailNextActivityPatterns on TripDetailNextActivity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TripDetailNextActivity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TripDetailNextActivity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TripDetailNextActivity value)  $default,){
final _that = this;
switch (_that) {
case _TripDetailNextActivity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TripDetailNextActivity value)?  $default,){
final _that = this;
switch (_that) {
case _TripDetailNextActivity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String? description,  DateTime startTime,  int confirmedCount,  int totalCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TripDetailNextActivity() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.startTime,_that.confirmedCount,_that.totalCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String? description,  DateTime startTime,  int confirmedCount,  int totalCount)  $default,) {final _that = this;
switch (_that) {
case _TripDetailNextActivity():
return $default(_that.id,_that.title,_that.description,_that.startTime,_that.confirmedCount,_that.totalCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String? description,  DateTime startTime,  int confirmedCount,  int totalCount)?  $default,) {final _that = this;
switch (_that) {
case _TripDetailNextActivity() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.startTime,_that.confirmedCount,_that.totalCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TripDetailNextActivity implements TripDetailNextActivity {
  const _TripDetailNextActivity({required this.id, required this.title, this.description, required this.startTime, this.confirmedCount = 0, this.totalCount = 0});
  factory _TripDetailNextActivity.fromJson(Map<String, dynamic> json) => _$TripDetailNextActivityFromJson(json);

@override final  String id;
@override final  String title;
@override final  String? description;
@override final  DateTime startTime;
/// Active members already checked in at the activity's place.
@override@JsonKey() final  int confirmedCount;
@override@JsonKey() final  int totalCount;

/// Create a copy of TripDetailNextActivity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TripDetailNextActivityCopyWith<_TripDetailNextActivity> get copyWith => __$TripDetailNextActivityCopyWithImpl<_TripDetailNextActivity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TripDetailNextActivityToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TripDetailNextActivity&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.confirmedCount, confirmedCount) || other.confirmedCount == confirmedCount)&&(identical(other.totalCount, totalCount) || other.totalCount == totalCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,title,description,startTime,confirmedCount,totalCount);
}

@override
String toString() {
    return 'TripDetailNextActivity(id: $id, title: $title, description: $description, startTime: $startTime, confirmedCount: $confirmedCount, totalCount: $totalCount)';
}


}

/// @nodoc
abstract mixin class _$TripDetailNextActivityCopyWith<$Res> implements $TripDetailNextActivityCopyWith<$Res> {
  factory _$TripDetailNextActivityCopyWith(_TripDetailNextActivity value, $Res Function(_TripDetailNextActivity) _then) = __$TripDetailNextActivityCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String? description, DateTime startTime, int confirmedCount, int totalCount
});




}
/// @nodoc
class __$TripDetailNextActivityCopyWithImpl<$Res>
    implements _$TripDetailNextActivityCopyWith<$Res> {
  __$TripDetailNextActivityCopyWithImpl(this._self, this._then);

  final _TripDetailNextActivity _self;
  final $Res Function(_TripDetailNextActivity) _then;

/// Create a copy of TripDetailNextActivity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? description = freezed,Object? startTime = null,Object? confirmedCount = null,Object? totalCount = null,}) {
  return _then(_TripDetailNextActivity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as DateTime,confirmedCount: null == confirmedCount ? _self.confirmedCount : confirmedCount // ignore: cast_nullable_to_non_nullable
as int,totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$TripDetailMemoriesPreview {

 int get totalCount; List<TripDetailMemory> get items;
/// Create a copy of TripDetailMemoriesPreview
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TripDetailMemoriesPreviewCopyWith<TripDetailMemoriesPreview> get copyWith => _$TripDetailMemoriesPreviewCopyWithImpl<TripDetailMemoriesPreview>(this as TripDetailMemoriesPreview, _$identity);

  /// Serializes this TripDetailMemoriesPreview to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TripDetailMemoriesPreview;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TripDetailMemoriesPreview&&(identical(other.totalCount, _this.totalCount) || other.totalCount == _this.totalCount)&&const DeepCollectionEquality().equals(other.items, _this.items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TripDetailMemoriesPreview;
  return Object.hash(runtimeType,_this.totalCount,const DeepCollectionEquality().hash(_this.items));
}

@override
String toString() {
  final _this = this as TripDetailMemoriesPreview;
  return 'TripDetailMemoriesPreview(totalCount: ${_this.totalCount}, items: ${_this.items})';
}


}

/// @nodoc
abstract mixin class $TripDetailMemoriesPreviewCopyWith<$Res>  {
  factory $TripDetailMemoriesPreviewCopyWith(TripDetailMemoriesPreview value, $Res Function(TripDetailMemoriesPreview) _then) = _$TripDetailMemoriesPreviewCopyWithImpl;
@useResult
$Res call({
 int totalCount, List<TripDetailMemory> items
});




}
/// @nodoc
class _$TripDetailMemoriesPreviewCopyWithImpl<$Res>
    implements $TripDetailMemoriesPreviewCopyWith<$Res> {
  _$TripDetailMemoriesPreviewCopyWithImpl(this._self, this._then);

  final TripDetailMemoriesPreview _self;
  final $Res Function(TripDetailMemoriesPreview) _then;

/// Create a copy of TripDetailMemoriesPreview
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalCount = null,Object? items = null,}) {
  return _then(TripDetailMemoriesPreview(
totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<TripDetailMemory>,
  ));
}

}


/// Adds pattern-matching-related methods to [TripDetailMemoriesPreview].
extension TripDetailMemoriesPreviewPatterns on TripDetailMemoriesPreview {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TripDetailMemoriesPreview value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TripDetailMemoriesPreview() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TripDetailMemoriesPreview value)  $default,){
final _that = this;
switch (_that) {
case _TripDetailMemoriesPreview():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TripDetailMemoriesPreview value)?  $default,){
final _that = this;
switch (_that) {
case _TripDetailMemoriesPreview() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int totalCount,  List<TripDetailMemory> items)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TripDetailMemoriesPreview() when $default != null:
return $default(_that.totalCount,_that.items);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int totalCount,  List<TripDetailMemory> items)  $default,) {final _that = this;
switch (_that) {
case _TripDetailMemoriesPreview():
return $default(_that.totalCount,_that.items);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int totalCount,  List<TripDetailMemory> items)?  $default,) {final _that = this;
switch (_that) {
case _TripDetailMemoriesPreview() when $default != null:
return $default(_that.totalCount,_that.items);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TripDetailMemoriesPreview implements TripDetailMemoriesPreview {
  const _TripDetailMemoriesPreview({required this.totalCount,  List<TripDetailMemory> items = const <TripDetailMemory>[]}): _items = items;
  factory _TripDetailMemoriesPreview.fromJson(Map<String, dynamic> json) => _$TripDetailMemoriesPreviewFromJson(json);

@override final  int totalCount;
 final  List<TripDetailMemory> _items;
@override@JsonKey() List<TripDetailMemory> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}


/// Create a copy of TripDetailMemoriesPreview
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TripDetailMemoriesPreviewCopyWith<_TripDetailMemoriesPreview> get copyWith => __$TripDetailMemoriesPreviewCopyWithImpl<_TripDetailMemoriesPreview>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TripDetailMemoriesPreviewToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TripDetailMemoriesPreview&&(identical(other.totalCount, totalCount) || other.totalCount == totalCount)&&const DeepCollectionEquality().equals(other.items, _items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,totalCount,const DeepCollectionEquality().hash(_items));
}

@override
String toString() {
    return 'TripDetailMemoriesPreview(totalCount: $totalCount, items: $items)';
}


}

/// @nodoc
abstract mixin class _$TripDetailMemoriesPreviewCopyWith<$Res> implements $TripDetailMemoriesPreviewCopyWith<$Res> {
  factory _$TripDetailMemoriesPreviewCopyWith(_TripDetailMemoriesPreview value, $Res Function(_TripDetailMemoriesPreview) _then) = __$TripDetailMemoriesPreviewCopyWithImpl;
@override @useResult
$Res call({
 int totalCount, List<TripDetailMemory> items
});




}
/// @nodoc
class __$TripDetailMemoriesPreviewCopyWithImpl<$Res>
    implements _$TripDetailMemoriesPreviewCopyWith<$Res> {
  __$TripDetailMemoriesPreviewCopyWithImpl(this._self, this._then);

  final _TripDetailMemoriesPreview _self;
  final $Res Function(_TripDetailMemoriesPreview) _then;

/// Create a copy of TripDetailMemoriesPreview
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalCount = null,Object? items = null,}) {
  return _then(_TripDetailMemoriesPreview(
totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<TripDetailMemory>,
  ));
}


}


/// @nodoc
mixin _$TripDetailMemory {

 String get id; String get imageUrl; String? get caption;/// Null when the uploader deleted their account.
 String? get authorName;
/// Create a copy of TripDetailMemory
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TripDetailMemoryCopyWith<TripDetailMemory> get copyWith => _$TripDetailMemoryCopyWithImpl<TripDetailMemory>(this as TripDetailMemory, _$identity);

  /// Serializes this TripDetailMemory to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TripDetailMemory;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TripDetailMemory&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.imageUrl, _this.imageUrl) || other.imageUrl == _this.imageUrl)&&(identical(other.caption, _this.caption) || other.caption == _this.caption)&&(identical(other.authorName, _this.authorName) || other.authorName == _this.authorName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TripDetailMemory;
  return Object.hash(runtimeType,_this.id,_this.imageUrl,_this.caption,_this.authorName);
}

@override
String toString() {
  final _this = this as TripDetailMemory;
  return 'TripDetailMemory(id: ${_this.id}, imageUrl: ${_this.imageUrl}, caption: ${_this.caption}, authorName: ${_this.authorName})';
}


}

/// @nodoc
abstract mixin class $TripDetailMemoryCopyWith<$Res>  {
  factory $TripDetailMemoryCopyWith(TripDetailMemory value, $Res Function(TripDetailMemory) _then) = _$TripDetailMemoryCopyWithImpl;
@useResult
$Res call({
 String id, String imageUrl, String? caption, String? authorName
});




}
/// @nodoc
class _$TripDetailMemoryCopyWithImpl<$Res>
    implements $TripDetailMemoryCopyWith<$Res> {
  _$TripDetailMemoryCopyWithImpl(this._self, this._then);

  final TripDetailMemory _self;
  final $Res Function(TripDetailMemory) _then;

/// Create a copy of TripDetailMemory
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? imageUrl = null,Object? caption = freezed,Object? authorName = freezed,}) {
  return _then(TripDetailMemory(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,caption: freezed == caption ? _self.caption : caption // ignore: cast_nullable_to_non_nullable
as String?,authorName: freezed == authorName ? _self.authorName : authorName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TripDetailMemory].
extension TripDetailMemoryPatterns on TripDetailMemory {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TripDetailMemory value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TripDetailMemory() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TripDetailMemory value)  $default,){
final _that = this;
switch (_that) {
case _TripDetailMemory():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TripDetailMemory value)?  $default,){
final _that = this;
switch (_that) {
case _TripDetailMemory() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String imageUrl,  String? caption,  String? authorName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TripDetailMemory() when $default != null:
return $default(_that.id,_that.imageUrl,_that.caption,_that.authorName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String imageUrl,  String? caption,  String? authorName)  $default,) {final _that = this;
switch (_that) {
case _TripDetailMemory():
return $default(_that.id,_that.imageUrl,_that.caption,_that.authorName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String imageUrl,  String? caption,  String? authorName)?  $default,) {final _that = this;
switch (_that) {
case _TripDetailMemory() when $default != null:
return $default(_that.id,_that.imageUrl,_that.caption,_that.authorName);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TripDetailMemory implements TripDetailMemory {
  const _TripDetailMemory({required this.id, required this.imageUrl, this.caption, this.authorName});
  factory _TripDetailMemory.fromJson(Map<String, dynamic> json) => _$TripDetailMemoryFromJson(json);

@override final  String id;
@override final  String imageUrl;
@override final  String? caption;
/// Null when the uploader deleted their account.
@override final  String? authorName;

/// Create a copy of TripDetailMemory
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TripDetailMemoryCopyWith<_TripDetailMemory> get copyWith => __$TripDetailMemoryCopyWithImpl<_TripDetailMemory>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TripDetailMemoryToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TripDetailMemory&&(identical(other.id, id) || other.id == id)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.caption, caption) || other.caption == caption)&&(identical(other.authorName, authorName) || other.authorName == authorName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,imageUrl,caption,authorName);
}

@override
String toString() {
    return 'TripDetailMemory(id: $id, imageUrl: $imageUrl, caption: $caption, authorName: $authorName)';
}


}

/// @nodoc
abstract mixin class _$TripDetailMemoryCopyWith<$Res> implements $TripDetailMemoryCopyWith<$Res> {
  factory _$TripDetailMemoryCopyWith(_TripDetailMemory value, $Res Function(_TripDetailMemory) _then) = __$TripDetailMemoryCopyWithImpl;
@override @useResult
$Res call({
 String id, String imageUrl, String? caption, String? authorName
});




}
/// @nodoc
class __$TripDetailMemoryCopyWithImpl<$Res>
    implements _$TripDetailMemoryCopyWith<$Res> {
  __$TripDetailMemoryCopyWithImpl(this._self, this._then);

  final _TripDetailMemory _self;
  final $Res Function(_TripDetailMemory) _then;

/// Create a copy of TripDetailMemory
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? imageUrl = null,Object? caption = freezed,Object? authorName = freezed,}) {
  return _then(_TripDetailMemory(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,caption: freezed == caption ? _self.caption : caption // ignore: cast_nullable_to_non_nullable
as String?,authorName: freezed == authorName ? _self.authorName : authorName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$TripDetailCompletionReward {

 int get points; bool get canClaim; bool get claimed;
/// Create a copy of TripDetailCompletionReward
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TripDetailCompletionRewardCopyWith<TripDetailCompletionReward> get copyWith => _$TripDetailCompletionRewardCopyWithImpl<TripDetailCompletionReward>(this as TripDetailCompletionReward, _$identity);

  /// Serializes this TripDetailCompletionReward to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TripDetailCompletionReward;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TripDetailCompletionReward&&(identical(other.points, _this.points) || other.points == _this.points)&&(identical(other.canClaim, _this.canClaim) || other.canClaim == _this.canClaim)&&(identical(other.claimed, _this.claimed) || other.claimed == _this.claimed));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TripDetailCompletionReward;
  return Object.hash(runtimeType,_this.points,_this.canClaim,_this.claimed);
}

@override
String toString() {
  final _this = this as TripDetailCompletionReward;
  return 'TripDetailCompletionReward(points: ${_this.points}, canClaim: ${_this.canClaim}, claimed: ${_this.claimed})';
}


}

/// @nodoc
abstract mixin class $TripDetailCompletionRewardCopyWith<$Res>  {
  factory $TripDetailCompletionRewardCopyWith(TripDetailCompletionReward value, $Res Function(TripDetailCompletionReward) _then) = _$TripDetailCompletionRewardCopyWithImpl;
@useResult
$Res call({
 int points, bool canClaim, bool claimed
});




}
/// @nodoc
class _$TripDetailCompletionRewardCopyWithImpl<$Res>
    implements $TripDetailCompletionRewardCopyWith<$Res> {
  _$TripDetailCompletionRewardCopyWithImpl(this._self, this._then);

  final TripDetailCompletionReward _self;
  final $Res Function(TripDetailCompletionReward) _then;

/// Create a copy of TripDetailCompletionReward
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? points = null,Object? canClaim = null,Object? claimed = null,}) {
  return _then(TripDetailCompletionReward(
points: null == points ? _self.points : points // ignore: cast_nullable_to_non_nullable
as int,canClaim: null == canClaim ? _self.canClaim : canClaim // ignore: cast_nullable_to_non_nullable
as bool,claimed: null == claimed ? _self.claimed : claimed // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [TripDetailCompletionReward].
extension TripDetailCompletionRewardPatterns on TripDetailCompletionReward {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TripDetailCompletionReward value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TripDetailCompletionReward() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TripDetailCompletionReward value)  $default,){
final _that = this;
switch (_that) {
case _TripDetailCompletionReward():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TripDetailCompletionReward value)?  $default,){
final _that = this;
switch (_that) {
case _TripDetailCompletionReward() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int points,  bool canClaim,  bool claimed)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TripDetailCompletionReward() when $default != null:
return $default(_that.points,_that.canClaim,_that.claimed);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int points,  bool canClaim,  bool claimed)  $default,) {final _that = this;
switch (_that) {
case _TripDetailCompletionReward():
return $default(_that.points,_that.canClaim,_that.claimed);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int points,  bool canClaim,  bool claimed)?  $default,) {final _that = this;
switch (_that) {
case _TripDetailCompletionReward() when $default != null:
return $default(_that.points,_that.canClaim,_that.claimed);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TripDetailCompletionReward implements TripDetailCompletionReward {
  const _TripDetailCompletionReward({required this.points, this.canClaim = false, this.claimed = false});
  factory _TripDetailCompletionReward.fromJson(Map<String, dynamic> json) => _$TripDetailCompletionRewardFromJson(json);

@override final  int points;
@override@JsonKey() final  bool canClaim;
@override@JsonKey() final  bool claimed;

/// Create a copy of TripDetailCompletionReward
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TripDetailCompletionRewardCopyWith<_TripDetailCompletionReward> get copyWith => __$TripDetailCompletionRewardCopyWithImpl<_TripDetailCompletionReward>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TripDetailCompletionRewardToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TripDetailCompletionReward&&(identical(other.points, points) || other.points == points)&&(identical(other.canClaim, canClaim) || other.canClaim == canClaim)&&(identical(other.claimed, claimed) || other.claimed == claimed));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,points,canClaim,claimed);
}

@override
String toString() {
    return 'TripDetailCompletionReward(points: $points, canClaim: $canClaim, claimed: $claimed)';
}


}

/// @nodoc
abstract mixin class _$TripDetailCompletionRewardCopyWith<$Res> implements $TripDetailCompletionRewardCopyWith<$Res> {
  factory _$TripDetailCompletionRewardCopyWith(_TripDetailCompletionReward value, $Res Function(_TripDetailCompletionReward) _then) = __$TripDetailCompletionRewardCopyWithImpl;
@override @useResult
$Res call({
 int points, bool canClaim, bool claimed
});




}
/// @nodoc
class __$TripDetailCompletionRewardCopyWithImpl<$Res>
    implements _$TripDetailCompletionRewardCopyWith<$Res> {
  __$TripDetailCompletionRewardCopyWithImpl(this._self, this._then);

  final _TripDetailCompletionReward _self;
  final $Res Function(_TripDetailCompletionReward) _then;

/// Create a copy of TripDetailCompletionReward
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? points = null,Object? canClaim = null,Object? claimed = null,}) {
  return _then(_TripDetailCompletionReward(
points: null == points ? _self.points : points // ignore: cast_nullable_to_non_nullable
as int,canClaim: null == canClaim ? _self.canClaim : canClaim // ignore: cast_nullable_to_non_nullable
as bool,claimed: null == claimed ? _self.claimed : claimed // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$TripDetailTimelinePreview {

 int get totalCount; List<TripDetailTimelineEvent> get items;
/// Create a copy of TripDetailTimelinePreview
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TripDetailTimelinePreviewCopyWith<TripDetailTimelinePreview> get copyWith => _$TripDetailTimelinePreviewCopyWithImpl<TripDetailTimelinePreview>(this as TripDetailTimelinePreview, _$identity);

  /// Serializes this TripDetailTimelinePreview to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TripDetailTimelinePreview;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TripDetailTimelinePreview&&(identical(other.totalCount, _this.totalCount) || other.totalCount == _this.totalCount)&&const DeepCollectionEquality().equals(other.items, _this.items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TripDetailTimelinePreview;
  return Object.hash(runtimeType,_this.totalCount,const DeepCollectionEquality().hash(_this.items));
}

@override
String toString() {
  final _this = this as TripDetailTimelinePreview;
  return 'TripDetailTimelinePreview(totalCount: ${_this.totalCount}, items: ${_this.items})';
}


}

/// @nodoc
abstract mixin class $TripDetailTimelinePreviewCopyWith<$Res>  {
  factory $TripDetailTimelinePreviewCopyWith(TripDetailTimelinePreview value, $Res Function(TripDetailTimelinePreview) _then) = _$TripDetailTimelinePreviewCopyWithImpl;
@useResult
$Res call({
 int totalCount, List<TripDetailTimelineEvent> items
});




}
/// @nodoc
class _$TripDetailTimelinePreviewCopyWithImpl<$Res>
    implements $TripDetailTimelinePreviewCopyWith<$Res> {
  _$TripDetailTimelinePreviewCopyWithImpl(this._self, this._then);

  final TripDetailTimelinePreview _self;
  final $Res Function(TripDetailTimelinePreview) _then;

/// Create a copy of TripDetailTimelinePreview
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalCount = null,Object? items = null,}) {
  return _then(TripDetailTimelinePreview(
totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<TripDetailTimelineEvent>,
  ));
}

}


/// Adds pattern-matching-related methods to [TripDetailTimelinePreview].
extension TripDetailTimelinePreviewPatterns on TripDetailTimelinePreview {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TripDetailTimelinePreview value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TripDetailTimelinePreview() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TripDetailTimelinePreview value)  $default,){
final _that = this;
switch (_that) {
case _TripDetailTimelinePreview():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TripDetailTimelinePreview value)?  $default,){
final _that = this;
switch (_that) {
case _TripDetailTimelinePreview() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int totalCount,  List<TripDetailTimelineEvent> items)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TripDetailTimelinePreview() when $default != null:
return $default(_that.totalCount,_that.items);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int totalCount,  List<TripDetailTimelineEvent> items)  $default,) {final _that = this;
switch (_that) {
case _TripDetailTimelinePreview():
return $default(_that.totalCount,_that.items);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int totalCount,  List<TripDetailTimelineEvent> items)?  $default,) {final _that = this;
switch (_that) {
case _TripDetailTimelinePreview() when $default != null:
return $default(_that.totalCount,_that.items);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TripDetailTimelinePreview implements TripDetailTimelinePreview {
  const _TripDetailTimelinePreview({required this.totalCount,  List<TripDetailTimelineEvent> items = const <TripDetailTimelineEvent>[]}): _items = items;
  factory _TripDetailTimelinePreview.fromJson(Map<String, dynamic> json) => _$TripDetailTimelinePreviewFromJson(json);

@override final  int totalCount;
 final  List<TripDetailTimelineEvent> _items;
@override@JsonKey() List<TripDetailTimelineEvent> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}


/// Create a copy of TripDetailTimelinePreview
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TripDetailTimelinePreviewCopyWith<_TripDetailTimelinePreview> get copyWith => __$TripDetailTimelinePreviewCopyWithImpl<_TripDetailTimelinePreview>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TripDetailTimelinePreviewToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TripDetailTimelinePreview&&(identical(other.totalCount, totalCount) || other.totalCount == totalCount)&&const DeepCollectionEquality().equals(other.items, _items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,totalCount,const DeepCollectionEquality().hash(_items));
}

@override
String toString() {
    return 'TripDetailTimelinePreview(totalCount: $totalCount, items: $items)';
}


}

/// @nodoc
abstract mixin class _$TripDetailTimelinePreviewCopyWith<$Res> implements $TripDetailTimelinePreviewCopyWith<$Res> {
  factory _$TripDetailTimelinePreviewCopyWith(_TripDetailTimelinePreview value, $Res Function(_TripDetailTimelinePreview) _then) = __$TripDetailTimelinePreviewCopyWithImpl;
@override @useResult
$Res call({
 int totalCount, List<TripDetailTimelineEvent> items
});




}
/// @nodoc
class __$TripDetailTimelinePreviewCopyWithImpl<$Res>
    implements _$TripDetailTimelinePreviewCopyWith<$Res> {
  __$TripDetailTimelinePreviewCopyWithImpl(this._self, this._then);

  final _TripDetailTimelinePreview _self;
  final $Res Function(_TripDetailTimelinePreview) _then;

/// Create a copy of TripDetailTimelinePreview
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalCount = null,Object? items = null,}) {
  return _then(_TripDetailTimelinePreview(
totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<TripDetailTimelineEvent>,
  ));
}


}


/// @nodoc
mixin _$TripDetailTimelineEvent {

 String get id;@JsonKey(unknownEnumValue: TripDetailEventType.system) TripDetailEventType get type; String get actorName; String? get actorAvatarUrl; String get content; DateTime get createdAt;
/// Create a copy of TripDetailTimelineEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TripDetailTimelineEventCopyWith<TripDetailTimelineEvent> get copyWith => _$TripDetailTimelineEventCopyWithImpl<TripDetailTimelineEvent>(this as TripDetailTimelineEvent, _$identity);

  /// Serializes this TripDetailTimelineEvent to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TripDetailTimelineEvent;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TripDetailTimelineEvent&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.type, _this.type) || other.type == _this.type)&&(identical(other.actorName, _this.actorName) || other.actorName == _this.actorName)&&(identical(other.actorAvatarUrl, _this.actorAvatarUrl) || other.actorAvatarUrl == _this.actorAvatarUrl)&&(identical(other.content, _this.content) || other.content == _this.content)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TripDetailTimelineEvent;
  return Object.hash(runtimeType,_this.id,_this.type,_this.actorName,_this.actorAvatarUrl,_this.content,_this.createdAt);
}

@override
String toString() {
  final _this = this as TripDetailTimelineEvent;
  return 'TripDetailTimelineEvent(id: ${_this.id}, type: ${_this.type}, actorName: ${_this.actorName}, actorAvatarUrl: ${_this.actorAvatarUrl}, content: ${_this.content}, createdAt: ${_this.createdAt})';
}


}

/// @nodoc
abstract mixin class $TripDetailTimelineEventCopyWith<$Res>  {
  factory $TripDetailTimelineEventCopyWith(TripDetailTimelineEvent value, $Res Function(TripDetailTimelineEvent) _then) = _$TripDetailTimelineEventCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(unknownEnumValue: TripDetailEventType.system) TripDetailEventType type, String actorName, String? actorAvatarUrl, String content, DateTime createdAt
});




}
/// @nodoc
class _$TripDetailTimelineEventCopyWithImpl<$Res>
    implements $TripDetailTimelineEventCopyWith<$Res> {
  _$TripDetailTimelineEventCopyWithImpl(this._self, this._then);

  final TripDetailTimelineEvent _self;
  final $Res Function(TripDetailTimelineEvent) _then;

/// Create a copy of TripDetailTimelineEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? type = null,Object? actorName = null,Object? actorAvatarUrl = freezed,Object? content = null,Object? createdAt = null,}) {
  return _then(TripDetailTimelineEvent(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as TripDetailEventType,actorName: null == actorName ? _self.actorName : actorName // ignore: cast_nullable_to_non_nullable
as String,actorAvatarUrl: freezed == actorAvatarUrl ? _self.actorAvatarUrl : actorAvatarUrl // ignore: cast_nullable_to_non_nullable
as String?,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [TripDetailTimelineEvent].
extension TripDetailTimelineEventPatterns on TripDetailTimelineEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TripDetailTimelineEvent value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TripDetailTimelineEvent() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TripDetailTimelineEvent value)  $default,){
final _that = this;
switch (_that) {
case _TripDetailTimelineEvent():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TripDetailTimelineEvent value)?  $default,){
final _that = this;
switch (_that) {
case _TripDetailTimelineEvent() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(unknownEnumValue: TripDetailEventType.system)  TripDetailEventType type,  String actorName,  String? actorAvatarUrl,  String content,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TripDetailTimelineEvent() when $default != null:
return $default(_that.id,_that.type,_that.actorName,_that.actorAvatarUrl,_that.content,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(unknownEnumValue: TripDetailEventType.system)  TripDetailEventType type,  String actorName,  String? actorAvatarUrl,  String content,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _TripDetailTimelineEvent():
return $default(_that.id,_that.type,_that.actorName,_that.actorAvatarUrl,_that.content,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(unknownEnumValue: TripDetailEventType.system)  TripDetailEventType type,  String actorName,  String? actorAvatarUrl,  String content,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _TripDetailTimelineEvent() when $default != null:
return $default(_that.id,_that.type,_that.actorName,_that.actorAvatarUrl,_that.content,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TripDetailTimelineEvent implements TripDetailTimelineEvent {
  const _TripDetailTimelineEvent({required this.id, @JsonKey(unknownEnumValue: TripDetailEventType.system) required this.type, required this.actorName, this.actorAvatarUrl, required this.content, required this.createdAt});
  factory _TripDetailTimelineEvent.fromJson(Map<String, dynamic> json) => _$TripDetailTimelineEventFromJson(json);

@override final  String id;
@override@JsonKey(unknownEnumValue: TripDetailEventType.system) final  TripDetailEventType type;
@override final  String actorName;
@override final  String? actorAvatarUrl;
@override final  String content;
@override final  DateTime createdAt;

/// Create a copy of TripDetailTimelineEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TripDetailTimelineEventCopyWith<_TripDetailTimelineEvent> get copyWith => __$TripDetailTimelineEventCopyWithImpl<_TripDetailTimelineEvent>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TripDetailTimelineEventToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TripDetailTimelineEvent&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.actorName, actorName) || other.actorName == actorName)&&(identical(other.actorAvatarUrl, actorAvatarUrl) || other.actorAvatarUrl == actorAvatarUrl)&&(identical(other.content, content) || other.content == content)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,type,actorName,actorAvatarUrl,content,createdAt);
}

@override
String toString() {
    return 'TripDetailTimelineEvent(id: $id, type: $type, actorName: $actorName, actorAvatarUrl: $actorAvatarUrl, content: $content, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$TripDetailTimelineEventCopyWith<$Res> implements $TripDetailTimelineEventCopyWith<$Res> {
  factory _$TripDetailTimelineEventCopyWith(_TripDetailTimelineEvent value, $Res Function(_TripDetailTimelineEvent) _then) = __$TripDetailTimelineEventCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(unknownEnumValue: TripDetailEventType.system) TripDetailEventType type, String actorName, String? actorAvatarUrl, String content, DateTime createdAt
});




}
/// @nodoc
class __$TripDetailTimelineEventCopyWithImpl<$Res>
    implements _$TripDetailTimelineEventCopyWith<$Res> {
  __$TripDetailTimelineEventCopyWithImpl(this._self, this._then);

  final _TripDetailTimelineEvent _self;
  final $Res Function(_TripDetailTimelineEvent) _then;

/// Create a copy of TripDetailTimelineEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? type = null,Object? actorName = null,Object? actorAvatarUrl = freezed,Object? content = null,Object? createdAt = null,}) {
  return _then(_TripDetailTimelineEvent(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as TripDetailEventType,actorName: null == actorName ? _self.actorName : actorName // ignore: cast_nullable_to_non_nullable
as String,actorAvatarUrl: freezed == actorAvatarUrl ? _self.actorAvatarUrl : actorAvatarUrl // ignore: cast_nullable_to_non_nullable
as String?,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}


/// @nodoc
mixin _$TripDetailRewardClaim {

 String? get tripId; int get pointsAwarded; int get basePoints; int get missionPoints; double get multiplierUsed; int get missionsCompleted; int get totalCheckins; int get totalPlaces; int get completionPercent;
/// Create a copy of TripDetailRewardClaim
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TripDetailRewardClaimCopyWith<TripDetailRewardClaim> get copyWith => _$TripDetailRewardClaimCopyWithImpl<TripDetailRewardClaim>(this as TripDetailRewardClaim, _$identity);

  /// Serializes this TripDetailRewardClaim to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TripDetailRewardClaim;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TripDetailRewardClaim&&(identical(other.tripId, _this.tripId) || other.tripId == _this.tripId)&&(identical(other.pointsAwarded, _this.pointsAwarded) || other.pointsAwarded == _this.pointsAwarded)&&(identical(other.basePoints, _this.basePoints) || other.basePoints == _this.basePoints)&&(identical(other.missionPoints, _this.missionPoints) || other.missionPoints == _this.missionPoints)&&(identical(other.multiplierUsed, _this.multiplierUsed) || other.multiplierUsed == _this.multiplierUsed)&&(identical(other.missionsCompleted, _this.missionsCompleted) || other.missionsCompleted == _this.missionsCompleted)&&(identical(other.totalCheckins, _this.totalCheckins) || other.totalCheckins == _this.totalCheckins)&&(identical(other.totalPlaces, _this.totalPlaces) || other.totalPlaces == _this.totalPlaces)&&(identical(other.completionPercent, _this.completionPercent) || other.completionPercent == _this.completionPercent));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TripDetailRewardClaim;
  return Object.hash(runtimeType,_this.tripId,_this.pointsAwarded,_this.basePoints,_this.missionPoints,_this.multiplierUsed,_this.missionsCompleted,_this.totalCheckins,_this.totalPlaces,_this.completionPercent);
}

@override
String toString() {
  final _this = this as TripDetailRewardClaim;
  return 'TripDetailRewardClaim(tripId: ${_this.tripId}, pointsAwarded: ${_this.pointsAwarded}, basePoints: ${_this.basePoints}, missionPoints: ${_this.missionPoints}, multiplierUsed: ${_this.multiplierUsed}, missionsCompleted: ${_this.missionsCompleted}, totalCheckins: ${_this.totalCheckins}, totalPlaces: ${_this.totalPlaces}, completionPercent: ${_this.completionPercent})';
}


}

/// @nodoc
abstract mixin class $TripDetailRewardClaimCopyWith<$Res>  {
  factory $TripDetailRewardClaimCopyWith(TripDetailRewardClaim value, $Res Function(TripDetailRewardClaim) _then) = _$TripDetailRewardClaimCopyWithImpl;
@useResult
$Res call({
 String? tripId, int pointsAwarded, int basePoints, int missionPoints, double multiplierUsed, int missionsCompleted, int totalCheckins, int totalPlaces, int completionPercent
});




}
/// @nodoc
class _$TripDetailRewardClaimCopyWithImpl<$Res>
    implements $TripDetailRewardClaimCopyWith<$Res> {
  _$TripDetailRewardClaimCopyWithImpl(this._self, this._then);

  final TripDetailRewardClaim _self;
  final $Res Function(TripDetailRewardClaim) _then;

/// Create a copy of TripDetailRewardClaim
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? tripId = freezed,Object? pointsAwarded = null,Object? basePoints = null,Object? missionPoints = null,Object? multiplierUsed = null,Object? missionsCompleted = null,Object? totalCheckins = null,Object? totalPlaces = null,Object? completionPercent = null,}) {
  return _then(TripDetailRewardClaim(
tripId: freezed == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String?,pointsAwarded: null == pointsAwarded ? _self.pointsAwarded : pointsAwarded // ignore: cast_nullable_to_non_nullable
as int,basePoints: null == basePoints ? _self.basePoints : basePoints // ignore: cast_nullable_to_non_nullable
as int,missionPoints: null == missionPoints ? _self.missionPoints : missionPoints // ignore: cast_nullable_to_non_nullable
as int,multiplierUsed: null == multiplierUsed ? _self.multiplierUsed : multiplierUsed // ignore: cast_nullable_to_non_nullable
as double,missionsCompleted: null == missionsCompleted ? _self.missionsCompleted : missionsCompleted // ignore: cast_nullable_to_non_nullable
as int,totalCheckins: null == totalCheckins ? _self.totalCheckins : totalCheckins // ignore: cast_nullable_to_non_nullable
as int,totalPlaces: null == totalPlaces ? _self.totalPlaces : totalPlaces // ignore: cast_nullable_to_non_nullable
as int,completionPercent: null == completionPercent ? _self.completionPercent : completionPercent // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [TripDetailRewardClaim].
extension TripDetailRewardClaimPatterns on TripDetailRewardClaim {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TripDetailRewardClaim value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TripDetailRewardClaim() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TripDetailRewardClaim value)  $default,){
final _that = this;
switch (_that) {
case _TripDetailRewardClaim():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TripDetailRewardClaim value)?  $default,){
final _that = this;
switch (_that) {
case _TripDetailRewardClaim() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? tripId,  int pointsAwarded,  int basePoints,  int missionPoints,  double multiplierUsed,  int missionsCompleted,  int totalCheckins,  int totalPlaces,  int completionPercent)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TripDetailRewardClaim() when $default != null:
return $default(_that.tripId,_that.pointsAwarded,_that.basePoints,_that.missionPoints,_that.multiplierUsed,_that.missionsCompleted,_that.totalCheckins,_that.totalPlaces,_that.completionPercent);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? tripId,  int pointsAwarded,  int basePoints,  int missionPoints,  double multiplierUsed,  int missionsCompleted,  int totalCheckins,  int totalPlaces,  int completionPercent)  $default,) {final _that = this;
switch (_that) {
case _TripDetailRewardClaim():
return $default(_that.tripId,_that.pointsAwarded,_that.basePoints,_that.missionPoints,_that.multiplierUsed,_that.missionsCompleted,_that.totalCheckins,_that.totalPlaces,_that.completionPercent);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? tripId,  int pointsAwarded,  int basePoints,  int missionPoints,  double multiplierUsed,  int missionsCompleted,  int totalCheckins,  int totalPlaces,  int completionPercent)?  $default,) {final _that = this;
switch (_that) {
case _TripDetailRewardClaim() when $default != null:
return $default(_that.tripId,_that.pointsAwarded,_that.basePoints,_that.missionPoints,_that.multiplierUsed,_that.missionsCompleted,_that.totalCheckins,_that.totalPlaces,_that.completionPercent);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TripDetailRewardClaim implements TripDetailRewardClaim {
  const _TripDetailRewardClaim({this.tripId, required this.pointsAwarded, this.basePoints = 0, this.missionPoints = 0, this.multiplierUsed = 1.0, this.missionsCompleted = 0, this.totalCheckins = 0, this.totalPlaces = 0, this.completionPercent = 0});
  factory _TripDetailRewardClaim.fromJson(Map<String, dynamic> json) => _$TripDetailRewardClaimFromJson(json);

@override final  String? tripId;
@override final  int pointsAwarded;
@override@JsonKey() final  int basePoints;
@override@JsonKey() final  int missionPoints;
@override@JsonKey() final  double multiplierUsed;
@override@JsonKey() final  int missionsCompleted;
@override@JsonKey() final  int totalCheckins;
@override@JsonKey() final  int totalPlaces;
@override@JsonKey() final  int completionPercent;

/// Create a copy of TripDetailRewardClaim
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TripDetailRewardClaimCopyWith<_TripDetailRewardClaim> get copyWith => __$TripDetailRewardClaimCopyWithImpl<_TripDetailRewardClaim>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TripDetailRewardClaimToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TripDetailRewardClaim&&(identical(other.tripId, tripId) || other.tripId == tripId)&&(identical(other.pointsAwarded, pointsAwarded) || other.pointsAwarded == pointsAwarded)&&(identical(other.basePoints, basePoints) || other.basePoints == basePoints)&&(identical(other.missionPoints, missionPoints) || other.missionPoints == missionPoints)&&(identical(other.multiplierUsed, multiplierUsed) || other.multiplierUsed == multiplierUsed)&&(identical(other.missionsCompleted, missionsCompleted) || other.missionsCompleted == missionsCompleted)&&(identical(other.totalCheckins, totalCheckins) || other.totalCheckins == totalCheckins)&&(identical(other.totalPlaces, totalPlaces) || other.totalPlaces == totalPlaces)&&(identical(other.completionPercent, completionPercent) || other.completionPercent == completionPercent));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,tripId,pointsAwarded,basePoints,missionPoints,multiplierUsed,missionsCompleted,totalCheckins,totalPlaces,completionPercent);
}

@override
String toString() {
    return 'TripDetailRewardClaim(tripId: $tripId, pointsAwarded: $pointsAwarded, basePoints: $basePoints, missionPoints: $missionPoints, multiplierUsed: $multiplierUsed, missionsCompleted: $missionsCompleted, totalCheckins: $totalCheckins, totalPlaces: $totalPlaces, completionPercent: $completionPercent)';
}


}

/// @nodoc
abstract mixin class _$TripDetailRewardClaimCopyWith<$Res> implements $TripDetailRewardClaimCopyWith<$Res> {
  factory _$TripDetailRewardClaimCopyWith(_TripDetailRewardClaim value, $Res Function(_TripDetailRewardClaim) _then) = __$TripDetailRewardClaimCopyWithImpl;
@override @useResult
$Res call({
 String? tripId, int pointsAwarded, int basePoints, int missionPoints, double multiplierUsed, int missionsCompleted, int totalCheckins, int totalPlaces, int completionPercent
});




}
/// @nodoc
class __$TripDetailRewardClaimCopyWithImpl<$Res>
    implements _$TripDetailRewardClaimCopyWith<$Res> {
  __$TripDetailRewardClaimCopyWithImpl(this._self, this._then);

  final _TripDetailRewardClaim _self;
  final $Res Function(_TripDetailRewardClaim) _then;

/// Create a copy of TripDetailRewardClaim
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? tripId = freezed,Object? pointsAwarded = null,Object? basePoints = null,Object? missionPoints = null,Object? multiplierUsed = null,Object? missionsCompleted = null,Object? totalCheckins = null,Object? totalPlaces = null,Object? completionPercent = null,}) {
  return _then(_TripDetailRewardClaim(
tripId: freezed == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String?,pointsAwarded: null == pointsAwarded ? _self.pointsAwarded : pointsAwarded // ignore: cast_nullable_to_non_nullable
as int,basePoints: null == basePoints ? _self.basePoints : basePoints // ignore: cast_nullable_to_non_nullable
as int,missionPoints: null == missionPoints ? _self.missionPoints : missionPoints // ignore: cast_nullable_to_non_nullable
as int,multiplierUsed: null == multiplierUsed ? _self.multiplierUsed : multiplierUsed // ignore: cast_nullable_to_non_nullable
as double,missionsCompleted: null == missionsCompleted ? _self.missionsCompleted : missionsCompleted // ignore: cast_nullable_to_non_nullable
as int,totalCheckins: null == totalCheckins ? _self.totalCheckins : totalCheckins // ignore: cast_nullable_to_non_nullable
as int,totalPlaces: null == totalPlaces ? _self.totalPlaces : totalPlaces // ignore: cast_nullable_to_non_nullable
as int,completionPercent: null == completionPercent ? _self.completionPercent : completionPercent // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
