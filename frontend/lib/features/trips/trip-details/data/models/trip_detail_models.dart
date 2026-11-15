import 'package:freezed_annotation/freezed_annotation.dart';

part 'trip_detail_models.freezed.dart';
part 'trip_detail_models.g.dart';

@JsonEnum(fieldRename: FieldRename.screamingSnake)
enum TripDetailStatus {
  draft,
  upcoming,
  ongoing,
  completed,
  cancelled,
  @JsonValue('NOTCOMPLETED')
  notCompleted,
}

@JsonEnum(fieldRename: FieldRename.screamingSnake)
enum TripDetailVisibility { public, private }

@JsonEnum(fieldRename: FieldRename.screamingSnake)
enum TripDetailType { solo, couple, family, friends, backpacker, other }

@JsonEnum(fieldRename: FieldRename.screamingSnake)
enum TripDetailBudgetLevel { low, medium, high }

@JsonEnum(fieldRename: FieldRename.screamingSnake)
enum TripDetailMemberRole {
  owner,
  admin,
  member;

  int get _rank => switch (this) {
    TripDetailMemberRole.owner => 2,
    TripDetailMemberRole.admin => 1,
    TripDetailMemberRole.member => 0,
  };

  /// Mirrors the backend kick rule: only strictly lower roles can be removed.
  bool outranks(TripDetailMemberRole other) => _rank > other._rank;
}

@JsonEnum(fieldRename: FieldRename.screamingSnake)
enum TripDetailEventType {
  tripCreated,
  memberJoined,
  memberLeft,
  memberKicked,
  activityAdded,
  activityUpdated,
  activityDeleted,
  activityCheckin,
  expenseCreated,
  expenseSettled,
  photoAdded,
  memoryAdded,
  memoryDeleted,
  system,
}

/// Response of `GET /trips/{id}`.
///
/// [expenseSummary], [memories], [completionReward] and [timeline] are only
/// returned to active members; they are null for visitors of a public trip.
@freezed
abstract class TripDetailOverview with _$TripDetailOverview {
  const TripDetailOverview._();

  const factory TripDetailOverview({
    required String id,
    required String name,
    String? description,
    String? coverImageUrl,
    required TripDetailStatus status,
    required TripDetailVisibility visibility,
    required TripDetailType tripType,
    required DateTime startDate,
    required DateTime endDate,
    required int maxMembers,
    TripDetailBudgetLevel? budgetLevel,
    String? inviteCode,
    required TripDetailViewer viewer,
    TripDetailExpenseSummary? expenseSummary,
    required TripDetailCheckinProgress checkinProgress,
    @Default(<TripDetailMember>[]) List<TripDetailMember> members,
    @Default(<TripDetailDestination>[])
    List<TripDetailDestination> destinations,
    TripDetailNextActivity? nextActivity,
    String? requirements,
    String? estimatedBudgetPerPerson,
    int? slotsRemaining,
    DateTime? expiresAt,
    TripDetailMemoriesPreview? memories,
    TripDetailCompletionReward? completionReward,
    TripDetailTimelinePreview? timeline,
  }) = _TripDetailOverview;

  factory TripDetailOverview.fromJson(Map<String, dynamic> json) =>
      _$TripDetailOverviewFromJson(json);

  bool get isMember => viewer.role != null;

  bool get canManageMembers =>
      viewer.role == TripDetailMemberRole.owner ||
      viewer.role == TripDetailMemberRole.admin;

  bool get canInviteMembers => viewer.role == TripDetailMemberRole.owner;

  /// Owner-only: edit trip fields or permanently delete the trip.
  bool get canEditTrip => viewer.role == TripDetailMemberRole.owner;

  bool get canDeleteTrip => viewer.role == TripDetailMemberRole.owner;

  /// The backend rejects the owner leaving their own trip.
  bool get canLeave => isMember && viewer.role != TripDetailMemberRole.owner;

  /// Owners and admins may remove members with a lower role, never themselves.
  bool canRemove(TripDetailMember member) {
    final role = viewer.role;
    return role != null &&
        canManageMembers &&
        member.userId != viewer.userId &&
        role.outranks(member.role);
  }
}

@freezed
abstract class TripDetailViewer with _$TripDetailViewer {
  const factory TripDetailViewer({
    required String userId,

    /// Null when the viewer is not an active member of the trip.
    TripDetailMemberRole? role,
  }) = _TripDetailViewer;

  factory TripDetailViewer.fromJson(Map<String, dynamic> json) =>
      _$TripDetailViewerFromJson(json);
}

@freezed
abstract class TripDetailExpenseSummary with _$TripDetailExpenseSummary {
  const factory TripDetailExpenseSummary({
    required double totalAmount,
    @Default('VND') String currency,
  }) = _TripDetailExpenseSummary;

  factory TripDetailExpenseSummary.fromJson(Map<String, dynamic> json) =>
      _$TripDetailExpenseSummaryFromJson(json);
}

@freezed
abstract class TripDetailCheckinProgress with _$TripDetailCheckinProgress {
  const TripDetailCheckinProgress._();

