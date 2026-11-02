import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_frontend_v1/app/router/router_names.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_bottom_sheet.dart';
import 'package:travel_frontend_v1/core/widget/app_empty_view.dart';
import 'package:travel_frontend_v1/core/widget/app_error_view.dart';
import 'package:travel_frontend_v1/core/widget/app_scaffold.dart';

import '../../../trip-itineraies/application/add_itinerary_activity_state.dart';
import '../../../trip-itineraies/application/trip_itinerary_controller.dart';
import '../../application/trip_detail_overview_controller.dart';
import '../../application/trip_itinerary_action_controller.dart';
import '../../application/trip_itinerary_controller.dart';
import '../../application/trip_itinerary_route.dart';
import '../../application/trip_itinerary_share_controller.dart';
import '../../application/trip_itinerary_view.dart';
import '../../data/models/trip_detail_models.dart';
import '../../utils/trip_detail_formatters.dart';
import '../../utils/trip_itinerary_formatters.dart';
import '../widgets/itinerary/trip_itinerary_bars.dart';
import '../widgets/itinerary/trip_itinerary_body.dart';
import '../widgets/itinerary/trip_itinerary_edit_activity_sheet.dart';
import '../widgets/itinerary/trip_itinerary_share_menu.dart';
import '../widgets/itinerary/trip_itinerary_skeleton.dart';
import '../widgets/trip_detail_feedback.dart';

class TripItineraryScreen extends StatelessWidget {
  const TripItineraryScreen({super.key, required this.tripId});

  final String tripId;

  @override
  Widget build(BuildContext context) {
    // Browse mode: destination tabs load days via
    // `GET .../itineraries/destinations/:id` instead of the full tree.
    return ProviderScope(
      overrides: [
        tripItineraryPreferLazyProvider(tripId).overrideWith((ref) => true),
      ],
      child: _TripItineraryScreenBody(tripId: tripId),
    );
  }
}

class _TripItineraryScreenBody extends ConsumerWidget {
  const _TripItineraryScreenBody({required this.tripId});

  final String tripId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final view = ref.watch(tripItineraryViewProvider(tripId));
    final trip = ref.watch(
      tripDetailOverviewControllerProvider(tripId).select((v) => v.value),
    );
    final shareInFlight =
        ref.watch(tripItineraryShareControllerProvider(tripId)) != null;

