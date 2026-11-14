import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/widget/app_skeleton.dart';

class TripTimelineSkeleton extends StatelessWidget {
  const TripTimelineSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Đang tải dòng thời gian',
      child: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth - AppSpacing.screenHorizontal * 2;
          final chipWidth = (width - AppSpacing.xs * 2) / 3;
          return ListView(
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(AppSpacing.screenHorizontal),
            children: [
              AppSkeleton(width: width, height: 128, radius: AppRadius.card),
              const SizedBox(height: AppSpacing.md),
              Row(
                children: [
                  for (var i = 0; i < 3; i++) ...[
                    if (i > 0) const SizedBox(width: AppSpacing.xs),
                    AppSkeleton(
                      width: chipWidth,
                      height: 36,
                      radius: AppRadius.pill,
                    ),
                  ],
                ],
              ),
              const SizedBox(height: AppSpacing.section),
              const TripTimelineEventsSkeleton(),
            ],
          );
        },
      ),
    );
  }
}

/// Placeholder for the day sections, e.g. while another filter loads.
class TripTimelineEventsSkeleton extends StatelessWidget {
  const TripTimelineEventsSkeleton({super.key, this.rows = 4});

  final int rows;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final cardWidth = constraints.maxWidth - AppSpacing.xl - AppSpacing.xs;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AppSkeleton(width: 160, height: 22),
            const SizedBox(height: AppSpacing.md),
            for (var i = 0; i < rows; i++) ...[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AppSkeleton(
                    width: AppSpacing.xl,
                    height: AppSpacing.xl,
                    radius: AppRadius.pill,
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  AppSkeleton(
                    width: cardWidth,
                    height: 96,
                    radius: AppRadius.card,
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
            ],
          ],
        );
      },
    );
  }
}
