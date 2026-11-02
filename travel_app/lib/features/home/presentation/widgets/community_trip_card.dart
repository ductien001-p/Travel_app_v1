import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_shadows.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_avatar.dart';
import 'package:travel_frontend_v1/core/widget/app_button.dart';
import 'package:travel_frontend_v1/core/widget/app_glass_surface.dart';
import 'package:travel_frontend_v1/core/widget/app_pressable.dart';
import 'package:travel_frontend_v1/core/widget/app_progress_bar.dart';
import 'package:travel_frontend_v1/features/trips/trip-publish/application/publish_entry.dart';

import '../../data/models/explore_home_models.dart';

class CommunityTripCardWidget extends StatelessWidget {
  const CommunityTripCardWidget({
    super.key,
    required this.trip,
    required this.isBookmarked,
    required this.onBookmark,
    required this.onViewItinerary,
    required this.onJoin,
    this.joining = false,
  });

  final CommunityTripCard trip;
  final bool isBookmarked;
  final VoidCallback onBookmark;
  final VoidCallback onViewItinerary;
  final VoidCallback onJoin;
  final bool joining;

  int get _emptySlots =>
      trip.slotsRemaining ?? (trip.capacity - trip.memberCount).clamp(0, 99);

  double get _fillRatio =>
      trip.capacity <= 0 ? 0 : trip.memberCount / trip.capacity;

