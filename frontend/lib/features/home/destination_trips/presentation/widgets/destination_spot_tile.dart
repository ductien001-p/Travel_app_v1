import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_shadows.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_glass_surface.dart';
import 'package:travel_frontend_v1/core/widget/app_pressable.dart';

import '../../data/models/destination_trips_models.dart';

class DestinationSpotTile extends StatelessWidget {
  const DestinationSpotTile({
    super.key,
    required this.spot,
    this.onOpen,
    this.onAdd,
  });

  final DestinationSpot spot;
  final VoidCallback? onOpen;
  final VoidCallback? onAdd;

  @override
  Widget build(BuildContext context) {
    final rating = spot.rating;
    return AppPressable(
      onTap: onOpen,
      borderRadius: BorderRadius.circular(AppRadius.card),
      child: AppGlassSurface(
        radius: AppRadius.card,
        padding: const EdgeInsets.all(AppSpacing.sm),
        borderColor: AppColors.borderNeutral,
        shadows: AppShadows.level1,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(AppRadius.input),
              child: _Thumb(url: spot.imageUrl),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    spot.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.cardTitle,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    rating == null
                        ? spot.categoryLabel
                        : '${rating.toStringAsFixed(1)} • ${spot.categoryLabel}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.caption.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  Text(
                    spot.note,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.caption,
                  ),
                ],
              ),
            ),
            if (onAdd != null)
              AppPressable(
                onTap: onAdd,
                pressedScale: 0.9,
                borderRadius: BorderRadius.circular(AppRadius.pill),
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: const BoxDecoration(
                    color: AppColors.primaryLight,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.add_rounded,
                    color: AppColors.primary,
                    size: 18,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _Thumb extends StatelessWidget {
  const _Thumb({required this.url});

  final String url;

  @override
  Widget build(BuildContext context) {
    if (url.trim().isEmpty) return const _ThumbFallback();
    return Image.network(
      url,
      width: 64,
      height: 64,
      fit: BoxFit.cover,
      errorBuilder: (_, _, _) => const _ThumbFallback(),
    );
  }
}

class _ThumbFallback extends StatelessWidget {
  const _ThumbFallback();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 64,
      height: 64,
      color: AppColors.primaryLight,
      alignment: Alignment.center,
      child: const Icon(Icons.place_rounded, color: AppColors.primary),
    );
  }
}
