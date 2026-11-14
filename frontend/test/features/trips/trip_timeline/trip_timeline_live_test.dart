import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:travel_frontend_v1/core/providers/core_provider.dart';
import 'package:travel_frontend_v1/features/trips/trip-timeline/application/trip_timeline_events_controller.dart';
import 'package:travel_frontend_v1/features/trips/trip-timeline/application/trip_timeline_live_controller.dart';
import 'package:travel_frontend_v1/features/trips/trip-timeline/provider/trip_timeline_provider.dart';

import '../../../core/realtime/fake_trip_socket_channel.dart';
import 'trip_timeline_fixture.dart';

void main() {
  final events = tripTimelineEventsControllerProvider('trip-1');
  final live = tripTimelineLiveProvider('trip-1');

  late FakeTripSocket socket;
  late FakeTripTimelineDataSource dataSource;
  late ProviderContainer container;

  Future<void> flush() => Future<void>.delayed(Duration.zero);

  setUp(() async {
    socket = FakeTripSocket();
    dataSource = FakeTripTimelineDataSource({
      null: timelinePageJson(
        [timelineEventJson(id: 'e-1')],
        counts: const {'all': 1},
      ),
    });
    container = ProviderContainer(
      overrides: [
        tripTimelineRemoteDataSourceProvider.overrideWithValue(dataSource),
        tripSocketClientProvider.overrideWithValue(socket.client),
      ],
    );
    container
      ..listen(events, (_, _) {})
      ..listen(live, (_, _) {});
    await container.read(events.future);
    await flush();
  });

  tearDown(() {
    container.dispose();
    socket.dispose();
  });

  void joinRoom() => socket.channel
    ..serverConnect()
    ..acceptJoins();

  test('is connecting until the room is joined, then live', () async {
    expect(container.read(live), TripTimelineLiveStatus.connecting);

    joinRoom();
    await flush();

    expect(container.read(live), TripTimelineLiveStatus.live);
  });

  test('puts a pushed event on top of the timeline', () async {
    joinRoom();
    socket.channel.serverEmit(
      'trip:timeline',
      timelineEventJson(id: 'live-1', type: 'ACTIVITY_CHECKIN'),
    );
    await flush();

    final state = container.read(events).requireValue;
    expect(state.entries.map((entry) => entry.id), ['live-1', 'e-1']);
    expect(state.counts.checkin, 1);
    expect(state.counts.all, 2);
  });

  test('drops a malformed pushed event', () async {
    joinRoom();
    socket.channel.serverEmit('trip:timeline', {
      'tripId': 'trip-1',
      'id': 'bad',
    });
    await flush();

    expect(container.read(events).requireValue.entries, hasLength(1));
  });

  test('reloads the timeline after re-joining to catch up', () async {
    joinRoom();
    await flush();
    socket.channel.serverDisconnect();
    await flush();
    expect(container.read(live), TripTimelineLiveStatus.connecting);

    joinRoom();
    await flush();
    await flush();

    expect(container.read(live), TripTimelineLiveStatus.live);
    expect(dataSource.requestedCursors, [null, null]);
  });

  test('is offline when the server refuses the session', () async {
    socket.channel.serverRefuse();
    await flush();
    socket.channel.serverRefuse();
    await flush();

    expect(container.read(live), TripTimelineLiveStatus.offline);
  });
}
