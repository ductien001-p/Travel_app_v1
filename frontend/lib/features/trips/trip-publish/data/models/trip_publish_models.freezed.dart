// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'trip_publish_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RecruitmentSummary {

 int get activeRecruitmentCount;
/// Create a copy of RecruitmentSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RecruitmentSummaryCopyWith<RecruitmentSummary> get copyWith => _$RecruitmentSummaryCopyWithImpl<RecruitmentSummary>(this as RecruitmentSummary, _$identity);

  /// Serializes this RecruitmentSummary to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as RecruitmentSummary;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecruitmentSummary&&(identical(other.activeRecruitmentCount, _this.activeRecruitmentCount) || other.activeRecruitmentCount == _this.activeRecruitmentCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as RecruitmentSummary;
  return Object.hash(runtimeType,_this.activeRecruitmentCount);
}

@override
String toString() {
  final _this = this as RecruitmentSummary;
  return 'RecruitmentSummary(activeRecruitmentCount: ${_this.activeRecruitmentCount})';
}


}

/// @nodoc
abstract mixin class $RecruitmentSummaryCopyWith<$Res>  {
  factory $RecruitmentSummaryCopyWith(RecruitmentSummary value, $Res Function(RecruitmentSummary) _then) = _$RecruitmentSummaryCopyWithImpl;
@useResult
$Res call({
 int activeRecruitmentCount
});




}
/// @nodoc
class _$RecruitmentSummaryCopyWithImpl<$Res>
    implements $RecruitmentSummaryCopyWith<$Res> {
  _$RecruitmentSummaryCopyWithImpl(this._self, this._then);

  final RecruitmentSummary _self;
  final $Res Function(RecruitmentSummary) _then;

/// Create a copy of RecruitmentSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? activeRecruitmentCount = null,}) {
  return _then(RecruitmentSummary(
activeRecruitmentCount: null == activeRecruitmentCount ? _self.activeRecruitmentCount : activeRecruitmentCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [RecruitmentSummary].
extension RecruitmentSummaryPatterns on RecruitmentSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RecruitmentSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RecruitmentSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RecruitmentSummary value)  $default,){
final _that = this;
switch (_that) {
case _RecruitmentSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RecruitmentSummary value)?  $default,){
final _that = this;
switch (_that) {
case _RecruitmentSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int activeRecruitmentCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RecruitmentSummary() when $default != null:
return $default(_that.activeRecruitmentCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int activeRecruitmentCount)  $default,) {final _that = this;
switch (_that) {
case _RecruitmentSummary():
return $default(_that.activeRecruitmentCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int activeRecruitmentCount)?  $default,) {final _that = this;
switch (_that) {
case _RecruitmentSummary() when $default != null:
return $default(_that.activeRecruitmentCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RecruitmentSummary implements RecruitmentSummary {
  const _RecruitmentSummary({required this.activeRecruitmentCount});
  factory _RecruitmentSummary.fromJson(Map<String, dynamic> json) => _$RecruitmentSummaryFromJson(json);

@override final  int activeRecruitmentCount;

/// Create a copy of RecruitmentSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RecruitmentSummaryCopyWith<_RecruitmentSummary> get copyWith => __$RecruitmentSummaryCopyWithImpl<_RecruitmentSummary>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RecruitmentSummaryToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _RecruitmentSummary&&(identical(other.activeRecruitmentCount, activeRecruitmentCount) || other.activeRecruitmentCount == activeRecruitmentCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,activeRecruitmentCount);
}

@override
String toString() {
    return 'RecruitmentSummary(activeRecruitmentCount: $activeRecruitmentCount)';
}


}

/// @nodoc
abstract mixin class _$RecruitmentSummaryCopyWith<$Res> implements $RecruitmentSummaryCopyWith<$Res> {
  factory _$RecruitmentSummaryCopyWith(_RecruitmentSummary value, $Res Function(_RecruitmentSummary) _then) = __$RecruitmentSummaryCopyWithImpl;
@override @useResult
$Res call({
 int activeRecruitmentCount
});




}
/// @nodoc
class __$RecruitmentSummaryCopyWithImpl<$Res>
    implements _$RecruitmentSummaryCopyWith<$Res> {
  __$RecruitmentSummaryCopyWithImpl(this._self, this._then);

  final _RecruitmentSummary _self;
  final $Res Function(_RecruitmentSummary) _then;

/// Create a copy of RecruitmentSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? activeRecruitmentCount = null,}) {
  return _then(_RecruitmentSummary(
activeRecruitmentCount: null == activeRecruitmentCount ? _self.activeRecruitmentCount : activeRecruitmentCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$PublishDraft {

 String get tripId; String get name; String? get description; String? get coverImageUrl; int? get draftStep; DateTime get startDate; DateTime get endDate; int get maxMembers; String? get budgetLevel; bool get urgent; DateTime get updatedAt;
/// Create a copy of PublishDraft
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PublishDraftCopyWith<PublishDraft> get copyWith => _$PublishDraftCopyWithImpl<PublishDraft>(this as PublishDraft, _$identity);

  /// Serializes this PublishDraft to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as PublishDraft;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PublishDraft&&(identical(other.tripId, _this.tripId) || other.tripId == _this.tripId)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.coverImageUrl, _this.coverImageUrl) || other.coverImageUrl == _this.coverImageUrl)&&(identical(other.draftStep, _this.draftStep) || other.draftStep == _this.draftStep)&&(identical(other.startDate, _this.startDate) || other.startDate == _this.startDate)&&(identical(other.endDate, _this.endDate) || other.endDate == _this.endDate)&&(identical(other.maxMembers, _this.maxMembers) || other.maxMembers == _this.maxMembers)&&(identical(other.budgetLevel, _this.budgetLevel) || other.budgetLevel == _this.budgetLevel)&&(identical(other.urgent, _this.urgent) || other.urgent == _this.urgent)&&(identical(other.updatedAt, _this.updatedAt) || other.updatedAt == _this.updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as PublishDraft;
  return Object.hash(runtimeType,_this.tripId,_this.name,_this.description,_this.coverImageUrl,_this.draftStep,_this.startDate,_this.endDate,_this.maxMembers,_this.budgetLevel,_this.urgent,_this.updatedAt);
}

@override
String toString() {
  final _this = this as PublishDraft;
  return 'PublishDraft(tripId: ${_this.tripId}, name: ${_this.name}, description: ${_this.description}, coverImageUrl: ${_this.coverImageUrl}, draftStep: ${_this.draftStep}, startDate: ${_this.startDate}, endDate: ${_this.endDate}, maxMembers: ${_this.maxMembers}, budgetLevel: ${_this.budgetLevel}, urgent: ${_this.urgent}, updatedAt: ${_this.updatedAt})';
}


}

/// @nodoc
abstract mixin class $PublishDraftCopyWith<$Res>  {
  factory $PublishDraftCopyWith(PublishDraft value, $Res Function(PublishDraft) _then) = _$PublishDraftCopyWithImpl;
@useResult
$Res call({
 String tripId, String name, String? description, String? coverImageUrl, int? draftStep, DateTime startDate, DateTime endDate, int maxMembers, String? budgetLevel, bool urgent, DateTime updatedAt
});




}
/// @nodoc
class _$PublishDraftCopyWithImpl<$Res>
    implements $PublishDraftCopyWith<$Res> {
  _$PublishDraftCopyWithImpl(this._self, this._then);

  final PublishDraft _self;
  final $Res Function(PublishDraft) _then;

/// Create a copy of PublishDraft
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? tripId = null,Object? name = null,Object? description = freezed,Object? coverImageUrl = freezed,Object? draftStep = freezed,Object? startDate = null,Object? endDate = null,Object? maxMembers = null,Object? budgetLevel = freezed,Object? urgent = null,Object? updatedAt = null,}) {
  return _then(PublishDraft(
tripId: null == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,coverImageUrl: freezed == coverImageUrl ? _self.coverImageUrl : coverImageUrl // ignore: cast_nullable_to_non_nullable
as String?,draftStep: freezed == draftStep ? _self.draftStep : draftStep // ignore: cast_nullable_to_non_nullable
as int?,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,endDate: null == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime,maxMembers: null == maxMembers ? _self.maxMembers : maxMembers // ignore: cast_nullable_to_non_nullable
as int,budgetLevel: freezed == budgetLevel ? _self.budgetLevel : budgetLevel // ignore: cast_nullable_to_non_nullable
as String?,urgent: null == urgent ? _self.urgent : urgent // ignore: cast_nullable_to_non_nullable
as bool,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [PublishDraft].
extension PublishDraftPatterns on PublishDraft {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PublishDraft value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PublishDraft() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PublishDraft value)  $default,){
final _that = this;
switch (_that) {
case _PublishDraft():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PublishDraft value)?  $default,){
final _that = this;
switch (_that) {
case _PublishDraft() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String tripId,  String name,  String? description,  String? coverImageUrl,  int? draftStep,  DateTime startDate,  DateTime endDate,  int maxMembers,  String? budgetLevel,  bool urgent,  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PublishDraft() when $default != null:
return $default(_that.tripId,_that.name,_that.description,_that.coverImageUrl,_that.draftStep,_that.startDate,_that.endDate,_that.maxMembers,_that.budgetLevel,_that.urgent,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String tripId,  String name,  String? description,  String? coverImageUrl,  int? draftStep,  DateTime startDate,  DateTime endDate,  int maxMembers,  String? budgetLevel,  bool urgent,  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _PublishDraft():
return $default(_that.tripId,_that.name,_that.description,_that.coverImageUrl,_that.draftStep,_that.startDate,_that.endDate,_that.maxMembers,_that.budgetLevel,_that.urgent,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String tripId,  String name,  String? description,  String? coverImageUrl,  int? draftStep,  DateTime startDate,  DateTime endDate,  int maxMembers,  String? budgetLevel,  bool urgent,  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _PublishDraft() when $default != null:
return $default(_that.tripId,_that.name,_that.description,_that.coverImageUrl,_that.draftStep,_that.startDate,_that.endDate,_that.maxMembers,_that.budgetLevel,_that.urgent,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PublishDraft implements PublishDraft {
  const _PublishDraft({required this.tripId, required this.name, this.description, this.coverImageUrl, this.draftStep, required this.startDate, required this.endDate, required this.maxMembers, this.budgetLevel, this.urgent = false, required this.updatedAt});
  factory _PublishDraft.fromJson(Map<String, dynamic> json) => _$PublishDraftFromJson(json);

@override final  String tripId;
@override final  String name;
@override final  String? description;
@override final  String? coverImageUrl;
@override final  int? draftStep;
@override final  DateTime startDate;
@override final  DateTime endDate;
@override final  int maxMembers;
@override final  String? budgetLevel;
@override@JsonKey() final  bool urgent;
@override final  DateTime updatedAt;

/// Create a copy of PublishDraft
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PublishDraftCopyWith<_PublishDraft> get copyWith => __$PublishDraftCopyWithImpl<_PublishDraft>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PublishDraftToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PublishDraft&&(identical(other.tripId, tripId) || other.tripId == tripId)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.coverImageUrl, coverImageUrl) || other.coverImageUrl == coverImageUrl)&&(identical(other.draftStep, draftStep) || other.draftStep == draftStep)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.maxMembers, maxMembers) || other.maxMembers == maxMembers)&&(identical(other.budgetLevel, budgetLevel) || other.budgetLevel == budgetLevel)&&(identical(other.urgent, urgent) || other.urgent == urgent)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,tripId,name,description,coverImageUrl,draftStep,startDate,endDate,maxMembers,budgetLevel,urgent,updatedAt);
}

@override
String toString() {
    return 'PublishDraft(tripId: $tripId, name: $name, description: $description, coverImageUrl: $coverImageUrl, draftStep: $draftStep, startDate: $startDate, endDate: $endDate, maxMembers: $maxMembers, budgetLevel: $budgetLevel, urgent: $urgent, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$PublishDraftCopyWith<$Res> implements $PublishDraftCopyWith<$Res> {
  factory _$PublishDraftCopyWith(_PublishDraft value, $Res Function(_PublishDraft) _then) = __$PublishDraftCopyWithImpl;
@override @useResult
$Res call({
 String tripId, String name, String? description, String? coverImageUrl, int? draftStep, DateTime startDate, DateTime endDate, int maxMembers, String? budgetLevel, bool urgent, DateTime updatedAt
});




}
/// @nodoc
class __$PublishDraftCopyWithImpl<$Res>
    implements _$PublishDraftCopyWith<$Res> {
  __$PublishDraftCopyWithImpl(this._self, this._then);

  final _PublishDraft _self;
  final $Res Function(_PublishDraft) _then;

/// Create a copy of PublishDraft
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? tripId = null,Object? name = null,Object? description = freezed,Object? coverImageUrl = freezed,Object? draftStep = freezed,Object? startDate = null,Object? endDate = null,Object? maxMembers = null,Object? budgetLevel = freezed,Object? urgent = null,Object? updatedAt = null,}) {
  return _then(_PublishDraft(
tripId: null == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,coverImageUrl: freezed == coverImageUrl ? _self.coverImageUrl : coverImageUrl // ignore: cast_nullable_to_non_nullable
as String?,draftStep: freezed == draftStep ? _self.draftStep : draftStep // ignore: cast_nullable_to_non_nullable
as int?,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,endDate: null == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime,maxMembers: null == maxMembers ? _self.maxMembers : maxMembers // ignore: cast_nullable_to_non_nullable
as int,budgetLevel: freezed == budgetLevel ? _self.budgetLevel : budgetLevel // ignore: cast_nullable_to_non_nullable
as String?,urgent: null == urgent ? _self.urgent : urgent // ignore: cast_nullable_to_non_nullable
as bool,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}


/// @nodoc
mixin _$RecruitmentMineTrip {

 String get tripId; String get name; String? get description; String? get coverImageUrl; DateTime get startDate; DateTime get endDate; int get maxMembers; int get memberCount; int get pendingRequestCount; int get slotsRemaining; String? get requirements; String? get estimatedBudgetPerPerson; String? get budgetLevel; DateTime? get expiresAt; RecruitmentState get effectiveState; bool get canPublish; List<String> get blockers; List<String> get destinationLabels; bool get urgent;
/// Create a copy of RecruitmentMineTrip
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RecruitmentMineTripCopyWith<RecruitmentMineTrip> get copyWith => _$RecruitmentMineTripCopyWithImpl<RecruitmentMineTrip>(this as RecruitmentMineTrip, _$identity);

  /// Serializes this RecruitmentMineTrip to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as RecruitmentMineTrip;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecruitmentMineTrip&&(identical(other.tripId, _this.tripId) || other.tripId == _this.tripId)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.coverImageUrl, _this.coverImageUrl) || other.coverImageUrl == _this.coverImageUrl)&&(identical(other.startDate, _this.startDate) || other.startDate == _this.startDate)&&(identical(other.endDate, _this.endDate) || other.endDate == _this.endDate)&&(identical(other.maxMembers, _this.maxMembers) || other.maxMembers == _this.maxMembers)&&(identical(other.memberCount, _this.memberCount) || other.memberCount == _this.memberCount)&&(identical(other.pendingRequestCount, _this.pendingRequestCount) || other.pendingRequestCount == _this.pendingRequestCount)&&(identical(other.slotsRemaining, _this.slotsRemaining) || other.slotsRemaining == _this.slotsRemaining)&&(identical(other.requirements, _this.requirements) || other.requirements == _this.requirements)&&(identical(other.estimatedBudgetPerPerson, _this.estimatedBudgetPerPerson) || other.estimatedBudgetPerPerson == _this.estimatedBudgetPerPerson)&&(identical(other.budgetLevel, _this.budgetLevel) || other.budgetLevel == _this.budgetLevel)&&(identical(other.expiresAt, _this.expiresAt) || other.expiresAt == _this.expiresAt)&&(identical(other.effectiveState, _this.effectiveState) || other.effectiveState == _this.effectiveState)&&(identical(other.canPublish, _this.canPublish) || other.canPublish == _this.canPublish)&&const DeepCollectionEquality().equals(other.blockers, _this.blockers)&&const DeepCollectionEquality().equals(other.destinationLabels, _this.destinationLabels)&&(identical(other.urgent, _this.urgent) || other.urgent == _this.urgent));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as RecruitmentMineTrip;
  return Object.hashAll([runtimeType,_this.tripId,_this.name,_this.description,_this.coverImageUrl,_this.startDate,_this.endDate,_this.maxMembers,_this.memberCount,_this.pendingRequestCount,_this.slotsRemaining,_this.requirements,_this.estimatedBudgetPerPerson,_this.budgetLevel,_this.expiresAt,_this.effectiveState,_this.canPublish,const DeepCollectionEquality().hash(_this.blockers),const DeepCollectionEquality().hash(_this.destinationLabels),_this.urgent]);
}

@override
String toString() {
  final _this = this as RecruitmentMineTrip;
  return 'RecruitmentMineTrip(tripId: ${_this.tripId}, name: ${_this.name}, description: ${_this.description}, coverImageUrl: ${_this.coverImageUrl}, startDate: ${_this.startDate}, endDate: ${_this.endDate}, maxMembers: ${_this.maxMembers}, memberCount: ${_this.memberCount}, pendingRequestCount: ${_this.pendingRequestCount}, slotsRemaining: ${_this.slotsRemaining}, requirements: ${_this.requirements}, estimatedBudgetPerPerson: ${_this.estimatedBudgetPerPerson}, budgetLevel: ${_this.budgetLevel}, expiresAt: ${_this.expiresAt}, effectiveState: ${_this.effectiveState}, canPublish: ${_this.canPublish}, blockers: ${_this.blockers}, destinationLabels: ${_this.destinationLabels}, urgent: ${_this.urgent})';
}


}

/// @nodoc
abstract mixin class $RecruitmentMineTripCopyWith<$Res>  {
  factory $RecruitmentMineTripCopyWith(RecruitmentMineTrip value, $Res Function(RecruitmentMineTrip) _then) = _$RecruitmentMineTripCopyWithImpl;
@useResult
$Res call({
 String tripId, String name, String? description, String? coverImageUrl, DateTime startDate, DateTime endDate, int maxMembers, int memberCount, int pendingRequestCount, int slotsRemaining, String? requirements, String? estimatedBudgetPerPerson, String? budgetLevel, DateTime? expiresAt, RecruitmentState effectiveState, bool canPublish, List<String> blockers, List<String> destinationLabels, bool urgent
});




}
/// @nodoc
class _$RecruitmentMineTripCopyWithImpl<$Res>
    implements $RecruitmentMineTripCopyWith<$Res> {
  _$RecruitmentMineTripCopyWithImpl(this._self, this._then);

  final RecruitmentMineTrip _self;
  final $Res Function(RecruitmentMineTrip) _then;

/// Create a copy of RecruitmentMineTrip
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? tripId = null,Object? name = null,Object? description = freezed,Object? coverImageUrl = freezed,Object? startDate = null,Object? endDate = null,Object? maxMembers = null,Object? memberCount = null,Object? pendingRequestCount = null,Object? slotsRemaining = null,Object? requirements = freezed,Object? estimatedBudgetPerPerson = freezed,Object? budgetLevel = freezed,Object? expiresAt = freezed,Object? effectiveState = null,Object? canPublish = null,Object? blockers = null,Object? destinationLabels = null,Object? urgent = null,}) {
  return _then(RecruitmentMineTrip(
tripId: null == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,coverImageUrl: freezed == coverImageUrl ? _self.coverImageUrl : coverImageUrl // ignore: cast_nullable_to_non_nullable
as String?,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,endDate: null == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime,maxMembers: null == maxMembers ? _self.maxMembers : maxMembers // ignore: cast_nullable_to_non_nullable
as int,memberCount: null == memberCount ? _self.memberCount : memberCount // ignore: cast_nullable_to_non_nullable
as int,pendingRequestCount: null == pendingRequestCount ? _self.pendingRequestCount : pendingRequestCount // ignore: cast_nullable_to_non_nullable
as int,slotsRemaining: null == slotsRemaining ? _self.slotsRemaining : slotsRemaining // ignore: cast_nullable_to_non_nullable
as int,requirements: freezed == requirements ? _self.requirements : requirements // ignore: cast_nullable_to_non_nullable
as String?,estimatedBudgetPerPerson: freezed == estimatedBudgetPerPerson ? _self.estimatedBudgetPerPerson : estimatedBudgetPerPerson // ignore: cast_nullable_to_non_nullable
as String?,budgetLevel: freezed == budgetLevel ? _self.budgetLevel : budgetLevel // ignore: cast_nullable_to_non_nullable
as String?,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,effectiveState: null == effectiveState ? _self.effectiveState : effectiveState // ignore: cast_nullable_to_non_nullable
as RecruitmentState,canPublish: null == canPublish ? _self.canPublish : canPublish // ignore: cast_nullable_to_non_nullable
as bool,blockers: null == blockers ? _self.blockers : blockers // ignore: cast_nullable_to_non_nullable
as List<String>,destinationLabels: null == destinationLabels ? _self.destinationLabels : destinationLabels // ignore: cast_nullable_to_non_nullable
as List<String>,urgent: null == urgent ? _self.urgent : urgent // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [RecruitmentMineTrip].
extension RecruitmentMineTripPatterns on RecruitmentMineTrip {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RecruitmentMineTrip value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RecruitmentMineTrip() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RecruitmentMineTrip value)  $default,){
final _that = this;
switch (_that) {
case _RecruitmentMineTrip():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RecruitmentMineTrip value)?  $default,){
final _that = this;
switch (_that) {
case _RecruitmentMineTrip() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String tripId,  String name,  String? description,  String? coverImageUrl,  DateTime startDate,  DateTime endDate,  int maxMembers,  int memberCount,  int pendingRequestCount,  int slotsRemaining,  String? requirements,  String? estimatedBudgetPerPerson,  String? budgetLevel,  DateTime? expiresAt,  RecruitmentState effectiveState,  bool canPublish,  List<String> blockers,  List<String> destinationLabels,  bool urgent)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RecruitmentMineTrip() when $default != null:
return $default(_that.tripId,_that.name,_that.description,_that.coverImageUrl,_that.startDate,_that.endDate,_that.maxMembers,_that.memberCount,_that.pendingRequestCount,_that.slotsRemaining,_that.requirements,_that.estimatedBudgetPerPerson,_that.budgetLevel,_that.expiresAt,_that.effectiveState,_that.canPublish,_that.blockers,_that.destinationLabels,_that.urgent);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String tripId,  String name,  String? description,  String? coverImageUrl,  DateTime startDate,  DateTime endDate,  int maxMembers,  int memberCount,  int pendingRequestCount,  int slotsRemaining,  String? requirements,  String? estimatedBudgetPerPerson,  String? budgetLevel,  DateTime? expiresAt,  RecruitmentState effectiveState,  bool canPublish,  List<String> blockers,  List<String> destinationLabels,  bool urgent)  $default,) {final _that = this;
switch (_that) {
case _RecruitmentMineTrip():
return $default(_that.tripId,_that.name,_that.description,_that.coverImageUrl,_that.startDate,_that.endDate,_that.maxMembers,_that.memberCount,_that.pendingRequestCount,_that.slotsRemaining,_that.requirements,_that.estimatedBudgetPerPerson,_that.budgetLevel,_that.expiresAt,_that.effectiveState,_that.canPublish,_that.blockers,_that.destinationLabels,_that.urgent);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String tripId,  String name,  String? description,  String? coverImageUrl,  DateTime startDate,  DateTime endDate,  int maxMembers,  int memberCount,  int pendingRequestCount,  int slotsRemaining,  String? requirements,  String? estimatedBudgetPerPerson,  String? budgetLevel,  DateTime? expiresAt,  RecruitmentState effectiveState,  bool canPublish,  List<String> blockers,  List<String> destinationLabels,  bool urgent)?  $default,) {final _that = this;
switch (_that) {
case _RecruitmentMineTrip() when $default != null:
return $default(_that.tripId,_that.name,_that.description,_that.coverImageUrl,_that.startDate,_that.endDate,_that.maxMembers,_that.memberCount,_that.pendingRequestCount,_that.slotsRemaining,_that.requirements,_that.estimatedBudgetPerPerson,_that.budgetLevel,_that.expiresAt,_that.effectiveState,_that.canPublish,_that.blockers,_that.destinationLabels,_that.urgent);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RecruitmentMineTrip implements RecruitmentMineTrip {
  const _RecruitmentMineTrip({required this.tripId, required this.name, this.description, this.coverImageUrl, required this.startDate, required this.endDate, required this.maxMembers, required this.memberCount, required this.pendingRequestCount, required this.slotsRemaining, this.requirements, this.estimatedBudgetPerPerson, this.budgetLevel, this.expiresAt, required this.effectiveState, required this.canPublish,  List<String> blockers = const <String>[],  List<String> destinationLabels = const <String>[], this.urgent = false}): _blockers = blockers,_destinationLabels = destinationLabels;
  factory _RecruitmentMineTrip.fromJson(Map<String, dynamic> json) => _$RecruitmentMineTripFromJson(json);

@override final  String tripId;
@override final  String name;
@override final  String? description;
@override final  String? coverImageUrl;
@override final  DateTime startDate;
@override final  DateTime endDate;
@override final  int maxMembers;
@override final  int memberCount;
@override final  int pendingRequestCount;
@override final  int slotsRemaining;
@override final  String? requirements;
@override final  String? estimatedBudgetPerPerson;
@override final  String? budgetLevel;
@override final  DateTime? expiresAt;
@override final  RecruitmentState effectiveState;
@override final  bool canPublish;
 final  List<String> _blockers;
@override@JsonKey() List<String> get blockers {
  if (_blockers is EqualUnmodifiableListView) return _blockers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_blockers);
}

 final  List<String> _destinationLabels;
@override@JsonKey() List<String> get destinationLabels {
  if (_destinationLabels is EqualUnmodifiableListView) return _destinationLabels;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_destinationLabels);
}

@override@JsonKey() final  bool urgent;

/// Create a copy of RecruitmentMineTrip
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RecruitmentMineTripCopyWith<_RecruitmentMineTrip> get copyWith => __$RecruitmentMineTripCopyWithImpl<_RecruitmentMineTrip>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RecruitmentMineTripToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _RecruitmentMineTrip&&(identical(other.tripId, tripId) || other.tripId == tripId)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.coverImageUrl, coverImageUrl) || other.coverImageUrl == coverImageUrl)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.maxMembers, maxMembers) || other.maxMembers == maxMembers)&&(identical(other.memberCount, memberCount) || other.memberCount == memberCount)&&(identical(other.pendingRequestCount, pendingRequestCount) || other.pendingRequestCount == pendingRequestCount)&&(identical(other.slotsRemaining, slotsRemaining) || other.slotsRemaining == slotsRemaining)&&(identical(other.requirements, requirements) || other.requirements == requirements)&&(identical(other.estimatedBudgetPerPerson, estimatedBudgetPerPerson) || other.estimatedBudgetPerPerson == estimatedBudgetPerPerson)&&(identical(other.budgetLevel, budgetLevel) || other.budgetLevel == budgetLevel)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.effectiveState, effectiveState) || other.effectiveState == effectiveState)&&(identical(other.canPublish, canPublish) || other.canPublish == canPublish)&&const DeepCollectionEquality().equals(other.blockers, _blockers)&&const DeepCollectionEquality().equals(other.destinationLabels, _destinationLabels)&&(identical(other.urgent, urgent) || other.urgent == urgent));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hashAll([runtimeType,tripId,name,description,coverImageUrl,startDate,endDate,maxMembers,memberCount,pendingRequestCount,slotsRemaining,requirements,estimatedBudgetPerPerson,budgetLevel,expiresAt,effectiveState,canPublish,const DeepCollectionEquality().hash(_blockers),const DeepCollectionEquality().hash(_destinationLabels),urgent]);
}

@override
String toString() {
    return 'RecruitmentMineTrip(tripId: $tripId, name: $name, description: $description, coverImageUrl: $coverImageUrl, startDate: $startDate, endDate: $endDate, maxMembers: $maxMembers, memberCount: $memberCount, pendingRequestCount: $pendingRequestCount, slotsRemaining: $slotsRemaining, requirements: $requirements, estimatedBudgetPerPerson: $estimatedBudgetPerPerson, budgetLevel: $budgetLevel, expiresAt: $expiresAt, effectiveState: $effectiveState, canPublish: $canPublish, blockers: $blockers, destinationLabels: $destinationLabels, urgent: $urgent)';
}


}

