import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_shadows.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_pressable.dart';

import '../../../application/trip_itinerary_view.dart';
import '../../../utils/trip_detail_formatters.dart';

/// Segmented selector of the trip's destinations; scrolls past three items.
class TripItineraryDestinationTabs extends StatelessWidget {
  const TripItineraryDestinationTabs({
    super.key,
    required this.destinations,
    required this.selectedId,
    required this.onSelected,
  });

  static const _maxFittedTabs = 3;
  static const _scrollableTabMaxWidth = 220.0;

  final List<TripItineraryDestinationView> destinations;
  final String? selectedId;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    final tabs = [
      for (final destination in destinations)
        _DestinationTab(
          destination: destination,
          selected: destination.id == selectedId,
          onTap: () => onSelected(destination.id),
        ),
    ];

    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: AppColors.surfaceSubdued,
        borderRadius: BorderRadius.circular(AppRadius.pill),
        border: Border.all(color: AppColors.borderBrandSoft),
      ),
      child: destinations.length <= _maxFittedTabs
          ? Row(
              children: [
                for (var i = 0; i < tabs.length; i++) ...[
                  if (i > 0) const SizedBox(width: AppSpacing.xxs),
                  Expanded(child: tabs[i]),
                ],
              ],
            )
          : SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  for (var i = 0; i < tabs.length; i++) ...[
                    if (i > 0) const SizedBox(width: AppSpacing.xxs),
                    ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxWidth: _scrollableTabMaxWidth,
                      ),
                      child: tabs[i],
                    ),
                  ],
                ],
              ),
            ),
    );
  }
}

class _DestinationTab extends StatelessWidget {
  const _DestinationTab({
    required this.destination,
    required this.selected,
    required this.onTap,
  });

  final TripItineraryDestinationView destination;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final data = destination.destination;
    final foreground = selected
        ? AppColors.textInverse
        : AppColors.textSecondary;

    return Semantics(
      button: true,
      selected: selected,
      label: 'Điểm đến ${data.city}',
      child: AppPressable(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.pill),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.sm,
            vertical: AppSpacing.xs,
          ),
          decoration: BoxDecoration(
            color: selected ? AppColors.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(AppRadius.pill),
            boxShadow: selected ? AppShadows.level1 : const [],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                selected ? Icons.location_on_rounded : Icons.flag_outlined,
                size: 16,
                color: selected
                    ? AppColors.textInverse
                    : AppColors.textTertiary,
              ),
              const SizedBox(width: AppSpacing.xxs),
              Flexible(
                child: Text(
                  data.city,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.bodyMedium.copyWith(
                    color: foreground,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.xxs),
              Flexible(
                child: Text(
                  formatShortDateRange(data.startDate, data.endDate),
                  maxLines: 1,
                  overflow: TextOverflow.fade,
                  softWrap: false,
                  style: AppTypography.caption.copyWith(
                    fontSize: 10,
                    color: selected
                        ? AppColors.textInverse.withValues(alpha: 0.85)
                        : AppColors.textTertiary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
