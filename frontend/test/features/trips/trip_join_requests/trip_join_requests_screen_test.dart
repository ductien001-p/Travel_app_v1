import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_frontend_v1/core/networks/api_exception.dart';
import 'package:travel_frontend_v1/features/trips/trip-details/provider/trip_detail_provider.dart';
import 'package:travel_frontend_v1/features/trips/trip-invitation/data/models/trip_join_request_models.dart';
import 'package:travel_frontend_v1/features/trips/trip-invitation/presentation/screen/trip_join_requests_screen.dart';
import 'package:travel_frontend_v1/features/trips/trip-invitation/provider/trip_join_requests_provider.dart';

import 'trip_join_requests_fixture.dart';

void main() {
  late FakeTripJoinRequestsDataSource dataSource;

  setUp(() => dataSource = FakeTripJoinRequestsDataSource());

  Future<void> pumpScreen(
    WidgetTester tester, {
    Map<String, dynamic>? trip,
    Size size = const Size(390, 844),
    double textScale = 1,
  }) async {
    tester.view.physicalSize = size;
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    tester.platformDispatcher.textScaleFactorTestValue = textScale;
    addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
    final router = GoRouter(
      initialLocation: '/trips/trip-1/join-requests',
      routes: [
        GoRoute(
          path: '/trips/:tripId/join-requests',
          builder: (context, state) =>
              TripJoinRequestsScreen(tripId: state.pathParameters['tripId']!),
        ),
      ],
    );
    addTearDown(router.dispose);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          tripJoinRequestsDataSourceProvider.overrideWithValue(dataSource),
          tripDetailRemoteDataSourceProvider.overrideWithValue(
            CountingTripDetailDataSource(trip ?? joinRequestsTripJson()),
          ),
          tripJoinRequestsClockProvider.overrideWithValue(() => fixtureNow),
        ],
        child: MaterialApp.router(routerConfig: router),
      ),
    );
    await tester.pump();
    await tester.pump();
    await tester.pump();
  }

  Finder inCard(String requestId, Finder matching) =>
      find.descendant(of: find.byKey(ValueKey(requestId)), matching: matching);

  Future<void> scrollTo(WidgetTester tester, Finder finder) =>
      tester.scrollUntilVisible(
        finder,
        200,
        scrollable: find.byType(Scrollable).first,
      );

  Future<void> tap(WidgetTester tester, Finder finder) async {
    await scrollTo(tester, finder);
    await tester.ensureVisible(finder);
    await tester.pump();
    await tester.tap(finder);
    await tester.pump();
    await tester.pump();
  }

  testWidgets('renders the trip and the pending requests on a small screen', (
    tester,
  ) async {
    await pumpScreen(tester, size: const Size(320, 700));

    expect(find.text('Yêu Cầu Tham Gia'), findsOneWidget);
    expect(find.text('Trưởng nhóm • Quyền quản trị'), findsOneWidget);
    expect(find.text('3 mới'), findsOneWidget);
    expect(find.text('Mùa hè rực rỡ xuyên miền Trung 2025'), findsOneWidget);
    expect(find.text('HE2025-VN'), findsOneWidget);
    expect(find.text('Chờ duyệt (3)'), findsOneWidget);
    expect(find.text('Đã duyệt (4)'), findsOneWidget);
    expect(find.byIcon(Icons.qr_code_2_rounded), findsNothing);
    expect(find.byIcon(Icons.tune_rounded), findsNothing);
    expect(find.bySemanticsLabel('Chia sẻ mã mời'), findsOneWidget);

    await scrollTo(tester, find.text('Minh Anh'));
    expect(find.text('96% Hợp gu'), findsOneWidget);
    expect(find.text('15 phút trước'), findsOneWidget);
    for (final text in const ['Thanh Thảo', 'Tự động duyệt bạn bè']) {
      await scrollTo(tester, find.text(text));
      expect(find.text(text), findsOneWidget);
    }
    expect(find.text('Rà soát thành viên'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('lays out without overflow at the largest text size', (
    tester,
  ) async {
    await pumpScreen(
      tester,
      textScale: 2,
      trip: joinRequestsTripJson(maxMembers: 5),
    );

    for (final text in const [
      'Minh Anh',
      'Thanh Thảo',
      'Tự động duyệt bạn bè',
    ]) {
      await scrollTo(tester, find.text(text));
    }
    expect(tester.takeException(), isNull);
  });

  testWidgets('approving a request removes it and updates the counts', (
    tester,
  ) async {
    await pumpScreen(tester);

    await tap(tester, inCard('join-request-minh-anh', find.text('Đồng ý')));

    expect(dataSource.decisions.single.requestId, 'join-request-minh-anh');
    expect(find.text('Đã thêm Minh Anh vào nhóm.'), findsOneWidget);
    expect(
      find.byKey(const ValueKey('join-request-minh-anh'), skipOffstage: false),
      findsNothing,
    );
    expect(find.text('2 mới'), findsOneWidget);
    expect(find.text('Chờ duyệt (2)', skipOffstage: false), findsOneWidget);
    expect(find.text('Đã duyệt (5)', skipOffstage: false), findsOneWidget);
  });

  testWidgets('rejecting asks for confirmation first', (tester) async {
    await pumpScreen(tester);

    await tap(tester, inCard('join-request-dang-khoa', find.text('Từ chối')));
    expect(find.text('Từ chối yêu cầu?'), findsOneWidget);
    await tester.tap(find.text('Hủy'));
    await tester.pumpAndSettle();
    expect(dataSource.decisions, isEmpty);

    await tap(tester, inCard('join-request-dang-khoa', find.text('Từ chối')));
    await tester.tap(find.widgetWithText(FilledButton, 'Từ chối'));
    await tester.pumpAndSettle();

    expect(
      dataSource.decisions.single.decision,
      TripJoinRequestStatus.rejected,
    );
    expect(find.text('Đã từ chối yêu cầu của Đăng Khoa.'), findsOneWidget);
    expect(find.text('2 mới'), findsOneWidget);
    expect(find.text('Đã từ chối (2)', skipOffstage: false), findsOneWidget);
  });

  testWidgets('shows the reviewed requests of another tab', (tester) async {
    await pumpScreen(tester);

    await tap(tester, find.text('Đã duyệt (4)'));

    expect(find.text('Ngọc Hân'), findsOneWidget);
    expect(find.text('Minh Anh'), findsNothing);
    expect(
      inCard('join-request-ngoc-han', find.text('Đã duyệt')),
      findsOneWidget,
    );
    expect(inCard('join-request-ngoc-han', find.text('Đồng ý')), findsNothing);
  });

  testWidgets('warns when only one seat is left', (tester) async {
    await pumpScreen(tester, trip: joinRequestsTripJson(maxMembers: 5));
    expect(
      find.textContaining('Chuyến đi chỉ còn đúng 1 vị trí trống.'),
      findsOneWidget,
    );
  });

  testWidgets('disables approving when the trip is full', (tester) async {
    await pumpScreen(tester, trip: joinRequestsTripJson(maxMembers: 4));

    expect(find.textContaining('Nhóm đã đủ quân số (4/4).'), findsOneWidget);
    await tap(tester, inCard('join-request-minh-anh', find.text('Đồng ý')));

    expect(dataSource.decisions, isEmpty);
  });

  testWidgets('tells members they cannot review requests', (tester) async {
    await pumpScreen(tester, trip: joinRequestsTripJson(role: 'MEMBER'));

    expect(find.text('Không thể duyệt yêu cầu'), findsOneWidget);
    expect(find.text('Chờ duyệt (3)'), findsNothing);
    expect(dataSource.pageRequests, isEmpty);
  });

  testWidgets('shows an error with retry when the requests fail', (
    tester,
  ) async {
    dataSource.listError = const ApiException(message: 'offline');
    await pumpScreen(tester);

    expect(find.text('Không thể tải yêu cầu'), findsOneWidget);
    expect(
      find.text('Không thể kết nối máy chủ. Kiểm tra mạng và thử lại.'),
      findsOneWidget,
    );

    dataSource.listError = null;
    await tap(tester, find.text('Thử lại'));
    await tester.pump();

    expect(find.text('Minh Anh'), findsOneWidget);
  });

  testWidgets('shows an empty state when nothing is pending', (tester) async {
    dataSource.emptyTabs.add(TripJoinRequestStatus.pending);
    await pumpScreen(tester);

    expect(find.text('Không có yêu cầu chờ duyệt'), findsOneWidget);
    expect(find.text('3 mới'), findsNothing);
  });
}
