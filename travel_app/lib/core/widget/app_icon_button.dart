import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_radius.dart';
import '../theme/app_shadows.dart';
import '../theme/app_sizes.dart';
import 'app_pressable.dart';

class AppIconButton extends StatelessWidget {
  const AppIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.iconColor = AppColors.textSecondary,
    this.backgroundColor = AppColors.glass90,
    this.semanticLabel,
  });

  final IconData icon;
  final VoidCallback? onPressed;
  final Color iconColor;
  final Color backgroundColor;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: semanticLabel,
      child: AppPressable(
        onTap: onPressed,
        pressedScale: 0.90,
        borderRadius: BorderRadius.circular(AppRadius.pill),
        child: Container(
          width: AppSizes.iconButton,
          height: AppSizes.iconButton,
          decoration: BoxDecoration(
            color: backgroundColor,
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.glassBorder),
            boxShadow: AppShadows.level1,
          ),
          alignment: Alignment.center,
          child: Icon(icon, size: 20, color: iconColor),
        ),
      ),
    );
  }
}
