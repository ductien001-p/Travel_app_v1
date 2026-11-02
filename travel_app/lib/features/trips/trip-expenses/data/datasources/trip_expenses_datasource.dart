import '../models/trip_expenses_models.dart';

abstract class TripExpensesDataSource {
  /// `TripExpenseController.getExpenses` — `GET /trips/{tripId}/expenses`.
  Future<TripExpensesOverview> getExpenses(String tripId);

  /// `TripExpenseController.createExpense` — `POST /trips/{tripId}/expenses`.
  Future<TripExpenseCreated> createExpense(
    String tripId,
    CreateTripExpenseRequest request,
  );

  /// `TripExpenseController.settleSplit`.
  Future<TripExpenseCreatedSplit> settleSplit({
    required String tripId,
    required String expenseId,
    required String splitId,
  });
}
