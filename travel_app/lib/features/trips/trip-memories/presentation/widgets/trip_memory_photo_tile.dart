import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_pressable.dart';

import '../../application/trip_memories_view.dart';
import '../../utils/trip_memories_formatters.dart';

/// Photo of the album grid. The [featured] tile also shows the caption,
/// the photographer and the time.
class TripMemoryPhotoTile extends StatelessWidget {
  const TripMemoryPhotoTile({
    super.key,
    required this.tile,
    required this.onTap,
    this.featured = false,
  });

  final TripMemoryTile tile;
  final VoidCallback onTap;
  final bool featured;

  @override
  Widget build(BuildContext context) {
    final entry = tile.entry;
    final caption = entry.caption?.trim();
    final radius = BorderRadius.circular(AppRadius.input);
    return Semantics(
      button: true,
      label: [
        'Ảnh của ${tile.uploaderName}',
        if (caption != null && caption.isNotEmpty) caption,
      ].join(', '),
      excludeSemantics: true,
      child: AppPressable(
        onTap: onTap,
        borderRadius: radius,
        child: ClipRRect(
          borderRadius: radius,
          child: Stack(
            fit: StackFit.expand,
            children: [
              TripMemoryNetworkImage(url: entry.imageUrl),
              DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.center,
                    colors: [
                      AppColors.heroOverlay.withValues(
                        alpha: featured ? 0.8 : 0.35,
                      ),
                      AppColors.heroOverlay.withValues(alpha: 0),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: AppSpacing.xs,
                left: AppSpacing.xs,
                right: AppSpacing.xs,
                child: _TopBadges(tile: tile, featured: featured),
              ),
              if (featured)
                Positioned(
                  left: AppSpacing.sm,
                  right: AppSpacing.sm,
                  bottom: AppSpacing.sm,
                  child: _FeaturedCaption(tile: tile, caption: caption),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class TripMemoryNetworkImage extends StatelessWidget {
  const TripMemoryNetworkImage({
    super.key,
    required this.url,
    this.fit = BoxFit.cover,
  });

  final String url;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    final dpr = MediaQuery.devicePixelRatioOf(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.hasBoundedWidth
            ? (constraints.maxWidth * dpr).round()
            : null;
        return Image.network(
          url,
          fit: fit,
          cacheWidth: fit == BoxFit.cover ? width : null,
          loadingBuilder: (context, child, progress) => progress == null
              ? child
              : const ColoredBox(color: AppColors.surfaceSubdued),
          errorBuilder: (_, _, _) => const ColoredBox(
            color: AppColors.surfaceSubdued,
            child: Center(
              child: Icon(
                Icons.image_not_supported_outlined,
                color: AppColors.textTertiary,
              ),
            ),
          ),
        );
      },
    );
  }
}

class _TopBadges extends StatelessWidget {
  const _TopBadges({required this.tile, required this.featured});

  final TripMemoryTile tile;
  final bool featured;

  @override
  Widget build(BuildContext context) {
    final badge = tile.entry.badge?.trim();
    final hasBadge = badge != null && badge.isNotEmpty;
    if (!hasBadge && !featured) return const SizedBox.shrink();
    return Wrap(
      spacing: AppSpacing.xxs,
      runSpacing: AppSpacing.xxs,
      children: [
        if (hasBadge)
          TripMemoryBadge(
            label: badge,
            icon: featured ? Icons.star_rounded : null,
          ),
        if (featured)
          _Pill(
            color: AppColors.heroOverlay.withValues(alpha: 0.6),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.schedule_rounded,
                  size: 12,
                  color: AppColors.textInverse,
                ),
                const SizedBox(width: 2),
                Text(
                  formatMemoryClock(tile.time),
                  style: AppTypography.badge.copyWith(
                    fontSize: 10,
                    color: AppColors.textInverse,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

/// Label suggested by the backend for a photo ("Khoảnh khắc đêm"...).
class TripMemoryBadge extends StatelessWidget {
  const TripMemoryBadge({super.key, required this.label, this.icon});

  final String label;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return _Pill(
      color: AppColors.primary.withValues(alpha: 0.9),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 12, color: AppColors.textInverse),
            const SizedBox(width: 2),
          ],
          Flexible(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTypography.badge.copyWith(
                fontSize: 10,
                color: AppColors.textInverse,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill({required this.color, required this.child});

  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.xs,
          vertical: 3,
        ),
        child: child,
      ),
    );
  }
}

class _FeaturedCaption extends StatelessWidget {
  const _FeaturedCaption({required this.tile, this.caption});

  final TripMemoryTile tile;
  final String? caption;

  @override
  Widget build(BuildContext context) {
    final caption = this.caption;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (caption != null && caption.isNotEmpty)
          Text(
            caption,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: AppTypography.bodyMedium.copyWith(
              fontSize: 13,
              height: 1.3,
              fontWeight: FontWeight.w700,
              color: AppColors.textInverse,
            ),
          ),
        Row(
          children: [
            const Icon(
              Icons.person_outline_rounded,
              size: 13,
              color: AppColors.textInverse,
            ),
            const SizedBox(width: 2),
            Expanded(
              child: Text(
                tile.uploaderName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.caption.copyWith(
                  fontSize: 11,
                  color: AppColors.textInverse,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
