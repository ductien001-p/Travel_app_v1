import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:travel_frontend_v1/core/networks/api_exception.dart';
import 'package:travel_frontend_v1/features/trips/trip-details/data/datasources/trip_detail_remote_datasource.dart';
import 'package:travel_frontend_v1/features/trips/trip-details/data/models/trip_detail_models.dart';
import 'package:travel_frontend_v1/features/trips/trip-details/presentation/screen/trip_detail_screen.dart';
import 'package:travel_frontend_v1/features/trips/trip-details/presentation/widgets/trip_detail_pill_button.dart';
import 'package:travel_frontend_v1/features/trips/trip-details/presentation/widgets/trip_detail_skeleton.dart';
import 'package:travel_frontend_v1/features/trips/trip-details/provider/trip_detail_provider.dart';

import 'trip_detail_fixture.dart';

void main() {
  Future<void> pumpScreen(
    WidgetTester tester,
    TripDetailRemoteDataSource dataSource, {
    Size size = const Size(360, 780),
  }) async {
    tester.view.physicalSize = size;
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          tripDetailRemoteDataSourceProvider.overrideWithValue(dataSource),
        ],
        child: const MaterialApp(home: TripDetailScreen(tripId: 'trip-1')),
      ),
    );
  }

  Future<void> scrollTo(WidgetTester tester, Finder finder) =>
      tester.scrollUntilVisible(
        finder,
        200,
        scrollable: find.byType(Scrollable).first,
      );

  testWidgets('renders every section of the trip on a small screen', (
    tester,
  ) async {
    await pumpScreen(
      tester,
      FakeTripDetailRemoteDataSource(),
      size: const Size(320, 700),
    );
    await tester.pump();

    expect(find.byType(TripDetailSkeleton), findsNothing);
    expect(find.text('Xem Lịch Trình Chi Tiết'), findsOneWidget);

    for (final text in const [
      'Thành viên nhóm',
      'TRIP-VN2025',
      'Chặng hành trình & Điểm dừng',
      'Kỷ niệm chuyến đi',
      'Nhận quà',
      'Dòng thời gian sự kiện',
    ]) {
      await scrollTo(tester, find.text(text));
      expect(find.text(text), findsOneWidget);
    }
    expect(find.text('Rời khỏi chuyến đi này'), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets('lets a regular member leave the trip', (tester) async {
    await pumpScreen(
      tester,
      FakeTripDetailRemoteDataSource({
        ...tripDetailJson(),
        'inviteCode': null,
        'viewer': {'userId': 'user-bao', 'role': 'MEMBER'},
      }),
    );
    await tester.pump();

    await scrollTo(tester, find.text('Rời khỏi chuyến đi này'));
    expect(find.text('Rời khỏi chuyến đi này'), findsOneWidget);
  });

  group('"Xem ảnh" of a member', () {
    /// Everyone has photos; Alex is the owner, Trang an admin who spent money.
    Map<String, dynamic> tripWithPhotos({required String viewerId}) {
      final json = tripDetailJson();
      return {
        ...json,
        'viewer': {
          'userId': viewerId,
          'role': viewerId == 'user-alex' ? 'OWNER' : 'MEMBER',
        },
        'members': [
          for (final member in json['members'] as List)
            {...member as Map<String, dynamic>, 'memoryCount': 2},
        ],
      };
    }

    Future<void> revealMembers(WidgetTester tester) async {
      await scrollTo(tester, find.text('Lan Phương'));
      await tester.pump();
    }

    testWidgets('sits beside the actions of the owner on a small screen', (
      tester,
    ) async {
      await pumpScreen(
        tester,
        FakeTripDetailRemoteDataSource(tripWithPhotos(viewerId: 'user-alex')),
        size: const Size(320, 700),
      );
      await tester.pump();
      await revealMembers(tester);

      for (final name in const [
        'Alex Nguyễn',
        'Minh Trang',
        'Quốc Bảo',
        'Lan Phương',
      ]) {
        expect(find.byTooltip('Xem ảnh của $name'), findsOneWidget);
      }
      expect(find.byTooltip('Mời Quốc Bảo ra khỏi nhóm'), findsOneWidget);
      expect(
        find.byTooltip('Chuyển quyền quản trị cho Minh Trang'),
        findsOneWidget,
      );
      expect(find.byIcon(Icons.verified_user_outlined), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('sits beside the amount a member spent', (tester) async {
      await pumpScreen(
        tester,
        FakeTripDetailRemoteDataSource(tripWithPhotos(viewerId: 'user-bao')),
        size: const Size(320, 700),
      );
      await tester.pump();
      await revealMembers(tester);

      expect(find.byTooltip('Xem ảnh của Minh Trang'), findsOneWidget);
      expect(find.text('Đã chi'), findsWidgets);
      expect(find.byTooltip('Mời Quốc Bảo ra khỏi nhóm'), findsNothing);
      expect(tester.takeException(), isNull);
    });

    testWidgets('is hidden for a member without photos', (tester) async {
      await pumpScreen(tester, FakeTripDetailRemoteDataSource());
      await tester.pump();
      await revealMembers(tester);

      expect(find.byTooltip('Xem ảnh của Minh Trang'), findsNothing);
      expect(find.byTooltip('Xem ảnh của Quốc Bảo'), findsOneWidget);
    });
  });

  group('member actions', () {
    final inviteButton = find.widgetWithText(TripDetailPillButton, 'Mời bạn');
    final joinRequestsButton = find.widgetWithText(
      TripDetailPillButton,
      'Yêu cầu',
    );

    Future<void> pumpAs(
      WidgetTester tester,
      String role, {
      Size size = const Size(360, 780),
    }) async {
      await pumpScreen(
        tester,
        FakeTripDetailRemoteDataSource({
          ...tripDetailJson(),
          'viewer': {'userId': 'user-alex', 'role': role},
        }),
        size: size,
      );
      await tester.pump();
      await scrollTo(tester, find.text('Thành viên nhóm'));
    }

    testWidgets('the owner sees invite and join requests side by side', (
      tester,
    ) async {
      await pumpAs(tester, 'OWNER', size: const Size(320, 700));

      expect(inviteButton, findsOneWidget);
      expect(joinRequestsButton, findsOneWidget);
      expect(
        tester.getCenter(joinRequestsButton).dy,
        tester.getCenter(inviteButton).dy,
      );
      expect(tester.takeException(), isNull);
    });

    testWidgets('an admin only sees the join requests', (tester) async {
      await pumpAs(tester, 'ADMIN');

      expect(inviteButton, findsNothing);
      expect(joinRequestsButton, findsOneWidget);
    });

    testWidgets('a member sees neither', (tester) async {
      await pumpAs(tester, 'MEMBER');

      expect(inviteButton, findsNothing);
      expect(joinRequestsButton, findsNothing);
    });
  });

  testWidgets('hides member-only sections from a visitor', (tester) async {
    await pumpScreen(
      tester,
      FakeTripDetailRemoteDataSource(visitorTripDetailJson()),
    );
    await tester.pump();

    expect(find.text('—'), findsOneWidget);
    await scrollTo(tester, find.text('Chặng hành trình & Điểm dừng'));
    await tester.drag(find.byType(Scrollable).first, const Offset(0, -2000));
    await tester.pump();

    for (final text in const [
      'TRIP-VN2025',
      'Kỷ niệm chuyến đi',
      'Nhận quà',
      'Dòng thời gian sự kiện',
      'Rời khỏi chuyến đi này',
    ]) {
      expect(find.text(text), findsNothing);
    }
    expect(tester.takeException(), isNull);
  });

  testWidgets('shows an error with retry when loading fails', (tester) async {
    await pumpScreen(tester, _FailingDataSource());
    await tester.pump();

    expect(find.text('Không thể tải chuyến đi'), findsOneWidget);
    expect(
      find.text('Chuyến đi không tồn tại hoặc đã bị xóa.'),
      findsOneWidget,
    );
    expect(find.text('Thử lại'), findsOneWidget);
  });
}

class _FailingDataSource extends TripDetailRemoteDataSource {
  _FailingDataSource() : super(apiClient: unusedApiClient());

  @override
  Future<TripDetailOverview> getTripDetail(String tripId) async =>
      throw const ApiException(message: 'Not found', statusCode: 404);
}
