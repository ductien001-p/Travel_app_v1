import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_frontend_v1/app/router/router_names.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/widget/app_empty_view.dart';
import 'package:travel_frontend_v1/core/widget/app_error_view.dart';
import 'package:travel_frontend_v1/core/widget/app_scaffold.dart';

import '../../../trip-details/presentation/widgets/trip_detail_feedback.dart';
import '../../application/trip_timeline_events_controller.dart';
import '../../application/trip_timeline_filter.dart';
import '../../application/trip_timeline_live_controller.dart';
import '../../application/trip_timeline_view.dart';
import '../../data/models/trip_timeline_models.dart';
import '../../utils/trip_timeline_formatters.dart';
import '../widgets/trip_timeline_day_section.dart';
import '../widgets/trip_timeline_entry_menu.dart';
import '../widgets/trip_timeline_filter_bar.dart';
import '../widgets/trip_timeline_footer.dart';
import '../widgets/trip_timeline_skeleton.dart';
import '../widgets/trip_timeline_summary_card.dart';
import '../widgets/trip_timeline_top_bar.dart';

class TripTimelineScreen extends ConsumerWidget {
  const TripTimelineScreen({super.key, required this.tripId});

  final String tripId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timeline = ref.watch(tripTimelineViewProvider(tripId));
    final header = ref.watch(tripTimelineHeaderProvider(tripId));
    final liveStatus = ref.watch(tripTimelineLiveProvider(tripId));
    final view = timeline.value;
    final countLabels = view == null ? null : _countLabels(view);

    return AppScaffold(
      topBar: TripTimelineTopBar(
        onBack: () => _goBack(context),
        tripName: header?.tripName,
        eventCountLabel: countLabels == null
            ? null
            : '${countLabels[TripTimelineFilter.all]} hoạt động ghi nhận',
        onFilter: view == null
            ? null
            : () => _openFilterSheet(context, ref, view.filter, countLabels!),
      ),
      body: switch (timeline) {
        AsyncValue(:final value?) => _TimelineContent(
          view: value,
          header: header,
          liveStatus: liveStatus,
          countLabels: countLabels!,
          now: ref.watch(tripTimelineClockProvider)(),
          toWallClock: ref.watch(tripTimelineWallClockProvider),
          onRefresh: () => _refresh(context, ref),
          onLoadMore: _controller(ref).loadMore,
          onSelectFilter: _filterController(ref).select,
          onRetryFilter: () => _reload(ref),
          onEntryMore: (entry) => _openEntryMenu(context, entry),
          onOpenAlbum: () => context.pushNamed(
            RouteNames.tripMemories,
            pathParameters: {'tripId': tripId},
          ),
        ),
        AsyncValue(:final error?) => _TimelineError(
          error: error,
          onRetry: () => _reload(ref),
          onBack: () => _goBack(context),
        ),
        _ => const TripTimelineSkeleton(),
      },
    );
  }

  TripTimelineEventsController _controller(WidgetRef ref) =>
      ref.read(tripTimelineEventsControllerProvider(tripId).notifier);

  TripTimelineFilterController _filterController(WidgetRef ref) =>
      ref.read(tripTimelineFilterProvider(tripId).notifier);

  void _reload(WidgetRef ref) =>
      ref.invalidate(tripTimelineEventsControllerProvider(tripId));

  Map<TripTimelineFilter, String> _countLabels(TripTimelineView view) => {
    for (final filter in TripTimelineFilter.values)
      filter: '${view.countOf(filter)}',
  };

  Future<void> _refresh(BuildContext context, WidgetRef ref) async {
    try {
      await _controller(ref).refresh();
    } catch (error) {
      if (context.mounted) {
        showTripDetailMessage(context, tripTimelineErrorMessage(error));
      }
    }
  }

  Future<void> _openFilterSheet(
    BuildContext context,
    WidgetRef ref,
    TripTimelineFilter selected,
    Map<TripTimelineFilter, String> countLabels,
  ) async {
    final picked = await showTripTimelineFilterSheet(
      context,
      selected: selected,
      countLabels: countLabels,
    );
    if (picked != null && context.mounted) {
      _filterController(ref).select(picked);
    }
  }

  Future<void> _openEntryMenu(
    BuildContext context,
    TripTimelineEntry entry,
  ) async {
    final action = await showTripTimelineEntryMenu(context, entry);
    if (action == null || !context.mounted) return;
    switch (action) {
      case TripTimelineEntryAction.viewDetail:
        _openEntryDetail(context, entry);
    }
  }

  // TODO(screen): mở màn chi tiết hoạt động / chi tiêu / kỷ niệm theo
  // `entry.targetType` + `entry.targetId` khi các màn đó được tạo.
  void _openEntryDetail(BuildContext context, TripTimelineEntry entry) {
    showTripDetailMessage(context, 'Tính năng xem chi tiết đang phát triển.');
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
}

class _TimelineContent extends StatelessWidget {
  const _TimelineContent({
    required this.view,
    required this.header,
    required this.liveStatus,
    required this.countLabels,
    required this.now,
    required this.toWallClock,
    required this.onRefresh,
    required this.onLoadMore,
    required this.onSelectFilter,
    required this.onRetryFilter,
    required this.onEntryMore,
    required this.onOpenAlbum,
  });

  /// Start fetching older events this far before the end of the list.
  static const _loadMoreExtent = 600.0;

  final TripTimelineView view;
  final TripTimelineHeader? header;
  final TripTimelineLiveStatus liveStatus;
  final Map<TripTimelineFilter, String> countLabels;
  final DateTime now;
  final TripTimelineWallClock toWallClock;
  final Future<void> Function() onRefresh;
  final VoidCallback onLoadMore;
  final ValueChanged<TripTimelineFilter> onSelectFilter;
  final VoidCallback onRetryFilter;
  final ValueChanged<TripTimelineEntry> onEntryMore;
  final VoidCallback onOpenAlbum;

