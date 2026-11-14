import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_frontend_v1/app/router/router_names.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_sizes.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/widget/app_button.dart';
import 'package:travel_frontend_v1/core/widget/app_empty_view.dart';
import 'package:travel_frontend_v1/core/widget/app_error_view.dart';
import 'package:travel_frontend_v1/core/widget/app_scaffold.dart';

import '../../../trip-details/presentation/widgets/trip_detail_feedback.dart';
import '../../application/trip_memories_action_controller.dart';
import '../../application/trip_memories_controller.dart';
import '../../application/trip_memories_filter.dart';
import '../../application/trip_memories_view.dart';
import '../../data/repositories/trip_memories_repository.dart';
import '../../provider/trip_memories_provider.dart';
import '../../utils/trip_memories_formatters.dart';
import '../widgets/trip_memories_filter_bar.dart';
import '../widgets/trip_memories_footer.dart';
import '../widgets/trip_memories_overview_card.dart';
import '../widgets/trip_memories_post_button.dart';
import '../widgets/trip_memories_skeleton.dart';
import '../widgets/trip_memories_top_bar.dart';
import '../widgets/trip_memory_contributors_sheet.dart';
import '../widgets/trip_memory_day_section.dart';
import 'trip_memory_viewer_screen.dart';

class TripMemoriesScreen extends ConsumerStatefulWidget {
  const TripMemoriesScreen({
    super.key,
    required this.tripId,
    this.startPosting = false,
    this.initialUploaderId,
  });

  static const _postParam = 'post';
  static const _uploaderParam = 'userId';

  /// Query of the album route that opens the photo picker on arrival.
  static const startPostingQuery = {_postParam: '1'};

  /// Query of the album route that shows only the photos of [userId].
  static Map<String, String> uploaderQuery(String userId) => {
    _uploaderParam: userId,
  };

  static bool startsPosting(Map<String, String> queryParameters) =>
      queryParameters[_postParam] == startPostingQuery[_postParam];

  static String? initialUploaderOf(Map<String, String> queryParameters) {
    final userId = queryParameters[_uploaderParam]?.trim();
    return userId == null || userId.isEmpty ? null : userId;
  }

  final String tripId;

  /// Opens the photo picker once the viewer is known to be allowed to post.
  final bool startPosting;

  /// Photographer selected when the album opens.
  final String? initialUploaderId;

  @override
  ConsumerState<TripMemoriesScreen> createState() => _TripMemoriesScreenState();
}

class _TripMemoriesScreenState extends ConsumerState<TripMemoriesScreen> {
  late bool _pendingStartPosting = widget.startPosting;

  /// Holds the album back until the initial photographer is selected, so the
  /// first request is already filtered.
  bool _applyingInitialFilter = false;

  String get tripId => widget.tripId;

  @override
  void initState() {
    super.initState();
    final uploaderId = widget.initialUploaderId;
    if (uploaderId != null) _applyInitialUploader(uploaderId);
    if (_pendingStartPosting) {
      ref.listenManual(
        tripMemoriesHeaderProvider(tripId),
        (_, header) => _startPostingOnce(header),
        fireImmediately: true,
      );
    }
  }

  /// Providers cannot be modified while widgets build, hence the microtask;
  /// the subscription keeps the filter alive until then.
  void _applyInitialUploader(String uploaderId) {
    _applyingInitialFilter = true;
    final filter = tripMemoriesFilterProvider(tripId);
    ref.listenManual(filter, (_, _) {});
    Future.microtask(() {
      if (!mounted) return;
      ref.read(filter.notifier).selectUploader(uploaderId);
      setState(() => _applyingInitialFilter = false);
    });
  }

