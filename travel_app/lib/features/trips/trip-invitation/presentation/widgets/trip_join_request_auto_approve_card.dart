import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_glass_surface.dart';

/// Preference that lets the owner's friends join without review.
class TripJoinRequestAutoApproveCard extends StatelessWidget {
  const TripJoinRequestAutoApproveCard({
    super.key,
    required this.value,
    required this.onChanged,
    this.errorMessage,
    this.onRetry,
  });

  /// Null while the preference is loading or could not be loaded.
  final bool? value;
  final ValueChanged<bool>? onChanged;

  /// Shown instead of the description when loading failed.
  final String? errorMessage;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final error = errorMessage;
    return AppGlassSurface(
      radius: AppRadius.card,
      padding: const EdgeInsets.all(AppSpacing.cardCompact),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primaryLight,
            ),
            alignment: Alignment.center,
            child: const Icon(
              Icons.bolt_rounded,
              size: 20,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Tự động duyệt bạn bè', style: AppTypography.cardTitle),
                if (error == null)
                  Text(
                    'Chấp nhận ngay những người là bạn bè của bạn',
                    style: AppTypography.caption,
                  )
                else
                  Text(
                    error,
                    style: AppTypography.caption.copyWith(
                      color: AppColors.danger,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.xs),
          if (error != null && onRetry != null)
            TextButton(onPressed: onRetry, child: const Text('Thử lại'))
          else
            Switch(
              value: value ?? false,
              onChanged: value == null ? null : onChanged,
              activeTrackColor: AppColors.primary,
              activeThumbColor: AppColors.surface,
              inactiveTrackColor: AppColors.surfaceSubdued,
              inactiveThumbColor: AppColors.surface,
              trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
            ),
        ],
      ),
    );
  }
}
