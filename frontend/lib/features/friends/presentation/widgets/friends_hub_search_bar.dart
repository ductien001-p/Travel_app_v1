import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';

class FriendsHubSearchBar extends StatelessWidget {
  const FriendsHubSearchBar({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: AppColors.glass90,
        borderRadius: BorderRadius.circular(AppRadius.pill),
        border: Border.all(color: AppColors.borderBrandSoft),
        boxShadow: const [
          BoxShadow(
            color: AppColors.black03,
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          const SizedBox(width: AppSpacing.md),
          const Icon(
            Icons.person_search_rounded,
            size: 22,
            color: AppColors.primary,
          ),
          const SizedBox(width: AppSpacing.xs),
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              style: AppTypography.body.copyWith(color: AppColors.textPrimary),
              decoration: InputDecoration(
                isCollapsed: true,
                border: InputBorder.none,
                hintText: 'Tìm theo tên, @username hoặc thẻ sở thích...',
                hintStyle: AppTypography.body.copyWith(
                  color: AppColors.textTertiary,
                ),
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
        ],
      ),
    );
  }
}
