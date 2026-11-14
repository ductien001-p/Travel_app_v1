import '../datasources/friends_hub_datasource.dart';
import '../models/friends_hub_models.dart';

class FriendsHubRepository {
  const FriendsHubRepository({required FriendsHubDataSource dataSource})
    : _dataSource = dataSource;

  final FriendsHubDataSource _dataSource;

  Future<FriendsHubPage> getHub() => _dataSource.getHub();

  Future<void> acceptRequest(String requestId) =>
      _dataSource.acceptRequest(requestId);

  Future<void> rejectRequest(String requestId) =>
      _dataSource.rejectRequest(requestId);

  Future<void> cancelRequest(String requestId) =>
      _dataSource.cancelRequest(requestId);

  Future<void> removeFriend(String friendId) =>
      _dataSource.removeFriend(friendId);

  Future<String> getOrCreateConversation(String friendId) =>
      _dataSource.getOrCreateConversation(friendId);
}
