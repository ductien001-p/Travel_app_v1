import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';

import '../../data/models/trip_detail_models.dart';
import 'trip_detail_pill_button.dart';

class TripDetailRewardCard extends StatelessWidget {
  const TripDetailRewardCard({
    super.key,
    required this.reward,
    required this.isClaiming,
    required this.onClaim,
  });

  final TripDetailCompletionReward reward;
  final bool isClaiming;
  final VoidCallback? onClaim;

  @override
  Widget build(BuildContext context) {
    final claimable = reward.canClaim && !reward.claimed;
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.primary12,
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(color: AppColors.primary20),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: AppColors.primaryActive,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.stars_rounded,
              size: 20,
              color: AppColors.textInverse,
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  reward.claimed
                      ? 'Đã nhận +${reward.points} điểm'
                      : 'Hoàn thành nhận +${reward.points} điểm',
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  'Đạt chuẩn mọi điểm đến để chia thưởng du lịch',
                  style: AppTypography.caption.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.xs),
          TripDetailPillButton(
            label: reward.claimed ? 'Đã nhận' : 'Nhận quà',
            variant: claimable
                ? TripDetailPillVariant.filled
                : TripDetailPillVariant.outlined,
            isLoading: isClaiming,
            onPressed: claimable ? onClaim : null,
          ),
        ],
      ),
    );
  }
}
