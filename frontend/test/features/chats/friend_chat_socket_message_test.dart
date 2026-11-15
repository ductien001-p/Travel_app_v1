import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:travel_frontend_v1/core/providers/core_provider.dart';
import 'package:travel_frontend_v1/core/realtime/friend_socket_client.dart';
import 'package:travel_frontend_v1/features/chats/friend-chat/application/friend_chat_controller.dart';
import 'package:travel_frontend_v1/features/chats/friend-chat/data/datamock/friend_chat_datamock.dart';
import 'package:travel_frontend_v1/features/chats/friend-chat/data/datasources/friend_chat_datasource.dart';
import 'package:travel_frontend_v1/features/chats/friend-chat/data/friend_chat_socket_message.dart';
import 'package:travel_frontend_v1/features/chats/friend-chat/data/models/friend_chat_models.dart';
import 'package:travel_frontend_v1/features/chats/friend-chat/data/repositories/friend_chat_repository.dart';
import 'package:travel_frontend_v1/features/chats/friend-chat/provider/friend_chat_provider.dart';

import '../../core/realtime/fake_trip_socket_channel.dart';

void main() {
  test('parses a UI friend message payload', () {
    final message = friendChatMessageFromSocket({
      'id': 'm-1',
      'kind': 'TEXT',
      'isMine': false,
      'text': 'Xin chào',
      'timeLabel': '14:10',
      'showAvatar': true,
    });

    expect(message?.text, 'Xin chào');
    expect(message?.kind, FriendChatMessageKind.text);
    expect(message?.isMine, isFalse);
  });

  test('parses a stored friend row into the UI shape', () {
    final message = friendChatMessageFromSocket(
      {
        'id': 'm-2',
        'senderId': 'user-me',
        'content': 'Đi không?',
        'messageType': 'TEXT',
        'createdAt': '2026-07-19T07:05:00.000Z',
      },
      peerUserId: 'user-alex',
    );

    expect(message?.text, 'Đi không?');
    expect(message?.isMine, isTrue);
    expect(message?.timeLabel, isNotEmpty);
  });

  test('parses a stored trip invite card', () {
    final message = friendChatMessageFromSocket({
      'id': 'm-3',
      'senderId': 'user-alex',
      'content': 'Mùa hè',
      'messageType': 'TRIP_INVITE',
      'metadata': {
        'tripId': 'trip-1',
        'title': 'Mùa hè',
        'imageUrl': 'https://example.com/a.jpg',
        'dateLabel': '19 Tháng 7',
        'priceLabel': '—',
        'seatsLabel': 'Còn 2 chỗ',
      },
    }, peerUserId: 'user-alex');

    expect(message?.kind, FriendChatMessageKind.tripInvite);
    expect(message?.tripInvite?.tripId, 'trip-1');
    expect(message?.isMine, isFalse);
  });

  test('marks a failed DM send instead of pretending it was delivered', () async {
    final container = ProviderContainer(
      overrides: [
        friendChatRepositoryProvider.overrideWithValue(
          FriendChatRepository(dataSource: _FailingSend()),
        ),
        friendSocketClientProvider.overrideWith((ref) {
          final client = FriendSocketClient(
            readAccessToken: () async => null,
            refreshSession: () async => null,
            tokenRefreshes: const Stream.empty(),
            channelFactory: FakeTripSocketChannel.new,
          );
          ref.onDispose(client.dispose);
          return client;
        }),
      ],
    );
    addTearDown(container.dispose);

    await container.read(friendChatControllerProvider('conv-alex').future);
    final ok = await container
        .read(friendChatControllerProvider('conv-alex').notifier)
        .sendText('hello');
    final thread = container
        .read(friendChatControllerProvider('conv-alex'))
        .value!;

    expect(ok, isFalse);
    expect(
      thread.messages.last.readStatus,
      FriendChatReadStatus.failed,
    );
  });
}

class _FailingSend implements FriendChatDataSource {
  @override
  Future<FriendChatThread> getThread(String conversationId) async =>
      FriendChatThread.fromJson(friendChatDatamock);

  @override
  Future<void> markRead(String conversationId) async {}

  @override
  Future<FriendChatMessage> sendText({
    required String conversationId,
    required String text,
  }) async {
    throw Exception('offline');
  }

  @override
  Future<FriendChatMessage> sendTripInvite({
    required String conversationId,
    required FriendChatInviteCandidate candidate,
  }) async {
    throw Exception('offline');
  }
}
