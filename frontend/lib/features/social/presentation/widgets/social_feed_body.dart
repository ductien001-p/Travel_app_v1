import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_button.dart';
import 'package:travel_frontend_v1/core/widget/app_empty_view.dart';

import '../../application/social_feed_view.dart';
import '../../data/models/social_feed_models.dart';
import 'social_feed_challenge_card.dart';
import 'social_feed_composer.dart';
import 'social_feed_filters.dart';
import 'social_feed_review_post.dart';
import 'social_feed_stories.dart';
import 'social_feed_trip_recruit_post.dart';

class SocialFeedBody extends StatelessWidget {
  const SocialFeedBody({
    super.key,
    required this.view,
    required this.onTabSelected,
    required this.onTopicSelected,
    required this.onLike,
    required this.onBookmark,
    required this.onComment,
    required this.onShare,
    required this.onJoinChallenge,
    required this.onLoadMore,
    required this.onCompose,
    required this.onPhotoCompose,
    required this.onCheckIn,
    required this.onInvite,
    required this.onStoryTap,
    required this.onSeeAllStories,
    required this.onOpenPost,
    required this.onOpenPlace,
    required this.onJoinTrip,
    this.onOpenReviewMedia,
    this.onComingSoon,
    this.onOpenTrip,
  });

  final SocialFeedViewState view;
  final ValueChanged<String> onTabSelected;
  final ValueChanged<String> onTopicSelected;
  final ValueChanged<String> onLike;
  final ValueChanged<String> onBookmark;
  final ValueChanged<String> onComment;
  final ValueChanged<String> onShare;
  final ValueChanged<String> onJoinChallenge;
  final VoidCallback onLoadMore;
  final VoidCallback onCompose;
  final VoidCallback onPhotoCompose;
  final VoidCallback onCheckIn;
  final VoidCallback onInvite;
  final ValueChanged<SocialFeedStory> onStoryTap;
  final VoidCallback onSeeAllStories;
  final ValueChanged<String> onOpenPost;
  final ValueChanged<String> onOpenPlace;
  final ValueChanged<String> onJoinTrip;
  final void Function(SocialFeedReviewPost post, int mediaIndex)?
  onOpenReviewMedia;
  final VoidCallback? onComingSoon;
  final ValueChanged<String>? onOpenTrip;

  @override
  Widget build(BuildContext context) {
    if (view.isEmpty) {
      return ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          const SizedBox(height: 120),
          AppEmptyView(
            title: 'Chưa có bài viết',
            description: 'Hãy chia sẻ khoảnh khắc đầu tiên của bạn.',
            actionLabel: 'Đăng bài',
            onAction: onCompose,
          ),
        ],
      );
    }

    return CustomScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            children: [
              SocialFeedStories(
                stories: view.feed.stories,
                onSeeAll: onSeeAllStories,
                onStoryTap: onStoryTap,
              ),
              const SizedBox(height: AppSpacing.md),
              SocialFeedFilters(
                tabs: view.tabs,
                topicChips: view.topicChips,
                onTabSelected: onTabSelected,
                onTopicSelected: onTopicSelected,
              ),
              const SizedBox(height: AppSpacing.md),
              SocialFeedComposerCard(
                composer: view.feed.composer,
                onComposeTap: onCompose,
                onPhotoTap: onPhotoCompose,
                onCheckInTap: onCheckIn,
                onInviteTap: onInvite,
              ),
              const SizedBox(height: AppSpacing.md),
            ],
          ),
        ),
        SliverList.separated(
          itemCount: view.feed.items.length,
          separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.md),
          itemBuilder: (context, index) {
            final item = view.feed.items[index];
            return switch (item.type) {
              SocialFeedItemType.review when item.review != null =>
                SocialFeedReviewPostCard(
                  post: item.review!,
                  onOpen: () => onOpenPost(item.review!.postId),
                  onOpenMedia: onOpenReviewMedia == null
                      ? null
                      : (index) => onOpenReviewMedia!(item.review!, index),
                  onLike: () => onLike(item.review!.postId),
                  onBookmark: () => onBookmark(item.review!.postId),
                  onComment: () => onComment(item.review!.postId),
                  onShare: () => onShare(item.review!.postId),
                  onPrimaryCta: () {
                    final placeId = item.review!.placeId;
                    if (placeId != null && placeId.isNotEmpty) {
                      onOpenPlace(placeId);
                    } else {
                      onOpenPost(item.review!.postId);
                    }
                  },
                  onSecondaryCta: () {
                    final placeId = item.review!.placeId;
                    if (placeId != null && placeId.isNotEmpty) {
                      onOpenPlace(placeId);
                    } else {
                      onOpenPost(item.review!.postId);
                    }
                  },
                  onMore: onComingSoon,
                ),
              SocialFeedItemType.challenge when item.challenge != null =>
                SocialFeedChallengeCard(
                  challenge: item.challenge!,
                  onJoin: () => onJoinChallenge(item.challenge!.id),
                ),
              SocialFeedItemType.tripRecruit when item.tripRecruit != null =>
                SocialFeedTripRecruitCard(
                  post: item.tripRecruit!,
                  onLike: onComingSoon,
                  onBookmark: onComingSoon,
                  onComment: onComingSoon,
                  onShare: onComingSoon,
                  onItinerary: () => onOpenTrip?.call(item.tripRecruit!.tripId),
                  onJoin: () => onJoinTrip(item.tripRecruit!.tripId),
                  onMore: onComingSoon,
                ),
              _ => const SizedBox.shrink(),
            };
          },
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.screenHorizontal,
              AppSpacing.md,
              AppSpacing.screenHorizontal,
              AppSpacing.safeBottom,
            ),
            child: Column(
              children: [
                if (view.loadMoreError != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.xs),
                    child: Text(
                      'Không tải thêm được bài viết.',
                      style: AppTypography.caption.copyWith(
                        color: AppColors.danger,
                      ),
                    ),
                  ),
                if (view.hasNextPage || view.loadMoreError != null)
                  AppButton(
                    label: 'Xem thêm',
                    variant: AppButtonVariant.secondary,
                    isLoading: view.isLoadingMore,
                    onPressed: view.isLoadingMore ? null : onLoadMore,
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
