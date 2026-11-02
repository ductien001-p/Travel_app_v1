import 'package:travel_frontend_v1/core/networks/api_client.dart';

import '../models/place_explore_api_models.dart';
import 'explore_places_datasource.dart';

class ExplorePlacesRemoteDataSource implements ExplorePlacesDataSource {
  const ExplorePlacesRemoteDataSource({required ApiClient apiClient})
    : _apiClient = apiClient;

  final ApiClient _apiClient;

  @override
  Future<FeaturedPlacesData> getFeatured({
    required int utcOffsetMinutes,
  }) async {
    final body = await _apiClient.get<Map<String, dynamic>>(
      '/places/featured',
      queryParameters: {'utcOffsetMinutes': utcOffsetMinutes},
    );
    final data = body['data'];
    if (data is! Map) {
      throw const FormatException('Invalid featured places response.');
    }
    return FeaturedPlacesData.fromJson(Map<String, dynamic>.from(data));
  }

  @override
  Future<List<PlaceEmbeddingSearchApi>> searchEmbeddings(String query) async {
    final body = await _apiClient.post<Map<String, dynamic>>(
      '/places/search-embeddings',
      data: {'query': query},
    );
    return _list(body, PlaceEmbeddingSearchApi.fromJson);
  }

  @override
  Future<List<NearbyPlaceApi>> getNearby({
    required double latitude,
    required double longitude,
    required int radiusKm,
  }) async {
    final body = await _apiClient.get<Map<String, dynamic>>(
      '/places/nearby',
      queryParameters: {
        'latitude': latitude,
        'longitude': longitude,
        'radiusKm': radiusKm,
      },
    );
    return _list(body, NearbyPlaceApi.fromJson);
  }

  @override
  Future<List<FeaturedCollectionApi>> getFeaturedCollections() async {
    final body = await _apiClient.get<Map<String, dynamic>>(
      '/place-collections/featured',
    );
    return _list(body, FeaturedCollectionApi.fromJson);
  }

  @override
  Future<List<OwnedPlaceCollection>> listMine() async {
    final body = await _apiClient.get<Map<String, dynamic>>(
      '/place-collections/mine',
    );
    return _list(body, OwnedPlaceCollection.fromJson);
  }

  @override
  Future<OwnedPlaceCollection> createCollection(String title) async {
    final body = await _apiClient.post<Map<String, dynamic>>(
      '/place-collections',
      data: {'title': title},
    );
    return _object(body, OwnedPlaceCollection.fromJson);
  }

  @override
  Future<void> setMembership({
    required String placeId,
    required List<String> collectionIds,
  }) async {
    final body = await _apiClient.put<Map<String, dynamic>>(
      '/place-collections/places/${Uri.encodeComponent(placeId)}/membership',
      data: {'collectionIds': collectionIds},
    );
    if (body['data'] is! Map) {
      throw const FormatException('Invalid membership response.');
    }
  }

  @override
  Future<void> unsave(String placeId) async {
    final body = await _apiClient.delete<Map<String, dynamic>>(
      '/places/${Uri.encodeComponent(placeId)}/save',
    );
    if (body['success'] != true) {
      throw const FormatException('Invalid unsave response.');
    }
  }

  @override
  Future<PlaceCollectionDetail> getCollection(String id) async {
    final body = await _apiClient.get<Map<String, dynamic>>(
      '/place-collections/${Uri.encodeComponent(id)}',
    );
    return _object(body, PlaceCollectionDetail.fromJson);
  }

  @override
  Future<PlaceCollectionDetail> rateCollection({
    required String id,
    required int rating,
  }) async {
    await _apiClient.put<Map<String, dynamic>>(
      '/place-collections/${Uri.encodeComponent(id)}/rating',
      data: {'rating': rating},
    );
    return getCollection(id);
  }

  @override
  Future<OwnedPlaceCollection> copyCollection(String id) async {
    final body = await _apiClient.post<Map<String, dynamic>>(
      '/place-collections/${Uri.encodeComponent(id)}/copy',
    );
    return _object(body, OwnedPlaceCollection.fromJson);
  }
}

List<T> _list<T>(
  Map<String, dynamic> body,
  T Function(Map<String, dynamic> json) decode,
) {
  final data = body['data'];
  if (data is! List) {
    throw const FormatException('Invalid list response.');
  }
  return [
    for (final item in data)
      if (item is Map) decode(Map<String, dynamic>.from(item)),
  ];
}

T _object<T>(
  Map<String, dynamic> body,
  T Function(Map<String, dynamic> json) decode,
) {
  final data = body['data'];
  if (data is! Map) {
    throw const FormatException('Invalid object response.');
  }
  return decode(Map<String, dynamic>.from(data));
}
