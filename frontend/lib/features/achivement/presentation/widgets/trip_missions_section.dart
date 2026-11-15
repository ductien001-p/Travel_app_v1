import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_error_view.dart';
import 'package:travel_frontend_v1/core/widget/app_progress_bar.dart';

import '../../application/achivement_view.dart';
import '../../application/trip_missions_controller.dart';
import '../../data/models/achivement_models.dart';
import 'trip_mission_tile.dart';

class TripMissionsSection extends ConsumerWidget {
  const TripMissionsSection({
    super.key,
    required this.tripId,
    required this.onMissionCta,
    this.onRulesTap,
  });

  final String tripId;
  final void Function(TripMissionItem mission) onMissionCta;
  final VoidCallback? onRulesTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(tripMissionsControllerProvider(tripId));

    return state.when(
      loading: () => const _MissionsSkeleton(),
      error: (error, _) {
        if (achivementFailureIsUnauthorized(error)) {
          return const SizedBox.shrink();
        }
        return AppErrorView(
          title: 'Không tải được nhiệm vụ',
          message: achivementFailureMessage(error),
          actionLabel: 'Thử lại',
          onRetry: () => ref
              .read(tripMissionsControllerProvider(tripId).notifier)
              .refresh(),
        );
      },
      data: (page) {
        if (page.items.isEmpty) return const SizedBox.shrink();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Nhiệm vụ chuyến đi',
                            style: AppTypography.sectionTitle.copyWith(
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(width: AppSpacing.xs),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primary15,
                              borderRadius: BorderRadius.circular(
                                AppRadius.pill,
                              ),
                            ),
                            child: Text(
                              achivementPointsLabel(
                                page.missionPointsPending,
                                withPlus: true,
                                withUnit: true,
                              ).replaceAll(' pts', ' điểm'),
                              style: AppTypography.badge.copyWith(
                                color: AppColors.primaryActive,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${page.completedCount}/${page.totalCount} hoàn thành',
                        style: AppTypography.caption.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                if (onRulesTap != null)
                  TextButton(
                    onPressed: onRulesTap,
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.primary,
                      padding: EdgeInsets.zero,
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Quy tắc',
                          style: AppTypography.caption.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const Icon(Icons.chevron_right_rounded, size: 16),
                      ],
                    ),
                  ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            AppProgressBar(value: page.progressRatio, height: 8),
            const SizedBox(height: AppSpacing.md),
            ...page.items.map(
              (mission) => Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                child: TripMissionTile(
                  mission: mission,
                  onCta: () => onMissionCta(mission),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _MissionsSkeleton extends StatelessWidget {
  const _MissionsSkeleton();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        2,
        (index) => Container(
          height: 96,
          margin: const EdgeInsets.only(bottom: AppSpacing.sm),
          decoration: BoxDecoration(
            color: AppColors.surfaceSubdued,
            borderRadius: BorderRadius.circular(22),
          ),
        ),
      ),
    );
  }
}
