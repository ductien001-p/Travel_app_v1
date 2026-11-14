import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_shadows.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_pressable.dart';

import '../../data/models/trip_chat_models.dart';

class TripChatPinnedBar extends StatelessWidget {
  const TripChatPinnedBar({
    super.key,
    required this.activity,
    required this.onCheckIn,
    required this.onOpenDetails,
  });

  final TripChatPinnedActivity activity;
  final VoidCallback onCheckIn;
  final VoidCallback onOpenDetails;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.sm,
        AppSpacing.xs,
        AppSpacing.sm,
        4,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppRadius.card),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.glass90,
              borderRadius: BorderRadius.circular(AppRadius.card),
              border: Border.all(color: AppColors.borderBrandSoft),
              boxShadow: AppShadows.level1,
            ),
            child: Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: const BoxDecoration(
                    color: AppColors.primaryLight,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.location_on_rounded,
                    size: 18,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              activity.badgeLabel.toUpperCase(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTypography.badge.copyWith(
                                color: AppColors.primary,
                                fontSize: 10,
                                letterSpacing: 0.4,
                              ),
                            ),
                          ),
                          if (activity.dayChipLabel != null) ...[
                            const SizedBox(width: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 1,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFF99F2EC),
                                borderRadius: BorderRadius.circular(
                                  AppRadius.pill,
                                ),
                              ),
                              child: Text(
                                activity.dayChipLabel!,
                                style: AppTypography.caption.copyWith(
                                  fontSize: 10,
                                  color: const Color(0xFF00716D),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(
                        activity.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTypography.caption.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                AppPressable(
                  onTap: onCheckIn,
                  pressedScale: 0.94,
                  borderRadius: BorderRadius.circular(AppRadius.pill),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(AppRadius.pill),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          activity.checkInLabel ?? 'Check-in',
                          style: AppTypography.badge.copyWith(
                            color: AppColors.textInverse,
                            fontSize: 10,
                          ),
                        ),
                        const SizedBox(width: 2),
                        const Icon(
                          Icons.push_pin_rounded,
                          size: 12,
                          color: AppColors.textInverse,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 4),
                AppPressable(
                  onTap: onOpenDetails,
                  pressedScale: 0.9,
                  borderRadius: BorderRadius.circular(AppRadius.pill),
                  child: Container(
                    width: 28,
                    height: 28,
                    decoration: const BoxDecoration(
                      color: AppColors.surfaceSubdued,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.arrow_forward_rounded,
                      size: 14,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
