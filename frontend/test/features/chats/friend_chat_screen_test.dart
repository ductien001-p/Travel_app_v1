import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:travel_frontend_v1/core/providers/core_provider.dart';
import 'package:travel_frontend_v1/core/realtime/friend_socket_client.dart';

import '../../core/realtime/fake_trip_socket_channel.dart';
import 'package:travel_frontend_v1/features/chats/friend-chat/data/datamock/friend_chat_datamock.dart';
import 'package:travel_frontend_v1/features/chats/friend-chat/data/datasources/friend_chat_datasource.dart';
import 'package:travel_frontend_v1/features/chats/friend-chat/data/models/friend_chat_models.dart';
import 'package:travel_frontend_v1/features/chats/friend-chat/data/repositories/friend_chat_repository.dart';
import 'package:travel_frontend_v1/features/chats/friend-chat/presentation/screen/friend_chat_screen.dart';
import 'package:travel_frontend_v1/features/chats/friend-chat/provider/friend_chat_provider.dart';

void main() {
  testWidgets('renders 1-on-1 friend chat chrome from Stitch', (tester) async {
    tester.view.physicalSize = const Size(390, 2400);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final container = ProviderContainer(
      overrides: [
        friendChatRepositoryProvider.overrideWithValue(
          FriendChatRepository(dataSource: _ThreadSource()),
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

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const MaterialApp(
          home: FriendChatScreen(conversationId: 'conv-alex'),
        ),
      ),
    );
    // Typing dots use a repeating AnimationController — avoid pumpAndSettle.
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.text('Alex Nguyễn'), findsWidgets);
    expect(find.textContaining('Trưởng nhóm'), findsOneWidget);
    expect(find.textContaining('Chuyến đi chung'), findsOneWidget);
    expect(find.textContaining('Faifo Coffee'), findsOneWidget);
    expect(find.textContaining('Tham gia chuyến đi'), findsOneWidget);
    expect(find.text('Mời vào chuyến đi'), findsOneWidget);
    expect(find.textContaining('đang soạn tin nhắn'), findsOneWidget);
  });
}

class _ThreadSource implements FriendChatDataSource {
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
    return FriendChatMessage(
      id: 'sent-1',
      kind: FriendChatMessageKind.text,
      isMine: true,
      text: text,
      timeLabel: '15:00',
      readStatus: FriendChatReadStatus.sent,
    );
  }

  @override
  Future<FriendChatMessage> sendTripInvite({
    required String conversationId,
    required FriendChatInviteCandidate candidate,
  }) async {
    return FriendChatMessage(
      id: 'invite-1',
      kind: FriendChatMessageKind.tripInvite,
      isMine: true,
      text: candidate.title,
      timeLabel: '15:00',
    );
  }
}
