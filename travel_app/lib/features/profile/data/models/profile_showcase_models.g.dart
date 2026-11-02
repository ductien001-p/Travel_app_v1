// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_showcase_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProfileShowcase _$ProfileShowcaseFromJson(
  Map<String, dynamic> json,
) => _ProfileShowcase(
  hostStatus: json['hostStatus'] as String,
  ranking: ProfileShowcaseRanking.fromJson(
    json['ranking'] as Map<String, dynamic>,
  ),
  social: ProfileSocialStats.fromJson(json['social'] as Map<String, dynamic>),
  travelDna: ProfileTravelDna.fromJson(
    json['travelDna'] as Map<String, dynamic>,
  ),
  ongoingTrip: json['ongoingTrip'] == null
      ? null
      : ProfileShowcaseTrip.fromJson(
          json['ongoingTrip'] as Map<String, dynamic>,
        ),
  upcomingTrip: json['upcomingTrip'] == null
      ? null
      : ProfileShowcaseTrip.fromJson(
          json['upcomingTrip'] as Map<String, dynamic>,
        ),
  memories: ProfileShowcaseMemories.fromJson(
    json['memories'] as Map<String, dynamic>,
  ),
  savedPlaces: ProfileShowcaseSavedPlaces.fromJson(
    json['savedPlaces'] as Map<String, dynamic>,
  ),
  posts: ProfileShowcasePosts.fromJson(json['posts'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ProfileShowcaseToJson(_ProfileShowcase instance) =>
    <String, dynamic>{
      'hostStatus': instance.hostStatus,
      'ranking': instance.ranking,
      'social': instance.social,
      'travelDna': instance.travelDna,
      'ongoingTrip': instance.ongoingTrip,
      'upcomingTrip': instance.upcomingTrip,
      'memories': instance.memories,
      'savedPlaces': instance.savedPlaces,
      'posts': instance.posts,
    };

_ProfileShowcaseRanking _$ProfileShowcaseRankingFromJson(
  Map<String, dynamic> json,
) => _ProfileShowcaseRanking(
  userId: json['userId'] as String,
  totalPoints: (json['totalPoints'] as num).toInt(),
  totalTripsCompleted: (json['totalTripsCompleted'] as num).toInt(),
  rank: json['rank'] as String,
  ranking: (json['ranking'] as num?)?.toInt(),
  percentile: (json['percentile'] as num?)?.toInt(),
);

Map<String, dynamic> _$ProfileShowcaseRankingToJson(
  _ProfileShowcaseRanking instance,
) => <String, dynamic>{
  'userId': instance.userId,
  'totalPoints': instance.totalPoints,
  'totalTripsCompleted': instance.totalTripsCompleted,
  'rank': instance.rank,
  'ranking': instance.ranking,
  'percentile': instance.percentile,
};

_ProfileSocialStats _$ProfileSocialStatsFromJson(Map<String, dynamic> json) =>
    _ProfileSocialStats(
      tripCount: (json['tripCount'] as num).toInt(),
      followerCount: (json['followerCount'] as num).toInt(),
      followingCount: (json['followingCount'] as num).toInt(),
    );

Map<String, dynamic> _$ProfileSocialStatsToJson(_ProfileSocialStats instance) =>
    <String, dynamic>{
      'tripCount': instance.tripCount,
      'followerCount': instance.followerCount,
      'followingCount': instance.followingCount,
    };

_ProfileTravelDna _$ProfileTravelDnaFromJson(Map<String, dynamic> json) =>
    _ProfileTravelDna(
      dominant: json['dominant'] == null
          ? null
          : ProfileTravelDnaBadge.fromJson(
              json['dominant'] as Map<String, dynamic>,
            ),
      topBadges: (json['topBadges'] as List<dynamic>)
          .map((e) => ProfileTravelDnaBadge.fromJson(e as Map<String, dynamic>))
          .toList(),
      all: (json['all'] as List<dynamic>)
          .map((e) => ProfileTravelDnaBadge.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProfileTravelDnaToJson(_ProfileTravelDna instance) =>
    <String, dynamic>{
      'dominant': instance.dominant,
      'topBadges': instance.topBadges,
      'all': instance.all,
    };

_ProfileTravelDnaBadge _$ProfileTravelDnaBadgeFromJson(
  Map<String, dynamic> json,
) => _ProfileTravelDnaBadge(
  type: json['type'] as String,
  name: json['name'] as String,
  icon: json['icon'] as String,
  description: json['description'] as String,
  score: (json['score'] as num).toInt(),
  tripTypeCount: (json['tripTypeCount'] as num).toInt(),
  activityCount: (json['activityCount'] as num).toInt(),
  createdAt: json['createdAt'] as String,
  updatedAt: json['updatedAt'] as String,
);

Map<String, dynamic> _$ProfileTravelDnaBadgeToJson(
  _ProfileTravelDnaBadge instance,
) => <String, dynamic>{
  'type': instance.type,
  'name': instance.name,
  'icon': instance.icon,
  'description': instance.description,
  'score': instance.score,
  'tripTypeCount': instance.tripTypeCount,
  'activityCount': instance.activityCount,
  'createdAt': instance.createdAt,
  'updatedAt': instance.updatedAt,
};

_ProfileShowcaseTrip _$ProfileShowcaseTripFromJson(Map<String, dynamic> json) =>
    _ProfileShowcaseTrip(
      id: json['id'] as String,
      name: json['name'] as String,
      coverImageUrl: json['coverImageUrl'] as String?,
      status: json['status'] as String,
      startDate: json['startDate'] as String,
      endDate: json['endDate'] as String,
      budgetLevel: json['budgetLevel'] as String?,
      maxMembers: (json['maxMembers'] as num).toInt(),
      memberCount: (json['memberCount'] as num).toInt(),
      totalActivities: (json['totalActivities'] as num).toInt(),
      completedActivities: (json['completedActivities'] as num).toInt(),
      highlights: (json['highlights'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$ProfileShowcaseTripToJson(
  _ProfileShowcaseTrip instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'coverImageUrl': instance.coverImageUrl,
  'status': instance.status,
  'startDate': instance.startDate,
  'endDate': instance.endDate,
  'budgetLevel': instance.budgetLevel,
  'maxMembers': instance.maxMembers,
  'memberCount': instance.memberCount,
  'totalActivities': instance.totalActivities,
  'completedActivities': instance.completedActivities,
  'highlights': instance.highlights,
};

_ProfileShowcaseMemories _$ProfileShowcaseMemoriesFromJson(
  Map<String, dynamic> json,
) => _ProfileShowcaseMemories(
  totalCount: (json['totalCount'] as num).toInt(),
  items: (json['items'] as List<dynamic>)
      .map((e) => ProfileShowcaseMemory.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$ProfileShowcaseMemoriesToJson(
  _ProfileShowcaseMemories instance,
) => <String, dynamic>{
  'totalCount': instance.totalCount,
  'items': instance.items,
};

_ProfileShowcaseMemory _$ProfileShowcaseMemoryFromJson(
  Map<String, dynamic> json,
) => _ProfileShowcaseMemory(
  id: json['id'] as String,
  imageUrl: json['imageUrl'] as String,
);

Map<String, dynamic> _$ProfileShowcaseMemoryToJson(
  _ProfileShowcaseMemory instance,
) => <String, dynamic>{'id': instance.id, 'imageUrl': instance.imageUrl};

_ProfileShowcaseSavedPlaces _$ProfileShowcaseSavedPlacesFromJson(
  Map<String, dynamic> json,
) => _ProfileShowcaseSavedPlaces(
  count: (json['count'] as num).toInt(),
  items: (json['items'] as List<dynamic>)
      .map((e) => ProfileShowcaseSavedPlace.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$ProfileShowcaseSavedPlacesToJson(
  _ProfileShowcaseSavedPlaces instance,
) => <String, dynamic>{'count': instance.count, 'items': instance.items};

_ProfileShowcaseSavedPlace _$ProfileShowcaseSavedPlaceFromJson(
  Map<String, dynamic> json,
) => _ProfileShowcaseSavedPlace(
  id: json['id'] as String,
  placeId: json['placeId'] as String,
  name: json['name'] as String,
  city: json['city'] as String,
  country: json['country'] as String,
  category: json['category'] as String,
  coverImageUrl: json['coverImageUrl'] as String?,
);

Map<String, dynamic> _$ProfileShowcaseSavedPlaceToJson(
  _ProfileShowcaseSavedPlace instance,
) => <String, dynamic>{
  'id': instance.id,
  'placeId': instance.placeId,
  'name': instance.name,
  'city': instance.city,
  'country': instance.country,
  'category': instance.category,
  'coverImageUrl': instance.coverImageUrl,
};

_ProfileShowcasePosts _$ProfileShowcasePostsFromJson(
  Map<String, dynamic> json,
) => _ProfileShowcasePosts(
  count: (json['count'] as num).toInt(),
  items: (json['items'] as List<dynamic>)
      .map((e) => ProfileShowcasePost.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$ProfileShowcasePostsToJson(
  _ProfileShowcasePosts instance,
) => <String, dynamic>{'count': instance.count, 'items': instance.items};

_ProfileShowcasePost _$ProfileShowcasePostFromJson(Map<String, dynamic> json) =>
    _ProfileShowcasePost(
      id: json['id'] as String,
      caption: json['caption'] as String?,
      imageUrl: json['imageUrl'] as String?,
    );

Map<String, dynamic> _$ProfileShowcasePostToJson(
  _ProfileShowcasePost instance,
) => <String, dynamic>{
  'id': instance.id,
  'caption': instance.caption,
  'imageUrl': instance.imageUrl,
};
