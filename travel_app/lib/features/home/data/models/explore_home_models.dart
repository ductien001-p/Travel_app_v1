import 'package:freezed_annotation/freezed_annotation.dart';

part 'explore_home_models.freezed.dart';
part 'explore_home_models.g.dart';

@freezed
abstract class ExploreHomeFeed with _$ExploreHomeFeed {
  const factory ExploreHomeFeed({
    required ExploreHomeHeader header,
    required List<ExploreFilterChip> filters,
    required List<CommunityTripCard> hotTrips,
    required List<ExploreDestination> destinations,
    required List<LiveTripUpdate> liveTrips,
    @Default(1) int page,
    @Default(false) bool hasNextPage,
    @Default(false) bool catalogUnavailable,
  }) = _ExploreHomeFeed;

  factory ExploreHomeFeed.fromJson(Map<String, dynamic> json) =>
      _$ExploreHomeFeedFromJson(json);
}

@freezed
abstract class ExploreHomeHeader with _$ExploreHomeHeader {
  const factory ExploreHomeHeader({
    required String displayName,
    String? avatarUrl,
    required String locationLabel,
    @Default(false) bool hasUnreadNotifications,
  }) = _ExploreHomeHeader;

  factory ExploreHomeHeader.fromJson(Map<String, dynamic> json) =>
      _$ExploreHomeHeaderFromJson(json);
}

@freezed
abstract class ExploreFilterChip with _$ExploreFilterChip {
  const factory ExploreFilterChip({required String id, required String label}) =
      _ExploreFilterChip;

  factory ExploreFilterChip.fromJson(Map<String, dynamic> json) =>
      _$ExploreFilterChipFromJson(json);
}

@freezed
abstract class CommunityTripAuthor with _$CommunityTripAuthor {
  const factory CommunityTripAuthor({
    required String name,
    required String handle,
    String? avatarUrl,
    String? badgeLabel,
  }) = _CommunityTripAuthor;

  factory CommunityTripAuthor.fromJson(Map<String, dynamic> json) =>
      _$CommunityTripAuthorFromJson(json);
}

@freezed
abstract class CommunityTripCard with _$CommunityTripCard {
  const factory CommunityTripCard({
    required String id,
    required CommunityTripAuthor author,
    required String coverUrl,
    required List<String> badges,
    required String durationLabel,
    required String title,
    required String dateLabel,
    required String costLabel,
    required String departureLabel,
    required int memberCount,
    required int capacity,
    required List<String> memberAvatars,
    @Default(<String>[]) List<String> filterTags,
    @Default(false) bool recruiting,
    String? requirements,
    String? estimatedBudgetPerPerson,
    int? slotsRemaining,
    DateTime? expiresAt,
    int? matchScore,
    @Default(false) bool urgent,
  }) = _CommunityTripCard;

  factory CommunityTripCard.fromJson(Map<String, dynamic> json) =>
      _$CommunityTripCardFromJson(json);
}

@freezed
abstract class ExploreDestination with _$ExploreDestination {
  const factory ExploreDestination({
    required String id,
    required String name,
    required String imageUrl,
    required int openTripCount,
  }) = _ExploreDestination;

  factory ExploreDestination.fromJson(Map<String, dynamic> json) =>
      _$ExploreDestinationFromJson(json);
}

@freezed
abstract class LiveTripUpdate with _$LiveTripUpdate {
  const factory LiveTripUpdate({
    required String id,
    required String title,
    required String placeLabel,
    required int memberCount,
    required int minutesAgo,
  }) = _LiveTripUpdate;

  factory LiveTripUpdate.fromJson(Map<String, dynamic> json) =>
      _$LiveTripUpdateFromJson(json);
}
