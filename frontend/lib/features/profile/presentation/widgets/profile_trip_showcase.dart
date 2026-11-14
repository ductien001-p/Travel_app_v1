import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_gradients.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_empty_view.dart';
import 'package:travel_frontend_v1/core/widget/app_glass_surface.dart';
import 'package:travel_frontend_v1/core/widget/app_icon_button.dart';
import 'package:travel_frontend_v1/core/widget/app_section_header.dart';

import '../../data/models/profile_showcase_models.dart';
import '../profile_count_format.dart';
import '../profile_showcase_labels.dart';
import 'profile_remote_image.dart';

class ProfileTripShowcase extends StatelessWidget {
  const ProfileTripShowcase({
    super.key,
    required this.showcase,
    required this.onSeeAllTrips,
    required this.onOpenOngoing,
    required this.onOpenUpcoming,
    required this.onOpenMemories,
  });

  final ProfileShowcase showcase;
  final VoidCallback onSeeAllTrips;
  final VoidCallback onOpenOngoing;
  final VoidCallback onOpenUpcoming;
  final VoidCallback onOpenMemories;

  @override
  Widget build(BuildContext context) {
    final ongoing = showcase.ongoingTrip;
    final upcoming = showcase.upcomingTrip;
    if (ongoing == null && upcoming == null) {
      return const AppEmptyView(
        title: 'Chưa có chuyến đi',
        description: 'Các chuyến đang diễn ra và sắp tới sẽ hiện ở đây.',
        icon: Icons.luggage_outlined,
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppSectionHeader(
          title: 'Chuyến Đi Đang Diễn Ra',
          actionLabel: 'Xem tất cả',
          onAction: onSeeAllTrips,
        ),
        const SizedBox(height: AppSpacing.sm),
        if (ongoing != null) ...[
          _OngoingTripCard(trip: ongoing, onOpen: onOpenOngoing),
          const SizedBox(height: AppSpacing.sm),
        ],
        if (upcoming != null)
          _UpcomingTripCard(trip: upcoming, onOpen: onOpenUpcoming),
        const SizedBox(height: AppSpacing.lg),
        _MemoriesStrip(memories: showcase.memories, onOpen: onOpenMemories),
      ],
    );
  }
}

class _OngoingTripCard extends StatelessWidget {
  const _OngoingTripCard({required this.trip, required this.onOpen});

  final ProfileShowcaseTrip trip;
  final VoidCallback onOpen;

