import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:travel_frontend_v1/core/networks/api_exception.dart';
import 'package:travel_frontend_v1/core/providers/core_provider.dart';
import 'package:travel_frontend_v1/features/trips/trip-details/provider/trip_detail_provider.dart';
import 'package:travel_frontend_v1/features/trips/trip-timeline/application/trip_timeline_view.dart';
import 'package:travel_frontend_v1/features/trips/trip-timeline/presentation/screen/trip_timeline_screen.dart';
import 'package:travel_frontend_v1/features/trips/trip-timeline/provider/trip_timeline_provider.dart';

import '../../../core/realtime/fake_trip_socket_channel.dart';
import '../trip_details/trip_detail_fixture.dart';
import 'trip_timeline_fixture.dart';

void main() {
  late FakeTripSocket socket;

  Future<void> pumpScreen(
    WidgetTester tester,
    FakeTripTimelineDataSource dataSource, {
    Size size = const Size(360, 780),
    TripTimelineWallClock wallClock = utcWallClock,
    double textScale = 1,
  }) async {
    // Created inside the test body so its streams run in the fake-async zone.
    socket = FakeTripSocket();
    addTearDown(socket.dispose);
    tester.view.physicalSize = size;
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    tester.platformDispatcher.textScaleFactorTestValue = textScale;
    addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          tripSocketClientProvider.overrideWithValue(socket.client),
          tripTimelineRemoteDataSourceProvider.overrideWithValue(dataSource),
          tripDetailRemoteDataSourceProvider.overrideWithValue(
            FakeTripDetailRemoteDataSource(),
          ),
          tripTimelineClockProvider.overrideWithValue(() => timelineNow),
          tripTimelineWallClockProvider.overrideWithValue(wallClock),
        ],
        child: const MaterialApp(home: TripTimelineScreen(tripId: 'trip-1')),
      ),
    );
    await tester.pump();
    await tester.pump();
  }

  Future<void> scrollTo(WidgetTester tester, Finder finder) =>
      tester.scrollUntilVisible(
        finder,
        200,
        scrollable: find.byType(Scrollable).first,
      );

  Future<void> tapChip(WidgetTester tester, String label) async {
    final chip = find.text(label);
    await tester.ensureVisible(chip);
    await tester.pump();
    await tester.tap(chip);
    await tester.pump();
    await tester.pump();
  }

  Map<String, dynamic> expensePage() => timelinePageJson(
    [
      timelineEventJson(
        id: 'x-1',
        type: 'EXPENSE_CREATED',
        content: 'Đã thêm một chi phí mới',
        metadata: {
          'amount': '1200000',
          'currency': 'VND',
          'description': 'Ăn trưa',
          'splitType': 'EQUAL',
          'splitCount': 4,
        },
      ),
    ],
    counts: const {
      'all': 9,
      'checkin': 2,
      'expense': 2,
      'memory': 1,
      'member': 1,
    },
  );

  testWidgets('renders grouped events of the datamock on a small screen', (
    tester,
  ) async {
    await pumpScreen(
      tester,
      FakeTripTimelineDataSource({null: timelineDatamockPage()}),
      size: const Size(320, 700),
    );

    expect(find.text('Dòng Thời Gian Chuyến Đi'), findsOneWidget);
    expect(find.text('TRIP-VN2025'), findsOneWidget);
    expect(find.text('Hôm nay'), findsOneWidget);
    expect(find.text('Tất cả (9)'), findsOneWidget);
    expect(find.text('1.200.000đ'), findsOneWidget);
    expect(find.text('300.000đ / người'), findsOneWidget);

    for (final text in const [
      'Hôm qua',
      'Tham gia qua mã mời',
      'Khoản chi: Vé máy bay và homestay',
      'Khởi tạo chuyến đi',
      'Đã hiển thị tất cả sự kiện của chuyến đi',
    ]) {
      await scrollTo(tester, find.text(text));
      expect(find.text(text), findsOneWidget);
    }
    expect(tester.takeException(), isNull);
  });

  testWidgets('lays out without overflow at the largest system text size', (
    tester,
  ) async {
    await pumpScreen(
      tester,
      FakeTripTimelineDataSource({null: timelineDatamockPage()}),
      textScale: 2,
    );

    expect(find.text('Dòng Thời Gian Chuyến Đi'), findsOneWidget);
    for (final text in const [
      'Hôm nay',
      '300.000đ / người',
      'Hôm qua',
      'Khởi tạo chuyến đi',
      'Đã hiển thị tất cả sự kiện của chuyến đi',
    ]) {
      await scrollTo(tester, find.text(text));
      expect(find.text(text), findsOneWidget);
    }
    expect(tester.takeException(), isNull);
  });

  testWidgets('shows event times on the clock of the user', (tester) async {
    await pumpScreen(
      tester,
      FakeTripTimelineDataSource({
        null: timelinePageJson([
          timelineEventJson(id: 'e-1', createdAt: '2025-07-21T02:50:00.000Z'),
        ]),
      }),
      wallClock: vietnamWallClock,
    );

    expect(find.text('09:50'), findsOneWidget);
    expect(find.text('02:50'), findsNothing);
  });

  testWidgets('shows live sync and inserts pushed events on top', (
    tester,
  ) async {
    await pumpScreen(
      tester,
      FakeTripTimelineDataSource({null: timelineDatamockPage()}),
    );
    expect(find.text('Đang kết nối đồng bộ…'), findsOneWidget);

    socket.channel
      ..serverConnect()
      ..acceptJoins();
    await tester.pump();
    await tester.pump();
    expect(find.text('Đang đồng bộ trực tiếp'), findsOneWidget);

    socket.channel.serverEmit(
      'trip:timeline',
      timelineEventJson(
        id: 'live-1',
        tripId: 'trip-1',
        type: 'MEMBER_LEFT',
        content: 'Đã rời khỏi chuyến đi',
        createdAt: '2025-07-21T17:00:00.000Z',
      ),
    );
    await tester.pump();
    await tester.pump();

    expect(find.text('RỜI NHÓM'), findsOneWidget);
    expect(find.text('Tất cả (10)'), findsOneWidget);
    expect(find.text('Thành viên (2)'), findsOneWidget);
  });

  testWidgets('a filter chip loads that category from the backend', (
    tester,
  ) async {
    final dataSource = FakeTripTimelineDataSource(
      {null: timelineDatamockPage()},
      categoryPages: {
        'expense': {null: expensePage()},
      },
    );
    await pumpScreen(tester, dataSource);

    await tapChip(tester, 'Chi tiêu (2)');

    expect(dataSource.requests.last, (category: 'expense', cursor: null));
    expect(find.text('KHOẢN CHI MỚI'), findsOneWidget);
    expect(find.text('KỶ NIỆM MỚI'), findsNothing);
    expect(find.text('CHECK-IN'), findsNothing);
    expect(find.text('Chi tiêu (2)'), findsOneWidget);

    const endMessage = 'Đã hiển thị tất cả sự kiện phù hợp';
    await scrollTo(tester, find.text(endMessage));
    expect(find.text(endMessage), findsOneWidget);
    expect(find.text('Đã hiển thị tất cả sự kiện của chuyến đi'), findsNothing);
  });

  testWidgets('a filter picked in the sheet scrolls its chip into view', (
    tester,
  ) async {
    final dataSource = FakeTripTimelineDataSource(
      {null: timelineDatamockPage()},
      categoryPages: {
        'member': {
          null: timelinePageJson(
            [],
            counts: const {
              'all': 9,
              'checkin': 2,
              'expense': 2,
              'memory': 1,
              'member': 1,
            },
          ),
        },
      },
    );
    await pumpScreen(tester, dataSource);
    final chip = find.text('Thành viên (1)', skipOffstage: false);
    expect(tester.getRect(chip).left, greaterThan(360));

    await tester.tap(find.bySemanticsLabel('Bộ lọc sự kiện'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Thành viên').last);
    await tester.pumpAndSettle();

    expect(dataSource.requests.last, (category: 'member', cursor: null));
    final rect = tester.getRect(chip);
    expect(rect.left, greaterThanOrEqualTo(0));
    expect(rect.right, lessThanOrEqualTo(360));
  });

  testWidgets('a failed filter load shows an inline retry', (tester) async {
    final dataSource = FakeTripTimelineDataSource(
      {null: timelineDatamockPage()},
      categoryPages: {
        'expense': {null: const ApiException(message: 'x', statusCode: 503)},
      },
    );
    await pumpScreen(tester, dataSource);

    await tapChip(tester, 'Chi tiêu (2)');

    expect(find.text('Không thể tải sự kiện'), findsOneWidget);
    expect(find.text('Chi tiêu (2)'), findsOneWidget);

    dataSource.pagesByCategory['expense']![null] = expensePage();
    await tester.tap(find.text('Thử lại'));
    await tester.pump();
    await tester.pump();

    expect(find.text('KHOẢN CHI MỚI'), findsOneWidget);
  });

  testWidgets('an empty category offers to show every event', (tester) async {
    final dataSource = FakeTripTimelineDataSource(
      {null: timelineDatamockPage()},
      categoryPages: {
        'member': {null: timelinePageJson([])},
      },
    );
    await pumpScreen(tester, dataSource);

    await tapChip(tester, 'Thành viên (1)');
    expect(find.text('Không có sự kiện phù hợp'), findsOneWidget);

    await tester.tap(find.text('Xem tất cả'));
    await tester.pump();
    await tester.pump();

    expect(find.text('Hôm nay'), findsOneWidget);
  });

  testWidgets('"Xem chi tiết" tells that the detail screen is coming', (
    tester,
  ) async {
    await pumpScreen(
      tester,
      FakeTripTimelineDataSource({null: timelineDatamockPage()}),
    );

    await tester.tap(find.byTooltip('Tùy chọn sự kiện').first);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Xem chi tiết'));
    await tester.pumpAndSettle();

    expect(
      find.text('Tính năng xem chi tiết đang phát triển.'),
      findsOneWidget,
    );
  });

  testWidgets('events without a target have no "…" menu', (tester) async {
    await pumpScreen(
      tester,
      FakeTripTimelineDataSource({
        null: timelinePageJson([
          timelineEventJson(id: 'e-1', type: 'MEMBER_LEFT'),
        ]),
      }),
    );

    expect(find.byTooltip('Tùy chọn sự kiện'), findsNothing);
  });

  testWidgets('shows an empty state for a trip without events', (tester) async {
    await pumpScreen(
      tester,
      FakeTripTimelineDataSource({null: timelinePageJson([])}),
    );

    expect(find.text('Chưa có sự kiện nào'), findsOneWidget);
  });

  testWidgets('shows an error with retry when loading fails', (tester) async {
    final dataSource = FakeTripTimelineDataSource({
      null: const ApiException(message: 'internal stack', statusCode: 500),
    });
    await pumpScreen(tester, dataSource);

    expect(find.text('Không thể tải dòng thời gian'), findsOneWidget);
    expect(find.textContaining('internal stack'), findsNothing);

    dataSource.pages[null] = timelineDatamockPage();
    await tester.tap(find.text('Thử lại'));
    await tester.pump();
    await tester.pump();

    expect(find.text('Hôm nay'), findsOneWidget);
    expect(dataSource.requestedCursors, [null, null]);
  });

  testWidgets('explains when the viewer is not a member', (tester) async {
    await pumpScreen(
      tester,
      FakeTripTimelineDataSource({
        null: const ApiException(message: 'Forbidden', statusCode: 403),
      }),
    );

    expect(find.text('Không thể xem dòng thời gian'), findsOneWidget);
    expect(find.text('Quay lại'), findsOneWidget);
    expect(find.text('Thử lại'), findsNothing);
  });
}
