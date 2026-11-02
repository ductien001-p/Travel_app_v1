import 'package:travel_frontend_v1/core/networks/api_client.dart';

import '../models/itinerary_models.dart';
import '../models/itinerary_requests.dart';

class TripItineraryRemoteDataSource {
  const TripItineraryRemoteDataSource({required ApiClient apiClient})
    : _apiClient = apiClient;

  final ApiClient _apiClient;

  Future<TripItineraryData> getItinerary(String tripId) async {
    final body = await _apiClient.get<Map<String, dynamic>>(
      '/trips/${Uri.encodeComponent(tripId)}/itineraries',
    );
    return TripItineraryData.fromEnvelope(body);
  }

  /// `GET /trips/{id}/itineraries/destinations/{destinationId}` — one city.
  Future<DestinationItinerary> getDestination(
    String tripId,
    String destinationId,
  ) async {
    final body = await _apiClient.get<Map<String, dynamic>>(
      '/trips/${Uri.encodeComponent(tripId)}/itineraries/destinations/'
      '${Uri.encodeComponent(destinationId)}',
    );
    return DestinationItinerary.fromJson(_dataMap(body));
  }

  Future<List<PlaceSearchResult>> searchPlaces({
    required String destinationId,
    required String query,
    List<String>? categories,
    double radiusKm = 20,
  }) async {
    final body = await _apiClient.post<Map<String, dynamic>>(
      '/places/search-embeddings',
      data: {
        'query': query,
        'destinationId': destinationId,
        'radiusKm': radiusKm,
        if (categories != null && categories.isNotEmpty)
          'categories': categories,
      },
    );
    return _dataList(body, PlaceSearchResult.fromJson);
  }

  Future<List<ItineraryActivity>> reorderItems(
    String tripId,
    String dayId,
    List<String> orderedItemIds,
  ) async {
    final body = await _apiClient.patch<List<dynamic>>(
      '/trips/${Uri.encodeComponent(tripId)}/itinerary-days/'
      '${Uri.encodeComponent(dayId)}/items/reorder',
      data: {'orderedItemIds': orderedItemIds},
    );
    return body
        .map(
          (item) => ItineraryActivity.fromJson(
            Map<String, dynamic>.from(item as Map),
          ),
        )
        .toList(growable: false);
  }

  Future<void> deleteDestination(
    String tripId,
    String destinationId, {
    bool acknowledgeRecruitmentImpact = false,
  }) async {
    final body = await _apiClient.delete<Map<String, dynamic>>(
      '/trips/${Uri.encodeComponent(tripId)}/itineraries/destinations/'
      '${Uri.encodeComponent(destinationId)}',
      queryParameters: acknowledgeRecruitmentImpact
          ? {'acknowledgeRecruitmentImpact': 'true'}
          : null,
    );
    _requireSuccess(body);
  }

  Future<ItineraryActivity> createActivity(
    String tripId,
    String dayId,
    CreateActivityRequest request,
  ) async {
    final body = await _apiClient.post<Map<String, dynamic>>(
      '/trips/${Uri.encodeComponent(tripId)}/itineraries/days/'
      '${Uri.encodeComponent(dayId)}/activities',
      data: request.toJson(),
    );
    return ItineraryActivity.fromJson(_dataMap(body));
  }

  Future<CreateItineraryItemsBatchResult> createItemsBatch(
    String tripId,
    CreateItineraryItemsBatchRequest request,
  ) async {
    final body = await _apiClient.post<Map<String, dynamic>>(
      '/trips/${Uri.encodeComponent(tripId)}/itineraries/items/batch',
      data: request.toJson(),
    );
    return CreateItineraryItemsBatchResult.fromJson(body);
  }

  Future<ItineraryActivity> updateActivity(
    String tripId,
    String activityId,
    UpdateActivityRequest request,
  ) async {
    final body = await _apiClient.patch<Map<String, dynamic>>(
      '/trips/${Uri.encodeComponent(tripId)}/itineraries/activities/'
      '${Uri.encodeComponent(activityId)}',
      data: request.toJson(),
    );
    return ItineraryActivity.fromJson(_dataMap(body));
  }

  Future<void> deleteActivity(String tripId, String activityId) async {
    final body = await _apiClient.delete<Map<String, dynamic>>(
      '/trips/${Uri.encodeComponent(tripId)}/itineraries/activities/'
      '${Uri.encodeComponent(activityId)}',
    );
    _requireSuccess(body);
  }

  Future<TripCheckin> checkin(
    String tripId,
    String activityId,
    CheckinActivityRequest request,
  ) async {
    final body = await _apiClient.post<Map<String, dynamic>>(
      '/trips/${Uri.encodeComponent(tripId)}/itineraries/activities/'
      '${Uri.encodeComponent(activityId)}/checkin',
      data: request.toJson(),
    );
    return TripCheckin.fromJson(_dataMap(body));
  }

  Future<void> uncheckin(String tripId, String activityId) async {
    final body = await _apiClient.delete<Map<String, dynamic>>(
      '/trips/${Uri.encodeComponent(tripId)}/itineraries/activities/'
      '${Uri.encodeComponent(activityId)}/checkin',
    );
    _requireSuccess(body);
  }

  Future<TripItineraryCompletion> getCompletion(String tripId) async {
    final body = await _apiClient.get<Map<String, dynamic>>(
      '/trips/${Uri.encodeComponent(tripId)}/itineraries/completion-status',
    );
    return TripItineraryCompletion.fromJson(_dataMap(body));
  }

  Map<String, dynamic> _dataMap(Map<String, dynamic> body) {
    final data = body['data'];
    if (data is Map) return Map<String, dynamic>.from(data);
    throw const FormatException('Response does not contain a data object.');
  }

  List<T> _dataList<T>(
    Map<String, dynamic> body,
    T Function(Map<String, dynamic>) parser,
  ) {
    final data = body['data'];
    if (data is! List) throw const FormatException('Data is not a list.');
    return data
        .map((item) => parser(Map<String, dynamic>.from(item as Map)))
        .toList(growable: false);
  }

  void _requireSuccess(Map<String, dynamic> body) {
    if (body['success'] != true) {
      throw const FormatException('Action response was not successful.');
    }
  }
}
