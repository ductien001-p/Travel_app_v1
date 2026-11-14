import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';

import '../../application/trip_timeline_view.dart';
import '../../data/models/trip_timeline_models.dart';
import '../../utils/trip_timeline_formatters.dart';
import 'trip_timeline_event_card.dart';
import 'trip_timeline_event_style.dart';

class TripTimelineDaySection extends StatelessWidget {
  const TripTimelineDaySection({
    super.key,
    required this.group,
    required this.now,
    required this.toWallClock,
    this.onEntryMore,
    this.onOpenAlbum,
  });

  final TripTimelineDayGroup group;
  final DateTime now;
  final TripTimelineWallClock toWallClock;

  /// Called from an event's "…" button; the button shows only for events
  /// that point at a resource.
  final ValueChanged<TripTimelineEntry>? onEntryMore;

  /// Opens the trip album from the photos of a memory event.
  final VoidCallback? onOpenAlbum;

  @override
  Widget build(BuildContext context) {
    final label = timelineDayLabel(group, now: now);
    final entries = group.entries;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _DayHeader(title: label.title, subtitle: label.subtitle),
        const SizedBox(height: AppSpacing.md),
        for (var i = 0; i < entries.length; i++)
          _TimelineTile(
            entry: entries[i],
            time: toWallClock(entries[i].createdAt),
            isFirst: i == 0,
            isLast: i == entries.length - 1,
            onMore: _moreFor(entries[i]),
            onOpenAlbum: onOpenAlbum,
          ),
      ],
    );
  }

  VoidCallback? _moreFor(TripTimelineEntry entry) {
    final onEntryMore = this.onEntryMore;
    if (onEntryMore == null || entry.targetId == null) return null;
    return () => onEntryMore(entry);
  }
}

class _DayHeader extends StatelessWidget {
  const _DayHeader({required this.title, this.subtitle});

  /// Share of the row the label may take before it wraps, so the divider
  /// never disappears at large text sizes.
  static const _maxLabelFraction = 0.8;

  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      header: true,
      child: LayoutBuilder(
        builder: (context, constraints) => Row(
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: constraints.maxWidth * _maxLabelFraction,
              ),
              child: Wrap(
                spacing: AppSpacing.xs,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text(
                    title,
                    style: AppTypography.sectionTitle.copyWith(fontSize: 18),
                  ),
                  if (subtitle != null)
                    Text(subtitle!, style: AppTypography.caption),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.xs),
            const Expanded(
              child: Divider(height: 1, color: AppColors.borderNeutral),
            ),
          ],
        ),
      ),
    );
  }
}

class _TimelineTile extends StatelessWidget {
  const _TimelineTile({
    required this.entry,
    required this.time,
    required this.isFirst,
    required this.isLast,
    this.onMore,
    this.onOpenAlbum,
  });

  static const _dotSize = 24.0;
  static const _dotTop = 6.0;
  static const _railWidth = 2.0;
  static const _dotCenter = _dotTop + _dotSize / 2;

  final TripTimelineEntry entry;
  final DateTime time;
  final bool isFirst;
  final bool isLast;
  final VoidCallback? onMore;
  final VoidCallback? onOpenAlbum;

  @override
  Widget build(BuildContext context) {
    final style = TripTimelineEventStyle.of(entry);
    final railTop = isFirst ? _dotCenter : 0.0;
    final hasRail = !(isFirst && isLast);
    return Stack(
      children: [
        if (hasRail)
          Positioned(
            left: (_dotSize - _railWidth) / 2,
            top: railTop,
            bottom: isLast ? null : 0,
            height: isLast ? _dotCenter - railTop : null,
            child: const ColoredBox(
              color: AppColors.primary20,
              child: SizedBox(width: _railWidth),
            ),
          ),
        Padding(
          padding: EdgeInsets.only(
            left: _dotSize + AppSpacing.xs,
            bottom: isLast ? 0 : AppSpacing.md,
          ),
          child: TripTimelineEventCard(
            entry: entry,
            time: time,
            style: style,
            onMore: onMore,
            onOpenAlbum: onOpenAlbum,
          ),
        ),
        Positioned(
          left: 0,
          top: _dotTop,
          child: TripTimelineDot(style: style, size: _dotSize),
        ),
      ],
    );
  }
}
