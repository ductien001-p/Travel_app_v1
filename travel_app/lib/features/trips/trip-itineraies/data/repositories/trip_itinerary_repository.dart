import '../datasources/trip_itinerary_remote_datasource.dart';
import '../models/itinerary_models.dart';
import '../models/itinerary_requests.dart';

class TripItineraryRepository {
  const TripItineraryRepository({
    required TripItineraryRemoteDataSource remoteDataSource,
  }) : _remote = remoteDataSource;

  final TripItineraryRemoteDataSource _remote;

  Future<TripItineraryData> getItinerary(String tripId) =>
      _remote.getItinerary(tripId);

  Future<DestinationItinerary> getDestination(
    String tripId,
    String destinationId,
  ) => _remote.getDestination(tripId, destinationId);

  Future<List<PlaceSearchResult>> searchPlaces({
    required String destinationId,
    required String query,
    List<String>? categories,
    double radiusKm = 20,
  }) => _remote.searchPlaces(
    destinationId: destinationId,
    query: query,
    categories: categories,
    radiusKm: radiusKm,
  );

  Future<List<ItineraryActivity>> reorderItems(
    String tripId,
    String dayId,
    List<String> orderedItemIds,
  ) => _remote.reorderItems(tripId, dayId, orderedItemIds);

  Future<void> deleteDestination(
    String tripId,
    String destinationId, {
    bool acknowledgeRecruitmentImpact = false,
  }) => _remote.deleteDestination(
    tripId,
    destinationId,
    acknowledgeRecruitmentImpact: acknowledgeRecruitmentImpact,
  );

  Future<ItineraryActivity> createActivity(
    String tripId,
    String dayId,
    CreateActivityRequest request,
  ) => _remote.createActivity(tripId, dayId, request);

  Future<CreateItineraryItemsBatchResult> createItemsBatch(
    String tripId,
    CreateItineraryItemsBatchRequest request,
  ) => _remote.createItemsBatch(tripId, request);

  Future<ItineraryActivity> updateActivity(
    String tripId,
    String activityId,
    UpdateActivityRequest request,
  ) => _remote.updateActivity(tripId, activityId, request);

  Future<void> deleteActivity(String tripId, String activityId) =>
      _remote.deleteActivity(tripId, activityId);

  Future<TripCheckin> checkin(
    String tripId,
    String activityId,
    CheckinActivityRequest request,
  ) => _remote.checkin(tripId, activityId, request);

  Future<void> uncheckin(String tripId, String activityId) =>
      _remote.uncheckin(tripId, activityId);

  Future<TripItineraryCompletion> getCompletion(String tripId) =>
      _remote.getCompletion(tripId);
}
