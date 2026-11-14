import 'package:flutter_test/flutter_test.dart';
import 'package:travel_frontend_v1/features/chats/friend-chat/data/datamock/friend_chat_datamock.dart';
import 'package:travel_frontend_v1/features/chats/friend-chat/data/models/friend_chat_models.dart';

void main() {
  test('parses Stitch friend-chat datamock into freezed models', () {
    final thread = FriendChatThread.fromJson(friendChatDatamock);

    expect(thread.conversationId, 'conv-alex');
    expect(thread.peer.displayName, 'Alex Nguyễn');
    expect(thread.peer.roleBadge, 'Trưởng nhóm');
    expect(thread.peer.isOnline, isTrue);
    expect(thread.sharedTrip?.title, contains('Mùa Hè Rực Rỡ'));
    expect(thread.messages, isNotEmpty);
    expect(
      thread.messages.where((m) => m.kind == FriendChatMessageKind.placeCard),
      isNotEmpty,
    );
    expect(
      thread.messages.where((m) => m.kind == FriendChatMessageKind.tripInvite),
      isNotEmpty,
    );
    expect(thread.shortcuts.first.kind, FriendChatShortcutKind.inviteTrip);
    expect(thread.inviteCandidates, hasLength(2));
  });
}
