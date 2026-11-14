import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_frontend_v1/app/router/router_names.dart';
import 'package:travel_frontend_v1/features/trips/trip-details/presentation/screen/trip_detail_screen.dart';
import 'package:travel_frontend_v1/features/trips/trip-details/presentation/widgets/trip_detail_pill_button.dart';
import 'package:travel_frontend_v1/features/trips/trip-details/provider/trip_detail_provider.dart';
import 'package:travel_frontend_v1/features/trips/trip-invitation/presentation/screen/trip_invite_friends_screen.dart';
import 'package:travel_frontend_v1/features/trips/trip-invitation/provider/trip_invite_friends_provider.dart';

import '../trip_details/trip_detail_fixture.dart';
import 'fake_trip_invite_friends_datasource.dart';

void main() {
  testWidgets('Mời bạn on the trip detail opens the invite screen', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(360, 780);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

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
              path: 'invite',
              name: RouteNames.tripInviteFriends,
              builder: (context, state) => TripInviteFriendsScreen(
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
          tripInviteFriendsDataSourceProvider.overrideWithValue(
            FakeTripInviteFriendsDataSource(),
          ),
          tripDetailRemoteDataSourceProvider.overrideWithValue(
            FakeTripDetailRemoteDataSource(),
          ),
        ],
        child: MaterialApp.router(routerConfig: router),
      ),
    );
    await tester.pump();
    await tester.pump();

    final invite = find.widgetWithText(TripDetailPillButton, 'Mời bạn');
    await tester.scrollUntilVisible(
      invite,
      200,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.pumpAndSettle();
    await tester.tap(invite);
    await tester.pumpAndSettle();

    expect(find.byType(TripInviteFriendsScreen), findsOneWidget);
    expect(find.text('Mời Bạn Đồng Hành'), findsOneWidget);
    expect(find.text('Minh Anh'), findsOneWidget);
  });
}
