import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_icon_button.dart';

class SocialPostDetailHeader extends StatelessWidget {
  const SocialPostDetailHeader({
    super.key,
    required this.subtitle,
    required this.bookmarked,
    required this.onBack,
    required this.onBookmark,
    required this.onMore,
  });

  final String subtitle;
  final bool bookmarked;
  final VoidCallback onBack;
  final VoidCallback onBookmark;
  final VoidCallback onMore;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.sm,
        AppSpacing.xs,
        AppSpacing.sm,
        AppSpacing.xs,
      ),
      child: Row(
        children: [
          AppIconButton(
            icon: Icons.arrow_back_rounded,
            onPressed: onBack,
            semanticLabel: 'Quay lại',
          ),
          const SizedBox(width: AppSpacing.xs),
          Expanded(
            child: Column(
              children: [
                Text('Bài Viết', style: AppTypography.screenTitle),
                const SizedBox(height: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Flexible(
                      child: Text(
                        subtitle,
                        style: AppTypography.caption.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          AppIconButton(
            icon: bookmarked
                ? Icons.bookmark_rounded
                : Icons.bookmark_border_rounded,
            iconColor: bookmarked ? AppColors.primary : AppColors.textSecondary,
            onPressed: onBookmark,
            semanticLabel: 'Lưu bài viết',
          ),
          const SizedBox(width: 4),
          AppIconButton(
            icon: Icons.more_vert_rounded,
            onPressed: onMore,
            semanticLabel: 'Thêm',
          ),
        ],
      ),
    );
  }
}
