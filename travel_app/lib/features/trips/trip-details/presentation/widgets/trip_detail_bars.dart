import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_shadows.dart';
import 'package:travel_frontend_v1/core/theme/app_sizes.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_button.dart';
import 'package:travel_frontend_v1/core/widget/app_glass_surface.dart';
import 'package:travel_frontend_v1/core/widget/app_icon_button.dart';
import 'package:travel_frontend_v1/core/widget/app_pressable.dart';

class TripDetailTopBar extends StatelessWidget {
  const TripDetailTopBar({
    super.key,
    required this.title,
    required this.onBack,
    this.onShare,
    this.onMore,
  });

  final String? title;
  final VoidCallback onBack;
  final VoidCallback? onShare;
  final VoidCallback? onMore;

  @override
  Widget build(BuildContext context) {
    return AppGlassSurface(
      radius: 0,
      color: AppColors.glass85,
      shadows: const [],
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.screenHorizontal,
      ),
      child: SizedBox(
        height: AppSizes.topBarMaxHeight,
        child: Row(
          children: [
            AppIconButton(
              icon: Icons.arrow_back_rounded,
              iconColor: AppColors.textPrimary,
              onPressed: onBack,
              semanticLabel: 'Quay lại',
            ),
            const SizedBox(width: AppSpacing.xs),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'CHI TIẾT HÀNH TRÌNH',
                    style: AppTypography.badge.copyWith(
                      color: AppColors.primaryActive,
                    ),
                  ),
                  if (title != null)
                    Text(
                      title!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: AppTypography.cardTitle,
                    ),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.xs),
            if (onShare != null) ...[
              AppIconButton(
                icon: Icons.share_outlined,
                iconColor: AppColors.textPrimary,
                onPressed: onShare,
                semanticLabel: 'Chia sẻ chuyến đi',
              ),
              const SizedBox(width: 6),
            ],
            if (onMore != null)
              AppIconButton(
                icon: Icons.more_vert_rounded,
                iconColor: AppColors.textPrimary,
                onPressed: onMore,
                semanticLabel: 'Thao tác thêm',
              ),
          ],
        ),
      ),
    );
  }
}

class TripDetailBottomBar extends StatelessWidget {
  const TripDetailBottomBar({
    super.key,
    required this.onExpenses,
    required this.onViewItinerary,
  });

  final VoidCallback onExpenses;
  final VoidCallback onViewItinerary;

  @override
  Widget build(BuildContext context) {
    return AppGlassSurface(
      radius: 0,
      color: AppColors.glass85,
      shadows: AppShadows.level2,
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Row(
            children: [
              Semantics(
                button: true,
                label: 'Quản lý chi tiêu nhóm',
                child: AppPressable(
                  onTap: onExpenses,
                  pressedScale: 0.92,
                  borderRadius: BorderRadius.circular(AppSizes.fabSize),
                  child: Container(
                    width: AppSizes.fabSize,
                    height: AppSizes.fabSize,
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.borderBrandSoft),
                      boxShadow: AppShadows.level1,
                    ),
                    child: const Icon(
                      Icons.receipt_long_outlined,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: AppButton(
                  label: 'Xem Lịch Trình Chi Tiết',
                  trailingIcon: Icons.arrow_forward_rounded,
                  onPressed: onViewItinerary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
