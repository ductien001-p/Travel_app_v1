import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_showcase_models.freezed.dart';
part 'profile_showcase_models.g.dart';

@freezed
abstract class ProfileShowcase with _$ProfileShowcase {
  const factory ProfileShowcase({
    required String hostStatus,
    required ProfileShowcaseRanking ranking,
    required ProfileSocialStats social,
    required ProfileTravelDna travelDna,
    ProfileShowcaseTrip? ongoingTrip,
    ProfileShowcaseTrip? upcomingTrip,
    required ProfileShowcaseMemories memories,
    required ProfileShowcaseSavedPlaces savedPlaces,
    required ProfileShowcasePosts posts,
  }) = _ProfileShowcase;

  factory ProfileShowcase.fromJson(Map<String, dynamic> json) =>
      _$ProfileShowcaseFromJson(json);
}

@freezed
abstract class ProfileShowcaseRanking with _$ProfileShowcaseRanking {
  const factory ProfileShowcaseRanking({
    required String userId,
    required int totalPoints,
    required int totalTripsCompleted,
    required String rank,
    int? ranking,
    int? percentile,
  }) = _ProfileShowcaseRanking;

  factory ProfileShowcaseRanking.fromJson(Map<String, dynamic> json) =>
      _$ProfileShowcaseRankingFromJson(json);
}

@freezed
abstract class ProfileSocialStats with _$ProfileSocialStats {
  const factory ProfileSocialStats({
    required int tripCount,
    required int followerCount,
    required int followingCount,
  }) = _ProfileSocialStats;

  factory ProfileSocialStats.fromJson(Map<String, dynamic> json) =>
      _$ProfileSocialStatsFromJson(json);
}

@freezed
abstract class ProfileTravelDna with _$ProfileTravelDna {
  const factory ProfileTravelDna({
    ProfileTravelDnaBadge? dominant,
    required List<ProfileTravelDnaBadge> topBadges,
    required List<ProfileTravelDnaBadge> all,
  }) = _ProfileTravelDna;

  factory ProfileTravelDna.fromJson(Map<String, dynamic> json) =>
      _$ProfileTravelDnaFromJson(json);
}

@freezed
abstract class ProfileTravelDnaBadge with _$ProfileTravelDnaBadge {
  const factory ProfileTravelDnaBadge({
    required String type,
    required String name,
    required String icon,
    required String description,
    required int score,
    required int tripTypeCount,
    required int activityCount,
    required String createdAt,
    required String updatedAt,
  }) = _ProfileTravelDnaBadge;

  factory ProfileTravelDnaBadge.fromJson(Map<String, dynamic> json) =>
      _$ProfileTravelDnaBadgeFromJson(json);
}

@freezed
abstract class ProfileShowcaseTrip with _$ProfileShowcaseTrip {
  const factory ProfileShowcaseTrip({
    required String id,
    required String name,
    String? coverImageUrl,
    required String status,
    required String startDate,
    required String endDate,
    String? budgetLevel,
    required int maxMembers,
    required int memberCount,
    required int totalActivities,
    required int completedActivities,
    required List<String> highlights,
  }) = _ProfileShowcaseTrip;

  factory ProfileShowcaseTrip.fromJson(Map<String, dynamic> json) =>
      _$ProfileShowcaseTripFromJson(json);
}

@freezed
abstract class ProfileShowcaseMemories with _$ProfileShowcaseMemories {
  const factory ProfileShowcaseMemories({
    required int totalCount,
    required List<ProfileShowcaseMemory> items,
  }) = _ProfileShowcaseMemories;

  factory ProfileShowcaseMemories.fromJson(Map<String, dynamic> json) =>
      _$ProfileShowcaseMemoriesFromJson(json);
}

@freezed
abstract class ProfileShowcaseMemory with _$ProfileShowcaseMemory {
  const factory ProfileShowcaseMemory({
    required String id,
    required String imageUrl,
  }) = _ProfileShowcaseMemory;

  factory ProfileShowcaseMemory.fromJson(Map<String, dynamic> json) =>
      _$ProfileShowcaseMemoryFromJson(json);
}

@freezed
abstract class ProfileShowcaseSavedPlaces with _$ProfileShowcaseSavedPlaces {
  const factory ProfileShowcaseSavedPlaces({
    required int count,
    required List<ProfileShowcaseSavedPlace> items,
  }) = _ProfileShowcaseSavedPlaces;

  factory ProfileShowcaseSavedPlaces.fromJson(Map<String, dynamic> json) =>
      _$ProfileShowcaseSavedPlacesFromJson(json);
}

@freezed
abstract class ProfileShowcaseSavedPlace with _$ProfileShowcaseSavedPlace {
  const factory ProfileShowcaseSavedPlace({
    required String id,
    required String placeId,
    required String name,
    required String city,
    required String country,
    required String category,
    String? coverImageUrl,
  }) = _ProfileShowcaseSavedPlace;

  factory ProfileShowcaseSavedPlace.fromJson(Map<String, dynamic> json) =>
      _$ProfileShowcaseSavedPlaceFromJson(json);
}

@freezed
abstract class ProfileShowcasePosts with _$ProfileShowcasePosts {
  const factory ProfileShowcasePosts({
    required int count,
    required List<ProfileShowcasePost> items,
  }) = _ProfileShowcasePosts;

  factory ProfileShowcasePosts.fromJson(Map<String, dynamic> json) =>
      _$ProfileShowcasePostsFromJson(json);
}

@freezed
abstract class ProfileShowcasePost with _$ProfileShowcasePost {
  const factory ProfileShowcasePost({
    required String id,
    String? caption,
    String? imageUrl,
  }) = _ProfileShowcasePost;

  factory ProfileShowcasePost.fromJson(Map<String, dynamic> json) =>
      _$ProfileShowcasePostFromJson(json);
}
