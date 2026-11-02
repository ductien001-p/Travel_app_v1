import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_sizes.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_badge.dart';
import 'package:travel_frontend_v1/core/widget/app_glass_surface.dart';
import 'package:travel_frontend_v1/core/widget/app_icon_button.dart';

class TripJoinRequestsTopBar extends StatelessWidget {
  const TripJoinRequestsTopBar({
    super.key,
    required this.onBack,
    this.reviewerLabel,
    this.pendingCount,
  });

  final VoidCallback onBack;
  final String? reviewerLabel;

  /// Requests waiting for review; the badge is hidden when there are none.
  final int? pendingCount;

  /// Keeps the title readable at large text sizes.
  static const _badgeMaxWidth = 88.0;

  @override
  Widget build(BuildContext context) {
    final pending = pendingCount ?? 0;
    return AppGlassSurface(
      radius: 0,
      color: AppColors.glass85,
      shadows: const [],
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.screenHorizontal,
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: AppSizes.topBarMaxHeight),
        child: Row(
          children: [
            AppIconButton(
              icon: Icons.arrow_back_rounded,
              iconColor: AppColors.primaryActive,
              onPressed: onBack,
              semanticLabel: 'Quay lại',
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Yêu Cầu Tham Gia',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.cardTitle.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  if (reviewerLabel != null)
                    Text(
                      reviewerLabel!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.caption.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                ],
              ),
            ),
            if (pending > 0) ...[
              const SizedBox(width: AppSpacing.xs),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: _badgeMaxWidth),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: AppBadge(label: '$pending mới'),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
