import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_shadows.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_progress_bar.dart';

import '../../application/achivement_view.dart';
import '../../data/models/achivement_models.dart';

class AchievementProgressTile extends StatelessWidget {
  const AchievementProgressTile({super.key, required this.item});

  final AchievementProgress item;

  @override
  Widget build(BuildContext context) {
    final unlocked = item.unlocked;
    final rarityColor = switch (item.rarity.toUpperCase()) {
      'EPIC' => const Color(0xFF7C3AED),
      'RARE' => AppColors.info,
      'LEGENDARY' => AppColors.warning,
      _ => AppColors.primary,
    };

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.glass85,
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(
          color: unlocked
              ? rarityColor.withValues(alpha: 0.25)
              : AppColors.borderBrandSoft,
        ),
        boxShadow: AppShadows.level1,
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: unlocked
                  ? rarityColor.withValues(alpha: 0.12)
                  : AppColors.surfaceSubdued,
              shape: BoxShape.circle,
            ),
            child: Icon(
              achivementAchievementIcon(item.code, unlocked: unlocked),
              color: unlocked ? rarityColor : AppColors.textTertiary,
              size: 22,
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        item.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTypography.bodyMedium.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: rarityColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(AppRadius.pill),
                      ),
                      child: Text(
                        item.rarity,
                        style: AppTypography.badge.copyWith(
                          color: rarityColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Expanded(
                      child: AppProgressBar(
                        value: item.progressRatio,
                        height: 6,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Text(
                      unlocked ? 'Đã mở' : '${item.current}/${item.target}',
                      style: AppTypography.badge.copyWith(
                        color: unlocked
                            ? AppColors.success
                            : AppColors.textSecondary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
