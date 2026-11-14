import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_shadows.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_badge.dart';
import 'package:travel_frontend_v1/core/widget/app_button.dart';

import '../../../application/trip_itinerary_view.dart';
import '../../../utils/trip_itinerary_formatters.dart';

class TripItineraryActivityCard extends StatelessWidget {
  const TripItineraryActivityCard({
    super.key,
    required this.item,
    this.onMore,
    this.onCheckin,
    this.isCheckingIn = false,
  });

  final TripItineraryActivityView item;
  final VoidCallback? onMore;

  /// Shown only on the next activity; null hides the call to action.
  final VoidCallback? onCheckin;
  final bool isCheckingIn;

  @override
  Widget build(BuildContext context) {
    return switch (item.status) {
      TripItineraryActivityStatus.checkedIn => _CheckedInCard(
        item: item,
        onMore: onMore,
      ),
      TripItineraryActivityStatus.next => _NextCard(
        item: item,
        onMore: onMore,
        onCheckin: onCheckin,
        isCheckingIn: isCheckingIn,
      ),
      TripItineraryActivityStatus.upcoming => _UpcomingCard(
        item: item,
        onMore: onMore,
      ),
    };
  }
}

class _CheckedInCard extends StatelessWidget {
  const _CheckedInCard({required this.item, required this.onMore});

  final TripItineraryActivityView item;
  final VoidCallback? onMore;

