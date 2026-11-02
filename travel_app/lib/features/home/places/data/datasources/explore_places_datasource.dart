import '../models/place_explore_api_models.dart';

abstract class ExplorePlacesDataSource {
  Future<FeaturedPlacesData> getFeatured({required int utcOffsetMinutes});

  Future<List<PlaceEmbeddingSearchApi>> searchEmbeddings(String query);

  Future<List<NearbyPlaceApi>> getNearby({
    required double latitude,
    required double longitude,
    required int radiusKm,
  });

  Future<List<FeaturedCollectionApi>> getFeaturedCollections();

  Future<List<OwnedPlaceCollection>> listMine();

  Future<OwnedPlaceCollection> createCollection(String title);

  Future<void> setMembership({
    required String placeId,
    required List<String> collectionIds,
  });

  Future<void> unsave(String placeId);

  Future<PlaceCollectionDetail> getCollection(String id);

  Future<PlaceCollectionDetail> rateCollection({
    required String id,
    required int rating,
  });

  Future<OwnedPlaceCollection> copyCollection(String id);
}
