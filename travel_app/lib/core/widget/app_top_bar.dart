import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_sizes.dart';
import '../theme/app_typography.dart';
import 'app_glass_surface.dart';
import 'app_icon_button.dart';

class AppTopBar extends StatelessWidget {
  const AppTopBar({
    super.key,
    required this.title,
    this.onBack,
    this.action,
    this.transparent = false,
  });

  final String title;
  final VoidCallback? onBack;
  final Widget? action;
  final bool transparent;

  @override
  Widget build(BuildContext context) {
    final content = SizedBox(
      height: AppSizes.topBarMaxHeight,
      child: Row(
        children: [
          SizedBox(
            width: AppSizes.iconButton,
            child: onBack == null
                ? const SizedBox.shrink()
                : AppIconButton(
                    icon: Icons.arrow_back_rounded,
                    onPressed: onBack,
                    semanticLabel: 'Back',
                  ),
          ),
          Expanded(
            child: Text(
              title,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTypography.screenTitle,
            ),
          ),
          SizedBox(
            width: AppSizes.iconButton,
            child: Align(
              alignment: Alignment.centerRight,
              child: action ?? const SizedBox.shrink(),
            ),
          ),
        ],
      ),
    );

    if (transparent) return content;

    return AppGlassSurface(
      radius: 0,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      color: AppColors.glass85,
      shadows: const [],
      child: content,
    );
  }
}
