import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_shadows.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_glass_surface.dart';
import 'package:travel_frontend_v1/core/widget/app_pressable.dart';

import '../../data/models/explore_places_models.dart';
import 'explore_place_cover.dart';

class NearbyPlaceTile extends StatelessWidget {
  const NearbyPlaceTile({super.key, required this.place, this.onOpen});

  final NearbyPlace place;
  final VoidCallback? onOpen;

  @override
  Widget build(BuildContext context) {
    final travelIcon = switch (place.travelMode) {
      NearbyTravelMode.walk => Icons.directions_walk_rounded,
      NearbyTravelMode.drive => Icons.directions_car_rounded,
    };

    return AppPressable(
      onTap: onOpen,
      borderRadius: BorderRadius.circular(AppRadius.card),
      child: AppGlassSurface(
        radius: AppRadius.card,
        padding: const EdgeInsets.all(AppSpacing.sm),
        color: AppColors.glass90,
        borderColor: AppColors.borderBrandSoft,
        shadows: AppShadows.level1,
        child: Row(
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.primary20, width: 2),
              ),
              child: ClipOval(child: ExplorePlaceCover(url: place.imageUrl)),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primaryLight,
                          borderRadius: BorderRadius.circular(AppRadius.pill),
                        ),
                        child: Text(
                          place.categoryLabel,
                          style: AppTypography.badge.copyWith(
                            fontSize: 10,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.xs),
                      const Icon(
                        Icons.star_rounded,
                        size: 14,
                        color: AppColors.warning,
                      ),
                      Text(
                        place.rating.toStringAsFixed(1),
                        style: AppTypography.caption.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(width: 2),
                      Flexible(
                        child: Text(
                          '(${place.reviewCountLabel})',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTypography.caption,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    place.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.bodyMedium.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    place.address,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.caption,
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      Icon(travelIcon, size: 13, color: AppColors.primary),
                      const SizedBox(width: 2),
                      Text(
                        place.distanceLabel,
                        style: AppTypography.caption.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          '• ${place.travelLabel}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTypography.caption,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