/// @nodoc
abstract mixin class _$RecruitmentMineTripCopyWith<$Res> implements $RecruitmentMineTripCopyWith<$Res> {
  factory _$RecruitmentMineTripCopyWith(_RecruitmentMineTrip value, $Res Function(_RecruitmentMineTrip) _then) = __$RecruitmentMineTripCopyWithImpl;
@override @useResult
$Res call({
 String tripId, String name, String? description, String? coverImageUrl, DateTime startDate, DateTime endDate, int maxMembers, int memberCount, int pendingRequestCount, int slotsRemaining, String? requirements, String? estimatedBudgetPerPerson, String? budgetLevel, DateTime? expiresAt, RecruitmentState effectiveState, bool canPublish, List<String> blockers, List<String> destinationLabels, bool urgent
});




}
/// @nodoc
class __$RecruitmentMineTripCopyWithImpl<$Res>
    implements _$RecruitmentMineTripCopyWith<$Res> {
  __$RecruitmentMineTripCopyWithImpl(this._self, this._then);

  final _RecruitmentMineTrip _self;
  final $Res Function(_RecruitmentMineTrip) _then;

/// Create a copy of RecruitmentMineTrip
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? tripId = null,Object? name = null,Object? description = freezed,Object? coverImageUrl = freezed,Object? startDate = null,Object? endDate = null,Object? maxMembers = null,Object? memberCount = null,Object? pendingRequestCount = null,Object? slotsRemaining = null,Object? requirements = freezed,Object? estimatedBudgetPerPerson = freezed,Object? budgetLevel = freezed,Object? expiresAt = freezed,Object? effectiveState = null,Object? canPublish = null,Object? blockers = null,Object? destinationLabels = null,Object? urgent = null,}) {
  return _then(_RecruitmentMineTrip(
tripId: null == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,coverImageUrl: freezed == coverImageUrl ? _self.coverImageUrl : coverImageUrl // ignore: cast_nullable_to_non_nullable
as String?,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,endDate: null == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime,maxMembers: null == maxMembers ? _self.maxMembers : maxMembers // ignore: cast_nullable_to_non_nullable
as int,memberCount: null == memberCount ? _self.memberCount : memberCount // ignore: cast_nullable_to_non_nullable
as int,pendingRequestCount: null == pendingRequestCount ? _self.pendingRequestCount : pendingRequestCount // ignore: cast_nullable_to_non_nullable
as int,slotsRemaining: null == slotsRemaining ? _self.slotsRemaining : slotsRemaining // ignore: cast_nullable_to_non_nullable
as int,requirements: freezed == requirements ? _self.requirements : requirements // ignore: cast_nullable_to_non_nullable
as String?,estimatedBudgetPerPerson: freezed == estimatedBudgetPerPerson ? _self.estimatedBudgetPerPerson : estimatedBudgetPerPerson // ignore: cast_nullable_to_non_nullable
as String?,budgetLevel: freezed == budgetLevel ? _self.budgetLevel : budgetLevel // ignore: cast_nullable_to_non_nullable
as String?,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,effectiveState: null == effectiveState ? _self.effectiveState : effectiveState // ignore: cast_nullable_to_non_nullable
as RecruitmentState,canPublish: null == canPublish ? _self.canPublish : canPublish // ignore: cast_nullable_to_non_nullable
as bool,blockers: null == blockers ? _self._blockers : blockers // ignore: cast_nullable_to_non_nullable
as List<String>,destinationLabels: null == destinationLabels ? _self._destinationLabels : destinationLabels // ignore: cast_nullable_to_non_nullable
as List<String>,urgent: null == urgent ? _self.urgent : urgent // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$RecruitmentMine {

 int get activeRecruitmentCount; PublishDraft? get latestPublishDraft; List<RecruitmentMineTrip> get trips;
/// Create a copy of RecruitmentMine
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RecruitmentMineCopyWith<RecruitmentMine> get copyWith => _$RecruitmentMineCopyWithImpl<RecruitmentMine>(this as RecruitmentMine, _$identity);

  /// Serializes this RecruitmentMine to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as RecruitmentMine;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecruitmentMine&&(identical(other.activeRecruitmentCount, _this.activeRecruitmentCount) || other.activeRecruitmentCount == _this.activeRecruitmentCount)&&(identical(other.latestPublishDraft, _this.latestPublishDraft) || other.latestPublishDraft == _this.latestPublishDraft)&&const DeepCollectionEquality().equals(other.trips, _this.trips));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as RecruitmentMine;
  return Object.hash(runtimeType,_this.activeRecruitmentCount,_this.latestPublishDraft,const DeepCollectionEquality().hash(_this.trips));
}

@override
String toString() {
  final _this = this as RecruitmentMine;
  return 'RecruitmentMine(activeRecruitmentCount: ${_this.activeRecruitmentCount}, latestPublishDraft: ${_this.latestPublishDraft}, trips: ${_this.trips})';
}


}

/// @nodoc
abstract mixin class $RecruitmentMineCopyWith<$Res>  {
  factory $RecruitmentMineCopyWith(RecruitmentMine value, $Res Function(RecruitmentMine) _then) = _$RecruitmentMineCopyWithImpl;
@useResult
$Res call({
 int activeRecruitmentCount, PublishDraft? latestPublishDraft, List<RecruitmentMineTrip> trips
});


$PublishDraftCopyWith<$Res>? get latestPublishDraft;

}
/// @nodoc
class _$RecruitmentMineCopyWithImpl<$Res>
    implements $RecruitmentMineCopyWith<$Res> {
  _$RecruitmentMineCopyWithImpl(this._self, this._then);

  final RecruitmentMine _self;
  final $Res Function(RecruitmentMine) _then;

/// Create a copy of RecruitmentMine
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? activeRecruitmentCount = null,Object? latestPublishDraft = freezed,Object? trips = null,}) {
  return _then(RecruitmentMine(
activeRecruitmentCount: null == activeRecruitmentCount ? _self.activeRecruitmentCount : activeRecruitmentCount // ignore: cast_nullable_to_non_nullable
as int,latestPublishDraft: freezed == latestPublishDraft ? _self.latestPublishDraft : latestPublishDraft // ignore: cast_nullable_to_non_nullable
as PublishDraft?,trips: null == trips ? _self.trips : trips // ignore: cast_nullable_to_non_nullable
as List<RecruitmentMineTrip>,
  ));
}
/// Create a copy of RecruitmentMine
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PublishDraftCopyWith<$Res>? get latestPublishDraft {
    if (_self.latestPublishDraft == null) {
    return null;
  }

  return $PublishDraftCopyWith<$Res>(_self.latestPublishDraft!, (value) {
    return _then(_self.copyWith(latestPublishDraft: value));
  });
}
}


