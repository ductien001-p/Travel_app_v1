import '../models/trip_invite_friends_models.dart';

abstract class TripInviteFriendsDataSource {
  /// `GET /trips/recommend-friends/{tripId}`.
  Future<TripInviteFriendsPage> getCandidates(String tripId);

  /// `GET /users/search`.
  Future<TripInviteSearchPage> searchUsers(String query);

  /// `POST /trip-invitations/invite`.
  Future<TripInviteSent> invite({
    required String tripId,
    required String inviteeId,
  });
}