    return AppScaffold(
      topBar: TripItineraryTopBar(
        tripName: trip?.name,
        onBack: () => _goBack(context),
        onShare: trip != null && isTripShareable(trip) && !shareInFlight
            ? () => _share(context, ref, trip)
            : null,
        onOpenMap: view.hasValue
            ? () => _openMap(context, view.value?.selectedDay?.id)
            : null,
      ),
      bottomNavigationBar: view.hasValue
          ? TripItineraryBottomBar(
              onExploreRoute: () =>
                  _openMap(context, view.value?.selectedDay?.id),
              onViewOverview: () => _goBack(context),
            )
          : null,
      body: switch (view) {
        AsyncValue(:final value?) when value.isEmpty => AppEmptyView(
          icon: Icons.event_note_outlined,
          title: 'Chưa có lịch trình',
          description: 'Chuyến đi này chưa có điểm đến nào.',
          actionLabel: value.canManageItinerary ? 'Lập lịch trình' : null,
          onAction: () => _openEditor(context),
        ),
        AsyncValue(:final value?) => RefreshIndicator(
          color: AppColors.primary,
          onRefresh: () => _refresh(context, ref),
          child: _ItineraryContent(
            tripId: tripId,
            view: value,
            onOpenMap: (dayId) => _openMap(context, dayId),
          ),
        ),
        AsyncValue(:final error?) => AppErrorView(
          title: 'Không thể tải lịch trình',
          message: tripDetailErrorMessage(error),
          actionLabel: 'Thử lại',
          onRetry: () => ref
            ..invalidate(tripItineraryControllerProvider(tripId))
            ..invalidate(tripItineraryViewerCheckinsProvider(tripId)),
        ),
        _ => const TripItinerarySkeleton(),
      },
    );
  }

  Future<void> _refresh(BuildContext context, WidgetRef ref) async {
    try {
      await Future.wait([
        ref.read(tripItineraryControllerProvider(tripId).notifier).refresh(),
        ref.refresh(tripItineraryViewerCheckinsProvider(tripId).future),
      ]);
    } catch (_) {
      // Surfaced below through the itinerary state or the snackbar.
    }
    final error =
        ref.read(tripItineraryControllerProvider(tripId)).error ??
        ref.read(tripItineraryViewerCheckinsProvider(tripId)).error;
    if (error != null && context.mounted) {
      showTripDetailMessage(context, tripDetailErrorMessage(error));
    }
  }

  void _goBack(BuildContext context) {
    if (context.canPop()) {
      context.pop();
    } else {
      context.goNamed(
        RouteNames.tripDetail,
        pathParameters: {'tripId': tripId},
      );
    }
  }

  void _openEditor(BuildContext context) => context.pushNamed(
    RouteNames.createTripItinerary,
    pathParameters: {'tripId': tripId},
  );

  void _openMap(BuildContext context, String? dayId) => context.pushNamed(
    RouteNames.tripItineraryMap,
    pathParameters: {'tripId': tripId},
    queryParameters: {'dayId': ?dayId},
  );

  Future<void> _share(
    BuildContext context,
    WidgetRef ref,
    TripDetailOverview trip,
  ) async {
    final provider = tripItineraryShareControllerProvider(tripId);
    if (ref.read(provider) != null) return;

    var action = TripShareAction.share;
    if (trip.canManageMembers) {
      final choice = await showAppBottomSheet<TripShareAction>(
        context: context,
        child: const TripItineraryShareMenu(),
      );
      if (choice == null || !context.mounted) return;
      action = choice;
    }

    switch (action) {
      case TripShareAction.share:
        await _runShare(
          context,
          () => ref
              .read(provider.notifier)
              .share(trip, origin: _shareOrigin(context)),
        );
      case TripShareAction.revoke:
        final confirmed = await confirmTripDetailAction(
          context,
          title: 'Thu hồi các link đã chia sẻ?',
          message:
              'Mọi link chia sẻ lịch trình đang còn hiệu lực sẽ không mở được '
              'nữa. Bạn có thể tạo link mới bất cứ lúc nào.',
          confirmLabel: 'Thu hồi',
        );
        if (!confirmed || !context.mounted) return;
        await _runShare(context, () async {
          final count = await ref.read(provider.notifier).revokeAll();
          if (context.mounted) {
            showTripDetailMessage(
              context,
              count == 0
                  ? 'Không có link nào đang hoạt động'
                  : 'Đã thu hồi $count link chia sẻ',
            );
          }
        });
    }
  }

  Future<void> _runShare(
    BuildContext context,
    Future<void> Function() task,
  ) async {
    try {
      await task();
    } catch (error) {
      if (context.mounted) {
        showTripDetailMessage(context, tripShareErrorMessage(error));
      }
    }
  }

  /// iPad anchors the share popover to this rect.
  static Rect? _shareOrigin(BuildContext context) {
    final box = context.findRenderObject();
    if (box is! RenderBox || !box.hasSize) return null;
    final topLeft = box.localToGlobal(Offset.zero);
    return topLeft & Size(box.size.width, box.size.height / 2);
  }
}

enum _ActivityMenuAction { checkin, uncheckin, edit, delete }

class _ItineraryContent extends ConsumerWidget {
  const _ItineraryContent({
    required this.tripId,
    required this.view,
    required this.onOpenMap,
  });

