import 'package:travel_frontend_v1/core/networks/api_exception.dart';

import '../data/models/find_friends_models.dart';

class FindFriendsViewState {
  const FindFriendsViewState({
    required this.page,
    this.query = '',
    this.isSearching = false,
    this.searchError,
    this.busyUserId,
    this.actionError,
    this.recentSearches = const <String>[],
  });

  final FindFriendsPage page;
  final String query;
  final bool isSearching;
  final Object? searchError;
  final String? busyUserId;
  final Object? actionError;
  final List<String> recentSearches;

  List<FindFriendsUser> get results => page.results;

  List<FindFriendsNearbySuggestion> get nearbySuggestions =>
      page.nearbySuggestions;

  FindFriendsDnaBanner get dnaBanner => page.dnaBanner;

  String get matchCountLabel => page.matchCountLabel;

  bool get hasQuery => query.trim().isNotEmpty;

  FindFriendsViewState copyWith({
    FindFriendsPage? page,
    String? query,
    bool? isSearching,
    Object? searchError,
    bool clearSearchError = false,
    String? busyUserId,
    bool clearBusyUser = false,
    Object? actionError,
    bool clearActionError = false,
    List<String>? recentSearches,
  }) => FindFriendsViewState(
    page: page ?? this.page,
    query: query ?? this.query,
    isSearching: isSearching ?? this.isSearching,
    searchError: clearSearchError ? null : searchError ?? this.searchError,
    busyUserId: clearBusyUser ? null : busyUserId ?? this.busyUserId,
    actionError: clearActionError ? null : actionError ?? this.actionError,
    recentSearches: recentSearches ?? this.recentSearches,
  );
}

String findFriendsActionLabel(FindFriendsAction action) => switch (action) {
  FindFriendsAction.addFriend => 'Kết bạn',
  FindFriendsAction.requestSent => 'Hủy yêu cầu',
  FindFriendsAction.message => 'Nhắn tin',
  FindFriendsAction.follow => 'Theo dõi',
  FindFriendsAction.following => 'Đang theo dõi',
};

FindFriendsAction findFriendsFallbackAfterCancel(FindFriendsUser user) =>
    FindFriendsAction.addFriend;

FindFriendsAction findFriendsFallbackAfterUnfollow(FindFriendsUser user) =>
    FindFriendsAction.addFriend;

String findFriendsFailureMessage(Object error) {
  if (error is ApiException && error.statusCode == 401) {
    return 'Phiên đăng nhập đã hết hạn';
  }
  if (error is ApiException && error.message.trim().isNotEmpty) {
    return error.message.trim();
  }
  return 'Đã xảy ra lỗi. Vui lòng thử lại.';
}

bool findFriendsFailureIsUnauthorized(Object error) =>
    error is ApiException && error.statusCode == 401;
