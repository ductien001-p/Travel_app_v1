import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_radius.dart';
import '../theme/app_typography.dart';
import 'app_pressable.dart';

class AppChip extends StatelessWidget {
  const AppChip({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
    this.leadingIcon,
  });

  final String label;
  final bool selected;
  final VoidCallback? onTap;
  final IconData? leadingIcon;

  @override
  Widget build(BuildContext context) {
    final foreground = selected
        ? AppColors.textInverse
        : AppColors.textSecondary;

    return AppPressable(
      onTap: onTap,
      pressedScale: 0.95,
      borderRadius: BorderRadius.circular(AppRadius.pill),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        height: 36,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: selected ? AppColors.primary : AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.pill),
          border: Border.all(
            color: selected ? AppColors.primary : AppColors.borderNeutral,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (leadingIcon != null) ...[
              Icon(leadingIcon, size: 16, color: foreground),
              const SizedBox(width: 6),
            ],
            Text(
              label,
              style: AppTypography.bodyMedium.copyWith(
                fontSize: 13,
                color: foreground,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
