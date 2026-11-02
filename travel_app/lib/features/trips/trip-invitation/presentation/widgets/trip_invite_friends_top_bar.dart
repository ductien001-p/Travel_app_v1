import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_icon_button.dart';

class TripInviteFriendsTopBar extends StatelessWidget {
  const TripInviteFriendsTopBar({
    super.key,
    required this.onBack,
    required this.onShowInviteCode,
    this.tripName,
    this.slotsLabel,
  });

  final VoidCallback onBack;
  final VoidCallback? onShowInviteCode;
  final String? tripName;
  final String? slotsLabel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.xs,
        AppSpacing.xs,
        AppSpacing.sm,
        AppSpacing.xs,
      ),
      child: Row(
        children: [
          AppIconButton(
            icon: Icons.arrow_back_rounded,
            onPressed: onBack,
            semanticLabel: 'Quay lại',
            iconColor: AppColors.primary,
            backgroundColor: AppColors.surface,
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Mời Bạn Đồng Hành',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.cardTitle,
                ),
                if (tripName != null)
                  Text(
                    slotsLabel == null ? tripName! : '$tripName · $slotsLabel',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.caption.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
              ],
            ),
          ),
          AppIconButton(
            icon: Icons.qr_code_rounded,
            onPressed: onShowInviteCode,
            semanticLabel: 'Mã mời chuyến đi',
            iconColor: AppColors.primary,
            backgroundColor: AppColors.surface,
          ),
        ],
      ),
    );
  }
}
