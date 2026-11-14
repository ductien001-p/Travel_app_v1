import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_card.dart';

import '../../data/models/trip_detail_models.dart';
import '../../utils/trip_detail_formatters.dart';

class TripDetailMetrics extends StatelessWidget {
  const TripDetailMetrics({super.key, required this.trip});

  final TripDetailOverview trip;

  @override
  Widget build(BuildContext context) {
    final progress = trip.checkinProgress;
    final expenses = trip.expenseSummary;
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: _MetricCard(
              icon: Icons.calendar_month_outlined,
              label: 'Thời gian',
              value: formatDateRange(trip.startDate, trip.endDate),
              caption: formatTripDuration(trip.startDate, trip.endDate),
              captionColor: AppColors.primary,
            ),
          ),
          const SizedBox(width: AppSpacing.xs),
          Expanded(
            child: _MetricCard(
              icon: Icons.payments_outlined,
              iconBackground: AppColors.primary15,
              label: 'Chi tiêu nhóm',
              value: expenses == null
                  ? '—'
                  : formatTripMoney(
                      expenses.totalAmount,
                      currency: expenses.currency,
                    ),
              caption: trip.budgetLevel == null
                  ? null
                  : 'Mức: ${trip.budgetLevel!.label}',
            ),
          ),
          const SizedBox(width: AppSpacing.xs),
          Expanded(
            child: _MetricCard(
              icon: Icons.flag_outlined,
              label: 'Tiến độ check-in',
              value:
                  '${progress.percent}% '
                  '(${progress.completedCount}/${progress.totalCount})',
              valueColor: AppColors.primary,
              caption: progress.pointsEarned > 0
                  ? '+${progress.pointsEarned} Điểm thưởng'
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({
    required this.icon,
    required this.label,
    required this.value,
    this.caption,
    this.iconBackground = AppColors.primaryLight,
    this.valueColor = AppColors.textPrimary,
    this.captionColor = AppColors.textSecondary,
  });

  final IconData icon;
  final String label;
  final String value;
  final String? caption;
  final Color iconBackground;
  final Color valueColor;
  final Color captionColor;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      label: [label, value, ?caption].join(', '),
      excludeSemantics: true,
      child: AppCard(
        padding: const EdgeInsets.all(AppSpacing.sm),
        radius: AppRadius.card,
        color: AppColors.glass85,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: iconBackground,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 16, color: AppColors.primaryActive),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(label, style: AppTypography.caption),
            const SizedBox(height: 2),
            FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Text(
                value,
                maxLines: 1,
                style: AppTypography.bodyMedium.copyWith(
                  color: valueColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            if (caption != null)
              Text(
                caption!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.caption.copyWith(color: captionColor),
              ),
          ],
        ),
      ),
    );
  }
}
