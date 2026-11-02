import 'package:freezed_annotation/freezed_annotation.dart';

part 'explore_places_models.freezed.dart';
part 'explore_places_models.g.dart';

enum NearbyTravelMode { walk, drive }

enum PlaceCollectionTone { summer, trend }

@freezed
abstract class ExplorePlacesFeed with _$ExplorePlacesFeed {
  const factory ExplorePlacesFeed({
    required String featuredSubtitle,
    required List<FeaturedPlace> featured,
    required String nearbySubtitle,
    required String nearbyRadiusLabel,
    required List<NearbyPlace> nearby,
    required String collectionsSubtitle,
    required List<PlaceCollection> collections,
  }) = _ExplorePlacesFeed;

  factory ExplorePlacesFeed.fromJson(Map<String, dynamic> json) =>
      _$ExplorePlacesFeedFromJson(json);
}

@freezed
abstract class FeaturedPlace with _$FeaturedPlace {
  const factory FeaturedPlace({
    required String id,
    required String name,
    required String imageUrl,
    required String categoryLabel,
    required double rating,
    required String saveCountLabel,
    required String locationLabel,
    required String tagline,
    @Default(false) bool bookmarked,
  }) = _FeaturedPlace;

  factory FeaturedPlace.fromJson(Map<String, dynamic> json) =>
      _$FeaturedPlaceFromJson(json);
}

@freezed
abstract class NearbyPlace with _$NearbyPlace {
  const factory NearbyPlace({
    required String id,
    required String name,
    required String imageUrl,
    required String categoryLabel,
    required double rating,
    required String reviewCountLabel,
    required String address,
    required String distanceLabel,
    required String travelLabel,
    required NearbyTravelMode travelMode,
  }) = _NearbyPlace;

  factory NearbyPlace.fromJson(Map<String, dynamic> json) =>
      _$NearbyPlaceFromJson(json);
}

@freezed
abstract class PlaceCollection with _$PlaceCollection {
  const factory PlaceCollection({
    required String id,
    required String title,
    required String eyebrow,
    required String imageUrl,
    required String countLabel,
    required PlaceCollectionTone tone,
  }) = _PlaceCollection;

  factory PlaceCollection.fromJson(Map<String, dynamic> json) =>
      _$PlaceCollectionFromJson(json);
}
