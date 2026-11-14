import 'package:travel_frontend_v1/core/networks/api_client.dart';

import '../models/friend_chat_models.dart';

abstract class FriendChatDataSource {
  Future<FriendChatThread> getThread(String conversationId);

  Future<void> markRead(String conversationId);

  // TODO(backend): API demo — chưa có POST send message trên OpenAPI
  Future<FriendChatMessage> sendText({
    required String conversationId,
    required String text,
  });
}

class FriendChatRemoteDataSource implements FriendChatDataSource {
  const FriendChatRemoteDataSource({required ApiClient apiClient})
    : _apiClient = apiClient;

  final ApiClient _apiClient;

  @override
  Future<FriendChatThread> getThread(String conversationId) async {
    // TODO(backend): API demo — thay bằng endpoint thật khi backend xong
    // OpenAPI hiện có GET /friends/conversations/{id}/messages (TEXT only).
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
    // TODO(backend): API demo — thay bằng endpoint thật khi backend xong
    final response = await _apiClient.post<Map<String, dynamic>>(
      '/friends/conversations/${Uri.encodeComponent(conversationId)}/messages',
      data: <String, dynamic>{'content': text, 'messageType': 'TEXT'},
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
