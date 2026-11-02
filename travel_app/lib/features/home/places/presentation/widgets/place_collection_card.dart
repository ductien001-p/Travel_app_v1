import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_shadows.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_pressable.dart';

import '../../data/models/explore_places_models.dart';
import 'explore_place_cover.dart';

class PlaceCollectionCard extends StatelessWidget {
  const PlaceCollectionCard({
    super.key,
    required this.collection,
    required this.onOpen,
  });

  final PlaceCollection collection;
  final VoidCallback onOpen;

  @override
  Widget build(BuildContext context) {
    final overlay = switch (collection.tone) {
      PlaceCollectionTone.summer => AppColors.primary,
      PlaceCollectionTone.trend => AppColors.textPrimary,
    };
    final eyebrowColor = switch (collection.tone) {
      PlaceCollectionTone.summer => AppColors.primaryLight,
      PlaceCollectionTone.trend => AppColors.warning,
    };

    return AppPressable(
      onTap: onOpen,
      borderRadius: BorderRadius.circular(AppRadius.card),
      child: Container(
        width: 256,
        height: 128,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppRadius.card),
          boxShadow: AppShadows.level1,
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          fit: StackFit.expand,
          children: [
            ExplorePlaceCover(url: collection.imageUrl),
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    overlay.withValues(alpha: 0),
                    overlay.withValues(alpha: 0.40),
                    overlay.withValues(alpha: 0.90),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    collection.eyebrow.toUpperCase(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.badge.copyWith(color: eyebrowColor),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    collection.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.cardTitle.copyWith(
                      color: AppColors.textInverse,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          collection.countLabel,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTypography.caption.copyWith(
                            color: AppColors.textInverse.withValues(alpha: 0.9),
                          ),
                        ),
                      ),
                      const Icon(
                        Icons.arrow_forward_rounded,
                        size: 16,
                        color: AppColors.textInverse,
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
