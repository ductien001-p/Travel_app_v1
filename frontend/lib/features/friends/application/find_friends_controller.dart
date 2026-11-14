import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_frontend_v1/features/trips/application/device_location_controller.dart';

import '../data/models/find_friends_models.dart';
import '../provider/find_friends_provider.dart';
import 'find_friends_recent_searches_store.dart';
import 'find_friends_view.dart';

/// No automatic retry: 401 never recovers, and the screen retries manually.
final findFriendsControllerProvider =
    AsyncNotifierProvider.autoDispose<
      FindFriendsController,
      FindFriendsViewState
    >(FindFriendsController.new, retry: (_, _) => null);

class FindFriendsController extends AsyncNotifier<FindFriendsViewState> {
  Timer? _searchTimer;
  int _searchGeneration = 0;
  double? _lat;
  double? _lng;

  @override
  Future<FindFriendsViewState> build() {
    ref.onDispose(() => _searchTimer?.cancel());
    return _bootstrap();
  }

  Future<FindFriendsViewState> _bootstrap() async {
    final recent = await ref
        .read(findFriendsRecentSearchesStoreProvider)
        .load();
    await _tryShareDiscoveryLocation();
    final page = await ref
        .read(findFriendsRepositoryProvider)
        .find(query: '', lat: _lat, lng: _lng);
    return FindFriendsViewState(
      page: page.copyWith(recentSearches: const <String>[]),
      query: '',
      recentSearches: recent,
    );
  }

  Future<bool> refresh() async {
    final previous = state.asData?.value;
    final query = previous?.query ?? '';
    state = const AsyncLoading<FindFriendsViewState>();
    state = await AsyncValue.guard(() async {
      await _tryShareDiscoveryLocation();
      return _load(query: query, recent: previous?.recentSearches);
    });
    if (state.hasError && previous != null) {
      state = AsyncData(previous);
      return false;
    }
    return !state.hasError;
  }

  void setQuery(String raw) {
    final current = state.asData?.value;
    if (current == null) return;
    final query = raw.trim();
    if (current.query == raw && !current.isSearching) return;

    state = AsyncData(
      current.copyWith(
        query: raw,
        isSearching: true,
        clearSearchError: true,
        clearActionError: true,
      ),
    );

    _searchTimer?.cancel();
    final generation = ++_searchGeneration;
    _searchTimer = Timer(const Duration(milliseconds: 350), () {
      unawaited(_runSearch(query: query, generation: generation));
    });
  }

  Future<void> submitQuery(String raw) async {
    _searchTimer?.cancel();
    final current = state.asData?.value;
    if (current == null) return;
    final query = raw.trim();
    state = AsyncData(
      current.copyWith(
        query: query,
        isSearching: true,
        clearSearchError: true,
        clearActionError: true,
      ),
    );
    await _runSearch(query: query, generation: ++_searchGeneration);
  }

  Future<void> applyRecentSearch(String term) async {
    await submitQuery(term);
  }

  Future<void> removeRecentSearch(String term) async {
    final current = state.asData?.value;
    if (current == null) return;
    final next = current.recentSearches
        .where((item) => item != term)
        .toList(growable: false);
    state = AsyncData(current.copyWith(recentSearches: next));
    await ref.read(findFriendsRecentSearchesStoreProvider).save(next);
  }

  Future<void> clearRecentSearches() async {
    final current = state.asData?.value;
    if (current == null) return;
    state = AsyncData(current.copyWith(recentSearches: const <String>[]));
    await ref
        .read(findFriendsRecentSearchesStoreProvider)
        .save(const <String>[]);
  }

  Future<bool> sendFriendRequest(String userId) async {
    final current = state.asData?.value;
    if (current == null || current.busyUserId != null) return false;

    state = AsyncData(
      current.copyWith(busyUserId: userId, clearActionError: true),
    );

    try {
      final sent = await ref
          .read(findFriendsRepositoryProvider)
          .sendFriendRequest(userId);
      final latest = state.asData?.value ?? current;
      state = AsyncData(
        latest.copyWith(
          page: _markRequestSent(latest.page, userId, sent.id),
          clearBusyUser: true,
          clearActionError: true,
        ),
      );
      return true;
    } catch (error) {
      final latest = state.asData?.value ?? current;
      state = AsyncData(
        latest.copyWith(clearBusyUser: true, actionError: error),
      );
      return false;
    }
  }

