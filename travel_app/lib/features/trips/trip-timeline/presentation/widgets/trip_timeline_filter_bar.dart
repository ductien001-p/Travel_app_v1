import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_bottom_sheet.dart';
import 'package:travel_frontend_v1/core/widget/app_chip.dart';
import 'package:travel_frontend_v1/core/widget/app_pressable.dart';

import '../../application/trip_timeline_filter.dart';
import '../../utils/trip_timeline_formatters.dart';

extension TripTimelineFilterIcon on TripTimelineFilter {
  IconData get icon => switch (this) {
    TripTimelineFilter.all => Icons.auto_awesome_outlined,
    TripTimelineFilter.checkin => Icons.pin_drop_outlined,
    TripTimelineFilter.expense => Icons.receipt_long_outlined,
    TripTimelineFilter.memory => Icons.photo_camera_outlined,
    TripTimelineFilter.member => Icons.group_outlined,
  };
}

/// Keeps the selected chip in view, also when it is picked from the sheet.
class TripTimelineFilterBar extends StatefulWidget {
  const TripTimelineFilterBar({
    super.key,
    required this.selected,
    required this.countLabels,
    required this.onSelected,
  });

  final TripTimelineFilter selected;
  final Map<TripTimelineFilter, String> countLabels;
  final ValueChanged<TripTimelineFilter> onSelected;

  @override
  State<TripTimelineFilterBar> createState() => _TripTimelineFilterBarState();
}

class _TripTimelineFilterBarState extends State<TripTimelineFilterBar> {
  static const _revealDuration = Duration(milliseconds: 250);

  final _scrollController = ScrollController();
  final _chipKeys = {
    for (final filter in TripTimelineFilter.values) filter: GlobalKey(),
  };

  @override
  void initState() {
    super.initState();
    if (widget.selected != TripTimelineFilter.all) {
      _revealSelectedAfterLayout(duration: Duration.zero);
    }
  }

  @override
  void didUpdateWidget(TripTimelineFilterBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selected != widget.selected) {
      _revealSelectedAfterLayout(duration: _revealDuration);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _revealSelectedAfterLayout({required Duration duration}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final chip = _chipKeys[widget.selected]!.currentContext
          ?.findRenderObject();
      if (!mounted || chip == null || !_scrollController.hasClients) return;
      // Only this row scrolls; the timeline list keeps its position.
      _scrollController.position.ensureVisible(
        chip,
        alignment: 0.5,
        duration: duration,
        curve: Curves.easeOutCubic,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _scrollController,
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.screenHorizontal,
        vertical: AppSpacing.xxs,
      ),
      child: Row(
        children: [
          for (final filter in TripTimelineFilter.values) ...[
            if (filter.index > 0) const SizedBox(width: AppSpacing.xs),
            KeyedSubtree(
              key: _chipKeys[filter],
              child: AppChip(
                label: '${filter.label} (${widget.countLabels[filter] ?? 0})',
                leadingIcon: filter.icon,
                selected: filter == widget.selected,
                onTap: () => widget.onSelected(filter),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

Future<TripTimelineFilter?> showTripTimelineFilterSheet(
  BuildContext context, {
  required TripTimelineFilter selected,
  required Map<TripTimelineFilter, String> countLabels,
}) {
  return showAppBottomSheet<TripTimelineFilter>(
    context: context,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Lọc sự kiện', style: AppTypography.sectionTitle),
        const SizedBox(height: AppSpacing.sm),
        for (final filter in TripTimelineFilter.values)
          _FilterOption(
            filter: filter,
            countLabel: countLabels[filter] ?? '0',
            selected: filter == selected,
          ),
      ],
    ),
  );
}

class _FilterOption extends StatelessWidget {
  const _FilterOption({
    required this.filter,
    required this.countLabel,
    required this.selected,
  });

  final TripTimelineFilter filter;
  final String countLabel;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final color = selected ? AppColors.primaryActive : AppColors.textPrimary;
    return Semantics(
      button: true,
      selected: selected,
      child: AppPressable(
        onTap: () => Navigator.of(context).pop(filter),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
          child: Row(
            children: [
              Icon(filter.icon, size: 20, color: color),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  filter.label,
                  style: AppTypography.bodyMedium.copyWith(color: color),
                ),
              ),
              Text(countLabel, style: AppTypography.caption),
              const SizedBox(width: AppSpacing.sm),
              Icon(
                selected
                    ? Icons.radio_button_checked_rounded
                    : Icons.radio_button_off_rounded,
                size: 20,
                color: selected ? AppColors.primary : AppColors.textTertiary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
