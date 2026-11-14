import '../datasources/find_friends_datasource.dart';
import '../models/find_friends_models.dart';

class FindFriendsRepository {
  const FindFriendsRepository({required FindFriendsDataSource dataSource})
    : _dataSource = dataSource;

  final FindFriendsDataSource _dataSource;

  Future<FindFriendsPage> find({String? query, double? lat, double? lng}) =>
      _dataSource.find(query: query, lat: lat, lng: lng);

  Future<void> updateDiscoveryLocation({
    required double lat,
    required double lng,
    bool shareLocationForDiscovery = true,
  }) => _dataSource.updateDiscoveryLocation(
    lat: lat,
    lng: lng,
    shareLocationForDiscovery: shareLocationForDiscovery,
  );

  Future<FindFriendsRequestSent> sendFriendRequest(String toUserId) =>
      _dataSource.sendFriendRequest(toUserId);

  Future<void> cancelFriendRequest(String requestId) =>
      _dataSource.cancelFriendRequest(requestId);

  Future<void> followUser(String followingId) =>
      _dataSource.followUser(followingId);

  Future<void> unfollowUser(String followingId) =>
      _dataSource.unfollowUser(followingId);

  Future<String> getOrCreateConversation(String friendId) =>
      _dataSource.getOrCreateConversation(friendId);
}
