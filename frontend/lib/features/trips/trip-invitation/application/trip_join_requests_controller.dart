import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/trip_join_request_models.dart';
import '../provider/trip_join_requests_provider.dart';

/// Tab of the review screen.
final tripJoinRequestStatusProvider = NotifierProvider.autoDispose
    .family<TripJoinRequestStatusController, TripJoinRequestStatus, String>(
      TripJoinRequestStatusController.new,
    );

class TripJoinRequestStatusController extends Notifier<TripJoinRequestStatus> {
  TripJoinRequestStatusController(this.tripId);

  final String tripId;

  @override
  TripJoinRequestStatus build() => TripJoinRequestStatus.pending;

  void select(TripJoinRequestStatus status) => state = status;
}

/// Loaded pages of one tab, newest request first.
class TripJoinRequestsState {
  const TripJoinRequestsState({
    required this.status,
    required this.requests,
    required this.counts,
    this.nextCursor,
    this.isLoadingMore = false,
    this.loadMoreError,
  });

  factory TripJoinRequestsState.fromPage(
    TripJoinRequestsPage page, {
    required TripJoinRequestStatus status,
  }) => TripJoinRequestsState(
    status: status,
    requests: List.unmodifiable(page.items),
    counts: page.meta.counts,
    nextCursor: _nextCursorOf(page.meta),
  );

  /// Tab the [requests] were loaded for.
  final TripJoinRequestStatus status;
  final List<TripJoinRequest> requests;

  /// Requests of the whole trip per status.
  final TripJoinRequestCounts counts;
  final String? nextCursor;
  final bool isLoadingMore;
  final Object? loadMoreError;

  bool get hasMore => nextCursor != null;

  TripJoinRequestsState _copy({
    List<TripJoinRequest>? requests,
    TripJoinRequestCounts? counts,
    bool isLoadingMore = false,
    Object? loadMoreError,
  }) => TripJoinRequestsState(
    status: status,
    requests: requests ?? this.requests,
    counts: counts ?? this.counts,
    nextCursor: nextCursor,
    isLoadingMore: isLoadingMore,
    loadMoreError: loadMoreError,
  );

  TripJoinRequestsState startLoadingMore() => _copy(isLoadingMore: true);

  TripJoinRequestsState failLoadingMore(Object error) =>
      _copy(loadMoreError: error);

  /// Appends an older [page], skipping requests that are already loaded.
  TripJoinRequestsState append(TripJoinRequestsPage page) {
    final knownIds = {for (final request in requests) request.id};
    return TripJoinRequestsState(
      status: status,
      requests: List.unmodifiable([
        ...requests,
        ...page.items.where((request) => knownIds.add(request.id)),
      ]),
      counts: page.meta.counts,
      nextCursor: _nextCursorOf(page.meta),
    );
  }

  /// Takes a pending request the backend just reviewed off this tab.
  TripJoinRequestsState applyDecision(TripJoinRequest reviewed) {
    final wasListed = requests.any((request) => request.id == reviewed.id);
    if (!wasListed || reviewed.status == status) return this;
    return _copy(
      requests: List.unmodifiable(
        requests.where((request) => request.id != reviewed.id),
      ),
      counts: counts.decided(reviewed.status),
      isLoadingMore: isLoadingMore,
      loadMoreError: loadMoreError,
    );
  }

  static String? _nextCursorOf(TripJoinRequestsMeta meta) =>
      meta.hasMore ? meta.nextCursor : null;
}

/// No automatic retry: 403/404 never recover, and the screen has a manual
/// retry button for transient failures.
final tripJoinRequestsControllerProvider = AsyncNotifierProvider.autoDispose
    .family<TripJoinRequestsController, TripJoinRequestsState, String>(
      TripJoinRequestsController.new,
      retry: (_, _) => null,
    );

class TripJoinRequestsController extends AsyncNotifier<TripJoinRequestsState> {
  TripJoinRequestsController(this.tripId);

  final String tripId;

  /// Bumped on every reload so a slow `loadMore` cannot append to a newer list.
  int _generation = 0;
  bool _refreshing = false;

  @override
  FutureOr<TripJoinRequestsState> build() {
    _generation++;
    return _fetchFirstPage(ref.watch(tripJoinRequestStatusProvider(tripId)));
  }

  Future<TripJoinRequestsState> _fetchFirstPage(
    TripJoinRequestStatus status,
  ) async {
    final page = await ref
        .read(tripJoinRequestsRepositoryProvider)
        .getJoinRequests(tripId, status: status);
    return TripJoinRequestsState.fromPage(page, status: status);
  }

  /// Reloads the first page. Keeps the current list if reloading fails and
  /// reports the failure through the returned future.
  Future<void> refresh() async {
    if (_refreshing) return;
    _refreshing = true;
    final generation = ++_generation;
    try {
      final next = await _fetchFirstPage(
        ref.read(tripJoinRequestStatusProvider(tripId)),
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
          .read(tripJoinRequestsRepositoryProvider)
          .getJoinRequests(
            tripId,
            status: current.status,
            cursor: current.nextCursor,
          );
      if (!ref.mounted || generation != _generation) return;
      state = AsyncData(current.append(page));
    } catch (error) {
      if (!ref.mounted || generation != _generation) return;
      state = AsyncData(current.failLoadingMore(error));
    }
  }

  /// Applies a decision confirmed by the backend without reloading the pages.
  void applyDecision(TripJoinRequest reviewed) {
    final current = state.value;
    if (current == null) return;
    state = AsyncData(current.applyDecision(reviewed));
  }
}
