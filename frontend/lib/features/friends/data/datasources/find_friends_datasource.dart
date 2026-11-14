import 'package:travel_frontend_v1/core/networks/api_client.dart';
import 'package:travel_frontend_v1/core/networks/api_response_parser.dart';

import '../models/find_friends_models.dart';

abstract class FindFriendsDataSource {
  Future<FindFriendsPage> find({String? query, double? lat, double? lng});

  Future<void> updateDiscoveryLocation({
    required double lat,
    required double lng,
    bool shareLocationForDiscovery = true,
  });

  Future<FindFriendsRequestSent> sendFriendRequest(String toUserId);

  Future<void> cancelFriendRequest(String requestId);

  Future<void> followUser(String followingId);

  Future<void> unfollowUser(String followingId);

  Future<String> getOrCreateConversation(String friendId);
}

class FindFriendsRemoteDataSource implements FindFriendsDataSource {
  const FindFriendsRemoteDataSource({required ApiClient apiClient})
    : _apiClient = apiClient;

  final ApiClient _apiClient;

  @override
  Future<FindFriendsPage> find({
    String? query,
    double? lat,
    double? lng,
  }) async {
    final q = query?.trim();
    final response = await _apiClient.get<Map<String, dynamic>>(
      '/friends/find',
      queryParameters: <String, dynamic>{
        if (q != null && q.isNotEmpty) 'q': q,
        'lat': ?lat,
        'lng': ?lng,
      },
    );
    return FindFriendsPage.fromJson(ApiResponseParser.dataMap(response));
  }

  @override
  Future<void> updateDiscoveryLocation({
    required double lat,
    required double lng,
    bool shareLocationForDiscovery = true,
  }) async {
    await _apiClient.put<Map<String, dynamic>>(
      '/friends/discovery-location',
      data: <String, dynamic>{
        'lat': lat,
        'lng': lng,
        'shareLocationForDiscovery': shareLocationForDiscovery,
      },
    );
  }

  @override
  Future<FindFriendsRequestSent> sendFriendRequest(String toUserId) async {
    final response = await _apiClient.post<Map<String, dynamic>>(
      '/friends/requests',
      data: <String, dynamic>{'toUserId': toUserId},
    );
    return FindFriendsRequestSent.fromJson(ApiResponseParser.dataMap(response));
  }

  @override
  Future<void> cancelFriendRequest(String requestId) async {
    await _apiClient.delete<Map<String, dynamic>>(
      '/friends/requests/${Uri.encodeComponent(requestId)}',
    );
  }

  @override
  Future<void> followUser(String followingId) async {
    await _apiClient.post<Map<String, dynamic>>(
      '/follow',
      data: <String, dynamic>{'followingId': followingId},
    );
  }

  @override
  Future<void> unfollowUser(String followingId) async {
    await _apiClient.delete<Map<String, dynamic>>(
      '/follow',
      data: <String, dynamic>{'followingId': followingId},
    );
  }

  @override
  Future<String> getOrCreateConversation(String friendId) async {
    final response = await _apiClient.post<Map<String, dynamic>>(
      '/friends/${Uri.encodeComponent(friendId)}/conversation',
    );
    final data = ApiResponseParser.dataMap(response);
    final id = data['id']?.toString();
    if (id == null || id.isEmpty) {
      throw const FormatException('Conversation id missing.');
    }
    return id;
  }
}
