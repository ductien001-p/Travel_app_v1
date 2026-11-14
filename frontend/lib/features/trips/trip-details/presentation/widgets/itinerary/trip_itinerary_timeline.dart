import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_shadows.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_card.dart';
import 'package:travel_frontend_v1/core/widget/app_pressable.dart';

import '../../../application/trip_itinerary_view.dart';
import '../trip_detail_section_header.dart';
import 'trip_itinerary_activity_card.dart';

class TripItineraryTimeline extends StatelessWidget {
  const TripItineraryTimeline({
    super.key,
    required this.day,
    required this.moreActionFor,
    required this.isCheckingIn,
    this.onCheckin,
    this.onAddActivity,
  });

  final TripItineraryDayView day;

  /// Null hides the overflow menu of that activity.
  final VoidCallback? Function(TripItineraryActivityView item) moreActionFor;
  final bool Function(TripItineraryActivityView item) isCheckingIn;

  /// Null when the viewer cannot check in right now.
  final ValueChanged<TripItineraryActivityView>? onCheckin;

  /// Null when the viewer cannot edit the itinerary.
  final VoidCallback? onAddActivity;

  static const _railWidth = 28.0;

  @override
  Widget build(BuildContext context) {
    final activities = day.activities;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TripDetailSectionHeader(
          title: 'Dòng thời gian hoạt động',
          countLabel: '${activities.length} điểm đến',
          countHighlighted: true,
        ),
        const SizedBox(height: AppSpacing.md),
        if (activities.isEmpty)
          AppCard(
            color: AppColors.glass85,
            child: Text(
              'Chưa có hoạt động nào cho ngày này.',
              style: AppTypography.body,
            ),
          )
        else
          Stack(
            children: [
              Positioned(
                left: _railWidth / 2 - 1,
                top: AppSpacing.sm,
                bottom: AppSpacing.xl,
                child: Container(
                  width: 2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppRadius.pill),
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [AppColors.primary, AppColors.primary20],
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  for (var i = 0; i < activities.length; i++)
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: i == activities.length - 1 ? 0 : AppSpacing.lg,
                      ),
                      child: _TimelineEntry(
                        item: activities[i],
                        onMore: moreActionFor(activities[i]),
                        isCheckingIn: isCheckingIn(activities[i]),
                        onCheckin: onCheckin == null
                            ? null
                            : () => onCheckin!(activities[i]),
                      ),
                    ),
                ],
              ),
            ],
          ),
        if (onAddActivity != null) ...[
          const SizedBox(height: AppSpacing.lg),
          _AddActivityButton(
            dayNumber: day.day.dayNumber,
            onTap: onAddActivity!,
          ),
          const SizedBox(height: 6),
          Text(
            'Gợi ý điểm check-in & quán ngon xung quanh vị trí của bạn',
            textAlign: TextAlign.center,
            style: AppTypography.caption.copyWith(fontSize: 11),
          ),
        ],
      ],
    );
  }
}

class _TimelineEntry extends StatelessWidget {
  const _TimelineEntry({
    required this.item,
    required this.onMore,
    required this.isCheckingIn,
    required this.onCheckin,
  });

  final TripItineraryActivityView item;
  final VoidCallback? onMore;
  final bool isCheckingIn;
  final VoidCallback? onCheckin;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: TripItineraryTimeline._railWidth,
          child: Padding(
            padding: const EdgeInsets.only(top: AppSpacing.sm),
            child: _NodeMarker(status: item.status),
          ),
        ),
        Expanded(
          child: TripItineraryActivityCard(
            item: item,
            onMore: onMore,
            onCheckin: item.status == TripItineraryActivityStatus.next
                ? onCheckin
                : null,
            isCheckingIn: isCheckingIn,
          ),
        ),
      ],
    );
  }
}

class _NodeMarker extends StatelessWidget {
  const _NodeMarker({required this.status});

  final TripItineraryActivityStatus status;

  @override
  Widget build(BuildContext context) {
    final (background, foreground, ring, icon) = switch (status) {
      TripItineraryActivityStatus.checkedIn => (
        AppColors.success,
        AppColors.textInverse,
        AppColors.surface,
        Icons.check_rounded,
      ),
      TripItineraryActivityStatus.next => (
        AppColors.primary,
        AppColors.textInverse,
        AppColors.primaryLight,
        Icons.near_me_rounded,
      ),
      TripItineraryActivityStatus.upcoming => (
        AppColors.surfaceSubdued,
        AppColors.textTertiary,
        AppColors.surface,
        Icons.schedule_rounded,
      ),
    };
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          color: background,
          shape: BoxShape.circle,
          border: Border.all(color: ring, width: 3),
          boxShadow: AppShadows.level1,
        ),
        child: Icon(icon, size: 13, color: foreground),
      ),
    );
  }
}

class _AddActivityButton extends StatelessWidget {
  const _AddActivityButton({required this.dayNumber, required this.onTap});

  final int dayNumber;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final label = 'Thêm hoạt động vào Ngày $dayNumber';
    return Semantics(
      button: true,
      label: label,
      excludeSemantics: true,
      child: AppPressable(
        onTap: onTap,
        pressedScale: 0.98,
        borderRadius: BorderRadius.circular(AppRadius.card),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: 14,
          ),
          decoration: BoxDecoration(
            color: AppColors.primary08,
            borderRadius: BorderRadius.circular(AppRadius.card),
            border: Border.all(color: AppColors.primary38, width: 1.5),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.add_circle_outline_rounded,
                size: 20,
                color: AppColors.primary,
              ),
              const SizedBox(width: AppSpacing.xs),
              Flexible(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.buttonSmall.copyWith(
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
