import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';

class TripDetailSectionHeader extends StatelessWidget {
  const TripDetailSectionHeader({
    super.key,
    required this.title,
    this.leadingIcon,
    this.countLabel,
    this.countHighlighted = false,
    this.actionLabel,
    this.actionIcon,
    this.onAction,
    this.trailing,
  });

  final String title;
  final IconData? leadingIcon;
  final String? countLabel;
  final bool countHighlighted;
  final String? actionLabel;
  final IconData? actionIcon;
  final VoidCallback? onAction;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (leadingIcon != null) ...[
          Icon(leadingIcon, size: 20, color: AppColors.primary),
          const SizedBox(width: AppSpacing.xs),
        ],
        Expanded(
          child: Row(
            children: [
              Flexible(
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.sectionTitle,
                ),
              ),
              if (countLabel != null) ...[
                const SizedBox(width: AppSpacing.xs),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.xs,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: countHighlighted
                        ? AppColors.primaryLight
                        : AppColors.surfaceSubdued,
                    borderRadius: BorderRadius.circular(AppRadius.pill),
                  ),
                  child: Text(
                    countLabel!,
                    style: AppTypography.badge.copyWith(
                      color: countHighlighted
                          ? AppColors.primaryActive
                          : AppColors.textSecondary,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
        if (trailing != null)
          trailing!
        else if (actionLabel != null && onAction != null)
          TextButton(
            onPressed: onAction,
            style: TextButton.styleFrom(
              foregroundColor: AppColors.primary,
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
              minimumSize: const Size(0, 36),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  actionLabel!,
                  style: AppTypography.caption.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                if (actionIcon != null) ...[
                  const SizedBox(width: 2),
                  Icon(actionIcon, size: 14),
                ],
              ],
            ),
          ),
      ],
    );
  }
}
