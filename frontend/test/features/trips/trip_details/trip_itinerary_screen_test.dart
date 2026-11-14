import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_frontend_v1/app/router/router_names.dart';
import 'package:travel_frontend_v1/core/networks/api_exception.dart';
import 'package:travel_frontend_v1/features/trips/application/device_location_controller.dart';
import 'package:travel_frontend_v1/features/trips/trip-details/application/trip_itinerary_controller.dart';
import 'package:travel_frontend_v1/features/trips/trip-details/application/trip_itinerary_share_controller.dart';
import 'package:travel_frontend_v1/features/trips/trip-details/presentation/screen/trip_itinerary_screen.dart';
import 'package:travel_frontend_v1/features/trips/trip-details/provider/trip_detail_provider.dart';
import 'package:travel_frontend_v1/features/trips/trip-itineraies/provider/trip_itinerary_provider.dart';

import 'trip_detail_fixture.dart';
import 'trip_itinerary_fixture.dart';

void main() {
  late RecordingShareSheet shareSheet;

  Future<void> pumpScreen(
    WidgetTester tester,
    FakeItineraryBackend backend, {
    Size size = const Size(360, 780),
    Map<String, dynamic>? tripJson,
  }) async {
    shareSheet = RecordingShareSheet();
    tester.view.physicalSize = size;
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          tripItineraryRemoteDataSourceProvider.overrideWithValue(
            FakeTripItineraryRemoteDataSource(backend),
          ),
          tripDetailRemoteDataSourceProvider.overrideWithValue(
            FakeItineraryTripDetailDataSource(backend, tripJson),
          ),
          deviceLocationServiceProvider.overrideWithValue(
            FakeDeviceLocationService(),
          ),
          tripItineraryClockProvider.overrideWithValue(() => itineraryNow),
          tripShareSheetProvider.overrideWithValue(shareSheet),
        ],
        child: MaterialApp.router(
          routerConfig: GoRouter(
            initialLocation: '/trips/trip-1/itinerary',
            routes: [
              GoRoute(
                path: '/trips/:tripId/itinerary',
                name: RouteNames.tripItinerary,
                builder: (context, state) => TripItineraryScreen(
                  tripId: state.pathParameters['tripId']!,
                ),
                routes: [
                  GoRoute(
                    path: 'map',
                    name: RouteNames.tripItineraryMap,
                    builder: (context, state) => Scaffold(
                      body: Text('map:${state.uri.queryParameters['dayId']}'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
    await tester.pump();
    await tester.pump();
  }

  Finder scrollable() => find.byType(Scrollable).first;

  Future<void> scrollTo(WidgetTester tester, Finder finder) =>
      tester.scrollUntilVisible(finder, 200, scrollable: scrollable());

  testWidgets('renders today on a small screen without overflow', (
    tester,
  ) async {
    await pumpScreen(
      tester,
      FakeItineraryBackend(),
      size: const Size(320, 700),
    );

    expect(find.text('Lịch trình chuyến đi'), findsOneWidget);
    expect(find.text('Mùa hè rực rỡ xuyên miền Trung 2025'), findsOneWidget);
    expect(find.text('Đà Nẵng'), findsOneWidget);
    expect(find.text('Hội An'), findsOneWidget);
    expect(find.text('Hôm nay'), findsOneWidget);
    expect(find.text('Xong'), findsOneWidget);
    expect(find.text('Tiến độ Ngày 2'), findsOneWidget);
    expect(find.text('Hoàn thành 2/4 hoạt động dự kiến'), findsOneWidget);
    expect(find.text('50%'), findsOneWidget);

    for (final text in const [
      'Đón bình minh & Tắm biển Mỹ Khê',
      'Tiếp theo',
      'Check-in ngay tại đây',
      'Ngắm Cầu Rồng phun lửa & Du thuyền sông Hàn',
      'Thêm hoạt động vào Ngày 2',
      'Tối ưu lộ trình di chuyển',
    ]) {
      await scrollTo(tester, find.text(text));
      expect(find.text(text), findsOneWidget);
    }
    expect(find.text('Đã check-in'), findsNWidgets(2));
    expect(find.text('Xem tổng quan chuyến đi'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('route card and progress card show the road route', (
    tester,
  ) async {
    final backend = FakeItineraryBackend();
    await pumpScreen(tester, backend);

    expect(find.text('Di chuyển: 21 km · 54 phút'), findsOneWidget);
    await scrollTo(tester, find.text('Tổng 21 km · 54 phút'));
    expect(backend.dayRouteRequests, ['day-2']);

    final fullscreen = find.text('Mở toàn màn hình');
    await scrollTo(tester, fullscreen);
    await tester.drag(scrollable(), const Offset(0, -200));
    await tester.pumpAndSettle();
    await tester.tap(fullscreen);
    await tester.pumpAndSettle();
    expect(find.text('map:day-2'), findsOneWidget);
  });

  testWidgets('map and explore buttons open the map of the day', (
    tester,
  ) async {
    await pumpScreen(tester, FakeItineraryBackend());

    await tester.tap(find.bySemanticsLabel('Xem bản đồ'));
    await tester.pumpAndSettle();
    expect(find.text('map:day-2'), findsOneWidget);

    GoRouter.of(tester.element(find.text('map:day-2'))).pop();
    await tester.pumpAndSettle();
    await tester.tap(find.bySemanticsLabel('Bản đồ tuyến đường'));
    await tester.pumpAndSettle();
    expect(find.text('map:day-2'), findsOneWidget);
  });

  testWidgets('checking in moves the next activity forward', (tester) async {
    final backend = FakeItineraryBackend();
    await pumpScreen(tester, backend);

    final checkinButton = find.text('Check-in ngay tại đây');
    await tester.ensureVisible(checkinButton);
    await tester.pump();
    await tester.tap(checkinButton);
    await tester.pump();
    await tester.pump();
    await tester.pump();

    expect(backend.checkinRequests.single.$1, 'activity-linh-ung');
    expect(
      find.text('Check-in thành công: Bán đảo Sơn Trà & Viếng Chùa Linh Ứng'),
      findsOneWidget,
    );
    await tester.drag(scrollable(), const Offset(0, 3000));
    await tester.pump();
    expect(find.text('75%'), findsOneWidget);
    expect(find.text('Hoàn thành 3/4 hoạt động dự kiến'), findsOneWidget);
  });

  testWidgets('editing an activity saves notes and shows them', (tester) async {
    final backend = FakeItineraryBackend();
    await pumpScreen(tester, backend);

    await tester.tap(find.byTooltip('Thao tác hoạt động').first);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Sửa hoạt động'));
    await tester.pumpAndSettle();

    expect(find.text('Giờ bắt đầu: 08:30'), findsOneWidget);
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Ghi chú'),
      'Mang kem chống nắng',
    );
    await tester.tap(find.text('Lưu thay đổi'));
    await tester.pumpAndSettle();

    final (activityId, body) = backend.updateRequests.single;
    expect(activityId, 'activity-my-khe');
    expect(body, {'notes': 'Mang kem chống nắng'});
    expect(find.text('Đã cập nhật hoạt động'), findsOneWidget);
    expect(find.text('Mang kem chống nắng'), findsOneWidget);
  });

  testWidgets('a member shares a fresh link directly', (tester) async {
    final backend = FakeItineraryBackend();
    await pumpScreen(
      tester,
      backend,
      tripJson: {
        ...tripDetailJson(),
        'viewer': {'userId': 'user-bao', 'role': 'MEMBER'},
      },
    );

    await tester.tap(find.bySemanticsLabel('Chia sẻ lịch trình'));
    await tester.pumpAndSettle();

    expect(backend.shareLinkRequests, 1);
    expect(
      shareSheet.shared.single.subject,
      'Mùa hè rực rỡ xuyên miền Trung 2025',
    );
    expect(
      shareSheet.shared.single.text,
      'Mùa hè rực rỡ xuyên miền Trung 2025 (15 - 20/07)\n'
      'Xem lịch trình chuyến đi: https://share.travel.test/s/${'a' * 43}',
    );
    expect(find.text('Thu hồi các link đã chia sẻ'), findsNothing);
  });

  testWidgets('an owner can revoke links after confirming', (tester) async {
    final backend = FakeItineraryBackend();
    await pumpScreen(tester, backend);

    await tester.tap(find.bySemanticsLabel('Chia sẻ lịch trình'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Thu hồi các link đã chia sẻ'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Thu hồi'));
    await tester.pumpAndSettle();

    expect(find.text('Đã thu hồi 2 link chia sẻ'), findsOneWidget);
    expect(backend.revokableLinks, 0);
    expect(shareSheet.shared, isEmpty);
  });

  testWidgets('a share failure shows a safe message', (tester) async {
    final backend = FakeItineraryBackend()
      ..shareError = const ApiException(
        message: 'Too many share links',
        statusCode: 429,
      );
    await pumpScreen(tester, backend);

    await tester.tap(find.bySemanticsLabel('Chia sẻ lịch trình'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Chia sẻ link lịch trình'));
    await tester.pumpAndSettle();

    expect(
      find.text('Bạn đã tạo quá nhiều link. Vui lòng thử lại sau.'),
      findsOneWidget,
    );
    expect(find.textContaining('Too many'), findsNothing);
  });

  testWidgets('switching destination shows its own days', (tester) async {
    await pumpScreen(tester, FakeItineraryBackend());

    await tester.tap(find.text('Hội An'));
    await tester.pump();

    expect(find.text('Tiến độ Ngày 5'), findsOneWidget);
    expect(find.text('Dạo phố cổ & Thả đèn hoa đăng'), findsOneWidget);
    expect(find.text('Check-in ngay tại đây'), findsNothing);
  });

  testWidgets('a failed check-in read shows the error with retry', (
    tester,
  ) async {
    final backend = FakeItineraryBackend(
      viewerCheckinsError: const ApiException(message: 'Boom', statusCode: 500),
    );
    await pumpScreen(tester, backend);

    expect(find.text('Không thể tải lịch trình'), findsOneWidget);

    backend.viewerCheckinsError = null;
    await tester.tap(find.text('Thử lại'));
    await tester.pump();
    await tester.pump();

    expect(find.text('Hoàn thành 2/4 hoạt động dự kiến'), findsOneWidget);
  });

  testWidgets('shows an empty state for an itinerary without destinations', (
    tester,
  ) async {
    await pumpScreen(
      tester,
      FakeItineraryBackend(
        itineraryEnvelope: {
          'data': <Object>[],
          'permissions': {'canManageItinerary': true},
        },
      ),
    );

    expect(find.text('Chưa có lịch trình'), findsOneWidget);
    expect(find.text('Lập lịch trình'), findsOneWidget);
  });

  testWidgets('shows an error with retry and recovers', (tester) async {
    final backend = FakeItineraryBackend(
      itineraryError: const ApiException(message: 'Forbidden', statusCode: 403),
    );
    await pumpScreen(tester, backend);

    expect(find.text('Không thể tải lịch trình'), findsOneWidget);
    expect(find.text('Bạn không có quyền xem chuyến đi này.'), findsOneWidget);

    backend.itineraryError = null;
    await tester.tap(find.text('Thử lại'));
    await tester.pump();
    await tester.pump();

    expect(find.text('Tiến độ Ngày 2'), findsOneWidget);
  });
}
