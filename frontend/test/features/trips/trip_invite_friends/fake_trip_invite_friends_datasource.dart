import 'package:travel_frontend_v1/core/networks/api_exception.dart';
import 'package:travel_frontend_v1/features/trips/trip-invitation/data/datamock/trip_invite_friends_datamock.dart';
import 'package:travel_frontend_v1/features/trips/trip-invitation/data/datasources/trip_invite_friends_datasource.dart';
import 'package:travel_frontend_v1/features/trips/trip-invitation/data/models/trip_invite_friends_models.dart';

class FakeTripInviteFriendsDataSource implements TripInviteFriendsDataSource {
  FakeTripInviteFriendsDataSource({this.inviteError, this.searchError});

  Object? inviteError;
  Object? searchError;
  final List<String> invitedIds = [];
  String? lastQuery;

  @override
  Future<TripInviteFriendsPage> getCandidates(String tripId) async {
    final envelope =
        tripInviteFriendsDatamock['recommendations']! as Map<String, dynamic>;
    final persona = envelope['tripTravelPersona'];
    return TripInviteFriendsPage(
      candidates: [
        for (final item in envelope['data']! as List)
          _withInvites(TripInviteCandidate.fromJson(_map(item))),
      ],
      tripTravelPersona: persona is String ? persona : null,
    );
  }

  @override
  Future<TripInviteSearchPage> searchUsers(String query) async {
    lastQuery = query;
    if (searchError != null) throw searchError!;
    final envelope =
        tripInviteFriendsDatamock['search']! as Map<String, dynamic>;
    final meta = envelope['meta']! as Map<String, dynamic>;
    return TripInviteSearchPage(
      users: [
        for (final item in envelope['data']! as List)
          TripInviteFriend.fromJson(_map(item)),
      ],
      hasNextPage: meta['hasNextPage'] == true,
    );
  }

  @override
  Future<TripInviteSent> invite({
    required String tripId,
    required String inviteeId,
  }) async {
    if (inviteError != null) throw inviteError!;
    invitedIds.add(inviteeId);
    final envelope =
        tripInviteFriendsDatamock['invitation']! as Map<String, dynamic>;
    return TripInviteSent.fromJson(
      _map(envelope['data']),
    ).copyWith(tripId: tripId, inviteeId: inviteeId);
  }

  TripInviteCandidate _withInvites(TripInviteCandidate person) {
    if (!invitedIds.contains(person.user.id)) return person;
    return person.copyWith(invitationStatus: TripInviteStatus.pending);
  }
}

Map<String, dynamic> _map(Object? value) =>
    Map<String, dynamic>.from(value! as Map);

const alreadyPendingInvite = ApiException(
  message: 'Invitation is already pending',
  statusCode: 409,
);
