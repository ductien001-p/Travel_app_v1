import 'package:flutter_test/flutter_test.dart';
import 'package:travel_frontend_v1/features/trips/trip-expenses/application/trip_expenses_filter.dart';
import 'package:travel_frontend_v1/features/trips/trip-expenses/application/trip_expenses_view.dart';
import 'package:travel_frontend_v1/features/trips/trip-expenses/data/datamock/trip_expenses_datamock.dart';
import 'package:travel_frontend_v1/features/trips/trip-expenses/data/models/trip_expenses_models.dart';
import 'package:travel_frontend_v1/features/trips/trip-expenses/utils/trip_expenses_formatters.dart';

void main() {
  final overview = TripExpensesOverview.fromJson(
    Map<String, dynamic>.from(tripExpensesDatamock),
  );

  group('buildTripExpensesView', () {
    test('shows all expenses by default', () {
      final view = buildTripExpensesView(overview, const TripExpensesFilter());

      expect(view.status, TripExpensesBodyStatus.ready);
      expect(view.expenses.length, 4);
      expect(view.mineCount, 2);
      expect(view.unsettledCount, 2);
    });

    test('filters mine scope to viewer-paid expenses', () {
      final view = buildTripExpensesView(
        overview,
        const TripExpensesFilter(scope: TripExpensesScope.mine),
      );

      expect(view.expenses.length, 2);
      expect(view.expenses.every((e) => e.payerIsViewer), isTrue);
    });

    test('filters unsettled and food category together', () {
      final view = buildTripExpensesView(
        overview,
        const TripExpensesFilter(
          scope: TripExpensesScope.unsettled,
          category: TripExpensesCategory.food,
        ),
      );

      expect(view.expenses.length, 1);
      expect(view.expenses.single.id, 'expense-seafood');
    });

    test('reports filteredEmpty when nothing matches', () {
      final view = buildTripExpensesView(
        overview,
        const TripExpensesFilter(
          scope: TripExpensesScope.mine,
          category: TripExpensesCategory.food,
        ),
      );

      expect(view.status, TripExpensesBodyStatus.filteredEmpty);
      expect(view.expenses, isEmpty);
    });
  });

  group('trip expenses formatters', () {
    test('formats VND with thousand separators', () {
      expect(formatExpenseMoney(4850000), '4.850.000 đ');
      expect(formatSignedExpenseMoney(425000), '+425.000 đ');
      expect(formatExpenseMoneyCompact(2037000), '2037k');
    });

    test('maps category labels and settle status', () {
      expect(expenseCategoryLabel(TripExpensesCategory.food), 'Ẩm thực');
      final entry = overview.expenses.first;
      expect(expenseSettleStatusLabel(entry), contains('Đã tất toán'));
    });
  });
}
