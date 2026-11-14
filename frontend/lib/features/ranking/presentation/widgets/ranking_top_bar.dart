import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_icon_button.dart';

class RankingTopBar extends StatelessWidget {
  const RankingTopBar({
    super.key,
    required this.seasonLabel,
    required this.onBack,
    required this.onHelpTap,
  });

  final String seasonLabel;
  final VoidCallback onBack;
  final VoidCallback onHelpTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.screenHorizontal,
        AppSpacing.sm,
        AppSpacing.screenHorizontal,
        AppSpacing.xs,
      ),
      child: Row(
        children: [
          AppIconButton(
            icon: Icons.arrow_back_rounded,
            onPressed: onBack,
            semanticLabel: 'Quay lại',
            backgroundColor: AppColors.surface,
          ),
          Expanded(
            child: Column(
              children: [
                Text(
                  'Bảng Xếp Hạng',
                  textAlign: TextAlign.center,
                  style: AppTypography.screenTitle.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.military_tech_rounded,
                      size: 14,
                      color: AppColors.primary,
                    ),
                    const SizedBox(width: 4),
                    Flexible(
                      child: Text(
                        seasonLabel,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTypography.caption.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          AppIconButton(
            icon: Icons.help_outline_rounded,
            onPressed: onHelpTap,
            semanticLabel: 'Thể lệ giải đấu',
            backgroundColor: AppColors.surface,
            iconColor: AppColors.primary,
          ),
        ],
      ),
    );
  }
}
