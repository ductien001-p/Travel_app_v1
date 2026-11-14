import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_shadows.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_pressable.dart';

import '../../data/models/ranking_models.dart';

class RankingQuestTile extends StatelessWidget {
  const RankingQuestTile({
    super.key,
    required this.quest,
    required this.onAction,
    this.busy = false,
  });

  final RankingQuest quest;
  final VoidCallback onAction;
  final bool busy;

  @override
  Widget build(BuildContext context) {
    final iconBg = switch (quest.tone) {
      RankingQuestTone.primary => AppColors.primaryLight,
      RankingQuestTone.secondary => const Color(0xFFCCFBF6),
      RankingQuestTone.tertiary => const Color(0xFFD8E2FF),
    };
    final iconColor = switch (quest.tone) {
      RankingQuestTone.primary => AppColors.primary,
      RankingQuestTone.secondary => AppColors.primary,
      RankingQuestTone.tertiary => const Color(0xFF005AC2),
    };
    final rewardBg = switch (quest.tone) {
      RankingQuestTone.primary => AppColors.primary08,
      RankingQuestTone.secondary => const Color(0xFF99F2EC),
      RankingQuestTone.tertiary => const Color(0xFFD8E2FF),
    };
    final rewardColor = switch (quest.tone) {
      RankingQuestTone.primary => AppColors.primary,
      RankingQuestTone.secondary => const Color(0xFF00716D),
      RankingQuestTone.tertiary => const Color(0xFF004395),
    };
    final highlightAction = quest.claimable || quest.action == RankingQuestAction.start;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.glass85,
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(color: AppColors.borderBrandSoft),
        boxShadow: AppShadows.level1,
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(color: iconBg, shape: BoxShape.circle),
            alignment: Alignment.center,
            child: Icon(_iconFor(quest.icon), size: 22, color: iconColor),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  quest.title,
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  quest.subtitle,
                  style: AppTypography.caption.copyWith(
                    color: AppColors.textTertiary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.xs),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: rewardBg,
              borderRadius: BorderRadius.circular(AppRadius.pill),
            ),
            child: Text(
              quest.claimed ? 'Đã nhận' : '+${quest.pointsReward} pts',
              style: AppTypography.caption.copyWith(
                color: rewardColor,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const SizedBox(width: 8),
          AppPressable(
            onTap: busy || quest.claimed ? null : onAction,
            borderRadius: BorderRadius.circular(AppRadius.pill),
            child: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: highlightAction
                    ? AppColors.primary
                    : AppColors.surfaceSubdued,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: busy
                  ? const SizedBox(
                      width: 14,
                      height: 14,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Icon(
                      _trailingIcon(),
                      size: 18,
                      color: highlightAction
                          ? AppColors.textInverse
                          : AppColors.textSecondary,
                    ),
            ),
          ),
        ],
      ),
    );
  }

  IconData _trailingIcon() {
    if (quest.claimed) return Icons.check_rounded;
    if (quest.claimable) return Icons.card_giftcard_rounded;
    return switch (quest.action) {
      RankingQuestAction.start => Icons.add_rounded,
      RankingQuestAction.continueAction => Icons.navigate_next_rounded,
      RankingQuestAction.write => Icons.edit_note_rounded,
    };
  }

  IconData _iconFor(String name) => switch (name) {
    'luggage' => Icons.luggage_rounded,
    'pin_drop' => Icons.pin_drop_rounded,
    'photo_camera' => Icons.photo_camera_rounded,
    _ => Icons.stars_rounded,
  };
}
