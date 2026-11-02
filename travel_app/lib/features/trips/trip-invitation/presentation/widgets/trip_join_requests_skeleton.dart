import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/widget/app_skeleton.dart';

/// Placeholder of the whole screen while the trip loads.
class TripJoinRequestsSkeleton extends StatelessWidget {
  const TripJoinRequestsSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Đang tải yêu cầu tham gia',
      child: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth - AppSpacing.screenHorizontal * 2;
          return ListView(
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(AppSpacing.screenHorizontal),
            children: [
              AppSkeleton(
                width: width,
                height: 220,
                radius: AppRadius.cardLarge,
              ),
              const SizedBox(height: AppSpacing.lg),
              const AppSkeleton(width: 220, height: 36, radius: AppRadius.pill),
              const SizedBox(height: AppSpacing.lg),
              const TripJoinRequestCardsSkeleton(),
            ],
          );
        },
      ),
    );
  }
}

/// Placeholder of the request cards, e.g. while another tab loads.
class TripJoinRequestCardsSkeleton extends StatelessWidget {
  const TripJoinRequestCardsSkeleton({super.key, this.count = 2});

  final int count;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Column(
        children: [
          for (var i = 0; i < count; i++) ...[
            if (i > 0) const SizedBox(height: AppSpacing.md),
            AppSkeleton(
              width: constraints.maxWidth,
              height: 200,
              radius: AppRadius.card,
            ),
          ],
        ],
      ),
    );
  }
}
