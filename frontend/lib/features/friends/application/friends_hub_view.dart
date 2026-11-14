import 'package:travel_frontend_v1/core/networks/api_exception.dart';

import '../data/models/friends_hub_models.dart';

class FriendsHubViewState {
  const FriendsHubViewState({
    required this.page,
    this.tab = FriendsHubTab.friends,
    this.sort = FriendsHubSort.recent,
    this.query = '',
    this.busyRequestId,
    this.busyFriendId,
    this.actionError,
  });

  final FriendsHubPage page;
  final FriendsHubTab tab;
  final FriendsHubSort sort;
  final String query;
  final String? busyRequestId;
  final String? busyFriendId;
  final Object? actionError;

  int get friendsCount => page.friendsCount;

  int get receivedCount => page.received.length;

  int get sentCount => page.sent.length;

  List<FriendsHubRequest> get receivedPreview =>
      page.received.take(2).toList(growable: false);

  List<FriendsHubRequest> get filteredReceived {
    final q = query.trim().toLowerCase();
    if (q.isEmpty) return page.received;
    return page.received
        .where((item) => _matchesUser(item.user, q))
        .toList(growable: false);
  }

  List<FriendsHubRequest> get filteredSent {
    final q = query.trim().toLowerCase();
    if (q.isEmpty) return page.sent;
    return page.sent
        .where((item) => _matchesUser(item.user, q))
        .toList(growable: false);
  }

  List<FriendsHubFriend> get filteredFriends {
    final q = query.trim().toLowerCase();
    var list = page.friends;
    if (q.isNotEmpty) {
      list = list
          .where((item) => _matchesUser(item.user, q))
          .toList(growable: false);
    }
    return switch (sort) {
      FriendsHubSort.recent => [
        ...list,
      ]..sort((a, b) => b.createdAt.compareTo(a.createdAt)),
      FriendsHubSort.az =>
        [...list]..sort(
          (a, b) => a.user.displayName.toLowerCase().compareTo(
            b.user.displayName.toLowerCase(),
          ),
        ),
      FriendsHubSort.online => [
        ...list.where((item) => item.user.isOnline),
        ...list.where((item) => !item.user.isOnline),
      ],
    };
  }

  FriendsHubViewState copyWith({
    FriendsHubPage? page,
    FriendsHubTab? tab,
    FriendsHubSort? sort,
    String? query,
    String? busyRequestId,
    bool clearBusyRequest = false,
    String? busyFriendId,
    bool clearBusyFriend = false,
    Object? actionError,
    bool clearActionError = false,
  }) => FriendsHubViewState(
    page: page ?? this.page,
    tab: tab ?? this.tab,
    sort: sort ?? this.sort,
    query: query ?? this.query,
    busyRequestId: clearBusyRequest
        ? null
        : busyRequestId ?? this.busyRequestId,
    busyFriendId: clearBusyFriend ? null : busyFriendId ?? this.busyFriendId,
    actionError: clearActionError ? null : actionError ?? this.actionError,
  );

  static bool _matchesUser(FriendsHubUser user, String q) {
    final haystack = [
      user.displayName,
      user.username,
      user.subtitle ?? '',
      user.metaLine ?? '',
      user.badgeLabel ?? '',
    ].join(' ').toLowerCase();
    return haystack.contains(q);
  }
}

String friendsHubRelativeTime(DateTime createdAt, {DateTime? now}) {
  final current = now ?? DateTime.now();
  final local = createdAt.toLocal();
  final diff = current.difference(local);
  if (diff.inMinutes < 1) return 'Vừa xong';
  if (diff.inMinutes < 60) return '${diff.inMinutes} phút trước';
  if (diff.inHours < 24) return '${diff.inHours} giờ trước';
  if (diff.inDays == 1) return 'Hôm qua';
  if (diff.inDays < 7) return '${diff.inDays} ngày trước';
  return '${local.day}/${local.month}/${local.year}';
}

String friendsHubFailureMessage(Object error) {
  if (error is ApiException && error.statusCode == 401) {
    return 'Phiên đăng nhập đã hết hạn';
  }
  if (error is ApiException && error.message.trim().isNotEmpty) {
    return error.message.trim();
  }
  return 'Đã xảy ra lỗi. Vui lòng thử lại.';
}

bool friendsHubFailureIsUnauthorized(Object error) =>
    error is ApiException && error.statusCode == 401;
