import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_shadows.dart';
import 'package:travel_frontend_v1/core/theme/app_sizes.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_bottom_sheet.dart';
import 'package:travel_frontend_v1/core/widget/app_chip.dart';
import 'package:travel_frontend_v1/core/widget/app_pressable.dart';

import 'package:travel_frontend_v1/core/widget/app_empty_view.dart';

import '../../application/saved_places_view.dart';
import '../../../../home/places/place-details/presentation/place_detail_navigation.dart';
import 'saved_place_card.dart';

class SavedPlacesBody extends StatelessWidget {
  const SavedPlacesBody({
    super.key,
    required this.places,
    required this.filter,
    required this.queryController,
    required this.onQueryChanged,
    required this.onSelectGroup,
    required this.onSelectCollection,
    required this.onCreateCollection,
    required this.onUnsave,
    required this.onAddToTrip,
    required this.onShare,
    required this.onMore,
    required this.onLoadMore,
    required this.onRetryCollection,
  });

  final SavedPlacesState places;
  final SavedPlacesFilterState filter;
  final TextEditingController queryController;
  final ValueChanged<String> onQueryChanged;
  final ValueChanged<SavedPlaceGroup> onSelectGroup;
  final ValueChanged<String> onSelectCollection;
  final VoidCallback onCreateCollection;
  final ValueChanged<SavedPlaceRow> onUnsave;
  final ValueChanged<SavedPlaceRow> onAddToTrip;
  final ValueChanged<SavedPlaceRow> onShare;
  final ValueChanged<SavedPlaceRow> onMore;
  final VoidCallback onLoadMore;
  final VoidCallback onRetryCollection;

  @override
  Widget build(BuildContext context) {
    final cards = savedCollectionCards(
      collections: places.ownedCollections,
      items: places.items,
    );
    final collection = places.selectedCollection;
    final showingCollection =
        filter.collectionId != null && collection?.id == filter.collectionId;
    final savedById = {for (final item in places.items) item.placeId: item};
    final rows = showingCollection
        ? [
            for (final item in filterCollectionPlaces(
              places: collection!.places,
              group: filter.group,
              query: filter.query,
            ))
              collectionPlaceRow(item, savedById[item.id]),
          ]
        : [
            for (final item in filterSavedPlaces(
              items: places.items,
              group: filter.group,
              query: filter.query,
            ))
              savedPlaceRow(item),
          ];
    final waitingForCollection =
        filter.collectionId != null && !showingCollection;
    final filtering =
        filter.group != SavedPlaceGroup.all ||
        filter.query.trim().isNotEmpty ||
        filter.collectionId != null;
    return ListView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.only(
        top: AppSpacing.md,
        bottom: AppSpacing.safeBottom,
      ),
      children: [
        _pad(_SummaryRow(total: places.total)),
        const SizedBox(height: AppSpacing.sm),
        _pad(
          _SearchField(controller: queryController, onChanged: onQueryChanged),
        ),
        const SizedBox(height: AppSpacing.md),
        _GroupRail(
          places: places,
          filter: filter,
          selected: filter.group,
          onSelect: onSelectGroup,
        ),
        const SizedBox(height: AppSpacing.section),
        _pad(
          _CollectionsSection(
            cards: cards,
            selectedId: filter.collectionId,
            onSelect: onSelectCollection,
            onCreate: onCreateCollection,
          ),
        ),
        const SizedBox(height: AppSpacing.section),
        _pad(_ListHeader(count: filtering ? rows.length : places.total)),
        const SizedBox(height: AppSpacing.md),
        if (waitingForCollection)
          _pad(
            _CollectionStatus(
              loading: places.loadingCollection,
              error: places.collectionError,
              onRetry: onRetryCollection,
            ),
          )
        else if (rows.isEmpty)
          _pad(_emptyList(places: places, filter: filter))
        else
          for (final place in rows) ...[
            _pad(
              SavedPlaceCard(
                place: place,
                onOpen: () => openPlaceDetail(context, place.placeId),
                onUnsave: () => onUnsave(place),
                onAddToTrip: () => onAddToTrip(place),
                onShare: () => onShare(place),
                onMore: () => onMore(place),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
          ],
        if (places.hasNextPage) ...[
          const SizedBox(height: AppSpacing.xs),
          _pad(
            _LoadMore(
              loading: places.loadingMore,
              error: places.loadMoreError,
              onPressed: onLoadMore,
            ),
          ),
        ],
      ],
    );
  }
}

Widget _pad(Widget child) {
  return Padding(
    padding: const EdgeInsets.symmetric(
      horizontal: AppSpacing.screenHorizontal,
    ),
    child: child,
  );
}

Widget _emptyList({
  required SavedPlacesState places,
  required SavedPlacesFilterState filter,
}) {
  final browsingAll =
      filter.group == SavedPlaceGroup.all &&
      filter.query.trim().isEmpty &&
      filter.collectionId == null;
  if (browsingAll && places.items.isEmpty) {
    return const AppEmptyView(
      title: 'Chưa lưu địa điểm',
      description: 'Địa điểm bạn đánh dấu sẽ hiện trong bộ sưu tập này.',
      icon: Icons.bookmark_outline_rounded,
    );
  }
  final message = filter.query.trim().isNotEmpty
      ? 'Không tìm thấy địa điểm đã lưu.'
      : filter.group != SavedPlaceGroup.all
      ? 'Không có địa điểm trong nhóm này.'
      : 'Bộ sưu tập này chưa có địa điểm.';
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: AppSpacing.xl),
    child: Text(
      message,
      textAlign: TextAlign.center,
      style: AppTypography.body,
    ),
  );
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({required this.total});

  final int total;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              borderRadius: BorderRadius.circular(AppRadius.pill),
              border: Border.all(color: AppColors.borderBrandSoft),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.sm,
                vertical: 6,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.bookmark_rounded,
                    size: 16,
                    color: AppColors.primary,
                  ),
                  const SizedBox(width: 6),
                  Flexible(
                    child: Text(
                      savedPlaceCountLabel(total),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.badge.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _SearchField extends StatelessWidget {
  const _SearchField({required this.controller, required this.onChanged});

  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: AppSizes.searchMinHeight),
      decoration: BoxDecoration(
        color: AppColors.surfaceSubdued,
        borderRadius: BorderRadius.circular(AppRadius.pill),
        border: Border.all(color: AppColors.borderNeutral),
      ),
      child: Row(
        children: [
          const SizedBox(width: AppSpacing.md),
          const Icon(Icons.search, size: 20, color: AppColors.primary),
          const SizedBox(width: AppSpacing.xs),
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              style: AppTypography.body.copyWith(color: AppColors.textPrimary),
              decoration: InputDecoration(
                isCollapsed: true,
                border: InputBorder.none,
                hintText: 'Tìm trong danh sách đã lưu...',
                hintStyle: AppTypography.body.copyWith(
                  color: AppColors.textTertiary,
                ),
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
        ],
      ),
    );
  }
}

