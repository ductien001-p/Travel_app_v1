import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_shadows.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_glass_surface.dart';
import 'package:travel_frontend_v1/core/widget/app_pressable.dart';

import '../../application/featured_destinations_view.dart';
import 'explore_place_cover.dart';

class FeaturedDestinationHeroCard extends StatelessWidget {
  const FeaturedDestinationHeroCard({
    super.key,
    required this.place,
    required this.onOpen,
    required this.onBookmark,
  });

  final FeaturedDestinationCardData place;
  final VoidCallback onOpen;
  final VoidCallback onBookmark;

  @override
  Widget build(BuildContext context) {
    return AppPressable(
      onTap: onOpen,
      borderRadius: BorderRadius.circular(AppRadius.card),
      child: AppGlassSurface(
        radius: AppRadius.card,
        color: AppColors.glass90,
        borderColor: AppColors.borderBrandSoft,
        shadows: AppShadows.level1,
        child: SizedBox(
          height: 256,
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
                      Color.fromRGBO(14, 30, 36, 0.20),
                      Color.fromRGBO(14, 30, 36, 0.30),
                      AppColors.heroOverlay,
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(AppSpacing.sm),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        _RatingPill(label: place.ratingLabel),
                        const Spacer(),
                        _BookmarkButton(
                          placeId: place.id,
                          bookmarked: place.bookmarked,
                          filled: place.bookmarked,
                          onPressed: onBookmark,
                        ),
                      ],
                    ),
                    const Spacer(),
                    Text(
                      place.categoryLabel.toUpperCase(),
                      style: AppTypography.badge.copyWith(
                        color: AppColors.primaryLight,
                      ),
                    ),
                    Text(
                      place.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.sectionTitle.copyWith(
                        color: AppColors.textInverse,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xxs),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on_rounded,
                          size: 14,
                          color: AppColors.primaryLight,
                        ),
                        const SizedBox(width: 2),
                        Expanded(
                          child: Text(
                            place.locationLabel,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTypography.caption.copyWith(
                              color: AppColors.surfaceSubdued,
                            ),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.xs),
                        Text(
                          place.saveLabel,
                          style: AppTypography.caption.copyWith(
                            color: AppColors.surfaceSubdued,
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

class FeaturedDestinationTile extends StatelessWidget {
  const FeaturedDestinationTile({
    super.key,
    required this.place,
    required this.onOpen,
    required this.onBookmark,
  });

  final FeaturedDestinationCardData place;
  final VoidCallback onOpen;
  final VoidCallback onBookmark;

  @override
  Widget build(BuildContext context) {
    return AppPressable(
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
            SizedBox(
              height: 144,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  ExplorePlaceCover(url: place.imageUrl),
                  Positioned(
                    top: AppSpacing.xs,
                    left: AppSpacing.xs,
                    child: _RatingPill(label: place.ratingLabel),
                  ),
                  Positioned(
                    top: AppSpacing.xs,
                    right: AppSpacing.xs,
                    child: _BookmarkButton(
                      placeId: place.id,
                      bookmarked: place.bookmarked,
                      filled: place.bookmarked,
                      compact: true,
                      onPressed: onBookmark,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.xs,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primaryLight,
                      borderRadius: BorderRadius.circular(AppRadius.pill),
                    ),
                    child: Text(
                      place.categoryLabel,
                      style: AppTypography.badge.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xxs),
                  Text(
                    place.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.cardTitle,
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_rounded,
                        size: 12,
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
                  const SizedBox(height: AppSpacing.xs),
                  const Divider(height: 1, color: AppColors.borderBrandSoft),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    place.saveLabel,
                    style: AppTypography.caption.copyWith(
                      color: AppColors.textTertiary,
                    ),
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

class _RatingPill extends StatelessWidget {
  const _RatingPill({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.glass90,
        borderRadius: BorderRadius.circular(AppRadius.pill),
        border: Border.all(color: AppColors.glassBorder),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.star_rounded, size: 14, color: AppColors.warning),
            const SizedBox(width: 2),
            Text(label, style: AppTypography.badge),
          ],
        ),
      ),
    );
  }
}

class _BookmarkButton extends StatelessWidget {
  const _BookmarkButton({
    required this.placeId,
    required this.bookmarked,
    required this.filled,
    required this.onPressed,
    this.compact = false,
  });

  final String placeId;
  final bool bookmarked;
  final bool filled;
  final VoidCallback onPressed;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final size = compact ? 28.0 : 36.0;
    return AppPressable(
      onTap: onPressed,
      pressedScale: 0.9,
      borderRadius: BorderRadius.circular(AppRadius.pill),
      child: Container(
        key: Key('featured-destination-bookmark-$placeId'),
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: filled ? AppColors.primary : AppColors.glass90,
          border: Border.all(
            color: filled ? AppColors.primary : AppColors.glassBorder,
          ),
        ),
        alignment: Alignment.center,
        child: Icon(
          bookmarked ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
          size: compact ? 16 : 18,
          color: filled ? AppColors.textInverse : AppColors.primary,
        ),
      ),
    );
  }
}
