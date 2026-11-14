import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_gradients.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_shadows.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';

import '../../data/models/trip_detail_models.dart';
import '../../utils/trip_detail_formatters.dart';

class TripDetailHero extends StatelessWidget {
  const TripDetailHero({super.key, required this.trip});

  final TripDetailOverview trip;

  static const _coverHeight = 240.0;

  @override
  Widget build(BuildContext context) {
    final duration = formatTripDuration(trip.startDate, trip.endDate);
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(color: AppColors.glassBorder),
        boxShadow: AppShadows.level1,
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: _coverHeight,
            child: Stack(
              fit: StackFit.expand,
              children: [
                _Cover(url: trip.coverImageUrl),
                const DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: AppGradients.heroImageOverlay,
                  ),
                ),
                Positioned(
                  top: 14,
                  left: 14,
                  right: 14,
                  child: Wrap(
                    alignment: WrapAlignment.spaceBetween,
                    spacing: AppSpacing.xs,
                    runSpacing: 6,
                    children: [
                      _StatusPill(status: trip.status),
                      _VisibilityPill(visibility: trip.visibility),
                    ],
                  ),
                ),
                Positioned(
                  left: AppSpacing.md,
                  right: AppSpacing.md,
                  bottom: AppSpacing.sm,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: _CoverMetaChip(
                      label:
                          '${trip.tripType.label} • ${duration.toUpperCase()}',
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppSpacing.cardCompact),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(trip.name, style: AppTypography.screenTitle),
                if (trip.description != null &&
                    trip.description!.trim().isNotEmpty) ...[
                  const SizedBox(height: AppSpacing.xs),
                  Text(trip.description!, style: AppTypography.body),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Cover extends StatelessWidget {
  const _Cover({required this.url});

  final String? url;

  @override
  Widget build(BuildContext context) {
    const fallback = DecoratedBox(
      decoration: BoxDecoration(gradient: AppGradients.primaryAction),
      child: Center(
        child: Icon(
          Icons.landscape_rounded,
          size: 48,
          color: AppColors.textInverse,
        ),
      ),
    );
    if (url == null || url!.isEmpty) return fallback;
    return Image.network(
      url!,
      fit: BoxFit.cover,
      semanticLabel: 'Ảnh bìa chuyến đi',
      errorBuilder: (_, _, _) => fallback,
    );
  }
}

class _StatusPill extends StatelessWidget {
  const _StatusPill({required this.status});

  final TripDetailStatus status;

  @override
  Widget build(BuildContext context) {
    final color = switch (status) {
      TripDetailStatus.ongoing => AppColors.primary,
      TripDetailStatus.upcoming => AppColors.info,
      TripDetailStatus.completed => AppColors.success,
      TripDetailStatus.cancelled => AppColors.danger,
      TripDetailStatus.notCompleted => AppColors.warning,
      TripDetailStatus.draft => AppColors.textTertiary,
    };
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xxs,
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(AppRadius.pill),
        boxShadow: AppShadows.primaryGlow,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (status == TripDetailStatus.ongoing) ...[
            Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: AppColors.textInverse,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 6),
          ],
          Text(
            status.label,
            style: AppTypography.badge.copyWith(color: AppColors.textInverse),
          ),
        ],
      ),
    );
  }
}

class _VisibilityPill extends StatelessWidget {
  const _VisibilityPill({required this.visibility});

  final TripDetailVisibility visibility;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: AppSpacing.xxs,
      ),
      decoration: BoxDecoration(
        color: AppColors.glass75,
        borderRadius: BorderRadius.circular(AppRadius.pill),
        boxShadow: AppShadows.level1,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            visibility == TripDetailVisibility.public
                ? Icons.public_rounded
                : Icons.lock_outline_rounded,
            size: 14,
            color: AppColors.primary,
          ),
          const SizedBox(width: 4),
          Text(
            visibility.label,
            style: AppTypography.caption.copyWith(color: AppColors.textPrimary),
          ),
        ],
      ),
    );
  }
}

class _CoverMetaChip extends StatelessWidget {
  const _CoverMetaChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      decoration: BoxDecoration(
        color: AppColors.textInverse.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.group_outlined,
            size: 14,
            color: AppColors.textInverse,
          ),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTypography.caption.copyWith(
                color: AppColors.textInverse,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
