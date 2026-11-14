import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_shadows.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_avatar.dart';
import 'package:travel_frontend_v1/core/widget/app_pressable.dart';
import 'package:travel_frontend_v1/core/widget/app_progress_bar.dart';

import '../../application/ranking_view.dart';
import '../../data/models/ranking_models.dart';

class RankingMeCardWidget extends StatelessWidget {
  const RankingMeCardWidget({
    super.key,
    required this.me,
    required this.progress,
    required this.onHowToEarnTap,
  });

  final RankingMeCard me;
  final double progress;
  final VoidCallback onHowToEarnTap;

  @override
  Widget build(BuildContext context) {
    final deltaUp = me.rankDelta > 0;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.card),
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [Color(0xFFFFFFFF), Color(0xFFF3FBFA)],
        ),
        border: Border.all(color: AppColors.primary20),
        boxShadow: AppShadows.level1,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: AppShadows.level1,
                ),
                child: Column(
                  children: [
                    Text(
                      'HẠNG',
                      style: AppTypography.badge.copyWith(
                        color: AppColors.textInverse,
                        fontSize: 9,
                        letterSpacing: 1.2,
                      ),
                    ),
                    Text(
                      '#${me.rank}',
                      style: AppTypography.cardTitle.copyWith(
                        color: AppColors.textInverse,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              AppAvatar(
                size: 44,
                imageUrl: me.avatarUrl,
                initials: me.displayName,
                verified: me.verified,
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Bạn (${me.displayName})',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.bodyMedium.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        const Icon(
                          Icons.workspace_premium_rounded,
                          size: 14,
                          color: Color(0xFFD97706),
                        ),
                        const SizedBox(width: 2),
                        Text(
                          me.tierLabel,
                          style: AppTypography.caption.copyWith(
                            color: const Color(0xFFD97706),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          '•',
                          style: AppTypography.caption.copyWith(
                            color: AppColors.textTertiary,
                          ),
                        ),
                        Icon(
                          deltaUp
                              ? Icons.arrow_drop_up_rounded
                              : Icons.arrow_drop_down_rounded,
                          size: 18,
                          color: deltaUp
                              ? AppColors.success
                              : AppColors.textTertiary,
                        ),
                        Text(
                          rankingRankDeltaLabel(me.rankDelta),
                          style: AppTypography.caption.copyWith(
                            color: deltaUp
                                ? AppColors.success
                                : AppColors.textSecondary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    rankingPointsLabel(me.points, withUnit: true),
                    style: AppTypography.cardTitle.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    '${me.tripsCompleted} chuyến',
                    style: AppTypography.caption.copyWith(
                      color: AppColors.textTertiary,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Divider(height: 1, color: AppColors.borderBrandSoft),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              Expanded(
                child: Text.rich(
                  TextSpan(
                    style: AppTypography.caption.copyWith(
                      color: AppColors.textSecondary,
                    ),
                    children: [
                      const TextSpan(text: 'Tiến trình lên '),
                      TextSpan(
                        text: me.nextTierLabel,
                        style: const TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Text(
                '${rankingPointsLabel(me.points)} / ${rankingPointsLabel(me.nextTierPoints)} pts',
                style: AppTypography.caption.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          AppProgressBar(value: progress, height: 10),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(
                Icons.flag_rounded,
                size: 14,
                color: AppColors.primary,
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  me.progressHint,
                  style: AppTypography.caption.copyWith(
                    color: AppColors.textTertiary,
                  ),
                ),
              ),
              AppPressable(
                onTap: onHowToEarnTap,
                child: Row(
                  children: [
                    Text(
                      'Cách tích điểm',
                      style: AppTypography.caption.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Icon(
                      Icons.chevron_right_rounded,
                      size: 16,
                      color: AppColors.primary,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
