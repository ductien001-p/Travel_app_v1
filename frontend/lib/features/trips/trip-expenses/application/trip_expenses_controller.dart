import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_frontend_v1/features/trips/data/models/trip_pagination.dart';

import '../data/models/trip_expenses_models.dart';
import '../provider/trip_expenses_provider.dart';

class TripExpensesSnapshot {
  const TripExpensesSnapshot({
    required this.overview,
    required this.meta,
    this.isLoadingMore = false,
    this.loadMoreError,
  });

  final TripExpensesOverview overview;
  final PageMeta meta;
  final bool isLoadingMore;
  final Object? loadMoreError;

  TripExpensesSnapshot copyWith({
    TripExpensesOverview? overview,
    PageMeta? meta,
    bool? isLoadingMore,
    Object? loadMoreError,
    bool clearLoadMoreError = false,
  }) {
    return TripExpensesSnapshot(
      overview: overview ?? this.overview,
      meta: meta ?? this.meta,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      loadMoreError: clearLoadMoreError
          ? null
          : (loadMoreError ?? this.loadMoreError),
    );
  }
}

/// No auto-retry: 403/404 never recover; UI has a manual retry button.
final tripExpensesControllerProvider = AsyncNotifierProvider.autoDispose
    .family<TripExpensesController, TripExpensesSnapshot, String>(
      TripExpensesController.new,
      retry: (_, _) => null,
    );

class TripExpensesController extends AsyncNotifier<TripExpensesSnapshot> {
  TripExpensesController(this.tripId);

  final String tripId;

  @override
  Future<TripExpensesSnapshot> build() => _load();

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(_load);
  }

  Future<void> loadMore() async {
    final current = state.value;
    if (current == null ||
        !current.meta.hasNextPage ||
        current.isLoadingMore) {
      return;
    }
    state = AsyncData(
      current.copyWith(isLoadingMore: true, clearLoadMoreError: true),
    );
    try {
      final page = await ref
          .read(tripExpensesRepositoryProvider)
          .getExpenses(
            tripId,
            page: current.meta.page + 1,
            limit: current.meta.limit,
          );
      final latest = state.value ?? current;
      state = AsyncData(
        latest.copyWith(
          overview: page.overview.copyWith(
            expenses: [
              ...latest.overview.expenses,
              ...page.overview.expenses,
            ],
          ),
          meta: page.meta,
          isLoadingMore: false,
          clearLoadMoreError: true,
        ),
      );
    } catch (error) {
      final latest = state.value ?? current;
      state = AsyncData(
        latest.copyWith(isLoadingMore: false, loadMoreError: error),
      );
    }
  }

  Future<TripExpensesSnapshot> _load() async {
    final page = await ref
        .read(tripExpensesRepositoryProvider)
        .getExpenses(tripId);
    return TripExpensesSnapshot(overview: page.overview, meta: page.meta);
  }
}
