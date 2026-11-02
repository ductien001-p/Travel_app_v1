import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/trip_timeline_models.dart';
import '../provider/trip_timeline_provider.dart';
import 'trip_timeline_filter.dart';

/// Loaded pages of one filter of the trip timeline, newest event first.
class TripTimelineEventsState {
  const TripTimelineEventsState({
    required this.filter,
    required this.entries,
    required this.counts,
    required this.nextCursor,
    required this.hasMore,
    this.isLoadingMore = false,
    this.loadMoreError,
  });

  factory TripTimelineEventsState.fromPage(
    TripTimelinePage page, {
    required TripTimelineFilter filter,
  }) => TripTimelineEventsState(
    filter: filter,
    entries: List.unmodifiable(page.items),
    counts: page.meta.counts ?? _countLoaded(page.items),
    nextCursor: page.meta.nextCursor,
    hasMore: _hasNextPage(page.meta),
  );

  /// Filter the [entries] were loaded for.
  final TripTimelineFilter filter;
  final List<TripTimelineEntry> entries;

  /// Totals of the whole trip, independent of [filter].
  final TripTimelineCounts counts;
  final String? nextCursor;
  final bool hasMore;
  final bool isLoadingMore;
  final Object? loadMoreError;

  TripTimelineEventsState _copy({
    List<TripTimelineEntry>? entries,
    TripTimelineCounts? counts,
    String? nextCursor,
    bool? hasMore,
    bool isLoadingMore = false,
    Object? loadMoreError,
  }) => TripTimelineEventsState(
    filter: filter,
    entries: entries ?? this.entries,
    counts: counts ?? this.counts,
    nextCursor: nextCursor ?? this.nextCursor,
    hasMore: hasMore ?? this.hasMore,
    isLoadingMore: isLoadingMore,
    loadMoreError: loadMoreError,
  );

  TripTimelineEventsState startLoadingMore() => _copy(isLoadingMore: true);

  TripTimelineEventsState failLoadingMore(Object error) =>
      _copy(loadMoreError: error);

  /// Appends an older [page], skipping events that are already loaded.
  TripTimelineEventsState append(TripTimelinePage page) {
    final knownIds = {for (final entry in entries) entry.id};
    return TripTimelineEventsState(
      filter: filter,
      entries: List.unmodifiable([
        ...entries,
        ...page.items.where((entry) => knownIds.add(entry.id)),
      ]),
      counts: counts,
      nextCursor: page.meta.nextCursor,
      hasMore: _hasNextPage(page.meta),
    );
  }

  /// Adds an event pushed by the server. Duplicates are ignored, so an event
  /// that also arrives through a page reload is never counted twice.
  TripTimelineEventsState receive(TripTimelineEntry entry) {
    if (entries.any((known) => known.id == entry.id)) return this;
    return _copy(
      entries: filter.matches(entry.type)
          ? List.unmodifiable([entry, ...entries])
          : entries,
      counts: counts.adding(entry.type),
      isLoadingMore: isLoadingMore,
      loadMoreError: loadMoreError,
    );
  }

  static bool _hasNextPage(TripTimelineCursor meta) =>
      meta.hasMore && meta.nextCursor != null;

  /// Fallback for a response without `meta.counts`.
  static TripTimelineCounts _countLoaded(List<TripTimelineEntry> items) =>
      items.fold(
        const TripTimelineCounts(),
        (counts, entry) => counts.adding(entry.type),
      );
}

/// No automatic retry: 403/404 never recover, and the error state has a
/// manual retry button for transient failures.
final tripTimelineEventsControllerProvider = AsyncNotifierProvider.autoDispose
    .family<TripTimelineEventsController, TripTimelineEventsState, String>(
      TripTimelineEventsController.new,
      retry: (_, _) => null,
    );

class TripTimelineEventsController
    extends AsyncNotifier<TripTimelineEventsState> {
  TripTimelineEventsController(this.tripId);

  final String tripId;

  /// Bumped on every reload so a slow `loadMore` cannot append to a newer list.
  int _generation = 0;
  bool _refreshing = false;

  @override
  FutureOr<TripTimelineEventsState> build() async {
    _generation++;
    final filter = ref.watch(tripTimelineFilterProvider(tripId));
    return _fetchFirstPage(filter);
  }

  Future<TripTimelineEventsState> _fetchFirstPage(
    TripTimelineFilter filter,
  ) async {
    final page = await ref
        .read(tripTimelineRepositoryProvider)
        .getTripTimeline(tripId, category: filter.apiCategory);
    return TripTimelineEventsState.fromPage(page, filter: filter);
  }

  /// Reloads the first page. Keeps the current list if reloading fails and
  /// reports the failure through the returned future.
  Future<void> refresh() async {
    if (_refreshing) return;
    _refreshing = true;
    final generation = ++_generation;
    try {
      final next = await _fetchFirstPage(
        ref.read(tripTimelineFilterProvider(tripId)),
      );
      if (!ref.mounted || generation != _generation) return;
      state = AsyncData(next);
    } catch (error, stackTrace) {
      if (!ref.mounted || generation != _generation) return;
      if (state.value == null) {
        state = AsyncError(error, stackTrace);
        return;
      }
      rethrow;
    } finally {
      _refreshing = false;
    }
  }

  Future<void> loadMore() async {
    final current = state.value;
    if (current == null || !current.hasMore || current.isLoadingMore) return;
    final generation = _generation;
    state = AsyncData(current.startLoadingMore());
    try {
      final page = await ref
          .read(tripTimelineRepositoryProvider)
          .getTripTimeline(
            tripId,
            cursor: current.nextCursor,
            category: current.filter.apiCategory,
          );
      if (!ref.mounted || generation != _generation) return;
      state = AsyncData(current.append(page));
    } catch (error) {
      if (!ref.mounted || generation != _generation) return;
      state = AsyncData(current.failLoadingMore(error));
    }
  }

  /// Applies an event pushed over the trip socket. Ignored while a first page
  /// is loading, because that page already contains the event.
  void receive(TripTimelineEntry entry) {
    final current = state.value;
    if (current == null || state.isLoading || entry.tripId != tripId) return;
    state = AsyncData(current.receive(entry));
  }
}
