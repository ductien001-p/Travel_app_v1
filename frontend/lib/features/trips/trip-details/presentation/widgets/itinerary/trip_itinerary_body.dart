import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_card.dart';

import '../../../application/trip_itinerary_route.dart';
import '../../../application/trip_itinerary_view.dart';
import '../trip_detail_section_header.dart';
import 'trip_itinerary_day_progress_card.dart';
import 'trip_itinerary_day_rail.dart';
import 'trip_itinerary_destination_tabs.dart';
import 'trip_itinerary_route_card.dart';
import 'trip_itinerary_timeline.dart';

/// Scrollable itinerary layout shared by the member and the shared views.
///
/// Every interactive callback is optional so a read-only caller simply omits
/// it.
class TripItineraryBody extends StatelessWidget {
  const TripItineraryBody({
    super.key,
    required this.view,
    required this.onSelectDestination,
    required this.onSelectDay,
    this.header,
    this.completionHeader,
    this.onReorder,
    this.onDeleteDestination,
    this.route,
    this.isRouteLoading = false,
    this.isDestinationLoading = false,
    this.onOpenRouteMap,
    this.moreActionFor,
    this.isCheckingIn,
    this.onCheckin,
    this.onAddActivity,
  });

  final TripItineraryView view;
  final ValueChanged<String> onSelectDestination;
  final void Function({required String destinationId, required String dayId})
  onSelectDay;

  /// Optional block above the destination tabs.
  final Widget? header;

  /// Optional itinerary completion progress (below destination tabs).
  final Widget? completionHeader;
  final VoidCallback? onReorder;

  /// Owner/admin: remove the currently selected destination.
  final VoidCallback? onDeleteDestination;
  final TripItineraryRouteSummary? route;
  final bool isRouteLoading;

  /// True while a destination's days are being lazy-loaded.
  final bool isDestinationLoading;
  final VoidCallback? onOpenRouteMap;
  final VoidCallback? Function(TripItineraryActivityView item)? moreActionFor;
  final bool Function(TripItineraryActivityView item)? isCheckingIn;
  final ValueChanged<TripItineraryActivityView>? onCheckin;
  final VoidCallback? onAddActivity;

  @override
  Widget build(BuildContext context) {
    final destination = view.selectedDestination;
    final day = view.selectedDay;

    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.screenHorizontal,
        AppSpacing.md,
        AppSpacing.screenHorizontal,
        AppSpacing.safeBottom,
      ),
      children: [
        if (header case final header?) ...[
          header,
          const SizedBox(height: AppSpacing.lg),
        ],
        TripItineraryDestinationTabs(
          destinations: view.destinations,
          selectedId: destination?.id,
          onSelected: onSelectDestination,
        ),
        if (completionHeader case final completion?) ...[
          const SizedBox(height: AppSpacing.md),
          completion,
        ],
        if (onDeleteDestination != null && destination != null) ...[
          const SizedBox(height: AppSpacing.sm),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton.icon(
              onPressed: onDeleteDestination,
              icon: const Icon(Icons.delete_outline, size: 18),
              label: Text('Xóa điểm đến ${destination.destination.city}'),
              style: TextButton.styleFrom(foregroundColor: AppColors.danger),
            ),
          ),
        ],
        const SizedBox(height: AppSpacing.lg),
        TripDetailSectionHeader(
          title: 'Lộ trình theo ngày',
          leadingIcon: Icons.calendar_month_outlined,
          actionLabel: onReorder == null ? null : 'Sắp xếp lại',
          actionIcon: Icons.swap_vert_rounded,
          onAction: onReorder,
        ),
        const SizedBox(height: AppSpacing.sm),
        if (isDestinationLoading)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: AppSpacing.xl),
            child: Center(child: CircularProgressIndicator()),
          )
        else if (destination == null || destination.days.isEmpty)
          AppCard(
            color: AppColors.glass85,
            child: Text(
              'Điểm đến này chưa có ngày nào trong lịch trình.',
              style: AppTypography.body,
            ),
          )
        else
          TripItineraryDayRail(
            days: destination.days,
            selectedId: day?.id,
            onSelected: (dayId) =>
                onSelectDay(destinationId: destination.id, dayId: dayId),
          ),
        if (!isDestinationLoading && destination != null && day != null) ...[
          const SizedBox(height: AppSpacing.md),
          TripItineraryDayProgressCard(day: day, route: route),
          const SizedBox(height: AppSpacing.section),
          TripItineraryTimeline(
            day: day,
            moreActionFor: moreActionFor ?? (_) => null,
            isCheckingIn: isCheckingIn ?? (_) => false,
            onCheckin: onCheckin,
            onAddActivity: onAddActivity,
          ),
          if (day.activities.length > 1) ...[
            const SizedBox(height: AppSpacing.section),
            TripItineraryRouteCard(
              day: day,
              summary: route,
              isLoading: isRouteLoading,
              onOpenFullscreen: onOpenRouteMap,
            ),
          ],
        ],
      ],
    );
  }
}
