import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_frontend_v1/app/router/router_names.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_button.dart';
import 'package:travel_frontend_v1/core/widget/app_chip.dart';
import 'package:travel_frontend_v1/core/widget/app_empty_view.dart';
import 'package:travel_frontend_v1/core/widget/app_error_view.dart';
import 'package:travel_frontend_v1/core/widget/app_glass_surface.dart';
import 'package:travel_frontend_v1/core/widget/app_loading.dart';
import 'package:travel_frontend_v1/core/widget/app_scaffold.dart';
import 'package:travel_frontend_v1/core/widget/app_top_bar.dart';

import '../../../trip-itineraies/application/trip_itinerary_controller.dart';
import '../../application/trip_itinerary_controller.dart';
import '../../application/trip_itinerary_map.dart';
import '../../application/trip_itinerary_route.dart';
import '../../application/trip_itinerary_view.dart';
import '../../data/models/trip_itinerary_route_models.dart';
import '../../utils/trip_detail_formatters.dart';
import '../../utils/trip_itinerary_formatters.dart';
import '../widgets/itinerary_map/trip_itinerary_map_stop_card.dart';
import '../widgets/itinerary_map/trip_itinerary_route_map.dart';

/// Full-screen map of one itinerary day and its route.
class TripItineraryMapScreen extends ConsumerStatefulWidget {
  const TripItineraryMapScreen({
    super.key,
    required this.tripId,
    this.initialDayId,
  });

  final String tripId;
  final String? initialDayId;

  @override
  ConsumerState<TripItineraryMapScreen> createState() =>
      _TripItineraryMapScreenState();
}

class _TripItineraryMapScreenState
    extends ConsumerState<TripItineraryMapScreen> {
  late String? _dayId = widget.initialDayId;
  String? _focusedActivityId;

  String get _tripId => widget.tripId;

  @override
  Widget build(BuildContext context) {
    final view = ref.watch(tripItineraryViewProvider(_tripId));

    return AppScaffold(
      topBar: AppTopBar(title: 'Bản đồ lộ trình', onBack: _goBack),
      body: switch (view) {
        AsyncValue(:final value?) => _buildContent(value),
        AsyncValue(:final error?) => AppErrorView(
          title: 'Không thể tải lịch trình',
          message: tripDetailErrorMessage(error),
          actionLabel: 'Thử lại',
          onRetry: () => ref
            ..invalidate(tripItineraryControllerProvider(_tripId))
            ..invalidate(tripItineraryViewerCheckinsProvider(_tripId)),
        ),
        _ => const AppLoading(message: 'Đang tải bản đồ...'),
      },
    );
  }

  Widget _buildContent(TripItineraryView view) {
    final selection = findItineraryDay(view, _dayId);
    if (selection == null) {
      return const AppEmptyView(
        icon: Icons.map_outlined,
        title: 'Chưa có lịch trình',
        description: 'Chuyến đi này chưa có ngày nào để xem trên bản đồ.',
      );
    }
    final (:destination, :day) = selection;
    final routeKey = tripDayRouteKey(_tripId, day);
    final route = day.activities.length > 1
        ? ref.watch(tripItineraryDayRouteProvider(routeKey))
        : null;
    final data = buildTripItineraryMap(day, route?.value);
    final summary = summarizeDayRoute(day, route?.value);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _DayChips(
          days: destination.days,
          selectedDayId: day.id,
          onSelect: (dayId) => setState(() {
            _dayId = dayId;
            _focusedActivityId = null;
          }),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.screenHorizontal,
            AppSpacing.xs,
            AppSpacing.screenHorizontal,
            AppSpacing.sm,
          ),
          child: Text(
            _headline(destination, day, summary, route),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: AppTypography.caption.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ),
        Expanded(child: _buildMapArea(day, data, route, routeKey)),
      ],
    );
  }

  Widget _buildMapArea(
    TripItineraryDayView day,
    TripItineraryMapData data,
    AsyncValue<TripDayRoute>? route,
    TripDayRouteKey routeKey,
  ) {
    if (day.activities.isEmpty) {
      return const AppEmptyView(
        icon: Icons.event_busy_outlined,
        title: 'Ngày này chưa có hoạt động',
        description: 'Thêm hoạt động vào lịch trình để xem lộ trình.',
      );
    }
    final mapsSupported = ref.watch(tripMapsSupportedProvider);
    const cardsHeight = 112.0;

    return Stack(
      children: [
        Positioned.fill(
          child: mapsSupported
              ? TripItineraryRouteMap(
                  data: data,
                  focusedActivityId: _focusedActivityId,
                  onStopTap: _focus,
                  bottomPadding: cardsHeight + AppSpacing.md,
                )
              : const _MapUnavailable(),
        ),
        if (route != null && route.hasError && !route.hasValue)
          Positioned(
            top: AppSpacing.sm,
            left: AppSpacing.screenHorizontal,
            right: AppSpacing.screenHorizontal,
            child: _RouteErrorBanner(
              onRetry: () =>
                  ref.invalidate(tripItineraryDayRouteProvider(routeKey)),
            ),
          ),
        if (data.stops.isNotEmpty)
          Positioned(
            left: 0,
            right: 0,
            bottom: AppSpacing.md,
            height: cardsHeight,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.screenHorizontal,
              ),
              itemCount: data.stops.length,
              separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.sm),
              itemBuilder: (context, index) {
                final stop = data.stops[index];
                return TripItineraryMapStopCard(
                  stop: stop,
                  nextLeg: data.legFrom(stop.item.id),
                  focused: stop.item.id == _focusedActivityId,
                  onTap: () => _focus(stop.item.id),
                );
              },
            ),
          ),
      ],
    );
  }

  String _headline(
    TripItineraryDestinationView destination,
    TripItineraryDayView day,
    TripItineraryRouteSummary? summary,
    AsyncValue<TripDayRoute>? route,
  ) {
    final place = destination.destination.city;
    final title = 'Ngày ${day.day.dayNumber} · $place';
    if (isDayRoutePending(route)) {
      return '$title · Đang tính đường đi...';
    }
    if (summary == null) return title;
    return '$title · ${formatRouteSummary(summary)}';
  }

  void _focus(String activityId) =>
      setState(() => _focusedActivityId = activityId);

  void _goBack() {
    if (context.canPop()) {
      context.pop();
    } else {
      context.goNamed(
        RouteNames.tripItinerary,
        pathParameters: {'tripId': _tripId},
      );
    }
  }
}

