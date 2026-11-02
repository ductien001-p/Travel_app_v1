import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/trip_memory_models.dart';
import '../provider/trip_memories_provider.dart';
import 'trip_memories_filter.dart';

/// Loaded pages of one filter of the album, newest memory first.
class TripMemoriesState {
  const TripMemoriesState({
    required this.filter,
    required this.entries,
    required this.nextCursor,
    required this.hasMore,
    this.totalCount,
    this.dayCounts,
    this.isLoadingMore = false,
    this.loadMoreError,
  });

  factory TripMemoriesState.fromPage(
    TripMemoriesPage page, {
    required TripMemoriesFilter filter,
  }) => TripMemoriesState(
    filter: filter,
    entries: List.unmodifiable(page.items),
    nextCursor: page.meta.nextCursor,
    hasMore: _hasNextPage(page.meta),
    totalCount: page.meta.totalCount,
    dayCounts: _dayCountsOf(page.meta),
  );

  /// Filter the [entries] were loaded for.
  final TripMemoriesFilter filter;
  final List<TripMemoryEntry> entries;
  final String? nextCursor;
  final bool hasMore;

  /// Total for [filter], when the backend sends it.
  final int? totalCount;

  /// Memories per trip day, when the backend sends them.
  final Map<int, int>? dayCounts;
  final bool isLoadingMore;
  final Object? loadMoreError;

  TripMemoriesState _copy({
    List<TripMemoryEntry>? entries,
    String? nextCursor,
    bool? hasMore,
    int? totalCount,
    Map<int, int>? dayCounts,
    bool isLoadingMore = false,
    Object? loadMoreError,
  }) => TripMemoriesState(
    filter: filter,
    entries: entries ?? this.entries,
    nextCursor: nextCursor ?? this.nextCursor,
    hasMore: hasMore ?? this.hasMore,
    totalCount: totalCount ?? this.totalCount,
    dayCounts: dayCounts ?? this.dayCounts,
    isLoadingMore: isLoadingMore,
    loadMoreError: loadMoreError,
  );

  TripMemoriesState startLoadingMore() => _copy(isLoadingMore: true);

  TripMemoriesState failLoadingMore(Object error) =>
      _copy(loadMoreError: error);

  /// Appends an older [page], skipping memories that are already loaded.
  TripMemoriesState append(TripMemoriesPage page) {
    final knownIds = {for (final entry in entries) entry.id};
    return TripMemoriesState(
      filter: filter,
      entries: List.unmodifiable([
        ...entries,
        ...page.items.where((entry) => knownIds.add(entry.id)),
      ]),
      nextCursor: page.meta.nextCursor,
      hasMore: _hasNextPage(page.meta),
      totalCount: totalCount,
      dayCounts: dayCounts,
    );
  }

  /// Drops a deleted memory; [day] is its trip day, to keep [dayCounts] right.
  TripMemoriesState removing(String memoryId, {int? day}) {
    if (!entries.any((entry) => entry.id == memoryId)) return this;
    final counts = dayCounts;
    return _copy(
      entries: List.unmodifiable(
        entries.where((entry) => entry.id != memoryId),
      ),
      totalCount: totalCount == null ? null : _decrement(totalCount!),
      dayCounts: counts == null || day == null || !counts.containsKey(day)
          ? null
          : Map.unmodifiable({...counts, day: _decrement(counts[day]!)}),
      isLoadingMore: isLoadingMore,
      loadMoreError: loadMoreError,
    );
  }

  /// Replaces one memory after a caption edit without reloading pages.
  TripMemoriesState replacing(TripMemoryEntry updated) {
    if (!entries.any((entry) => entry.id == updated.id)) return this;
    return _copy(
      entries: List.unmodifiable([
        for (final entry in entries)
          if (entry.id == updated.id) updated else entry,
      ]),
      isLoadingMore: isLoadingMore,
      loadMoreError: loadMoreError,
    );
  }

  static int _decrement(int value) => value > 0 ? value - 1 : 0;

  static bool _hasNextPage(TripMemoriesCursor meta) =>
      meta.hasMore && meta.nextCursor != null;

  static Map<int, int>? _dayCountsOf(TripMemoriesCursor meta) {
    final counts = meta.dayCounts;
    if (counts == null) return null;
    return Map.unmodifiable({for (final c in counts) c.day: c.count});
  }
}

/// No automatic retry: 403/404 never recover, and the error state has a
/// manual retry button for transient failures.
final tripMemoriesControllerProvider = AsyncNotifierProvider.autoDispose
    .family<TripMemoriesController, TripMemoriesState, String>(
      TripMemoriesController.new,
      retry: (_, _) => null,
    );

class TripMemoriesController extends AsyncNotifier<TripMemoriesState> {
  TripMemoriesController(this.tripId);

  final String tripId;

  /// Bumped on every reload so a slow `loadMore` cannot append to a newer list.
  int _generation = 0;
  bool _refreshing = false;

  @override
  FutureOr<TripMemoriesState> build() async {
    _generation++;
    final filter = ref.watch(tripMemoriesFilterProvider(tripId));
    return _fetchFirstPage(filter);
  }

  Future<TripMemoriesState> _fetchFirstPage(TripMemoriesFilter filter) async {
    final page = await ref
        .read(tripMemoriesRepositoryProvider)
        .getMemories(tripId, day: filter.day, uploaderId: filter.uploaderId);
    return TripMemoriesState.fromPage(page, filter: filter);
  }

  /// Reloads the first page. Keeps the current list if reloading fails and
  /// reports the failure through the returned future.
  Future<void> refresh() async {
    if (_refreshing) return;
    _refreshing = true;
    final generation = ++_generation;
    try {
      final next = await _fetchFirstPage(
        ref.read(tripMemoriesFilterProvider(tripId)),
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
          .read(tripMemoriesRepositoryProvider)
          .getMemories(
            tripId,
            cursor: current.nextCursor,
            day: current.filter.day,
            uploaderId: current.filter.uploaderId,
          );
      if (!ref.mounted || generation != _generation) return;
      state = AsyncData(current.append(page));
    } catch (error) {
      if (!ref.mounted || generation != _generation) return;
      state = AsyncData(current.failLoadingMore(error));
    }
  }

  /// Applies a delete confirmed by the backend without reloading the pages.
  void removeLocally(String memoryId, {int? day}) {
    final current = state.value;
    if (current == null) return;
    state = AsyncData(current.removing(memoryId, day: day));
  }

  /// Applies a caption edit confirmed by the backend without reloading pages.
  void replaceLocally(TripMemoryEntry updated) {
    final current = state.value;
    if (current == null) return;
    state = AsyncData(current.replacing(updated));
  }
}
