import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/chats_hub_provider.dart';
import 'chats_hub_view.dart';

final chatsHubControllerProvider =
    AsyncNotifierProvider<ChatsHubController, ChatsHubViewState>(
      ChatsHubController.new,
    );

class ChatsHubController extends AsyncNotifier<ChatsHubViewState> {
  @override
  Future<ChatsHubViewState> build() async {
    final hub = await ref.watch(chatsHubRepositoryProvider).getHub();
    return ChatsHubViewState(hub: hub);
  }

  Future<bool> refresh() async {
    final previous = state.asData?.value;
    state = const AsyncLoading<ChatsHubViewState>();
    state = await AsyncValue.guard(() async {
      final hub = await ref.read(chatsHubRepositoryProvider).getHub();
      return ChatsHubViewState(
        hub: hub,
        filter: previous?.filter ?? ChatsHubFilter.trips,
        searchQuery: previous?.searchQuery ?? '',
      );
    });
    if (state.hasError && previous != null) {
      state = AsyncData(previous);
      return false;
    }
    return !state.hasError;
  }

  void selectFilter(ChatsHubFilter filter) {
    final current = state.asData?.value;
    if (current == null || current.filter == filter) return;
    state = AsyncData(current.copyWith(filter: filter));
  }

  void setSearchQuery(String query) {
    final current = state.asData?.value;
    if (current == null || current.searchQuery == query) return;
    state = AsyncData(current.copyWith(searchQuery: query));
  }
}