class _GroupRail extends StatelessWidget {
  const _GroupRail({
    required this.places,
    required this.filter,
    required this.selected,
    required this.onSelect,
  });

  final SavedPlacesState places;
  final SavedPlacesFilterState filter;
  final SavedPlaceGroup selected;
  final ValueChanged<SavedPlaceGroup> onSelect;

  @override
  Widget build(BuildContext context) {
    final groups = [SavedPlaceGroup.all, ...savedPlaceGroupOrder];
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.screenHorizontal,
        ),
        itemCount: groups.length,
        separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.xs),
        itemBuilder: (context, index) {
          final group = groups[index];
          final collection = places.selectedCollection;
          final showingCollection =
              filter.collectionId != null &&
              collection?.id == filter.collectionId;
          final count = showingCollection
              ? collectionPlaceGroupCount(collection!.places, group)
              : group == SavedPlaceGroup.all
              ? places.total
              : savedPlaceGroupCount(places.items, group);
          return AppChip(
            label: '${savedPlaceGroupLabel(group)} ($count)',
            selected: group == selected,
            leadingIcon: group == SavedPlaceGroup.all
                ? Icons.auto_awesome
                : null,
            onTap: () => onSelect(group),
          );
        },
      ),
    );
  }
}

class _CollectionsSection extends StatelessWidget {
  const _CollectionsSection({
    required this.cards,
    required this.selectedId,
    required this.onSelect,
    required this.onCreate,
  });

  final List<SavedCollectionCardData> cards;
  final String? selectedId;
  final ValueChanged<String> onSelect;
  final VoidCallback onCreate;

  @override
  Widget build(BuildContext context) {
    final preview = cards.take(2).toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            const Icon(
              Icons.folder_special_outlined,
              size: 20,
              color: AppColors.primary,
            ),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                'Bộ Sưu Tập Thông Minh',
                style: AppTypography.sectionTitle,
              ),
            ),
            if (cards.isNotEmpty)
              TextButton(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.xs,
                  ),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                onPressed: () => _openAll(context),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Tất cả (${cards.length})',
                      style: AppTypography.caption.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Icon(
                      Icons.chevron_right,
                      size: 16,
                      color: AppColors.primary,
                    ),
                  ],
                ),
              ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        if (preview.isNotEmpty)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (var index = 0; index < preview.length; index++) ...[
                if (index > 0) const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: _CollectionCard(
                    card: preview[index],
                    iconOnMint: index.isEven,
                    selected: preview[index].id == selectedId,
                    onTap: () => onSelect(preview[index].id),
                  ),
                ),
              ],
              if (preview.length == 1) const Spacer(),
            ],
          ),
        if (preview.isNotEmpty) const SizedBox(height: AppSpacing.sm),
        _CreateCollectionButton(onTap: onCreate),
      ],
    );
  }

  Future<void> _openAll(BuildContext context) async {
    final selected = await showAppBottomSheet<String>(
      context: context,
      child: Builder(
        builder: (sheetContext) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (final card in cards)
                ListTile(
                  leading: Icon(
                    _collectionIcon(card.group),
                    color: AppColors.primary,
                  ),
                  title: Text(card.title, style: AppTypography.cardTitle),
                  subtitle: Text(
                    '${card.count} mục',
                    style: AppTypography.caption,
                  ),
                  onTap: () => Navigator.of(sheetContext).pop(card.id),
                ),
            ],
          );
        },
      ),
    );
    if (selected != null) onSelect(selected);
  }
}

