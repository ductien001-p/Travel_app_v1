import '../datasources/friend_chat_datasource.dart';
import '../models/friend_chat_models.dart';

class FriendChatRepository {
  const FriendChatRepository({required FriendChatDataSource dataSource})
    : _dataSource = dataSource;

  final FriendChatDataSource _dataSource;

  Future<FriendChatThread> getThread(String conversationId) =>
      _dataSource.getThread(conversationId);

  Future<void> markRead(String conversationId) =>
      _dataSource.markRead(conversationId);

  Future<FriendChatMessage> sendText({
    required String conversationId,
    required String text,
  }) => _dataSource.sendText(conversationId: conversationId, text: text);

  Future<FriendChatMessage> sendTripInvite({
    required String conversationId,
    required FriendChatInviteCandidate candidate,
  }) => _dataSource.sendTripInvite(
    conversationId: conversationId,
    candidate: candidate,
  );
}
