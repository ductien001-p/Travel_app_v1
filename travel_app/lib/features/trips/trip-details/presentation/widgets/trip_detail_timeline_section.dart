import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_avatar.dart';
import 'package:travel_frontend_v1/core/widget/app_card.dart';

import '../../data/models/trip_detail_models.dart';
import '../../utils/trip_detail_formatters.dart';
import 'trip_detail_section_header.dart';

class TripDetailTimelineSection extends StatelessWidget {
  const TripDetailTimelineSection({
    super.key,
    required this.timeline,
    required this.now,
    required this.onSeeMore,
  });

  final TripDetailTimelinePreview timeline;
  final DateTime now;
  final VoidCallback onSeeMore;

  @override
  Widget build(BuildContext context) {
    final events = timeline.items;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TripDetailSectionHeader(
          title: 'Dòng thời gian sự kiện',
          leadingIcon: Icons.history_rounded,
          actionLabel: timeline.totalCount > 0
              ? 'Xem thêm (${timeline.totalCount})'
              : null,
          actionIcon: Icons.arrow_forward_rounded,
          onAction: onSeeMore,
        ),
        const SizedBox(height: AppSpacing.sm),
        AppCard(
          radius: AppRadius.card,
          color: AppColors.glass85,
          child: events.isEmpty
              ? Text(
                  'Chưa có hoạt động nào trong chuyến đi.',
                  style: AppTypography.body,
                )
              : Column(
                  children: [
                    for (var i = 0; i < events.length; i++)
                      _TimelineRow(
                        event: events[i],
                        now: now,
                        isLast: i == events.length - 1,
                      ),
                  ],
                ),
        ),
      ],
    );
  }
}

class _TimelineRow extends StatelessWidget {
  const _TimelineRow({
    required this.event,
    required this.now,
    required this.isLast,
  });

  final TripDetailTimelineEvent event;
  final DateTime now;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final style = _EventStyle.of(event.type);
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: style.background,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.surface, width: 2),
                ),
                child: Icon(style.icon, size: 15, color: style.foreground),
              ),
              if (!isLast)
                const Expanded(
                  child: VerticalDivider(
                    width: 2,
                    thickness: 2,
                    color: AppColors.primary15,
                  ),
                ),
            ],
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                top: 3,
                bottom: isLast ? 0 : AppSpacing.md,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      AppAvatar(
                        size: 18,
                        imageUrl: event.actorAvatarUrl,
                        initials: initialsOf(event.actorName),
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: event.actorName,
                                style: AppTypography.caption.copyWith(
                                  color: AppColors.textPrimary,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              TextSpan(
                                text: ' ${event.type.verb}',
                                style: AppTypography.caption.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.xxs),
                      Text(
                        formatTimelineTime(event.createdAt, now: now),
                        style: AppTypography.caption,
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    event.content,
                    style: AppTypography.caption.copyWith(
                      color: style.contentColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _EventStyle {
  const _EventStyle({
    required this.icon,
    required this.background,
    required this.foreground,
    this.contentColor = AppColors.textSecondary,
  });

  final IconData icon;
  final Color background;
  final Color foreground;
  final Color contentColor;

  static _EventStyle of(TripDetailEventType type) => switch (type) {
    TripDetailEventType.activityCheckin => const _EventStyle(
      icon: Icons.check_circle_outline_rounded,
      background: AppColors.primary,
      foreground: AppColors.textInverse,
      contentColor: AppColors.primaryActive,
    ),
    TripDetailEventType.expenseCreated ||
    TripDetailEventType.expenseSettled => const _EventStyle(
      icon: Icons.receipt_long_outlined,
      background: AppColors.primary15,
      foreground: AppColors.primaryActive,
      contentColor: AppColors.textPrimary,
    ),
    TripDetailEventType.memoryAdded ||
    TripDetailEventType.photoAdded => const _EventStyle(
      icon: Icons.photo_camera_outlined,
      background: AppColors.primaryLight,
      foreground: AppColors.primary,
    ),
    TripDetailEventType.memoryDeleted => const _EventStyle(
      icon: Icons.hide_image_outlined,
      background: AppColors.surfaceSubdued,
      foreground: AppColors.textSecondary,
      contentColor: AppColors.textTertiary,
    ),
    TripDetailEventType.memberJoined => const _EventStyle(
      icon: Icons.person_add_alt_1_outlined,
      background: AppColors.surfaceSubdued,
      foreground: AppColors.primaryActive,
      contentColor: AppColors.textTertiary,
    ),
    TripDetailEventType.memberLeft => const _EventStyle(
      icon: Icons.logout_rounded,
      background: AppColors.surfaceSubdued,
      foreground: AppColors.textSecondary,
      contentColor: AppColors.textTertiary,
    ),
    TripDetailEventType.memberKicked => const _EventStyle(
      icon: Icons.person_remove_outlined,
      background: AppColors.surfaceSubdued,
      foreground: AppColors.danger,
      contentColor: AppColors.textTertiary,
    ),
    TripDetailEventType.activityAdded => const _EventStyle(
      icon: Icons.add_location_alt_outlined,
      background: AppColors.primaryLight,
      foreground: AppColors.primary,
    ),
    TripDetailEventType.activityUpdated => const _EventStyle(
      icon: Icons.edit_location_alt_outlined,
      background: AppColors.primaryLight,
      foreground: AppColors.primary,
    ),
    TripDetailEventType.activityDeleted => const _EventStyle(
      icon: Icons.wrong_location_outlined,
      background: AppColors.surfaceSubdued,
      foreground: AppColors.textSecondary,
      contentColor: AppColors.textTertiary,
    ),
    TripDetailEventType.tripCreated => const _EventStyle(
      icon: Icons.flag_outlined,
      background: AppColors.primaryLight,
      foreground: AppColors.primary,
    ),
    TripDetailEventType.system => const _EventStyle(
      icon: Icons.info_outline_rounded,
      background: AppColors.surfaceSubdued,
      foreground: AppColors.textSecondary,
    ),
  };
}