  Future<bool> cancelFriendRequest({
    required String userId,
    required String requestId,
  }) async {
    final current = state.asData?.value;
    if (current == null || current.busyUserId != null) return false;

    state = AsyncData(
      current.copyWith(busyUserId: userId, clearActionError: true),
    );

    try {
      await ref
          .read(findFriendsRepositoryProvider)
          .cancelFriendRequest(requestId);
      final latest = state.asData?.value ?? current;
      state = AsyncData(
        latest.copyWith(
          page: _markRequestCancelled(latest.page, userId),
          clearBusyUser: true,
          clearActionError: true,
        ),
      );
      return true;
    } catch (error) {
      final latest = state.asData?.value ?? current;
      state = AsyncData(
        latest.copyWith(clearBusyUser: true, actionError: error),
      );
      return false;
    }
  }

  Future<bool> followUser(String userId) async {
    final current = state.asData?.value;
    if (current == null || current.busyUserId != null) return false;

    state = AsyncData(
      current.copyWith(busyUserId: userId, clearActionError: true),
    );

    try {
      await ref.read(findFriendsRepositoryProvider).followUser(userId);
      final latest = state.asData?.value ?? current;
      state = AsyncData(
        latest.copyWith(
          page: _markFollowed(latest.page, userId),
          clearBusyUser: true,
          clearActionError: true,
        ),
      );
      return true;
    } catch (error) {
      final latest = state.asData?.value ?? current;
      state = AsyncData(
        latest.copyWith(clearBusyUser: true, actionError: error),
      );
      return false;
    }
  }

  Future<bool> unfollowUser(String userId) async {
    final current = state.asData?.value;
    if (current == null || current.busyUserId != null) return false;

    state = AsyncData(
      current.copyWith(busyUserId: userId, clearActionError: true),
    );

    try {
      await ref.read(findFriendsRepositoryProvider).unfollowUser(userId);
      final latest = state.asData?.value ?? current;
      state = AsyncData(
        latest.copyWith(
          page: _markUnfollowed(latest.page, userId),
          clearBusyUser: true,
          clearActionError: true,
        ),
      );
      return true;
    } catch (error) {
      final latest = state.asData?.value ?? current;
      state = AsyncData(
        latest.copyWith(clearBusyUser: true, actionError: error),
      );
      return false;
    }
  }

  Future<String?> openConversation(String friendId) async {
    final current = state.asData?.value;
    if (current == null || current.busyUserId != null) return null;

    state = AsyncData(
      current.copyWith(busyUserId: friendId, clearActionError: true),
    );
    try {
      final conversationId = await ref
          .read(findFriendsRepositoryProvider)
          .getOrCreateConversation(friendId);
      final latest = state.asData?.value ?? current;
      state = AsyncData(
        latest.copyWith(
          page: _withConversationId(latest.page, friendId, conversationId),
          clearBusyUser: true,
          clearActionError: true,
        ),
      );
      return conversationId;
    } catch (error) {
      final latest = state.asData?.value ?? current;
      state = AsyncData(
        latest.copyWith(clearBusyUser: true, actionError: error),
      );
      return null;
    }
  }

  Future<FindFriendsViewState> _load({
    required String query,
    List<String>? recent,
  }) async {
    final page = await ref
        .read(findFriendsRepositoryProvider)
        .find(query: query, lat: _lat, lng: _lng);
    final recentSearches =
        recent ??
        state.asData?.value.recentSearches ??
        await ref.read(findFriendsRecentSearchesStoreProvider).load();
    return FindFriendsViewState(
      page: page,
      query: query,
      recentSearches: recentSearches,
    );
  }

