import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_shadows.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_pressable.dart';

import '../../../application/trip_itinerary_view.dart';
import '../../../utils/trip_detail_formatters.dart';

/// Horizontal day selector; keeps the selected day scrolled into view.
class TripItineraryDayRail extends StatefulWidget {
  const TripItineraryDayRail({
    super.key,
    required this.days,
    required this.selectedId,
    required this.onSelected,
  });

  final List<TripItineraryDayView> days;
  final String? selectedId;
  final ValueChanged<String> onSelected;

  @override
  State<TripItineraryDayRail> createState() => _TripItineraryDayRailState();
}

class _TripItineraryDayRailState extends State<TripItineraryDayRail> {
  static const _chipWidth = 78.0;
  static const _selectedChipWidth = 86.0;
  static const _gap = 10.0;

  final _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    _revealSelected(animate: false);
  }

  @override
  void didUpdateWidget(TripItineraryDayRail oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedId != widget.selectedId) _revealSelected();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// Scrolls only this rail, never the enclosing page.
  void _revealSelected({bool animate = true}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || !_controller.hasClients) return;
      final index = widget.days.indexWhere((d) => d.id == widget.selectedId);
      if (index < 0) return;
      final position = _controller.position;
      final chipCenter = index * (_chipWidth + _gap) + _selectedChipWidth / 2;
      final target = (chipCenter - position.viewportDimension / 2).clamp(
        0.0,
        position.maxScrollExtent,
      );
      if (animate) {
        _controller.animateTo(
          target,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
        );
      } else {
        _controller.jumpTo(target);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _controller,
      scrollDirection: Axis.horizontal,
      clipBehavior: Clip.none,
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xxs),
      child: Row(
        children: [
          for (var i = 0; i < widget.days.length; i++) ...[
            if (i > 0) const SizedBox(width: _gap),
            _DayChip(
              day: widget.days[i],
              selected: widget.days[i].id == widget.selectedId,
              width: widget.days[i].id == widget.selectedId
                  ? _selectedChipWidth
                  : _chipWidth,
              onTap: () => widget.onSelected(widget.days[i].id),
            ),
          ],
        ],
      ),
    );
  }
}

class _DayChip extends StatelessWidget {
  const _DayChip({
    required this.day,
    required this.selected,
    required this.width,
    required this.onTap,
  });

  final TripItineraryDayView day;
  final bool selected;
  final double width;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final date = formatDayMonth(day.day.date);
    final title = 'Ngày ${day.day.dayNumber}';

    return Semantics(
      button: true,
      selected: selected,
      label: '$title, $date',
      child: AppPressable(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.card),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          width: width,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.xxs,
            vertical: 10,
          ),
          decoration: BoxDecoration(
            color: selected ? AppColors.primaryActive : AppColors.surface,
            borderRadius: BorderRadius.circular(AppRadius.card),
            border: Border.all(
              color: selected ? AppColors.primary38 : AppColors.borderNeutral,
              width: selected ? 2 : 1,
            ),
            boxShadow: selected ? AppShadows.level2 : const [],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                date,
                style: AppTypography.caption.copyWith(
                  color: selected
                      ? AppColors.primaryLight
                      : AppColors.textTertiary,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                title,
                maxLines: 1,
                style: AppTypography.cardTitle.copyWith(
                  fontWeight: FontWeight.w700,
                  color: selected
                      ? AppColors.textInverse
                      : AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: AppSpacing.xxs),
              _DayStatusLabel(day: day, selected: selected),
            ],
          ),
        ),
      ),
    );
  }
}

class _DayStatusLabel extends StatelessWidget {
  const _DayStatusLabel({required this.day, required this.selected});

  final TripItineraryDayView day;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return switch (day.status) {
      TripItineraryDayStatus.today => _pill(
        label: 'Hôm nay',
        background: selected ? AppColors.primaryLight : AppColors.primary12,
        foreground: AppColors.primaryActive,
      ),
      TripItineraryDayStatus.done => _pill(
        label: 'Xong',
        icon: Icons.check_circle_rounded,
        background: AppColors.success.withValues(alpha: 0.12),
        foreground: AppColors.success,
      ),
      TripItineraryDayStatus.planned => FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          day.activities.isEmpty
              ? 'Trống'
              : '${day.activities.length} hoạt động',
          maxLines: 1,
          style: AppTypography.caption.copyWith(
            fontSize: 11,
            color: selected ? AppColors.primaryLight : AppColors.textTertiary,
          ),
        ),
      ),
    };
  }

  Widget _pill({
    required String label,
    required Color background,
    required Color foreground,
    IconData? icon,
  }) {
    final pill = Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 12, color: foreground),
            const SizedBox(width: 2),
          ],
          Text(
            label,
            style: AppTypography.badge.copyWith(
              fontSize: 10,
              color: foreground,
            ),
          ),
        ],
      ),
    );
    return FittedBox(fit: BoxFit.scaleDown, child: pill);
  }
}
