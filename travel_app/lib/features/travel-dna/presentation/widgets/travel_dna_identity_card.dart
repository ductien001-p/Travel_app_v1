import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_avatar.dart';
import 'package:travel_frontend_v1/core/widget/app_card.dart';
import 'package:travel_frontend_v1/core/widget/app_progress_bar.dart';

import '../../application/travel_dna_radar_view.dart';

class TravelDnaIdentityCard extends StatelessWidget {
  const TravelDnaIdentityCard({super.key, required this.view});

  final TravelDnaRadarView view;

  @override
  Widget build(BuildContext context) {
    final identity = view.identity;
    final stats = view.stats;
    return AppCard(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppAvatar(
                size: 64,
                imageUrl: identity.avatarUrl,
                initials: identity.initials,
                verified: identity.verified,
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            identity.displayName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTypography.sectionTitle,
                          ),
                        ),
                        if (identity.rankChip != null) ...[
                          const SizedBox(width: AppSpacing.xs),
                          Flexible(child: _RankChip(label: identity.rankChip!)),
                        ],
                      ],
                    ),
                    const SizedBox(height: AppSpacing.xxs),
                    Wrap(
                      spacing: AppSpacing.xs,
                      runSpacing: AppSpacing.xxs,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text(
                          identity.personaTitle,
                          style: AppTypography.cardTitle.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        if (identity.spotlight != null)
                          _Spotlight(label: identity.spotlight!),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.xxs),
                    Text(
                      identity.summary,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.caption,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          const Divider(height: 1, color: AppColors.borderBrandSoft),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              Expanded(
                child: _Stat(
                  value: '${stats.tripsAnalyzed}',
                  label: 'Chuyến đi phân tích',
                ),
              ),
              const SizedBox(width: AppSpacing.xs),
              Expanded(
                child: _Stat(
                  value: '${stats.checkIns}',
                  label: 'Điểm check-in',
                ),
              ),
              const SizedBox(width: AppSpacing.xs),
              Expanded(
                child: _Stat(
                  value: '${stats.portraitMatch}%',
                  label: 'Độ khớp chân dung',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class TravelDnaAxisCard extends StatelessWidget {
  const TravelDnaAxisCard({super.key, required this.axis});

  final TravelDnaAxisView axis;

  @override
  Widget build(BuildContext context) {
    final score = axis.score < 0 ? 0 : axis.score;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(
          color: axis.dominant ? AppColors.primary : AppColors.borderNeutral,
        ),
        boxShadow: const [],
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.primaryLight,
                    borderRadius: BorderRadius.circular(AppRadius.input),
                  ),
                  child: Text(axis.icon, style: const TextStyle(fontSize: 20)),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              axis.title,
                              style: AppTypography.cardTitle,
                            ),
                          ),
                          if (axis.dominant) ...[
                            const SizedBox(width: AppSpacing.xxs),
                            const Icon(
                              Icons.military_tech_rounded,
                              size: 16,
                              color: AppColors.warning,
                            ),
                          ],
                        ],
                      ),
                      Text(
                        axis.badgeLabel,
                        style: AppTypography.caption.copyWith(
                          color: axis.dominant
                              ? AppColors.primary
                              : AppColors.textTertiary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: AppSpacing.xs),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '$score',
                      style: AppTypography.screenTitle.copyWith(
                        color: axis.dominant
                            ? AppColors.primary
                            : AppColors.textPrimary,
                      ),
                    ),
                    Text('/100', style: AppTypography.caption),
                  ],
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            AppProgressBar(value: score / 100),
            const SizedBox(height: AppSpacing.sm),
            Row(
              children: [
                Expanded(
                  child: Text(axis.evidence, style: AppTypography.caption),
                ),
                if (axis.fitLabel != null) ...[
                  const SizedBox(width: AppSpacing.xs),
                  Flexible(
                    child: Text(
                      axis.fitLabel!,
                      textAlign: TextAlign.right,
                      style: AppTypography.caption.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _RankChip extends StatelessWidget {
  const _RankChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.warning.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(AppRadius.pill),
        border: Border.all(color: AppColors.warning.withValues(alpha: 0.35)),
      ),
      child: Text(
        label,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: AppTypography.badge,
      ),
    );
  }
}

class _Spotlight extends StatelessWidget {
  const _Spotlight({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
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

class _Stat extends StatelessWidget {
  const _Stat({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.surfaceSubdued,
        borderRadius: BorderRadius.circular(AppRadius.input),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.xs,
          vertical: AppSpacing.sm,
        ),
        child: Column(
          children: [
            Text(
              value,
              style: AppTypography.sectionTitle.copyWith(
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              textAlign: TextAlign.center,
              style: AppTypography.caption,
            ),
          ],
        ),
      ),
    );
  }
}
