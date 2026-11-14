import 'package:freezed_annotation/freezed_annotation.dart';

part 'ranking_models.freezed.dart';
part 'ranking_models.g.dart';

enum RankingPeriod {
  @JsonValue('WEEK')
  week,
  @JsonValue('MONTH')
  month,
  @JsonValue('SEASON')
  season,
  @JsonValue('ALL_TIME')
  allTime,
}

enum RankingQuestAction {
  @JsonValue('START')
  start,
  @JsonValue('CONTINUE')
  continueAction,
  @JsonValue('WRITE')
  write,
}

enum RankingQuestTone {
  @JsonValue('PRIMARY')
  primary,
  @JsonValue('SECONDARY')
  secondary,
  @JsonValue('TERTIARY')
  tertiary,
}

/// Composite UI payload cho màn Bảng Xếp Hạng (Stitch).
@freezed
abstract class RankingPage with _$RankingPage {
  const factory RankingPage({
    @Default('Bảng Xếp Hạng') String seasonLabel,
    @Default('Cập nhật vừa xong') String updatedLabel,
    @Default('Hiển thị Top 4 - 10') String listRangeLabel,
    @Default(0) int questsTotal,
    @Default(RankingPeriod.season) RankingPeriod selectedPeriod,
    @Default(<RankingPeriodOption>[]) List<RankingPeriodOption> periods,
    @Default(<RankingTraveler>[]) List<RankingTraveler> podium,
    RankingMeCard? me,
    @Default(<RankingTraveler>[]) List<RankingTraveler> entries,
    @Default(<RankingQuest>[]) List<RankingQuest> quests,
  }) = _RankingPage;

  factory RankingPage.fromJson(Map<String, dynamic> json) =>
      _$RankingPageFromJson(json);
}

@freezed
abstract class RankingPeriodOption with _$RankingPeriodOption {
  const factory RankingPeriodOption({
    required RankingPeriod id,
    required String label,
  }) = _RankingPeriodOption;

  factory RankingPeriodOption.fromJson(Map<String, dynamic> json) =>
      _$RankingPeriodOptionFromJson(json);
}

@freezed
abstract class RankingTraveler with _$RankingTraveler {
  const factory RankingTraveler({
    required String userId,
    required int rank,
    required String displayName,
    required String username,
    String? avatarUrl,
    String? badgeLabel,
    String? badgeIcon,
    @Default(0) int points,
    @Default(0) int tripsCompleted,
    String? tier,
    @Default(false) bool verified,
    @Default(false) bool highlight,
  }) = _RankingTraveler;

  factory RankingTraveler.fromJson(Map<String, dynamic> json) =>
      _$RankingTravelerFromJson(json);
}

@freezed
abstract class RankingMeCard with _$RankingMeCard {
  const factory RankingMeCard({
    required String userId,
    required int rank,
    required String displayName,
    required String username,
    String? avatarUrl,
    @Default(false) bool verified,
    @Default('Gold Tier') String tierLabel,
    @Default(0) int rankDelta,
    @Default(0) int points,
    @Default(0) int tripsCompleted,
    @Default('Bạch Kim (Top 10)') String nextTierLabel,
    @Default(0) int nextTierPoints,
    @Default('') String progressHint,
  }) = _RankingMeCard;

  factory RankingMeCard.fromJson(Map<String, dynamic> json) =>
      _$RankingMeCardFromJson(json);
}

@freezed
abstract class RankingQuest with _$RankingQuest {
  const factory RankingQuest({
    required String id,
    @Default('') String code,
    required String title,
    required String subtitle,
    required String icon,
    @Default(0) int pointsReward,
    @Default(RankingQuestAction.start) RankingQuestAction action,
    @Default(RankingQuestTone.primary) RankingQuestTone tone,
    int? progressCurrent,
    int? progressTarget,
    @Default(false) bool claimed,
    @Default(false) bool claimable,
  }) = _RankingQuest;

  factory RankingQuest.fromJson(Map<String, dynamic> json) =>
      _$RankingQuestFromJson(json);
}
