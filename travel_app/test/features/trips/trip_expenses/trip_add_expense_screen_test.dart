import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:travel_frontend_v1/core/widget/app_button.dart';
import 'package:travel_frontend_v1/features/trips/trip-expenses/data/models/trip_expenses_models.dart';
import 'package:travel_frontend_v1/features/trips/trip-expenses/presentation/widgets/trip_add_expense_widgets.dart';

void main() {
  testWidgets('add-expense chrome matches Stitch labels', (tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    var selected = TripExpensesCategory.food;
    var cancelled = false;
    var submitted = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                TripAddExpenseTopBar(
                  tripName: 'Mùa hè rực rỡ 2025',
                  onCancel: () => cancelled = true,
                  onScanReceipt: () {},
                ),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    children: [
                      TripAddExpenseCategoryGrid(
                        selected: selected,
                        onSelected: (value) => selected = value,
                      ),
                    ],
                  ),
                ),
                TripAddExpenseBottomBar(
                  memberCount: 4,
                  isLoading: false,
                  onSubmit: () => submitted = true,
                ),
              ],
            ),
          ),
        ),
      ),
    );

    expect(find.text('Thêm Khoản Chi'), findsOneWidget);
    expect(find.text('Mùa hè rực rỡ 2025'), findsOneWidget);
    expect(find.text('Hủy'), findsOneWidget);
    expect(find.text('Danh Mục Chi Tiêu'), findsOneWidget);
    expect(find.text('Ẩm thực'), findsOneWidget);
    expect(find.text('Xác nhận & Lưu khoản chi'), findsOneWidget);
    expect(find.textContaining('4 thành viên'), findsOneWidget);

    await tester.tap(find.text('Hủy'));
    await tester.pump();
    expect(cancelled, isTrue);

    await tester.tap(find.text('Lưu trú'));
    await tester.pump();
    expect(selected, TripExpensesCategory.accommodation);

    await tester.tap(find.byType(AppButton));
    await tester.pump();
    expect(submitted, isTrue);
  });
}
