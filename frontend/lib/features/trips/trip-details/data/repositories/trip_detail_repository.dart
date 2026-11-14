import '../datasources/trip_detail_remote_datasource.dart';
import '../models/trip_detail_models.dart';
import '../models/trip_itinerary_route_models.dart';
import '../models/trip_share_models.dart';

class TripDetailRepository {
  const TripDetailRepository({
    required TripDetailRemoteDataSource remoteDataSource,
  }) : _remote = remoteDataSource;

  final TripDetailRemoteDataSource _remote;

  Future<TripDetailOverview> getTripDetail(String tripId) =>
      _remote.getTripDetail(tripId);

  Future<void> kickMember(String tripId, String targetUserId) =>
      _remote.kickMember(tripId, targetUserId);

  Future<void> leaveTrip(String tripId) => _remote.leaveTrip(tripId);

  Future<String> rotateInviteCode(String tripId) =>
      _remote.rotateInviteCode(tripId);

  Future<TripDetailRewardClaim> claimCompletionReward(String tripId) =>
      _remote.claimCompletionReward(tripId);

  /// Place ids the current member has checked in to on this trip.
  Future<Set<String>> getViewerCheckedInPlaceIds(String tripId) async {
    final checkins = await _remote.getMyItineraryCheckins(tripId);
    return {for (final checkin in checkins) checkin.placeId};
  }

  Future<TripDayRoute> getDayRoute(String tripId, String dayId) =>
      _remote.getDayRoute(tripId, dayId);

  Future<TripShareLink> createShareLink(String tripId) =>
      _remote.createShareLink(tripId);

  Future<int> revokeShareLinks(String tripId) =>
      _remote.revokeShareLinks(tripId);

  Future<SharedItinerary> getSharedItinerary(String token) =>
      _remote.getSharedItinerary(token);
}
