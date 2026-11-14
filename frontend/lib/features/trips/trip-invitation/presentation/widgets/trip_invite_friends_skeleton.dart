import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/widget/app_skeleton.dart';

class TripInviteFriendsSkeleton extends StatelessWidget {
  const TripInviteFriendsSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Đang tải danh sách bạn bè',
      child: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth - AppSpacing.screenHorizontal * 2;
          return ListView(
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(AppSpacing.screenHorizontal),
            children: [
              AppSkeleton(width: width, height: 48, radius: AppRadius.pill),
              const SizedBox(height: AppSpacing.sm),
              const AppSkeleton(width: 280, height: 36, radius: AppRadius.pill),
              const SizedBox(height: AppSpacing.lg),
              for (var i = 0; i < 4; i++) ...[
                AppSkeleton(width: width, height: 76, radius: AppRadius.card),
                const SizedBox(height: AppSpacing.sm),
              ],
            ],
          );
        },
      ),
    );
  }
}