/// Adds pattern-matching-related methods to [RecruitmentMine].
extension RecruitmentMinePatterns on RecruitmentMine {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RecruitmentMine value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RecruitmentMine() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RecruitmentMine value)  $default,){
final _that = this;
switch (_that) {
case _RecruitmentMine():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RecruitmentMine value)?  $default,){
final _that = this;
switch (_that) {
case _RecruitmentMine() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int activeRecruitmentCount,  PublishDraft? latestPublishDraft,  List<RecruitmentMineTrip> trips)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RecruitmentMine() when $default != null:
return $default(_that.activeRecruitmentCount,_that.latestPublishDraft,_that.trips);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int activeRecruitmentCount,  PublishDraft? latestPublishDraft,  List<RecruitmentMineTrip> trips)  $default,) {final _that = this;
switch (_that) {
case _RecruitmentMine():
return $default(_that.activeRecruitmentCount,_that.latestPublishDraft,_that.trips);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int activeRecruitmentCount,  PublishDraft? latestPublishDraft,  List<RecruitmentMineTrip> trips)?  $default,) {final _that = this;
switch (_that) {
case _RecruitmentMine() when $default != null:
return $default(_that.activeRecruitmentCount,_that.latestPublishDraft,_that.trips);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RecruitmentMine implements RecruitmentMine {
  const _RecruitmentMine({required this.activeRecruitmentCount, this.latestPublishDraft,  List<RecruitmentMineTrip> trips = const <RecruitmentMineTrip>[]}): _trips = trips;
  factory _RecruitmentMine.fromJson(Map<String, dynamic> json) => _$RecruitmentMineFromJson(json);

@override final  int activeRecruitmentCount;
@override final  PublishDraft? latestPublishDraft;
 final  List<RecruitmentMineTrip> _trips;
@override@JsonKey() List<RecruitmentMineTrip> get trips {
  if (_trips is EqualUnmodifiableListView) return _trips;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_trips);
}


/// Create a copy of RecruitmentMine
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RecruitmentMineCopyWith<_RecruitmentMine> get copyWith => __$RecruitmentMineCopyWithImpl<_RecruitmentMine>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RecruitmentMineToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _RecruitmentMine&&(identical(other.activeRecruitmentCount, activeRecruitmentCount) || other.activeRecruitmentCount == activeRecruitmentCount)&&(identical(other.latestPublishDraft, latestPublishDraft) || other.latestPublishDraft == latestPublishDraft)&&const DeepCollectionEquality().equals(other.trips, _trips));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,activeRecruitmentCount,latestPublishDraft,const DeepCollectionEquality().hash(_trips));
}

