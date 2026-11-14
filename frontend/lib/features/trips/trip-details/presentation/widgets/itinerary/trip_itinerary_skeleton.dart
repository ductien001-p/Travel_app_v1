import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/widget/app_skeleton.dart';

class TripItinerarySkeleton extends StatelessWidget {
  const TripItinerarySkeleton({super.key});

  static const _chipWidth = 72.0;
  static const _chipGap = 10.0;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Đang tải lịch trình',
      child: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth - AppSpacing.screenHorizontal * 2;
          final dayChips = ((width + _chipGap) / (_chipWidth + _chipGap))
              .floor()
              .clamp(1, 4);
          return ListView(
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(AppSpacing.screenHorizontal),
            children: [
              AppSkeleton(width: width, height: 48, radius: AppRadius.pill),
              const SizedBox(height: AppSpacing.lg),
              const AppSkeleton(width: 180, height: 22),
              const SizedBox(height: AppSpacing.sm),
              Row(
                children: [
                  for (var i = 0; i < dayChips; i++) ...[
                    if (i > 0) const SizedBox(width: _chipGap),
                    const AppSkeleton(
                      width: _chipWidth,
                      height: 84,
                      radius: AppRadius.card,
                    ),
                  ],
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              AppSkeleton(width: width, height: 140, radius: AppRadius.card),
              const SizedBox(height: AppSpacing.section),
              for (var i = 0; i < 3; i++) ...[
                AppSkeleton(width: width, height: 110, radius: AppRadius.card),
                const SizedBox(height: AppSpacing.md),
              ],
            ],
          );
        },
      ),
    );
  }
}
