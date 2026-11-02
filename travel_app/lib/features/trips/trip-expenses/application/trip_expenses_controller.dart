import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/trip_expenses_models.dart';
import '../provider/trip_expenses_provider.dart';

/// No auto-retry: 403/404 never recover; UI has a manual retry button.
final tripExpensesControllerProvider = AsyncNotifierProvider.autoDispose
    .family<TripExpensesController, TripExpensesOverview, String>(
      TripExpensesController.new,
      retry: (_, _) => null,
    );

class TripExpensesController extends AsyncNotifier<TripExpensesOverview> {
  TripExpensesController(this.tripId);

  final String tripId;

  @override
  Future<TripExpensesOverview> build() => _load();

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(_load);
  }

  Future<TripExpensesOverview> _load() =>
      ref.read(tripExpensesRepositoryProvider).getExpenses(tripId);
}
