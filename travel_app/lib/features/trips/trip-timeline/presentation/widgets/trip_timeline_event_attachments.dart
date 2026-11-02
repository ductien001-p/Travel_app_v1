import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';

import '../../../trip-details/utils/trip_detail_formatters.dart';
import '../../data/models/trip_timeline_models.dart';
import '../../utils/trip_timeline_formatters.dart';

/// Type-specific details under the event sentence, or nothing when the
/// backend sent no metadata for it.
class TripTimelineEventAttachment extends StatelessWidget {
  const TripTimelineEventAttachment({
    super.key,
    required this.entry,
    this.onOpenAlbum,
  });

  final TripTimelineEntry entry;

  /// Opens the trip album from a photo strip; no "Xem album" when null.
  final VoidCallback? onOpenAlbum;

  @override
  Widget build(BuildContext context) {
    final meta = entry.metadata;
    if (meta == null) return const SizedBox.shrink();
    final attachment = switch (entry.type) {
      TripTimelineEntryType.tripCreated => _tripPlan(meta),
      TripTimelineEntryType.memoryAdded || TripTimelineEntryType.photoAdded
          when meta.photoUrls.isNotEmpty =>
        _PhotoStrip(
          urls: meta.photoUrls,
          totalCount: meta.photoCount ?? meta.photoUrls.length,
          onOpenAlbum: onOpenAlbum,
        ),
      TripTimelineEntryType.expenseCreated => _expenseSplit(meta),
      TripTimelineEntryType.expenseSettled => _settledExpense(meta),
      TripTimelineEntryType.activityCheckin => _checkinPlace(meta),
      TripTimelineEntryType.activityUpdated
          when meta.previousStartTime != null && meta.startTime != null =>
        _TimeChange(from: meta.previousStartTime!, to: meta.startTime!),
      TripTimelineEntryType.activityAdded => _activitySchedule(meta),
      _ => null,
    };
    if (attachment == null) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.xs),
      child: attachment,
    );
  }

  Widget? _tripPlan(TripTimelineEntryMetadata meta) {
    final start = meta.startDate;
    final end = meta.endDate;
    final destinations = meta.destinationCount ?? 0;
    final parts = [
      if (start != null && end != null) formatDateRange(start, end),
      if (destinations > 0) '$destinations điểm đến',
    ];
    if (parts.isEmpty) return null;
    return _InfoRow(icon: Icons.flag_outlined, text: parts.join(' • '));
  }

  Widget? _expenseSplit(TripTimelineEntryMetadata meta) {
    final amount = meta.amount;
    final split = meta.splitCount;
    if (split == null || split <= 0) return null;
    if (meta.splitType != TripTimelineSplitType.equal || amount == null) {
      return _InfoRow(
        icon: Icons.group_outlined,
        text: 'Chia cho $split người',
      );
    }
    return _InfoRow(
      icon: Icons.group_outlined,
      text: 'Chia đều $split người',
      trailing:
          '${formatTripMoney(amount / split, currency: meta.currency)} / người',
    );
  }

  Widget? _settledExpense(TripTimelineEntryMetadata meta) {
    final description = meta.description?.trim();
    if (description == null || description.isEmpty) return null;
    return _NoteRow(
      icon: Icons.task_alt_rounded,
      text: 'Khoản chi: $description',
      color: AppColors.success,
    );
  }

  Widget? _checkinPlace(TripTimelineEntryMetadata meta) {
    final lat = meta.latitude;
    final lng = meta.longitude;
    final hasCoordinates = lat != null && lng != null;
    if (!hasCoordinates && meta.imageUrl == null && meta.placeArea == null) {
      return null;
    }
    return Row(
      children: [
        if (meta.imageUrl != null) ...[
          TripTimelineImage(url: meta.imageUrl!, width: 64, height: 64),
          const SizedBox(width: AppSpacing.sm),
        ],
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (hasCoordinates)
                _CoordinatesChip(label: formatCoordinates(lat, lng)),
              if (hasCoordinates && meta.placeArea != null)
                const SizedBox(height: AppSpacing.xxs),
              if (meta.placeArea != null)
                _NoteRow(
                  icon: Icons.forest_outlined,
                  text: meta.placeArea!,
                  color: AppColors.textSecondary,
                  iconColor: AppColors.warning,
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget? _activitySchedule(TripTimelineEntryMetadata meta) {
    final parts = [
      if (meta.dayNumber != null) 'Ngày ${meta.dayNumber}',
      if (meta.startTime != null) formatClock(meta.startTime!),
      ?meta.placeName,
    ];
    if (parts.isEmpty) return null;
    return _InfoRow(icon: Icons.event_outlined, text: parts.join(' • '));
  }
}

class TripTimelineImage extends StatelessWidget {
  const TripTimelineImage({
    super.key,
    required this.url,
    required this.height,
    this.width,
  });

  final String url;
  final double height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    final dpr = MediaQuery.devicePixelRatioOf(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppRadius.input),
      child: SizedBox(
        width: width,
        height: height,
        child: Image.network(
          url,
          fit: BoxFit.cover,
          cacheHeight: (height * dpr).round(),
          errorBuilder: (_, _, _) => const ColoredBox(
            color: AppColors.surfaceSubdued,
            child: Center(
              child: Icon(
                Icons.image_not_supported_outlined,
                color: AppColors.textTertiary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _PhotoStrip extends StatelessWidget {
  const _PhotoStrip({
    required this.urls,
    required this.totalCount,
    this.onOpenAlbum,
  });

  static const _visible = 3;
  static const _height = 80.0;

  final List<String> urls;
  final int totalCount;
  final VoidCallback? onOpenAlbum;

  @override
  Widget build(BuildContext context) {
    final shown = urls.take(_visible).toList(growable: false);
    final hidden = totalCount - shown.length;
    final strip = Row(
      children: [
        for (var i = 0; i < _visible; i++) ...[
          if (i > 0) const SizedBox(width: AppSpacing.xs),
          Expanded(
            child: i < shown.length
                ? Stack(
                    fit: StackFit.passthrough,
                    children: [
                      TripTimelineImage(url: shown[i], height: _height),
                      if (i == shown.length - 1 &&
                          (hidden > 0 || onOpenAlbum != null))
                        Positioned.fill(
                          child: _AlbumOverlay(
                            hiddenCount: hidden,
                            showAlbumLink: onOpenAlbum != null,
                          ),
                        ),
                    ],
                  )
                : const SizedBox(height: _height),
          ),
        ],
      ],
    );
    if (onOpenAlbum == null) return strip;
    return Semantics(
      button: true,
      label: 'Xem album kỷ niệm',
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onOpenAlbum,
        child: ExcludeSemantics(child: strip),
      ),
    );
  }
}

class _AlbumOverlay extends StatelessWidget {
  const _AlbumOverlay({required this.hiddenCount, required this.showAlbumLink});

  final int hiddenCount;
  final bool showAlbumLink;

  @override
  Widget build(BuildContext context) {
    final style = AppTypography.badge.copyWith(color: AppColors.textInverse);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.primaryActive.withValues(alpha: 0.75),
        borderRadius: BorderRadius.circular(AppRadius.input),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xxs),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (hiddenCount > 0) Text('+$hiddenCount ảnh', style: style),
              if (showAlbumLink)
                Text(
                  'Xem album',
                  style: style.copyWith(
                    fontSize: 9,
                    fontWeight: FontWeight.w500,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.icon, required this.text, this.trailing});

  final IconData icon;
  final String text;
  final String? trailing;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: AppColors.surfaceSubdued,
        borderRadius: BorderRadius.circular(AppRadius.input),
      ),
      child: Row(
        children: [
          Icon(icon, size: 16, color: AppColors.primary),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              text,
              style: AppTypography.caption.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
          if (trailing != null) ...[
            const SizedBox(width: AppSpacing.xs),
            Flexible(
              child: Text(
                trailing!,
                textAlign: TextAlign.end,
                style: AppTypography.caption.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _NoteRow extends StatelessWidget {
  const _NoteRow({
    required this.icon,
    required this.text,
    required this.color,
    this.iconColor,
  });

  final IconData icon;
  final String text;
  final Color color;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 15, color: iconColor ?? color),
        const SizedBox(width: AppSpacing.xxs),
        Expanded(
          child: Text(
            text,
            style: AppTypography.caption.copyWith(
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

class _CoordinatesChip extends StatelessWidget {
  const _CoordinatesChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xs,
        vertical: AppSpacing.xxs,
      ),
      decoration: BoxDecoration(
        color: AppColors.surfaceSubdued,
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.explore_outlined,
            size: 14,
            color: AppColors.primary,
          ),
          const SizedBox(width: AppSpacing.xxs),
          Flexible(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTypography.caption.copyWith(fontSize: 11),
            ),
          ),
        ],
      ),
    );
  }
}

class _TimeChange extends StatelessWidget {
  const _TimeChange({required this.from, required this.to});

  final DateTime from;
  final DateTime to;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.xxs,
        ),
        decoration: BoxDecoration(
          color: AppColors.warning.withValues(alpha: 0.10),
          borderRadius: BorderRadius.circular(AppRadius.pill),
          border: Border.all(color: AppColors.warning.withValues(alpha: 0.30)),
        ),
        child: Wrap(
          spacing: AppSpacing.xxs,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text(
              formatClock(from),
              style: AppTypography.caption.copyWith(
                color: AppColors.textTertiary,
                decoration: TextDecoration.lineThrough,
              ),
            ),
            const Icon(
              Icons.arrow_forward_rounded,
              size: 14,
              color: AppColors.warning,
            ),
            Text(
              formatClock(to),
              style: AppTypography.caption.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
