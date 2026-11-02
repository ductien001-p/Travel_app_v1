import '../models/trip_invite_preview_models.dart';
import '../models/trip_join_request_models.dart';

/// Join requests of one trip, reviewed by its owner and admins.
abstract interface class TripJoinRequestsDataSource {
  /// `GET /trips/join/{inviteCode}` — preview before asking to join.
  Future<TripJoinInvitePreview> previewByInviteCode(String inviteCode);

  /// Asks to join the trip of [inviteCode]; the request comes back `APPROVED`
  /// when the trip lets friends of the owner in without review.
  Future<TripJoinRequest> requestToJoin(String inviteCode, {String? message});

  /// `GET /trips/{tripId}/join/preview` — PUBLIC trips only.
  Future<TripJoinInvitePreview> previewByTripId(String tripId);

  /// `POST /trips/{tripId}/join` — PUBLIC trips only (Community Explore).
  Future<TripJoinRequest> requestToJoinByTripId(
    String tripId, {
    String? message,
  });

  /// Newest first; [cursor] is only valid with the [status] it was issued for.
  Future<TripJoinRequestsPage> getJoinRequests(
    String tripId, {
    required TripJoinRequestStatus status,
    required int limit,
    String? cursor,
  });

  Future<TripJoinRequest> approveJoinRequest(String tripId, String requestId);

  Future<TripJoinRequest> rejectJoinRequest(String tripId, String requestId);

  Future<TripJoinRequestSettings> getJoinRequestSettings(String tripId);

  Future<TripJoinRequestSettings> updateJoinRequestSettings(
    String tripId,
    TripJoinRequestSettings settings,
  );
}
