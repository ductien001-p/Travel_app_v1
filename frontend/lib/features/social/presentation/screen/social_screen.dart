import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_frontend_v1/app/router/router_names.dart';
import 'package:travel_frontend_v1/core/testing/e2e_keys.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_gradients.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/widget/app_error_view.dart';
import 'package:travel_frontend_v1/core/widget/app_skeleton.dart';

import 'package:travel_frontend_v1/features/home/application/home_failure_message.dart';
import 'package:travel_frontend_v1/features/profile/application/profile_controller.dart';
import 'package:travel_frontend_v1/features/public-images/utils/public_image_navigation.dart';
import 'package:travel_frontend_v1/features/public-images/utils/public_image_social_mapper.dart';
import 'package:travel_frontend_v1/features/trips/trip-invitation/data/models/trip_join_request_models.dart';

import '../../application/social_feed_controller.dart';
import '../../application/social_feed_view.dart';
import '../../data/models/social_feed_models.dart';
import '../widgets/social_create_post_sheet.dart';
import '../widgets/social_create_story_sheet.dart';
import '../widgets/social_feed_body.dart';
import '../widgets/social_feed_header.dart';
import '../widgets/social_story_viewer.dart';

class SocialScreen extends ConsumerWidget {
  const SocialScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final feedState = ref.watch(socialFeedControllerProvider);

