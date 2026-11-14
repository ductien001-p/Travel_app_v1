import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_pressable.dart';

import '../../application/social_post_detail_view.dart';
import '../../data/models/social_post_detail_models.dart';

class SocialPostDetailStats extends StatelessWidget {
  const SocialPostDetailStats({super.key, required this.post});

  final SocialPostDetail post;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.screenHorizontal,
      ),
      child: Text(
        '${formatCountLabel(post.likesCount)} lượt thích · '
        '${formatCountLabel(post.commentsCount)} bình luận · '
        '${formatCountLabel(post.sharesCount)} lượt chia sẻ',
        style: AppTypography.caption.copyWith(color: AppColors.textSecondary),
      ),
    );
  }
}

class SocialPostDetailActionBar extends StatelessWidget {
  const SocialPostDetailActionBar({
    super.key,
    required this.post,
    required this.onLike,
    required this.onComment,
    required this.onShare,
    required this.onBookmark,
  });

  final SocialPostDetail post;
  final VoidCallback onLike;
  final VoidCallback onComment;
  final VoidCallback onShare;
  final VoidCallback onBookmark;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.screenHorizontal,
      ),
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: AppColors.surfaceSubdued,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: AppColors.borderNeutral),
        ),
        child: Row(
          children: [
            Expanded(
              child: _ActionChip(
                icon: post.liked
                    ? Icons.favorite_rounded
                    : Icons.favorite_border_rounded,
                label: formatCountLabel(post.likesCount),
                iconColor: post.liked
                    ? AppColors.danger
                    : AppColors.textPrimary,
                onTap: onLike,
              ),
            ),
            Expanded(
              child: _ActionChip(
                icon: Icons.chat_bubble_outline_rounded,
                label: formatCountLabel(post.commentsCount),
                onTap: onComment,
              ),
            ),
            Expanded(
              child: _ActionChip(
                icon: Icons.ios_share_rounded,
                label: 'Chia sẻ',
                onTap: onShare,
              ),
            ),
            Expanded(
              child: _ActionChip(
                icon: post.bookmarked
                    ? Icons.bookmark_rounded
                    : Icons.bookmark_border_rounded,
                label: 'Lưu',
                iconColor: post.bookmarked
                    ? AppColors.primary
                    : AppColors.textPrimary,
                onTap: onBookmark,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionChip extends StatelessWidget {
  const _ActionChip({
    required this.icon,
    required this.label,
    required this.onTap,
    this.iconColor = AppColors.textPrimary,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return AppPressable(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.input),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: [
            Icon(icon, size: 20, color: iconColor),
            const SizedBox(height: 4),
            Text(
              label,
              style: AppTypography.caption.copyWith(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
