import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/networks/api_exception.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_badge.dart';
import 'package:travel_frontend_v1/core/widget/app_chip.dart';
import 'package:travel_frontend_v1/core/widget/app_empty_view.dart';
import 'package:travel_frontend_v1/core/widget/app_search_bar.dart';

import '../../application/user_memories_view.dart';
import '../../data/models/user_memories_models.dart';
import 'user_memories_gallery.dart';
import 'user_memories_highlight_card.dart';

class UserMemoriesBody extends StatelessWidget {
  const UserMemoriesBody({
    super.key,
    required this.gallery,
    required this.filter,
    required this.onSelectTrip,
    required this.onQueryChanged,
    required this.onManage,
    required this.onOpenHighlight,
    required this.onLikeHighlight,
    required this.onShareHighlight,
    required this.onOpenItem,
    required this.onLikeItem,
    required this.onLoadMore,
  });

  final UserMemoriesState gallery;
  final UserMemoriesFilterState filter;
  final ValueChanged<String?> onSelectTrip;
  final ValueChanged<String> onQueryChanged;
  final VoidCallback onManage;
  final VoidCallback onOpenHighlight;
  final VoidCallback onLikeHighlight;
  final VoidCallback onShareHighlight;
  final ValueChanged<UserMemoryPhoto> onOpenItem;
  final ValueChanged<UserMemoryPhoto> onLikeItem;
  final VoidCallback onLoadMore;

  @override
  Widget build(BuildContext context) {
    final highlight = gallery.highlight;
    final loadError = gallery.loadMoreError;
    final canRetryLoad =
        loadError != null &&
        !(loadError is ApiException && loadError.statusCode == 401);

    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification.metrics.pixels >=
            notification.metrics.maxScrollExtent - 240) {
          onLoadMore();
        }
        return false;
      },
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.screenHorizontal,
          AppSpacing.lg,
          AppSpacing.screenHorizontal,
          AppSpacing.safeBottom,
        ),
        children: [
          if (filter.searchOpen) ...[
            AppSearchBar(
              hintText: 'Tìm theo chú thích...',
              onChanged: onQueryChanged,
            ),
            const SizedBox(height: AppSpacing.lg),
          ],
          _CollectionHeader(onManage: onManage),
          const SizedBox(height: AppSpacing.sm),
          SizedBox(
            height: 40,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: gallery.collections.length + 1,
              separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.xs),
              itemBuilder: (context, index) {
                if (index == 0) {
                  return AppChip(
                    label: 'Tất cả ảnh (${gallery.allPhotoCount})',
                    selected: filter.tripId == null,
                    onTap: () => onSelectTrip(null),
                  );
                }
                final collection = gallery.collections[index - 1];
                return AppChip(
                  label: '${collection.name} (${collection.memoryCount})',
                  selected: collection.tripId == filter.tripId,
                  onTap: () => onSelectTrip(collection.tripId),
                );
              },
            ),
          ),
          if (highlight != null) ...[
            const SizedBox(height: AppSpacing.xl),
            Row(
              children: [
                Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: AppSpacing.xs),
                Expanded(
                  child: Text(
                    'Điểm Nhấn Kỷ Niệm',
                    style: AppTypography.sectionTitle,
                  ),
                ),
                const AppBadge(label: 'Nổi bật trong tháng'),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            UserMemoriesHighlightCard(
              highlight: highlight,
              onOpen: onOpenHighlight,
              onLike: onLikeHighlight,
              onShare: onShareHighlight,
            ),
          ],
          const SizedBox(height: AppSpacing.xl),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Thư Viện Ảnh Kỷ Niệm',
                  style: AppTypography.sectionTitle,
                ),
              ),
              const SizedBox(width: AppSpacing.xs),
              Flexible(
                child: Text(
                  'Sắp xếp theo ngày gần nhất',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.end,
                  style: AppTypography.caption.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          if (gallery.items.isEmpty)
            const AppEmptyView(
              icon: Icons.photo_library_outlined,
              title: 'Chưa có ảnh trong bộ này',
              description: 'Ảnh bạn đăng trong chuyến đi sẽ hiện ở đây.',
            )
          else
            UserMemoriesGalleryGrid(
              items: gallery.items,
              layout: filter.layout,
              onOpen: onOpenItem,
              onLike: onLikeItem,
            ),
          if (gallery.loadingMore) ...[
            const SizedBox(height: AppSpacing.md),
            const Center(
              child: SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ),
          ],
          if (canRetryLoad) ...[
            const SizedBox(height: AppSpacing.sm),
            Center(
              child: TextButton(
                onPressed: onLoadMore,
                child: const Text('Thử lại'),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _CollectionHeader extends StatelessWidget {
  const _CollectionHeader({required this.onManage});

  final VoidCallback onManage;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            'BỘ SƯU TẬP CHUYẾN ĐI',
            style: AppTypography.caption.copyWith(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.6,
            ),
          ),
        ),
        TextButton(
          onPressed: onManage,
          style: TextButton.styleFrom(
            foregroundColor: AppColors.primary,
            visualDensity: VisualDensity.compact,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Quản lý',
                style: AppTypography.caption.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Icon(Icons.chevron_right_rounded, size: 16),
            ],
          ),
        ),
      ],
    );
  }
}
