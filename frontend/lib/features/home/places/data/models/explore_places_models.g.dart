// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'explore_places_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ExplorePlacesFeed _$ExplorePlacesFeedFromJson(Map<String, dynamic> json) =>
    _ExplorePlacesFeed(
      featuredSubtitle: json['featuredSubtitle'] as String,
      featured: (json['featured'] as List<dynamic>)
          .map((e) => FeaturedPlace.fromJson(e as Map<String, dynamic>))
          .toList(),
      nearbySubtitle: json['nearbySubtitle'] as String,
      nearbyRadiusLabel: json['nearbyRadiusLabel'] as String,
      nearby: (json['nearby'] as List<dynamic>)
          .map((e) => NearbyPlace.fromJson(e as Map<String, dynamic>))
          .toList(),
      collectionsSubtitle: json['collectionsSubtitle'] as String,
      collections: (json['collections'] as List<dynamic>)
          .map((e) => PlaceCollection.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ExplorePlacesFeedToJson(_ExplorePlacesFeed instance) =>
    <String, dynamic>{
      'featuredSubtitle': instance.featuredSubtitle,
      'featured': instance.featured,
      'nearbySubtitle': instance.nearbySubtitle,
      'nearbyRadiusLabel': instance.nearbyRadiusLabel,
      'nearby': instance.nearby,
      'collectionsSubtitle': instance.collectionsSubtitle,
      'collections': instance.collections,
    };

_FeaturedPlace _$FeaturedPlaceFromJson(Map<String, dynamic> json) =>
    _FeaturedPlace(
      id: json['id'] as String,
      name: json['name'] as String,
      imageUrl: json['imageUrl'] as String,
      categoryLabel: json['categoryLabel'] as String,
      rating: (json['rating'] as num).toDouble(),
      saveCountLabel: json['saveCountLabel'] as String,
      locationLabel: json['locationLabel'] as String,
      tagline: json['tagline'] as String,
      bookmarked: json['bookmarked'] as bool? ?? false,
    );

Map<String, dynamic> _$FeaturedPlaceToJson(_FeaturedPlace instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'imageUrl': instance.imageUrl,
      'categoryLabel': instance.categoryLabel,
      'rating': instance.rating,
      'saveCountLabel': instance.saveCountLabel,
      'locationLabel': instance.locationLabel,
      'tagline': instance.tagline,
      'bookmarked': instance.bookmarked,
    };

_NearbyPlace _$NearbyPlaceFromJson(Map<String, dynamic> json) => _NearbyPlace(
  id: json['id'] as String,
  name: json['name'] as String,
  imageUrl: json['imageUrl'] as String,
  categoryLabel: json['categoryLabel'] as String,
  rating: (json['rating'] as num).toDouble(),
  reviewCountLabel: json['reviewCountLabel'] as String,
  address: json['address'] as String,
  distanceLabel: json['distanceLabel'] as String,
  travelLabel: json['travelLabel'] as String,
  travelMode: $enumDecode(_$NearbyTravelModeEnumMap, json['travelMode']),
);

Map<String, dynamic> _$NearbyPlaceToJson(_NearbyPlace instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'imageUrl': instance.imageUrl,
      'categoryLabel': instance.categoryLabel,
      'rating': instance.rating,
      'reviewCountLabel': instance.reviewCountLabel,
      'address': instance.address,
      'distanceLabel': instance.distanceLabel,
      'travelLabel': instance.travelLabel,
      'travelMode': _$NearbyTravelModeEnumMap[instance.travelMode]!,
    };

const _$NearbyTravelModeEnumMap = {
  NearbyTravelMode.walk: 'walk',
  NearbyTravelMode.drive: 'drive',
};

_PlaceCollection _$PlaceCollectionFromJson(Map<String, dynamic> json) =>
    _PlaceCollection(
      id: json['id'] as String,
      title: json['title'] as String,
      eyebrow: json['eyebrow'] as String,
      imageUrl: json['imageUrl'] as String,
      countLabel: json['countLabel'] as String,
      tone: $enumDecode(_$PlaceCollectionToneEnumMap, json['tone']),
    );

Map<String, dynamic> _$PlaceCollectionToJson(_PlaceCollection instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'eyebrow': instance.eyebrow,
      'imageUrl': instance.imageUrl,
      'countLabel': instance.countLabel,
      'tone': _$PlaceCollectionToneEnumMap[instance.tone]!,
    };

const _$PlaceCollectionToneEnumMap = {
  PlaceCollectionTone.summer: 'summer',
  PlaceCollectionTone.trend: 'trend',
};
