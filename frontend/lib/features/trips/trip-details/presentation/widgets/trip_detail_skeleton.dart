import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/widget/app_skeleton.dart';

class TripDetailSkeleton extends StatelessWidget {
  const TripDetailSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Đang tải chi tiết chuyến đi',
      child: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth - AppSpacing.screenHorizontal * 2;
          final metricWidth = (width - AppSpacing.xs * 2) / 3;
          return ListView(
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(AppSpacing.screenHorizontal),
            children: [
              AppSkeleton(width: width, height: 320, radius: AppRadius.card),
              const SizedBox(height: AppSpacing.section),
              Row(
                children: [
                  for (var i = 0; i < 3; i++) ...[
                    if (i > 0) const SizedBox(width: AppSpacing.xs),
                    AppSkeleton(
                      width: metricWidth,
                      height: 112,
                      radius: AppRadius.card,
                    ),
                  ],
                ],
              ),
              const SizedBox(height: AppSpacing.section),
              const AppSkeleton(width: 160, height: 22),
              const SizedBox(height: AppSpacing.sm),
              for (var i = 0; i < 3; i++) ...[
                AppSkeleton(width: width, height: 72, radius: AppRadius.card),
                const SizedBox(height: AppSpacing.xs),
              ],
            ],
          );
        },
      ),
    );
  }
}
