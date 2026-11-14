import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';

import '../../application/trip_memories_view.dart';
import '../../utils/trip_memories_formatters.dart';
import 'trip_memory_photo_tile.dart';

/// Photos of one day: a header, then a bento grid led by a featured photo.
class TripMemoryDaySection extends StatelessWidget {
  const TripMemoryDaySection({
    super.key,
    required this.group,
    required this.onOpen,
  });

  final TripMemoryDayGroup group;
  final ValueChanged<TripMemoryTile> onOpen;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _DayHeader(group: group),
        const SizedBox(height: AppSpacing.sm),
        _BentoGrid(tiles: group.tiles, onOpen: onOpen),
      ],
    );
  }
}

class _DayHeader extends StatelessWidget {
  const _DayHeader({required this.group});

  final TripMemoryDayGroup group;

  @override
  Widget build(BuildContext context) {
    final place = group.place;
    final metaStyle = AppTypography.caption.copyWith(
      color: AppColors.textSecondary,
    );
    return Semantics(
      header: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: AppSpacing.xs,
                height: AppSpacing.xs,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  memoryGroupTitle(group),
                  style: AppTypography.sectionTitle.copyWith(fontSize: 18),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xxs),
          Padding(
            padding: const EdgeInsets.only(left: 14),
            child: Wrap(
              spacing: AppSpacing.xs,
              runSpacing: AppSpacing.xxs,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                _MetaItem(
                  icon: Icons.calendar_today_outlined,
                  text: formatMemoryDate(group.date),
                  style: metaStyle,
                ),
                if (place != null && group.day != null)
                  _MetaItem(
                    icon: Icons.location_on_outlined,
                    text: place,
                    style: metaStyle,
                  ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.xs,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceSubdued,
                    borderRadius: BorderRadius.circular(AppRadius.pill),
                  ),
                  child: Text(
                    memoryCountLabel(group.count),
                    style: AppTypography.badge.copyWith(
                      color: AppColors.textTertiary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MetaItem extends StatelessWidget {
  const _MetaItem({
    required this.icon,
    required this.text,
    required this.style,
  });

  final IconData icon;
  final String text;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: AppColors.primary),
        const SizedBox(width: 2),
        Flexible(child: Text(text, style: style)),
      ],
    );
  }
}

/// One photo spans the width; two share a row; three or more start with a
/// 2×2 featured photo next to two small ones, then rows of three.
class _BentoGrid extends StatelessWidget {
  const _BentoGrid({required this.tiles, required this.onOpen});

  static const _gap = AppSpacing.xs;
  static const _wideAspectRatio = 16 / 10;

  final List<TripMemoryTile> tiles;
  final ValueChanged<TripMemoryTile> onOpen;

  /// The first photo with a suggested badge leads, otherwise the newest.
  List<TripMemoryTile> get _ordered {
    final index = tiles.indexWhere(
      (tile) => tile.entry.badge?.trim().isNotEmpty ?? false,
    );
    if (index <= 0) return tiles;
    return [tiles[index], ...tiles.take(index), ...tiles.skip(index + 1)];
  }

  @override
  Widget build(BuildContext context) {
    final ordered = _ordered;
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final cell = (width - _gap * 2) / 3;
        if (ordered.length == 1) {
          return SizedBox(
            height: width / _wideAspectRatio,
            child: _photo(ordered.first, featured: true),
          );
        }
        if (ordered.length == 2) {
          final half = (width - _gap) / 2;
          return SizedBox(
            height: half,
            child: Row(
              children: [
                Expanded(child: _photo(ordered[0], featured: true)),
                const SizedBox(width: _gap),
                Expanded(child: _photo(ordered[1])),
              ],
            ),
          );
        }
        final rest = ordered.skip(3).toList(growable: false);
        return Column(
          children: [
            SizedBox(
              height: cell * 2 + _gap,
              child: Row(
                children: [
                  SizedBox(
                    width: cell * 2 + _gap,
                    child: _photo(ordered[0], featured: true),
                  ),
                  const SizedBox(width: _gap),
                  Expanded(
                    child: Column(
                      children: [
                        Expanded(child: _photo(ordered[1])),
                        const SizedBox(height: _gap),
                        Expanded(child: _photo(ordered[2])),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            for (var start = 0; start < rest.length; start += 3) ...[
              const SizedBox(height: _gap),
              SizedBox(
                height: cell,
                child: Row(
                  children: [
                    for (var i = start; i < start + 3; i++) ...[
                      if (i > start) const SizedBox(width: _gap),
                      Expanded(
                        child: i < rest.length
                            ? _photo(rest[i])
                            : const SizedBox.shrink(),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ],
        );
      },
    );
  }

  Widget _photo(TripMemoryTile tile, {bool featured = false}) =>
      TripMemoryPhotoTile(
        tile: tile,
        featured: featured,
        onTap: () => onOpen(tile),
      );
}
