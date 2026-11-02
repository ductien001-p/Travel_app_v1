import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_radius.dart';
import '../theme/app_shadows.dart';
import '../theme/app_sizes.dart';
import '../theme/app_typography.dart';
import 'app_pressable.dart';

enum AppButtonVariant { primary, secondary, glass, destructive }

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.isLoading = false,
    this.leadingIcon,
    this.trailingIcon,
    this.expand = true,
  });

  final String label;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final bool isLoading;
  final IconData? leadingIcon;
  final IconData? trailingIcon;
  final bool expand;

  @override
  Widget build(BuildContext context) {
    final enabled = onPressed != null && !isLoading;

    final config = switch (variant) {
      AppButtonVariant.primary => _ButtonConfig(
        height: AppSizes.buttonPrimaryHeight,
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textInverse,
        borderColor: Colors.transparent,
        textStyle: AppTypography.buttonLarge,
        shadows: AppShadows.primaryGlow,
      ),
      AppButtonVariant.secondary => _ButtonConfig(
        height: AppSizes.buttonSecondaryHeight,
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.primary,
        borderColor: AppColors.primary,
        textStyle: AppTypography.buttonSmall.copyWith(color: AppColors.primary),
        shadows: const [],
      ),
      AppButtonVariant.glass => _ButtonConfig(
        height: AppSizes.buttonSecondaryHeight,
        backgroundColor: AppColors.glass75,
        foregroundColor: AppColors.textPrimary,
        borderColor: AppColors.glassBorder,
        textStyle: AppTypography.buttonSmall.copyWith(
          color: AppColors.textPrimary,
        ),
        shadows: AppShadows.level1,
      ),
      AppButtonVariant.destructive => _ButtonConfig(
        height: AppSizes.buttonPrimaryHeight,
        backgroundColor: AppColors.dangerStrong,
        foregroundColor: AppColors.textInverse,
        borderColor: Colors.transparent,
        textStyle: AppTypography.buttonLarge,
        shadows: const [
          BoxShadow(
            color: Color.fromRGBO(255, 90, 54, 0.30),
            offset: Offset(0, 10),
            blurRadius: 25,
            spreadRadius: -4,
          ),
        ],
      ),
    };

    final child = AppPressable(
      onTap: enabled ? onPressed : null,
      pressedScale: 0.98,
      borderRadius: BorderRadius.circular(AppRadius.pill),
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 150),
        opacity: enabled ? 1 : 0.55,
        child: Container(
          height: config.height,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: config.backgroundColor,
            borderRadius: BorderRadius.circular(AppRadius.pill),
            border: Border.all(
              color: config.borderColor,
              width: variant == AppButtonVariant.secondary ? 2 : 1,
            ),
            boxShadow: config.shadows,
          ),
          child: Row(
            mainAxisSize: expand ? MainAxisSize.max : MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isLoading)
                SizedBox.square(
                  dimension: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: config.foregroundColor,
                  ),
                )
              else ...[
                if (leadingIcon != null) ...[
                  Icon(leadingIcon, size: 20, color: config.foregroundColor),
                  const SizedBox(width: 8),
                ],
                if (expand)
                  Flexible(
                    child: Text(
                      label,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: config.textStyle,
                    ),
                  )
                else
                  Text(label, maxLines: 1, style: config.textStyle),
                if (trailingIcon != null) ...[
                  const SizedBox(width: 8),
                  Icon(trailingIcon, size: 20, color: config.foregroundColor),
                ],
              ],
            ],
          ),
        ),
      ),
    );

    return expand ? SizedBox(width: double.infinity, child: child) : child;
  }
}

class _ButtonConfig {
  const _ButtonConfig({
    required this.height,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.borderColor,
    required this.textStyle,
    required this.shadows,
  });

  final double height;
  final Color backgroundColor;
  final Color foregroundColor;
  final Color borderColor;
  final TextStyle textStyle;
  final List<BoxShadow> shadows;
}
