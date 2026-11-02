import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_sizes.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_glass_surface.dart';
import 'package:travel_frontend_v1/core/widget/app_icon_button.dart';

class TripExpensesTopBar extends StatelessWidget {
  const TripExpensesTopBar({
    super.key,
    required this.onBack,
    this.tripName,
    this.onSettings,
  });

  final VoidCallback onBack;
  final String? tripName;
  final VoidCallback? onSettings;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.screenHorizontal,
        AppSpacing.xs,
        AppSpacing.screenHorizontal,
        AppSpacing.sm,
      ),
      child: AppGlassSurface(
        radius: AppRadius.pill,
        color: AppColors.glass85,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            minHeight: AppSizes.topBarMaxHeight,
          ),
          child: Row(
            children: [
              AppIconButton(
                icon: Icons.arrow_back_rounded,
                iconColor: AppColors.primaryActive,
                backgroundColor: AppColors.surfaceSubdued,
                onPressed: onBack,
                semanticLabel: 'Quay lại',
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Chi tiêu & Quỹ nhóm',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.cardTitle,
                    ),
                    if (tripName != null)
                      Row(
                        children: [
                          const Icon(
                            Icons.luggage_rounded,
                            size: 14,
                            color: AppColors.primary,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              'Chuyến đi: $tripName',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTypography.caption.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
              if (onSettings != null)
                AppIconButton(
                  icon: Icons.tune_rounded,
                  iconColor: AppColors.textSecondary,
                  backgroundColor: AppColors.surfaceSubdued,
                  onPressed: onSettings,
                  semanticLabel: 'Cài đặt quỹ',
                ),
            ],
          ),
        ),
      ),
    );
  }
}
