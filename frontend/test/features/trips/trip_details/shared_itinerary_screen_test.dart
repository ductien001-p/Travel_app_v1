import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_frontend_v1/app/router/router_names.dart';
import 'package:travel_frontend_v1/core/networks/api_exception.dart';
import 'package:travel_frontend_v1/features/trips/trip-details/application/trip_itinerary_controller.dart';
import 'package:travel_frontend_v1/features/trips/trip-details/presentation/screen/shared_itinerary_screen.dart';
import 'package:travel_frontend_v1/features/trips/trip-details/provider/trip_detail_provider.dart';

import 'trip_itinerary_fixture.dart';

void main() {
  final token = 'a' * 43;

  Future<void> pumpScreen(
    WidgetTester tester,
    FakeItineraryBackend backend, {
    String? linkToken,
  }) async {
    tester.view.physicalSize = const Size(360, 780);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          tripDetailRemoteDataSourceProvider.overrideWithValue(
            FakeItineraryTripDetailDataSource(backend),
          ),
          tripItineraryClockProvider.overrideWithValue(() => itineraryNow),
        ],
        child: MaterialApp.router(
          routerConfig: GoRouter(
            initialLocation: '/shared/${linkToken ?? token}',
            routes: [
              GoRoute(
                path: '/shared/:token',
                name: RouteNames.sharedItinerary,
                builder: (context, state) => SharedItineraryScreen(
                  token: state.pathParameters['token']!,
                ),
              ),
              GoRoute(
                path: '/home',
                name: RouteNames.home,
                builder: (context, state) => const Text('home'),
              ),
              GoRoute(
                path: '/trips/:tripId/itinerary',
                name: RouteNames.tripItinerary,
                builder: (context, state) =>
                    Text('itinerary:${state.pathParameters['tripId']}'),
              ),
            ],
          ),
        ),
      ),
    );
    await tester.pump();
    await tester.pump();
  }

  testWidgets('shows the itinerary read-only for a visitor', (tester) async {
    final backend = FakeItineraryBackend();
    await pumpScreen(tester, backend);

    expect(backend.sharedTokens, [token]);
    expect(find.text('Lịch trình được chia sẻ'), findsOneWidget);
    expect(find.text('Chỉ xem'), findsOneWidget);
    expect(find.text('Mùa hè rực rỡ xuyên miền Trung 2025'), findsOneWidget);
    expect(find.text('Đà Nẵng'), findsOneWidget);
    expect(find.text('Check-in ngay tại đây'), findsNothing);
    expect(find.byTooltip('Thao tác hoạt động'), findsNothing);
    expect(find.text('Sắp xếp lại'), findsNothing);
    expect(find.textContaining('Thêm hoạt động'), findsNothing);
    expect(find.text('Mở chuyến đi'), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets('a member can jump into the trip', (tester) async {
    final backend = FakeItineraryBackend()..sharedViewerIsMember = true;
    await pumpScreen(tester, backend);

    await tester.tap(find.text('Mở chuyến đi'));
    await tester.pumpAndSettle();

    expect(find.text('itinerary:trip-1'), findsOneWidget);
  });

  testWidgets('an expired or revoked link shows that it is gone', (
    tester,
  ) async {
    final backend = FakeItineraryBackend()
      ..sharedItineraryError = const ApiException(
        message: 'Share link not found or expired',
        statusCode: 404,
      );
    await pumpScreen(tester, backend);

    expect(find.text('Link không còn hiệu lực'), findsOneWidget);
    await tester.tap(find.text('Về trang chủ'));
    await tester.pumpAndSettle();
    expect(find.text('home'), findsOneWidget);
  });

  testWidgets('a malformed token never reaches the server', (tester) async {
    final backend = FakeItineraryBackend();
    await pumpScreen(tester, backend, linkToken: 'short');

    expect(find.text('Link không còn hiệu lực'), findsOneWidget);
    expect(backend.sharedTokens, isEmpty);
  });

  testWidgets('a transient failure offers a retry', (tester) async {
    final backend = FakeItineraryBackend()
      ..sharedItineraryError = const ApiException(
        message: 'down',
        statusCode: 503,
      );
    await pumpScreen(tester, backend);

    expect(find.text('Không thể tải lịch trình'), findsOneWidget);

    backend.sharedItineraryError = null;
    await tester.tap(find.text('Thử lại'));
    await tester.pump();
    await tester.pump();

    expect(find.text('Chỉ xem'), findsOneWidget);
  });
}
