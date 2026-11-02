import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_frontend_v1/app/router/router_names.dart';
import 'package:travel_frontend_v1/features/trips/trip-details/presentation/screen/trip_detail_screen.dart';
import 'package:travel_frontend_v1/features/trips/trip-details/presentation/widgets/trip_detail_pill_button.dart';
import 'package:travel_frontend_v1/features/trips/trip-details/provider/trip_detail_provider.dart';
import 'package:travel_frontend_v1/features/trips/trip-invitation/presentation/screen/trip_join_requests_screen.dart';
import 'package:travel_frontend_v1/features/trips/trip-invitation/provider/trip_join_requests_provider.dart';

import 'trip_join_requests_fixture.dart';

void main() {
  testWidgets('"Yêu cầu" in the trip detail opens the join requests', (
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
              path: 'join-requests',
              name: RouteNames.tripJoinRequests,
              builder: (context, state) => TripJoinRequestsScreen(
                tripId: state.pathParameters['tripId']!,
              ),
            ),
          ],
        ),
      ],
    );
    addTearDown(router.dispose);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          tripJoinRequestsDataSourceProvider.overrideWithValue(
            FakeTripJoinRequestsDataSource(),
          ),
          tripDetailRemoteDataSourceProvider.overrideWithValue(
            CountingTripDetailDataSource(joinRequestsTripJson()),
          ),
          tripJoinRequestsClockProvider.overrideWithValue(() => fixtureNow),
        ],
        child: MaterialApp.router(routerConfig: router),
      ),
    );
    await tester.pump();
    await tester.pump();

    final openRequests = find.widgetWithText(TripDetailPillButton, 'Yêu cầu');
    await tester.scrollUntilVisible(
      openRequests,
      200,
      scrollable: find.byType(Scrollable).first,
    );
    await Scrollable.ensureVisible(
      tester.element(openRequests),
      alignment: 0.5,
    );
    await tester.pumpAndSettle();
    await tester.tap(openRequests);
    await tester.pumpAndSettle();

    expect(find.byType(TripJoinRequestsScreen), findsOneWidget);
    expect(find.text('Chờ duyệt (3)'), findsOneWidget);
  });
}