  @override
  Widget build(BuildContext context) {
    final activity = item.activity;
    final imageUrl = activity.place?.imageUrl;

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.card),
        boxShadow: AppShadows.level1,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppRadius.card),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: const BoxDecoration(
            color: AppColors.glass90,
            border: Border(
              left: BorderSide(color: AppColors.success, width: 4),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _CardHeader(
                item: item,
                timeColor: AppColors.success,
                badge: const AppBadge(
                  label: 'Đã check-in',
                  tone: AppBadgeTone.success,
                  icon: Icons.check_circle_rounded,
                ),
                onMore: onMore,
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  if (imageUrl != null) ...[
                    _PlaceImage(url: imageUrl, size: 64),
                    const SizedBox(width: AppSpacing.sm),
                  ],
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _AddressLine(item: item),
                        const SizedBox(height: AppSpacing.xxs),
                        Wrap(
                          spacing: AppSpacing.sm,
                          runSpacing: AppSpacing.xxs,
                          children: [
                            _IconText(
                              icon: Icons.sell_outlined,
                              text: formatActivityCost(activity.estimatedCost),
                              color: AppColors.success,
                            ),
                            if (activity.estimatedDuration case final minutes?
                                when minutes > 0)
                              _IconText(
                                icon: Icons.timelapse_rounded,
                                text: formatDurationMinutes(minutes),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NextCard extends StatelessWidget {
  const _NextCard({
    required this.item,
    required this.onMore,
    required this.onCheckin,
    required this.isCheckingIn,
  });

  final TripItineraryActivityView item;
  final VoidCallback? onMore;
  final VoidCallback? onCheckin;
  final bool isCheckingIn;

  @override
  Widget build(BuildContext context) {
    final activity = item.activity;
    final imageUrl = activity.place?.imageUrl;
    final duration = activity.estimatedDuration;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(color: AppColors.primary38, width: 2),
        boxShadow: AppShadows.level2,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _CardHeader(
            item: item,
            timeColor: AppColors.primaryActive,
            badge: const _FilledBadge(label: 'Tiếp theo'),
            titleStyle: AppTypography.sectionTitle.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
            onMore: onMore,
          ),
          if (imageUrl != null) ...[
            const SizedBox(height: AppSpacing.sm),
            SizedBox(
              height: 128,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  _PlaceImage(url: imageUrl),
                  Positioned(
                    left: AppSpacing.xs,
                    bottom: AppSpacing.xs,
                    child: _ImageCaption(text: 'Điểm check-in nổi bật'),
                  ),
                ],
              ),
            ),
          ],
          const SizedBox(height: AppSpacing.sm),
          _AddressLine(item: item),
          const SizedBox(height: AppSpacing.xxs),
          Row(
            children: [
              if (duration != null && duration > 0)
                Expanded(
                  child: _IconText(
                    icon: Icons.timelapse_rounded,
                    text: 'Dự kiến: ${formatDurationMinutes(duration)}',
                  ),
                )
              else
                const Spacer(),
              Text(
                formatActivityCost(activity.estimatedCost),
                style: AppTypography.caption.copyWith(
                  color: AppColors.primaryActive,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          if (onCheckin != null || isCheckingIn) ...[
            const SizedBox(height: AppSpacing.sm),
            AppButton(
              label: 'Check-in ngay tại đây',
              leadingIcon: Icons.where_to_vote_rounded,
              isLoading: isCheckingIn,
              onPressed: onCheckin,
            ),
          ],
        ],
      ),
    );
  }
}

class _UpcomingCard extends StatelessWidget {
  const _UpcomingCard({required this.item, required this.onMore});

  final TripItineraryActivityView item;
  final VoidCallback? onMore;

  @override
  Widget build(BuildContext context) {
    final activity = item.activity;
    final category = placeCategoryStyle(activity.place?.category);

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.glass85,
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(color: AppColors.borderNeutral),
        boxShadow: AppShadows.level1,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _CardHeader(
            item: item,
            timeColor: AppColors.textTertiary,
            onMore: onMore,
          ),
          const SizedBox(height: AppSpacing.xs),
          const Divider(height: 1, color: AppColors.borderNeutral),
          const SizedBox(height: AppSpacing.xs),
          Row(
            children: [
              Expanded(
                child: _IconText(icon: category.icon, text: category.label),
              ),
              const SizedBox(width: AppSpacing.xs),
              Text(
                formatActivityCost(activity.estimatedCost),
                style: AppTypography.caption.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CardHeader extends StatelessWidget {
  const _CardHeader({
    required this.item,
    required this.timeColor,
    required this.onMore,
    this.badge,
    this.titleStyle,
  });

  final TripItineraryActivityView item;
  final Color timeColor;
  final VoidCallback? onMore;
  final Widget? badge;
  final TextStyle? titleStyle;

  @override
  Widget build(BuildContext context) {
    final time = formatActivityTimeRange(item.activity.startTime, item.endTime);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                spacing: AppSpacing.xs,
                runSpacing: AppSpacing.xxs,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text(
                    time ?? 'Chưa đặt giờ',
                    style: AppTypography.bodyMedium.copyWith(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: timeColor,
                    ),
                  ),
                  ?badge,
                ],
              ),
              const SizedBox(height: AppSpacing.xxs),
              Text(
                item.activity.title,
                style:
                    titleStyle ??
                    AppTypography.cardTitle.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
              if (item.activity.notes case final notes?
                  when notes.trim().isNotEmpty) ...[
                const SizedBox(height: AppSpacing.xxs),
                Text(
                  notes.trim(),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.caption.copyWith(
                    color: AppColors.textSecondary,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ],
          ),
        ),
        if (onMore != null)
          IconButton(
            onPressed: onMore,
            tooltip: 'Thao tác hoạt động',
            icon: const Icon(Icons.more_vert_rounded),
            iconSize: 18,
            color: AppColors.textTertiary,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints.tightFor(width: 36, height: 36),
          ),
      ],
    );
  }
}

class _AddressLine extends StatelessWidget {
  const _AddressLine({required this.item});

  final TripItineraryActivityView item;

  @override
  Widget build(BuildContext context) {
    final place = item.activity.place;
    final address = place?.address ?? place?.name;
    if (address == null || address.trim().isEmpty) {
      return const SizedBox.shrink();
    }
    return _IconText(
      icon: Icons.location_on_outlined,
      text: address,
      iconColor: AppColors.primary,
    );
  }
}

class _IconText extends StatelessWidget {
  const _IconText({
    required this.icon,
    required this.text,
    this.color = AppColors.textSecondary,
    this.iconColor,
  });

  final IconData icon;
  final String text;
  final Color color;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: iconColor ?? color),
        const SizedBox(width: AppSpacing.xxs),
        Flexible(
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
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

class _FilledBadge extends StatelessWidget {
  const _FilledBadge({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xs,
        vertical: 3,
      ),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: const BoxDecoration(
              color: AppColors.textInverse,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: AppSpacing.xxs),
          Text(
            label,
            style: AppTypography.badge.copyWith(
              fontSize: 10,
              color: AppColors.textInverse,
            ),
          ),
        ],
      ),
    );
  }
}

class _ImageCaption extends StatelessWidget {
  const _ImageCaption({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.heroOverlay,
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.photo_camera_outlined,
            size: 13,
            color: AppColors.textInverse,
          ),
          const SizedBox(width: AppSpacing.xxs),
          Text(
            text,
            style: AppTypography.caption.copyWith(
              fontSize: 11,
              color: AppColors.textInverse,
            ),
          ),
        ],
      ),
    );
  }
}

class _PlaceImage extends StatelessWidget {
  const _PlaceImage({required this.url, this.size});

  final String url;

  /// Square side; null fills the parent.
  final double? size;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppRadius.input),
      child: SizedBox(
        width: size,
        height: size,
        child: Image.network(
          url,
          fit: BoxFit.cover,
          semanticLabel: 'Ảnh địa điểm',
          errorBuilder: (_, _, _) => const ColoredBox(
            color: AppColors.primaryLight,
            child: Icon(Icons.image_outlined, color: AppColors.primary),
          ),
        ),
      ),
    );
  }
}
