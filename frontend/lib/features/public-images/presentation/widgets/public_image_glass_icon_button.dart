import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_sizes.dart';
import 'package:travel_frontend_v1/core/widget/app_pressable.dart';

class PublicImageGlassIconButton extends StatelessWidget {
  const PublicImageGlassIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.semanticLabel,
    this.highlighted = false,
  });

  final IconData icon;
  final VoidCallback? onPressed;
  final String? semanticLabel;
  final bool highlighted;

  @override
  Widget build(BuildContext context) {
    final bg = highlighted
        ? AppColors.primary.withValues(alpha: 0.20)
        : AppColors.textInverse.withValues(alpha: 0.10);
    final border = highlighted
        ? AppColors.primary.withValues(alpha: 0.60)
        : AppColors.textInverse.withValues(alpha: 0.20);
    final iconColor = highlighted
        ? const Color(0xFF84F5EF)
        : AppColors.textInverse;

    return Semantics(
      button: true,
      label: semanticLabel,
      child: AppPressable(
        onTap: onPressed,
        pressedScale: 0.92,
        borderRadius: BorderRadius.circular(AppRadius.pill),
        child: Container(
          width: AppSizes.iconButton,
          height: AppSizes.iconButton,
          decoration: BoxDecoration(
            color: bg,
            shape: BoxShape.circle,
            border: Border.all(color: border),
          ),
          alignment: Alignment.center,
          child: Icon(icon, size: 20, color: iconColor),
        ),
      ),
    );
  }
}
