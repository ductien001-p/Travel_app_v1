import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_shadows.dart';
import 'package:travel_frontend_v1/core/theme/app_sizes.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_button.dart';
import 'package:travel_frontend_v1/core/widget/app_glass_surface.dart';
import 'package:travel_frontend_v1/core/widget/app_icon_button.dart';

class TripItineraryTopBar extends StatelessWidget {
  const TripItineraryTopBar({
    super.key,
    required this.tripName,
    required this.onBack,
    this.onShare,
    this.onOpenMap,
  });

  final String? tripName;
  final VoidCallback onBack;
  final VoidCallback? onShare;
  final VoidCallback? onOpenMap;

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
        height: AppSizes.topBarMaxHeight + AppSpacing.xs,
        child: Row(
          children: [
            AppIconButton(
              icon: Icons.arrow_back_ios_new_rounded,
              iconColor: AppColors.textPrimary,
              onPressed: onBack,
              semanticLabel: 'Quay lại',
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Lịch trình chuyến đi',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.screenTitle,
                  ),
                  if (tripName != null)
                    Row(
                      children: [
                        const Icon(
                          Icons.luggage_outlined,
                          size: 13,
                          color: AppColors.primary,
                        ),
                        const SizedBox(width: AppSpacing.xxs),
                        Flexible(
                          child: Text(
                            tripName!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTypography.caption.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
            if (onShare != null) ...[
              const SizedBox(width: AppSpacing.xs),
              AppIconButton(
                icon: Icons.share_outlined,
                iconColor: AppColors.primary,
                onPressed: onShare,
                semanticLabel: 'Chia sẻ lịch trình',
              ),
            ],
            if (onOpenMap != null) ...[
              const SizedBox(width: 6),
              AppIconButton(
                icon: Icons.map_outlined,
                iconColor: AppColors.primary,
                onPressed: onOpenMap,
                semanticLabel: 'Xem bản đồ',
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class TripItineraryBottomBar extends StatelessWidget {
  const TripItineraryBottomBar({
    super.key,
    required this.onExploreRoute,
    required this.onViewOverview,
  });

  final VoidCallback onExploreRoute;
  final VoidCallback onViewOverview;

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
              AppIconButton(
                icon: Icons.explore_outlined,
                iconColor: AppColors.primary,
                backgroundColor: AppColors.surface,
                onPressed: onExploreRoute,
                semanticLabel: 'Bản đồ tuyến đường',
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: AppButton(
                  label: 'Xem tổng quan chuyến đi',
                  trailingIcon: Icons.arrow_forward_rounded,
                  onPressed: onViewOverview,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
