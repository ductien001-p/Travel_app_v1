import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/widget/app_skeleton.dart';

class FindFriendsSkeleton extends StatelessWidget {
  const FindFriendsSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final width =
        MediaQuery.sizeOf(context).width - (AppSpacing.screenHorizontal * 2);
    return ListView(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.screenHorizontal,
        AppSpacing.sm,
        AppSpacing.screenHorizontal,
        AppSpacing.safeBottom,
      ),
      children: [
        AppSkeleton(width: width, height: 88, radius: 20),
        const SizedBox(height: AppSpacing.md),
        AppSkeleton(width: width, height: 140, radius: 24),
        const SizedBox(height: AppSpacing.md),
        const AppSkeleton(width: 180, height: 20, radius: 8),
        const SizedBox(height: AppSpacing.sm),
        AppSkeleton(width: width, height: 110, radius: 20),
        const SizedBox(height: AppSpacing.sm),
        AppSkeleton(width: width, height: 110, radius: 20),
        const SizedBox(height: AppSpacing.sm),
        AppSkeleton(width: width, height: 110, radius: 20),
        const SizedBox(height: AppSpacing.md),
        const AppSkeleton(width: 220, height: 20, radius: 8),
        const SizedBox(height: AppSpacing.sm),
        Row(
          children: [
            Expanded(
              child: AppSkeleton(width: width / 2 - 6, height: 180, radius: 20),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: AppSkeleton(width: width / 2 - 6, height: 180, radius: 20),
            ),
          ],
        ),
      ],
    );
  }
}
