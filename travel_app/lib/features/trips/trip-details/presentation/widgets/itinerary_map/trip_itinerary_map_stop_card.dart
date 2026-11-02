import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_shadows.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_pressable.dart';

import '../../../application/trip_itinerary_map.dart';
import '../../../application/trip_itinerary_view.dart';
import '../../../utils/trip_itinerary_formatters.dart';

/// Horizontal card for one stop, with the leg to the next stop.
class TripItineraryMapStopCard extends StatelessWidget {
  const TripItineraryMapStopCard({
    super.key,
    required this.stop,
    required this.nextLeg,
    required this.focused,
    required this.onTap,
  });

  static const width = 264.0;

  final TripItineraryMapStop stop;
  final TripItineraryMapLeg? nextLeg;
  final bool focused;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final item = stop.item;
    final time = formatActivityTimeRange(item.activity.startTime, item.endTime);
    final leg = nextLeg;

    return AppPressable(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.card),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        width: width,
        padding: const EdgeInsets.all(AppSpacing.sm),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.card),
          border: Border.all(
            color: focused ? AppColors.primary : AppColors.borderBrandSoft,
            width: focused ? 2 : 1,
          ),
          boxShadow: AppShadows.level2,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _NumberBadge(number: stop.number, status: item.status),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    item.activity.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.bodyMedium.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  if (time != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      time,
                      style: AppTypography.caption.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                  if (leg != null) ...[
                    const SizedBox(height: AppSpacing.xxs),
                    Text(
                      _legLabel(leg),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.caption.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static String _legLabel(TripItineraryMapLeg leg) {
    final meters = leg.distanceMeters;
    if (leg.isEstimate || meters == null) {
      return 'Đến điểm tiếp: chưa có dữ liệu đường đi';
    }
    final distance = formatRouteDistance(meters / 1000, isEstimate: false);
    final seconds = leg.durationSeconds;
    if (seconds == null || seconds < 60) return 'Đến điểm tiếp: $distance';
    final minutes = (seconds / 60).round();
    return 'Đến điểm tiếp: $distance · ${formatDurationMinutes(minutes)}';
  }
}

class _NumberBadge extends StatelessWidget {
  const _NumberBadge({required this.number, required this.status});

  final int number;
  final TripItineraryActivityStatus status;

  @override
  Widget build(BuildContext context) {
    final color = switch (status) {
      TripItineraryActivityStatus.checkedIn => AppColors.success,
      TripItineraryActivityStatus.next => AppColors.primary,
      TripItineraryActivityStatus.upcoming => AppColors.textTertiary,
    };
    return Container(
      width: 28,
      height: 28,
      alignment: Alignment.center,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      child: Text(
        '$number',
        style: AppTypography.badge.copyWith(color: AppColors.textInverse),
      ),
    );
  }
}