@override
String toString() {
    return 'RecruitmentMine(activeRecruitmentCount: $activeRecruitmentCount, latestPublishDraft: $latestPublishDraft, trips: $trips)';
}


}

/// @nodoc
abstract mixin class _$RecruitmentMineCopyWith<$Res> implements $RecruitmentMineCopyWith<$Res> {
  factory _$RecruitmentMineCopyWith(_RecruitmentMine value, $Res Function(_RecruitmentMine) _then) = __$RecruitmentMineCopyWithImpl;
@override @useResult
$Res call({
 int activeRecruitmentCount, PublishDraft? latestPublishDraft, List<RecruitmentMineTrip> trips
});


@override $PublishDraftCopyWith<$Res>? get latestPublishDraft;

}
/// @nodoc
class __$RecruitmentMineCopyWithImpl<$Res>
    implements _$RecruitmentMineCopyWith<$Res> {
  __$RecruitmentMineCopyWithImpl(this._self, this._then);

  final _RecruitmentMine _self;
  final $Res Function(_RecruitmentMine) _then;

/// Create a copy of RecruitmentMine
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? activeRecruitmentCount = null,Object? latestPublishDraft = freezed,Object? trips = null,}) {
  return _then(_RecruitmentMine(
activeRecruitmentCount: null == activeRecruitmentCount ? _self.activeRecruitmentCount : activeRecruitmentCount // ignore: cast_nullable_to_non_nullable
as int,latestPublishDraft: freezed == latestPublishDraft ? _self.latestPublishDraft : latestPublishDraft // ignore: cast_nullable_to_non_nullable
as PublishDraft?,trips: null == trips ? _self._trips : trips // ignore: cast_nullable_to_non_nullable
as List<RecruitmentMineTrip>,
  ));
}

