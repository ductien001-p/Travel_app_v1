import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_frontend_v1/app/router/router_names.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_chip.dart';
import 'package:travel_frontend_v1/core/widget/app_empty_view.dart';
import 'package:travel_frontend_v1/core/widget/app_error_view.dart';
import 'package:travel_frontend_v1/core/widget/app_glass_surface.dart';
import 'package:travel_frontend_v1/core/widget/app_icon_button.dart';
import 'package:travel_frontend_v1/core/widget/app_scaffold.dart';
import 'package:travel_frontend_v1/core/widget/app_search_bar.dart';
import 'package:travel_frontend_v1/core/widget/app_skeleton.dart';
import 'package:travel_frontend_v1/features/home/application/home_failure_message.dart';

import '../../application/featured_destinations_controller.dart';
import '../../application/featured_destinations_view.dart';
import '../widgets/featured_destination_card.dart';
import '../../place-details/presentation/place_detail_navigation.dart';
import '../widgets/place_save_sheet.dart';

class FeaturedDestinationsScreen extends ConsumerStatefulWidget {
  const FeaturedDestinationsScreen({super.key});

  @override
  ConsumerState<FeaturedDestinationsScreen> createState() =>
      _FeaturedDestinationsScreenState();
}

class _FeaturedDestinationsScreenState
    extends ConsumerState<FeaturedDestinationsScreen> {
  final _search = TextEditingController();
  final _scroll = ScrollController();

  @override
  void dispose() {
    _search.dispose();
    _scroll.dispose();
    super.dispose();
  }

  void _back() {
    if (context.canPop()) {
      context.pop();
      return;
    }
    context.goNamed(RouteNames.home);
  }

  @override
  Widget build(BuildContext context) {
    final placesState = ref.watch(featuredDestinationsControllerProvider);
    final caption = placesState.asData?.value.view.headerCaption;
    return AppScaffold(
      topBar: _FeaturedHeader(
        caption: caption ?? 'Đang tải địa danh nổi bật',
        onBack: _back,
        onSearch: _focusSearch,
      ),
      body: placesState.when(
        loading: () => const _FeaturedLoading(),
        error: (error, _) => _FeaturedFailure(
          error: error,
          onRetry: () => ref
              .read(featuredDestinationsControllerProvider.notifier)
              .refresh(),
        ),
        data: (state) => _FeaturedBody(
          state: state,
          search: _search,
          scroll: _scroll,
          onQuery: (value) => ref
              .read(featuredDestinationsControllerProvider.notifier)
              .setQuery(value),
          onChip: (chip) => ref
              .read(featuredDestinationsControllerProvider.notifier)
              .selectChip(chip),
          onSort: (sort) => ref
              .read(featuredDestinationsControllerProvider.notifier)
              .selectSort(sort),
          onBookmark: (id) =>
              showPlaceSaveSheet(context: context, ref: ref, placeId: id),
          onOpen: (id) => openPlaceDetail(context, id),
          onRefresh: () => ref
              .read(featuredDestinationsControllerProvider.notifier)
              .refresh(),
        ),
      ),
    );
  }

  void _focusSearch() {
    if (!_scroll.hasClients) return;
    _scroll.animateTo(
      0,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
    );
  }
}

class _FeaturedHeader extends StatelessWidget {
  const _FeaturedHeader({
    required this.caption,
    required this.onBack,
    required this.onSearch,
  });

  final String caption;
  final VoidCallback onBack;
  final VoidCallback onSearch;

  @override
  Widget build(BuildContext context) {
    return AppGlassSurface(
      radius: 0,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      color: AppColors.glass85,
      shadows: const [],
      child: Row(
        children: [
          AppIconButton(
            icon: Icons.arrow_back_rounded,
            onPressed: onBack,
            semanticLabel: 'Quay lại',
          ),
          Expanded(
            child: Column(
              children: [
                Text(
                  'Điểm Đến Nổi Bật',
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.sectionTitle,
                ),
                Text(
                  caption,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.caption.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          AppIconButton(
            icon: Icons.search_rounded,
            iconColor: AppColors.primary,
            onPressed: onSearch,
            semanticLabel: 'Tìm kiếm',
          ),
        ],
      ),
    );
  }
}

class _FeaturedBody extends StatelessWidget {
  const _FeaturedBody({
    required this.state,
    required this.search,
    required this.scroll,
    required this.onQuery,
    required this.onChip,
    required this.onSort,
    required this.onBookmark,
    required this.onOpen,
    required this.onRefresh,
  });

  final FeaturedDestinationsState state;
  final TextEditingController search;
  final ScrollController scroll;
  final ValueChanged<String> onQuery;
  final ValueChanged<FeaturedDestinationChip> onChip;
  final ValueChanged<FeaturedDestinationSort> onSort;
  final ValueChanged<String> onBookmark;
  final ValueChanged<String> onOpen;
  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    final view = state.view;
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView(
        controller: scroll,
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.md,
          AppSpacing.sm,
          AppSpacing.md,
          AppSpacing.xxl,
        ),
        children: [
          AppSearchBar(
            controller: search,
            hintText: 'Tìm kiếm điểm đến theo tên, tỉnh thành...',
            onChanged: onQuery,
          ),
          const SizedBox(height: AppSpacing.sm),
          _ChipRow(selected: view.chip, onSelected: onChip),
          const SizedBox(height: AppSpacing.sm),
          Align(
            alignment: Alignment.centerRight,
            child: _SortControl(label: view.sortLabel, onSelected: onSort),
          ),
          if (state.reloadError != null || state.searchError != null) ...[
            const SizedBox(height: AppSpacing.sm),
            Text(
              state.searchError ?? state.reloadError!,
              style: AppTypography.body.copyWith(color: AppColors.danger),
            ),
          ],
          const SizedBox(height: AppSpacing.sm),
          if (state.query.trim().isEmpty && view.isSourceEmpty)
            const AppEmptyView(
              title: 'Chưa có điểm đến nổi bật',
              description: 'Các địa danh được chọn hôm nay sẽ hiện tại đây.',
              icon: Icons.explore_outlined,
            )
          else if (view.places.isEmpty)
            const AppEmptyView(
              title: 'Không có điểm đến phù hợp',
              description: 'Đổi từ khóa hoặc thẻ để xem địa danh khác.',
              icon: Icons.search_off_rounded,
            )
          else
            _FeaturedFeed(
              places: view.places,
              onBookmark: onBookmark,
              onOpen: onOpen,
            ),
        ],
      ),
    );
  }
}

class _ChipRow extends StatelessWidget {
  const _ChipRow({required this.selected, required this.onSelected});