  final String tripId;
  final TripItineraryView view;
  final ValueChanged<String> onOpenMap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final actions = ref.watch(tripItineraryActionControllerProvider(tripId));
    final selection = ref.read(tripItinerarySelectionProvider(tripId).notifier);
    final destination = view.selectedDestination;
    final day = view.selectedDay;
    final loadingDestinationId = ref.watch(
      tripItineraryLoadingDestinationProvider(tripId),
    );
    final isDestinationLoading =
        destination != null && loadingDestinationId == destination.id;
    final route = day != null && day.activities.length > 1
        ? ref.watch(tripItineraryDayRouteProvider(tripDayRouteKey(tripId, day)))
        : null;

    return TripItineraryBody(
      view: view,
      onSelectDestination: (destinationId) =>
          _selectDestination(context, ref, selection, destinationId),
      onSelectDay: ({required destinationId, required dayId}) =>
          _selectDay(context, ref, selection, destinationId, dayId),
      onReorder: view.canManageItinerary ? () => _openEditor(context) : null,
      route: day == null ? null : summarizeDayRoute(day, route?.value),
      isRouteLoading: isDayRoutePending(route),
      isDestinationLoading: isDestinationLoading,
      onOpenRouteMap: day == null ? null : () => onOpenMap(day.id),
      moreActionFor: (item) => _menuFor(context, ref, item),
      isCheckingIn: (item) =>
          actions.isPending(TripItineraryAction.checkin, item.id),
      onCheckin: view.canCheckin
          ? (item) => _checkin(context, ref, item)
          : null,
      onAddActivity:
          view.canManageItinerary && destination != null && day != null
          ? () => _addActivity(context, destination, day)
          : null,
    );
  }

  Future<void> _selectDestination(
    BuildContext context,
    WidgetRef ref,
    TripItinerarySelectionController selection,
    String destinationId,
  ) async {
    try {
      await selection.selectDestination(destinationId);
    } catch (error) {
      if (context.mounted) {
        showTripDetailMessage(context, tripDetailErrorMessage(error));
      }
    }
  }

  Future<void> _selectDay(
    BuildContext context,
    WidgetRef ref,
    TripItinerarySelectionController selection,
    String destinationId,
    String dayId,
  ) async {
    try {
      await selection.selectDay(destinationId: destinationId, dayId: dayId);
    } catch (error) {
      if (context.mounted) {
        showTripDetailMessage(context, tripDetailErrorMessage(error));
      }
    }
  }

  void _openEditor(BuildContext context) => context.pushNamed(
    RouteNames.createTripItinerary,
    pathParameters: {'tripId': tripId},
  );

  List<_ActivityMenuAction> _actionsFor(TripItineraryActivityView item) => [
    if (view.canCheckin && item.status == TripItineraryActivityStatus.upcoming)
      _ActivityMenuAction.checkin,
    if (view.canCheckin && item.isCheckedIn) _ActivityMenuAction.uncheckin,
    if (view.canManageItinerary) ...[
      _ActivityMenuAction.edit,
      _ActivityMenuAction.delete,
    ],
  ];

  VoidCallback? _menuFor(
    BuildContext context,
    WidgetRef ref,
    TripItineraryActivityView item,
  ) {
    final options = _actionsFor(item);
    if (options.isEmpty) return null;
    return () async {
      final choice = await showAppBottomSheet<_ActivityMenuAction>(
        context: context,
        child: _ActivityMenu(title: item.activity.title, options: options),
      );
      if (choice == null || !context.mounted) return;
      switch (choice) {
        case _ActivityMenuAction.checkin:
          await _checkin(context, ref, item);
        case _ActivityMenuAction.uncheckin:
          await _run(
            context,
            ref,
            TripItineraryAction.uncheckin,
            (notifier) => notifier.uncheckin(item.id),
            successMessage: 'Đã hủy check-in',
          );
        case _ActivityMenuAction.edit:
          await _edit(context, item);
        case _ActivityMenuAction.delete:
          await _delete(context, ref, item);
      }
    };
  }

  Future<void> _checkin(
    BuildContext context,
    WidgetRef ref,
    TripItineraryActivityView item,
  ) => _run(
    context,
    ref,
    TripItineraryAction.checkin,
    (notifier) => notifier.checkin(item.id),
    successMessage: 'Check-in thành công: ${item.activity.title}',
  );

  Future<void> _edit(
    BuildContext context,
    TripItineraryActivityView item,
  ) async {
    final day = view.selectedDay;
    if (day == null) return;
    final saved = await showAppBottomSheet<bool>(
      context: context,
      child: TripItineraryEditActivitySheet(
        tripId: tripId,
        activity: item.activity,
        dayDate: day.day.date,
      ),
    );
    if (saved == true && context.mounted) {
      showTripDetailMessage(context, 'Đã cập nhật hoạt động');
    }
  }

  Future<void> _delete(
    BuildContext context,
    WidgetRef ref,
    TripItineraryActivityView item,
  ) async {
    final confirmed = await confirmTripDetailAction(
      context,
      title: 'Xóa hoạt động?',
      message: '"${item.activity.title}" sẽ bị xóa khỏi lịch trình.',
      confirmLabel: 'Xóa',
    );
    if (!confirmed || !context.mounted) return;
    await _run(
      context,
      ref,
      TripItineraryAction.deleteActivity,
      (notifier) => notifier.deleteActivity(item.id),
      successMessage: 'Đã xóa hoạt động',
    );
  }

  Future<void> _run(
    BuildContext context,
    WidgetRef ref,
    TripItineraryAction action,
    Future<void> Function(TripItineraryActionController notifier) task, {
    required String successMessage,
  }) async {
    final provider = tripItineraryActionControllerProvider(tripId);
    if (ref.read(provider).isBusy) return;
    try {
      await task(ref.read(provider.notifier));
      if (context.mounted) showTripDetailMessage(context, successMessage);
    } catch (error) {
      if (context.mounted) {
        showTripDetailMessage(
          context,
          tripItineraryActionErrorMessage(action, error),
        );
      }
    }
  }

  void _addActivity(
    BuildContext context,
    TripItineraryDestinationView destination,
    TripItineraryDayView day,
  ) {
    context.pushNamed(
      RouteNames.addItineraryActivity,
      pathParameters: {'tripId': tripId},
      extra: AddItineraryActivityArgs(
        tripId: tripId,
        dayId: day.id,
        destinationId: destination.id,
        dayNumber: day.day.dayNumber,
        dayDate: day.day.date,
        city: destination.destination.city,
        country: destination.destination.country,
        insertionChoices: List.unmodifiable(day.day.activities),
        canManageItinerary: view.canManageItinerary,
      ),
    );
  }
}

