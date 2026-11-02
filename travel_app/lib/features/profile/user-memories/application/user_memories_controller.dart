import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/user_memories_models.dart';
import '../provider/user_memories_provider.dart';
import 'user_memories_view.dart';

final userMemoriesControllerProvider =
    AsyncNotifierProvider<UserMemoriesController, UserMemoriesState>(
      UserMemoriesController.new,
    );

class UserMemoriesController extends AsyncNotifier<UserMemoriesState> {
  var _requestId = 0;
  final _pendingLikes = <String>{};

  @override
  Future<UserMemoriesState> build() {
    final filter = ref.watch(
      userMemoriesFilterProvider.select(
        (state) => (tripId: state.tripId, query: state.submittedQuery),
      ),
    );
    final now = DateTime.now();
    return _loadFirstPage(
      tripId: filter.tripId,
      q: filter.query,
      year: now.year,
      month: now.month,
      utcOffsetMinutes: now.timeZoneOffset.inMinutes,
    );
  }

  Future<bool> refresh() async {
    if (state.isLoading) return true;
    final previous = state.value;
    final filter = ref.read(userMemoriesFilterProvider);
    final now = DateTime.now();
    state = await AsyncValue.guard(
      () => _loadFirstPage(
        tripId: filter.tripId,
        q: filter.submittedQuery,
        year: now.year,
        month: now.month,
        utcOffsetMinutes: now.timeZoneOffset.inMinutes,
      ),
    );
    if (state.hasError && previous != null) {
      state = AsyncData(previous);
      return false;
    }
    return !state.hasError;
  }

  Future<void> loadMore() async {
    final current = state.value;
    final cursor = current?.nextCursor;
    if (current == null ||
        current.loadingMore ||
        !current.hasMore ||
        cursor == null) {
      return;
    }
    final requestId = _requestId;
    final filter = ref.read(userMemoriesFilterProvider);
    final now = DateTime.now();
    state = AsyncData(current.copyWith(loadingMore: true, loadMoreError: null));
    try {
      final page = await ref
          .read(userMemoriesRepositoryProvider)
          .getMine(
            tripId: filter.tripId,
            q: _query(filter.submittedQuery),
            year: now.year,
            month: now.month,
            utcOffsetMinutes: now.timeZoneOffset.inMinutes,
            cursor: cursor,
          );
      if (requestId != _requestId) return;
      final latest = state.value ?? current;
      state = AsyncData(
        latest.copyWith(
          items: [...latest.items, ...page.items],
          nextCursor: page.meta.nextCursor,
          hasMore: page.meta.hasMore,
          loadingMore: false,
          loadMoreError: null,
        ),
      );
    } catch (error) {
      if (requestId != _requestId) return;
      final latest = state.value ?? current;
      state = AsyncData(
        latest.copyWith(loadingMore: false, loadMoreError: error),
      );
    }
  }

  /// Calls like or unlike, then writes the returned count. A failed request
  /// leaves the previous count in place.
  Future<void> toggleLike(String id) async {
    final current = state.value;
    if (current == null || _pendingLikes.contains(id)) return;
    final photo = _photo(current, id);
    if (photo == null) return;
    _pendingLikes.add(id);
    try {
      final repository = ref.read(userMemoriesRepositoryProvider);
      final result = photo.liked
          ? await repository.unlike(id)
          : await repository.like(id);
      final latest = state.value;
      if (latest == null) return;
      state = AsyncData(latest.applyLike(id, result));
    } finally {
      _pendingLikes.remove(id);
    }
  }

  Future<UserMemoriesState> _loadFirstPage({
    required String? tripId,
    required String q,
    required int year,
    required int month,
    required int utcOffsetMinutes,
  }) async {
    _requestId++;
    final page = await ref
        .read(userMemoriesRepositoryProvider)
        .getMine(
          tripId: tripId,
          q: _query(q),
          year: year,
          month: month,
          utcOffsetMinutes: utcOffsetMinutes,
        );
    return UserMemoriesState.fromPage(page);
  }

  String? _query(String value) {
    final trimmed = value.trim();
    if (trimmed.isEmpty) return null;
    return trimmed;
  }

  UserMemoryPhoto? _photo(UserMemoriesState gallery, String id) {
    final highlight = gallery.highlight;
    if (highlight != null && highlight.id == id) return highlight;
    for (final item in gallery.items) {
      if (item.id == id) return item;
    }
    return null;
  }
}

final userMemoriesFilterProvider =
    NotifierProvider<UserMemoriesFilterController, UserMemoriesFilterState>(
      UserMemoriesFilterController.new,
    );

class UserMemoriesFilterController extends Notifier<UserMemoriesFilterState> {
  Timer? _queryTimer;

  @override
  UserMemoriesFilterState build() {
    ref.onDispose(() => _queryTimer?.cancel());
    return const UserMemoriesFilterState();
  }

  void selectTrip(String? tripId) {
    state = state.copyWith(tripId: tripId);
  }

  void setQuery(String query) {
    state = state.copyWith(query: query);
    _queryTimer?.cancel();
    _queryTimer = Timer(const Duration(milliseconds: 300), () {
      final next = query.trim();
      if (next == state.submittedQuery) return;
      state = state.copyWith(submittedQuery: next);
    });
  }

  void toggleSearch() {
    if (state.searchOpen) {
      _queryTimer?.cancel();
      state = state.copyWith(searchOpen: false, query: '', submittedQuery: '');
      return;
    }
    state = state.copyWith(searchOpen: true);
  }

  void toggleLayout() {
    final next = state.layout == UserMemoriesLayout.bento
        ? UserMemoriesLayout.grid
        : UserMemoriesLayout.bento;
    state = state.copyWith(layout: next);
  }
}
