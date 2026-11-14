import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';

class AuthFormError extends StatelessWidget {
  const AuthFormError({super.key, required this.error});

  final Object error;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      liveRegion: true,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: AppColors.danger.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(AppRadius.input),
          border: Border.all(color: AppColors.danger.withValues(alpha: 0.20)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.error_outline_rounded, color: AppColors.danger),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Text(
                error.toString(),
                style: AppTypography.body.copyWith(color: AppColors.danger),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