class _ActivityMenu extends StatelessWidget {
  const _ActivityMenu({required this.title, required this.options});

  final String title;
  final List<_ActivityMenuAction> options;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: _buildOptions(context),
    );
  }

  Widget _buildOptions(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: AppTypography.cardTitle,
        ),
        const SizedBox(height: AppSpacing.xs),
        for (final option in options)
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Icon(_iconOf(option), color: _colorOf(option)),
            title: Text(
              _labelOf(option),
              style: AppTypography.bodyMedium.copyWith(color: _colorOf(option)),
            ),
            onTap: () => context.pop(option),
          ),
      ],
    );
  }

  static String _labelOf(_ActivityMenuAction action) => switch (action) {
    _ActivityMenuAction.checkin => 'Check-in tại đây',
    _ActivityMenuAction.uncheckin => 'Hủy check-in',
    _ActivityMenuAction.edit => 'Sửa hoạt động',
    _ActivityMenuAction.delete => 'Xóa hoạt động',
  };

  static IconData _iconOf(_ActivityMenuAction action) => switch (action) {
    _ActivityMenuAction.checkin => Icons.where_to_vote_outlined,
    _ActivityMenuAction.uncheckin => Icons.undo_rounded,
    _ActivityMenuAction.edit => Icons.edit_calendar_outlined,
    _ActivityMenuAction.delete => Icons.delete_outline_rounded,
  };

  static Color _colorOf(_ActivityMenuAction action) =>
      action == _ActivityMenuAction.delete
      ? AppColors.danger
      : AppColors.textPrimary;
}
