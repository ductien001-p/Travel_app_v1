import 'package:flutter_test/flutter_test.dart';
import 'package:travel_frontend_v1/core/realtime/trip_socket_client.dart';

import 'fake_trip_socket_channel.dart';

void main() {
  late FakeTripSocket socket;

  setUp(() => socket = FakeTripSocket());
  tearDown(() => socket.dispose());

  Future<void> flush() => Future<void>.delayed(Duration.zero);

  Future<List<TripRoomEvent>> watch(String tripId) async {
    final events = <TripRoomEvent>[];
    final subscription = socket.client.watchTrip(tripId).listen(events.add);
    addTearDown(subscription.cancel);
    await flush();
    return events;
  }

  List<Object?> joins() => [
    for (final emit in socket.channel.emitted)
      if (emit.event == 'trip:join') emit.data,
  ];

  test('connects lazily and joins the room once connected', () async {
    expect(socket.channels, isEmpty);

    final events = await watch('trip-1');
    expect(socket.channel.connectCalls, 1);
    expect(joins(), isEmpty);

    socket.channel.serverConnect();
    socket.channel.acceptJoins();
    await flush();

    expect(joins(), [
      {'tripId': 'trip-1'},
    ]);
    expect(events, [isA<TripRoomJoined>()]);
  });

  test('sends the latest stored token on every handshake', () async {
    await watch('trip-1');

    expect(await socket.channel.readToken(), 'access-1');
  });

  test('forwards timeline events of joined rooms only', () async {
    final events = await watch('trip-1');
    socket.channel
      ..serverConnect()
      ..acceptJoins()
      ..serverEmit('trip:timeline', {'id': 'e-1', 'tripId': 'trip-1'})
      ..serverEmit('trip:timeline', {'id': 'e-2', 'tripId': 'trip-2'})
      ..serverEmit('trip:timeline', 'not a map');
    await flush();

    final pushed = events.whereType<TripTimelinePushed>().toList();
    expect(pushed.single.event['id'], 'e-1');
  });

  test('forwards nested trip chat messages and typing', () async {
    final events = await watch('trip-1');
    socket.channel
      ..serverConnect()
      ..acceptJoins()
      ..serverEmit('trip:message', {
        'tripId': 'trip-1',
        'message': {'id': 'm-1', 'kind': 'TEXT', 'text': 'hi'},
      })
      ..serverEmit('trip:typing', {
        'tripId': 'trip-1',
        'userId': 'user-2',
        'isTyping': true,
        'typingLabel': 'Lan đang nhập',
      })
      ..serverEmit('trip:message:reaction', {
        'tripId': 'trip-1',
        'messageId': 'm-1',
        'reactions': [
          {'emoji': '❤️', 'count': 2},
        ],
      });
    await flush();

    final message = events.whereType<TripChatMessagePushed>().single;
    expect(message.message['id'], 'm-1');

    final typing = events.whereType<TripChatTypingPushed>().single;
    expect(typing.typingLabel, 'Lan đang nhập');

    final reaction = events.whereType<TripChatReactionPushed>().single;
    expect(reaction.messageId, 'm-1');
    expect(reaction.reactions.single['count'], 2);
  });

  test('emits trip:typing only after the room is joined', () async {
    await watch('trip-1');
    socket.client.emitTyping(tripId: 'trip-1', isTyping: true);
    expect(
      socket.channel.emitted.where((e) => e.event == 'trip:typing'),
      isEmpty,
    );

    socket.channel
      ..serverConnect()
      ..acceptJoins();
    await flush();

    socket.client.emitTyping(tripId: 'trip-1', isTyping: true);
    expect(socket.channel.emitted.last.event, 'trip:typing');
    expect(socket.channel.emitted.last.data, {
      'tripId': 'trip-1',
      'isTyping': true,
    });
  });

  test('re-joins every watched room after a reconnect', () async {
    final events = await watch('trip-1');
    socket.channel
      ..serverConnect()
      ..acceptJoins()
      ..serverDisconnect();
    await flush();
    expect(events.last, isA<TripRoomLeft>());

    socket.channel
      ..serverConnect()
      ..acceptJoins();
    await flush();

    expect(joins(), [
      {'tripId': 'trip-1'},
      {'tripId': 'trip-1'},
    ]);
    expect(events.whereType<TripRoomJoined>(), hasLength(2));
  });

  test('refreshes the session once after a refused handshake', () async {
    await watch('trip-1');

    socket.channel.serverRefuse();
    await flush();

    expect(socket.channel.connectCalls, 2);
  });

  test(
    'stops instead of looping when the refreshed token is refused',
    () async {
      final events = await watch('trip-1');

      socket.channel.serverRefuse();
      await flush();
      socket.channel.serverRefuse();
      await flush();

      expect(socket.channel.connectCalls, 2);
      expect(events.last, isA<TripRoomRejected>());
    },
  );

  test('a later token refresh restarts a stopped connection', () async {
    await watch('trip-1');
    socket.channel.serverRefuse();
    await flush();
    socket.channel.serverRefuse();
    await flush();

    socket.tokenRefreshes.add(null);
    await flush();

    expect(socket.channel.connectCalls, 3);
  });

  test('stops when the session has expired', () async {
    socket.dispose();
    socket = FakeTripSocket(refreshSession: () async => null);
    final events = await watch('trip-1');

    socket.channel.serverRefuse();
    await flush();

    expect(socket.channel.connectCalls, 1);
    expect(events.last, isA<TripRoomRejected>());
  });

  test('ignores transport errors, Socket.IO retries them itself', () async {
    await watch('trip-1');

    socket.channel.serverRefuse('websocket error');
    await flush();

    expect(socket.channel.connectCalls, 1);
  });

  test('retries after the server closed the connection', () async {
    await watch('trip-1');
    socket.channel
      ..serverConnect()
      ..serverDisconnect('io server disconnect');

    await Future<void>.delayed(const Duration(milliseconds: 30));

    expect(socket.channel.connectCalls, 2);
  });

  test('leaves the room and closes the connection when unwatched', () async {
    final subscription = socket.client.watchTrip('trip-1').listen((_) {});
    await flush();
    socket.channel
      ..serverConnect()
      ..acceptJoins();
    await flush();

    await subscription.cancel();

    final last = socket.channel.emitted.last;
    expect(last.event, 'trip:leave');
    expect(last.data, {'tripId': 'trip-1'});
    expect(socket.channel.disposed, isTrue);
  });

  test('a second watcher of a joined room is told it is joined', () async {
    await watch('trip-1');
    socket.channel
      ..serverConnect()
      ..acceptJoins();
    await flush();

    final second = await watch('trip-1');

    expect(second, [isA<TripRoomJoined>()]);
    expect(socket.channels, hasLength(1));
  });

  test('a join refused by the server rejects the pending room', () async {
    final events = await watch('trip-1');
    socket.channel
      ..serverConnect()
      ..serverEmit('trip:error', {'message': 'not a member'});
    await flush();

    expect(events.last, isA<TripRoomRejected>());
  });
}
