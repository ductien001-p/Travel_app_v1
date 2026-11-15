import 'package:travel_frontend_v1/core/networks/api_client.dart';

import '../models/friend_chat_models.dart';

abstract class FriendChatDataSource {
  Future<FriendChatThread> getThread(String conversationId);

  Future<void> markRead(String conversationId);

  Future<FriendChatMessage> sendText({
    required String conversationId,
    required String text,
  });

  Future<FriendChatMessage> sendTripInvite({
    required String conversationId,
    required FriendChatInviteCandidate candidate,
  });
}

class FriendChatRemoteDataSource implements FriendChatDataSource {
  const FriendChatRemoteDataSource({required ApiClient apiClient})
    : _apiClient = apiClient;

  final ApiClient _apiClient;

  @override
  Future<FriendChatThread> getThread(String conversationId) async {
    final response = await _apiClient.get<Map<String, dynamic>>(
      '/friends/conversations/${Uri.encodeComponent(conversationId)}/thread',
    );
    return FriendChatThread.fromJson(_dataFromEnvelope(response));
  }

  @override
  Future<void> markRead(String conversationId) async {
    await _apiClient.post<Map<String, dynamic>>(
      '/friends/conversations/${Uri.encodeComponent(conversationId)}/read',
    );
  }

  @override
  Future<FriendChatMessage> sendText({
    required String conversationId,
    required String text,
  }) async {
    final response = await _apiClient.post<Map<String, dynamic>>(
      '/friends/conversations/${Uri.encodeComponent(conversationId)}/messages',
      data: <String, dynamic>{'content': text, 'messageType': 'TEXT'},
    );
    return FriendChatMessage.fromJson(_dataFromEnvelope(response));
  }

  @override
  Future<FriendChatMessage> sendTripInvite({
    required String conversationId,
    required FriendChatInviteCandidate candidate,
  }) async {
    final imageUrl = candidate.imageUrl.trim().isEmpty
        ? 'about:blank'
        : candidate.imageUrl;
    final response = await _apiClient.post<Map<String, dynamic>>(
      '/friends/conversations/${Uri.encodeComponent(conversationId)}/messages',
      data: <String, dynamic>{
        'content': candidate.title,
        'messageType': 'TRIP_INVITE',
        'metadata': <String, dynamic>{
          'tripId': candidate.tripId,
          'title': candidate.title,
          'imageUrl': imageUrl,
          'dateLabel': candidate.metaLabel,
          'priceLabel': '—',
          'seatsLabel': candidate.badgeLabel,
          'badgeLabel': candidate.badgeLabel,
          'primaryActionLabel': 'Tham gia',
          'secondaryActionLabel': 'Chi tiết',
        },
      },
    );
    return FriendChatMessage.fromJson(_dataFromEnvelope(response));
  }

  Map<String, dynamic> _dataFromEnvelope(Map<String, dynamic> response) {
    final data = response['data'];
    if (data is Map<String, dynamic>) return data;
    if (data is Map) return Map<String, dynamic>.from(data);
    throw const FormatException(
      'Friend chat response does not contain a valid data object.',
    );
  }
}
