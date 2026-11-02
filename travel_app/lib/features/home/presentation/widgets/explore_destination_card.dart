import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_shadows.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_glass_surface.dart';
import 'package:travel_frontend_v1/core/widget/app_pressable.dart';

import '../../data/models/explore_home_models.dart';

class ExploreDestinationCard extends StatelessWidget {
  const ExploreDestinationCard({
    super.key,
    required this.destination,
    this.onTap,
  });

  final ExploreDestination destination;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return AppPressable(
      onTap: onTap,
      pressedScale: 0.97,
      borderRadius: BorderRadius.circular(AppRadius.card),
      child: AppGlassSurface(
        radius: AppRadius.card,
        padding: const EdgeInsets.all(10),
        shadows: AppShadows.level1,
        child: SizedBox(
          width: 136,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(AppRadius.input),
                child: Stack(
                  children: [
                    Image.network(
                      destination.imageUrl,
                      width: double.infinity,
                      height: 96,
                      fit: BoxFit.cover,
                      errorBuilder: (_, _, _) => Container(
                        width: double.infinity,
                        height: 96,
                        color: AppColors.primaryLight,
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.landscape_rounded,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 6,
                      right: 6,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.glass85,
                          borderRadius: BorderRadius.circular(AppRadius.pill),
                        ),
                        child: Text(
                          '${destination.openTripCount} chuyến',
                          style: AppTypography.badge.copyWith(
                            color: AppColors.primary,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                destination.name,
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w700,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                '${destination.openTripCount} chuyến đi mở',
                style: AppTypography.caption.copyWith(fontSize: 11),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
