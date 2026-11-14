import 'package:travel_frontend_v1/core/networks/api_client.dart';
import 'package:travel_frontend_v1/core/networks/api_response_parser.dart';

import '../models/friends_hub_models.dart';

abstract class FriendsHubDataSource {
  Future<FriendsHubPage> getHub();

  Future<void> acceptRequest(String requestId);

  Future<void> rejectRequest(String requestId);

  Future<void> cancelRequest(String requestId);

  Future<void> removeFriend(String friendId);

  Future<String> getOrCreateConversation(String friendId);
}

class FriendsHubRemoteDataSource implements FriendsHubDataSource {
  const FriendsHubRemoteDataSource({required ApiClient apiClient})
    : _apiClient = apiClient;

  final ApiClient _apiClient;

  @override
  Future<FriendsHubPage> getHub() async {
    final results = await Future.wait([
      _apiClient.get<Map<String, dynamic>>('/friends'),
      _apiClient.get<Map<String, dynamic>>('/friends/requests/received'),
      _apiClient.get<Map<String, dynamic>>('/friends/requests/sent'),
    ]);

    final friendships = _dataList(results[0]);
    final received = _dataList(results[1]);
    final sent = _dataList(results[2]);

    final friends = friendships.map(_mapFriendship).toList(growable: false);
    final receivedRequests = received
        .map((row) => _mapRequest(row, fromKey: 'fromUser'))
        .toList(growable: false);
    final sentRequests = sent
        .map((row) => _mapRequest(row, fromKey: 'toUser'))
        .toList(growable: false);

    final count = friends.length;
    return FriendsHubPage(
      friendsCount: count,
      friendsCountLabel: '$count bạn bè đồng hành',
      received: receivedRequests,
      sent: sentRequests,
      friends: friends,
    );
  }

  @override
  Future<void> acceptRequest(String requestId) async {
    await _apiClient.post<Map<String, dynamic>>(
      '/friends/requests/${Uri.encodeComponent(requestId)}/accept',
    );
  }

  @override
  Future<void> rejectRequest(String requestId) async {
    await _apiClient.post<Map<String, dynamic>>(
      '/friends/requests/${Uri.encodeComponent(requestId)}/reject',
    );
  }

  @override
  Future<void> cancelRequest(String requestId) async {
    await _apiClient.delete<Map<String, dynamic>>(
      '/friends/requests/${Uri.encodeComponent(requestId)}',
    );
  }

  @override
  Future<void> removeFriend(String friendId) async {
    await _apiClient.delete<Map<String, dynamic>>(
      '/friends/${Uri.encodeComponent(friendId)}',
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

  List<Map<String, dynamic>> _dataList(Map<String, dynamic> body) {
    final raw = body['data'];
    if (raw is! List) return const <Map<String, dynamic>>[];
    return raw
        .whereType<Map>()
        .map((row) => Map<String, dynamic>.from(row))
        .toList(growable: false);
  }

  FriendsHubFriend _mapFriendship(Map<String, dynamic> row) {
    final friendRaw = row['friend'];
    final friendMap = friendRaw is Map
        ? Map<String, dynamic>.from(friendRaw)
        : <String, dynamic>{};
    final friendId =
        row['friendId']?.toString() ?? friendMap['id']?.toString() ?? '';
    return FriendsHubFriend(
      friendshipId: row['id']?.toString() ?? friendId,
      friendId: friendId,
      createdAt: _parseDate(row['createdAt']),
      conversationId: row['conversationId']?.toString(),
      user: _mapUser(friendMap),
    );
  }

  FriendsHubRequest _mapRequest(
    Map<String, dynamic> row, {
    required String fromKey,
  }) {
    final userRaw = row[fromKey];
    final userMap = userRaw is Map
        ? Map<String, dynamic>.from(userRaw)
        : <String, dynamic>{};
    return FriendsHubRequest(
      id: row['id']?.toString() ?? '',
      createdAt: _parseDate(row['createdAt']),
      user: _mapUser(userMap),
    );
  }

  FriendsHubUser _mapUser(Map<String, dynamic> raw) {
    final username = raw['username']?.toString() ?? '';
    final rawDisplay = raw['displayName']?.toString().trim();
    final rawFullName = raw['fullName']?.toString().trim();
    final displayName = (rawDisplay != null && rawDisplay.isNotEmpty)
        ? rawDisplay
        : (rawFullName != null && rawFullName.isNotEmpty)
        ? rawFullName
        : (username.isEmpty ? 'Người dùng' : username);
    final avatarUrl = _resolveAvatar(
      avatarUrl: raw['avatarUrl']?.toString(),
      avatarId: raw['avatarId']?.toString(),
    );
    return FriendsHubUser(
      id: raw['id']?.toString() ?? '',
      displayName: displayName,
      username: username,
      avatarUrl: avatarUrl,
      isOnline: raw['isOnline'] == true,
      verified: raw['verified'] == true,
      subtitle: raw['subtitle']?.toString(),
      metaIcon: raw['metaIcon']?.toString(),
      metaLine: raw['metaLine']?.toString(),
      badgeLabel: raw['badgeLabel']?.toString(),
      badgeTone: _badgeTone(raw['badgeTone']?.toString()),
    );
  }

  String? _resolveAvatar({String? avatarUrl, String? avatarId}) {
    if (avatarUrl != null && avatarUrl.isNotEmpty) return avatarUrl;
    if (avatarId == null || avatarId.isEmpty) return null;
    if (avatarId.startsWith('http://') || avatarId.startsWith('https://')) {
      return avatarId;
    }
    return null;
  }

  FriendsHubBadgeTone _badgeTone(String? raw) {
    return switch (raw) {
      'PRIMARY' => FriendsHubBadgeTone.primary,
      'SECONDARY' => FriendsHubBadgeTone.secondary,
      'INFO' => FriendsHubBadgeTone.info,
      _ => FriendsHubBadgeTone.subdued,
    };
  }

  DateTime _parseDate(Object? raw) {
    if (raw is DateTime) return raw;
    final parsed = DateTime.tryParse(raw?.toString() ?? '');
    return parsed ?? DateTime.fromMillisecondsSinceEpoch(0, isUtc: true);
  }
}
