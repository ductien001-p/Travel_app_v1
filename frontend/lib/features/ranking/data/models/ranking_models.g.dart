// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ranking_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RankingPage _$RankingPageFromJson(Map<String, dynamic> json) => _RankingPage(
  seasonLabel: json['seasonLabel'] as String? ?? 'Bảng Xếp Hạng',
  updatedLabel: json['updatedLabel'] as String? ?? 'Cập nhật vừa xong',
  listRangeLabel: json['listRangeLabel'] as String? ?? 'Hiển thị Top 4 - 10',
  questsTotal: (json['questsTotal'] as num?)?.toInt() ?? 0,
  selectedPeriod:
      $enumDecodeNullable(_$RankingPeriodEnumMap, json['selectedPeriod']) ??
      RankingPeriod.season,
  periods:
      (json['periods'] as List<dynamic>?)
          ?.map((e) => RankingPeriodOption.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <RankingPeriodOption>[],
  podium:
      (json['podium'] as List<dynamic>?)
          ?.map((e) => RankingTraveler.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <RankingTraveler>[],
  me: json['me'] == null
      ? null
      : RankingMeCard.fromJson(json['me'] as Map<String, dynamic>),
  entries:
      (json['entries'] as List<dynamic>?)
          ?.map((e) => RankingTraveler.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <RankingTraveler>[],
  quests:
      (json['quests'] as List<dynamic>?)
          ?.map((e) => RankingQuest.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <RankingQuest>[],
);

Map<String, dynamic> _$RankingPageToJson(_RankingPage instance) =>
    <String, dynamic>{
      'seasonLabel': instance.seasonLabel,
      'updatedLabel': instance.updatedLabel,
      'listRangeLabel': instance.listRangeLabel,
      'questsTotal': instance.questsTotal,
      'selectedPeriod': _$RankingPeriodEnumMap[instance.selectedPeriod]!,
      'periods': instance.periods,
      'podium': instance.podium,
      'me': instance.me,
      'entries': instance.entries,
      'quests': instance.quests,
    };

const _$RankingPeriodEnumMap = {
  RankingPeriod.week: 'WEEK',
  RankingPeriod.month: 'MONTH',
  RankingPeriod.season: 'SEASON',
  RankingPeriod.allTime: 'ALL_TIME',
};

_RankingPeriodOption _$RankingPeriodOptionFromJson(Map<String, dynamic> json) =>
    _RankingPeriodOption(
      id: $enumDecode(_$RankingPeriodEnumMap, json['id']),
      label: json['label'] as String,
    );

Map<String, dynamic> _$RankingPeriodOptionToJson(
  _RankingPeriodOption instance,
) => <String, dynamic>{
  'id': _$RankingPeriodEnumMap[instance.id]!,
  'label': instance.label,
};

_RankingTraveler _$RankingTravelerFromJson(Map<String, dynamic> json) =>
    _RankingTraveler(
      userId: json['userId'] as String,
      rank: (json['rank'] as num).toInt(),
      displayName: json['displayName'] as String,
      username: json['username'] as String,
      avatarUrl: json['avatarUrl'] as String?,
      badgeLabel: json['badgeLabel'] as String?,
      badgeIcon: json['badgeIcon'] as String?,
      points: (json['points'] as num?)?.toInt() ?? 0,
      tripsCompleted: (json['tripsCompleted'] as num?)?.toInt() ?? 0,
      tier: json['tier'] as String?,
      verified: json['verified'] as bool? ?? false,
      highlight: json['highlight'] as bool? ?? false,
    );

Map<String, dynamic> _$RankingTravelerToJson(_RankingTraveler instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'rank': instance.rank,
      'displayName': instance.displayName,
      'username': instance.username,
      'avatarUrl': instance.avatarUrl,
      'badgeLabel': instance.badgeLabel,
      'badgeIcon': instance.badgeIcon,
      'points': instance.points,
      'tripsCompleted': instance.tripsCompleted,
      'tier': instance.tier,
      'verified': instance.verified,
      'highlight': instance.highlight,
    };

_RankingMeCard _$RankingMeCardFromJson(Map<String, dynamic> json) =>
    _RankingMeCard(
      userId: json['userId'] as String,
      rank: (json['rank'] as num).toInt(),
      displayName: json['displayName'] as String,
      username: json['username'] as String,
      avatarUrl: json['avatarUrl'] as String?,
      verified: json['verified'] as bool? ?? false,
      tierLabel: json['tierLabel'] as String? ?? 'Gold Tier',
      rankDelta: (json['rankDelta'] as num?)?.toInt() ?? 0,
      points: (json['points'] as num?)?.toInt() ?? 0,
      tripsCompleted: (json['tripsCompleted'] as num?)?.toInt() ?? 0,
      nextTierLabel: json['nextTierLabel'] as String? ?? 'Bạch Kim (Top 10)',
      nextTierPoints: (json['nextTierPoints'] as num?)?.toInt() ?? 0,
      progressHint: json['progressHint'] as String? ?? '',
    );

Map<String, dynamic> _$RankingMeCardToJson(_RankingMeCard instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'rank': instance.rank,
      'displayName': instance.displayName,
      'username': instance.username,
      'avatarUrl': instance.avatarUrl,
      'verified': instance.verified,
      'tierLabel': instance.tierLabel,
      'rankDelta': instance.rankDelta,
      'points': instance.points,
      'tripsCompleted': instance.tripsCompleted,
      'nextTierLabel': instance.nextTierLabel,
      'nextTierPoints': instance.nextTierPoints,
      'progressHint': instance.progressHint,
    };

_RankingQuest _$RankingQuestFromJson(Map<String, dynamic> json) =>
    _RankingQuest(
      id: json['id'] as String,
      code: json['code'] as String? ?? '',
      title: json['title'] as String,
      subtitle: json['subtitle'] as String,
      icon: json['icon'] as String,
      pointsReward: (json['pointsReward'] as num?)?.toInt() ?? 0,
      action:
          $enumDecodeNullable(_$RankingQuestActionEnumMap, json['action']) ??
          RankingQuestAction.start,
      tone:
          $enumDecodeNullable(_$RankingQuestToneEnumMap, json['tone']) ??
          RankingQuestTone.primary,
      progressCurrent: (json['progressCurrent'] as num?)?.toInt(),
      progressTarget: (json['progressTarget'] as num?)?.toInt(),
      claimed: json['claimed'] as bool? ?? false,
      claimable: json['claimable'] as bool? ?? false,
    );

Map<String, dynamic> _$RankingQuestToJson(_RankingQuest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'title': instance.title,
      'subtitle': instance.subtitle,
      'icon': instance.icon,
      'pointsReward': instance.pointsReward,
      'action': _$RankingQuestActionEnumMap[instance.action]!,
      'tone': _$RankingQuestToneEnumMap[instance.tone]!,
      'progressCurrent': instance.progressCurrent,
      'progressTarget': instance.progressTarget,
      'claimed': instance.claimed,
      'claimable': instance.claimable,
    };

const _$RankingQuestActionEnumMap = {
  RankingQuestAction.start: 'START',
  RankingQuestAction.continueAction: 'CONTINUE',
  RankingQuestAction.write: 'WRITE',
};

const _$RankingQuestToneEnumMap = {
  RankingQuestTone.primary: 'PRIMARY',
  RankingQuestTone.secondary: 'SECONDARY',
  RankingQuestTone.tertiary: 'TERTIARY',
};