/// Create a copy of RecruitmentMine
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PublishDraftCopyWith<$Res>? get latestPublishDraft {
    if (_self.latestPublishDraft == null) {
    return null;
  }

  return $PublishDraftCopyWith<$Res>(_self.latestPublishDraft!, (value) {
    return _then(_self.copyWith(latestPublishDraft: value));
  });
}
}


/// @nodoc
mixin _$RecruitmentPublishResult {

 String get tripId; RecruitmentState get state; RecruitmentState get effectiveState; DateTime? get publishedAt; DateTime? get expiresAt; String get visibility; String? get previousVisibility;
/// Create a copy of RecruitmentPublishResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RecruitmentPublishResultCopyWith<RecruitmentPublishResult> get copyWith => _$RecruitmentPublishResultCopyWithImpl<RecruitmentPublishResult>(this as RecruitmentPublishResult, _$identity);

  /// Serializes this RecruitmentPublishResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as RecruitmentPublishResult;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecruitmentPublishResult&&(identical(other.tripId, _this.tripId) || other.tripId == _this.tripId)&&(identical(other.state, _this.state) || other.state == _this.state)&&(identical(other.effectiveState, _this.effectiveState) || other.effectiveState == _this.effectiveState)&&(identical(other.publishedAt, _this.publishedAt) || other.publishedAt == _this.publishedAt)&&(identical(other.expiresAt, _this.expiresAt) || other.expiresAt == _this.expiresAt)&&(identical(other.visibility, _this.visibility) || other.visibility == _this.visibility)&&(identical(other.previousVisibility, _this.previousVisibility) || other.previousVisibility == _this.previousVisibility));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as RecruitmentPublishResult;
  return Object.hash(runtimeType,_this.tripId,_this.state,_this.effectiveState,_this.publishedAt,_this.expiresAt,_this.visibility,_this.previousVisibility);
}

