import 'package:travel_frontend_v1/core/networks/api_client.dart';

import '../models/create_trip.dart';
import '../models/trip.dart';
import '../models/trip_list_item.dart';
import '../models/trip_pagination.dart';
import '../models/trip_query.dart';
import '../models/trip_related_models.dart';
import '../models/trip_requests.dart';
import '../models/update_trip_request.dart';
import '../models/trip_creation_models.dart';

class TripRemoteDataSource {
  const TripRemoteDataSource({required ApiClient apiClient})
    : _apiClient = apiClient;
  final ApiClient _apiClient;

  Future<Trip> createTrip(CreateTripRequest request) async {
    final body = await _apiClient.post<Map<String, dynamic>>(
      '/trips',
      data: request.toJson(),
    );
    return Trip.fromJson(_envelopeData(body));
  }

  Future<Trip> createDraft(CreateTripDraftRequest request) async {
    final body = await _apiClient.post<Map<String, dynamic>>(
      '/trips/drafts',
      data: request.toJson(),
    );
    return Trip.fromJson(_envelopeData(body));
  }

  Future<Trip> finalizeTrip(String tripId) async {
    final body = await _apiClient.post<Map<String, dynamic>>(
      '/trips/${Uri.encodeComponent(tripId)}/finalize',
    );
    return Trip.fromJson(_envelopeData(body));
  }

  Future<List<Trip>> getDrafts() async {
    final body = await _apiClient.get<Map<String, dynamic>>('/trips/my-drafts');
    return _envelopeList(body, Trip.fromJson);
  }

  Future<List<CompanionRecommendation>> getCompanionRecommendations(
    String tripId,
  ) async {
    final body = await _apiClient.get<Map<String, dynamic>>(
      '/trips/recommend-friends/${Uri.encodeComponent(tripId)}',
    );
    final outer = body['data'];
    final list = outer is Map ? outer['data'] : outer;
    if (list is! List) {
      throw const FormatException('Recommendations data is not a list.');
    }
    return list
        .map(
          (item) => CompanionRecommendation.fromJson(
            Map<String, dynamic>.from(item as Map),
          ),
        )
        .toList(growable: false);
  }

  Future<PageResult<TripCreationUser>> searchUsers(
    String query, {
    int page = 1,
    int limit = 20,
  }) async {
    final body = await _apiClient.get<Map<String, dynamic>>(
      '/users/search',
      queryParameters: {'q': query, 'page': page, 'limit': limit},
    );
    return _page(body, TripCreationUser.fromJson);
  }

  Future<List<DestinationCatalogItem>> getDestinationCatalog({
    String? query,
  }) async {
    final body = await _apiClient.get<Map<String, dynamic>>(
      '/trips/destinations/catalog',
      queryParameters: {'q': ?query},
    );
    return _envelopeList(body, DestinationCatalogItem.fromJson);
  }

  Future<CatalogPlacesResult> getCatalogPlaces(
    String catalogId, {
    String? category,
    String? sort,
    int limit = 20,
  }) async {
    final body = await _apiClient.get<Map<String, dynamic>>(
      '/trips/destinations/catalog/${Uri.encodeComponent(catalogId)}/places',
      queryParameters: {'category': ?category, 'sort': ?sort, 'limit': limit},
    );
    return CatalogPlacesResult.fromJson(_envelopeData(body));
  }

  Future<RoutePreviewResult> previewRoute({
    required double originLat,
    required double originLng,
    required double destinationLat,
    required double destinationLng,
  }) async {
    final body = await _apiClient.post<Map<String, dynamic>>(
      '/trips/routes/preview',
      data: {
        'origin': {'lat': originLat, 'lng': originLng},
        'destination': {'lat': destinationLat, 'lng': destinationLng},
      },
    );
    return RoutePreviewResult.fromJson(_envelopeData(body));
  }

  Future<TripListPage> getTrips(TripQuery query) async {
    final body = await _apiClient.get<Map<String, dynamic>>(
      '/trips',
      queryParameters: query.toJson(),
    );
    return TripListPage(
      items: _envelopeList(body, TripListItem.fromJson),
      meta: PageMeta.fromJson(Map<String, dynamic>.from(body['meta'] as Map)),
      summary: TripSummary.fromJson(
        Map<String, dynamic>.from(body['summary'] as Map),
      ),
    );
  }

