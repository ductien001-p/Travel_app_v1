import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_shadows.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_badge.dart';
import 'package:travel_frontend_v1/core/widget/app_card.dart';

import '../../data/models/trip_detail_models.dart';
import '../../utils/trip_detail_formatters.dart';
import 'trip_detail_section_header.dart';

class TripDetailJourneySection extends StatelessWidget {
  const TripDetailJourneySection({
    super.key,
    required this.destinations,
    required this.nextActivity,
    required this.now,
    required this.onViewItinerary,
  });

  final List<TripDetailDestination> destinations;
  final TripDetailNextActivity? nextActivity;
  final DateTime now;
  final VoidCallback onViewItinerary;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const TripDetailSectionHeader(title: 'Chặng hành trình & Điểm dừng'),
        const SizedBox(height: AppSpacing.sm),
        if (destinations.isEmpty)
          AppCard(
            color: AppColors.glass85,
            child: Text(
              'Chuyến đi chưa có điểm dừng nào.',
              style: AppTypography.body,
            ),
          )
        else
          _DestinationPills(destinations: destinations),
        if (nextActivity != null) ...[
          const SizedBox(height: AppSpacing.sm),
          _NextActivityCard(
            activity: nextActivity!,
            now: now,
            onViewItinerary: onViewItinerary,
          ),
        ],
      ],
    );
  }
}

class _DestinationPills extends StatelessWidget {
  const _DestinationPills({required this.destinations});

  final List<TripDetailDestination> destinations;

  @override
  Widget build(BuildContext context) {
    final sorted = [...destinations]
      ..sort((a, b) => a.order.compareTo(b.order));
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xxs),
      child: Row(
        children: [
          for (var i = 0; i < sorted.length; i++) ...[
            if (i > 0)
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSpacing.xs),
                child: Icon(
                  Icons.arrow_forward_rounded,
                  size: 20,
                  color: AppColors.primary,
                ),
              ),
            _DestinationPill(destination: sorted[i]),
          ],
        ],
      ),
    );
  }
}

class _DestinationPill extends StatelessWidget {
  const _DestinationPill({required this.destination});

  final TripDetailDestination destination;

  @override
  Widget build(BuildContext context) {
    final active = destination.isCurrent;
    final foreground = active ? AppColors.textInverse : AppColors.textPrimary;
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: active ? AppColors.primary : AppColors.glass85,
        borderRadius: BorderRadius.circular(AppRadius.pill),
        border: Border.all(
          color: active ? Colors.transparent : AppColors.borderBrandSoft,
        ),
        boxShadow: active ? AppShadows.level1 : const [],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            active ? Icons.location_on_rounded : Icons.pin_drop_outlined,
            size: 15,
            color: active ? AppColors.textInverse : AppColors.primary,
          ),
          const SizedBox(width: 6),
          Text(
            destination.country.trim().isEmpty
                ? '${destination.order}. ${destination.city}'
                : '${destination.order}. ${destination.city}, ${destination.country}',
            style: AppTypography.caption.copyWith(
              color: foreground,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(width: 4),
          Text(
            '(${formatShortDateRange(destination.startDate, destination.endDate)})',
            style: AppTypography.caption.copyWith(
              color: active
                  ? AppColors.textInverse.withValues(alpha: 0.8)
                  : AppColors.textTertiary,
            ),
          ),
        ],
      ),
    );
  }
}

class _NextActivityCard extends StatelessWidget {
  const _NextActivityCard({
    required this.activity,
    required this.now,
    required this.onViewItinerary,
  });

  final TripDetailNextActivity activity;
  final DateTime now;
  final VoidCallback onViewItinerary;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.surface, AppColors.primaryLight],
        ),
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(color: AppColors.borderBrandSoft),
        boxShadow: AppShadows.level1,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Flexible(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: AppBadge(
                    label: 'HOẠT ĐỘNG TIẾP THEO',
                    icon: Icons.schedule_rounded,
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.xs),
              Text(
                formatActivityTime(activity.startTime, now: now),
                style: AppTypography.caption.copyWith(
                  color: AppColors.primaryActive,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(activity.title, style: AppTypography.cardTitle),
          if (activity.description != null &&
              activity.description!.isNotEmpty) ...[
            const SizedBox(height: 6),
            Text(
              activity.description!,
              style: AppTypography.caption.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
          const SizedBox(height: 10),
          const Divider(height: 1, color: AppColors.borderBrandSoft),
          const SizedBox(height: AppSpacing.xxs),
          Row(
            children: [
              if (activity.totalCount > 0) ...[
                Container(
                  height: 24,
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.primaryActive,
                    borderRadius: BorderRadius.circular(AppRadius.pill),
                  ),
                  child: Text(
                    '${activity.confirmedCount}/${activity.totalCount}',
                    style: AppTypography.badge.copyWith(
                      color: AppColors.textInverse,
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.xs),
                Expanded(
                  child: Text(
                    'thành viên đã check-in',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.caption.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              ] else
                const Spacer(),
              Flexible(
                child: TextButton(
                  onPressed: onViewItinerary,
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.primaryActive,
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.xs,
                    ),
                    minimumSize: const Size(0, 36),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Text(
                          'Xem lịch trình',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTypography.caption.copyWith(
                            color: AppColors.primaryActive,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const Icon(Icons.chevron_right_rounded, size: 16),
                    ],
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
