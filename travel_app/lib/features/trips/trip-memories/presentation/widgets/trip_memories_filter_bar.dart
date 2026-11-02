import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_chip.dart';

import '../../application/trip_memories_filter.dart';
import '../../application/trip_memories_view.dart';
import '../../utils/trip_memories_formatters.dart';

/// Day chips and photographer chips, each row scrolling horizontally.
class TripMemoriesFilterBar extends StatelessWidget {
  const TripMemoriesFilterBar({
    super.key,
    required this.filter,
    required this.dayOptions,
    required this.contributors,
    required this.onSelectDay,
    required this.onSelectUploader,
    this.totalCount,
    this.viewerId,
  });

  final TripMemoriesFilter filter;
  final List<TripMemoryDayOption> dayOptions;
  final List<TripMemoryContributor> contributors;
  final int? totalCount;

  /// Shows the "Của tôi" chip; null for visitors.
  final String? viewerId;
  final ValueChanged<int?> onSelectDay;
  final ValueChanged<String?> onSelectUploader;

  @override
  Widget build(BuildContext context) {
    final others = [
      for (final member in contributors)
        if (member.userId != viewerId) member,
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _ChipRow(
          children: [
            AppChip(
              label: withCount('Tất cả', totalCount),
              selected: filter.day == null,
              onTap: () => onSelectDay(null),
            ),
            for (final option in dayOptions)
              AppChip(
                label: memoryDayChipLabel(option),
                selected: filter.day == option.day,
                onTap: () => onSelectDay(option.day),
              ),
          ],
        ),
        const SizedBox(height: AppSpacing.xs),
        _ChipRow(
          children: [
            Text(
              'Người chụp:',
              style: AppTypography.caption.copyWith(
                color: AppColors.textTertiary,
              ),
            ),
            AppChip(
              label: 'Tất cả thành viên',
              selected: filter.uploaderId == null,
              onTap: () => onSelectUploader(null),
            ),
            if (viewerId != null)
              AppChip(
                label: 'Của tôi',
                selected: filter.uploaderId == viewerId,
                onTap: () => onSelectUploader(viewerId),
              ),
            for (final member in others)
              AppChip(
                label: withCount(member.name, member.memoryCount),
                selected: filter.uploaderId == member.userId,
                onTap: () => onSelectUploader(member.userId),
              ),
          ],
        ),
      ],
    );
  }
}

class _ChipRow extends StatelessWidget {
  const _ChipRow({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.screenHorizontal,
      ),
      child: Row(
        children: [
          for (var i = 0; i < children.length; i++) ...[
            if (i > 0) const SizedBox(width: AppSpacing.xs),
            children[i],
          ],
        ],
      ),
    );
  }
}
