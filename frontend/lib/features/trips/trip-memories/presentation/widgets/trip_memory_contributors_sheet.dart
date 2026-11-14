import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_sizes.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_avatar.dart';
import 'package:travel_frontend_v1/core/widget/app_bottom_sheet.dart';
import 'package:travel_frontend_v1/core/widget/app_pressable.dart';

import '../../../trip-details/utils/trip_detail_formatters.dart';
import '../../application/trip_memories_view.dart';

/// Lists who posted photos; returns the user id picked to filter by.
Future<String?> showTripMemoryContributorsSheet(
  BuildContext context, {
  required List<TripMemoryContributor> contributors,
}) => showAppBottomSheet<String>(
  context: context,
  child: Flexible(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Thành viên đóng góp', style: AppTypography.sectionTitle),
        const SizedBox(height: AppSpacing.xxs),
        Text(
          'Chọn một thành viên để xem ảnh của họ.',
          style: AppTypography.caption.copyWith(color: AppColors.textSecondary),
        ),
        const SizedBox(height: AppSpacing.sm),
        Flexible(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: contributors.length,
            itemBuilder: (context, index) =>
                _ContributorRow(contributor: contributors[index]),
          ),
        ),
      ],
    ),
  ),
);

class _ContributorRow extends StatelessWidget {
  const _ContributorRow({required this.contributor});

  final TripMemoryContributor contributor;

  @override
  Widget build(BuildContext context) {
    return AppPressable(
      onTap: () => Navigator.of(context).pop(contributor.userId),
      borderRadius: BorderRadius.circular(AppRadius.input),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
        child: Row(
          children: [
            AppAvatar(
              size: AppSizes.avatarMd,
              imageUrl: contributor.avatarUrl,
              initials: initialsOf(contributor.name),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Text(
                contributor.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.cardTitle,
              ),
            ),
            Text(
              '${contributor.memoryCount} ảnh',
              style: AppTypography.caption.copyWith(
                color: AppColors.primaryActive,
                fontWeight: FontWeight.w700,
              ),
            ),
            const Icon(
              Icons.chevron_right_rounded,
              color: AppColors.textTertiary,
            ),
          ],
        ),
      ),
    );
  }
}