  const factory TripDetailCheckinProgress({
    required int completedCount,
    required int totalCount,
    @Default(0) int pointsEarned,
  }) = _TripDetailCheckinProgress;

  factory TripDetailCheckinProgress.fromJson(Map<String, dynamic> json) =>
      _$TripDetailCheckinProgressFromJson(json);

  int get percent =>
      totalCount <= 0 ? 0 : ((completedCount / totalCount) * 100).round();
}

@freezed
abstract class TripDetailMember with _$TripDetailMember {
  const factory TripDetailMember({
    required String id,
    required String userId,
    required String displayName,
    String? avatarUrl,
    required TripDetailMemberRole role,
    required DateTime joinedAt,
    String? travelPersona,
    String? activityNote,
    @Default(false) bool isOnline,
    @Default(false) bool isNewMember,
    double? amountSpent,
    @Default(0) int memoryCount,
  }) = _TripDetailMember;

  factory TripDetailMember.fromJson(Map<String, dynamic> json) =>
      _$TripDetailMemberFromJson(json);
}

@freezed
abstract class TripDetailDestination with _$TripDetailDestination {
  const factory TripDetailDestination({
    required String id,
    required String city,
    required String country,
    required int order,
    required DateTime startDate,
    required DateTime endDate,
    @Default(false) bool isCurrent,
  }) = _TripDetailDestination;

  factory TripDetailDestination.fromJson(Map<String, dynamic> json) =>
      _$TripDetailDestinationFromJson(json);
}

@freezed
abstract class TripDetailNextActivity with _$TripDetailNextActivity {
  const factory TripDetailNextActivity({
    required String id,
    required String title,
    String? description,
    required DateTime startTime,

    /// Active members already checked in at the activity's place.
    @Default(0) int confirmedCount,
    @Default(0) int totalCount,
  }) = _TripDetailNextActivity;

  factory TripDetailNextActivity.fromJson(Map<String, dynamic> json) =>
      _$TripDetailNextActivityFromJson(json);
}

@freezed
abstract class TripDetailMemoriesPreview with _$TripDetailMemoriesPreview {
  const factory TripDetailMemoriesPreview({
    required int totalCount,
    @Default(<TripDetailMemory>[]) List<TripDetailMemory> items,
  }) = _TripDetailMemoriesPreview;

  factory TripDetailMemoriesPreview.fromJson(Map<String, dynamic> json) =>
      _$TripDetailMemoriesPreviewFromJson(json);
}

@freezed
abstract class TripDetailMemory with _$TripDetailMemory {
  const factory TripDetailMemory({
    required String id,
    required String imageUrl,
    String? caption,

    /// Null when the uploader deleted their account.
    String? authorName,
  }) = _TripDetailMemory;

  factory TripDetailMemory.fromJson(Map<String, dynamic> json) =>
      _$TripDetailMemoryFromJson(json);
}

@freezed
abstract class TripDetailCompletionReward with _$TripDetailCompletionReward {
  const factory TripDetailCompletionReward({
    required int points,
    @Default(false) bool canClaim,
    @Default(false) bool claimed,
  }) = _TripDetailCompletionReward;

  factory TripDetailCompletionReward.fromJson(Map<String, dynamic> json) =>
      _$TripDetailCompletionRewardFromJson(json);
}

@freezed
abstract class TripDetailTimelinePreview with _$TripDetailTimelinePreview {
  const factory TripDetailTimelinePreview({
    required int totalCount,
    @Default(<TripDetailTimelineEvent>[]) List<TripDetailTimelineEvent> items,
  }) = _TripDetailTimelinePreview;

  factory TripDetailTimelinePreview.fromJson(Map<String, dynamic> json) =>
      _$TripDetailTimelinePreviewFromJson(json);
}

@freezed
abstract class TripDetailTimelineEvent with _$TripDetailTimelineEvent {
  const factory TripDetailTimelineEvent({
    required String id,
    @JsonKey(unknownEnumValue: TripDetailEventType.system)
    required TripDetailEventType type,
    required String actorName,
    String? actorAvatarUrl,
    required String content,
    required DateTime createdAt,
  }) = _TripDetailTimelineEvent;

  factory TripDetailTimelineEvent.fromJson(Map<String, dynamic> json) =>
      _$TripDetailTimelineEventFromJson(json);
}

/// Response of `POST /trips/{tripId}/completion`.
@freezed
abstract class TripDetailRewardClaim with _$TripDetailRewardClaim {
  const factory TripDetailRewardClaim({
    String? tripId,
    required int pointsAwarded,
    @Default(0) int basePoints,
    @Default(0) int missionPoints,
    @Default(1.0) double multiplierUsed,
    @Default(0) int missionsCompleted,
    @Default(0) int totalCheckins,
    @Default(0) int totalPlaces,
    @Default(0) int completionPercent,
  }) = _TripDetailRewardClaim;

  factory TripDetailRewardClaim.fromJson(Map<String, dynamic> json) =>
      _$TripDetailRewardClaimFromJson(json);
}
