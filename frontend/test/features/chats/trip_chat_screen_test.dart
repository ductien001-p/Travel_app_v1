import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:travel_frontend_v1/core/providers/core_provider.dart';
import 'package:travel_frontend_v1/features/chats/trip-chats/data/datamock/trip_chat_datamock.dart';
import 'package:travel_frontend_v1/features/chats/trip-chats/data/datasources/trip_chat_datasource.dart';
import 'package:travel_frontend_v1/features/chats/trip-chats/data/models/trip_chat_models.dart';
import 'package:travel_frontend_v1/features/chats/trip-chats/data/repositories/trip_chat_repository.dart';
import 'package:travel_frontend_v1/features/chats/trip-chats/presentation/screen/trip_chat_screen.dart';
import 'package:travel_frontend_v1/features/chats/trip-chats/provider/trip_chat_provider.dart';

import '../../core/realtime/fake_trip_socket_channel.dart';

void main() {
  testWidgets('renders trip group chat chrome from Stitch', (tester) async {
    tester.view.physicalSize = const Size(390, 2400);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final socket = FakeTripSocket();
    addTearDown(socket.dispose);

    final container = ProviderContainer(
      overrides: [
        tripChatRepositoryProvider.overrideWithValue(
          TripChatRepository(dataSource: _ThreadSource()),
        ),
        tripSocketClientProvider.overrideWithValue(socket.client),
      ],
    );
    addTearDown(container.dispose);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const MaterialApp(
          home: TripChatScreen(tripId: 'trip-mien-trung-2025'),
        ),
      ),
    );
    // Typing dots use a repeating AnimationController — avoid pumpAndSettle.
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.textContaining('Mùa hè rực rỡ'), findsWidgets);
    expect(find.textContaining('đang online'), findsOneWidget);
    expect(find.textContaining('HOẠT ĐỘNG TIẾP THEO'), findsOneWidget);
    expect(find.textContaining('Check-in'), findsOneWidget);
    expect(find.textContaining('Alex Nguyễn'), findsWidgets);
    expect(find.textContaining('Quán Mót Hội An'), findsOneWidget);
    expect(find.textContaining('Khoản chi mới'), findsOneWidget);
  });
}

class _ThreadSource implements TripChatDataSource {
  @override
  Future<TripChatThread> getThread(String tripId) async =>
      TripChatThread.fromJson(tripChatDatamock);

  @override
  Future<void> markRead(String tripId) async {}

  @override
  Future<TripChatMessage> sendText({
    required String tripId,
    required String text,
  }) async {
    return TripChatMessage(
      id: 'sent-1',
      kind: TripChatMessageKind.text,
      isMine: true,
      text: text,
      timeLabel: '15:00',
      readStatus: TripChatReadStatus.sent,
    );
  }

  @override
  Future<List<TripChatReaction>> addReaction({
    required String tripId,
    required String messageId,
    required String emoji,
  }) async => const <TripChatReaction>[];

  @override
  Future<List<TripChatReaction>> removeReaction({
    required String tripId,
    required String messageId,
    required String emoji,
  }) async => const <TripChatReaction>[];
}
