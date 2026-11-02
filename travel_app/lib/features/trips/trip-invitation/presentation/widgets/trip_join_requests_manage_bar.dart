import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_shadows.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_glass_surface.dart';

import '../../../trip-details/presentation/widgets/trip_detail_pill_button.dart';

/// Floating pill leading to the member list of the trip.
class TripJoinRequestsManageBar extends StatelessWidget {
  const TripJoinRequestsManageBar({super.key, required this.onReviewMembers});

  final VoidCallback onReviewMembers;

  /// Share of the bar the action may take before it scales down.
  static const _actionMaxWidthFactor = 0.6;

  @override
  Widget build(BuildContext context) {
    return AppGlassSurface(
      radius: AppRadius.pill,
      shadows: AppShadows.level2,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs,
      ),
      child: LayoutBuilder(
        builder: (context, constraints) => Row(
          children: [
            Container(
              width: 10,
              height: 10,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(width: AppSpacing.xs),
            Expanded(
              child: Text(
                'Quản lý trực tiếp',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.xs),
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: constraints.maxWidth * _actionMaxWidthFactor,
              ),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: TripDetailPillButton(
                  label: 'Rà soát thành viên',
                  icon: Icons.manage_accounts_outlined,
                  variant: TripDetailPillVariant.outlined,
                  onPressed: onReviewMembers,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
