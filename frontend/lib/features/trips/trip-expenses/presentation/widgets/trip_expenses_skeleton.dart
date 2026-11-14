import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/widget/app_skeleton.dart';

class TripExpensesSkeleton extends StatelessWidget {
  const TripExpensesSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Đang tải chi tiêu nhóm',
      child: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth - AppSpacing.screenHorizontal * 2;
          return ListView(
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.screenHorizontal,
              0,
              AppSpacing.screenHorizontal,
              AppSpacing.safeBottom,
            ),
            children: [
              AppSkeleton(width: width, height: 260, radius: AppRadius.hero),
              const SizedBox(height: AppSpacing.md),
              AppSkeleton(
                width: width,
                height: 160,
                radius: AppRadius.cardLarge,
              ),
              const SizedBox(height: AppSpacing.md),
              AppSkeleton(
                width: width,
                height: 140,
                radius: AppRadius.cardLarge,
              ),
              const SizedBox(height: AppSpacing.md),
              AppSkeleton(width: width, height: 40, radius: AppRadius.pill),
              const SizedBox(height: AppSpacing.sm),
              AppSkeleton(width: width, height: 36, radius: AppRadius.pill),
              const SizedBox(height: AppSpacing.md),
              AppSkeleton(width: width, height: 110, radius: 22),
              const SizedBox(height: AppSpacing.sm),
              AppSkeleton(width: width, height: 110, radius: 22),
            ],
          );
        },
      ),
    );
  }
}
