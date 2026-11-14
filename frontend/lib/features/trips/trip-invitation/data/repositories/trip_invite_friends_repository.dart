import '../datasources/trip_invite_friends_datasource.dart';
import '../models/trip_invite_friends_models.dart';

class TripInviteFriendsRepository {
  const TripInviteFriendsRepository({
    required TripInviteFriendsDataSource dataSource,
  }) : _dataSource = dataSource;

  /// Matches `@MinLength(1)` / `@MaxLength(100)` of `GET /users/search`.
  static const minQueryLength = 1;
  static const maxQueryLength = 100;

  final TripInviteFriendsDataSource _dataSource;

  Future<TripInviteFriendsPage> getCandidates(String tripId) =>
      _dataSource.getCandidates(tripId);

  Future<TripInviteSearchPage> searchUsers(String query) {
    final trimmed = query.trim();
    if (trimmed.length < minQueryLength || trimmed.length > maxQueryLength) {
      throw ArgumentError.value(
        query,
        'query',
        'Must be $minQueryLength–$maxQueryLength characters',
      );
    }
    return _dataSource.searchUsers(trimmed);
  }

  Future<TripInviteSent> invite({
    required String tripId,
    required String inviteeId,
  }) => _dataSource.invite(tripId: tripId, inviteeId: inviteeId);
}
