import '../datasources/explore_places_datasource.dart';
import '../models/explore_places_mapper.dart';
import '../models/explore_places_models.dart';
import '../models/place_explore_api_models.dart';

class ExplorePlacesRepository {
  const ExplorePlacesRepository({required ExplorePlacesDataSource dataSource})
    : _dataSource = dataSource;

  final ExplorePlacesDataSource _dataSource;

  Future<FeaturedPlacesData> getFeatured({required int utcOffsetMinutes}) {
    return _dataSource.getFeatured(utcOffsetMinutes: utcOffsetMinutes);
  }

  Future<List<FeaturedPlaceApi>> searchEmbeddings(String query) async {
    final hits = await _dataSource.searchEmbeddings(query);
    return [for (final hit in hits) mapEmbeddingSearchHit(hit)];
  }

  Future<List<NearbyPlace>> getNearby({
    required double latitude,
    required double longitude,
    required int radiusKm,
  }) async {
    final places = await _dataSource.getNearby(
      latitude: latitude,
      longitude: longitude,
      radiusKm: radiusKm,
    );
    return [for (final place in places) mapNearbyPlace(place)];
  }

  Future<List<PlaceCollection>> getFeaturedCollections() async {
    final collections = await _dataSource.getFeaturedCollections();
    return [
      for (final collection in collections) mapFeaturedCollection(collection),
    ];
  }

  Future<List<OwnedPlaceCollection>> listMine() => _dataSource.listMine();

  Future<OwnedPlaceCollection> createCollection(String title) {
    return _dataSource.createCollection(title);
  }

  Future<void> setMembership({
    required String placeId,
    required List<String> collectionIds,
  }) {
    return _dataSource.setMembership(
      placeId: placeId,
      collectionIds: collectionIds,
    );
  }

  Future<void> unsave(String placeId) => _dataSource.unsave(placeId);

  Future<PlaceCollectionDetail> getCollection(String id) {
    return _dataSource.getCollection(id);
  }

  Future<PlaceCollectionDetail> rateCollection({
    required String id,
    required int rating,
  }) {
    return _dataSource.rateCollection(id: id, rating: rating);
  }

  Future<OwnedPlaceCollection> copyCollection(String id) {
    return _dataSource.copyCollection(id);
  }
}

FeaturedPlaceApi mapEmbeddingSearchHit(PlaceEmbeddingSearchApi hit) {
  return FeaturedPlaceApi(
    id: hit.id,
    name: hit.name,
    coverImageUrl: hit.thumbnailUrl,
    category: hit.category ?? '',
    averageRating: hit.averageRating ?? 0,
    saveCount: hit.saveCount,
    city: '',
    address: hit.address ?? '',
    description: hit.description,
    bookmarked: hit.bookmarked,
  );
}

List<FeaturedPlace> mapFeaturedPlaces(FeaturedPlacesData data) {
  return [for (final place in data.places) mapFeaturedPlace(place)];
}
