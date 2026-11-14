import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_frontend_v1/features/trips/application/device_location_controller.dart';
import 'package:travel_frontend_v1/features/trips/trip-invitation/data/models/trip_join_request_models.dart';
import 'package:travel_frontend_v1/features/trips/trip-invitation/provider/trip_join_requests_provider.dart';

import '../data/datasources/social_feed_datasource.dart';
import '../data/models/social_feed_models.dart';
import '../data/models/social_post_comment.dart';
import '../provider/social_feed_provider.dart';
import 'social_feed_view.dart';

final socialFeedControllerProvider =
    AsyncNotifierProvider<SocialFeedController, SocialFeedViewState>(
      SocialFeedController.new,
    );

class SocialFeedController extends AsyncNotifier<SocialFeedViewState> {
  @override
  Future<SocialFeedViewState> build() async {
    final feed = await ref
        .watch(socialFeedRepositoryProvider)
        .getFeed(const SocialFeedQuery());
    final initialTab = feed.tabs
        .where((tab) => tab.selected)
        .map((tab) => tab.id)
        .firstOrNull;
    return SocialFeedViewState(
      feed: feed,
      selectedTabId: initialTab ?? 'explore',
    );
  }

  Future<bool> refresh() async {
    final previous = state.asData?.value;
    final tab = previous?.selectedTabId ?? 'explore';
    final coords = await _coordsForTab(tab, previous);
    return _load(
      tab: tab,
      topic: previous?.selectedTopicId,
      lat: coords.$1,
      lng: coords.$2,
      keepPreviousOnError: previous,
      showLoading: true,
    );
  }

  Future<void> selectTab(String tabId) async {
    final current = state.asData?.value;
    if (current == null || current.selectedTabId == tabId) return;

    final coords = await _coordsForTab(tabId, current);
    if (tabId == 'nearby' && (coords.$1 == null || coords.$2 == null)) {
      state = AsyncData(
        current.copyWith(selectedTabId: tabId, clearNearby: true),
      );
      return;
    }

    await _load(
      tab: tabId,
      topic: current.selectedTopicId,
      lat: coords.$1,
      lng: coords.$2,
      keepPreviousOnError: current,
      showLoading: true,
    );
  }

  Future<void> selectTopic(String topicId) async {
    final current = state.asData?.value;
    if (current == null) return;

    final nextTopic = current.selectedTopicId == topicId ? null : topicId;
    await _load(
      tab: current.selectedTabId,
      topic: nextTopic,
      lat: current.nearbyLat,
      lng: current.nearbyLng,
      keepPreviousOnError: current,
      showLoading: true,
    );
  }

  Future<void> loadMore() async {
    final current = state.asData?.value;
    if (current == null || current.isLoadingMore || !current.hasNextPage) {
      return;
    }

    state = AsyncData(
      current.copyWith(isLoadingMore: true, clearLoadMoreError: true),
    );

    try {
      final nextPage = current.currentPage + 1;
      final page = await ref
          .read(socialFeedRepositoryProvider)
          .getFeed(
            SocialFeedQuery(
              tab: current.selectedTabId,
              topic: current.selectedTopicId,
              page: nextPage,
              lat: current.nearbyLat,
              lng: current.nearbyLng,
            ),
          );

      final existingIds = current.feed.items.map((item) => item.id).toSet();
      final appended = [
        ...current.feed.items,
        ...page.items.where((item) => !existingIds.contains(item.id)),
      ];

      state = AsyncData(
        current.copyWith(
          feed: current.feed.copyWith(items: appended, meta: page.meta),
          isLoadingMore: false,
          clearLoadMoreError: true,
        ),
      );
    } catch (error) {
      state = AsyncData(
        current.copyWith(isLoadingMore: false, loadMoreError: error),
      );
    }
  }

