import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_shadows.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_avatar.dart';
import 'package:travel_frontend_v1/core/widget/app_pressable.dart';

import '../../data/models/social_feed_models.dart';

class SocialFeedTripRecruitCard extends StatelessWidget {
  const SocialFeedTripRecruitCard({
    super.key,
    required this.post,
    this.onLike,
    this.onComment,
    this.onShare,
    this.onBookmark,
    this.onItinerary,
    this.onJoin,
    this.onMore,
  });

  final SocialFeedTripRecruit post;
  final VoidCallback? onLike;
  final VoidCallback? onComment;
  final VoidCallback? onShare;
  final VoidCallback? onBookmark;
  final VoidCallback? onItinerary;
  final VoidCallback? onJoin;
  final VoidCallback? onMore;

  @override
  Widget build(BuildContext context) {
    final authorInitial = post.author.displayName.isNotEmpty
        ? post.author.displayName.characters.first.toUpperCase()
        : '?';

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppSpacing.screenHorizontal,
      ),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.glass90,
        borderRadius: BorderRadius.circular(26),
        border: Border.all(color: AppColors.glassBorder),
        boxShadow: AppShadows.level1,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              AppAvatar(
                size: 44,
                imageUrl: post.author.avatarUrl,
                initials: authorInitial,
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            post.author.displayName,
                            style: AppTypography.cardTitle.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (post.author.badgeLabel != null) ...[
                          const SizedBox(width: 6),
                          Text(
                            post.author.badgeLabel!,
                            style: AppTypography.caption.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ],
                    ),
                    Text(
                      '${post.timeLabel} • ${post.recruitBadge}',
                      style: AppTypography.caption,
                    ),
                  ],
                ),
              ),
              AppPressable(
                onTap: onMore,
                borderRadius: BorderRadius.circular(AppRadius.pill),
                child: const SizedBox(
                  width: 32,
                  height: 32,
                  child: Icon(
                    Icons.more_horiz_rounded,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.surfaceSubdued,
              borderRadius: BorderRadius.circular(AppRadius.pill),
              border: Border.all(color: AppColors.borderBrandSoft),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.explore_rounded,
                  size: 15,
                  color: AppColors.primary,
                ),
                const SizedBox(width: 4),
                Flexible(
                  child: Text(
                    post.placeLabel,
                    style: AppTypography.caption.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            post.caption,
            style: AppTypography.body.copyWith(color: AppColors.textPrimary),
          ),
          const SizedBox(height: AppSpacing.sm),
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFE6F7F6), Color(0xFFF4FAF9)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(AppRadius.card),
              border: Border.all(color: AppColors.borderBrandSoft),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(AppRadius.pill),
                      ),
                      child: Text(
                        'CHUYẾN ĐI MỞ',
                        style: AppTypography.badge.copyWith(
                          color: AppColors.textInverse,
                          fontSize: 10,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      post.urgencyLabel,
                      style: AppTypography.caption.copyWith(
                        color: AppColors.danger,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  post.tripTitle,
                  style: AppTypography.cardTitle.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  post.spotsLeftLabel,
                  style: AppTypography.caption.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Row(
                  children: [
                    const Icon(
                      Icons.calendar_month_rounded,
                      size: 16,
                      color: AppColors.textSecondary,
                    ),
                    const SizedBox(width: 4),
                    Text(post.scheduleLabel, style: AppTypography.caption),
                    const SizedBox(width: AppSpacing.md),
                    const Icon(
                      Icons.payments_outlined,
                      size: 16,
                      color: AppColors.textSecondary,
                    ),
                    const SizedBox(width: 4),
                    Flexible(
                      child: Text(
                        post.priceLabel,
                        style: AppTypography.caption,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.sm),
                Row(
                  children: [
                    Text(
                      'Số thành viên đã chốt: ${post.membersLabel}',
                      style: AppTypography.caption.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      post.fillPercentLabel,
                      style: AppTypography.caption.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                ClipRRect(
                  borderRadius: BorderRadius.circular(AppRadius.pill),
                  child: LinearProgressIndicator(
                    value: post.fillRatio.clamp(0, 1),
                    minHeight: 8,
                    backgroundColor: AppColors.surface,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Row(
                  children: [
                    SizedBox(
                      height: 28,
                      width:
                          28.0 +
                          (post.memberAvatars.length.clamp(0, 3) - 1) * 16,
                      child: Stack(
                        children: [
                          for (
                            var i = 0;
                            i < post.memberAvatars.length && i < 3;
                            i++
                          )
                            Positioned(
                              left: i * 16.0,
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: AppColors.surface,
                                    width: 2,
                                  ),
                                ),
                                child: AppAvatar(
                                  size: 24,
                                  imageUrl: post.memberAvatars[i],
                                  initials: '?',
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    if (post.extraMemberCount > 0) ...[
                      const SizedBox(width: 6),
                      Text(
                        '+${post.extraMemberCount}',
                        style: AppTypography.caption.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                    const Spacer(),
                    Text(
                      'Đã tham gia',
                      style: AppTypography.caption.copyWith(
                        color: AppColors.textTertiary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.md),
                Row(
                  children: [
                    Expanded(
                      child: AppPressable(
                        onTap: onItinerary,
                        borderRadius: BorderRadius.circular(AppRadius.pill),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: AppColors.surface,
                            borderRadius: BorderRadius.circular(AppRadius.pill),
                            border: Border.all(
                              color: AppColors.borderBrandSoft,
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            post.itineraryCtaLabel,
                            style: AppTypography.buttonSmall.copyWith(
                              color: AppColors.primary,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      flex: 2,
                      child: AppPressable(
                        onTap: onJoin,
                        borderRadius: BorderRadius.circular(AppRadius.pill),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(AppRadius.pill),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            post.joinCtaLabel,
                            style: AppTypography.buttonSmall.copyWith(
                              color: AppColors.textInverse,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (post.highlightLabel != null) ...[
            const SizedBox(height: AppSpacing.sm),
            Row(
              children: [
                const Icon(
                  Icons.wb_sunny_rounded,
                  size: 16,
                  color: AppColors.warning,
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    [
                      post.highlightLabel!,
                      if (post.highlightDetail != null) post.highlightDetail!,
                    ].join(' • '),
                    style: AppTypography.caption.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              ],
            ),
          ],
          const SizedBox(height: AppSpacing.sm),
          Text(
            '${post.likesCount} lượt thích • ${post.commentsCount} bình luận • '
            '${post.sharesCount} chia sẻ',
            style: AppTypography.caption,
          ),
          const SizedBox(height: AppSpacing.xs),
          Row(
            children: [
              _Action(
                icon: post.liked
                    ? Icons.favorite_rounded
                    : Icons.favorite_border_rounded,
                label: post.liked ? 'Đã thích' : 'Thích',
                active: post.liked,
                onTap: onLike,
              ),
              _Action(
                icon: Icons.chat_bubble_outline_rounded,
                label: 'Bình luận',
                onTap: onComment,
              ),
              _Action(
                icon: Icons.ios_share_rounded,
                label: 'Chia sẻ',
                onTap: onShare,
              ),
              const Spacer(),
              AppPressable(
                onTap: onBookmark,
                borderRadius: BorderRadius.circular(AppRadius.pill),
                child: Icon(
                  post.bookmarked
                      ? Icons.bookmark_rounded
                      : Icons.bookmark_border_rounded,
                  color: post.bookmarked
                      ? AppColors.primary
                      : AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Action extends StatelessWidget {
  const _Action({
    required this.icon,
    required this.label,
    this.onTap,
    this.active = false,
  });

  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  final bool active;

  @override
  Widget build(BuildContext context) {
    final color = active ? AppColors.danger : AppColors.textSecondary;
    return AppPressable(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.pill),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
        child: Row(
          children: [
            Icon(icon, size: 18, color: color),
            const SizedBox(width: 4),
            Text(
              label,
              style: AppTypography.caption.copyWith(
                color: color,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
