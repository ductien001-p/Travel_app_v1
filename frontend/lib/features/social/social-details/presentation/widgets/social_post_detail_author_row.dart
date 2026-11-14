import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_avatar.dart';
import 'package:travel_frontend_v1/core/widget/app_pressable.dart';

import '../../application/social_post_detail_view.dart';

class SocialPostDetailAuthorRow extends StatelessWidget {
  const SocialPostDetailAuthorRow({
    super.key,
    required this.view,
    required this.onFollow,
  });

  final SocialPostDetailView view;
  final VoidCallback onFollow;

  @override
  Widget build(BuildContext context) {
    final author = view.post.author;
    final initial = view.authorDisplayName.isNotEmpty
        ? view.authorDisplayName.characters.first.toUpperCase()
        : '?';

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.screenHorizontal,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppAvatar(
            size: 48,
            imageUrl: author.avatarUrl,
            initials: initial,
            verified: author.verified,
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 6,
                  runSpacing: 4,
                  children: [
                    Text(
                      view.authorDisplayName,
                      style: AppTypography.cardTitle.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    if (author.badgeLabel != null &&
                        author.badgeLabel!.trim().isNotEmpty)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primaryLight,
                          borderRadius: BorderRadius.circular(AppRadius.pill),
                          border: Border.all(color: AppColors.borderBrandSoft),
                        ),
                        child: Text(
                          author.badgeLabel!,
                          style: AppTypography.badge.copyWith(
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(view.post.timeLabel, style: AppTypography.caption),
                    Text(
                      ' · ',
                      style: AppTypography.caption.copyWith(
                        color: AppColors.textTertiary,
                      ),
                    ),
                    Icon(
                      Icons.public_rounded,
                      size: 13,
                      color: AppColors.textTertiary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      view.visibilityLabel,
                      style: AppTypography.caption.copyWith(
                        color: AppColors.textTertiary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          AppPressable(
            onTap: onFollow,
            borderRadius: BorderRadius.circular(AppRadius.pill),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(AppRadius.pill),
              ),
              child: Text(
                'Theo dõi',
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.textInverse,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
