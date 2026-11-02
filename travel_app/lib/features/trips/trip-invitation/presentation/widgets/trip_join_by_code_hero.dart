import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_shadows.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';

import '../../data/datamock/trip_join_by_code_datamock.dart';

class TripJoinByCodeHero extends StatelessWidget {
  const TripJoinByCodeHero({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: AppSpacing.xs),
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppRadius.card),
                gradient: const LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [AppColors.primary20, AppColors.primaryLight],
                ),
                border: Border.all(color: AppColors.glassBorder),
                boxShadow: AppShadows.level1,
              ),
              alignment: Alignment.center,
              child: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(AppRadius.input),
                  boxShadow: AppShadows.primaryGlow,
                ),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.airplane_ticket_rounded,
                  color: AppColors.textInverse,
                  size: 28,
                ),
              ),
            ),
            Positioned(
              right: -4,
              bottom: -4,
              child: Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: const Color(0xFF99F2EC),
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.surface, width: 2),
                ),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.explore_rounded,
                  size: 14,
                  color: Color(0xFF00716D),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          'Nhập Mã Mời Chuyến Đi',
          textAlign: TextAlign.center,
          style: AppTypography.screenTitle,
        ),
        const SizedBox(height: AppSpacing.xxs),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          child: Text(
            'Nhận mã $tripInviteCodeLength ký tự từ Trưởng nhóm hoặc thành '
            'viên chuyến đi để gửi yêu cầu tham gia hành trình chung.',
            textAlign: TextAlign.center,
            style: AppTypography.caption.copyWith(
              color: AppColors.textSecondary,
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }
}
