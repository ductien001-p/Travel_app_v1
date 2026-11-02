import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_shadows.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_glass_surface.dart';
import 'package:travel_frontend_v1/core/widget/app_pressable.dart';

class TripExpensesBottomBar extends StatelessWidget {
  const TripExpensesBottomBar({
    super.key,
    required this.onAddExpense,
    required this.onSettle,
  });

  final VoidCallback onAddExpense;
  final VoidCallback onSettle;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.screenHorizontal,
          0,
          AppSpacing.screenHorizontal,
          AppSpacing.sm,
        ),
        child: AppGlassSurface(
          radius: AppRadius.pill,
          color: AppColors.glass85,
          blurSigma: 24,
          padding: const EdgeInsets.all(AppSpacing.xs),
          shadows: AppShadows.level3,
          child: Row(
            children: [
              Expanded(
                child: AppPressable(
                  onTap: onAddExpense,
                  pressedScale: 0.95,
                  borderRadius: BorderRadius.circular(AppRadius.pill),
                  child: Container(
                    height: 48,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(AppRadius.pill),
                      boxShadow: AppShadows.primaryGlow,
                    ),
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.add_circle_rounded,
                            size: 22,
                            color: AppColors.textInverse,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Thêm khoản chi',
                            maxLines: 1,
                            softWrap: false,
                            style: AppTypography.sectionTitle.copyWith(
                              fontSize: 15,
                              color: AppColors.textInverse,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.xs),
              AppPressable(
                onTap: onSettle,
                pressedScale: 0.95,
                borderRadius: BorderRadius.circular(AppRadius.pill),
                child: Container(
                  height: 48,
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primaryLight,
                    borderRadius: BorderRadius.circular(AppRadius.pill),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.receipt_long_rounded,
                        size: 18,
                        color: AppColors.primary,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'Tất toán',
                        style: AppTypography.caption.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
