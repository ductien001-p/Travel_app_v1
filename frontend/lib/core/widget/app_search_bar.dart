import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_radius.dart';
import '../theme/app_sizes.dart';
import '../theme/app_typography.dart';
import 'app_icon_button.dart';

class AppSearchBar extends StatelessWidget {
  const AppSearchBar({
    super.key,
    this.controller,
    this.hintText = 'Search',
    this.onChanged,
    this.onFilterPressed,
  });

  final TextEditingController? controller;
  final String hintText;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onFilterPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: AppSizes.searchMinHeight),
      decoration: BoxDecoration(
        color: AppColors.glass90,
        borderRadius: BorderRadius.circular(AppRadius.pill),
        border: Border.all(color: AppColors.glassBorder),
      ),
      child: Row(
        children: [
          const SizedBox(width: 16),
          const Icon(
            Icons.search_rounded,
            size: 20,
            color: AppColors.textTertiary,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.textPrimary,
              ),
              decoration: InputDecoration(
                isCollapsed: true,
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                filled: false,
                hintText: hintText,
                hintStyle: AppTypography.body.copyWith(
                  color: AppColors.textTertiary,
                ),
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
          if (onFilterPressed != null) ...[
            AppIconButton(
              icon: Icons.tune_rounded,
              onPressed: onFilterPressed,
              semanticLabel: 'Filter',
              backgroundColor: Colors.transparent,
            ),
            const SizedBox(width: 4),
          ] else
            const SizedBox(width: 16),
        ],
      ),
    );
  }
}
