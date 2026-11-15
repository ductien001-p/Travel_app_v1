import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_shadows.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_pressable.dart';
import 'package:travel_frontend_v1/core/widget/app_progress_bar.dart';

import '../../application/achivement_view.dart';
import '../../data/models/achivement_models.dart';

class TripMissionTile extends StatelessWidget {
  const TripMissionTile({
    super.key,
    required this.mission,
    required this.onCta,
  });

  final TripMissionItem mission;
  final VoidCallback onCta;

  @override
  Widget build(BuildContext context) {
    final completed = mission.completed;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: completed
              ? AppColors.success.withValues(alpha: 0.3)
              : AppColors.borderBrandSoft,
        ),
        boxShadow: AppShadows.level1,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: completed
                      ? AppColors.success.withValues(alpha: 0.15)
                      : AppColors.primaryLight,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: completed
                        ? AppColors.success.withValues(alpha: 0.2)
                        : AppColors.primary20,
                  ),
                ),
                child: Icon(
                  completed
                      ? Icons.check_circle_rounded
                      : achivementMissionIcon(mission.icon),
                  size: 20,
                  color: completed ? AppColors.success : AppColors.primary,
                ),
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
                            mission.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTypography.cardTitle.copyWith(
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.xs),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: completed
                                ? AppColors.success.withValues(alpha: 0.1)
                                : AppColors.surfaceSubdued,
                            borderRadius: BorderRadius.circular(AppRadius.pill),
                          ),
                          child: Text(
                            achivementPointsLabel(
                              mission.pointsReward,
                              withPlus: true,
                              withUnit: true,
                            ),
                            style: AppTypography.badge.copyWith(
                              color: completed
                                  ? AppColors.success
                                  : AppColors.primary,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      mission.subtitle,
                      style: AppTypography.caption.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.xs),
              if (completed)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.success.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(AppRadius.pill),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.done_rounded,
                        size: 14,
                        color: AppColors.success,
                      ),
                      const SizedBox(width: 2),
                      Text(
                        '${mission.progressCurrent}/${mission.progressTarget} Đã xong',
                        style: AppTypography.badge.copyWith(
                          color: AppColors.success,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                )
              else
                AppPressable(
                  onTap: onCta,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppRadius.pill),
                      border: Border.all(color: AppColors.primary),
                    ),
                    child: Text(
                      achivementMissionCtaLabel(mission.cta),
                      style: AppTypography.caption.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          if (!completed) ...[
            const SizedBox(height: AppSpacing.sm),
            const Divider(height: 1, color: AppColors.borderNeutral),
            const SizedBox(height: AppSpacing.sm),
            Row(
              children: [
                Expanded(
                  child: AppProgressBar(
                    value: mission.progressRatio,
                    height: 6,
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Text(
                  '${mission.progressCurrent}/${mission.progressTarget}',
                  style: AppTypography.badge.copyWith(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
