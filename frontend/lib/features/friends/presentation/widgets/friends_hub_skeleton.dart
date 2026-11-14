import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/widget/app_skeleton.dart';

class FriendsHubSkeleton extends StatelessWidget {
  const FriendsHubSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final width =
        MediaQuery.sizeOf(context).width - (AppSpacing.screenHorizontal * 2);
    return ListView(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.screenHorizontal,
        AppSpacing.sm,
        AppSpacing.screenHorizontal,
        AppSpacing.xl,
      ),
      children: [
        AppSkeleton(width: width, height: 44, radius: 999),
        const SizedBox(height: AppSpacing.md),
        AppSkeleton(width: width, height: 48, radius: 999),
        const SizedBox(height: AppSpacing.lg),
        const AppSkeleton(width: 160, height: 24, radius: 8),
        const SizedBox(height: AppSpacing.sm),
        AppSkeleton(width: width, height: 140, radius: 20),
        const SizedBox(height: AppSpacing.sm),
        AppSkeleton(width: width, height: 140, radius: 20),
        const SizedBox(height: AppSpacing.lg),
        AppSkeleton(width: width, height: 64, radius: 20),
        const SizedBox(height: AppSpacing.lg),
        AppSkeleton(width: width, height: 80, radius: 20),
        const SizedBox(height: AppSpacing.sm),
        AppSkeleton(width: width, height: 80, radius: 20),
        const SizedBox(height: AppSpacing.sm),
        AppSkeleton(width: width, height: 80, radius: 20),
      ],
    );
  }
}
