// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_publish_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RecruitmentSummary _$RecruitmentSummaryFromJson(Map<String, dynamic> json) =>
    _RecruitmentSummary(
      activeRecruitmentCount: (json['activeRecruitmentCount'] as num).toInt(),
    );

Map<String, dynamic> _$RecruitmentSummaryToJson(_RecruitmentSummary instance) =>
    <String, dynamic>{
      'activeRecruitmentCount': instance.activeRecruitmentCount,
    };

_PublishDraft _$PublishDraftFromJson(Map<String, dynamic> json) =>
    _PublishDraft(
      tripId: json['tripId'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      coverImageUrl: json['coverImageUrl'] as String?,
      draftStep: (json['draftStep'] as num?)?.toInt(),
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      maxMembers: (json['maxMembers'] as num).toInt(),
      budgetLevel: json['budgetLevel'] as String?,
      urgent: json['urgent'] as bool? ?? false,
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$PublishDraftToJson(_PublishDraft instance) =>
    <String, dynamic>{
      'tripId': instance.tripId,
      'name': instance.name,
      'description': instance.description,
      'coverImageUrl': instance.coverImageUrl,
      'draftStep': instance.draftStep,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
      'maxMembers': instance.maxMembers,
      'budgetLevel': instance.budgetLevel,
      'urgent': instance.urgent,
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

_RecruitmentMineTrip _$RecruitmentMineTripFromJson(Map<String, dynamic> json) =>
    _RecruitmentMineTrip(
      tripId: json['tripId'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      coverImageUrl: json['coverImageUrl'] as String?,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      maxMembers: (json['maxMembers'] as num).toInt(),
      memberCount: (json['memberCount'] as num).toInt(),
      pendingRequestCount: (json['pendingRequestCount'] as num).toInt(),
      slotsRemaining: (json['slotsRemaining'] as num).toInt(),
      requirements: json['requirements'] as String?,
      estimatedBudgetPerPerson: json['estimatedBudgetPerPerson'] as String?,
      budgetLevel: json['budgetLevel'] as String?,
      expiresAt: json['expiresAt'] == null
          ? null
          : DateTime.parse(json['expiresAt'] as String),
      effectiveState: $enumDecode(
        _$RecruitmentStateEnumMap,
        json['effectiveState'],
      ),
      canPublish: json['canPublish'] as bool,
      blockers:
          (json['blockers'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      destinationLabels:
          (json['destinationLabels'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      urgent: json['urgent'] as bool? ?? false,
    );

Map<String, dynamic> _$RecruitmentMineTripToJson(
  _RecruitmentMineTrip instance,
) => <String, dynamic>{
  'tripId': instance.tripId,
  'name': instance.name,
  'description': instance.description,
  'coverImageUrl': instance.coverImageUrl,
  'startDate': instance.startDate.toIso8601String(),
  'endDate': instance.endDate.toIso8601String(),
  'maxMembers': instance.maxMembers,
  'memberCount': instance.memberCount,
  'pendingRequestCount': instance.pendingRequestCount,
  'slotsRemaining': instance.slotsRemaining,
  'requirements': instance.requirements,
  'estimatedBudgetPerPerson': instance.estimatedBudgetPerPerson,
  'budgetLevel': instance.budgetLevel,
  'expiresAt': instance.expiresAt?.toIso8601String(),
  'effectiveState': _$RecruitmentStateEnumMap[instance.effectiveState]!,
  'canPublish': instance.canPublish,
  'blockers': instance.blockers,
  'destinationLabels': instance.destinationLabels,
  'urgent': instance.urgent,
};

const _$RecruitmentStateEnumMap = {
  RecruitmentState.notPublished: 'NOT_PUBLISHED',
  RecruitmentState.open: 'OPEN',
  RecruitmentState.full: 'FULL',
  RecruitmentState.closed: 'CLOSED',
};

_RecruitmentMine _$RecruitmentMineFromJson(Map<String, dynamic> json) =>
    _RecruitmentMine(
      activeRecruitmentCount: (json['activeRecruitmentCount'] as num).toInt(),
      latestPublishDraft: json['latestPublishDraft'] == null
          ? null
          : PublishDraft.fromJson(
              json['latestPublishDraft'] as Map<String, dynamic>,
            ),
      trips:
          (json['trips'] as List<dynamic>?)
              ?.map(
                (e) => RecruitmentMineTrip.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const <RecruitmentMineTrip>[],
    );

Map<String, dynamic> _$RecruitmentMineToJson(_RecruitmentMine instance) =>
    <String, dynamic>{
      'activeRecruitmentCount': instance.activeRecruitmentCount,
      'latestPublishDraft': instance.latestPublishDraft,
      'trips': instance.trips,
    };

_RecruitmentPublishResult _$RecruitmentPublishResultFromJson(
  Map<String, dynamic> json,
) => _RecruitmentPublishResult(
  tripId: json['tripId'] as String,
  state: $enumDecode(_$RecruitmentStateEnumMap, json['state']),
  effectiveState: $enumDecode(
    _$RecruitmentStateEnumMap,
    json['effectiveState'],
  ),
  publishedAt: json['publishedAt'] == null
      ? null
      : DateTime.parse(json['publishedAt'] as String),
  expiresAt: json['expiresAt'] == null
      ? null
      : DateTime.parse(json['expiresAt'] as String),
  visibility: json['visibility'] as String,
  previousVisibility: json['previousVisibility'] as String?,
);

Map<String, dynamic> _$RecruitmentPublishResultToJson(
  _RecruitmentPublishResult instance,
) => <String, dynamic>{
  'tripId': instance.tripId,
  'state': _$RecruitmentStateEnumMap[instance.state]!,
  'effectiveState': _$RecruitmentStateEnumMap[instance.effectiveState]!,
  'publishedAt': instance.publishedAt?.toIso8601String(),
  'expiresAt': instance.expiresAt?.toIso8601String(),
  'visibility': instance.visibility,
  'previousVisibility': instance.previousVisibility,
};