  Future<Trip> updateTrip(String tripId, UpdateTripRequest request) async {
    final body = await _apiClient.patch<Map<String, dynamic>>(
      '/trips/${Uri.encodeComponent(tripId)}',
      data: request.toJson(),
    );
    return Trip.fromJson(_envelopeData(body));
  }

  Future<void> deleteTrip(String tripId) async {
    final body = await _apiClient.delete<Map<String, dynamic>>(
      '/trips/${Uri.encodeComponent(tripId)}',
    );
    _requireSuccess(body);
  }

  Future<List<TripInterest>> getInterests() async {
    final body = await _apiClient.get<Map<String, dynamic>>(
      '/trips/interests/all',
      requiresAuth: false,
    );
    return _envelopeList(body, TripInterest.fromJson);
  }

  Future<List<TripInterest>> setTripInterests(
    String tripId,
    List<String> interestIds,
  ) async {
    final body = await _apiClient.put<Map<String, dynamic>>(
      '/trips/interests/${Uri.encodeComponent(tripId)}',
      data: {'interestIds': interestIds},
    );
    return _envelopeList(body, TripInterest.fromJson);
  }

  Future<TripInvitation> createInvitation(
    CreateTripInvitationRequest request,
  ) async {
    final body = await _apiClient.post<Map<String, dynamic>>(
      '/trip-invitations/invite',
      data: request.toJson(),
    );
    return TripInvitation.fromJson(_envelopeData(body));
  }

  Future<TripInvitation> acceptInvitation(String invitationId) async {
    final body = await _apiClient.post<Map<String, dynamic>>(
      '/trip-invitations/accept/${Uri.encodeComponent(invitationId)}',
    );
    return TripInvitation.fromJson(_envelopeData(body));
  }

  Future<TripInvitation> rejectInvitation(String invitationId) async {
    final body = await _apiClient.post<Map<String, dynamic>>(
      '/trip-invitations/reject/${Uri.encodeComponent(invitationId)}',
    );
    return TripInvitation.fromJson(_envelopeData(body));
  }

  Future<TripInvitation> cancelInvitation(
    String tripId,
    String invitationId,
  ) async {
    final body = await _apiClient.post<Map<String, dynamic>>(
      '/trip-invitations/cancel/${Uri.encodeComponent(tripId)}/'
      '${Uri.encodeComponent(invitationId)}',
    );
    return TripInvitation.fromJson(_envelopeData(body));
  }

  /// Incoming invitations for the current user.
  /// `GET /trip-invitations/received`
  Future<PageResult<TripInvitation>> getReceivedInvitations({
    int page = 1,
    int limit = 20,
  }) async {
    final body = await _apiClient.get<Map<String, dynamic>>(
      '/trip-invitations/received',
      queryParameters: {'page': page, 'limit': limit},
    );
    return _page(body, TripInvitation.fromJson);
  }

  /// Outgoing invitations for a trip (owner/admin).
  /// `GET /trip-invitations/invitations?tripId=`
  Future<PageResult<TripInvitation>> getSentInvitations(
    String tripId, {
    int page = 1,
    int limit = 20,
  }) async {
    final body = await _apiClient.get<Map<String, dynamic>>(
      '/trip-invitations/invitations',
      queryParameters: {'tripId': tripId, 'page': page, 'limit': limit},
    );
    return _page(body, TripInvitation.fromJson);
  }

  Map<String, dynamic> _envelopeData(Map<String, dynamic> body) {
    final data = body['data'];
    if (data is Map) return Map<String, dynamic>.from(data);
    throw const FormatException('Response does not contain a data object.');
  }

  List<T> _envelopeList<T>(
    Map<String, dynamic> body,
    T Function(Map<String, dynamic>) parser,
  ) {
    final data = body['data'];
    if (data is! List) throw const FormatException('Data is not a list.');
    return data
        .map((item) => parser(Map<String, dynamic>.from(item as Map)))
        .toList(growable: false);
  }

  PageResult<T> _page<T>(
    Map<String, dynamic> body,
    T Function(Map<String, dynamic>) parser,
  ) => PageResult(
    items: _envelopeList(body, parser),
    meta: PageMeta.fromJson(Map<String, dynamic>.from(body['meta'] as Map)),
  );

  void _requireSuccess(Map<String, dynamic> body) {
    if (body['success'] != true) {
      throw const FormatException('Action response was not successful.');
    }
  }
}
