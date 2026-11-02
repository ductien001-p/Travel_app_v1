import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_shadows.dart';
import 'package:travel_frontend_v1/core/theme/app_sizes.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_avatar.dart';
import 'package:travel_frontend_v1/core/widget/app_card.dart';
import 'package:travel_frontend_v1/core/widget/app_pressable.dart';

import '../../../trip-details/utils/trip_detail_formatters.dart';
import '../../application/trip_memories_view.dart';

/// "Kho Kỷ Niệm Chung": album total and the members who posted photos.
class TripMemoriesOverviewCard extends StatelessWidget {
  const TripMemoriesOverviewCard({
    super.key,
    required this.contributors,
    this.totalCount,
    this.onShowContributors,
  });

  final List<TripMemoryContributor> contributors;
  final int? totalCount;
  final VoidCallback? onShowContributors;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      radius: AppRadius.card,
      color: AppColors.glass85,
      borderColor: AppColors.glassBorder,
      shadows: AppShadows.level2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: AppSizes.avatarMd,
                height: AppSizes.avatarMd,
                decoration: const BoxDecoration(
                  color: AppColors.primaryLight,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.photo_library_outlined,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Kho Kỷ Niệm Chung', style: AppTypography.cardTitle),
                    Text(
                      totalCount == null
                          ? 'Ảnh của cả nhóm trong chuyến đi'
                          : '$totalCount ảnh kỷ niệm',
                      style: AppTypography.caption.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: AppSpacing.sm),
            child: Divider(height: 1, color: AppColors.borderNeutral),
          ),
          _ContributorsRow(
            contributors: contributors,
            onShowContributors: onShowContributors,
          ),
        ],
      ),
    );
  }
}

class _ContributorsRow extends StatelessWidget {
  const _ContributorsRow({required this.contributors, this.onShowContributors});

  static const _maxAvatars = 4;
  static const _avatarSize = AppSizes.avatarSm;
  static const _overlap = 10.0;

  final List<TripMemoryContributor> contributors;
  final VoidCallback? onShowContributors;

  @override
  Widget build(BuildContext context) {
    final shown = contributors.take(_maxAvatars).toList(growable: false);
    final label = contributors.isEmpty
        ? 'Chưa có ai đăng ảnh'
        : '${contributors.length} thành viên đóng góp';
    return Row(
      children: [
        if (shown.isNotEmpty) ...[
          SizedBox(
            width: _avatarSize + (shown.length - 1) * (_avatarSize - _overlap),
            height: _avatarSize,
            child: Stack(
              children: [
                for (var i = 0; i < shown.length; i++)
                  Positioned(
                    left: i * (_avatarSize - _overlap),
                    child: AppAvatar(
                      size: _avatarSize,
                      imageUrl: shown[i].avatarUrl,
                      initials: initialsOf(shown[i].name),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.xs),
        ],
        Expanded(
          child: Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text(
                label,
                style: AppTypography.caption.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              if (onShowContributors != null && contributors.isNotEmpty)
                AppPressable(
                  onTap: onShowContributors,
                  borderRadius: BorderRadius.circular(AppRadius.pill),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.xs,
                      vertical: AppSpacing.xxs,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: Text(
                            'Chi tiết',
                            style: AppTypography.caption.copyWith(
                              color: AppColors.primaryActive,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        const Icon(
                          Icons.chevron_right_rounded,
                          size: 16,
                          color: AppColors.primaryActive,
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
