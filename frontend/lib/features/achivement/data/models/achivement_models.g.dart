// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'achivement_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TripMissionsPage _$TripMissionsPageFromJson(Map<String, dynamic> json) =>
    _TripMissionsPage(
      completedCount: (json['completedCount'] as num?)?.toInt() ?? 0,
      totalCount: (json['totalCount'] as num?)?.toInt() ?? 0,
      missionPointsEarned: (json['missionPointsEarned'] as num?)?.toInt() ?? 0,
      missionPointsCap: (json['missionPointsCap'] as num?)?.toInt() ?? 80,
      missionPointsPending:
          (json['missionPointsPending'] as num?)?.toInt() ?? 0,
      items:
          (json['items'] as List<dynamic>?)
              ?.map((e) => TripMissionItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <TripMissionItem>[],
    );

Map<String, dynamic> _$TripMissionsPageToJson(_TripMissionsPage instance) =>
    <String, dynamic>{
      'completedCount': instance.completedCount,
      'totalCount': instance.totalCount,
      'missionPointsEarned': instance.missionPointsEarned,
      'missionPointsCap': instance.missionPointsCap,
      'missionPointsPending': instance.missionPointsPending,
      'items': instance.items,
    };

_TripMissionItem _$TripMissionItemFromJson(Map<String, dynamic> json) =>
    _TripMissionItem(
      id: json['id'] as String,
      code: json['code'] as String,
      group:
          $enumDecodeNullable(
            _$TripMissionGroupEnumMap,
            json['group'],
            unknownValue: TripMissionGroup.exploration,
          ) ??
          TripMissionGroup.exploration,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String? ?? '',
      icon: json['icon'] as String? ?? 'explore',
      verifyType:
          $enumDecodeNullable(
            _$TripMissionVerifyTypeEnumMap,
            json['verifyType'],
            unknownValue: TripMissionVerifyType.checkinCount,
          ) ??
          TripMissionVerifyType.checkinCount,
      pointsReward: (json['pointsReward'] as num?)?.toInt() ?? 0,
      progressCurrent: (json['progressCurrent'] as num?)?.toInt() ?? 0,
      progressTarget: (json['progressTarget'] as num?)?.toInt() ?? 1,
      completed: json['completed'] as bool? ?? false,
      cta:
          $enumDecodeNullable(
            _$TripMissionCtaEnumMap,
            json['cta'],
            unknownValue: TripMissionCta.itinerary,
          ) ??
          TripMissionCta.itinerary,
    );

Map<String, dynamic> _$TripMissionItemToJson(_TripMissionItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'group': _$TripMissionGroupEnumMap[instance.group]!,
      'title': instance.title,
      'subtitle': instance.subtitle,
      'icon': instance.icon,
      'verifyType': _$TripMissionVerifyTypeEnumMap[instance.verifyType]!,
      'pointsReward': instance.pointsReward,
      'progressCurrent': instance.progressCurrent,
      'progressTarget': instance.progressTarget,
      'completed': instance.completed,
      'cta': _$TripMissionCtaEnumMap[instance.cta]!,
    };

const _$TripMissionGroupEnumMap = {
  TripMissionGroup.exploration: 'EXPLORATION',
  TripMissionGroup.food: 'FOOD',
  TripMissionGroup.culture: 'CULTURE',
  TripMissionGroup.adventure: 'ADVENTURE',
  TripMissionGroup.nature: 'NATURE',
  TripMissionGroup.social: 'SOCIAL',
  TripMissionGroup.experience: 'EXPERIENCE',
  TripMissionGroup.responsible: 'RESPONSIBLE',
};

const _$TripMissionVerifyTypeEnumMap = {
  TripMissionVerifyType.checkinCount: 'CHECKIN_COUNT',
  TripMissionVerifyType.checkinNewCity: 'CHECKIN_NEW_CITY',
  TripMissionVerifyType.checkinPlaceCategory: 'CHECKIN_PLACE_CATEGORY',
  TripMissionVerifyType.memoryCount: 'MEMORY_COUNT',
};

const _$TripMissionCtaEnumMap = {
  TripMissionCta.itinerary: 'ITINERARY',
  TripMissionCta.memories: 'MEMORIES',
};

_TravelTier _$TravelTierFromJson(Map<String, dynamic> json) => _TravelTier(
  code: json['code'] as String,
  label: json['label'] as String,
  multiplier: (json['multiplier'] as num?)?.toDouble() ?? 1.0,
  tripsCompleted: (json['tripsCompleted'] as num?)?.toInt() ?? 0,
  distinctCities: (json['distinctCities'] as num?)?.toInt() ?? 0,
  next: json['next'] == null
      ? null
      : TravelTierNext.fromJson(json['next'] as Map<String, dynamic>),
);

Map<String, dynamic> _$TravelTierToJson(_TravelTier instance) =>
    <String, dynamic>{
      'code': instance.code,
      'label': instance.label,
      'multiplier': instance.multiplier,
      'tripsCompleted': instance.tripsCompleted,
      'distinctCities': instance.distinctCities,
      'next': instance.next,
    };

_TravelTierNext _$TravelTierNextFromJson(Map<String, dynamic> json) =>
    _TravelTierNext(
      code: json['code'] as String,
      multiplier: (json['multiplier'] as num?)?.toDouble() ?? 1.0,
      tripsRemaining: (json['tripsRemaining'] as num?)?.toInt() ?? 0,
      citiesRemaining: (json['citiesRemaining'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$TravelTierNextToJson(_TravelTierNext instance) =>
    <String, dynamic>{
      'code': instance.code,
      'multiplier': instance.multiplier,
      'tripsRemaining': instance.tripsRemaining,
      'citiesRemaining': instance.citiesRemaining,
    };

_AchievementProgress _$AchievementProgressFromJson(Map<String, dynamic> json) =>
    _AchievementProgress(
      code: json['code'] as String,
      title: json['title'] as String,
      rarity: json['rarity'] as String? ?? 'COMMON',
      current: (json['current'] as num?)?.toInt() ?? 0,
      target: (json['target'] as num?)?.toInt() ?? 1,
      unlocked: json['unlocked'] as bool? ?? false,
    );

Map<String, dynamic> _$AchievementProgressToJson(
  _AchievementProgress instance,
) => <String, dynamic>{
  'code': instance.code,
  'title': instance.title,
  'rarity': instance.rarity,
  'current': instance.current,
  'target': instance.target,
  'unlocked': instance.unlocked,
};

_AchivementProgressPage _$AchivementProgressPageFromJson(
  Map<String, dynamic> json,
) => _AchivementProgressPage(
  travelTier: json['travelTier'] == null
      ? null
      : TravelTier.fromJson(json['travelTier'] as Map<String, dynamic>),
  achievements:
      (json['achievements'] as List<dynamic>?)
          ?.map((e) => AchievementProgress.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <AchievementProgress>[],
);

Map<String, dynamic> _$AchivementProgressPageToJson(
  _AchivementProgressPage instance,
) => <String, dynamic>{
  'travelTier': instance.travelTier,
  'achievements': instance.achievements,
};

_AchivementCompletionResult _$AchivementCompletionResultFromJson(
  Map<String, dynamic> json,
) => _AchivementCompletionResult(
  tripId: json['tripId'] as String,
  tripName: json['tripName'] as String? ?? '',
  pointsAwarded: (json['pointsAwarded'] as num?)?.toInt() ?? 0,
  basePoints: (json['basePoints'] as num?)?.toInt() ?? 0,
  missionPoints: (json['missionPoints'] as num?)?.toInt() ?? 0,
  multiplierUsed: (json['multiplierUsed'] as num?)?.toDouble() ?? 1.0,
  missionsCompleted: (json['missionsCompleted'] as num?)?.toInt() ?? 0,
  totalCheckins: (json['totalCheckins'] as num?)?.toInt() ?? 0,
  totalPlaces: (json['totalPlaces'] as num?)?.toInt() ?? 0,
  completionPercent: (json['completionPercent'] as num?)?.toInt() ?? 0,
  tierLabel: json['tierLabel'] as String?,
  nextTierHint: json['nextTierHint'] as String?,
  nextTierProgress: (json['nextTierProgress'] as num?)?.toDouble() ?? 0.0,
);

Map<String, dynamic> _$AchivementCompletionResultToJson(
  _AchivementCompletionResult instance,
) => <String, dynamic>{
  'tripId': instance.tripId,
  'tripName': instance.tripName,
  'pointsAwarded': instance.pointsAwarded,
  'basePoints': instance.basePoints,
  'missionPoints': instance.missionPoints,
  'multiplierUsed': instance.multiplierUsed,
  'missionsCompleted': instance.missionsCompleted,
  'totalCheckins': instance.totalCheckins,
  'totalPlaces': instance.totalPlaces,
  'completionPercent': instance.completionPercent,
  'tierLabel': instance.tierLabel,
  'nextTierHint': instance.nextTierHint,
  'nextTierProgress': instance.nextTierProgress,
};
