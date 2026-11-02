import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_button.dart';

class TripInviteFriendsBottomBar extends StatelessWidget {
  const TripInviteFriendsBottomBar({
    super.key,
    required this.selectedCount,
    required this.slotsLabel,
    required this.isSending,
    required this.canSend,
    required this.onSend,
  });

  final int selectedCount;
  final String slotsLabel;
  final bool isSending;
  final bool canSend;
  final VoidCallback onSend;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface.withValues(alpha: 0.92),
      elevation: 8,
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.screenHorizontal,
            AppSpacing.sm,
            AppSpacing.screenHorizontal,
            AppSpacing.sm,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Đã chọn $selectedCount bạn bè',
                      style: AppTypography.caption.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Text(
                    slotsLabel,
                    style: AppTypography.caption.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.xs),
              AppButton(
                label: 'Gửi lời mời tham gia ($selectedCount)',
                trailingIcon: Icons.rocket_launch_rounded,
                isLoading: isSending,
                onPressed: canSend ? onSend : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
