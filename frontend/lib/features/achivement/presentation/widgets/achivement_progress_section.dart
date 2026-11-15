import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_error_view.dart';

import '../../application/achivement_progress_controller.dart';
import '../../application/achivement_view.dart';
import '../../data/models/achivement_models.dart';
import 'achievement_progress_tile.dart';
import 'travel_tier_card.dart';

/// Embeds Travel Tier + Achievements under Ranking (Stitch screen 3).
///
/// Always shows a visible state (skeleton / error / empty / data) — never
/// collapses silently so the feature looks "missing".
class AchivementProgressSection extends ConsumerWidget {
  const AchivementProgressSection({super.key});

  static const _fallbackTier = TravelTier(
    code: 'ROOKIE',
    label: 'Tân binh',
    multiplier: 1,
    tripsCompleted: 0,
    distinctCities: 0,
    next: TravelTierNext(
      code: 'EXPLORER',
      multiplier: 1.1,
      tripsRemaining: 3,
      citiesRemaining: 0,
    ),
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(achivementProgressControllerProvider);

    return state.when(
      loading: () => const _ProgressSkeleton(),
      error: (error, _) {
        if (achivementFailureIsUnauthorized(error)) {
          return _EmptyTierCard(
            message: 'Đăng nhập lại để xem hạng du lịch và thành tích.',
          );
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppErrorView(
              title: 'Không tải được hạng du lịch',
              message: achivementFailureMessage(error),
              actionLabel: 'Thử lại',
              onRetry: () => ref
                  .read(achivementProgressControllerProvider.notifier)
                  .refresh(),
            ),
          ],
        );
      },
      data: (page) {
        final tier = page.travelTier ?? _fallbackTier;
        final achievements = page.achievements;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TravelTierCard(tier: tier),
            const SizedBox(height: AppSpacing.lg),
            Row(
              children: [
                const Icon(
                  Icons.emoji_events_rounded,
                  size: 18,
                  color: AppColors.warning,
                ),
                const SizedBox(width: 6),
                Text(
                  'Thành tích',
                  style: AppTypography.sectionTitle.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            if (achievements.isEmpty)
              const _EmptyAchievementsHint()
            else
              ...achievements.map(
                (item) => Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.xs),
                  child: AchievementProgressTile(item: item),
                ),
              ),
          ],
        );
      },
    );
  }
}

class _ProgressSkeleton extends StatelessWidget {
  const _ProgressSkeleton();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 112,
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.surfaceSubdued,
            borderRadius: BorderRadius.circular(AppRadius.card),
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        Container(
          height: 64,
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.surfaceSubdued,
            borderRadius: BorderRadius.circular(AppRadius.card),
          ),
        ),
      ],
    );
  }
}

class _EmptyTierCard extends StatelessWidget {
  const _EmptyTierCard({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.primaryLight,
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(color: AppColors.primary20),
      ),
      child: Text(
        message,
        style: AppTypography.bodyMedium.copyWith(
          color: AppColors.textSecondary,
        ),
      ),
    );
  }
}

class _EmptyAchievementsHint extends StatelessWidget {
  const _EmptyAchievementsHint();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surfaceSubdued,
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(color: AppColors.borderBrandSoft),
      ),
      child: Text(
        'Hoàn thành chuyến đi và nhiệm vụ để mở thành tích đầu tiên.',
        style: AppTypography.caption.copyWith(color: AppColors.textSecondary),
      ),
    );
  }
}