  final FeaturedDestinationChip selected;
  final ValueChanged<FeaturedDestinationChip> onSelected;

  @override
  Widget build(BuildContext context) {
    const chips = [
      (
        FeaturedDestinationChip.popular,
        'Phổ biến nhất',
        'featured-chip-popular',
      ),
      (
        FeaturedDestinationChip.topRated,
        'Đánh giá trên 4.8',
        'featured-chip-top-rated',
      ),
    ];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (final (chip, label, key) in chips) ...[
            AppChip(
              key: Key(key),
              label: label,
              selected: selected == chip,
              onTap: () => onSelected(chip),
            ),
            const SizedBox(width: AppSpacing.xs),
          ],
        ],
      ),
    );
  }
}

class _SortControl extends StatelessWidget {
  const _SortControl({required this.label, required this.onSelected});

  final String label;
  final ValueChanged<FeaturedDestinationSort> onSelected;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<FeaturedDestinationSort>(
      key: const Key('featured-sort'),
      onSelected: onSelected,
      itemBuilder: (context) => const [
        PopupMenuItem(
          value: FeaturedDestinationSort.saves,
          child: Text('Lượt lưu nhiều nhất'),
        ),
      ],
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: AppTypography.caption.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const Icon(
            Icons.expand_more_rounded,
            size: 16,
            color: AppColors.textSecondary,
          ),
        ],
      ),
    );
  }
}

class _FeaturedFeed extends StatelessWidget {
  const _FeaturedFeed({
    required this.places,
    required this.onBookmark,
    required this.onOpen,
  });

  final List<FeaturedDestinationCardData> places;
  final ValueChanged<String> onBookmark;
  final ValueChanged<String> onOpen;

  @override
  Widget build(BuildContext context) {
    final hero = places.first;
    final tiles = places.skip(1).toList();
    return Column(
      children: [
        FeaturedDestinationHeroCard(
          place: hero,
          onOpen: () => onOpen(hero.id),
          onBookmark: () => onBookmark(hero.id),
        ),
        for (var index = 0; index < tiles.length; index += 2) ...[
          const SizedBox(height: AppSpacing.sm),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: FeaturedDestinationTile(
                  place: tiles[index],
                  onOpen: () => onOpen(tiles[index].id),
                  onBookmark: () => onBookmark(tiles[index].id),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: index + 1 < tiles.length
                    ? FeaturedDestinationTile(
                        place: tiles[index + 1],
                        onOpen: () => onOpen(tiles[index + 1].id),
                        onBookmark: () => onBookmark(tiles[index + 1].id),
                      )
                    : const SizedBox.shrink(),
              ),
            ],
          ),
        ],
      ],
    );
  }
}

class _FeaturedLoading extends StatelessWidget {
  const _FeaturedLoading();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppSkeleton(
            width: double.infinity,
            height: 44,
            radius: AppRadius.pill,
          ),
          SizedBox(height: AppSpacing.sm),
          AppSkeleton(width: 220, height: 36, radius: AppRadius.pill),
          SizedBox(height: AppSpacing.sm),
          AppSkeleton(
            width: double.infinity,
            height: 256,
            radius: AppRadius.card,
          ),
        ],
      ),
    );
  }
}

class _FeaturedFailure extends StatelessWidget {
  const _FeaturedFailure({required this.error, required this.onRetry});

  final Object error;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final unauthorized = homeFailureIsUnauthorized(error);
    return AppErrorView(
      title: unauthorized
          ? 'Phiên đăng nhập đã hết hạn'
          : 'Không tải được điểm đến',
      message: unauthorized
          ? 'Đăng nhập lại để xem địa danh nổi bật.'
          : homeFailureMessage(error),
      actionLabel: 'Thử lại',
      onRetry: unauthorized ? null : onRetry,
    );
  }
}