  @override
  Widget build(BuildContext context) => AppGlassSurface(
    radius: AppRadius.card,
    padding: EdgeInsets.zero,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: 176,
          child: Stack(
            fit: StackFit.expand,
            children: [
              ProfileRemoteImage(url: trip.coverImageUrl),
              const DecoratedBox(
                decoration: BoxDecoration(
                  gradient: AppGradients.heroImageOverlay,
                ),
              ),
              Positioned(
                top: AppSpacing.sm,
                left: AppSpacing.sm,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(AppRadius.pill),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: AppColors.textInverse,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        profileTripStatusLabel(trip.status),
                        style: AppTypography.badge.copyWith(
                          color: AppColors.textInverse,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: AppSpacing.sm,
                right: AppSpacing.sm,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.textPrimary.withValues(alpha: 0.45),
                    borderRadius: BorderRadius.circular(AppRadius.pill),
                    border: Border.all(color: AppColors.glassBorder),
                  ),
                  child: Text(
                    profileTripDateLabel(trip.startDate, trip.endDate),
                    style: AppTypography.caption.copyWith(
                      color: AppColors.textInverse,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: AppSpacing.sm,
                right: AppSpacing.sm,
                bottom: AppSpacing.sm,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      profileOngoingDurationLabel(
                        trip.startDate,
                        trip.endDate,
                      ).toUpperCase(),
                      style: AppTypography.caption.copyWith(
                        color: AppColors.primaryLight,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      trip.name,
                      style: AppTypography.cardTitle.copyWith(
                        color: AppColors.textInverse,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.groups_outlined,
                    size: 18,
                    color: AppColors.primary,
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  Expanded(
                    child: Text(
                      '${trip.memberCount} thành viên du lịch',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.caption.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  Flexible(
                    child: Text(
                      '${trip.completedActivities}/${trip.totalActivities} hoạt động đã hoàn thành',
                      textAlign: TextAlign.end,
                      maxLines: 2,
                      style: AppTypography.caption.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.xs),
              ClipRRect(
                borderRadius: BorderRadius.circular(AppRadius.pill),
                child: ColoredBox(
                  color: AppColors.surfaceSubdued,
                  child: SizedBox(
                    height: 8,
                    width: double.infinity,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: FractionallySizedBox(
                        widthFactor: profileRatio(
                          trip.completedActivities,
                          trip.totalActivities,
                        ),
                        heightFactor: 1,
                        child: const ColoredBox(color: AppColors.primary),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              if (profileTripHighlight(trip.highlights).isNotEmpty)
                Row(
                  children: [
                    const Icon(
                      Icons.restaurant_rounded,
                      size: 16,
                      color: AppColors.warning,
                    ),
                    const SizedBox(width: AppSpacing.xxs),
                    Expanded(
                      child: Text(
                        profileTripHighlight(trip.highlights),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTypography.caption.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: onOpen,
                      style: TextButton.styleFrom(
                        foregroundColor: AppColors.primary,
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.xs,
                        ),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Chi tiết'),
                          Icon(Icons.chevron_right_rounded, size: 16),
                        ],
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ],
    ),
  );
}

class _UpcomingTripCard extends StatelessWidget {
  const _UpcomingTripCard({required this.trip, required this.onOpen});

  final ProfileShowcaseTrip trip;
  final VoidCallback onOpen;

  @override
  Widget build(BuildContext context) => AppGlassSurface(
    radius: AppRadius.card,
    padding: const EdgeInsets.all(AppSpacing.md),
    child: Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(AppRadius.input),
          child: SizedBox(
            width: 80,
            height: 80,
            child: Stack(
              fit: StackFit.expand,
              children: [
                ProfileRemoteImage(url: trip.coverImageUrl),
                Positioned(
                  top: 4,
                  left: 4,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.textPrimary.withValues(alpha: 0.6),
                      borderRadius: BorderRadius.circular(AppRadius.input),
                    ),
                    child: Text(
                      profileTripMonthLabel(trip.startDate),
                      style: AppTypography.badge.copyWith(
                        color: AppColors.textInverse,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceSubdued,
                      borderRadius: BorderRadius.circular(AppRadius.pill),
                    ),
                    child: Text(
                      profileTripStatusLabel(trip.status),
                      style: AppTypography.badge,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  Text(
                    profileUpcomingDurationLabel(trip.startDate, trip.endDate),
                    style: AppTypography.caption,
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.xxs),
              Text(
                trip.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: AppSpacing.xxs),
              Wrap(
                spacing: AppSpacing.xs,
                runSpacing: 2,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  const Icon(
                    Icons.payments_outlined,
                    size: 14,
                    color: AppColors.textTertiary,
                  ),
                  Text(
                    profileBudgetLabel(trip.budgetLevel),
                    style: AppTypography.caption,
                  ),
                  const Text('•', style: AppTypography.caption),
                  const Icon(
                    Icons.person_add_alt_1_outlined,
                    size: 14,
                    color: AppColors.textTertiary,
                  ),
                  Text(
                    '${trip.memberCount}/${trip.maxMembers} người',
                    style: AppTypography.caption,
                  ),
                ],
              ),
            ],
          ),
        ),
        AppIconButton(
          icon: Icons.chevron_right_rounded,
          onPressed: onOpen,
          semanticLabel: 'Mở chuyến đi sắp tới',
        ),
      ],
    ),
  );
}

class _MemoriesStrip extends StatelessWidget {
  const _MemoriesStrip({required this.memories, required this.onOpen});

  final ProfileShowcaseMemories memories;
  final VoidCallback onOpen;

  @override
  Widget build(BuildContext context) {
    final previews = memories.items.take(2).toList(growable: false);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: onOpen,
                behavior: HitTestBehavior.opaque,
                child: Text(
                  'Khoảnh Khắc Hành Trình',
                  style: AppTypography.sectionTitle,
                ),
              ),
            ),
            Text(
              '${formatProfileCount(memories.totalCount)} ảnh',
              style: AppTypography.caption,
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        Row(
          children: [
            for (final item in previews) ...[
              Expanded(
                child: GestureDetector(
                  onTap: onOpen,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(AppRadius.input),
                    child: SizedBox(
                      height: 96,
                      child: ProfileRemoteImage(url: item.imageUrl),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.xs),
            ],
            Expanded(
              child: Material(
                color: AppColors.primaryLight,
                borderRadius: BorderRadius.circular(AppRadius.input),
                child: InkWell(
                  onTap: onOpen,
                  borderRadius: BorderRadius.circular(AppRadius.input),
                  child: SizedBox(
                    height: 96,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.photo_library_outlined,
                          color: AppColors.primary,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '+${formatProfileCount(profileMemoryExtraCount(memories))} ảnh',
                          style: AppTypography.badge.copyWith(
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
