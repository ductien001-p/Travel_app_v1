import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widget/app_card.dart';

class CreateTripHeader extends StatelessWidget {
  const CreateTripHeader({
    super.key,
    required this.step,
    required this.subtitle,
    required this.onBack,
    required this.onCancel,
  });

  final int step;
  final String subtitle;
  final VoidCallback onBack;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(
      AppSpacing.sm,
      AppSpacing.xs,
      AppSpacing.sm,
      AppSpacing.xs,
    ),
    child: Column(
      children: [
        Row(
          children: [
            IconButton(onPressed: onBack, icon: const Icon(Icons.arrow_back)),
            Expanded(
              child: Column(
                children: [
                  Text('Tạo hành trình mới', style: AppTypography.cardTitle),
                  Text(
                    'Bước $step trên 3: $subtitle',
                    style: AppTypography.caption.copyWith(
                      color: AppColors.primaryActive,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            TextButton(onPressed: onCancel, child: const Text('Hủy')),
          ],
        ),
        const SizedBox(height: AppSpacing.xs),
        ClipRRect(
          borderRadius: BorderRadius.circular(AppRadius.pill),
          child: LinearProgressIndicator(
            value: step / 3,
            minHeight: 5,
            color: AppColors.primary,
            backgroundColor: AppColors.surfaceSubdued,
          ),
        ),
      ],
    ),
  );
}

class CreateTripSection extends StatelessWidget {
  const CreateTripSection({
    super.key,
    required this.title,
    required this.icon,
    required this.child,
    this.subtitle,
    this.trailing,
  });

  final String title;
  final String? subtitle;
  final IconData icon;
  final Widget child;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) => AppCard(
    padding: const EdgeInsets.all(AppSpacing.md),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 34,
              height: 34,
              decoration: const BoxDecoration(
                color: AppColors.primaryLight,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 19, color: AppColors.primaryActive),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTypography.cardTitle),
                  if (subtitle != null)
                    Text(
                      subtitle!,
                      style: AppTypography.caption.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                ],
              ),
            ),
            ?trailing,
          ],
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: AppSpacing.sm),
          child: Divider(color: AppColors.borderBrandSoft),
        ),
        child,
      ],
    ),
  );
}

class CreateTripBottomBar extends StatelessWidget {
  const CreateTripBottomBar({
    super.key,
    required this.primaryLabel,
    required this.onPrimary,
    this.secondaryLabel,
    this.onSecondary,
    this.loading = false,
  });

  final String primaryLabel;
  final VoidCallback? onPrimary;
  final String? secondaryLabel;
  final VoidCallback? onSecondary;
  final bool loading;

  @override
  Widget build(BuildContext context) => SafeArea(
    top: false,
    child: DecoratedBox(
      decoration: const BoxDecoration(
        color: AppColors.glass90,
        boxShadow: [
          BoxShadow(
            color: AppColors.marine08,
            blurRadius: 24,
            offset: Offset(0, -6),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.sm),
        child: Row(
          children: [
            if (secondaryLabel != null) ...[
              OutlinedButton.icon(
                onPressed: loading ? null : onSecondary,
                icon: const Icon(Icons.bookmark_border_rounded),
                label: Text(secondaryLabel!),
              ),
              const SizedBox(width: AppSpacing.sm),
            ],
            Expanded(
              child: FilledButton(
                onPressed: loading ? null : onPrimary,
                style: FilledButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  backgroundColor: AppColors.primary,
                ),
                child: loading
                    ? const SizedBox.square(
                        dimension: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : Text(primaryLabel),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
