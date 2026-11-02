import '../datasources/trip_remote_datasource.dart';
import '../models/create_trip.dart';
import '../models/trip.dart';
import '../models/trip_list_item.dart';
import '../models/trip_pagination.dart';
import '../models/trip_query.dart';
import '../models/trip_related_models.dart';
import '../models/trip_requests.dart';
import '../models/update_trip_request.dart';
import '../models/trip_creation_models.dart';

class TripRepository {
  const TripRepository({required TripRemoteDataSource remoteDataSource})
    : _remote = remoteDataSource;
  final TripRemoteDataSource _remote;

  Future<Trip> createTrip(CreateTripRequest request) =>
      _remote.createTrip(request);
  Future<Trip> createDraft(CreateTripDraftRequest request) =>
      _remote.createDraft(request);
  Future<Trip> finalizeTrip(String tripId) => _remote.finalizeTrip(tripId);
  Future<List<Trip>> getDrafts() => _remote.getDrafts();
  Future<List<CompanionRecommendation>> getCompanionRecommendations(
    String tripId,
  ) => _remote.getCompanionRecommendations(tripId);
  Future<PageResult<TripCreationUser>> searchUsers(
    String query, {
    int page = 1,
    int limit = 20,
  }) => _remote.searchUsers(query, page: page, limit: limit);
  Future<List<DestinationCatalogItem>> getDestinationCatalog({String? query}) =>
      _remote.getDestinationCatalog(query: query);
  Future<CatalogPlacesResult> getCatalogPlaces(
    String catalogId, {
    String? category,
    String? sort,
    int limit = 20,
  }) => _remote.getCatalogPlaces(
    catalogId,
    category: category,
    sort: sort,
    limit: limit,
  );
  Future<RoutePreviewResult> previewRoute({
    required double originLat,
    required double originLng,
    required double destinationLat,
    required double destinationLng,
  }) => _remote.previewRoute(
    originLat: originLat,
    originLng: originLng,
    destinationLat: destinationLat,
    destinationLng: destinationLng,
  );
  Future<TripListPage> getTrips(TripQuery query) => _remote.getTrips(query);
  Future<Trip> updateTrip(String tripId, UpdateTripRequest request) =>
      _remote.updateTrip(tripId, request);
  Future<void> deleteTrip(String tripId) => _remote.deleteTrip(tripId);
  Future<List<TripInterest>> getInterests() => _remote.getInterests();
  Future<List<TripInterest>> setTripInterests(
    String tripId,
    List<String> interestIds,
  ) => _remote.setTripInterests(tripId, interestIds);
  Future<TripInvitation> createInvitation(
    CreateTripInvitationRequest request,
  ) => _remote.createInvitation(request);
  Future<TripInvitation> acceptInvitation(String invitationId) =>
      _remote.acceptInvitation(invitationId);
  Future<TripInvitation> rejectInvitation(String invitationId) =>
      _remote.rejectInvitation(invitationId);
  Future<TripInvitation> cancelInvitation(String tripId, String invitationId) =>
      _remote.cancelInvitation(tripId, invitationId);
  Future<PageResult<TripInvitation>> getReceivedInvitations({
    int page = 1,
    int limit = 20,
  }) => _remote.getReceivedInvitations(page: page, limit: limit);
  Future<PageResult<TripInvitation>> getSentInvitations(
    String tripId, {
    int page = 1,
    int limit = 20,
  }) => _remote.getSentInvitations(tripId, page: page, limit: limit);
}
