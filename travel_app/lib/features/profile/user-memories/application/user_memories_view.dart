import '../data/models/user_memories_models.dart';

enum UserMemoriesLayout { bento, grid }

const _keep = Object();

class UserMemoriesFilterState {
  const UserMemoriesFilterState({
    this.tripId,
    this.query = '',
    this.submittedQuery = '',
    this.layout = UserMemoriesLayout.bento,
    this.searchOpen = false,
  });

  /// Null selects every photo. Otherwise the chip's trip.
  final String? tripId;
  final String query;
  final String submittedQuery;
  final UserMemoriesLayout layout;
  final bool searchOpen;

  UserMemoriesFilterState copyWith({
    Object? tripId = _keep,
    String? query,
    String? submittedQuery,
    UserMemoriesLayout? layout,
    bool? searchOpen,
  }) {
    return UserMemoriesFilterState(
      tripId: identical(tripId, _keep) ? this.tripId : tripId as String?,
      query: query ?? this.query,
      submittedQuery: submittedQuery ?? this.submittedQuery,
      layout: layout ?? this.layout,
      searchOpen: searchOpen ?? this.searchOpen,
    );
  }
}

class UserMemoriesState {
  const UserMemoriesState({
    required this.items,
    required this.collections,
    this.highlight,
    required this.totalCount,
    this.nextCursor,
    required this.hasMore,
    this.loadingMore = false,
    this.loadMoreError,
  });

  final List<UserMemoryPhoto> items;
  final List<UserMemoryCollection> collections;
  final UserMemoryPhoto? highlight;
  final int totalCount;
  final String? nextCursor;
  final bool hasMore;
  final bool loadingMore;
  final Object? loadMoreError;

  int get allPhotoCount => collections.fold<int>(
    0,
    (sum, collection) => sum + collection.memoryCount,
  );

  factory UserMemoriesState.fromPage(UserMemoriesPage page) {
    return UserMemoriesState(
      items: page.items,
      collections: page.collections ?? const [],
      highlight: page.highlight,
      totalCount: page.meta.totalCount ?? 0,
      nextCursor: page.meta.nextCursor,
      hasMore: page.meta.hasMore,
    );
  }

  UserMemoriesState copyWith({
    List<UserMemoryPhoto>? items,
    List<UserMemoryCollection>? collections,
    Object? highlight = _keep,
    int? totalCount,
    Object? nextCursor = _keep,
    bool? hasMore,
    bool? loadingMore,
    Object? loadMoreError = _keep,
  }) {
    return UserMemoriesState(
      items: items ?? this.items,
      collections: collections ?? this.collections,
      highlight: identical(highlight, _keep)
          ? this.highlight
          : highlight as UserMemoryPhoto?,
      totalCount: totalCount ?? this.totalCount,
      nextCursor: identical(nextCursor, _keep)
          ? this.nextCursor
          : nextCursor as String?,
      hasMore: hasMore ?? this.hasMore,
      loadingMore: loadingMore ?? this.loadingMore,
      loadMoreError: identical(loadMoreError, _keep)
          ? this.loadMoreError
          : loadMoreError,
    );
  }

  UserMemoriesState applyLike(String id, UserMemoryLike like) {
    final currentHighlight = highlight;
    return copyWith(
      highlight: currentHighlight != null && currentHighlight.id == id
          ? currentHighlight.copyWith(
              likeCount: like.likeCount,
              liked: like.liked,
            )
          : currentHighlight,
      items: [
        for (final item in items)
          if (item.id == id)
            item.copyWith(likeCount: like.likeCount, liked: like.liked)
          else
            item,
      ],
    );
  }
}

String userMemoriesSubtitle(UserMemoriesState gallery) {
  return '${gallery.totalCount} kỷ niệm';
}

String userMemoryDateLabel(DateTime createdAt) {
  final local = createdAt.toLocal();
  final day = local.day.toString().padLeft(2, '0');
  final month = local.month.toString().padLeft(2, '0');
  return '$day/$month/${local.year}';
}

String userMemoryTitle(UserMemoryPhoto photo) {
  final caption = photo.caption?.trim();
  if (caption != null && caption.isNotEmpty) return caption;
  return photo.tripName;
}

List<UserMemoryCollection> filterMemoryCollections(
  List<UserMemoryCollection> collections,
  String query,
) {
  final needle = query.trim().toLowerCase();
  if (needle.isEmpty) return collections;
  return [
    for (final collection in collections)
      if (collection.name.toLowerCase().contains(needle)) collection,
  ];
}
