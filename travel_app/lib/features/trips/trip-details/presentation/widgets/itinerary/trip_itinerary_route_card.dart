import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_shadows.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_glass_surface.dart';
import 'package:travel_frontend_v1/core/widget/app_pressable.dart';
import 'package:travel_frontend_v1/core/widget/app_skeleton.dart';

import '../../../application/trip_itinerary_route.dart';
import '../../../application/trip_itinerary_view.dart';
import '../../../utils/trip_itinerary_formatters.dart';

/// Stylised preview of the day's stops in visiting order.
class TripItineraryRouteCard extends StatelessWidget {
  const TripItineraryRouteCard({
    super.key,
    required this.day,
    required this.summary,
    required this.isLoading,
    required this.onOpenFullscreen,
  });

  static const _maxFittedStops = 5;

  final TripItineraryDayView day;

  /// Road distance, or a straight-line estimate when road data is missing.
  final TripItineraryRouteSummary? summary;
  final bool isLoading;

  /// Hidden when null (e.g. read-only shared itineraries).
  final VoidCallback? onOpenFullscreen;

  @override
  Widget build(BuildContext context) {
    final summary = this.summary;

    return AppGlassSurface(
      radius: AppRadius.card,
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const Icon(
                Icons.route_outlined,
                size: 20,
                color: AppColors.primary,
              ),
              const SizedBox(width: AppSpacing.xs),
              Expanded(
                child: Text(
                  'Tối ưu lộ trình di chuyển',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.cardTitle,
                ),
              ),
            ],
          ),
          if (isLoading) ...[
            const SizedBox(height: AppSpacing.xxs),
            const Align(
              alignment: Alignment.centerLeft,
              child: AppSkeleton(width: 140, height: 14),
            ),
          ] else if (summary != null) ...[
            const SizedBox(height: AppSpacing.xxs),
            Text(
              formatRouteSummary(summary),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTypography.caption.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
          const SizedBox(height: AppSpacing.sm),
          ClipRRect(
            borderRadius: BorderRadius.circular(AppRadius.input),
            child: Container(
              height: 112,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [AppColors.primary20, AppColors.primaryLight],
                ),
              ),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(
                        AppSpacing.lg,
                        0,
                        AppSpacing.lg,
                        AppSpacing.lg,
                      ),
                      child: Center(child: _stops()),
                    ),
                  ),
                  if (onOpenFullscreen case final onTap?)
                    Positioned(
                      right: AppSpacing.xs,
                      bottom: AppSpacing.xs,
                      child: _FullscreenChip(onTap: onTap),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _stops() {
    final activities = day.activities;
    if (activities.length <= _maxFittedStops) {
      return Row(
        children: [
          for (var i = 0; i < activities.length; i++) ...[
            if (i > 0) Expanded(child: _Connector(reached: _reached(i))),
            _StopMarker(index: i + 1, status: activities[i].status),
          ],
        ],
      );
    }
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (var i = 0; i < activities.length; i++) ...[
            if (i > 0)
              SizedBox(
                width: AppSpacing.lg,
                child: _Connector(reached: _reached(i)),
              ),
            _StopMarker(index: i + 1, status: activities[i].status),
          ],
        ],
      ),
    );
  }

  /// The leg into stop [index] counts as travelled once the stop is reached.
  bool _reached(int index) =>
      day.activities[index].status != TripItineraryActivityStatus.upcoming;
}

class _Connector extends StatelessWidget {
  const _Connector({required this.reached});

  final bool reached;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 2,
      margin: const EdgeInsets.symmetric(horizontal: AppSpacing.xxs),
      color: reached ? AppColors.primary38 : AppColors.borderNeutral,
    );
  }
}

class _StopMarker extends StatelessWidget {
  const _StopMarker({required this.index, required this.status});

  final int index;
  final TripItineraryActivityStatus status;

  @override
  Widget build(BuildContext context) {
    final (background, foreground, ring) = switch (status) {
      TripItineraryActivityStatus.checkedIn => (
        AppColors.surface,
        AppColors.primary,
        AppColors.primary,
      ),
      TripItineraryActivityStatus.next => (
        AppColors.primary,
        AppColors.textInverse,
        AppColors.primary38,
      ),
      TripItineraryActivityStatus.upcoming => (
        AppColors.surfaceSubdued,
        AppColors.textTertiary,
        AppColors.borderNeutral,
      ),
    };
    return Container(
      width: 30,
      height: 30,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: background,
        shape: BoxShape.circle,
        border: Border.all(color: ring, width: 2),
        boxShadow: AppShadows.level1,
      ),
      child: Text(
        '$index',
        style: AppTypography.badge.copyWith(color: foreground),
      ),
    );
  }
}

class _FullscreenChip extends StatelessWidget {
  const _FullscreenChip({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AppPressable(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.pill),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: AppSpacing.xxs,
        ),
        decoration: BoxDecoration(
          color: AppColors.glass90,
          borderRadius: BorderRadius.circular(AppRadius.pill),
          border: Border.all(color: AppColors.borderBrandSoft),
          boxShadow: AppShadows.level1,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Mở toàn màn hình',
              style: AppTypography.caption.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(width: AppSpacing.xxs),
            const Icon(
              Icons.open_in_full_rounded,
              size: 14,
              color: AppColors.primary,
            ),
          ],
        ),
      ),
    );
  }
}
