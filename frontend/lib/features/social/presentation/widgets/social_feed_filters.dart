import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_pressable.dart';

import '../../data/models/social_feed_models.dart';

class SocialFeedFilters extends StatelessWidget {
  const SocialFeedFilters({
    super.key,
    required this.tabs,
    required this.topicChips,
    required this.onTabSelected,
    required this.onTopicSelected,
  });

  final List<SocialFeedTab> tabs;
  final List<SocialFeedTopicChip> topicChips;
  final ValueChanged<String> onTabSelected;
  final ValueChanged<String> onTopicSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.screenHorizontal,
          ),
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: AppColors.surfaceSubdued.withValues(alpha: 0.9),
              borderRadius: BorderRadius.circular(AppRadius.pill),
              border: Border.all(color: AppColors.borderNeutral),
            ),
            child: Row(
              children: [
                for (final tab in tabs)
                  Expanded(
                    child: AppPressable(
                      onTap: () => onTabSelected(tab.id),
                      borderRadius: BorderRadius.circular(AppRadius.pill),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 180),
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          color: tab.selected
                              ? AppColors.primary
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(AppRadius.pill),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              child: Text(
                                tab.label,
                                style: AppTypography.bodyMedium.copyWith(
                                  color: tab.selected
                                      ? AppColors.textInverse
                                      : AppColors.textSecondary,
                                  fontWeight: tab.selected
                                      ? FontWeight.w700
                                      : FontWeight.w500,
                                  fontSize: 13,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            if (tab.badgeLabel != null) ...[
                              const SizedBox(width: 4),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 1,
                                ),
                                decoration: BoxDecoration(
                                  color: tab.selected
                                      ? AppColors.textInverse.withValues(
                                          alpha: 0.2,
                                        )
                                      : AppColors.primaryLight,
                                  borderRadius: BorderRadius.circular(
                                    AppRadius.pill,
                                  ),
                                ),
                                child: Text(
                                  tab.badgeLabel!,
                                  style: AppTypography.badge.copyWith(
                                    color: tab.selected
                                        ? AppColors.textInverse
                                        : AppColors.primary,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                            ],
                            if (tab.emoji != null) ...[
                              const SizedBox(width: 2),
                              Text(
                                tab.emoji!,
                                style: const TextStyle(fontSize: 12),
                              ),
                            ],
                            if (tab.selected &&
                                tab.badgeLabel == null &&
                                tab.emoji == null) ...[
                              const SizedBox(width: 4),
                              Container(
                                width: 6,
                                height: 6,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF84F5EF),
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        SizedBox(
          height: 36,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.screenHorizontal,
            ),
            itemCount: topicChips.length,
            separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.xs),
            itemBuilder: (context, index) {
              final chip = topicChips[index];
              return AppPressable(
                onTap: () => onTopicSelected(chip.id),
                borderRadius: BorderRadius.circular(AppRadius.pill),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 160),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: chip.selected
                        ? AppColors.primaryLight
                        : AppColors.surface,
                    borderRadius: BorderRadius.circular(AppRadius.pill),
                    border: Border.all(
                      color: chip.selected
                          ? AppColors.primary
                          : AppColors.borderBrandSoft,
                    ),
                  ),
                  child: Text(
                    chip.label,
                    style: AppTypography.caption.copyWith(
                      color: chip.selected
                          ? AppColors.primary
                          : AppColors.textSecondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
