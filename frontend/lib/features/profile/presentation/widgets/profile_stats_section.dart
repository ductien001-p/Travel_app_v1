import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_glass_surface.dart';

import '../profile_count_format.dart';

class ProfileStatsSection extends StatelessWidget {
  const ProfileStatsSection({
    super.key,
    required this.destinationCount,
    required this.tripCount,
    required this.followerCount,
    required this.followingCount,
  });

  final num destinationCount;
  final int tripCount;
  final int followerCount;
  final int followingCount;

  @override
  Widget build(BuildContext context) => AppGlassSurface(
    radius: AppRadius.card,
    padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
    child: Row(
      children: [
        _Stat(value: formatProfileCount(destinationCount), label: 'Điểm đến'),
        const _Divider(),
        _Stat(
          value: formatProfileCount(tripCount),
          label: 'Chuyến đi',
          accent: true,
        ),
        const _Divider(),
        _Stat(
          value: formatProfileCount(followerCount),
          label: 'Người theo dõi',
        ),
        const _Divider(),
        _Stat(value: formatProfileCount(followingCount), label: 'Đang dõi'),
      ],
    ),
  );
}

class _Stat extends StatelessWidget {
  const _Stat({required this.value, required this.label, this.accent = false});

  final String value;
  final String label;
  final bool accent;

  @override
  Widget build(BuildContext context) => Expanded(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          value,
          maxLines: 1,
          style: AppTypography.sectionTitle.copyWith(
            color: accent ? AppColors.primary : AppColors.textPrimary,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          maxLines: 2,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: AppTypography.caption.copyWith(fontSize: 11),
        ),
      ],
    ),
  );
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) => const SizedBox(
    height: 44,
    child: VerticalDivider(width: 1, color: AppColors.borderNeutral),
  );
}
