import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_shadows.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_pressable.dart';

enum TripDetailPillVariant { filled, outlined }

/// Compact pill action used inside cards, where [AppButton] is too tall.
class TripDetailPillButton extends StatelessWidget {
  const TripDetailPillButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.variant = TripDetailPillVariant.filled,
    this.isLoading = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final TripDetailPillVariant variant;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final enabled = onPressed != null && !isLoading;
    final filled = variant == TripDetailPillVariant.filled;
    final foreground = filled ? AppColors.textInverse : AppColors.primaryActive;

    return Semantics(
      button: true,
      enabled: enabled,
      label: label,
      child: AppPressable(
        onTap: enabled ? onPressed : null,
        borderRadius: BorderRadius.circular(AppRadius.pill),
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 150),
          opacity: enabled || isLoading ? 1 : 0.55,
          child: Container(
            constraints: const BoxConstraints(minHeight: 36),
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
            decoration: BoxDecoration(
              color: filled ? AppColors.primary : AppColors.surface,
              borderRadius: BorderRadius.circular(AppRadius.pill),
              border: Border.all(
                color: filled ? Colors.transparent : AppColors.borderBrandSoft,
              ),
              boxShadow: filled ? AppShadows.primaryGlow : AppShadows.level1,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (isLoading)
                  SizedBox.square(
                    dimension: 14,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: foreground,
                    ),
                  )
                else if (icon != null)
                  Icon(icon, size: 14, color: foreground),
                if (isLoading || icon != null) const SizedBox(width: 4),
                Text(
                  label,
                  style: AppTypography.badge.copyWith(color: foreground),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
