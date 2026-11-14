import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_avatar.dart';
import 'package:travel_frontend_v1/core/widget/app_badge.dart';
import 'package:travel_frontend_v1/core/widget/app_card.dart';

import '../../../trip-details/utils/trip_detail_formatters.dart';
import '../../data/models/trip_timeline_models.dart';
import '../../utils/trip_timeline_formatters.dart';
import 'trip_timeline_event_attachments.dart';
import 'trip_timeline_event_style.dart';

class TripTimelineEventCard extends StatelessWidget {
  const TripTimelineEventCard({
    super.key,
    required this.entry,
    required this.time,
    required this.style,
    this.onMore,
    this.onOpenAlbum,
  });

  final TripTimelineEntry entry;

  /// `entry.createdAt` on the user's wall clock.
  final DateTime time;
  final TripTimelineEventStyle style;

  /// Opens the "…" menu; hidden when null.
  final VoidCallback? onMore;

  /// Opens the trip album from the photos of a memory event.
  final VoidCallback? onOpenAlbum;

  bool get _isTripStart => entry.type == TripTimelineEntryType.tripCreated;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      radius: AppRadius.card,
      padding: const EdgeInsets.all(AppSpacing.sm),
      color: _isTripStart ? AppColors.primaryLight : AppColors.glass90,
      borderColor: _isTripStart ? AppColors.primary20 : AppColors.glassBorder,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _CardHeader(entry: entry, time: time, style: style, onMore: onMore),
          const SizedBox(height: AppSpacing.xs),
          if (_isTripStart)
            _TripStartBody(entry: entry)
          else if (entry.type == TripTimelineEntryType.memberJoined)
            _MemberJoinedBody(entry: entry)
          else
            _EventSentence(entry: entry),
          TripTimelineEventAttachment(entry: entry, onOpenAlbum: onOpenAlbum),
        ],
      ),
    );
  }
}

class _CardHeader extends StatelessWidget {
  const _CardHeader({
    required this.entry,
    required this.time,
    required this.style,
    this.onMore,
  });

  static const _trailingMaxFraction = 0.45;
  static const _moreButtonSize = 32.0;

  final TripTimelineEntry entry;
  final DateTime time;
  final TripTimelineEventStyle style;
  final VoidCallback? onMore;

  @override
  Widget build(BuildContext context) {
    final trailing = _trailing();
    return LayoutBuilder(
      builder: (context, constraints) => Row(
        children: [
          Expanded(
            child: Wrap(
              spacing: AppSpacing.xs,
              runSpacing: AppSpacing.xxs,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: AppBadge(
                    label: entry.type.badge,
                    tone: style.badgeTone,
                  ),
                ),
                Text(formatTimelineClock(time), style: AppTypography.caption),
              ],
            ),
          ),
          if (trailing != null) ...[
            const SizedBox(width: AppSpacing.xs),
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: constraints.maxWidth * _trailingMaxFraction,
              ),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerRight,
                child: trailing,
              ),
            ),
          ],
          if (onMore != null)
            IconButton(
              onPressed: onMore,
              tooltip: 'Tùy chọn sự kiện',
              icon: const Icon(Icons.more_horiz_rounded),
              iconSize: 18,
              color: AppColors.textTertiary,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints.tightFor(
                width: _moreButtonSize,
                height: _moreButtonSize,
              ),
            ),
        ],
      ),
    );
  }

  Widget? _trailing() {
    final meta = entry.metadata;
    if (meta == null) return null;
    final amount = meta.amount;
    if (amount != null &&
        (entry.type == TripTimelineEntryType.expenseCreated ||
            entry.type == TripTimelineEntryType.expenseSettled)) {
      return Text(
        formatTripMoney(amount, currency: meta.currency),
        style: AppTypography.cardTitle.copyWith(
          fontWeight: FontWeight.w700,
          color: entry.type == TripTimelineEntryType.expenseSettled
              ? AppColors.success
              : AppColors.primaryActive,
        ),
      );
    }
    if (entry.type != TripTimelineEntryType.activityCheckin) return null;
    final points = meta.pointsEarned ?? 0;
    if (points > 0) {
      return AppBadge(label: '+$points điểm', icon: Icons.bolt_rounded);
    }
    if (meta.verified) {
      return const AppBadge(
        label: 'Đã xác thực',
        tone: AppBadgeTone.success,
        icon: Icons.verified_outlined,
      );
    }
    return null;
  }
}

class _EventSentence extends StatelessWidget {
  const _EventSentence({required this.entry});

  final TripTimelineEntry entry;

  @override
  Widget build(BuildContext context) {
    final base = AppTypography.body.copyWith(color: AppColors.textPrimary);
    return Text.rich(
      TextSpan(
        style: base,
        children: [
          for (final part in timelineSentence(entry))
            TextSpan(text: part.text, style: _styleOf(part.tone, base)),
        ],
      ),
    );
  }

  static TextStyle? _styleOf(TimelineTextTone tone, TextStyle base) =>
      switch (tone) {
        TimelineTextTone.plain => null,
        TimelineTextTone.actor ||
        TimelineTextTone.strong => base.copyWith(fontWeight: FontWeight.w700),
        TimelineTextTone.title => base.copyWith(fontWeight: FontWeight.w600),
        TimelineTextTone.place => base.copyWith(
          color: AppColors.primaryActive,
          fontWeight: FontWeight.w600,
        ),
      };
}

class _MemberJoinedBody extends StatelessWidget {
  const _MemberJoinedBody({required this.entry});

  final TripTimelineEntry entry;

  @override
  Widget build(BuildContext context) {
    final user = entry.member.user;
    final joinLabel = timelineJoinLabel(entry.metadata?.via);
    return Row(
      children: [
        AppAvatar(
          size: 44,
          imageUrl: user.avatarUrl,
          initials: initialsOf(user.name),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _EventSentence(entry: entry),
              if (joinLabel != null)
                Text(
                  joinLabel,
                  style: AppTypography.caption.copyWith(
                    color: AppColors.primaryActive,
                    fontWeight: FontWeight.w600,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class _TripStartBody extends StatelessWidget {
  const _TripStartBody({required this.entry});

  final TripTimelineEntry entry;

  @override
  Widget build(BuildContext context) {
    final tripName = entry.metadata?.tripName?.trim();
    final title = tripName == null || tripName.isEmpty
        ? entry.content
        : 'Khởi hành hành trình "$tripName"';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTypography.cardTitle.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: AppSpacing.xxs),
        Text.rich(
          TextSpan(
            text: 'Tạo bởi ',
            children: [
              TextSpan(
                text: entry.member.user.name,
                style: AppTypography.caption.copyWith(
                  color: AppColors.primaryActive,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          style: AppTypography.caption.copyWith(color: AppColors.textSecondary),
        ),
      ],
    );
  }
}
