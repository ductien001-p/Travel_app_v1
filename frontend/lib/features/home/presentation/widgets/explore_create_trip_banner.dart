import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_shadows.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_pressable.dart';

class ExploreCreateTripBanner extends StatelessWidget {
  const ExploreCreateTripBanner({
    super.key,
    required this.onCreateTrip,
    this.label = 'Đăng chuyến đi',
    this.isLoading = false,
  });

  final VoidCallback? onCreateTrip;
  final String label;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.card),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primaryLight,
            Color(0xFFE6F6FF),
            AppColors.surface,
          ],
        ),
        border: Border.all(color: AppColors.glassBorder),
        boxShadow: AppShadows.level1,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.glass85,
                    borderRadius: BorderRadius.circular(AppRadius.pill),
                    border: Border.all(color: AppColors.borderBrandSoft),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.auto_awesome_rounded,
                        size: 14,
                        color: AppColors.primary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Khởi tạo hành trình',
                        style: AppTypography.badge.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  'Đang có kế hoạch du lịch?',
                  style: AppTypography.sectionTitle.copyWith(fontSize: 18),
                ),
                const SizedBox(height: 4),
                Text(
                  'Đăng chuyến đi để kết nối những người bạn cùng gu, '
                  'chia sẻ chi phí & trải nghiệm!',
                  style: AppTypography.caption.copyWith(
                    color: AppColors.textSecondary,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Column(
            children: [
              Icon(
                Icons.explore_outlined,
                size: 36,
                color: AppColors.primary.withValues(alpha: 0.35),
              ),
              const SizedBox(height: AppSpacing.sm),
              AppPressable(
                onTap: isLoading ? null : onCreateTrip,
                pressedScale: 0.95,
                borderRadius: BorderRadius.circular(AppRadius.pill),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: isLoading
                        ? AppColors.primary.withValues(alpha: 0.7)
                        : AppColors.primary,
                    borderRadius: BorderRadius.circular(AppRadius.pill),
                    boxShadow: AppShadows.primaryGlow,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (isLoading)
                        const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: AppColors.textInverse,
                          ),
                        )
                      else
                        const Icon(
                          Icons.add_rounded,
                          size: 16,
                          color: AppColors.textInverse,
                        ),
                      const SizedBox(width: 4),
                      Text(
                        label,
                        style: AppTypography.caption.copyWith(
                          color: AppColors.textInverse,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
