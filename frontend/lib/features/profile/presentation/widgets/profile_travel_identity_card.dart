import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_gradients.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_shadows.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';

import '../../data/models/profile_showcase_models.dart';
import '../profile_count_format.dart';
import '../profile_showcase_labels.dart';

class ProfileTravelIdentityCard extends StatelessWidget {
  const ProfileTravelIdentityCard({
    super.key,
    required this.dna,
    required this.onExplore,
  });

  final ProfileTravelDna dna;
  final VoidCallback onExplore;

  @override
  Widget build(BuildContext context) {
    final dominant = dna.dominant;
    if (dominant == null) {
      return const _EmptyDnaCard();
    }
    final traits = profileSupportingTraits(dna);
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        gradient: AppGradients.primaryAction,
        borderRadius: BorderRadius.circular(AppRadius.card),
        boxShadow: AppShadows.primaryGlow,
      ),
      child: Stack(
        children: [
          const Positioned(right: -36, bottom: -36, child: _Glow(size: 140)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.textInverse.withValues(alpha: 0.18),
                      borderRadius: BorderRadius.circular(AppRadius.pill),
                      border: Border.all(color: AppColors.glassBorder),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.biotech_rounded,
                          size: 14,
                          color: AppColors.textInverse,
                        ),
                        const SizedBox(width: AppSpacing.xxs),
                        Text(
                          'TRAVEL DNA ĐỘC BẢN',
                          style: AppTypography.badge.copyWith(
                            color: AppColors.textInverse,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'Độ khớp: ${dominant.score}%',
                      style: AppTypography.caption.copyWith(
                        color: AppColors.textInverse.withValues(alpha: 0.85),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              Row(
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: AppColors.textInverse.withValues(alpha: 0.18),
                      borderRadius: BorderRadius.circular(AppRadius.input),
                      border: Border.all(color: AppColors.glassBorder),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      dominant.icon,
                      style: const TextStyle(fontSize: 28),
                    ),
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
                                dominant.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppTypography.cardTitle.copyWith(
                                  color: AppColors.textInverse,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            Text(
                              '${dominant.score}',
                              style: AppTypography.sectionTitle.copyWith(
                                color: AppColors.textInverse,
                              ),
                            ),
                            Text(
                              '/100',
                              style: AppTypography.caption.copyWith(
                                color: AppColors.textInverse.withValues(
                                  alpha: 0.7,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 2),
                        Text(
                          profileDnaCaption(dominant),
                          style: AppTypography.caption.copyWith(
                            color: AppColors.textInverse.withValues(
                              alpha: 0.85,
                            ),
                          ),
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        _ScoreBar(
                          factor: profileRatio(dominant.score, 100),
                          fill: AppColors.textInverse,
                          track: AppColors.textPrimary.withValues(alpha: 0.2),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              if (traits.isNotEmpty) ...[
                const SizedBox(height: AppSpacing.md),
                Divider(
                  color: AppColors.textInverse.withValues(alpha: 0.2),
                  height: 1,
                ),
                const SizedBox(height: AppSpacing.sm),
                Row(
                  children: [
                    for (final trait in traits)
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 3),
                          child: _TraitPill(trait: trait),
                        ),
                      ),
                  ],
                ),
              ],
              const SizedBox(height: AppSpacing.md),
              Material(
                color: AppColors.textInverse.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(AppRadius.input),
                child: InkWell(
                  onTap: onExplore,
                  borderRadius: BorderRadius.circular(AppRadius.input),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.sm,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppRadius.input),
                      border: Border.all(color: AppColors.glassBorder),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Text(
                            'Khám phá bản đồ radar DNA & độ tương thích',
                            textAlign: TextAlign.center,
                            style: AppTypography.caption.copyWith(
                              color: AppColors.textInverse,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.xxs),
                        const Icon(
                          Icons.arrow_forward_rounded,
                          size: 16,
                          color: AppColors.textInverse,
                        ),
                      ],
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

class _EmptyDnaCard extends StatelessWidget {
  const _EmptyDnaCard();

  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
    padding: const EdgeInsets.all(AppSpacing.lg),
    decoration: BoxDecoration(
      gradient: AppGradients.primaryAction,
      borderRadius: BorderRadius.circular(AppRadius.card),
    ),
    child: Text(
      'Chưa có Travel DNA. Check-in trong chuyến đi để bắt đầu.',
      style: AppTypography.bodyMedium.copyWith(color: AppColors.textInverse),
    ),
  );
}

class _TraitPill extends StatelessWidget {
  const _TraitPill({required this.trait});

  final ProfileTravelDnaBadge trait;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
    decoration: BoxDecoration(
      color: AppColors.textInverse.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(AppRadius.input),
      border: Border.all(color: AppColors.textInverse.withValues(alpha: 0.16)),
    ),
    child: Column(
      children: [
        Text(trait.icon, style: const TextStyle(fontSize: 18)),
        const SizedBox(height: 2),
        Text(
          trait.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTypography.caption.copyWith(
            color: AppColors.textInverse,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          '${trait.score} pts',
          style: AppTypography.badge.copyWith(color: AppColors.primaryLight),
        ),
      ],
    ),
  );
}

class _ScoreBar extends StatelessWidget {
  const _ScoreBar({
    required this.factor,
    required this.fill,
    required this.track,
  });

  final double factor;
  final Color fill;
  final Color track;

  @override
  Widget build(BuildContext context) => ClipRRect(
    borderRadius: BorderRadius.circular(AppRadius.pill),
    child: ColoredBox(
      color: track,
      child: SizedBox(
        height: 8,
        width: double.infinity,
        child: Align(
          alignment: Alignment.centerLeft,
          child: FractionallySizedBox(
            widthFactor: factor,
            heightFactor: 1,
            child: ColoredBox(color: fill),
          ),
        ),
      ),
    ),
  );
}

class _Glow extends StatelessWidget {
  const _Glow({required this.size});

  final double size;

  @override
  Widget build(BuildContext context) => Container(
    width: size,
    height: size,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: AppColors.textInverse.withValues(alpha: 0.1),
    ),
  );
}