class _DayChips extends StatelessWidget {
  const _DayChips({
    required this.days,
    required this.selectedDayId,
    required this.onSelect,
  });

  final List<TripItineraryDayView> days;
  final String selectedDayId;
  final ValueChanged<String> onSelect;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.screenHorizontal,
          vertical: AppSpacing.xxs,
        ),
        itemCount: days.length,
        separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.xs),
        itemBuilder: (context, index) {
          final day = days[index];
          return AppChip(
            label: 'Ngày ${day.day.dayNumber}',
            selected: day.id == selectedDayId,
            onTap: () => onSelect(day.id),
          );
        },
      ),
    );
  }
}

class _RouteErrorBanner extends StatelessWidget {
  const _RouteErrorBanner({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return AppGlassSurface(
      radius: AppRadius.card,
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.md,
        AppSpacing.xs,
        AppSpacing.xs,
        AppSpacing.xs,
      ),
      child: Row(
        children: [
          const Icon(Icons.wifi_off_rounded, color: AppColors.warning),
          const SizedBox(width: AppSpacing.xs),
          Expanded(
            child: Text(
              'Chưa tải được đường đi. Đang hiển thị đường thẳng ước tính.',
              style: AppTypography.caption.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.xs),
          AppButton(
            label: 'Thử lại',
            variant: AppButtonVariant.secondary,
            expand: false,
            onPressed: onRetry,
          ),
        ],
      ),
    );
  }
}

class _MapUnavailable extends StatelessWidget {
  const _MapUnavailable();

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.surfaceSubdued,
      child: Align(
        alignment: const Alignment(0, -0.4),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Text(
            'Bản đồ chỉ hiển thị trên Android và iOS.',
            textAlign: TextAlign.center,
            style: AppTypography.body,
          ),
        ),
      ),
    );
  }
}
