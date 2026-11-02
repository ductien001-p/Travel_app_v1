import 'package:freezed_annotation/freezed_annotation.dart';

part 'trip_publish_models.freezed.dart';
part 'trip_publish_models.g.dart';

enum RecruitmentState {
  @JsonValue('NOT_PUBLISHED')
  notPublished,
  @JsonValue('OPEN')
  open,
  @JsonValue('FULL')
  full,
  @JsonValue('CLOSED')
  closed,
}

@freezed
abstract class RecruitmentSummary with _$RecruitmentSummary {
  const factory RecruitmentSummary({required int activeRecruitmentCount}) =
      _RecruitmentSummary;

  factory RecruitmentSummary.fromJson(Map<String, dynamic> json) =>
      _$RecruitmentSummaryFromJson(json);
}

@freezed
abstract class PublishDraft with _$PublishDraft {
  const factory PublishDraft({
    required String tripId,
    required String name,
    String? description,
    String? coverImageUrl,
    int? draftStep,
    required DateTime startDate,
    required DateTime endDate,
    required int maxMembers,
    String? budgetLevel,
    @Default(false) bool urgent,
    required DateTime updatedAt,
  }) = _PublishDraft;

  factory PublishDraft.fromJson(Map<String, dynamic> json) =>
      _$PublishDraftFromJson(json);
}

@freezed
abstract class RecruitmentMineTrip with _$RecruitmentMineTrip {
  const factory RecruitmentMineTrip({
    required String tripId,
    required String name,
    String? description,
    String? coverImageUrl,
    required DateTime startDate,
    required DateTime endDate,
    required int maxMembers,
    required int memberCount,
    required int pendingRequestCount,
    required int slotsRemaining,
    String? requirements,
    String? estimatedBudgetPerPerson,
    String? budgetLevel,
    DateTime? expiresAt,
    required RecruitmentState effectiveState,
    required bool canPublish,
    @Default(<String>[]) List<String> blockers,
    @Default(<String>[]) List<String> destinationLabels,
    @Default(false) bool urgent,
  }) = _RecruitmentMineTrip;

  factory RecruitmentMineTrip.fromJson(Map<String, dynamic> json) =>
      _$RecruitmentMineTripFromJson(json);
}

@freezed
abstract class RecruitmentMine with _$RecruitmentMine {
  const factory RecruitmentMine({
    required int activeRecruitmentCount,
    PublishDraft? latestPublishDraft,
    @Default(<RecruitmentMineTrip>[]) List<RecruitmentMineTrip> trips,
  }) = _RecruitmentMine;

  factory RecruitmentMine.fromJson(Map<String, dynamic> json) =>
      _$RecruitmentMineFromJson(json);
}

@freezed
abstract class RecruitmentPublishResult with _$RecruitmentPublishResult {
  const factory RecruitmentPublishResult({
    required String tripId,
    required RecruitmentState state,
    required RecruitmentState effectiveState,
    DateTime? publishedAt,
    DateTime? expiresAt,
    required String visibility,
    String? previousVisibility,
  }) = _RecruitmentPublishResult;

  factory RecruitmentPublishResult.fromJson(Map<String, dynamic> json) =>
      _$RecruitmentPublishResultFromJson(json);
}
