import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_shadows.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_badge.dart';

import '../../data/models/trip_invite_preview_models.dart';
import '../../utils/trip_join_by_code_formatters.dart';

class TripJoinByCodePreviewCard extends StatelessWidget {
  const TripJoinByCodePreviewCard({super.key, required this.preview});

  final TripJoinInvitePreview preview;

  @override
  Widget build(BuildContext context) {
    final remaining = preview.maxMembers - preview.memberCount;
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(color: AppColors.glassBorder),
        boxShadow: AppShadows.level1,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: AppSpacing.xs),
              Expanded(
                child: Text(
                  'Xem Trước Hành Trình',
                  style: AppTypography.badge.copyWith(
                    color: AppColors.textTertiary,
                  ),
                ),
              ),
              AppBadge(label: preview.inviteCode),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          const Divider(height: 1, color: AppColors.borderBrandSoft),
          const SizedBox(height: AppSpacing.sm),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(AppRadius.input),
                child: SizedBox(
                  width: 80,
                  height: 80,
                  child: preview.coverImageUrl == null
                      ? ColoredBox(
                          color: AppColors.surfaceSubdued,
                          child: Icon(
                            Icons.landscape_rounded,
                            color: AppColors.primary.withValues(alpha: 0.5),
                          ),
                        )
                      : Image.network(
                          preview.coverImageUrl!,
                          fit: BoxFit.cover,
                          errorBuilder: (_, _, _) => ColoredBox(
                            color: AppColors.surfaceSubdued,
                            child: Icon(
                              Icons.broken_image_outlined,
                              color: AppColors.primary.withValues(alpha: 0.5),
                            ),
                          ),
                        ),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      preview.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.cardTitle.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xxs),
                    _MetaRow(
                      icon: Icons.calendar_month_rounded,
                      text: inviteCodeNightDayLabel(
                        preview.startDate.toUtc(),
                        preview.endDate.toUtc(),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xxs),
                    _MetaRow(
                      icon: Icons.person_pin_rounded,
                      text: 'Trưởng nhóm: ${preview.ownerDisplayName} (Owner)',
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              Expanded(
                child: _StatTile(
                  icon: Icons.group_rounded,
                  iconColor: AppColors.warning,
                  iconBackground: AppColors.warning.withValues(alpha: 0.15),
                  label: 'Suất tham gia',
                  value: Text.rich(
                    TextSpan(
                      style: AppTypography.caption.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                      children: [
                        TextSpan(
                          text: '${preview.memberCount}/${preview.maxMembers}',
                        ),
                        if (remaining > 0)
                          TextSpan(
                            text: ' (Còn $remaining suất)',
                            style: const TextStyle(
                              color: AppColors.danger,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.xs),
              Expanded(
                child: _StatTile(
                  icon: Icons.favorite_rounded,
                  iconColor: AppColors.textInverse,
                  iconBackground: AppColors.primary,
                  label: 'Độ hợp gu DNA',
                  value: Text(
                    preview.matchScore == null
                        ? '—'
                        : inviteMatchLabel(preview.matchScore!),
                    style: AppTypography.caption.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w700,
                    ),
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

class _MetaRow extends StatelessWidget {
  const _MetaRow({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) => Row(
    children: [
      Icon(icon, size: 14, color: AppColors.primary),
      const SizedBox(width: AppSpacing.xxs),
      Expanded(
        child: Text(
          text,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTypography.caption.copyWith(color: AppColors.textSecondary),
        ),
      ),
    ],
  );
}

class _StatTile extends StatelessWidget {
  const _StatTile({
    required this.icon,
    required this.iconColor,
    required this.iconBackground,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final Color iconColor;
  final Color iconBackground;
  final String label;
  final Widget value;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(AppSpacing.xs + 2),
    decoration: BoxDecoration(
      color: AppColors.surfaceSubdued,
      borderRadius: BorderRadius.circular(AppRadius.input),
      border: Border.all(color: AppColors.borderBrandSoft),
    ),
    child: Row(
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: iconBackground,
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Icon(icon, size: 14, color: iconColor),
        ),
        const SizedBox(width: AppSpacing.xs),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: AppTypography.caption.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              value,
            ],
          ),
        ),
      ],
    ),
  );
}