    return Scaffold(
      key: E2eKeys.navSocial,
      backgroundColor: Colors.transparent,
      body: DecoratedBox(
        decoration: const BoxDecoration(gradient: AppGradients.pageAtmosphere),
        child: SafeArea(
          child: Column(
            children: [
              if (feedState.hasValue)
                SocialFeedTopBar(
                  header: feedState.requireValue.feed.header,
                  onSearchTap: () => context.pushNamed(RouteNames.findFriends),
                  onNotificationsTap: () => _comingSoon(context),
                  onFriendsTap: () => context.pushNamed(RouteNames.friendsHub),
                )
              else
                const Padding(
                  padding: EdgeInsets.fromLTRB(
                    AppSpacing.screenHorizontal,
                    AppSpacing.sm,
                    AppSpacing.screenHorizontal,
                    AppSpacing.xs,
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: AppSkeleton(width: 140, height: 28, radius: 8),
                  ),
                ),
              Expanded(child: _body(context, ref, feedState)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _body(
    BuildContext context,
    WidgetRef ref,
    AsyncValue<SocialFeedViewState> feedState,
  ) {
    if (!feedState.hasValue && feedState.isLoading) {
      return const _Skeleton();
    }
    if (feedState.hasError && !feedState.hasValue) {
      final unauthorized = socialFeedFailureIsUnauthorized(feedState.error!);
      return AppErrorView(
        title: unauthorized
            ? 'Phiên đăng nhập đã hết hạn'
            : 'Không tải được bảng tin',
        message: socialFeedFailureMessage(feedState.error!),
        actionLabel: 'Thử lại',
        onRetry: unauthorized
            ? null
            : () => ref.read(socialFeedControllerProvider.notifier).refresh(),
      );
    }

    final view = feedState.requireValue;
    return RefreshIndicator(
      color: AppColors.primary,
      onRefresh: () async {
        await ref.read(socialFeedControllerProvider.notifier).refresh();
      },
      child: SocialFeedBody(
        view: view,
        onTabSelected: (tabId) {
          ref.read(socialFeedControllerProvider.notifier).selectTab(tabId);
        },
        onTopicSelected: (topicId) {
          ref.read(socialFeedControllerProvider.notifier).selectTopic(topicId);
        },
        onLike: (postId) =>
            ref.read(socialFeedControllerProvider.notifier).toggleLike(postId),
        onBookmark: (postId) => ref
            .read(socialFeedControllerProvider.notifier)
            .toggleBookmark(postId),
        onComment: (postId) {
          context.pushNamed(
            RouteNames.postDetail,
            pathParameters: {'postId': postId},
            queryParameters: const {'focus': 'comments'},
          );
        },
        onShare: (postId) => _share(context, ref, postId),
        onJoinChallenge: (challengeId) =>
            _joinChallenge(context, ref, challengeId),
        onLoadMore: () {
          ref.read(socialFeedControllerProvider.notifier).loadMore();
        },
        onCompose: () => _openCreatePost(context),
        onPhotoCompose: () => _openCreatePost(context),
        onCheckIn: () => _openCreatePost(
          context,
          hint: 'Check-in: gắn mẹo/địa điểm trong bài đăng của bạn.',
        ),
        onInvite: () => context.pushNamed(RouteNames.createTrip),
        onStoryTap: (story) => _onStoryTap(context, view, story),
        onSeeAllStories: () =>
            showSocialStoryViewer(context: context, stories: view.feed.stories),
        onOpenPost: (postId) {
          context.pushNamed(
            RouteNames.postDetail,
            pathParameters: {'postId': postId},
          );
        },
        onOpenReviewMedia: (post, mediaIndex) =>
            _openOtherUserMedia(context, ref, post, mediaIndex),
        onOpenPlace: (placeId) {
          context.pushNamed(
            RouteNames.placeDetail,
            pathParameters: {'placeId': placeId},
          );
        },
        onJoinTrip: (tripId) => _joinTrip(context, ref, tripId),
        onComingSoon: () => _comingSoon(context),
        onOpenTrip: (tripId) {
          context.pushNamed(
            RouteNames.tripDetail,
            pathParameters: {'tripId': tripId},
          );
        },
      ),
    );
  }

  Future<void> _openOtherUserMedia(
    BuildContext context,
    WidgetRef ref,
    SocialFeedReviewPost post,
    int mediaIndex,
  ) async {
    final meId = ref.read(profileControllerProvider).asData?.value.id;
    final isMine = meId != null && meId.isNotEmpty && meId == post.author.id;

    final album = publicImageAlbumFromSocialMedias(
      postId: post.postId,
      authorId: post.author.id,
      authorName: post.author.displayName,
      caption: post.caption,
      placeLabel: post.placeLabel,
      placeDetail: post.placeDetail,
      likesCount: post.likesCount,
      commentsCount: post.commentsCount,
      likedByMe: post.liked,
      medias: [
        for (final media in post.medias)
          (id: media.id, imageUrl: media.imageUrl, caption: media.caption),
      ],
    );

    // Bài của người khác (hoặc chưa biết me): mở fullscreen viewer.
    // Bài của mình: mở chi tiết bài như trước.
    if (isMine || album.images.isEmpty) {
      if (!context.mounted) return;
      context.pushNamed(
        RouteNames.postDetail,
        pathParameters: {'postId': post.postId},
      );
      return;
    }

    await openPublicImageViewer(
      context,
      ref,
      album: album,
      initialIndex: mediaIndex,
    );
  }

  Future<void> _joinTrip(
    BuildContext context,
    WidgetRef ref,
    String tripId,
  ) async {
    final messenger = ScaffoldMessenger.of(context);
    try {
      final request = await ref
          .read(socialFeedControllerProvider.notifier)
          .joinTrip(tripId);
      final approved = request.status == TripJoinRequestStatus.approved;
      messenger.showSnackBar(
        SnackBar(
          content: Text(
            approved
                ? 'Đã tham gia chuyến đi.'
                : 'Đã gửi yêu cầu tham gia chuyến đi.',
          ),
        ),
      );
      if (approved && context.mounted) {
        context.pushNamed(
          RouteNames.tripDetail,
          pathParameters: {'tripId': tripId},
        );
      }
    } catch (error) {
      messenger.showSnackBar(
        SnackBar(content: Text(homeFailureMessage(error))),
      );
    }
  }

  Future<void> _openCreatePost(BuildContext context, {String? hint}) async {
    final created = await showSocialCreatePostSheet(
      context: context,
      initialHint: hint,
    );
    if (!context.mounted || created != true) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Đã đăng bài lên bảng tin.')));
  }

  Future<void> _onStoryTap(
    BuildContext context,
    SocialFeedViewState view,
    SocialFeedStory story,
  ) async {
    // Self node always means "add story" (Stitch + badge).
    if (story.isSelf) {
      final created = await showSocialCreateStorySheet(
        context: context,
        defaultLabel: view.feed.composer.displayName,
      );
      if (!context.mounted || created != true) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Đã đăng story.')));
      return;
    }

    final hasImage = story.imageUrl != null && story.imageUrl!.isNotEmpty;
    if (!hasImage) {
      _comingSoon(context);
      return;
    }

    final index = view.feed.stories.indexWhere((item) => item.id == story.id);
    await showSocialStoryViewer(
      context: context,
      stories: view.feed.stories,
      initialIndex: index < 0 ? 0 : index,
    );
  }

  Future<void> _share(
    BuildContext context,
    WidgetRef ref,
    String postId,
  ) async {
    final ok = await ref
        .read(socialFeedControllerProvider.notifier)
        .sharePost(postId);
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          ok ? 'Đã chia sẻ bài viết.' : 'Không chia sẻ được. Thử lại.',
        ),
      ),
    );
  }

  Future<void> _joinChallenge(
    BuildContext context,
    WidgetRef ref,
    String challengeId,
  ) async {
    final ok = await ref
        .read(socialFeedControllerProvider.notifier)
        .joinChallenge(challengeId);
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          ok ? 'Đã tham gia thử thách.' : 'Không tham gia được. Thử lại.',
        ),
      ),
    );
  }

  void _comingSoon(BuildContext context) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Tính năng này sắp có.')));
  }
}

class _Skeleton extends StatelessWidget {
  const _Skeleton();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.screenHorizontal,
      ),
      children: const [
        SizedBox(height: AppSpacing.sm),
        AppSkeleton(width: double.infinity, height: 96, radius: 20),
        SizedBox(height: AppSpacing.md),
        AppSkeleton(width: double.infinity, height: 40, radius: 999),
        SizedBox(height: AppSpacing.sm),
        AppSkeleton(width: double.infinity, height: 36, radius: 999),
        SizedBox(height: AppSpacing.md),
        AppSkeleton(width: double.infinity, height: 96, radius: 24),
        SizedBox(height: AppSpacing.md),
        AppSkeleton(width: double.infinity, height: 320, radius: 26),
        SizedBox(height: AppSpacing.md),
        AppSkeleton(width: double.infinity, height: 180, radius: 26),
      ],
    );
  }
}
