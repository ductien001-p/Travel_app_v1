import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/widget/app_skeleton.dart';

class TripMemoriesSkeleton extends StatelessWidget {
  const TripMemoriesSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Đang tải album kỷ niệm',
      child: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth - AppSpacing.screenHorizontal * 2;
          final chipWidth = (width - AppSpacing.xs * 2) / 3;
          return ListView(
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(AppSpacing.screenHorizontal),
            children: [
              AppSkeleton(width: width, height: 120, radius: AppRadius.card),
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
              const TripMemoriesGridSkeleton(),
            ],
          );
        },
      ),
    );
  }
}

/// Placeholder for the day sections, e.g. while another filter loads.
class TripMemoriesGridSkeleton extends StatelessWidget {
  const TripMemoriesGridSkeleton({super.key});

  static const _gap = AppSpacing.xs;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final cell = (width - _gap * 2) / 3;
        final hero = cell * 2 + _gap;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AppSkeleton(width: 200, height: 22),
            const SizedBox(height: AppSpacing.sm),
            Row(
              children: [
                AppSkeleton(width: hero, height: hero),
                const SizedBox(width: _gap),
                Column(
                  children: [
                    AppSkeleton(width: cell, height: cell),
                    const SizedBox(height: _gap),
                    AppSkeleton(width: cell, height: cell),
                  ],
                ),
              ],
            ),
            const SizedBox(height: _gap),
            Row(
              children: [
                for (var i = 0; i < 3; i++) ...[
                  if (i > 0) const SizedBox(width: _gap),
                  AppSkeleton(width: cell, height: cell),
                ],
              ],
            ),
          ],
        );
      },
    );
  }
}
