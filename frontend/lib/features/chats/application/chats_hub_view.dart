import '../data/models/chats_hub_models.dart';

enum ChatsHubFilter { all, trips, friends, unread }

class ChatsHubViewState {
  const ChatsHubViewState({
    required this.hub,
    this.filter = ChatsHubFilter.trips,
    this.searchQuery = '',
  });

  final ChatsHub hub;
  final ChatsHubFilter filter;
  final String searchQuery;

  List<ChatsTripThread> get visibleTripThreads {
    if (filter == ChatsHubFilter.friends) return const [];
    return hub.tripThreads.where(_matchesTrip).toList(growable: false);
  }

  List<ChatsFriendThread> get visibleFriendThreads {
    if (filter == ChatsHubFilter.trips) return const [];
    return hub.friendThreads.where(_matchesFriend).toList(growable: false);
  }

  bool get showActivePulse {
    if (hub.activeTripPulse == null) return false;
    if (filter == ChatsHubFilter.friends) return false;
    if (filter == ChatsHubFilter.unread) {
      return hub.activeTripPulse!.newExchangeCount > 0;
    }
    final query = searchQuery.trim().toLowerCase();
    if (query.isEmpty) return true;
    final pulse = hub.activeTripPulse!;
    return pulse.title.toLowerCase().contains(query) ||
        pulse.pinnedMessage.toLowerCase().contains(query) ||
        pulse.pinnedSenderName.toLowerCase().contains(query);
  }

  bool get isEmpty =>
      !showActivePulse &&
      visibleTripThreads.isEmpty &&
      visibleFriendThreads.isEmpty;

  ChatsHubViewState copyWith({
    ChatsHub? hub,
    ChatsHubFilter? filter,
    String? searchQuery,
  }) => ChatsHubViewState(
    hub: hub ?? this.hub,
    filter: filter ?? this.filter,
    searchQuery: searchQuery ?? this.searchQuery,
  );

  bool _matchesTrip(ChatsTripThread thread) {
    if (filter == ChatsHubFilter.unread && thread.unreadCount <= 0) {
      return false;
    }
    final query = searchQuery.trim().toLowerCase();
    if (query.isEmpty) return true;
    return thread.title.toLowerCase().contains(query) ||
        thread.lastSenderName.toLowerCase().contains(query) ||
        thread.lastMessage.toLowerCase().contains(query);
  }

  bool _matchesFriend(ChatsFriendThread thread) {
    if (filter == ChatsHubFilter.unread && thread.unreadCount <= 0) {
      return false;
    }
    final query = searchQuery.trim().toLowerCase();
    if (query.isEmpty) return true;
    return thread.displayName.toLowerCase().contains(query) ||
        thread.lastMessage.toLowerCase().contains(query) ||
        (thread.roleBadge?.toLowerCase().contains(query) ?? false);
  }
}

String chatsTripStatusLabel(ChatsTripThreadStatus status) => switch (status) {
  ChatsTripThreadStatus.upcoming => 'Sắp tới',
  ChatsTripThreadStatus.ongoing => 'Đang diễn ra',
  ChatsTripThreadStatus.completed => 'Đã hoàn thành',
};

String chatsHubFailureMessage(Object error) {
  final text = error.toString();
  if (text.toLowerCase().contains('401') ||
      text.toLowerCase().contains('unauthorized')) {
    return 'Phiên đăng nhập đã hết hạn. Đăng nhập lại để xem tin nhắn.';
  }
  return 'Không tải được hộp thư. Thử lại sau.';
}

bool chatsHubFailureIsUnauthorized(Object error) {
  final text = error.toString().toLowerCase();
  return text.contains('401') || text.contains('unauthorized');
}
