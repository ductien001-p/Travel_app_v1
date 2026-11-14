import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/trip_enums.dart';
import '../data/models/trip_list_item.dart';
import '../data/models/trip_pagination.dart';
import '../data/models/trip_query.dart';
import '../provider/trips_provider.dart';

class TripListState {
  const TripListState({
    required this.items,
    required this.query,
    required this.meta,
    required this.summary,
    this.isLoadingMore = false,
    this.loadMoreError,
  });
  final List<TripListItem> items;
  final TripQuery query;
  final PageMeta meta;
  final TripSummary summary;
  final bool isLoadingMore;
  final Object? loadMoreError;

  bool get hasMore => meta.hasNextPage;

  TripListState copyWith({
    List<TripListItem>? items,
    TripQuery? query,
    PageMeta? meta,
    TripSummary? summary,
    bool? isLoadingMore,
    Object? loadMoreError,
    bool clearLoadMoreError = false,
  }) => TripListState(
    items: items ?? this.items,
    query: query ?? this.query,
    meta: meta ?? this.meta,
    summary: summary ?? this.summary,
    isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    loadMoreError: clearLoadMoreError
        ? null
        : (loadMoreError ?? this.loadMoreError),
  );
}

final tripListControllerProvider =
    AsyncNotifierProvider<TripListController, TripListState>(
      TripListController.new,
    );

class TripDashboardState {
  const TripDashboardState({
    required this.ongoing,
    required this.upcoming,
    required this.summary,
  });

  final List<TripListItem> ongoing;
  final List<TripListItem> upcoming;
  final TripSummary summary;
}

final tripDashboardControllerProvider =
    AsyncNotifierProvider<TripDashboardController, TripDashboardState>(
      TripDashboardController.new,
    );

/// Loads the two collections used together by the Trips dashboard.
/// Keeping this aggregation here prevents the screen from reaching into the
/// repository while still allowing both sections to be rendered at once.
class TripDashboardController extends AsyncNotifier<TripDashboardState> {
  @override
  FutureOr<TripDashboardState> build() => _load();

  Future<TripDashboardState> _load() async {
    final repository = ref.read(tripRepositoryProvider);
    final pages = await Future.wait([
      repository.getTrips(
        const TripQuery(status: TripStatus.ongoing, limit: 5),
      ),
      repository.getTrips(
        const TripQuery(status: TripStatus.upcoming, limit: 5),
      ),
    ]);
    return TripDashboardState(
      ongoing: pages[0].items,
      upcoming: pages[1].items,
      summary: pages[0].summary,
    );
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(_load);
  }
}

class TripListController extends AsyncNotifier<TripListState> {
  TripQuery _query = const TripQuery(status: TripStatus.ongoing);
  bool _loadingMore = false;

  @override
  FutureOr<TripListState> build() => _load(_query);

  Future<TripListState> _load(TripQuery query) async {
    final page = await ref.read(tripRepositoryProvider).getTrips(query);
    return TripListState(
      items: page.items,
      query: query,
      meta: page.meta,
      summary: page.summary,
    );
  }

  Future<void> refresh() async {
    final query = _query.copyWith(page: 1);
    _query = query;
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _load(query));
  }

  Future<void> setQuery(TripQuery query) async {
    _query = query.copyWith(page: 1);
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _load(_query));
  }

  Future<void> setSearch(String? search) async {
    await setQuery(
      TripQuery(
        search: search,
        tripType: _query.tripType,
        visibility: _query.visibility,
        status: _query.status,
        budgetLevel: _query.budgetLevel,
        ownerId: _query.ownerId,
        limit: _query.limit,
      ),
    );
  }

  Future<void> loadNextPage() async {
    final current = state.value;
    if (current == null || !current.hasMore || _loadingMore) return;
    _loadingMore = true;
    state = AsyncData(
      current.copyWith(isLoadingMore: true, clearLoadMoreError: true),
    );
    try {
      final nextQuery = _query.copyWith(page: current.meta.page + 1);
      final page = await ref.read(tripRepositoryProvider).getTrips(nextQuery);
      _query = nextQuery;
      state = AsyncData(
        current.copyWith(
          items: [...current.items, ...page.items],
          query: nextQuery,
          meta: page.meta,
          summary: page.summary,
          isLoadingMore: false,
          clearLoadMoreError: true,
        ),
      );
    } catch (error) {
      state = AsyncData(
        current.copyWith(isLoadingMore: false, loadMoreError: error),
      );
    } finally {
      _loadingMore = false;
    }
  }
}
