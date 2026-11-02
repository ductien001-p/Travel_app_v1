import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/trip_expenses_models.dart';

/// Segmented tabs under the settlement section.
enum TripExpensesScope { all, mine, unsettled }

class TripExpensesFilter {
  const TripExpensesFilter({this.scope = TripExpensesScope.all, this.category});

  final TripExpensesScope scope;

  /// Null = every category ("Tất cả").
  final TripExpensesCategory? category;

  TripExpensesFilter copyWith({
    TripExpensesScope? scope,
    TripExpensesCategory? category,
    bool clearCategory = false,
  }) => TripExpensesFilter(
    scope: scope ?? this.scope,
    category: clearCategory ? null : (category ?? this.category),
  );

  bool get isDefault => scope == TripExpensesScope.all && category == null;
}

final tripExpensesFilterProvider = NotifierProvider.autoDispose
    .family<TripExpensesFilterController, TripExpensesFilter, String>(
      TripExpensesFilterController.new,
    );

class TripExpensesFilterController extends Notifier<TripExpensesFilter> {
  TripExpensesFilterController(this.tripId);

  final String tripId;

  @override
  TripExpensesFilter build() => const TripExpensesFilter();

  void selectScope(TripExpensesScope scope) {
    if (state.scope == scope) return;
    state = state.copyWith(scope: scope);
  }

  void selectCategory(TripExpensesCategory? category) {
    if (state.category == category) return;
    state = category == null
        ? state.copyWith(clearCategory: true)
        : state.copyWith(category: category);
  }
}
