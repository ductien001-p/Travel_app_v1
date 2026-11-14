import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_sizes.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_glass_surface.dart';
import 'package:travel_frontend_v1/core/widget/app_icon_button.dart';

class TripMemoriesTopBar extends StatelessWidget {
  const TripMemoriesTopBar({
    super.key,
    required this.onBack,
    this.tripName,
    this.countLabel,
    this.onAdd,
  });

  final VoidCallback onBack;
  final String? tripName;
  final String? countLabel;

  /// Posts new photos; hidden when the viewer cannot post.
  final VoidCallback? onAdd;

  @override
  Widget build(BuildContext context) {
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
                    'Kỷ Niệm Chuyến Đi',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.cardTitle,
                  ),
                  if (tripName != null || countLabel != null)
                    _Subtitle(tripName: tripName, countLabel: countLabel),
                ],
              ),
            ),
            if (onAdd != null) ...[
              const SizedBox(width: AppSpacing.xs),
              AppIconButton(
                icon: Icons.add_rounded,
                iconColor: AppColors.textInverse,
                backgroundColor: AppColors.primary,
                onPressed: onAdd,
                semanticLabel: 'Thêm ảnh kỷ niệm',
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _Subtitle extends StatelessWidget {
  const _Subtitle({this.tripName, this.countLabel});

  final String? tripName;
  final String? countLabel;

  @override
  Widget build(BuildContext context) {
    final style = AppTypography.caption.copyWith(
      color: AppColors.textSecondary,
    );
    return Text.rich(
      TextSpan(
        children: [
          if (tripName != null) TextSpan(text: tripName),
          if (tripName != null && countLabel != null)
            const TextSpan(text: ' • '),
          if (countLabel != null)
            TextSpan(
              text: countLabel,
              style: style.copyWith(
                color: AppColors.primaryActive,
                fontWeight: FontWeight.w600,
              ),
            ),
        ],
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: style,
    );
  }
}
