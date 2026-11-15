import 'package:freezed_annotation/freezed_annotation.dart';

part 'achivement_models.freezed.dart';
part 'achivement_models.g.dart';

enum TripMissionGroup {
  @JsonValue('EXPLORATION')
  exploration,
  @JsonValue('FOOD')
  food,
  @JsonValue('CULTURE')
  culture,
  @JsonValue('ADVENTURE')
  adventure,
  @JsonValue('NATURE')
  nature,
  @JsonValue('SOCIAL')
  social,
  @JsonValue('EXPERIENCE')
  experience,
  @JsonValue('RESPONSIBLE')
  responsible,
}

enum TripMissionVerifyType {
  @JsonValue('CHECKIN_COUNT')
  checkinCount,
  @JsonValue('CHECKIN_NEW_CITY')
  checkinNewCity,
  @JsonValue('CHECKIN_PLACE_CATEGORY')
  checkinPlaceCategory,
  @JsonValue('MEMORY_COUNT')
  memoryCount,
}

enum TripMissionCta {
  @JsonValue('ITINERARY')
  itinerary,
  @JsonValue('MEMORIES')
  memories,
}

/// `GET /trips/{tripId}/missions` page payload.
@freezed
abstract class TripMissionsPage with _$TripMissionsPage {
  const TripMissionsPage._();

  const factory TripMissionsPage({
    @Default(0) int completedCount,
    @Default(0) int totalCount,
    @Default(0) int missionPointsEarned,
    @Default(80) int missionPointsCap,
    @Default(0) int missionPointsPending,
    @Default(<TripMissionItem>[]) List<TripMissionItem> items,
  }) = _TripMissionsPage;

  factory TripMissionsPage.fromJson(Map<String, dynamic> json) =>
      _$TripMissionsPageFromJson(json);

  double get progressRatio {
    if (totalCount <= 0) return 0;
    return (completedCount / totalCount).clamp(0.0, 1.0);
  }
}

@freezed
abstract class TripMissionItem with _$TripMissionItem {
  const TripMissionItem._();

  const factory TripMissionItem({
    required String id,
    required String code,
    @JsonKey(unknownEnumValue: TripMissionGroup.exploration)
    @Default(TripMissionGroup.exploration)
    TripMissionGroup group,
    required String title,
    @Default('') String subtitle,
    @Default('explore') String icon,
    @JsonKey(unknownEnumValue: TripMissionVerifyType.checkinCount)
    @Default(TripMissionVerifyType.checkinCount)
    TripMissionVerifyType verifyType,
    @Default(0) int pointsReward,
    @Default(0) int progressCurrent,
    @Default(1) int progressTarget,
    @Default(false) bool completed,
    @JsonKey(unknownEnumValue: TripMissionCta.itinerary)
    @Default(TripMissionCta.itinerary)
    TripMissionCta cta,
  }) = _TripMissionItem;

  factory TripMissionItem.fromJson(Map<String, dynamic> json) =>
      _$TripMissionItemFromJson(json);

  double get progressRatio {
    if (progressTarget <= 0) return completed ? 1 : 0;
    return (progressCurrent / progressTarget).clamp(0.0, 1.0);
  }
}

/// Travel tier embedded in `GET /ranking/me`.
@freezed
abstract class TravelTier with _$TravelTier {
  const TravelTier._();

  const factory TravelTier({
    required String code,
    required String label,
    @Default(1.0) double multiplier,
    @Default(0) int tripsCompleted,
    @Default(0) int distinctCities,
    TravelTierNext? next,
  }) = _TravelTier;

  factory TravelTier.fromJson(Map<String, dynamic> json) =>
      _$TravelTierFromJson(json);
}

@freezed
abstract class TravelTierNext with _$TravelTierNext {
  const factory TravelTierNext({
    required String code,
    @Default(1.0) double multiplier,
    @Default(0) int tripsRemaining,
    @Default(0) int citiesRemaining,
  }) = _TravelTierNext;

  factory TravelTierNext.fromJson(Map<String, dynamic> json) =>
      _$TravelTierNextFromJson(json);
}

@freezed
abstract class AchievementProgress with _$AchievementProgress {
  const AchievementProgress._();

  const factory AchievementProgress({
    required String code,
    required String title,
    @Default('COMMON') String rarity,
    @Default(0) int current,
    @Default(1) int target,
    @Default(false) bool unlocked,
  }) = _AchievementProgress;

  factory AchievementProgress.fromJson(Map<String, dynamic> json) =>
      _$AchievementProgressFromJson(json);

  double get progressRatio {
    if (target <= 0) return unlocked ? 1 : 0;
    return (current / target).clamp(0.0, 1.0);
  }
}

/// Composite payload for Ranking travel-tier + achievements section.
@freezed
abstract class AchivementProgressPage with _$AchivementProgressPage {
  const factory AchivementProgressPage({
    TravelTier? travelTier,
    @Default(<AchievementProgress>[]) List<AchievementProgress> achievements,
  }) = _AchivementProgressPage;

  factory AchivementProgressPage.fromJson(Map<String, dynamic> json) =>
      _$AchivementProgressPageFromJson(json);
}

/// Breakdown from `POST /trips/{tripId}/completion`.
@freezed
abstract class AchivementCompletionResult with _$AchivementCompletionResult {
  const AchivementCompletionResult._();

  const factory AchivementCompletionResult({
    required String tripId,
    @Default('') String tripName,
    @Default(0) int pointsAwarded,
    @Default(0) int basePoints,
    @Default(0) int missionPoints,
    @Default(1.0) double multiplierUsed,
    @Default(0) int missionsCompleted,
    @Default(0) int totalCheckins,
    @Default(0) int totalPlaces,
    @Default(0) int completionPercent,
    String? tierLabel,
    String? nextTierHint,
    @Default(0.0) double nextTierProgress,
  }) = _AchivementCompletionResult;

  factory AchivementCompletionResult.fromJson(Map<String, dynamic> json) =>
      _$AchivementCompletionResultFromJson(json);

  String get formulaLabel =>
      '($basePoints + $missionPoints) × $multiplierUsed = $pointsAwarded điểm';
}
