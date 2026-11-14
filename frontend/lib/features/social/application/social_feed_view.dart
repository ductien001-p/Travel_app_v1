import '../data/models/social_feed_models.dart';

class SocialFeedViewState {
  const SocialFeedViewState({
    required this.feed,
    this.selectedTabId = 'explore',
    this.selectedTopicId,
    this.nearbyLat,
    this.nearbyLng,
    this.isLoadingMore = false,
    this.loadMoreError,
  });

  final SocialFeed feed;
  final String selectedTabId;
  final String? selectedTopicId;
  final double? nearbyLat;
  final double? nearbyLng;
  final bool isLoadingMore;
  final Object? loadMoreError;

  List<SocialFeedTab> get tabs => [
    for (final tab in feed.tabs)
      tab.copyWith(selected: tab.id == selectedTabId),
  ];

  List<SocialFeedTopicChip> get topicChips => [
    for (final chip in feed.topicChips)
      chip.copyWith(selected: chip.id == selectedTopicId),
  ];

  bool get isEmpty => feed.items.isEmpty;

  bool get hasNextPage => feed.meta?.hasNextPage ?? false;

  int get currentPage => feed.meta?.page ?? 1;

  SocialFeedViewState copyWith({
    SocialFeed? feed,
    String? selectedTabId,
    String? selectedTopicId,
    bool clearTopic = false,
    double? nearbyLat,
    double? nearbyLng,
    bool clearNearby = false,
    bool? isLoadingMore,
    Object? loadMoreError,
    bool clearLoadMoreError = false,
  }) => SocialFeedViewState(
    feed: feed ?? this.feed,
    selectedTabId: selectedTabId ?? this.selectedTabId,
    selectedTopicId: clearTopic
        ? null
        : (selectedTopicId ?? this.selectedTopicId),
    nearbyLat: clearNearby ? null : (nearbyLat ?? this.nearbyLat),
    nearbyLng: clearNearby ? null : (nearbyLng ?? this.nearbyLng),
    isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    loadMoreError: clearLoadMoreError
        ? null
        : (loadMoreError ?? this.loadMoreError),
  );
}

String socialFeedFailureMessage(Object error) {
  final text = error.toString();
  if (text.toLowerCase().contains('401') ||
      text.toLowerCase().contains('unauthorized')) {
    return 'Phiên đăng nhập đã hết hạn. Đăng nhập lại để xem bảng tin.';
  }
  return 'Không tải được bảng tin. Thử lại sau.';
}

bool socialFeedFailureIsUnauthorized(Object error) {
  final text = error.toString().toLowerCase();
  return text.contains('401') || text.contains('unauthorized');
}