  Future<bool> sharePost(String postId) async {
    if (!_isRealPostId(postId)) return false;
    try {
      await ref.read(socialFeedRepositoryProvider).sharePost(postId);
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<SocialPostCommentsPage> getComments({
    required String postId,
    int page = 1,
  }) {
    return ref
        .read(socialFeedRepositoryProvider)
        .getComments(postId: postId, page: page);
  }

  Future<SocialPostComment?> createComment({
    required String postId,
    required String content,
  }) async {
    if (!_isRealPostId(postId)) return null;
    final trimmed = content.trim();
    if (trimmed.isEmpty) return null;

    final comment = await ref
        .read(socialFeedRepositoryProvider)
        .createComment(postId: postId, content: trimmed);

    final current = state.asData?.value;
    if (current != null) {
      state = AsyncData(
        current.copyWith(
          feed: current.feed.copyWith(
            items: [
              for (final item in current.feed.items)
                if (item.type == SocialFeedItemType.review &&
                    item.review?.postId == postId)
                  item.copyWith(
                    review: item.review!.copyWith(
                      commentsCount: item.review!.commentsCount + 1,
                      previewComment: SocialFeedPreviewComment(
                        id: comment.id,
                        authorName: comment.authorName,
                        text: comment.content,
                        timeLabel: 'Vừa xong',
                      ),
                    ),
                  )
                else
                  item,
            ],
          ),
        ),
      );
    }
    return comment;
  }

  Future<bool> createPost({
    required String caption,
    required List<String> mediaIds,
    String? tipTitle,
    String? tipBody,
    String? topic,
    String? placeDetail,
  }) async {
    final trimmed = caption.trim();
    if (trimmed.isEmpty || mediaIds.isEmpty) return false;
    await ref
        .read(socialFeedRepositoryProvider)
        .createPost(
          caption: trimmed,
          mediaIds: mediaIds,
          tipTitle: tipTitle?.trim(),
          tipBody: tipBody?.trim(),
          topic: topic,
          placeDetail: placeDetail?.trim(),
        );
    await refresh();
    return true;
  }

  Future<bool> createStory({
    required String mediaId,
    required String label,
    bool isLive = false,
  }) async {
    final trimmed = label.trim();
    if (mediaId.isEmpty || trimmed.isEmpty) return false;
    await ref
        .read(socialFeedRepositoryProvider)
        .createStory(mediaId: mediaId, label: trimmed, isLive: isLive);
    await refresh();
    return true;
  }

  Future<TripJoinRequest> joinTrip(String tripId) {
    return ref
        .read(tripJoinRequestsRepositoryProvider)
        .requestToJoinByTripId(tripId);
  }

  Future<bool> joinChallenge(String challengeId) async {
    final current = state.asData?.value;
    if (current == null) return false;

    try {
      final updated = await ref
          .read(socialFeedRepositoryProvider)
          .joinChallenge(challengeId);
      state = AsyncData(
        current.copyWith(
          feed: current.feed.copyWith(
            items: [
              for (final item in current.feed.items)
                if (item.type == SocialFeedItemType.challenge &&
                    item.challenge?.id == challengeId)
                  item.copyWith(challenge: updated)
                else
                  item,
            ],
          ),
        ),
      );
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<bool> _load({
    required String tab,
    String? topic,
    double? lat,
    double? lng,
    SocialFeedViewState? keepPreviousOnError,
    bool showLoading = false,
  }) async {
    if (showLoading) {
      state = const AsyncLoading<SocialFeedViewState>();
    }
    state = await AsyncValue.guard(() async {
      final feed = await ref
          .read(socialFeedRepositoryProvider)
          .getFeed(SocialFeedQuery(tab: tab, topic: topic, lat: lat, lng: lng));
      return SocialFeedViewState(
        feed: feed,
        selectedTabId: tab,
        selectedTopicId: topic,
        nearbyLat: tab == 'nearby' ? lat : null,
        nearbyLng: tab == 'nearby' ? lng : null,
      );
    });
    if (state.hasError && keepPreviousOnError != null) {
      state = AsyncData(keepPreviousOnError);
      return false;
    }
    return !state.hasError;
  }

  Future<(double?, double?)> _coordsForTab(
    String tabId,
    SocialFeedViewState? previous,
  ) async {
    if (tabId != 'nearby') return (null, null);
    if (previous?.nearbyLat != null && previous?.nearbyLng != null) {
      return (previous!.nearbyLat, previous.nearbyLng);
    }
    var location = ref.read(deviceLocationControllerProvider).asData?.value;
    if (location == null) {
      await ref.read(deviceLocationControllerProvider.notifier).locate();
      location = ref.read(deviceLocationControllerProvider).asData?.value;
    }
    return (location?.latitude, location?.longitude);
  }

  Future<void> toggleLike(String postId) async {
    if (!_isRealPostId(postId)) return;

    final current = state.asData?.value;
    if (current == null) return;

    final updatedItems = <SocialFeedItem>[];
    var nextLiked = false;
    var found = false;

    for (final item in current.feed.items) {
      if (item.type == SocialFeedItemType.review &&
          item.review?.postId == postId) {
        found = true;
        final review = item.review!;
        nextLiked = !review.liked;
        final likes = review.likesCount + (nextLiked ? 1 : -1);
        updatedItems.add(
          item.copyWith(
            review: review.copyWith(
              liked: nextLiked,
              likesCount: likes < 0 ? 0 : likes,
            ),
          ),
        );
        continue;
      }
      updatedItems.add(item);
    }

    if (!found) return;

    state = AsyncData(
      current.copyWith(feed: current.feed.copyWith(items: updatedItems)),
    );

    try {
      final repo = ref.read(socialFeedRepositoryProvider);
      if (nextLiked) {
        await repo.likePost(postId);
      } else {
        await repo.unlikePost(postId);
      }
    } catch (_) {
      state = AsyncData(current);
    }
  }

  Future<void> toggleBookmark(String postId) async {
    if (!_isRealPostId(postId)) return;

    final current = state.asData?.value;
    if (current == null) return;

    final updatedItems = <SocialFeedItem>[];
    var nextSaved = false;
    var found = false;

    for (final item in current.feed.items) {
      if (item.type == SocialFeedItemType.review &&
          item.review?.postId == postId) {
        found = true;
        final review = item.review!;
        nextSaved = !review.bookmarked;
        final saves = review.savesCount + (nextSaved ? 1 : -1);
        updatedItems.add(
          item.copyWith(
            review: review.copyWith(
              bookmarked: nextSaved,
              savesCount: saves < 0 ? 0 : saves,
            ),
          ),
        );
        continue;
      }
      updatedItems.add(item);
    }

    if (!found) return;

    state = AsyncData(
      current.copyWith(feed: current.feed.copyWith(items: updatedItems)),
    );

    try {
      final repo = ref.read(socialFeedRepositoryProvider);
      if (nextSaved) {
        await repo.savePost(postId);
      } else {
        await repo.unsavePost(postId);
      }
    } catch (_) {
      state = AsyncData(current);
    }
  }

  bool _isRealPostId(String postId) =>
      postId.isNotEmpty && !postId.startsWith('trip-recruit-');
}
