// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'explore_home_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ExploreHomeFeed _$ExploreHomeFeedFromJson(Map<String, dynamic> json) =>
    _ExploreHomeFeed(
      header: ExploreHomeHeader.fromJson(
        json['header'] as Map<String, dynamic>,
      ),
      filters: (json['filters'] as List<dynamic>)
          .map((e) => ExploreFilterChip.fromJson(e as Map<String, dynamic>))
          .toList(),
      hotTrips: (json['hotTrips'] as List<dynamic>)
          .map((e) => CommunityTripCard.fromJson(e as Map<String, dynamic>))
          .toList(),
      destinations: (json['destinations'] as List<dynamic>)
          .map((e) => ExploreDestination.fromJson(e as Map<String, dynamic>))
          .toList(),
      liveTrips: (json['liveTrips'] as List<dynamic>)
          .map((e) => LiveTripUpdate.fromJson(e as Map<String, dynamic>))
          .toList(),
      page: (json['page'] as num?)?.toInt() ?? 1,
      hasNextPage: json['hasNextPage'] as bool? ?? false,
      catalogUnavailable: json['catalogUnavailable'] as bool? ?? false,
    );

Map<String, dynamic> _$ExploreHomeFeedToJson(_ExploreHomeFeed instance) =>
    <String, dynamic>{
      'header': instance.header,
      'filters': instance.filters,
      'hotTrips': instance.hotTrips,
      'destinations': instance.destinations,
      'liveTrips': instance.liveTrips,
      'page': instance.page,
      'hasNextPage': instance.hasNextPage,
      'catalogUnavailable': instance.catalogUnavailable,
    };

_ExploreHomeHeader _$ExploreHomeHeaderFromJson(Map<String, dynamic> json) =>
    _ExploreHomeHeader(
      displayName: json['displayName'] as String,
      avatarUrl: json['avatarUrl'] as String?,
      locationLabel: json['locationLabel'] as String,
      hasUnreadNotifications: json['hasUnreadNotifications'] as bool? ?? false,
    );

Map<String, dynamic> _$ExploreHomeHeaderToJson(_ExploreHomeHeader instance) =>
    <String, dynamic>{
      'displayName': instance.displayName,
      'avatarUrl': instance.avatarUrl,
      'locationLabel': instance.locationLabel,
      'hasUnreadNotifications': instance.hasUnreadNotifications,
    };

_ExploreFilterChip _$ExploreFilterChipFromJson(Map<String, dynamic> json) =>
    _ExploreFilterChip(
      id: json['id'] as String,
      label: json['label'] as String,
    );

Map<String, dynamic> _$ExploreFilterChipToJson(_ExploreFilterChip instance) =>
    <String, dynamic>{'id': instance.id, 'label': instance.label};

_CommunityTripAuthor _$CommunityTripAuthorFromJson(Map<String, dynamic> json) =>
    _CommunityTripAuthor(
      name: json['name'] as String,
      handle: json['handle'] as String,
      avatarUrl: json['avatarUrl'] as String?,
      badgeLabel: json['badgeLabel'] as String?,
    );

Map<String, dynamic> _$CommunityTripAuthorToJson(
  _CommunityTripAuthor instance,
) => <String, dynamic>{
  'name': instance.name,
  'handle': instance.handle,
  'avatarUrl': instance.avatarUrl,
  'badgeLabel': instance.badgeLabel,
};

_CommunityTripCard _$CommunityTripCardFromJson(
  Map<String, dynamic> json,
) => _CommunityTripCard(
  id: json['id'] as String,
  author: CommunityTripAuthor.fromJson(json['author'] as Map<String, dynamic>),
  coverUrl: json['coverUrl'] as String,
  badges: (json['badges'] as List<dynamic>).map((e) => e as String).toList(),
  durationLabel: json['durationLabel'] as String,
  title: json['title'] as String,
  dateLabel: json['dateLabel'] as String,
  costLabel: json['costLabel'] as String,
  departureLabel: json['departureLabel'] as String,
  memberCount: (json['memberCount'] as num).toInt(),
  capacity: (json['capacity'] as num).toInt(),
  memberAvatars: (json['memberAvatars'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  filterTags:
      (json['filterTags'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const <String>[],
  recruiting: json['recruiting'] as bool? ?? false,
  requirements: json['requirements'] as String?,
  estimatedBudgetPerPerson: json['estimatedBudgetPerPerson'] as String?,
  slotsRemaining: (json['slotsRemaining'] as num?)?.toInt(),
  expiresAt: json['expiresAt'] == null
      ? null
      : DateTime.parse(json['expiresAt'] as String),
  matchScore: (json['matchScore'] as num?)?.toInt(),
  urgent: json['urgent'] as bool? ?? false,
);

Map<String, dynamic> _$CommunityTripCardToJson(_CommunityTripCard instance) =>
    <String, dynamic>{
      'id': instance.id,
      'author': instance.author,
      'coverUrl': instance.coverUrl,
      'badges': instance.badges,
      'durationLabel': instance.durationLabel,
      'title': instance.title,
      'dateLabel': instance.dateLabel,
      'costLabel': instance.costLabel,
      'departureLabel': instance.departureLabel,
      'memberCount': instance.memberCount,
      'capacity': instance.capacity,
      'memberAvatars': instance.memberAvatars,
      'filterTags': instance.filterTags,
      'recruiting': instance.recruiting,
      'requirements': instance.requirements,
      'estimatedBudgetPerPerson': instance.estimatedBudgetPerPerson,
      'slotsRemaining': instance.slotsRemaining,
      'expiresAt': instance.expiresAt?.toIso8601String(),
      'matchScore': instance.matchScore,
      'urgent': instance.urgent,
    };

_ExploreDestination _$ExploreDestinationFromJson(Map<String, dynamic> json) =>
    _ExploreDestination(
      id: json['id'] as String,
      name: json['name'] as String,
      imageUrl: json['imageUrl'] as String,
      openTripCount: (json['openTripCount'] as num).toInt(),
    );

Map<String, dynamic> _$ExploreDestinationToJson(_ExploreDestination instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'imageUrl': instance.imageUrl,
      'openTripCount': instance.openTripCount,
    };

_LiveTripUpdate _$LiveTripUpdateFromJson(Map<String, dynamic> json) =>
    _LiveTripUpdate(
      id: json['id'] as String,
      title: json['title'] as String,
      placeLabel: json['placeLabel'] as String,
      memberCount: (json['memberCount'] as num).toInt(),
      minutesAgo: (json['minutesAgo'] as num).toInt(),
    );

Map<String, dynamic> _$LiveTripUpdateToJson(_LiveTripUpdate instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'placeLabel': instance.placeLabel,
      'memberCount': instance.memberCount,
      'minutesAgo': instance.minutesAgo,
    };