  bool get _isReady => view.status == TripTimelineBodyStatus.ready;

  bool get _canAutoLoad =>
      _isReady &&
      view.hasMore &&
      !view.isLoadingMore &&
      view.loadMoreError == null;

  @override
  Widget build(BuildContext context) {
    final groups = view.groups;
    final bodyCount = !_isReady || view.isEmpty ? 1 : groups.length;
    final showFooter = _isReady && (!view.isEmpty || view.hasMore);
    final itemCount = 2 + bodyCount + (showFooter ? 1 : 0);

    return NotificationListener<ScrollUpdateNotification>(
      onNotification: (notification) {
        final isTimelineList = notification.depth == 0;
        if (isTimelineList &&
            _canAutoLoad &&
            notification.metrics.extentAfter < _loadMoreExtent) {
          onLoadMore();
        }
        return false;
      },
      child: RefreshIndicator(
        color: AppColors.primary,
        onRefresh: onRefresh,
        child: ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.only(
            top: AppSpacing.md,
            bottom: AppSpacing.xl,
          ),
          itemCount: itemCount,
          itemBuilder: (context, index) {
            if (index == 0) return _padded(_summary());
            if (index == 1) return _filterBar();
            final bodyIndex = index - 2;
            if (bodyIndex < bodyCount) {
              return _padded(_body(bodyIndex));
            }
            return _padded(
              TripTimelineFooter(
                hasMore: view.hasMore,
                isLoadingMore: view.isLoadingMore,
                hasLoadMoreError: view.loadMoreError != null,
                onLoadMore: onLoadMore,
                isFiltered: view.filter != TripTimelineFilter.all,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _body(int index) {
    switch (view.status) {
      case TripTimelineBodyStatus.switchingFilter:
        return const TripTimelineEventsSkeleton(rows: 3);
      case TripTimelineBodyStatus.filterError:
        return AppErrorView(
          title: 'Không thể tải sự kiện',
          message: tripTimelineErrorMessage(view.filterError!),
          actionLabel: 'Thử lại',
          onRetry: onRetryFilter,
        );
      case TripTimelineBodyStatus.ready:
        if (view.isEmpty) return _emptyState();
        return Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.section),
          child: TripTimelineDaySection(
            group: view.groups[index],
            now: now,
            toWallClock: toWallClock,
            onEntryMore: onEntryMore,
            onOpenAlbum: onOpenAlbum,
          ),
        );
    }
  }

  Widget _padded(Widget child) => Padding(
    padding: const EdgeInsets.symmetric(
      horizontal: AppSpacing.screenHorizontal,
    ),
    child: child,
  );

  Widget _summary() => TripTimelineSummaryCard(
    liveStatus: liveStatus,
    inviteCode: header?.inviteCode,
    metrics: [
      TripTimelineMetric(
        icon: Icons.timeline_rounded,
        value: countLabels[TripTimelineFilter.all]!,
        label: 'Sự kiện',
        background: AppColors.primaryLight,
        foreground: AppColors.primary,
      ),
      TripTimelineMetric(
        icon: Icons.groups_outlined,
        value: header == null ? '—' : '${header!.memberCount}',
        label: 'Thành viên',
        background: AppColors.surfaceSubdued,
        foreground: AppColors.primaryActive,
      ),
      TripTimelineMetric(
        icon: Icons.location_on_outlined,
        value: countLabels[TripTimelineFilter.checkin]!,
        label: 'Check-in',
        background: AppColors.primary12,
        foreground: AppColors.primaryActive,
      ),
      TripTimelineMetric(
        icon: Icons.receipt_long_outlined,
        value: countLabels[TripTimelineFilter.expense]!,
        label: 'Chi tiêu',
        background: AppColors.info.withValues(alpha: 0.12),
        foreground: AppColors.info,
      ),
    ],
  );

  Widget _filterBar() => Padding(
    padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
    child: TripTimelineFilterBar(
      selected: view.filter,
      countLabels: countLabels,
      onSelected: onSelectFilter,
    ),
  );

  Widget _emptyState() {
    if (view.filter == TripTimelineFilter.all) {
      return const AppEmptyView(
        icon: Icons.history_rounded,
        title: 'Chưa có sự kiện nào',
        description:
            'Check-in, chi tiêu, kỷ niệm và thay đổi lịch trình của nhóm '
            'sẽ xuất hiện tại đây.',
      );
    }
    return AppEmptyView(
      icon: Icons.filter_alt_off_outlined,
      title: 'Không có sự kiện phù hợp',
      description: 'Thử chọn bộ lọc khác.',
      actionLabel: 'Xem tất cả',
      onAction: () => onSelectFilter(TripTimelineFilter.all),
    );
  }
}

class _TimelineError extends StatelessWidget {
  const _TimelineError({
    required this.error,
    required this.onRetry,
    required this.onBack,
  });

  final Object error;
  final VoidCallback onRetry;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    final message = tripTimelineErrorMessage(error);
    if (isTripTimelineForbidden(error)) {
      return AppEmptyView(
        icon: Icons.lock_outline_rounded,
        title: 'Không thể xem dòng thời gian',
        description: message,
        actionLabel: 'Quay lại',
        onAction: onBack,
      );
    }
    return AppErrorView(
      title: 'Không thể tải dòng thời gian',
      message: message,
      actionLabel: 'Thử lại',
      onRetry: onRetry,
    );
  }
}
