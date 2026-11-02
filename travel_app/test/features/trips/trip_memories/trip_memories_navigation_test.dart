import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_frontend_v1/app/router/router_names.dart';
import 'package:travel_frontend_v1/features/media/providers/media_providers.dart';
import 'package:travel_frontend_v1/features/trips/trip-details/presentation/screen/trip_detail_screen.dart';
import 'package:travel_frontend_v1/features/trips/trip-details/provider/trip_detail_provider.dart';
import 'package:travel_frontend_v1/features/trips/trip-memories/application/trip_memories_view.dart';
import 'package:travel_frontend_v1/features/trips/trip-memories/presentation/screen/trip_memories_screen.dart';
import 'package:travel_frontend_v1/features/trips/trip-memories/provider/trip_memories_provider.dart';

import '../trip_details/trip_detail_fixture.dart';
import 'trip_memories_fixture.dart';

void main() {
  late FakeTripMemoriesDataSource memories;
  late int pickerCalls;

  setUp(() {
    memories = FakeTripMemoriesDataSource({firstPage: memoriesDatamockPage()});
    pickerCalls = 0;
  });

  /// The album trip with the photo previews of `tripDetailJson()`.
  Map<String, dynamic> tripWithPreviews({String status = 'ONGOING'}) => {
    ...memoriesTripDetailJson(status: status),
    'memories': tripDetailJson()['memories'],
  };

  Future<void> pumpApp(
    WidgetTester tester, {
    String initialLocation = '/trips/trip-1',
    Map<String, dynamic>? trip,
  }) async {
    tester.view.physicalSize = const Size(360, 780);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    final router = GoRouter(
      initialLocation: initialLocation,
      routes: [
        GoRoute(
          path: '/trips/:tripId',
          name: RouteNames.tripDetail,
          builder: (context, state) =>
              TripDetailScreen(tripId: state.pathParameters['tripId']!),
          routes: [
            GoRoute(
              path: 'memories',
              name: RouteNames.tripMemories,
              builder: (context, state) => TripMemoriesScreen(
                tripId: state.pathParameters['tripId']!,
                startPosting: TripMemoriesScreen.startsPosting(
                  state.uri.queryParameters,
                ),
                initialUploaderId: TripMemoriesScreen.initialUploaderOf(
                  state.uri.queryParameters,
                ),
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
          tripDetailRemoteDataSourceProvider.overrideWithValue(
            FakeTripDetailRemoteDataSource(trip ?? tripWithPreviews()),
          ),
          tripMemoriesRemoteDataSourceProvider.overrideWithValue(memories),
          mediaUploadRepositoryProvider.overrideWithValue(
            FakeMediaUploadRepository(),
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

  /// Centers [finder] in the trip detail, clear of its top and bottom bars.
  Future<void> revealInTripDetail(WidgetTester tester, Finder finder) async {
    final list = find.byType(Scrollable).first;
    await tester.scrollUntilVisible(finder, 200, scrollable: list);
    await Scrollable.ensureVisible(tester.element(finder), alignment: 0.5);
    await tester.pumpAndSettle();
  }

  testWidgets('"Tất cả" in the trip detail opens the album', (tester) async {
    await pumpApp(tester);

    final seeAll = find.text('Tất cả');
    await revealInTripDetail(tester, seeAll);
    await tester.tap(seeAll);
    await tester.pumpAndSettle();

    expect(find.byType(TripMemoriesScreen), findsOneWidget);
    expect(find.text('Kỷ Niệm Chuyến Đi'), findsOneWidget);
    expect(memories.requests, [firstPage]);
    expect(pickerCalls, 0);
  });

  testWidgets('a photo preview in the trip detail opens the album', (
    tester,
  ) async {
    await pumpApp(tester);

    final preview = find.bySemanticsLabel('Đỉnh Bàn Cờ');
    await revealInTripDetail(tester, preview);
    await tester.tap(preview);
    await tester.pumpAndSettle();

    expect(find.byType(TripMemoriesScreen), findsOneWidget);
    expect(pickerCalls, 0);
  });

  testWidgets('"Đăng ảnh mới" opens the album and posts picked photos', (
    tester,
  ) async {
    await pumpApp(tester);

    final addPhoto = find.text('Đăng ảnh mới');
    await revealInTripDetail(tester, addPhoto);
    await tester.tap(addPhoto);
    await tester.pumpAndSettle();

    expect(find.byType(TripMemoriesScreen), findsOneWidget);
    expect(pickerCalls, 1);
    expect(memories.created.single, hasLength(2));
    expect(find.text('Đã thêm 2 ảnh vào album.'), findsOneWidget);
  });

  testWidgets('"Xem ảnh" of a member opens the album filtered to them', (
    tester,
  ) async {
    const byBao = (day: null, uploaderId: 'user-bao', cursor: null);
    memories.pages[byBao] = memoriesPageJson([
      memoryJson(id: 'bao-1', userId: 'user-bao', caption: 'Ảnh của Bảo'),
    ]);
    await pumpApp(
      tester,
      trip: {
        ...tripWithPreviews(),
        'viewer': {'userId': 'user-phuong', 'role': 'MEMBER'},
      },
    );

    final viewPhotos = find.byTooltip('Xem ảnh của Quốc Bảo');
    await revealInTripDetail(tester, viewPhotos);
    await tester.tap(viewPhotos);
    await tester.pumpAndSettle();

    expect(find.byType(TripMemoriesScreen), findsOneWidget);
    expect(memories.requests, [byBao]);
    expect(find.text('Đã hiển thị tất cả ảnh phù hợp'), findsOneWidget);

    await tester.tap(find.text('Tất cả thành viên'));
    await tester.pumpAndSettle();

    expect(memories.requests.last, firstPage);
  });

  testWidgets('an empty photographer in the link shows the whole album', (
    tester,
  ) async {
    await pumpApp(tester, initialLocation: '/trips/trip-1/memories?userId=');
    await tester.pumpAndSettle();

    expect(memories.requests, [firstPage]);
  });

  testWidgets('the post link does not open the picker when posting is closed', (
    tester,
  ) async {
    await pumpApp(
      tester,
      initialLocation: '/trips/trip-1/memories?post=1',
      trip: tripWithPreviews(status: 'CANCELLED'),
    );
    await tester.pumpAndSettle();

    expect(find.byType(TripMemoriesScreen), findsOneWidget);
    expect(find.text('Đăng Khoảnh Khắc Mới'), findsNothing);
    expect(pickerCalls, 0);
  });
}
