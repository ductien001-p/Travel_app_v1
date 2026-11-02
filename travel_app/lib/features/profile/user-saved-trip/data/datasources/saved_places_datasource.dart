import 'package:flutter/foundation.dart';
import 'package:travel_frontend_v1/core/networks/api_client.dart';
import 'package:travel_frontend_v1/features/home/places/data/models/place_explore_api_models.dart';

import '../models/saved_places_models.dart';

class SavedPlacesDataSource {
  const SavedPlacesDataSource({required ApiClient apiClient})
    : _apiClient = apiClient;

  /// Lets tests subclass the source without a live client. Production always
  /// uses [SavedPlacesDataSource.new].
  @visibleForTesting
  const SavedPlacesDataSource.testing() : _apiClient = null;

  final ApiClient? _apiClient;

  ApiClient get _client {
    final client = _apiClient;
    if (client == null) {
      throw StateError('ApiClient is required');
    }
    return client;
  }

  /// `GET /places/saved/me`. Newest saves first.
  Future<SavedPlacesPage> getMine({int page = 1, int limit = 20}) async {
    final body = await _client.get<Map<String, dynamic>>(
      '/places/saved/me',
      queryParameters: {'page': page, 'limit': limit},
    );
    if (body['data'] is! List || body['meta'] is! Map) {
      throw const FormatException('Invalid saved places response.');
    }
    return SavedPlacesPage.fromJson(body);
  }

  /// `GET /places/saved/count`.
  Future<int> getCount() async {
    final body = await _client.get<Map<String, dynamic>>('/places/saved/count');
    final data = body['data'];
    if (data is! Map) {
      throw const FormatException('Invalid saved places count response.');
    }
    return SavedPlacesCountEnvelope.fromJson({
      'data': Map<String, dynamic>.from(data),
    }).data.count;
  }

  /// `DELETE /places/{placeId}/save`.
  Future<void> unsave(String placeId) async {
    final body = await _client.delete<Map<String, dynamic>>(
      '/places/${Uri.encodeComponent(placeId)}/save',
    );
    if (body['success'] != true) {
      throw const FormatException('Invalid unsave response.');
    }
  }

  /// `GET /place-collections/mine`.
  Future<List<OwnedPlaceCollection>> listCollections() async {
    final body = await _client.get<Map<String, dynamic>>(
      '/place-collections/mine',
    );
    final data = body['data'];
    if (data is! List) {
      throw const FormatException('Invalid collections response.');
    }
    return [
      for (final item in data)
        if (item is Map)
          OwnedPlaceCollection.fromJson(Map<String, dynamic>.from(item)),
    ];
  }

  /// `GET /place-collections/{id}`.
  Future<PlaceCollectionDetail> getCollection(String id) async {
    final body = await _client.get<Map<String, dynamic>>(
      '/place-collections/${Uri.encodeComponent(id)}',
    );
    final data = body['data'];
    if (data is! Map) {
      throw const FormatException('Invalid collection response.');
    }
    return PlaceCollectionDetail.fromJson(Map<String, dynamic>.from(data));
  }

  /// `POST /place-collections`.
  Future<OwnedPlaceCollection> createCollection(String title) async {
    final body = await _client.post<Map<String, dynamic>>(
      '/place-collections',
      data: {'title': title},
    );
    final data = body['data'];
    if (data is! Map) {
      throw const FormatException('Invalid create collection response.');
    }
    return OwnedPlaceCollection.fromJson(Map<String, dynamic>.from(data));
  }
}
