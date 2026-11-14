import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_frontend_v1/core/networks/api_exception.dart';
import 'package:travel_frontend_v1/features/media/providers/media_providers.dart';
import 'package:travel_frontend_v1/features/trips/trip-details/provider/trip_detail_provider.dart';
import 'package:travel_frontend_v1/features/trips/trip-memories/application/trip_memories_view.dart';
import 'package:travel_frontend_v1/features/trips/trip-memories/presentation/screen/trip_memories_screen.dart';
import 'package:travel_frontend_v1/features/trips/trip-memories/presentation/widgets/trip_memory_photo_tile.dart';
import 'package:travel_frontend_v1/features/trips/trip-memories/provider/trip_memories_provider.dart';

import '../trip_details/trip_detail_fixture.dart';
import 'trip_memories_fixture.dart';

void main() {
  late FakeMediaUploadRepository media;
  late int pickerCalls;

  setUp(() {
    media = FakeMediaUploadRepository();
    pickerCalls = 0;
  });

  Future<void> pumpScreen(
    WidgetTester tester,
    FakeTripMemoriesDataSource dataSource, {
    Size size = const Size(360, 780),
    double textScale = 1,
    Map<String, dynamic>? trip,
  }) async {
    tester.view.physicalSize = size;
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    tester.platformDispatcher.textScaleFactorTestValue = textScale;
    addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
    final router = GoRouter(
      initialLocation: '/trips/trip-1/memories',
      routes: [
        GoRoute(
          path: '/trips/:tripId/memories',
          builder: (context, state) =>
              TripMemoriesScreen(tripId: state.pathParameters['tripId']!),
        ),
      ],
    );
    addTearDown(router.dispose);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          tripMemoriesRemoteDataSourceProvider.overrideWithValue(dataSource),
          mediaUploadRepositoryProvider.overrideWithValue(media),
          tripDetailRemoteDataSourceProvider.overrideWithValue(
            FakeTripDetailRemoteDataSource(trip ?? memoriesTripDetailJson()),
          ),
          tripMemoriesWallClockProvider.overrideWithValue(utcWallClock),
          tripMemoryPhotoPickerProvider.overrideWithValue(({
            int limit = 20,
          }) async {
            pickerCalls++;
            return fakePhotos(2);
          }),
        ],
        child: MaterialApp.router(routerConfig: router),
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

  Future<void> tapText(WidgetTester tester, String label) async {
    final target = find.text(label);
    await tester.ensureVisible(target);
    await tester.pump();
    await tester.tap(target);
    await tester.pump();
    await tester.pump();
  }

  FakeTripMemoriesDataSource datamock() =>
      FakeTripMemoriesDataSource({firstPage: memoriesDatamockPage()});

  testWidgets('renders the album of the datamock on a small screen', (
    tester,
  ) async {
    await pumpScreen(tester, datamock(), size: const Size(320, 700));

    expect(find.text('Kỷ Niệm Chuyến Đi'), findsOneWidget);
    expect(find.text('Kho Kỷ Niệm Chung'), findsOneWidget);
    expect(find.text('Tất cả (10)'), findsOneWidget);
    expect(find.text('Đăng Khoảnh Khắc Mới'), findsOneWidget);

    for (final text in const [
      'Ngày 4: Phố Cổ Hội An',
      'Ngày 1: Đà Nẵng',
      'Đã hiển thị tất cả kỷ niệm của chuyến đi',
    ]) {
      await scrollTo(tester, find.text(text));
      expect(find.text(text), findsOneWidget);
    }
    expect(tester.takeException(), isNull);
  });

  testWidgets('lays out without overflow at the largest system text size', (
    tester,
  ) async {
    await pumpScreen(tester, datamock(), textScale: 2);

    for (final text in const [
      'Ngày 4: Phố Cổ Hội An',
      'Ngày 1: Đà Nẵng',
      'Đã hiển thị tất cả kỷ niệm của chuyến đi',
    ]) {
      await scrollTo(tester, find.text(text));
      expect(find.text(text), findsOneWidget);
    }
    expect(tester.takeException(), isNull);
  });

  testWidgets('a day chip asks the backend for the photos of that day', (
    tester,
  ) async {
    final dataSource = datamock()
      ..pages[(day: 4, uploaderId: null, cursor: null)] = memoriesPageJson([
        memoryJson(id: 'only', createdAt: '2025-07-18T03:00:00.000Z'),
      ]);
    await pumpScreen(tester, dataSource);

    await tapText(tester, 'Ngày 4 - Phố Cổ Hội An (5)');

    expect(dataSource.requests.last, (day: 4, uploaderId: null, cursor: null));
    expect(find.text('Ngày 4: Phố Cổ Hội An'), findsOneWidget);
    expect(find.text('Ngày 1: Đà Nẵng'), findsNothing);
    expect(find.text('Đã hiển thị tất cả ảnh phù hợp'), findsOneWidget);
  });

  testWidgets('a filter the backend rejects offers to show everything', (
    tester,
  ) async {
    final dataSource = datamock()
      ..pages[(
        day: null,
        uploaderId: 'user-trang',
        cursor: null,
      )] = const ApiException(
        message: 'property userId should not exist',
        statusCode: 400,
      );
    await pumpScreen(tester, dataSource);

    await tapText(tester, 'Minh Trang (3)');

    expect(find.text('Không thể lọc kỷ niệm'), findsOneWidget);
    expect(
      find.text('Không áp dụng được bộ lọc này. Hãy xem tất cả kỷ niệm.'),
      findsOneWidget,
    );
    expect(find.textContaining('should not exist'), findsNothing);

    await tapText(tester, 'Xem tất cả');

    expect(find.text('Ngày 4: Phố Cổ Hội An'), findsOneWidget);
  });

  testWidgets('shows an empty album', (tester) async {
    await pumpScreen(
      tester,
      FakeTripMemoriesDataSource({firstPage: memoriesPageJson([])}),
    );

    expect(find.text('Chưa có kỷ niệm nào'), findsOneWidget);
    expect(find.text('Đăng Khoảnh Khắc Mới'), findsOneWidget);
  });

  testWidgets('retries after the album fails to load', (tester) async {
    final dataSource = FakeTripMemoriesDataSource({
      firstPage: const ApiException(message: 'boom', statusCode: 500),
    });
    await pumpScreen(tester, dataSource);

    expect(find.text('Không thể tải album kỷ niệm'), findsOneWidget);
    expect(find.textContaining('boom'), findsNothing);

    dataSource.pages[firstPage] = memoriesDatamockPage();
    await tapText(tester, 'Thử lại');

    expect(find.text('Ngày 4: Phố Cổ Hội An'), findsOneWidget);
  });

  testWidgets('explains when the viewer may not see the album', (tester) async {
    await pumpScreen(
      tester,
      FakeTripMemoriesDataSource({
        firstPage: const ApiException(message: 'Forbidden', statusCode: 403),
      }),
    );

    expect(find.text('Không thể xem album'), findsOneWidget);
    expect(find.text('Quay lại'), findsOneWidget);
    expect(find.text('Thử lại'), findsNothing);
  });

  testWidgets('hides posting from visitors', (tester) async {
    await pumpScreen(
      tester,
      datamock(),
      trip: {
        ...memoriesTripDetailJson(),
        'viewer': {'userId': 'user-visitor', 'role': null},
      },
    );

    expect(find.text('Đăng Khoảnh Khắc Mới'), findsNothing);
    expect(find.text('Của tôi'), findsNothing);
  });

  testWidgets('posts picked photos and reloads the album', (tester) async {
    final dataSource = datamock();
    await pumpScreen(tester, dataSource);

    await tester.tap(find.text('Đăng Khoảnh Khắc Mới'));
    await tester.pump();
    await tester.pump();
    await tester.pump();

    expect(pickerCalls, 1);
    expect(media.uploads.single.fileCount, 2);
    expect(dataSource.created.single.map((m) => m.mediaId), [
      'upload-0',
      'upload-1',
    ]);
    expect(dataSource.requests, [firstPage, firstPage]);
    expect(find.text('Đã thêm 2 ảnh vào album.'), findsOneWidget);
  });

  testWidgets('deletes a photo from the viewer after confirming', (
    tester,
  ) async {
    final dataSource = datamock();
    await pumpScreen(tester, dataSource);

    await tester.tap(find.byType(TripMemoryPhotoTile).first);
    await tester.pumpAndSettle();
    expect(find.text('Đèn lồng phố Hội lung linh'), findsWidgets);

    await tester.tap(find.byIcon(Icons.delete_outline_rounded));
    await tester.pumpAndSettle();
    expect(find.text('Xóa ảnh này?'), findsOneWidget);
    await tester.tap(find.text('Xóa'));
    await tester.pumpAndSettle();

    expect(dataSource.deleted, ['memory-lanterns']);
    expect(find.text('Đã xóa ảnh khỏi album.'), findsOneWidget);
    expect(find.text('Đèn lồng phố Hội lung linh'), findsNothing);
  });
}