  @override
  Widget build(BuildContext context) {
    return AppGlassSurface(
      radius: AppRadius.card,
      padding: const EdgeInsets.all(AppSpacing.md),
      shadows: AppShadows.level1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _AuthorRow(
            author: trip.author,
            isBookmarked: isBookmarked,
            onBookmark: onBookmark,
          ),
          const SizedBox(height: AppSpacing.sm),
          AppPressable(
            onTap: onViewItinerary,
            child: _Cover(
              coverUrl: trip.coverUrl,
              badges: trip.badges,
              durationLabel: trip.durationLabel,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          AppPressable(
            onTap: onViewItinerary,
            child: Text(trip.title, style: AppTypography.cardTitle),
          ),
          if (trip.requirements != null &&
              trip.requirements!.trim().isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(
              trip.requirements!,
              style: AppTypography.caption.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
          if (trip.expiresAt != null) ...[
            const SizedBox(height: 4),
            Text(
              'Hết hạn ${formatRecruitmentInstant(trip.expiresAt!)}',
              style: AppTypography.caption.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
          const SizedBox(height: AppSpacing.sm),
          _MetaGrid(
            dateLabel: trip.dateLabel,
            costLabel: trip.costLabel,
            departureLabel: trip.departureLabel,
          ),
          const SizedBox(height: AppSpacing.sm),
          _SlotsRow(
            memberCount: trip.memberCount,
            capacity: trip.capacity,
            emptySlots: _emptySlots,
            fillRatio: _fillRatio,
          ),
          if (trip.memberAvatars.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.sm),
            _MembersRail(
              avatars: trip.memberAvatars,
              emptySlots: _emptySlots,
              memberCount: trip.memberCount,
            ),
          ],
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: AppButton(
                  label: 'Xem lịch trình',
                  onPressed: onViewItinerary,
                  variant: AppButtonVariant.secondary,
                  expand: true,
                ),
              ),
              const SizedBox(width: AppSpacing.xs),
              Expanded(
                flex: 3,
                child: AppButton(
                  label: 'Tham gia ngay',
                  onPressed: joining ? null : onJoin,
                  isLoading: joining,
                  trailingIcon: Icons.rocket_launch_rounded,
                  expand: true,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _AuthorRow extends StatelessWidget {
  const _AuthorRow({
    required this.author,
    required this.isBookmarked,
    required this.onBookmark,
  });

  final CommunityTripAuthor author;
  final bool isBookmarked;
  final VoidCallback onBookmark;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppAvatar(
          size: 40,
          imageUrl: author.avatarUrl,
          initials: author.name.isNotEmpty
              ? author.name.characters.first.toUpperCase()
              : '?',
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Flexible(
                    child: Text(
                      author.name,
                      style: AppTypography.bodyMedium.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(author.handle, style: AppTypography.caption),
                ],
              ),
              if (author.badgeLabel != null)
                Text(
                  author.badgeLabel!,
                  style: AppTypography.caption.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                    fontSize: 11,
                  ),
                ),
            ],
          ),
        ),
        AppPressable(
          onTap: onBookmark,
          borderRadius: BorderRadius.circular(AppRadius.pill),
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: Icon(
              isBookmarked ? Icons.bookmark_rounded : Icons.bookmark_border,
              size: 20,
              color: isBookmarked ? AppColors.primary : AppColors.textTertiary,
            ),
          ),
        ),
      ],
    );
  }
}

class _Cover extends StatelessWidget {
  const _Cover({
    required this.coverUrl,
    required this.badges,
    required this.durationLabel,
  });

  final String coverUrl;
  final List<String> badges;
  final String durationLabel;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppRadius.input),
      child: Stack(
        children: [
          Image.network(
            coverUrl,
            width: double.infinity,
            height: 144,
            fit: BoxFit.cover,
            errorBuilder: (_, _, _) => Container(
              width: double.infinity,
              height: 144,
              color: AppColors.primaryLight,
              alignment: Alignment.center,
              child: const Icon(
                Icons.image_not_supported_outlined,
                color: AppColors.primary,
              ),
            ),
          ),
          Positioned(
            top: 10,
            left: 10,
            child: Wrap(
              spacing: 6,
              children: [
                for (var i = 0; i < badges.length; i++)
                  _OverlayBadge(label: badges[i], emphasized: i == 0),
              ],
            ),
          ),
          Positioned(
            bottom: 10,
            right: 10,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: AppColors.glass85,
                borderRadius: BorderRadius.circular(AppRadius.pill),
              ),
              child: Text(
                durationLabel,
                style: AppTypography.caption.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _OverlayBadge extends StatelessWidget {
  const _OverlayBadge({required this.label, required this.emphasized});

  final String label;
  final bool emphasized;

  @override
  Widget build(BuildContext context) {
    final isUrgent =
        label.toLowerCase().contains('còn') ||
        label.toLowerCase().contains('chỉ');
    final bg = isUrgent
        ? AppColors.danger.withValues(alpha: 0.9)
        : emphasized
        ? AppColors.glass85
        : AppColors.textPrimary.withValues(alpha: 0.75);
    final fg = isUrgent || !emphasized
        ? AppColors.textInverse
        : AppColors.primary;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(AppRadius.pill),
        border: emphasized && !isUrgent
            ? Border.all(color: AppColors.glassBorder)
            : null,
      ),
      child: Text(label, style: AppTypography.badge.copyWith(color: fg)),
    );
  }
}

class _MetaGrid extends StatelessWidget {
  const _MetaGrid({
    required this.dateLabel,
    required this.costLabel,
    required this.departureLabel,
  });

  final String dateLabel;
  final String costLabel;
  final String departureLabel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.surfaceSubdued.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(AppRadius.input),
        border: Border.all(color: AppColors.borderBrandSoft),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _MetaItem(
                  icon: Icons.calendar_month_rounded,
                  caption: 'Thời gian',
                  value: dateLabel,
                ),
              ),
              Expanded(
                child: _MetaItem(
                  icon: Icons.payments_outlined,
                  caption: 'Ước tính',
                  value: costLabel,
                  valueColor: AppColors.primary,
                  valueSuffix: '/người',
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Divider(height: 1, color: AppColors.borderBrandSoft),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(
                Icons.fmd_good_rounded,
                size: 18,
                color: AppColors.primary,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text.rich(
                  TextSpan(
                    style: AppTypography.caption.copyWith(
                      color: AppColors.textSecondary,
                    ),
                    children: [
                      const TextSpan(
                        text: 'Điểm xuất phát: ',
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextSpan(text: departureLabel),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MetaItem extends StatelessWidget {
  const _MetaItem({
    required this.icon,
    required this.caption,
    required this.value,
    this.valueColor,
    this.valueSuffix,
  });

  final IconData icon;
  final String caption;
  final String value;
  final Color? valueColor;
  final String? valueSuffix;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: AppColors.primary),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                caption,
                style: AppTypography.caption.copyWith(fontSize: 11),
              ),
              Text.rich(
                TextSpan(
                  style: AppTypography.caption.copyWith(
                    color: valueColor ?? AppColors.textPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                  children: [
                    TextSpan(text: value),
                    if (valueSuffix != null)
                      TextSpan(
                        text: valueSuffix,
                        style: AppTypography.caption.copyWith(
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textSecondary,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SlotsRow extends StatelessWidget {
  const _SlotsRow({
    required this.memberCount,
    required this.capacity,
    required this.emptySlots,
    required this.fillRatio,
  });

  final int memberCount;
  final int capacity;
  final int emptySlots;
  final double fillRatio;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Icon(
              Icons.groups_rounded,
              size: 15,
              color: AppColors.primary,
            ),
            const SizedBox(width: 4),
            Text.rich(
              TextSpan(
                style: AppTypography.caption.copyWith(
                  color: AppColors.textSecondary,
                ),
                children: [
                  const TextSpan(text: 'Quy mô: '),
                  TextSpan(
                    text: '$memberCount/$capacity người',
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: AppColors.primaryLight,
                borderRadius: BorderRadius.circular(AppRadius.pill),
              ),
              child: Text(
                'Còn $emptySlots chỗ trống',
                style: AppTypography.caption.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        AppProgressBar(value: fillRatio, height: 8),
      ],
    );
  }
}

class _MembersRail extends StatelessWidget {
  const _MembersRail({
    required this.avatars,
    required this.emptySlots,
    required this.memberCount,
  });

  final List<String> avatars;
  final int emptySlots;
  final int memberCount;

  @override
  Widget build(BuildContext context) {
    final shownEmpty = emptySlots.clamp(0, 3);
    final total = avatars.length + shownEmpty;
    final width = total <= 0 ? 0.0 : 28.0 + (total - 1) * 20.0;

    return Row(
      children: [
        SizedBox(
          width: width,
          height: 28,
          child: Stack(
            children: [
              for (var i = 0; i < avatars.length; i++)
                Positioned(
                  left: i * 20.0,
                  child: AppAvatar(size: 28, imageUrl: avatars[i]),
                ),
              for (var i = 0; i < shownEmpty; i++)
                Positioned(
                  left: (avatars.length + i) * 20.0,
                  child: Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primaryLight.withValues(alpha: 0.4),
                      border: Border.all(
                        color: AppColors.primary.withValues(alpha: 0.45),
                        width: 2,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '+1',
                      style: AppTypography.badge.copyWith(
                        color: AppColors.primary,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
        const Spacer(),
        Text(
          '$memberCount bạn cùng gu đã tham gia',
          style: AppTypography.caption,
        ),
      ],
    );
  }
}
