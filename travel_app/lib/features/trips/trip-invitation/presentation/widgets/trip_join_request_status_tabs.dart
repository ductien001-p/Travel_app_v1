import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/widget/app_chip.dart';

import '../../data/models/trip_join_request_models.dart';
import '../../utils/trip_join_request_formatters.dart';

class TripJoinRequestStatusTabs extends StatelessWidget {
  const TripJoinRequestStatusTabs({
    super.key,
    required this.selected,
    required this.onSelect,
    this.counts,
  });

  final TripJoinRequestStatus selected;
  final ValueChanged<TripJoinRequestStatus> onSelect;

  /// Unknown until the first page arrives.
  final TripJoinRequestCounts? counts;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.screenHorizontal,
      ),
      child: Row(
        children: [
          for (final status in TripJoinRequestStatus.values) ...[
            if (status != TripJoinRequestStatus.values.first)
              const SizedBox(width: AppSpacing.xs),
            AppChip(
              label: joinRequestTabLabel(status, counts?.of(status)),
              selected: status == selected,
              onTap: () => onSelect(status),
            ),
          ],
        ],
      ),
    );
  }
}
