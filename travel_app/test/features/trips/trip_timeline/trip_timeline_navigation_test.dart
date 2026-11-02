import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_frontend_v1/app/router/router_names.dart';
import 'package:travel_frontend_v1/core/providers/core_provider.dart';
import 'package:travel_frontend_v1/features/trips/trip-details/presentation/screen/trip_detail_screen.dart';
import 'package:travel_frontend_v1/features/trips/trip-details/provider/trip_detail_provider.dart';
import 'package:travel_frontend_v1/features/trips/trip-memories/application/trip_memories_view.dart';
import 'package:travel_frontend_v1/features/trips/trip-memories/presentation/screen/trip_memories_screen.dart';
import 'package:travel_frontend_v1/features/trips/trip-memories/provider/trip_memories_provider.dart';
import 'package:travel_frontend_v1/features/trips/trip-timeline/application/trip_timeline_view.dart';
import 'package:travel_frontend_v1/features/trips/trip-timeline/presentation/screen/trip_timeline_screen.dart';
import 'package:travel_frontend_v1/features/trips/trip-timeline/provider/trip_timeline_provider.dart';

import '../../../core/realtime/fake_trip_socket_channel.dart';
import '../trip_details/trip_detail_fixture.dart';
import '../trip_memories/trip_memories_fixture.dart' hide utcWallClock;
import 'trip_timeline_fixture.dart';

void main() {
  testWidgets('"Xem thêm" in the trip detail opens the trip timeline', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(360, 780);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    final router = GoRouter(
      initialLocation: '/trips/trip-1',
      routes: [
        GoRoute(
          path: '/trips/:tripId',
          name: RouteNames.tripDetail,
          builder: (context, state) =>
              TripDetailScreen(tripId: state.pathParameters['tripId']!),
          routes: [
            GoRoute(
              path: 'timeline',
              name: RouteNames.tripTimeline,
              builder: (context, state) =>
                  TripTimelineScreen(tripId: state.pathParameters['tripId']!),
            ),
          ],
        ),
      ],
    );
    addTearDown(router.dispose);
    final socket = FakeTripSocket();
    addTearDown(socket.dispose);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          tripSocketClientProvider.overrideWithValue(socket.client),
          tripDetailRemoteDataSourceProvider.overrideWithValue(
            FakeTripDetailRemoteDataSource(),
          ),
          tripTimelineRemoteDataSourceProvider.overrideWithValue(
            FakeTripTimelineDataSource({null: timelineDatamockPage()}),
          ),
          tripTimelineClockProvider.overrideWithValue(() => timelineNow),
          tripTimelineWallClockProvider.overrideWithValue(utcWallClock),
        ],
        child: MaterialApp.router(routerConfig: router),
      ),
    );
    await tester.pump();

    final seeMore = find.text('Xem thêm (8)');
    final list = find.byType(Scrollable).first;
    await tester.scrollUntilVisible(seeMore, 200, scrollable: list);
    // Lift the link above the detail screen's bottom bar.
    await tester.drag(list, const Offset(0, -300));
    await tester.pumpAndSettle();
    await tester.tap(seeMore);
    await tester.pumpAndSettle();

    expect(find.byType(TripTimelineScreen), findsOneWidget);
    expect(find.text('Dòng Thời Gian Chuyến Đi'), findsOneWidget);
    expect(find.text('Hôm nay'), findsOneWidget);
  });

  testWidgets('"Xem album" on a photo event opens the trip album', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(360, 780);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    final router = GoRouter(
      initialLocation: '/trips/trip-1/timeline',
      routes: [
        GoRoute(
          path: '/trips/:tripId',
          name: RouteNames.tripDetail,
          builder: (context, state) =>
              TripDetailScreen(tripId: state.pathParameters['tripId']!),
          routes: [
            GoRoute(
              path: 'timeline',
              name: RouteNames.tripTimeline,
              builder: (context, state) =>
                  TripTimelineScreen(tripId: state.pathParameters['tripId']!),
            ),
            GoRoute(
              path: 'memories',
              name: RouteNames.tripMemories,
              builder: (context, state) =>
                  TripMemoriesScreen(tripId: state.pathParameters['tripId']!),
            ),
          ],
        ),
      ],
    );
    addTearDown(router.dispose);
    final socket = FakeTripSocket();
    addTearDown(socket.dispose);
    final memories = FakeTripMemoriesDataSource({
      firstPage: memoriesDatamockPage(),
    });

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          tripSocketClientProvider.overrideWithValue(socket.client),
          tripDetailRemoteDataSourceProvider.overrideWithValue(
            FakeTripDetailRemoteDataSource(memoriesTripDetailJson()),
          ),
          tripTimelineRemoteDataSourceProvider.overrideWithValue(
            FakeTripTimelineDataSource({null: timelineDatamockPage()}),
          ),
          tripTimelineClockProvider.overrideWithValue(() => timelineNow),
          tripTimelineWallClockProvider.overrideWithValue(utcWallClock),
          tripMemoriesRemoteDataSourceProvider.overrideWithValue(memories),
          tripMemoriesWallClockProvider.overrideWithValue(utcWallClock),
        ],
        child: MaterialApp.router(routerConfig: router),
      ),
    );
    await tester.pump();
    await tester.pump();

    final albumLink = find.text('Xem album');
    await tester.ensureVisible(albumLink.first);
    await tester.pump();
    await tester.tap(albumLink.first);
    await tester.pumpAndSettle();

    expect(find.byType(TripMemoriesScreen), findsOneWidget);
    expect(find.text('Kỷ Niệm Chuyến Đi'), findsOneWidget);
    expect(memories.requests, [firstPage]);
  });
}
