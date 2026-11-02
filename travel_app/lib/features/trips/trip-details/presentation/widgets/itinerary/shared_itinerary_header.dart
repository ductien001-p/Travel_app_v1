import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_badge.dart';
import 'package:travel_frontend_v1/core/widget/app_card.dart';

import '../../../data/models/trip_share_models.dart';
import '../../../utils/trip_detail_formatters.dart';

/// Trip summary at the top of a shared, read-only itinerary.
class SharedItineraryHeader extends StatelessWidget {
  const SharedItineraryHeader({super.key, required this.trip});

  final SharedTripSummary trip;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: AppSpacing.xs,
            runSpacing: AppSpacing.xxs,
            children: [
              const AppBadge(label: 'Chỉ xem', icon: Icons.visibility_outlined),
              AppBadge(label: trip.status.label, tone: AppBadgeTone.neutral),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(trip.name, style: AppTypography.sectionTitle),
          const SizedBox(height: AppSpacing.xxs),
          Row(
            children: [
              const Icon(
                Icons.calendar_month_outlined,
                size: 16,
                color: AppColors.primary,
              ),
              const SizedBox(width: AppSpacing.xxs),
              Expanded(
                child: Text(
                  '${formatDateRange(trip.startDate, trip.endDate)} · '
                  '${formatTripDuration(trip.startDate, trip.endDate)}',
                  style: AppTypography.caption.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