@override
String toString() {
  final _this = this as RecruitmentPublishResult;
  return 'RecruitmentPublishResult(tripId: ${_this.tripId}, state: ${_this.state}, effectiveState: ${_this.effectiveState}, publishedAt: ${_this.publishedAt}, expiresAt: ${_this.expiresAt}, visibility: ${_this.visibility}, previousVisibility: ${_this.previousVisibility})';
}


}

/// @nodoc
abstract mixin class $RecruitmentPublishResultCopyWith<$Res>  {
  factory $RecruitmentPublishResultCopyWith(RecruitmentPublishResult value, $Res Function(RecruitmentPublishResult) _then) = _$RecruitmentPublishResultCopyWithImpl;
@useResult
$Res call({
 String tripId, RecruitmentState state, RecruitmentState effectiveState, DateTime? publishedAt, DateTime? expiresAt, String visibility, String? previousVisibility
});




}
/// @nodoc
class _$RecruitmentPublishResultCopyWithImpl<$Res>
    implements $RecruitmentPublishResultCopyWith<$Res> {
  _$RecruitmentPublishResultCopyWithImpl(this._self, this._then);

  final RecruitmentPublishResult _self;
  final $Res Function(RecruitmentPublishResult) _then;

/// Create a copy of RecruitmentPublishResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? tripId = null,Object? state = null,Object? effectiveState = null,Object? publishedAt = freezed,Object? expiresAt = freezed,Object? visibility = null,Object? previousVisibility = freezed,}) {
  return _then(RecruitmentPublishResult(
tripId: null == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String,state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as RecruitmentState,effectiveState: null == effectiveState ? _self.effectiveState : effectiveState // ignore: cast_nullable_to_non_nullable
as RecruitmentState,publishedAt: freezed == publishedAt ? _self.publishedAt : publishedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,visibility: null == visibility ? _self.visibility : visibility // ignore: cast_nullable_to_non_nullable
as String,previousVisibility: freezed == previousVisibility ? _self.previousVisibility : previousVisibility // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [RecruitmentPublishResult].
extension RecruitmentPublishResultPatterns on RecruitmentPublishResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RecruitmentPublishResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RecruitmentPublishResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RecruitmentPublishResult value)  $default,){
final _that = this;
switch (_that) {
case _RecruitmentPublishResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RecruitmentPublishResult value)?  $default,){
final _that = this;
switch (_that) {
case _RecruitmentPublishResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String tripId,  RecruitmentState state,  RecruitmentState effectiveState,  DateTime? publishedAt,  DateTime? expiresAt,  String visibility,  String? previousVisibility)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RecruitmentPublishResult() when $default != null:
return $default(_that.tripId,_that.state,_that.effectiveState,_that.publishedAt,_that.expiresAt,_that.visibility,_that.previousVisibility);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String tripId,  RecruitmentState state,  RecruitmentState effectiveState,  DateTime? publishedAt,  DateTime? expiresAt,  String visibility,  String? previousVisibility)  $default,) {final _that = this;
switch (_that) {
case _RecruitmentPublishResult():
return $default(_that.tripId,_that.state,_that.effectiveState,_that.publishedAt,_that.expiresAt,_that.visibility,_that.previousVisibility);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String tripId,  RecruitmentState state,  RecruitmentState effectiveState,  DateTime? publishedAt,  DateTime? expiresAt,  String visibility,  String? previousVisibility)?  $default,) {final _that = this;
switch (_that) {
case _RecruitmentPublishResult() when $default != null:
return $default(_that.tripId,_that.state,_that.effectiveState,_that.publishedAt,_that.expiresAt,_that.visibility,_that.previousVisibility);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RecruitmentPublishResult implements RecruitmentPublishResult {
  const _RecruitmentPublishResult({required this.tripId, required this.state, required this.effectiveState, this.publishedAt, this.expiresAt, required this.visibility, this.previousVisibility});
  factory _RecruitmentPublishResult.fromJson(Map<String, dynamic> json) => _$RecruitmentPublishResultFromJson(json);

@override final  String tripId;
@override final  RecruitmentState state;
@override final  RecruitmentState effectiveState;
@override final  DateTime? publishedAt;
@override final  DateTime? expiresAt;
@override final  String visibility;
@override final  String? previousVisibility;

/// Create a copy of RecruitmentPublishResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RecruitmentPublishResultCopyWith<_RecruitmentPublishResult> get copyWith => __$RecruitmentPublishResultCopyWithImpl<_RecruitmentPublishResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RecruitmentPublishResultToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _RecruitmentPublishResult&&(identical(other.tripId, tripId) || other.tripId == tripId)&&(identical(other.state, state) || other.state == state)&&(identical(other.effectiveState, effectiveState) || other.effectiveState == effectiveState)&&(identical(other.publishedAt, publishedAt) || other.publishedAt == publishedAt)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.visibility, visibility) || other.visibility == visibility)&&(identical(other.previousVisibility, previousVisibility) || other.previousVisibility == previousVisibility));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,tripId,state,effectiveState,publishedAt,expiresAt,visibility,previousVisibility);
}

@override
String toString() {
    return 'RecruitmentPublishResult(tripId: $tripId, state: $state, effectiveState: $effectiveState, publishedAt: $publishedAt, expiresAt: $expiresAt, visibility: $visibility, previousVisibility: $previousVisibility)';
}


}

/// @nodoc
abstract mixin class _$RecruitmentPublishResultCopyWith<$Res> implements $RecruitmentPublishResultCopyWith<$Res> {
  factory _$RecruitmentPublishResultCopyWith(_RecruitmentPublishResult value, $Res Function(_RecruitmentPublishResult) _then) = __$RecruitmentPublishResultCopyWithImpl;
@override @useResult
$Res call({
 String tripId, RecruitmentState state, RecruitmentState effectiveState, DateTime? publishedAt, DateTime? expiresAt, String visibility, String? previousVisibility
});




}
/// @nodoc
class __$RecruitmentPublishResultCopyWithImpl<$Res>
    implements _$RecruitmentPublishResultCopyWith<$Res> {
  __$RecruitmentPublishResultCopyWithImpl(this._self, this._then);

  final _RecruitmentPublishResult _self;
  final $Res Function(_RecruitmentPublishResult) _then;

/// Create a copy of RecruitmentPublishResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? tripId = null,Object? state = null,Object? effectiveState = null,Object? publishedAt = freezed,Object? expiresAt = freezed,Object? visibility = null,Object? previousVisibility = freezed,}) {
  return _then(_RecruitmentPublishResult(
tripId: null == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String,state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as RecruitmentState,effectiveState: null == effectiveState ? _self.effectiveState : effectiveState // ignore: cast_nullable_to_non_nullable
as RecruitmentState,publishedAt: freezed == publishedAt ? _self.publishedAt : publishedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,visibility: null == visibility ? _self.visibility : visibility // ignore: cast_nullable_to_non_nullable
as String,previousVisibility: freezed == previousVisibility ? _self.previousVisibility : previousVisibility // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
