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

class FeaturedPlaceCard extends StatelessWidget {
  const FeaturedPlaceCard({
    super.key,
    required this.place,
    required this.bookmarked,
    this.onOpen,
    required this.onBookmark,
  });

  final FeaturedPlace place;
  final bool bookmarked;
  final VoidCallback? onOpen;
  final VoidCallback onBookmark;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 288,
      child: AppPressable(
        onTap: onOpen,
        borderRadius: BorderRadius.circular(AppRadius.card),
        child: AppGlassSurface(
          radius: AppRadius.card,
          color: AppColors.glass90,
          borderColor: AppColors.borderBrandSoft,
          shadows: AppShadows.level1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _FeaturedCover(
                place: place,
                bookmarked: bookmarked,
                onBookmark: onBookmark,
              ),
              Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      place.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.cardTitle,
                    ),
                    const SizedBox(height: AppSpacing.xxs),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on_rounded,
                          size: 14,
                          color: AppColors.primary,
                        ),
                        const SizedBox(width: 2),
                        Expanded(
                          child: Text(
                            place.locationLabel,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTypography.caption.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    const Divider(height: 1, color: AppColors.borderNeutral),
                    const SizedBox(height: AppSpacing.xs),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            place.tagline,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTypography.caption,
                          ),
                        ),
                        Text(
                          'Khám phá →',
                          style: AppTypography.caption.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w700,
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
      ),
    );
  }
}

class _FeaturedCover extends StatelessWidget {
  const _FeaturedCover({
    required this.place,
    required this.bookmarked,
    required this.onBookmark,
  });

  final FeaturedPlace place;
  final bool bookmarked;
  final VoidCallback onBookmark;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 176,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          ExplorePlaceCover(url: place.imageUrl),
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromRGBO(0, 0, 0, 0.20),
                  Color.fromRGBO(0, 0, 0, 0),
                  Color.fromRGBO(0, 0, 0, 0.60),
                ],
                stops: [0, 0.45, 1],
              ),
            ),
          ),
          Positioned(
            top: 10,
            left: 10,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
              decoration: BoxDecoration(
                color: AppColors.glass85,
                borderRadius: BorderRadius.circular(AppRadius.pill),
              ),
              child: Text(
                place.categoryLabel,
                style: AppTypography.badge.copyWith(color: AppColors.primary),
              ),
            ),
          ),
          Positioned(
            top: 10,
            right: 10,
            child: AppPressable(
              key: Key('featured-bookmark-${place.id}'),
              onTap: onBookmark,
              pressedScale: 0.92,
              borderRadius: BorderRadius.circular(AppRadius.pill),
              child: Container(
                width: 32,
                height: 32,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: AppColors.glass90,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  bookmarked
                      ? Icons.bookmark_rounded
                      : Icons.bookmark_border_rounded,
                  size: 18,
                  color: bookmarked
                      ? AppColors.primary
                      : AppColors.textSecondary,
                ),
              ),
            ),
          ),
          Positioned(
            left: 12,
            bottom: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: const Color.fromRGBO(0, 0, 0, 0.40),
                borderRadius: BorderRadius.circular(AppRadius.pill),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.star_rounded,
                    size: 15,
                    color: AppColors.warning,
                  ),
                  const SizedBox(width: 2),
                  Text(
                    place.rating.toStringAsFixed(1),
                    style: AppTypography.caption.copyWith(
                      color: AppColors.textInverse,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '(${place.saveCountLabel})',
                    style: AppTypography.caption.copyWith(
                      color: AppColors.textInverse.withValues(alpha: 0.8),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
