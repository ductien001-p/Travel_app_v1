import 'package:travel_frontend_v1/core/networks/api_client.dart';

import '../models/trip_detail_models.dart';
import '../models/trip_itinerary_checkin_models.dart';
import '../models/trip_itinerary_route_models.dart';
import '../models/trip_share_models.dart';

class TripDetailRemoteDataSource {
  const TripDetailRemoteDataSource({required ApiClient apiClient})
    : _apiClient = apiClient;

  final ApiClient _apiClient;

  Future<TripDetailOverview> getTripDetail(String tripId) async {
    final body = await _apiClient.get<Map<String, dynamic>>(
      '/trips/${Uri.encodeComponent(tripId)}',
    );
    return TripDetailOverview.fromJson(_dataMap(body));
  }

  Future<void> kickMember(String tripId, String targetUserId) async {
    await _apiClient.post<Object?>(
      '/trips/kick/${Uri.encodeComponent(tripId)}/'
      '${Uri.encodeComponent(targetUserId)}',
    );
  }

  Future<void> leaveTrip(String tripId) async {
    await _apiClient.post<Object?>(
      '/trips/leave/${Uri.encodeComponent(tripId)}',
    );
  }

  /// `POST /trips/{tripId}/invite-code/rotate` — owner only.
  Future<String> rotateInviteCode(String tripId) async {
    final body = await _apiClient.post<Map<String, dynamic>>(
      '/trips/${Uri.encodeComponent(tripId)}/invite-code/rotate',
    );
    final code = _dataMap(body)['inviteCode'];
    if (code is! String || code.isEmpty) {
      throw const FormatException('Response does not contain inviteCode.');
    }
    return code;
  }

  Future<TripDetailRewardClaim> claimCompletionReward(String tripId) async {
    final body = await _apiClient.post<Map<String, dynamic>>(
      '/trips/${Uri.encodeComponent(tripId)}/completion',
    );
    return TripDetailRewardClaim.fromJson(_dataMap(body));
  }

  Future<List<TripItineraryViewerCheckin>> getMyItineraryCheckins(
    String tripId,
  ) async {
    final body = await _apiClient.get<Map<String, dynamic>>(
      '/trips/${Uri.encodeComponent(tripId)}/itineraries/checkins/me',
    );
    final data = body['data'];
    if (data is! List) {
      throw const FormatException('Response does not contain a data list.');
    }
    return data
        .map(
          (item) => TripItineraryViewerCheckin.fromJson(
            Map<String, dynamic>.from(item as Map),
          ),
        )
        .toList(growable: false);
  }

  Future<TripDayRoute> getDayRoute(String tripId, String dayId) async {
    final body = await _apiClient.get<Map<String, dynamic>>(
      '/trips/${Uri.encodeComponent(tripId)}/itineraries/days/'
      '${Uri.encodeComponent(dayId)}/route',
    );
    return TripDayRoute.fromJson(_dataMap(body));
  }

  Future<TripShareLink> createShareLink(String tripId) async {
    final body = await _apiClient.post<Map<String, dynamic>>(
      '/trips/${Uri.encodeComponent(tripId)}/share-links',
    );
    return TripShareLink.fromJson(_dataMap(body));
  }

  /// Returns how many live links were revoked.
  Future<int> revokeShareLinks(String tripId) async {
    final body = await _apiClient.delete<Map<String, dynamic>>(
      '/trips/${Uri.encodeComponent(tripId)}/share-links',
    );
    final count = _dataMap(body)['revokedCount'];
    if (count is! num) {
      throw const FormatException('Response does not contain revokedCount.');
    }
    return count.toInt();
  }

  Future<SharedItinerary> getSharedItinerary(String token) async {
    final body = await _apiClient.get<Map<String, dynamic>>(
      '/trip-shares/${Uri.encodeComponent(token)}',
    );
    return SharedItinerary.parse(_dataMap(body));
  }

  Map<String, dynamic> _dataMap(Map<String, dynamic> body) {
    final data = body['data'];
    if (data is Map) return Map<String, dynamic>.from(data);
    throw const FormatException('Response does not contain a data object.');
  }
}
