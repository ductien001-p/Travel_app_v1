import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_shadows.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_avatar.dart';
import 'package:travel_frontend_v1/core/widget/app_pressable.dart';

import '../../data/models/social_feed_models.dart';

class SocialFeedReviewPostCard extends StatelessWidget {
  const SocialFeedReviewPostCard({
    super.key,
    required this.post,
    this.onOpen,
    this.onOpenMedia,
    this.onLike,
    this.onComment,
    this.onShare,
    this.onBookmark,
    this.onPrimaryCta,
    this.onSecondaryCta,
    this.onMore,
  });

  final SocialFeedReviewPost post;
  final VoidCallback? onOpen;

  /// Tap ảnh trên bài của người khác → fullscreen viewer.
  final ValueChanged<int>? onOpenMedia;
  final VoidCallback? onLike;
  final VoidCallback? onComment;
  final VoidCallback? onShare;
  final VoidCallback? onBookmark;
  final VoidCallback? onPrimaryCta;
  final VoidCallback? onSecondaryCta;
  final VoidCallback? onMore;

  @override
  Widget build(BuildContext context) {
    final authorInitial = post.author.displayName.isNotEmpty
        ? post.author.displayName.characters.first.toUpperCase()
        : '?';

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.screenHorizontal,
      ),
      child: Container(
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
            // Header + caption open post detail. Media is outside so taps
            // are not swallowed by the card pressable.
            AppPressable(
              onTap: onOpen,
              pressedScale: 0.99,
              borderRadius: BorderRadius.circular(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppAvatar(
                        size: 44,
                        imageUrl: post.author.avatarUrl,
                        initials: authorInitial,
                        verified: post.author.verified,
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              spacing: 6,
                              children: [
                                Text(
                                  post.author.displayName,
                                  style: AppTypography.cardTitle.copyWith(
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                if (post.author.badgeLabel != null)
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColors.primaryLight,
                                      borderRadius: BorderRadius.circular(
                                        AppRadius.pill,
                                      ),
                                      border: Border.all(
                                        color: AppColors.warning.withValues(
                                          alpha: 0.35,
                                        ),
                                      ),
                                    ),
                                    child: Text(
                                      '🏆 ${post.author.badgeLabel}',
                                      style: AppTypography.badge.copyWith(
                                        color: AppColors.primary,
                                        fontSize: 11,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            const SizedBox(height: 2),
                            Row(
                              children: [
                                Text(
                                  post.timeLabel,
                                  style: AppTypography.caption,
                                ),
                                const Text(' • ', style: AppTypography.caption),
                                const Icon(
                                  Icons.public_rounded,
                                  size: 13,
                                  color: AppColors.textTertiary,
                                ),
                                if (post.trendLabel != null) ...[
                                  const SizedBox(width: 6),
                                  const Icon(
                                    Icons.local_fire_department_rounded,
                                    size: 13,
                                    color: AppColors.warning,
                                  ),
                                  const SizedBox(width: 2),
                                  Flexible(
                                    child: Text(
                                      post.trendLabel!,
                                      style: AppTypography.caption.copyWith(
                                        color: AppColors.warning,
                                        fontWeight: FontWeight.w700,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ],
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
                  if (post.placeLabel != null) ...[
                    const SizedBox(height: AppSpacing.sm),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.surfaceSubdued,
                            borderRadius: BorderRadius.circular(AppRadius.pill),
                            border: Border.all(
                              color: AppColors.borderBrandSoft,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.location_on_rounded,
                                size: 15,
                                color: AppColors.primary,
                              ),
                              const SizedBox(width: 4),
                              Flexible(
                                child: Text(
                                  post.placeLabel!,
                                  style: AppTypography.caption.copyWith(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              if (post.placeDetail != null) ...[
                                Text(
                                  ' • ${post.placeDetail}',
                                  style: AppTypography.caption.copyWith(
                                    color: AppColors.textTertiary,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                        if (post.savedByLabel != null)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primaryLight.withValues(
                                alpha: 0.7,
                              ),
                              borderRadius: BorderRadius.circular(
                                AppRadius.pill,
                              ),
                              border: Border.all(
                                color: AppColors.borderBrandSoft,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.bookmark_rounded,
                                  size: 13,
                                  color: AppColors.primary,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  post.savedByLabel!,
                                  style: AppTypography.caption.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ],
                  const SizedBox(height: AppSpacing.sm),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      post.caption,
                      style: AppTypography.body.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                  if (post.tipTitle != null && post.tipBody != null) ...[
                    const SizedBox(height: AppSpacing.sm),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.primaryLight.withValues(alpha: 0.75),
                        borderRadius: BorderRadius.circular(AppRadius.image),
                        border: Border.all(color: AppColors.borderBrandSoft),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.tips_and_updates_rounded,
                            size: 18,
                            color: AppColors.primary,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                style: AppTypography.caption.copyWith(
                                  color: AppColors.textPrimary,
                                  height: 1.35,
                                ),
                                children: [
                                  TextSpan(
                                    text: '${post.tipTitle} ',
                                    style: const TextStyle(
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  TextSpan(text: post.tipBody),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
            if (post.medias.isNotEmpty) ...[
              const SizedBox(height: AppSpacing.sm),
              _MediaGrid(
                medias: post.medias,
                extraCount: post.extraMediaCount,
                onMediaTap: onOpenMedia ?? (_) => onOpen?.call(),
              ),
            ],
            if (post.primaryCtaLabel != null ||
                post.secondaryCtaLabel != null) ...[
              const SizedBox(height: AppSpacing.sm),
              Row(
                children: [
                  if (post.primaryCtaLabel != null)
                    Expanded(
                      child: AppPressable(
                        onTap: onPrimaryCta,
                        borderRadius: BorderRadius.circular(AppRadius.pill),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(AppRadius.pill),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.route_rounded,
                                size: 16,
                                color: AppColors.textInverse,
                              ),
                              const SizedBox(width: 6),
                              Flexible(
                                child: Text(
                                  post.primaryCtaLabel!,
                                  style: AppTypography.buttonSmall.copyWith(
                                    color: AppColors.textInverse,
                                    fontSize: 12,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  if (post.primaryCtaLabel != null &&
                      post.secondaryCtaLabel != null)
                    const SizedBox(width: 8),
                  if (post.secondaryCtaLabel != null)
                    Expanded(
                      child: AppPressable(
                        onTap: onSecondaryCta,
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.bookmark_add_outlined,
                                size: 16,
                                color: AppColors.primary,
                              ),
                              const SizedBox(width: 6),
                              Flexible(
                                child: Text(
                                  post.secondaryCtaLabel!,
                                  style: AppTypography.buttonSmall.copyWith(
                                    color: AppColors.primary,
                                    fontSize: 12,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ],
            const SizedBox(height: AppSpacing.sm),
            Text(
              '${_formatCount(post.likesCount)} lượt thích • '
              '${_formatCount(post.commentsCount)} thảo luận • '
              '${_formatCount(post.savesCount)} đã lưu',
              style: AppTypography.caption,
            ),
            const SizedBox(height: AppSpacing.xs),
            Row(
              children: [
                _ActionChip(
                  icon: post.liked
                      ? Icons.favorite_rounded
                      : Icons.favorite_border_rounded,
                  label: post.liked ? 'Đã thích' : 'Thích',
                  active: post.liked,
                  activeColor: AppColors.danger,
                  onTap: onLike,
                ),
                _ActionChip(
                  icon: Icons.chat_bubble_outline_rounded,
                  label: 'Bình luận',
                  onTap: onComment,
                ),
                _ActionChip(
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
            if (post.previewComment != null) ...[
              const SizedBox(height: AppSpacing.sm),
              const Divider(height: 1, color: AppColors.borderNeutral),
              const SizedBox(height: AppSpacing.sm),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppAvatar(
                    size: 28,
                    imageUrl: post.previewComment!.avatarUrl,
                    initials: post.previewComment!.authorName.isNotEmpty
                        ? post.previewComment!.authorName.characters.first
                              .toUpperCase()
                        : '?',
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            style: AppTypography.caption.copyWith(
                              color: AppColors.textPrimary,
                              height: 1.4,
                            ),
                            children: [
                              TextSpan(
                                text: '${post.previewComment!.authorName} ',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              TextSpan(text: post.previewComment!.text),
                            ],
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          [
                            post.previewComment!.timeLabel,
                            if (post.previewComment!.replyLabel != null)
                              post.previewComment!.replyLabel!,
                          ].join(' • '),
                          style: AppTypography.caption.copyWith(
                            color: AppColors.textTertiary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _MediaGrid extends StatelessWidget {
  const _MediaGrid({
    required this.medias,
    required this.extraCount,
    this.onMediaTap,
  });

  final List<SocialFeedMedia> medias;
  final int extraCount;
  final ValueChanged<int>? onMediaTap;

  int _indexOf(SocialFeedMedia media) {
    final index = medias.indexWhere((item) => item.id == media.id);
    return index < 0 ? 0 : index;
  }

  @override
  Widget build(BuildContext context) {
    final hero = medias.where((m) => m.isHero).firstOrNull ?? medias.first;
    final side = medias.where((m) => m.id != hero.id).toList();

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: SizedBox(
        height: 208,
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: _TapMedia(
                onTap: onMediaTap == null
                    ? null
                    : () => onMediaTap!(_indexOf(hero)),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      hero.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (_, _, _) =>
                          const ColoredBox(color: AppColors.surfaceSubdued),
                    ),
                    if (hero.overlayLabel != null)
                      Positioned(
                        left: 8,
                        bottom: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.heroOverlay.withValues(
                              alpha: 0.75,
                            ),
                            borderRadius: BorderRadius.circular(AppRadius.pill),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.photo_camera_rounded,
                                size: 13,
                                color: AppColors.textInverse,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                hero.overlayLabel!,
                                style: AppTypography.badge.copyWith(
                                  color: AppColors.textInverse,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 6),
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: side.isEmpty
                        ? const ColoredBox(color: AppColors.surfaceSubdued)
                        : _TapMedia(
                            onTap: onMediaTap == null
                                ? null
                                : () => onMediaTap!(_indexOf(side.first)),
                            child: Image.network(
                              side.first.imageUrl,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              errorBuilder: (_, _, _) => const ColoredBox(
                                color: AppColors.surfaceSubdued,
                              ),
                            ),
                          ),
                  ),
                  const SizedBox(height: 6),
                  Expanded(
                    child: _TapMedia(
                      onTap: onMediaTap == null
                          ? null
                          : () => onMediaTap!(
                              side.length > 1
                                  ? _indexOf(side[1])
                                  : _indexOf(hero),
                            ),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          ColoredBox(
                            color: AppColors.primary.withValues(alpha: 0.12),
                            child: side.length > 1
                                ? Image.network(
                                    side[1].imageUrl,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, _, _) =>
                                        const SizedBox.shrink(),
                                  )
                                : null,
                          ),
                          if (extraCount > 0)
                            ColoredBox(
                              color: AppColors.heroOverlay.withValues(
                                alpha: 0.45,
                              ),
                              child: Center(
                                child: Text(
                                  '+$extraCount ảnh',
                                  style: AppTypography.buttonSmall.copyWith(
                                    color: AppColors.textInverse,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TapMedia extends StatelessWidget {
  const _TapMedia({required this.child, this.onTap});

  final Widget child;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    if (onTap == null) return child;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: child,
    );
  }
}

class _ActionChip extends StatelessWidget {
  const _ActionChip({
    required this.icon,
    required this.label,
    this.onTap,
    this.active = false,
    this.activeColor = AppColors.primary,
  });

  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  final bool active;
  final Color activeColor;

  @override
  Widget build(BuildContext context) {
    final color = active ? activeColor : AppColors.textSecondary;
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

String _formatCount(int value) {
  if (value >= 1000) {
    final k = value / 1000;
    return '${k.toStringAsFixed(k >= 10 ? 0 : 1)}k';
  }
  return '$value';
}
