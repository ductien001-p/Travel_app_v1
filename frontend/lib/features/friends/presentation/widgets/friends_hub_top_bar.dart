import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_icon_button.dart';

class FriendsHubTopBar extends StatelessWidget {
  const FriendsHubTopBar({
    super.key,
    required this.friendsCountLabel,
    required this.onBack,
    required this.onSearchTap,
  });

  final String friendsCountLabel;
  final VoidCallback onBack;
  final VoidCallback onSearchTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.screenHorizontal,
        AppSpacing.sm,
        AppSpacing.screenHorizontal,
        AppSpacing.sm,
      ),
      child: Row(
        children: [
          AppIconButton(
            icon: Icons.arrow_back_rounded,
            onPressed: onBack,
            semanticLabel: 'Quay lại',
            backgroundColor: AppColors.glass90,
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Bạn Bè',
                  style: AppTypography.screenTitle.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  friendsCountLabel,
                  style: AppTypography.caption.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          AppIconButton(
            icon: Icons.search_rounded,
            onPressed: onSearchTap,
            semanticLabel: 'Tìm kiếm bạn bè',
            backgroundColor: AppColors.glass90,
            iconColor: AppColors.primary,
          ),
        ],
      ),
    );
  }
}
