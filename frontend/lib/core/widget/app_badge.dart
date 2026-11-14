import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_radius.dart';
import '../theme/app_typography.dart';

enum AppBadgeTone { brand, success, warning, info, danger, neutral }

class AppBadge extends StatelessWidget {
  const AppBadge({
    super.key,
    required this.label,
    this.tone = AppBadgeTone.brand,
    this.icon,
  });

  final String label;
  final AppBadgeTone tone;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final (background, foreground) = switch (tone) {
      AppBadgeTone.brand => (AppColors.primaryLight, AppColors.primaryActive),
      AppBadgeTone.success => (
        const Color.fromRGBO(16, 185, 129, 0.12),
        AppColors.success,
      ),
      AppBadgeTone.warning => (
        const Color.fromRGBO(245, 158, 11, 0.12),
        AppColors.warning,
      ),
      AppBadgeTone.info => (
        const Color.fromRGBO(59, 130, 246, 0.12),
        AppColors.info,
      ),
      AppBadgeTone.danger => (
        const Color.fromRGBO(239, 68, 68, 0.12),
        AppColors.danger,
      ),
      AppBadgeTone.neutral => (
        AppColors.surfaceSubdued,
        AppColors.textSecondary,
      ),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 14, color: foreground),
            const SizedBox(width: 4),
          ],
          Text(label, style: AppTypography.badge.copyWith(color: foreground)),
        ],
      ),
    );
  }
}