class _CreateCollectionButton extends StatelessWidget {
  const _CreateCollectionButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AppPressable(
      onTap: onTap,
      pressedScale: 0.98,
      borderRadius: BorderRadius.circular(AppRadius.card),
      child: CustomPaint(
        painter: const _DashedBorderPainter(),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: AppColors.primaryLight.withValues(alpha: 0.4),
            borderRadius: BorderRadius.circular(AppRadius.card),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.sm,
              vertical: 10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.create_new_folder_outlined,
                  size: 18,
                  color: AppColors.primary,
                ),
                const SizedBox(width: 6),
                Flexible(
                  child: Text(
                    'Tạo bộ sưu tập mới (+ New Folder / List)',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.caption.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DashedBorderPainter extends CustomPainter {
  const _DashedBorderPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.primary.withValues(alpha: 0.4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;
    final path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Offset.zero & size,
          const Radius.circular(AppRadius.card),
        ),
      );
    for (final metric in path.computeMetrics()) {
      var distance = 0.0;
      while (distance < metric.length) {
        final end = (distance + 6).clamp(0, metric.length).toDouble();
        canvas.drawPath(metric.extractPath(distance, end), paint);
        distance += 10;
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DashedBorderPainter oldDelegate) => false;
}

class _CollectionCard extends StatelessWidget {
  const _CollectionCard({
    required this.card,
    required this.iconOnMint,
    required this.selected,
    required this.onTap,
  });

  final SavedCollectionCardData card;
  final bool iconOnMint;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AppPressable(
      onTap: onTap,
      pressedScale: 0.98,
      borderRadius: BorderRadius.circular(AppRadius.card),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.glass90,
          borderRadius: BorderRadius.circular(AppRadius.card),
          border: Border.all(
            color: selected ? AppColors.primary : AppColors.glassBorder,
          ),
          boxShadow: AppShadows.level1,
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: iconOnMint
                          ? AppColors.primaryLight
                          : AppColors.surfaceSubdued,
                      shape: BoxShape.circle,
                    ),
                    child: SizedBox(
                      width: 36,
                      height: 36,
                      child: Icon(
                        _collectionIcon(card.group),
                        size: 18,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '${card.count} mục',
                    style: AppTypography.badge.copyWith(
                      color: AppColors.textTertiary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                card.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.cardTitle,
              ),
              if (card.subtitle.isNotEmpty) ...[
                const SizedBox(height: 2),
                Text(
                  card.subtitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.caption,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

IconData _collectionIcon(SavedPlaceGroup? group) {
  if (group == null) return Icons.folder_outlined;
  return savedPlaceGroupIcon(group);
}

class _ListHeader extends StatelessWidget {
  const _ListHeader({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: Text(
            'Danh Sách Đã Lưu',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTypography.sectionTitle,
          ),
        ),
        const SizedBox(width: AppSpacing.xs),
        DecoratedBox(
          decoration: BoxDecoration(
            color: AppColors.surfaceSubdued,
            borderRadius: BorderRadius.circular(AppRadius.pill),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            child: Text(
              '$count',
              style: AppTypography.caption.copyWith(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        const Spacer(),
        Text(
          'Mới lưu nhất',
          style: AppTypography.caption.copyWith(color: AppColors.textSecondary),
        ),
      ],
    );
  }
}

class _LoadMore extends StatelessWidget {
  const _LoadMore({
    required this.loading,
    required this.error,
    required this.onPressed,
  });

  final bool loading;
  final Object? error;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (error != null)
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.xs),
            child: Text(
              'Không tải thêm được.',
              style: AppTypography.caption.copyWith(color: AppColors.danger),
            ),
          ),
        TextButton(
          onPressed: loading ? null : onPressed,
          child: loading
              ? const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : Text(error == null ? 'Tải thêm' : 'Thử lại'),
        ),
      ],
    );
  }
}

class _CollectionStatus extends StatelessWidget {
  const _CollectionStatus({
    required this.loading,
    required this.error,
    required this.onRetry,
  });

  final bool loading;
  final Object? error;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    if (loading || error == null) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: AppSpacing.xl),
        child: Center(
          child: SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
      child: Column(
        children: [
          Text(
            'Không tải được bộ sưu tập.',
            textAlign: TextAlign.center,
            style: AppTypography.body,
          ),
          TextButton(onPressed: onRetry, child: const Text('Thử lại')),
        ],
      ),
    );
  }
}
