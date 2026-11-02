import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_badge.dart';
import 'package:travel_frontend_v1/core/widget/app_glass_surface.dart';
import 'package:travel_frontend_v1/core/widget/app_icon_button.dart';

class DestinationTripsTopBar extends StatelessWidget {
  const DestinationTripsTopBar({
    super.key,
    required this.title,
    required this.onBack,
    required this.onSearch,
    required this.onTune,
    this.regionLabel,
    this.openTripCount,
  });

  final String title;
  final VoidCallback onBack;
  final VoidCallback onSearch;
  final VoidCallback onTune;
  final String? regionLabel;
  final int? openTripCount;

  @override
  Widget build(BuildContext context) {
    final region = regionLabel?.trim();
    return AppGlassSurface(
      radius: 0,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
      shadows: const [],
      child: SizedBox(
        height: 64,
        child: Row(
          children: [
            AppIconButton(
              icon: Icons.arrow_back_rounded,
              onPressed: onBack,
              semanticLabel: 'Quay lại',
              iconColor: AppColors.textPrimary,
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTypography.screenTitle,
                        ),
                      ),
                      if (region != null && region.isNotEmpty) ...[
                        const SizedBox(width: 6),
                        Text('- $region', style: AppTypography.caption),
                      ],
                    ],
                  ),
                  if (openTripCount != null) ...[
                    const SizedBox(height: 2),
                    AppBadge(label: '$openTripCount chuyến đi mở'),
                  ],
                ],
              ),
            ),
            AppIconButton(
              icon: Icons.search_rounded,
              onPressed: onSearch,
              semanticLabel: 'Tìm kiếm',
              iconColor: AppColors.textPrimary,
            ),
            const SizedBox(width: 6),
            AppIconButton(
              icon: Icons.tune_rounded,
              onPressed: onTune,
              semanticLabel: 'Bộ lọc nâng cao',
              iconColor: AppColors.textPrimary,
            ),
          ],
        ),
      ),
    );
  }
}
