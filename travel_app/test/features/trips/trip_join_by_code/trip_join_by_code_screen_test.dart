import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:travel_frontend_v1/core/widget/app_button.dart';
import 'package:travel_frontend_v1/features/trips/trip-invitation/data/datamock/trip_join_by_code_datamock.dart';
import 'package:travel_frontend_v1/features/trips/trip-invitation/presentation/screen/trip_join_by_code_screen.dart';
import 'package:travel_frontend_v1/features/trips/trip-invitation/provider/trip_join_requests_provider.dart';

import '../trip_join_requests/in_memory_trip_join_requests_datasource.dart';

void main() {
  Future<void> pumpScreen(WidgetTester tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          tripJoinRequestsDataSourceProvider.overrideWithValue(
            InMemoryTripJoinRequestsDataSource(
              now: () => DateTime.utc(2025, 7, 10, 8),
            ),
          ),
        ],
        child: const MaterialApp(home: TripJoinByCodeScreen()),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('renders Stitch join-by-code chrome', (tester) async {
    await pumpScreen(tester);

    expect(find.text('Tham Gia Chuyến Đi'), findsOneWidget);
    expect(find.text('Nhập Mã Mời Chuyến Đi'), findsOneWidget);
    expect(tester.takeException(), isNull);
    expect(find.byType(AppButton), findsNWidgets(2));

    final buttons = tester
        .widgetList<AppButton>(find.byType(AppButton))
        .toList();
    expect(buttons.first.label, contains('Gửi Yêu Cầu'));
    expect(buttons.last.label, contains('Quét Mã QR'));
  });

  testWidgets('pasting the demo code shows the trip preview', (tester) async {
    await pumpScreen(tester);

    final slots = find.descendant(
      of: find.byType(TripJoinByCodeScreen),
      matching: find.byType(TextField),
    );
    expect(slots, findsWidgets);

    await tester.enterText(slots.first, tripJoinByCodeDemoInviteCode);
    await tester.pumpAndSettle();

    expect(find.text('Mã chuyến đi hợp lệ'), findsOneWidget);
    expect(find.text(tripJoinByCodeDemoInviteCode), findsOneWidget);
    expect(find.textContaining('Mùa Hè Rực Rỡ'), findsOneWidget);
  });
}
