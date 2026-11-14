import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:travel_frontend_v1/core/networks/api_exception.dart';
import 'package:travel_frontend_v1/features/trips/application/device_location_controller.dart';
import 'package:travel_frontend_v1/features/trips/trip-details/application/trip_itinerary_controller.dart';
import 'package:travel_frontend_v1/features/trips/trip-details/application/trip_itinerary_map.dart';
import 'package:travel_frontend_v1/features/trips/trip-details/presentation/screen/trip_itinerary_map_screen.dart';
import 'package:travel_frontend_v1/features/trips/trip-details/presentation/widgets/itinerary_map/trip_itinerary_map_stop_card.dart';
import 'package:travel_frontend_v1/features/trips/trip-details/provider/trip_detail_provider.dart';
import 'package:travel_frontend_v1/features/trips/trip-itineraies/provider/trip_itinerary_provider.dart';

import 'trip_itinerary_fixture.dart';

void main() {
  Future<void> pumpScreen(
    WidgetTester tester,
    FakeItineraryBackend backend, {
    String? dayId,
  }) async {
    tester.view.physicalSize = const Size(360, 780);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          tripItineraryRemoteDataSourceProvider.overrideWithValue(
            FakeTripItineraryRemoteDataSource(backend),
          ),
          tripDetailRemoteDataSourceProvider.overrideWithValue(
            FakeItineraryTripDetailDataSource(backend),
          ),
          deviceLocationServiceProvider.overrideWithValue(
            FakeDeviceLocationService(),
          ),
          tripItineraryClockProvider.overrideWithValue(() => itineraryNow),
          tripMapsSupportedProvider.overrideWithValue(false),
        ],
        child: MaterialApp(
          home: TripItineraryMapScreen(tripId: 'trip-1', initialDayId: dayId),
        ),
      ),
    );
    await tester.pump();
    await tester.pump();
  }

  testWidgets('shows the road summary and the stops of today', (tester) async {
    final backend = FakeItineraryBackend();
    await pumpScreen(tester, backend);

    expect(find.text('Bản đồ lộ trình'), findsOneWidget);
    expect(
      find.text('Ngày 2 · Đà Nẵng · Tổng 21 km · 54 phút'),
      findsOneWidget,
    );
    expect(find.byType(TripItineraryMapStopCard), findsWidgets);
    expect(find.text('Đến điểm tiếp: 4,2 km · 12 phút'), findsOneWidget);
    expect(backend.dayRouteRequests, ['day-2']);
    expect(tester.takeException(), isNull);
  });

  testWidgets('opens the requested day and switches days', (tester) async {
    final backend = FakeItineraryBackend();
    await pumpScreen(tester, backend, dayId: 'day-1');

    expect(find.textContaining('Ngày 1 · Đà Nẵng'), findsOneWidget);

    await tester.tap(find.text('Ngày 2'));
    await tester.pump();
    await tester.pump();

    expect(find.textContaining('Ngày 2 · Đà Nẵng'), findsOneWidget);
    expect(backend.dayRouteRequests, ['day-1', 'day-2']);
  });

  testWidgets('a failed route falls back to estimates with retry', (
    tester,
  ) async {
    final backend = FakeItineraryBackend()
      ..dayRouteError = const ApiException(message: 'boom', statusCode: 503);
    await pumpScreen(tester, backend);

    expect(find.textContaining('(ước tính)'), findsOneWidget);
    expect(find.textContaining('Chưa tải được đường đi'), findsOneWidget);
    expect(find.textContaining('boom'), findsNothing);

    backend.dayRouteError = null;
    await tester.tap(find.text('Thử lại'));
    await tester.pump();
    await tester.pump();

    expect(find.textContaining('Chưa tải được đường đi'), findsNothing);
    expect(find.textContaining('Tổng 21 km · 54 phút'), findsOneWidget);
  });

  testWidgets('shows the itinerary error with retry', (tester) async {
    final backend = FakeItineraryBackend()
      ..itineraryError = const ApiException(message: 'down', statusCode: 500);
    await pumpScreen(tester, backend);

    expect(find.text('Không thể tải lịch trình'), findsOneWidget);

    backend.itineraryError = null;
    await tester.tap(find.text('Thử lại'));
    await tester.pump();
    await tester.pump();

    expect(find.text('Bản đồ lộ trình'), findsOneWidget);
    expect(find.byType(TripItineraryMapStopCard), findsWidgets);
  });
}
