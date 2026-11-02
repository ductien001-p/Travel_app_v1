import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_shadows.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_avatar.dart';
import 'package:travel_frontend_v1/core/widget/app_glass_surface.dart';
import 'package:travel_frontend_v1/core/widget/app_pressable.dart';
import 'package:travel_frontend_v1/features/home/data/models/explore_home_models.dart';

import '../../application/destination_trips_controller.dart';

class DestinationTripCard extends StatelessWidget {
  const DestinationTripCard({
    super.key,
    required this.trip,
    required this.bookmarked,
    required this.joining,
    required this.onBookmark,
    required this.onOpen,
    required this.onJoin,
  });

  final CommunityTripCard trip;
  final bool bookmarked;
  final bool joining;
  final VoidCallback onBookmark;
  final VoidCallback onOpen;
  final VoidCallback onJoin;

  @override
  Widget build(BuildContext context) {
    final urgent = isUrgentDestinationTrip(trip);
    final slots =
        trip.slotsRemaining ?? (trip.capacity - trip.memberCount).clamp(0, 99);
    final toneLabel = urgent
        ? 'Đang tuyển gấp (Còn $slots chỗ)'
        : (trip.badges.isEmpty ? 'Đang tuyển' : trip.badges.first);

    return AppGlassSurface(
      radius: AppRadius.card,
      padding: const EdgeInsets.all(AppSpacing.md),
      borderColor: AppColors.borderBrandSoft,
      shadows: AppShadows.level1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    _ToneBadge(label: toneLabel, urgent: urgent),
                    _DurationBadge(label: trip.durationLabel),
                  ],
                ),
              ),
              AppPressable(
                onTap: onBookmark,
                child: Icon(
                  bookmarked
                      ? Icons.bookmark_rounded
                      : Icons.bookmark_border_rounded,
                  color: bookmarked
                      ? AppColors.primary
                      : AppColors.textTertiary,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
          AppPressable(
            onTap: onOpen,
            child: Text(trip.title, style: AppTypography.cardTitle),
          ),
          const SizedBox(height: AppSpacing.sm),
          _HostRow(trip: trip),
          const SizedBox(height: AppSpacing.sm),
          _MetaGrid(trip: trip),
          const SizedBox(height: AppSpacing.sm),
          const Divider(height: 1, color: AppColors.surfaceSubdued),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              Expanded(child: _Members(trip: trip)),
              _ActionButton(label: 'Lịch trình', filled: false, onTap: onOpen),
              const SizedBox(width: 8),
              _ActionButton(
                label: urgent ? 'Đăng ký' : 'Tham gia',
                filled: true,
                loading: joining,
                onTap: joining ? null : onJoin,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ToneBadge extends StatelessWidget {
  const _ToneBadge({required this.label, required this.urgent});

  final String label;
  final bool urgent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: urgent
            ? const Color.fromRGBO(239, 68, 68, 0.10)
            : AppColors.surfaceSubdued,
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (urgent) ...[
            const Icon(Icons.bolt_rounded, size: 14, color: AppColors.danger),
            const SizedBox(width: 2),
          ],
          Flexible(
            child: Text(
              label,
              style: AppTypography.badge.copyWith(
                color: urgent ? AppColors.danger : AppColors.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DurationBadge extends StatelessWidget {
  const _DurationBadge({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.primaryLight,
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
      child: Text(
        label,
        style: AppTypography.badge.copyWith(color: AppColors.primary),
      ),
    );
  }
}

class _HostRow extends StatelessWidget {
  const _HostRow({required this.trip});

  final CommunityTripCard trip;

  @override
  Widget build(BuildContext context) {
    final role = trip.author.badgeLabel?.trim();
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.surfaceSubdued,
        borderRadius: BorderRadius.circular(AppRadius.input),
      ),
      child: Row(
        children: [
          AppAvatar(
            size: 40,
            imageUrl: trip.author.avatarUrl,
            initials: trip.author.name,
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${trip.author.name}  ${trip.author.handle}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  role == null || role.isEmpty ? 'Chủ chuyến' : role,
                  style: AppTypography.caption.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MetaGrid extends StatelessWidget {
  const _MetaGrid({required this.trip});

  final CommunityTripCard trip;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: AppColors.canvas,
        borderRadius: BorderRadius.circular(AppRadius.input),
        border: Border.all(color: AppColors.surfaceSubdued),
      ),
      child: Row(
        children: [
          Expanded(
            child: _Meta(
              icon: Icons.calendar_month_rounded,
              label: 'Thời gian',
              value: trip.dateLabel,
            ),
          ),
          Expanded(
            child: _Meta(
              icon: Icons.payments_rounded,
              label: 'Dự tính/người',
              value: trip.costLabel,
              emphasize: true,
            ),
          ),
        ],
      ),
    );
  }
}

class _Meta extends StatelessWidget {
  const _Meta({
    required this.icon,
    required this.label,
    required this.value,
    this.emphasize = false,
  });

  final IconData icon;
  final String label;
  final String value;
  final bool emphasize;

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
              Text(label, style: AppTypography.caption),
              Text(
                value,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.bodyMedium.copyWith(
                  color: emphasize ? AppColors.primary : AppColors.textPrimary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Members extends StatelessWidget {
  const _Members({required this.trip});

  final CommunityTripCard trip;

  @override
  Widget build(BuildContext context) {
    final shown = trip.memberAvatars.take(3).toList(growable: false);
    final extra = trip.memberCount - shown.length;
    return Row(
      children: [
        if (shown.isNotEmpty)
          SizedBox(
            width: 20.0 + (shown.length * 16) + (extra > 0 ? 16 : 0),
            height: 28,
            child: Stack(
              children: [
                for (var index = 0; index < shown.length; index++)
                  Positioned(
                    left: index * 16,
                    child: AppAvatar(size: 28, imageUrl: shown[index]),
                  ),
                if (extra > 0)
                  Positioned(
                    left: shown.length * 16,
                    child: Container(
                      width: 28,
                      height: 28,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        color: AppColors.primaryLight,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        '+$extra',
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
        const SizedBox(width: 6),
        Flexible(
          child: Text(
            '${trip.memberCount}/${trip.capacity} đã tham gia',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTypography.caption.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.label,
    required this.filled,
    required this.onTap,
    this.loading = false,
  });

  final String label;
  final bool filled;
  final VoidCallback? onTap;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    return AppPressable(
      onTap: onTap,
      pressedScale: 0.95,
      borderRadius: BorderRadius.circular(AppRadius.pill),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: filled ? AppColors.primary : AppColors.primaryLight,
          borderRadius: BorderRadius.circular(AppRadius.pill),
          boxShadow: filled ? AppShadows.primaryGlow : null,
        ),
        child: loading
            ? SizedBox.square(
                dimension: 14,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: filled ? AppColors.textInverse : AppColors.primary,
                ),
              )
            : Text(
                label,
                style: AppTypography.badge.copyWith(
                  color: filled ? AppColors.textInverse : AppColors.primary,
                ),
              ),
      ),
    );
  }
}
