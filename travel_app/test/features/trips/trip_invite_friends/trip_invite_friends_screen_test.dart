import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:travel_frontend_v1/features/trips/trip-details/provider/trip_detail_provider.dart';
import 'package:travel_frontend_v1/features/trips/trip-invitation/presentation/screen/trip_invite_friends_screen.dart';
import 'package:travel_frontend_v1/features/trips/trip-invitation/provider/trip_invite_friends_provider.dart';

import '../trip_details/trip_detail_fixture.dart';
import 'fake_trip_invite_friends_datasource.dart';

void main() {
  testWidgets('owner selects a friend and sends the invitation', (
    tester,
  ) async {
    final dataSource = FakeTripInviteFriendsDataSource();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          tripInviteFriendsDataSourceProvider.overrideWithValue(dataSource),
          tripDetailRemoteDataSourceProvider.overrideWithValue(
            FakeTripDetailRemoteDataSource({
              ...tripDetailJson(),
              'status': 'UPCOMING',
            }),
          ),
        ],
        child: const MaterialApp(
          home: TripInviteFriendsScreen(tripId: 'trip-1'),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Mời Bạn Đồng Hành'), findsOneWidget);
    expect(find.text('Gợi ý cùng gu du lịch'), findsOneWidget);
    expect(find.text('Beach Lover 🏖️ • Hợp 94%'), findsOneWidget);
    expect(find.text('Gần đây'), findsOneWidget);
    expect(
      find.text('Cùng gu (Beach Lover 🏖️)', skipOffstage: false),
      findsOneWidget,
    );
    expect(find.text('Minh Anh'), findsOneWidget);
    expect(find.text('Chờ duyệt'), findsOneWidget);
    expect(find.text('Còn 2 chỗ trống (4/6)'), findsWidgets);

    await tester.scrollUntilVisible(
      find.text('Đức Huy'),
      200,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.pumpAndSettle();
    await tester.tap(find.bySemanticsLabel('Mời Đức Huy'));
    await tester.pumpAndSettle();
    expect(
      find.text('ĐÃ CHỌN ĐỂ MỜI (1)', skipOffstage: false),
      findsOneWidget,
    );

    await tester.tap(find.text('Gửi lời mời tham gia (1)'));
    await tester.pumpAndSettle();

    expect(dataSource.invitedIds, ['user-duc-huy']);
    expect(find.text('Đã gửi 1 lời mời.'), findsOneWidget);
    expect(find.text('ĐÃ CHỌN ĐỂ MỜI (1)', skipOffstage: false), findsNothing);
  });

  testWidgets('a member sees the locked state', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          tripInviteFriendsDataSourceProvider.overrideWithValue(
            FakeTripInviteFriendsDataSource(),
          ),
          tripDetailRemoteDataSourceProvider.overrideWithValue(
            FakeTripDetailRemoteDataSource({
              ...tripDetailJson(),
              'viewer': {'userId': 'user-bao', 'role': 'MEMBER'},
              'inviteCode': null,
            }),
          ),
        ],
        child: const MaterialApp(
          home: TripInviteFriendsScreen(tripId: 'trip-1'),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Chỉ trưởng nhóm mới mời được bạn'), findsOneWidget);
    expect(find.text('Minh Anh'), findsNothing);
  });
}
