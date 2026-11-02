import 'package:freezed_annotation/freezed_annotation.dart';

part 'trip_timeline_models.freezed.dart';
part 'trip_timeline_models.g.dart';

@JsonEnum(fieldRename: FieldRename.screamingSnake)
enum TripTimelineEntryType {
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

/// Resource an event points at, opened by the "Xem chi tiết" action.
@JsonEnum(fieldRename: FieldRename.screamingSnake)
enum TripTimelineTargetType { trip, member, activity, expense, memory }

@JsonEnum(fieldRename: FieldRename.screamingSnake)
enum TripTimelineJoinVia { inviteCode, invitation, joinRequest }

@JsonEnum(fieldRename: FieldRename.screamingSnake)
enum TripTimelineSplitType { equal, custom }

/// One page of `GET /trips/timeline/{tripId}`, newest event first.
@freezed
abstract class TripTimelinePage with _$TripTimelinePage {
  const factory TripTimelinePage({
    @JsonKey(name: 'data')
    @Default(<TripTimelineEntry>[])
    List<TripTimelineEntry> items,
    required TripTimelineCursor meta,
  }) = _TripTimelinePage;

  factory TripTimelinePage.fromJson(Map<String, dynamic> json) =>
      _$TripTimelinePageFromJson(json);
}

@freezed
abstract class TripTimelineCursor with _$TripTimelineCursor {
  const factory TripTimelineCursor({
    String? nextCursor,
    @Default(false) bool hasMore,

    /// Totals of the whole trip per filter chip; only sent with the first page.
    TripTimelineCounts? counts,
  }) = _TripTimelineCursor;

  factory TripTimelineCursor.fromJson(Map<String, dynamic> json) =>
      _$TripTimelineCursorFromJson(json);
}

@freezed
abstract class TripTimelineCounts with _$TripTimelineCounts {
  const factory TripTimelineCounts({
    @Default(0) int all,
    @Default(0) int checkin,
    @Default(0) int expense,
    @Default(0) int memory,
    @Default(0) int member,
  }) = _TripTimelineCounts;

  factory TripTimelineCounts.fromJson(Map<String, dynamic> json) =>
      _$TripTimelineCountsFromJson(json);
}

/// Same shape for the REST page and the `trip:timeline` socket event.
@freezed
abstract class TripTimelineEntry with _$TripTimelineEntry {
  const factory TripTimelineEntry({
    required String id,
    required String tripId,
    required String memberId,
    @JsonKey(unknownEnumValue: TripTimelineEntryType.system)
    required TripTimelineEntryType type,
    required String content,
    required DateTime createdAt,
    required TripTimelineEntryMember member,
    @JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue)
    TripTimelineTargetType? targetType,
    String? targetId,

    /// Null for events recorded before the backend stored metadata.
    TripTimelineEntryMetadata? metadata,
  }) = _TripTimelineEntry;

  factory TripTimelineEntry.fromJson(Map<String, dynamic> json) =>
      _$TripTimelineEntryFromJson(json);
}

@freezed
abstract class TripTimelineEntryMember with _$TripTimelineEntryMember {
  const factory TripTimelineEntryMember({
    required String id,
    required TripTimelineEntryUser user,
  }) = _TripTimelineEntryMember;

  factory TripTimelineEntryMember.fromJson(Map<String, dynamic> json) =>
      _$TripTimelineEntryMemberFromJson(json);
}

@freezed
abstract class TripTimelineEntryUser with _$TripTimelineEntryUser {
  const TripTimelineEntryUser._();

  const factory TripTimelineEntryUser({
    required String id,
    required String username,
    String? displayName,
    String? avatarUrl,
  }) = _TripTimelineEntryUser;

  factory TripTimelineEntryUser.fromJson(Map<String, dynamic> json) =>
      _$TripTimelineEntryUserFromJson(json);

  String get name {
    final display = displayName?.trim();
    return display == null || display.isEmpty ? username : display;
  }
}

/// Type-specific snapshot taken when the event happened. Every field is
/// optional; which ones are present depends on the event type.
@freezed
abstract class TripTimelineEntryMetadata with _$TripTimelineEntryMetadata {
  const factory TripTimelineEntryMetadata({
    // TRIP_CREATED
    String? tripName,
    DateTime? startDate,
    DateTime? endDate,
    int? destinationCount,

    // MEMBER_JOINED / MEMBER_KICKED
    @JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue)
    TripTimelineJoinVia? via,
    String? targetMemberId,
    String? targetName,

    // ACTIVITY_*
    String? activityTitle,
    String? placeName,
    String? placeArea,
    int? dayNumber,
    DateTime? startTime,
    DateTime? previousStartTime,
    double? latitude,
    double? longitude,
    String? imageUrl,
    @Default(false) bool verified,
    int? pointsEarned,

    // EXPENSE_*
    @JsonKey(fromJson: _moneyFromJson) double? amount,
    @Default('VND') String currency,
    String? category,
    String? description,
    @JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue)
    TripTimelineSplitType? splitType,
    int? splitCount,
    String? payerMemberId,
    String? payerName,
    String? debtorMemberId,
    String? debtorName,

    // MEMORY_ADDED
    @Default(<String>[]) List<String> memoryIds,
    @Default(<String>[]) List<String> photoUrls,
    int? photoCount,
    String? caption,
  }) = _TripTimelineEntryMetadata;

  factory TripTimelineEntryMetadata.fromJson(Map<String, dynamic> json) =>
      _$TripTimelineEntryMetadataFromJson(json);
}

/// Money is sent as a base-10 string ("1200000.00") to keep precision.
double? _moneyFromJson(Object? value) => switch (value) {
  num() => value.toDouble(),
  String() => double.tryParse(value),
  _ => null,
};
