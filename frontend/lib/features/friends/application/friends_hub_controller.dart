import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/friends_hub_models.dart';
import '../data/repositories/friends_hub_repository.dart';
import '../provider/friends_hub_provider.dart';
import 'friends_hub_view.dart';

/// No automatic retry: 401 never recovers; screen retries manually.
final friendsHubControllerProvider =
    AsyncNotifierProvider.autoDispose<
      FriendsHubController,
      FriendsHubViewState
    >(FriendsHubController.new, retry: (_, _) => null);

class FriendsHubController extends AsyncNotifier<FriendsHubViewState> {
  @override
  Future<FriendsHubViewState> build() => _load();

  Future<bool> refresh() async {
    final previous = state.asData?.value;
    // Soft refresh: keep current data visible; only first load uses skeleton.
    if (previous == null) {
      state = const AsyncLoading<FriendsHubViewState>();
    }
    state = await AsyncValue.guard(_load);
    if (state.hasError && previous != null) {
      state = AsyncData(previous);
      return false;
    }
    return !state.hasError;
  }

  void setTab(FriendsHubTab tab) {
    final current = state.asData?.value;
    if (current == null || current.tab == tab) return;
    state = AsyncData(current.copyWith(tab: tab, clearActionError: true));
  }

  void setSort(FriendsHubSort sort) {
    final current = state.asData?.value;
    if (current == null || current.sort == sort) return;
    state = AsyncData(current.copyWith(sort: sort));
  }

  void setQuery(String raw) {
    final current = state.asData?.value;
    if (current == null) return;
    state = AsyncData(current.copyWith(query: raw));
  }

  Future<bool> acceptRequest(String requestId) =>
      _mutateRequest(requestId, (repo) => repo.acceptRequest(requestId));

  Future<bool> rejectRequest(String requestId) =>
      _mutateRequest(requestId, (repo) => repo.rejectRequest(requestId));

  Future<bool> cancelRequest(String requestId) =>
      _mutateRequest(requestId, (repo) => repo.cancelRequest(requestId));

  Future<bool> removeFriend(String friendId) async {
    final current = state.asData?.value;
    if (current == null || current.busyFriendId != null) return false;

    state = AsyncData(
      current.copyWith(busyFriendId: friendId, clearActionError: true),
    );
    try {
      await ref.read(friendsHubRepositoryProvider).removeFriend(friendId);
      final latest = state.asData?.value ?? current;
      final nextFriends = latest.page.friends
          .where((item) => item.friendId != friendId)
          .toList(growable: false);
      state = AsyncData(
        latest.copyWith(
          page: latest.page.copyWith(
            friends: nextFriends,
            friendsCount: nextFriends.length,
            friendsCountLabel: '${nextFriends.length} bạn bè đồng hành',
          ),
          clearBusyFriend: true,
          clearActionError: true,
        ),
      );
      return true;
    } catch (error) {
      final latest = state.asData?.value ?? current;
      state = AsyncData(
        latest.copyWith(clearBusyFriend: true, actionError: error),
      );
      return false;
    }
  }

  Future<String?> openConversation(String friendId) async {
    final current = state.asData?.value;
    if (current == null || current.busyFriendId != null) return null;

    state = AsyncData(
      current.copyWith(busyFriendId: friendId, clearActionError: true),
    );
    try {
      final conversationId = await ref
          .read(friendsHubRepositoryProvider)
          .getOrCreateConversation(friendId);
      final latest = state.asData?.value ?? current;
      final nextFriends = latest.page.friends
          .map(
            (item) => item.friendId == friendId
                ? item.copyWith(conversationId: conversationId)
                : item,
          )
          .toList(growable: false);
      state = AsyncData(
        latest.copyWith(
          page: latest.page.copyWith(friends: nextFriends),
          clearBusyFriend: true,
          clearActionError: true,
        ),
      );
      return conversationId;
    } catch (error) {
      final latest = state.asData?.value ?? current;
      state = AsyncData(
        latest.copyWith(clearBusyFriend: true, actionError: error),
      );
      return null;
    }
  }

  Future<FriendsHubViewState> _load() async {
    final previous = state.asData?.value;
    final page = await ref.read(friendsHubRepositoryProvider).getHub();
    return FriendsHubViewState(
      page: page,
      tab: previous?.tab ?? FriendsHubTab.friends,
      sort: previous?.sort ?? FriendsHubSort.recent,
      query: previous?.query ?? '',
    );
  }

  Future<bool> _mutateRequest(
    String requestId,
    Future<void> Function(FriendsHubRepository repo) action,
  ) async {
    final current = state.asData?.value;
    if (current == null || current.busyRequestId != null) return false;

    state = AsyncData(
      current.copyWith(busyRequestId: requestId, clearActionError: true),
    );
    try {
      await action(ref.read(friendsHubRepositoryProvider));
      final refreshed = await ref.read(friendsHubRepositoryProvider).getHub();
      final latest = state.asData?.value ?? current;
      state = AsyncData(
        latest.copyWith(
          page: refreshed,
          clearBusyRequest: true,
          clearActionError: true,
        ),
      );
      return true;
    } catch (error) {
      final latest = state.asData?.value ?? current;
      state = AsyncData(
        latest.copyWith(clearBusyRequest: true, actionError: error),
      );
      return false;
    }
  }
}
