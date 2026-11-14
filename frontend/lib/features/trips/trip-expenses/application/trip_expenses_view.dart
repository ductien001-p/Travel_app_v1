import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/trip_expenses_models.dart';
import 'trip_expenses_controller.dart';
import 'trip_expenses_filter.dart';

enum TripExpensesBodyStatus { ready, empty, filteredEmpty }

class TripExpensesView {
  const TripExpensesView({
    required this.overview,
    required this.filter,
    required this.expenses,
    required this.status,
    required this.mineCount,
    required this.unsettledCount,
    required this.hasNextPage,
    required this.isLoadingMore,
    this.loadMoreError,
  });

  final TripExpensesOverview overview;
  final TripExpensesFilter filter;
  final List<TripExpensesEntry> expenses;
  final TripExpensesBodyStatus status;
  final int mineCount;
  final int unsettledCount;
  final bool hasNextPage;
  final bool isLoadingMore;
  final Object? loadMoreError;

  int get categoryCount => overview.categories.length;

  int countOfCategory(TripExpensesCategory? category) {
    if (category == null) return overview.expenses.length;
    return overview.expenses.where((e) => e.category == category).length;
  }
}

final tripExpensesViewProvider = Provider.autoDispose
    .family<AsyncValue<TripExpensesView>, String>((ref, tripId) {
      final overview = ref.watch(tripExpensesControllerProvider(tripId));
      final filter = ref.watch(tripExpensesFilterProvider(tripId));
      return overview.when(
        data: (data) => AsyncData(
          buildTripExpensesView(
            data.overview,
            filter,
            hasNextPage: data.meta.hasNextPage,
            isLoadingMore: data.isLoadingMore,
            loadMoreError: data.loadMoreError,
          ),
        ),
        error: (error, stackTrace) => AsyncError(error, stackTrace),
        loading: () => const AsyncLoading(),
      );
    });

TripExpensesView buildTripExpensesView(
  TripExpensesOverview overview,
  TripExpensesFilter filter, {
  bool hasNextPage = false,
  bool isLoadingMore = false,
  Object? loadMoreError,
}) {
  final mineCount = overview.expenses.where((e) => e.payerIsViewer).length;
  final unsettledCount = overview.expenses
      .where((e) => e.status != TripExpensesSettleStatus.settled)
      .length;

  final filtered = overview.expenses
      .where((entry) {
        final scopeOk = switch (filter.scope) {
          TripExpensesScope.all => true,
          TripExpensesScope.mine => entry.payerIsViewer,
          TripExpensesScope.unsettled =>
            entry.status != TripExpensesSettleStatus.settled,
        };
        final categoryOk =
            filter.category == null || entry.category == filter.category;
        return scopeOk && categoryOk;
      })
      .toList(growable: false);

  final status = overview.expenses.isEmpty
      ? TripExpensesBodyStatus.empty
      : filtered.isEmpty
      ? TripExpensesBodyStatus.filteredEmpty
      : TripExpensesBodyStatus.ready;

  return TripExpensesView(
    overview: overview,
    filter: filter,
    expenses: filtered,
    status: status,
    mineCount: mineCount,
    unsettledCount: unsettledCount,
    hasNextPage: hasNextPage,
    isLoadingMore: isLoadingMore,
    loadMoreError: loadMoreError,
  );
}
