import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/widget/app_badge.dart';

import '../../data/models/trip_timeline_models.dart';

enum TripTimelineDotStyle { brand, muted, success, highlight }

class TripTimelineEventStyle {
  const TripTimelineEventStyle({
    required this.icon,
    required this.badgeTone,
    this.dot = TripTimelineDotStyle.brand,
  });

  final IconData icon;
  final AppBadgeTone badgeTone;
  final TripTimelineDotStyle dot;

  static TripTimelineEventStyle of(TripTimelineEntry entry) =>
      switch (entry.type) {
        TripTimelineEntryType.tripCreated => const TripTimelineEventStyle(
          icon: Icons.flag_rounded,
          badgeTone: AppBadgeTone.brand,
          dot: TripTimelineDotStyle.highlight,
        ),
        TripTimelineEntryType.memberJoined => const TripTimelineEventStyle(
          icon: Icons.person_add_alt_1_outlined,
          badgeTone: AppBadgeTone.info,
        ),
        TripTimelineEntryType.memberLeft => const TripTimelineEventStyle(
          icon: Icons.logout_rounded,
          badgeTone: AppBadgeTone.neutral,
          dot: TripTimelineDotStyle.muted,
        ),
        TripTimelineEntryType.memberKicked => const TripTimelineEventStyle(
          icon: Icons.person_remove_outlined,
          badgeTone: AppBadgeTone.danger,
          dot: TripTimelineDotStyle.muted,
        ),
        TripTimelineEntryType.activityAdded => const TripTimelineEventStyle(
          icon: Icons.add_location_alt_outlined,
          badgeTone: AppBadgeTone.brand,
        ),
        TripTimelineEntryType.activityUpdated => const TripTimelineEventStyle(
          icon: Icons.update_rounded,
          badgeTone: AppBadgeTone.neutral,
          dot: TripTimelineDotStyle.muted,
        ),
        TripTimelineEntryType.activityDeleted => const TripTimelineEventStyle(
          icon: Icons.wrong_location_outlined,
          badgeTone: AppBadgeTone.neutral,
          dot: TripTimelineDotStyle.muted,
        ),
        TripTimelineEntryType.activityCheckin => TripTimelineEventStyle(
          icon: (entry.metadata?.pointsEarned ?? 0) > 0
              ? Icons.military_tech_outlined
              : Icons.pin_drop_outlined,
          badgeTone: AppBadgeTone.brand,
        ),
        TripTimelineEntryType.expenseCreated => const TripTimelineEventStyle(
          icon: Icons.receipt_long_outlined,
          badgeTone: AppBadgeTone.brand,
        ),
        TripTimelineEntryType.expenseSettled => const TripTimelineEventStyle(
          icon: Icons.check_rounded,
          badgeTone: AppBadgeTone.success,
          dot: TripTimelineDotStyle.success,
        ),
        TripTimelineEntryType.photoAdded ||
        TripTimelineEntryType.memoryAdded => const TripTimelineEventStyle(
          icon: Icons.photo_library_outlined,
          badgeTone: AppBadgeTone.brand,
        ),
        TripTimelineEntryType.memoryDeleted => const TripTimelineEventStyle(
          icon: Icons.hide_image_outlined,
          badgeTone: AppBadgeTone.neutral,
          dot: TripTimelineDotStyle.muted,
        ),
        TripTimelineEntryType.system => const TripTimelineEventStyle(
          icon: Icons.info_outline_rounded,
          badgeTone: AppBadgeTone.neutral,
          dot: TripTimelineDotStyle.muted,
        ),
      };
}

class TripTimelineDot extends StatelessWidget {
  const TripTimelineDot({super.key, required this.style, this.size = 24});

  final TripTimelineEventStyle style;
  final double size;

  @override
  Widget build(BuildContext context) {
    final (background, border, foreground) = switch (style.dot) {
      TripTimelineDotStyle.brand => (
        AppColors.surface,
        AppColors.primary,
        AppColors.primaryActive,
      ),
      TripTimelineDotStyle.muted => (
        AppColors.surface,
        AppColors.primary38,
        AppColors.textSecondary,
      ),
      TripTimelineDotStyle.success => (
        AppColors.success,
        AppColors.surface,
        AppColors.textInverse,
      ),
      TripTimelineDotStyle.highlight => (
        AppColors.primary,
        AppColors.primary,
        AppColors.textInverse,
      ),
    };
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: background,
        shape: BoxShape.circle,
        border: Border.all(color: border, width: 2),
      ),
      alignment: Alignment.center,
      child: Icon(style.icon, size: size * 0.54, color: foreground),
    );
  }
}
