import 'package:travel_frontend_v1/core/networks/api_client.dart';

import '../models/trip_invite_friends_models.dart';
import 'trip_invite_friends_datasource.dart';

class TripInviteFriendsRemoteDataSource implements TripInviteFriendsDataSource {
  const TripInviteFriendsRemoteDataSource({required ApiClient apiClient})
    : _apiClient = apiClient;

  final ApiClient _apiClient;

  static const searchPageSize = 20;

  @override
  Future<TripInviteFriendsPage> getCandidates(String tripId) async {
    final body = await _apiClient.get<Map<String, dynamic>>(
      '/trips/recommend-friends/${Uri.encodeComponent(tripId)}',
    );
    final persona = body['tripTravelPersona'];
    return TripInviteFriendsPage(
      candidates: [
        for (final item in _objectList(body, 'recommendations'))
          TripInviteCandidate.fromJson(item),
      ],
      tripTravelPersona: persona is String && persona.isNotEmpty
          ? persona
          : null,
    );
  }

  @override
  Future<TripInviteSearchPage> searchUsers(String query) async {
    final body = await _apiClient.get<Map<String, dynamic>>(
      '/users/search',
      queryParameters: {'q': query, 'page': 1, 'limit': searchPageSize},
    );
    final meta = body['meta'];
    return TripInviteSearchPage(
      users: [
        for (final item in _objectList(body, 'user search'))
          TripInviteFriend.fromJson(item),
      ],
      hasNextPage: meta is Map && meta['hasNextPage'] == true,
    );
  }

  @override
  Future<TripInviteSent> invite({
    required String tripId,
    required String inviteeId,
  }) async {
    final body = await _apiClient.post<Map<String, dynamic>>(
      '/trip-invitations/invite',
      data: {'tripId': tripId, 'inviteeId': inviteeId},
    );
    final data = body['data'];
    if (data is! Map) {
      throw const FormatException('Invalid invitation response.');
    }
    return TripInviteSent.fromJson(Map<String, dynamic>.from(data));
  }

  /// Recommend-friends wraps the list in `data`. A nested `data` is accepted
  /// so a future envelope change does not break the screen.
  static List<Map<String, dynamic>> _objectList(
    Map<String, dynamic> body,
    String what,
  ) {
    final data = body['data'];
    final list = data is Map<String, dynamic> ? data['data'] : data;
    if (list is! List) {
      throw FormatException('Invalid $what response.');
    }
    return [
      for (final item in list)
        if (item is Map) Map<String, dynamic>.from(item),
    ];
  }
}
