import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_pressable.dart';

import '../../data/models/friend_chat_models.dart';

class FriendChatSharedTripBanner extends StatelessWidget {
  const FriendChatSharedTripBanner({
    super.key,
    required this.sharedTrip,
    required this.onTap,
  });

  final FriendChatSharedTrip sharedTrip;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final destination = sharedTrip.destinationHint;
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.sm + 2,
        AppSpacing.xs,
        AppSpacing.sm + 2,
        AppSpacing.xs,
      ),
      child: AppPressable(
        onTap: onTap,
        pressedScale: 0.98,
        borderRadius: BorderRadius.circular(AppRadius.pill),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.glass90,
            borderRadius: BorderRadius.circular(AppRadius.pill),
            border: Border.all(color: AppColors.surface),
            boxShadow: const [
              BoxShadow(
                color: AppColors.black03,
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: const BoxDecoration(
                  color: AppColors.primaryLight,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.luggage_rounded,
                  size: 15,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(width: AppSpacing.xs),
              Expanded(
                child: Text.rich(
                  TextSpan(
                    style: AppTypography.caption.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                    children: [
                      const TextSpan(text: 'Chuyến đi chung: '),
                      TextSpan(
                        text: sharedTrip.title,
                        style: const TextStyle(color: AppColors.primary),
                      ),
                      if (destination != null && destination.isNotEmpty)
                        TextSpan(text: ' ($destination)'),
                    ],
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: AppSpacing.xs),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0x9999F2EC),
                  borderRadius: BorderRadius.circular(AppRadius.pill),
                ),
                child: Text(
                  sharedTrip.statusLabel.toUpperCase(),
                  style: AppTypography.badge.copyWith(
                    fontSize: 10,
                    color: const Color(0xFF00716D),
                    letterSpacing: 0.6,
                  ),
                ),
              ),
              const Icon(
                Icons.chevron_right_rounded,
                size: 18,
                color: AppColors.textTertiary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