  void _startPostingOnce(TripMemoriesHeader? header) {
    if (!_pendingStartPosting || header == null) return;
    _pendingStartPosting = false;
    if (!header.canPost) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _postPhotos(context, ref);
    });
  }

  @override
  Widget build(BuildContext context) {
    final album = _applyingInitialFilter
        ? const AsyncLoading<TripMemoriesView>()
        : ref.watch(tripMemoriesViewProvider(tripId));
    final header = ref.watch(tripMemoriesHeaderProvider(tripId));
    final action = ref.watch(tripMemoriesActionControllerProvider(tripId));
    final view = album.value;
    final canPost = header?.canPost ?? false;
    final onPost = canPost && !action.isBusy
        ? () => _postPhotos(context, ref)
        : null;

    return AppScaffold(
      topBar: TripMemoriesTopBar(
        onBack: () => _goBack(context),
        tripName: header?.tripName,
        countLabel: view?.totalCount == null
            ? null
            : memoryCountLabel(view!.totalCount!),
        onAdd: canPost ? onPost : null,
      ),
      body: switch (album) {
        AsyncValue(:final value?) => Stack(
          children: [
            _AlbumContent(
              view: value,
              header: header,
              onRefresh: () => _refresh(context, ref),
              onLoadMore: _controller(ref).loadMore,
              onSelectDay: _filterController(ref).selectDay,
              onSelectUploader: _filterController(ref).selectUploader,
              onShowAll: _filterController(ref).reset,
              onRetryFilter: () => _reload(ref),
              onOpen: (tile) => _openViewer(context, value, tile),
              onShowContributors: () =>
                  _openContributors(context, ref, value.contributors),
              onPost: onPost,
              bottomInset: canPost ? _postButtonSpace : 0,
            ),
            if (canPost)
              Positioned(
                left: AppSpacing.screenHorizontal,
                right: AppSpacing.screenHorizontal,
                bottom: AppSpacing.xl,
                child: Center(
                  child: TripMemoriesPostButton(
                    onPressed: onPost,
                    uploadProgress: action.uploadProgress,
                  ),
                ),
              ),
          ],
        ),
        AsyncValue(:final error?) => _AlbumError(
          error: error,
          onRetry: () => _reload(ref),
          onBack: () => _goBack(context),
        ),
        _ => const TripMemoriesSkeleton(),
      },
    );
  }

  static const _postButtonSpace =
      AppSizes.buttonPrimaryHeight + AppSpacing.xl * 2;

  TripMemoriesController _controller(WidgetRef ref) =>
      ref.read(tripMemoriesControllerProvider(tripId).notifier);

  TripMemoriesFilterController _filterController(WidgetRef ref) =>
      ref.read(tripMemoriesFilterProvider(tripId).notifier);

  void _reload(WidgetRef ref) =>
      ref.invalidate(tripMemoriesControllerProvider(tripId));

  Future<void> _refresh(BuildContext context, WidgetRef ref) async {
    try {
      await _controller(ref).refresh();
    } catch (error) {
      if (context.mounted) {
        showTripDetailMessage(context, tripMemoriesErrorMessage(error));
      }
    }
  }

  Future<void> _postPhotos(BuildContext context, WidgetRef ref) async {
    final photos = await ref.read(tripMemoryPhotoPickerProvider)(
      limit: TripMemoriesRepository.maxPhotosPerPost,
    );
    if (photos.isEmpty || !context.mounted) return;
    final selected = photos
        .take(TripMemoriesRepository.maxPhotosPerPost)
        .toList(growable: false);
    try {
      final added = await ref
          .read(tripMemoriesActionControllerProvider(tripId).notifier)
          .postPhotos(selected);
      if (!context.mounted) return;
      final skipped = photos.length - selected.length;
      showTripDetailMessage(
        context,
        skipped > 0
            ? 'Đã thêm $added ảnh. Mỗi lần chỉ đăng tối đa '
                  '${TripMemoriesRepository.maxPhotosPerPost} ảnh.'
            : 'Đã thêm $added ảnh vào album.',
      );
    } catch (error) {
      if (context.mounted) {
        showTripDetailMessage(context, tripMemoriesUploadErrorMessage(error));
      }
    }
  }

  void _openViewer(
    BuildContext context,
    TripMemoriesView view,
    TripMemoryTile tile,
  ) {
    final tiles = view.tiles;
    final index = tiles.indexWhere((t) => t.entry.id == tile.entry.id);
    Navigator.of(context).push(
      TripMemoryViewerScreen.route(
        tripId: tripId,
        tiles: tiles,
        initialIndex: index < 0 ? 0 : index,
      ),
    );
  }

  Future<void> _openContributors(
    BuildContext context,
    WidgetRef ref,
    List<TripMemoryContributor> contributors,
  ) async {
    final userId = await showTripMemoryContributorsSheet(
      context,
      contributors: contributors,
    );
    if (userId != null && context.mounted) {
      _filterController(ref).selectUploader(userId);
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
}

class _AlbumContent extends StatelessWidget {
  const _AlbumContent({
    required this.view,
    required this.header,
    required this.onRefresh,
    required this.onLoadMore,
    required this.onSelectDay,
    required this.onSelectUploader,
    required this.onShowAll,
    required this.onRetryFilter,
    required this.onOpen,
    required this.onShowContributors,
    required this.bottomInset,
    this.onPost,
  });

  /// Start fetching older photos this far before the end of the list.
  static const _loadMoreExtent = 600.0;

  final TripMemoriesView view;
  final TripMemoriesHeader? header;
  final Future<void> Function() onRefresh;
  final VoidCallback onLoadMore;
  final ValueChanged<int?> onSelectDay;
  final ValueChanged<String?> onSelectUploader;
  final VoidCallback onShowAll;
  final VoidCallback onRetryFilter;
  final ValueChanged<TripMemoryTile> onOpen;
  final VoidCallback onShowContributors;
  final VoidCallback? onPost;

  /// Room kept free under the list for the floating post button.
  final double bottomInset;

  bool get _isReady => view.status == TripMemoriesBodyStatus.ready;

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
        final isAlbumList = notification.depth == 0;
        if (isAlbumList &&
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
          padding: EdgeInsets.only(
            top: AppSpacing.md,
            bottom: AppSpacing.xl + bottomInset,
          ),
          itemCount: itemCount,
          itemBuilder: (context, index) {
            if (index == 0) return _padded(_overview());
            if (index == 1) return _filterBar();
            final bodyIndex = index - 2;
            if (bodyIndex < bodyCount) return _padded(_body(bodyIndex));
            return _padded(
              TripMemoriesFooter(
                hasMore: view.hasMore,
                isLoadingMore: view.isLoadingMore,
                hasLoadMoreError: view.loadMoreError != null,
                onLoadMore: onLoadMore,
                isFiltered: !view.filter.isAll,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _overview() => TripMemoriesOverviewCard(
    totalCount: view.totalCount,
    contributors: view.contributors,
    onShowContributors: onShowContributors,
  );

  Widget _filterBar() => Padding(
    padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
    child: TripMemoriesFilterBar(
      filter: view.filter,
      dayOptions: view.dayOptions,
      contributors: view.contributors,
      totalCount: view.totalCount,
      viewerId: (header?.isMember ?? false) ? header!.viewerId : null,
      onSelectDay: onSelectDay,
      onSelectUploader: onSelectUploader,
    ),
  );

  Widget _body(int index) {
    switch (view.status) {
      case TripMemoriesBodyStatus.switchingFilter:
        return const TripMemoriesGridSkeleton();
      case TripMemoriesBodyStatus.filterError:
        return _FilterError(
          message: tripMemoriesFilterErrorMessage(view.filterError!),
          onRetry: onRetryFilter,
          onShowAll: onShowAll,
        );
      case TripMemoriesBodyStatus.ready:
        if (view.isEmpty) return _emptyState();
        return Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.section),
          child: TripMemoryDaySection(
            group: view.groups[index],
            onOpen: onOpen,
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

  Widget _emptyState() {
    if (!view.filter.isAll) {
      return AppEmptyView(
        icon: Icons.filter_alt_off_outlined,
        title: 'Không có ảnh phù hợp',
        description: 'Thử chọn ngày hoặc người chụp khác.',
        actionLabel: 'Xem tất cả',
        onAction: onShowAll,
      );
    }
    return AppEmptyView(
      icon: Icons.photo_library_outlined,
      title: 'Chưa có kỷ niệm nào',
      description: onPost == null
          ? 'Ảnh các thành viên đăng trong chuyến đi sẽ xuất hiện tại đây.'
          : 'Hãy đăng những bức ảnh đầu tiên của chuyến đi.',
    );
  }
}

class _FilterError extends StatelessWidget {
  const _FilterError({
    required this.message,
    required this.onRetry,
    required this.onShowAll,
  });

  final String message;
  final VoidCallback onRetry;
  final VoidCallback onShowAll;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppErrorView(
          title: 'Không thể lọc kỷ niệm',
          message: message,
          actionLabel: 'Thử lại',
          onRetry: onRetry,
        ),
        AppButton(
          label: 'Xem tất cả',
          variant: AppButtonVariant.glass,
          expand: false,
          onPressed: onShowAll,
        ),
      ],
    );
  }
}

class _AlbumError extends StatelessWidget {
  const _AlbumError({
    required this.error,
    required this.onRetry,
    required this.onBack,
  });

  final Object error;
  final VoidCallback onRetry;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    final message = tripMemoriesErrorMessage(error);
    if (isTripMemoriesForbidden(error)) {
      return AppEmptyView(
        icon: Icons.lock_outline_rounded,
        title: 'Không thể xem album',
        description: message,
        actionLabel: 'Quay lại',
        onAction: onBack,
      );
    }
    return AppErrorView(
      title: 'Không thể tải album kỷ niệm',
      message: message,
      actionLabel: 'Thử lại',
      onRetry: onRetry,
    );
  }
}
