import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_glass_surface.dart';

import '../../data/models/explore_home_models.dart';

class ExploreLiveTripCard extends StatelessWidget {
  const ExploreLiveTripCard({super.key, required this.update});

  final LiveTripUpdate update;

  @override
  Widget build(BuildContext context) {
    return AppGlassSurface(
      radius: AppRadius.card,
      padding: const EdgeInsets.all(14),
      color: AppColors.glass85,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primary08,
              border: Border.all(color: AppColors.primary12),
            ),
            alignment: Alignment.center,
            child: const Icon(
              Icons.location_on_rounded,
              color: AppColors.primary,
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
                    Text(
                      'LIVE CHECK-IN',
                      style: AppTypography.badge.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.schedule_rounded,
                      size: 12,
                      color: AppColors.textTertiary,
                    ),
                    const SizedBox(width: 2),
                    Text(
                      '${update.minutesAgo} phút trước',
                      style: AppTypography.caption.copyWith(fontSize: 11),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  update.title,
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text.rich(
                  TextSpan(
                    style: AppTypography.caption.copyWith(
                      color: AppColors.textSecondary,
                    ),
                    children: [
                      const TextSpan(text: 'Đang check-in tại '),
                      TextSpan(
                        text: update.placeLabel,
                        style: const TextStyle(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const TextSpan(text: ' • '),
                      TextSpan(
                        text: '${update.memberCount} thành viên',
                        style: const TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
