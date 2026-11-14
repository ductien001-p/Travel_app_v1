import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';

import '../../../application/trip_itinerary_share_controller.dart';

/// Share options for owners and admins; pops the chosen [TripShareAction].
class TripItineraryShareMenu extends StatelessWidget {
  const TripItineraryShareMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Chia sẻ lịch trình', style: AppTypography.cardTitle),
          const SizedBox(height: AppSpacing.xxs),
          Text(
            'Người nhận cần đăng nhập và chỉ xem được lịch trình.',
            style: AppTypography.caption.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(
              Icons.ios_share_rounded,
              color: AppColors.primary,
            ),
            title: Text(
              'Chia sẻ link lịch trình',
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
            onTap: () => context.pop(TripShareAction.share),
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(
              Icons.link_off_rounded,
              color: AppColors.danger,
            ),
            title: Text(
              'Thu hồi các link đã chia sẻ',
              style: AppTypography.bodyMedium.copyWith(color: AppColors.danger),
            ),
            onTap: () => context.pop(TripShareAction.revoke),
          ),
        ],
      ),
    );
  }
}
