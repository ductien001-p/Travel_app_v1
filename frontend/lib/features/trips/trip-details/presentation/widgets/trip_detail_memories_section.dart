import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_gradients.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_shadows.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_pressable.dart';

import '../../data/models/trip_detail_models.dart';
import '../../utils/trip_detail_formatters.dart';
import 'trip_detail_section_header.dart';

class TripDetailMemoriesSection extends StatelessWidget {
  const TripDetailMemoriesSection({
    super.key,
    required this.memories,
    required this.onSeeAll,
    required this.onAddPhoto,
  });

  final TripDetailMemoriesPreview memories;
  final VoidCallback onSeeAll;
  final VoidCallback onAddPhoto;

  static const _columns = 3;

  @override
  Widget build(BuildContext context) {
    final previews = memories.items.take(_columns - 1).toList(growable: false);
    final tiles = <Widget>[
      for (final memory in previews)
        _MemoryTile(memory: memory, onTap: onSeeAll),
      _AddMemoryTile(onTap: onAddPhoto),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TripDetailSectionHeader(
          title: 'Kỷ niệm chuyến đi',
          countLabel: '${memories.totalCount} khoảnh khắc',
          actionLabel: memories.totalCount > 0 ? 'Tất cả' : null,
          onAction: onSeeAll,
        ),
        const SizedBox(height: AppSpacing.sm),
        Row(
          children: [
            for (var i = 0; i < _columns; i++) ...[
              if (i > 0) const SizedBox(width: 10),
              Expanded(
                child: AspectRatio(
                  aspectRatio: 1,
                  child: i < tiles.length ? tiles[i] : const SizedBox(),
                ),
              ),
            ],
          ],
        ),
        if (memories.items.isEmpty) ...[
          const SizedBox(height: AppSpacing.xs),
          Text(
            'Chưa có kỷ niệm nào. Hãy đăng khoảnh khắc đầu tiên!',
            style: AppTypography.caption,
          ),
        ],
      ],
    );
  }
}

class _MemoryTile extends StatelessWidget {
  const _MemoryTile({required this.memory, required this.onTap});

  final TripDetailMemory memory;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final caption = memory.caption;
    final author = memory.authorName ?? 'Thành viên cũ';
    return Semantics(
      button: true,
      label: caption ?? 'Kỷ niệm của $author',
      hint: 'Mở album kỷ niệm',
      excludeSemantics: true,
      child: AppPressable(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.input),
        child: _photo(caption, author),
      ),
    );
  }

  Widget _photo(String? caption, String author) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.input),
        boxShadow: AppShadows.level1,
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            memory.imageUrl,
            fit: BoxFit.cover,
            errorBuilder: (_, _, _) => const ColoredBox(
              color: AppColors.primaryLight,
              child: Icon(Icons.image_outlined, color: AppColors.primary),
            ),
          ),
          const DecoratedBox(
            decoration: BoxDecoration(gradient: AppGradients.heroImageOverlay),
          ),
          Positioned(
            left: 6,
            right: 6,
            bottom: 6,
            child: Row(
              children: [
                Container(
                  width: 18,
                  height: 18,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: AppColors.heroOverlay,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    initialsOf(author).characters.first,
                    style: AppTypography.badge.copyWith(
                      color: AppColors.textInverse,
                    ),
                  ),
                ),
                if (caption != null && caption.isNotEmpty) ...[
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      caption,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.caption.copyWith(
                        color: AppColors.textInverse,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AddMemoryTile extends StatelessWidget {
  const _AddMemoryTile({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: 'Đăng ảnh kỷ niệm mới',
      excludeSemantics: true,
      child: AppPressable(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.input),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.primary08,
            borderRadius: BorderRadius.circular(AppRadius.input),
            border: Border.all(color: AppColors.primary38),
          ),
          padding: const EdgeInsets.all(AppSpacing.xs),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.add_a_photo_outlined,
                size: 24,
                color: AppColors.primary,
              ),
              const SizedBox(height: 4),
              Text(
                'Đăng ảnh mới',
                textAlign: TextAlign.center,
                maxLines: 2,
                style: AppTypography.badge.copyWith(
                  color: AppColors.primaryActive,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
