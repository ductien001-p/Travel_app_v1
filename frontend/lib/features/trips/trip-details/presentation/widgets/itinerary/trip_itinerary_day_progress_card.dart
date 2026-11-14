import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_glass_surface.dart';
import 'package:travel_frontend_v1/core/widget/app_progress_bar.dart';

import '../../../application/trip_itinerary_route.dart';
import '../../../application/trip_itinerary_view.dart';
import '../../../utils/trip_detail_formatters.dart';
import '../../../utils/trip_itinerary_formatters.dart';

class TripItineraryDayProgressCard extends StatelessWidget {
  const TripItineraryDayProgressCard({
    super.key,
    required this.day,
    this.route,
  });

  final TripItineraryDayView day;
  final TripItineraryRouteSummary? route;

  @override
  Widget build(BuildContext context) {
    final total = day.activities.length;
    final percent = day.progressPercent;

    return AppGlassSurface(
      radius: AppRadius.card,
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: const BoxDecoration(
                  color: AppColors.primaryLight,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.verified_outlined,
                  size: 18,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(width: AppSpacing.xs),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tiến độ Ngày ${day.day.dayNumber}',
                      style: AppTypography.cardTitle,
                    ),
                    Text(
                      total == 0
                          ? 'Chưa có hoạt động dự kiến'
                          : 'Hoàn thành ${day.checkedInCount}/$total '
                                'hoạt động dự kiến',
                      style: AppTypography.caption.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.xs),
              Text(
                '$percent%',
                style: AppTypography.sectionTitle.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          AppProgressBar(value: percent / 100),
          const SizedBox(height: AppSpacing.sm),
          const Divider(height: 1, color: AppColors.borderBrandSoft),
          const SizedBox(height: AppSpacing.xs),
          Row(
            children: [
              Expanded(
                child: _MetricTile(
                  icon: Icons.payments_outlined,
                  label: 'Chi phí ngày',
                  value: formatTripMoney(day.totalCost),
                ),
              ),
              const SizedBox(width: AppSpacing.xs),
              Expanded(
                child: _MetricTile(
                  icon: Icons.schedule_rounded,
                  label: 'Tổng thời lượng',
                  value: day.totalDurationMinutes == 0
                      ? '—'
                      : '~ ${formatDurationMinutes(day.totalDurationMinutes)}',
                ),
              ),
            ],
          ),
          if (route case final route?) ...[
            const SizedBox(height: AppSpacing.xs),
            Row(
              children: [
                const Icon(
                  Icons.directions_car_outlined,
                  size: 16,
                  color: AppColors.textSecondary,
                ),
                const SizedBox(width: AppSpacing.xxs),
                Expanded(
                  child: Text(
                    'Di chuyển: ${_travelLabel(route)}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.caption.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  static String _travelLabel(TripItineraryRouteSummary route) {
    final distance = formatRouteDistance(
      route.distanceKm,
      isEstimate: route.isEstimate,
    );
    final minutes = route.travelMinutes;
    return minutes == null || minutes == 0
        ? distance
        : '$distance · ${formatDurationMinutes(minutes)}';
  }
}

class _MetricTile extends StatelessWidget {
  const _MetricTile({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.surfaceSubdued,
        borderRadius: BorderRadius.circular(AppRadius.input),
      ),
      child: Row(
        children: [
          Icon(icon, size: 17, color: AppColors.primary),
          const SizedBox(width: AppSpacing.xs),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.caption.copyWith(fontSize: 10),
                ),
                Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.bodyMedium.copyWith(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