  Future<void> _runSearch({
    required String query,
    required int generation,
  }) async {
    try {
      final page = await ref
          .read(findFriendsRepositoryProvider)
          .find(query: query, lat: _lat, lng: _lng);
      if (generation != _searchGeneration) return;
      final current = state.asData?.value;
      if (current == null) return;
      final recent = await _rememberQuery(query, current.recentSearches);
      state = AsyncData(
        current.copyWith(
          page: page,
          query: query,
          isSearching: false,
          clearSearchError: true,
          recentSearches: recent,
        ),
      );
    } catch (error) {
      if (generation != _searchGeneration) return;
      final current = state.asData?.value;
      if (current == null) return;
      state = AsyncData(
        current.copyWith(isSearching: false, searchError: error),
      );
    }
  }

  Future<List<String>> _rememberQuery(
    String query,
    List<String> previous,
  ) async {
    final trimmed = query.trim();
    if (trimmed.isEmpty) return previous;
    final next = <String>[
      trimmed,
      ...previous.where((item) => item.toLowerCase() != trimmed.toLowerCase()),
    ].take(8).toList(growable: false);
    await ref.read(findFriendsRecentSearchesStoreProvider).save(next);
    return next;
  }

  Future<void> _tryShareDiscoveryLocation() async {
    try {
      final coordinate = await ref
          .read(deviceLocationServiceProvider)
          .current();
      _lat = coordinate.latitude;
      _lng = coordinate.longitude;
      await ref
          .read(findFriendsRepositoryProvider)
          .updateDiscoveryLocation(lat: _lat!, lng: _lng!);
    } catch (_) {
      // Location denied/unavailable: search still works without nearby.
      _lat = null;
      _lng = null;
    }
  }

  FindFriendsPage _markRequestSent(
    FindFriendsPage page,
    String userId,
    String requestId,
  ) {
    return page.copyWith(
      results: [
        for (final user in page.results)
          if (user.id == userId)
            user.copyWith(
              action: FindFriendsAction.requestSent,
              friendRequestId: requestId,
            )
          else
            user,
      ],
      nearbySuggestions: [
        for (final item in page.nearbySuggestions)
          if (item.id == userId)
            item.copyWith(
              action: FindFriendsAction.requestSent,
              friendRequestId: requestId,
            )
          else
            item,
      ],
    );
  }

  FindFriendsPage _markRequestCancelled(FindFriendsPage page, String userId) {
    return page.copyWith(
      results: [
        for (final user in page.results)
          if (user.id == userId)
            user.copyWith(
              action: findFriendsFallbackAfterCancel(user),
              friendRequestId: null,
            )
          else
            user,
      ],
      nearbySuggestions: [
        for (final item in page.nearbySuggestions)
          if (item.id == userId)
            item.copyWith(
              action: FindFriendsAction.addFriend,
              friendRequestId: null,
            )
          else
            item,
      ],
    );
  }

  FindFriendsPage _markFollowed(FindFriendsPage page, String userId) {
    return page.copyWith(
      results: [
        for (final user in page.results)
          if (user.id == userId)
            user.copyWith(action: FindFriendsAction.following)
          else
            user,
      ],
      nearbySuggestions: [
        for (final item in page.nearbySuggestions)
          if (item.id == userId)
            item.copyWith(action: FindFriendsAction.following)
          else
            item,
      ],
    );
  }

  FindFriendsPage _markUnfollowed(FindFriendsPage page, String userId) {
    return page.copyWith(
      results: [
        for (final user in page.results)
          if (user.id == userId)
            user.copyWith(action: findFriendsFallbackAfterUnfollow(user))
          else
            user,
      ],
      nearbySuggestions: [
        for (final item in page.nearbySuggestions)
          if (item.id == userId)
            item.copyWith(action: FindFriendsAction.addFriend)
          else
            item,
      ],
    );
  }

  FindFriendsPage _withConversationId(
    FindFriendsPage page,
    String friendId,
    String conversationId,
  ) {
    return page.copyWith(
      results: [
        for (final user in page.results)
          if (user.id == friendId)
            user.copyWith(conversationId: conversationId)
          else
            user,
      ],
    );
  }
}
