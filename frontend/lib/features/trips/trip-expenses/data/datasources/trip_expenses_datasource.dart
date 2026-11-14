import 'package:travel_frontend_v1/features/trips/data/models/trip_pagination.dart';

import '../models/trip_expenses_models.dart';

class TripExpensesPage {
  const TripExpensesPage({required this.overview, required this.meta});

  final TripExpensesOverview overview;
  final PageMeta meta;
}

abstract class TripExpensesDataSource {
  /// `TripExpenseController.getExpenses` — `GET /trips/{tripId}/expenses`.
  Future<TripExpensesPage> getExpenses(
    String tripId, {
    int page = 1,
    int limit = 20,
  });

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
