import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_bottom_sheet.dart';

import '../../data/models/trip_timeline_models.dart';
import '../../utils/trip_timeline_formatters.dart';

enum TripTimelineEntryAction { viewDetail }

Future<TripTimelineEntryAction?> showTripTimelineEntryMenu(
  BuildContext context,
  TripTimelineEntry entry,
) {
  return showAppBottomSheet<TripTimelineEntryAction>(
    context: context,
    child: Material(
      type: MaterialType.transparency,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(entry.type.badge, style: AppTypography.cardTitle),
          const SizedBox(height: AppSpacing.xs),
          Builder(
            builder: (context) => ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(
                Icons.open_in_new_rounded,
                color: AppColors.textPrimary,
              ),
              title: Text('Xem chi tiết', style: AppTypography.bodyMedium),
              onTap: () =>
                  Navigator.of(context).pop(TripTimelineEntryAction.viewDetail),
            ),
          ),
        ],
      ),
    ),
  );
}
