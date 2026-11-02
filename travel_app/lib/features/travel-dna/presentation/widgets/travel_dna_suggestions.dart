import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_gradients.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_avatar.dart';
import 'package:travel_frontend_v1/core/widget/app_button.dart';
import 'package:travel_frontend_v1/core/widget/app_card.dart';

import '../../application/travel_dna_radar_view.dart';

class TravelDnaJourneyCard extends StatelessWidget {
  const TravelDnaJourneyCard({
    super.key,
    required this.journey,
    required this.onOpen,
  });

  final TravelDnaJourneyView journey;
  final VoidCallback onOpen;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: EdgeInsets.zero,
      radius: AppRadius.cardLarge,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 176,
            child: Stack(
              fit: StackFit.expand,
              children: [
                _JourneyCover(url: journey.coverImageUrl),
                const DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: AppGradients.heroImageOverlay,
                  ),
                ),
                Positioned(
                  top: AppSpacing.sm,
                  left: AppSpacing.sm,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: AppColors.glass85,
                      borderRadius: BorderRadius.circular(AppRadius.pill),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.auto_awesome_rounded,
                            size: 14,
                            color: AppColors.primary,
                          ),
                          const SizedBox(width: AppSpacing.xxs),
                          Text(
                            'Độ Hợp Gu ${journey.matchPercent}%',
                            style: AppTypography.badge.copyWith(
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: AppSpacing.md,
                  right: AppSpacing.md,
                  bottom: AppSpacing.sm,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        journey.eyebrow,
                        style: AppTypography.caption.copyWith(
                          color: AppColors.primaryLight,
                        ),
                      ),
                      Text(
                        journey.title,
                        style: AppTypography.cardTitle.copyWith(
                          color: AppColors.textInverse,
                          fontWeight: FontWeight.w700,
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
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Wrap(
                  spacing: AppSpacing.sm,
                  runSpacing: AppSpacing.xxs,
                  children: [
                    _Meta(
                      icon: Icons.schedule_rounded,
                      label: journey.durationLabel,
                    ),
                    _Meta(
                      icon: Icons.place_rounded,
                      label: journey.highlightLabel,
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.sm),
                AppButton(label: 'Xem Hành Trình', onPressed: onOpen),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TravelDnaCompanionSection extends StatelessWidget {
  const TravelDnaCompanionSection({
    super.key,
    required this.companions,
    required this.onFindCompanions,
  });

  final List<TravelDnaCompanionView> companions;
  final VoidCallback onFindCompanions;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      radius: AppRadius.cardLarge,
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const Icon(
                Icons.join_inner_rounded,
                color: AppColors.primary,
                size: 20,
              ),
              const SizedBox(width: AppSpacing.xs),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Độ Hợp Gu Với Bạn Bè',
                      style: AppTypography.sectionTitle,
                    ),
                    Text(
                      'Chỉ số hòa hợp khi lập nhóm vi vu',
                      style: AppTypography.caption,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          if (companions.isEmpty)
            Text('Chưa có bạn bè đạt độ hợp từ 70%.', style: AppTypography.body)
          else
            for (final companion in companions) ...[
              TravelDnaCompanionTile(companion: companion),
              const SizedBox(height: AppSpacing.sm),
            ],
          const SizedBox(height: AppSpacing.xs),
          AppButton(
            label: 'Tìm Bạn Đồng Hành Hợp Gu DNA',
            leadingIcon: Icons.groups_rounded,
            onPressed: onFindCompanions,
          ),
        ],
      ),
    );
  }
}

class TravelDnaCompanionTile extends StatelessWidget {
  const TravelDnaCompanionTile({super.key, required this.companion});

  final TravelDnaCompanionView companion;

  @override
  Widget build(BuildContext context) {
    final tone = _fitColor(companion.matchPercent);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.surfaceSubdued,
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(color: AppColors.borderNeutral),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.sm),
        child: Row(
          children: [
            AppAvatar(
              size: 48,
              imageUrl: companion.avatarUrl,
              initials: companion.initials,
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(
                    TextSpan(
                      text: companion.name,
                      style: AppTypography.cardTitle,
                      children: [
                        TextSpan(
                          text: '  ${companion.handle}',
                          style: AppTypography.caption,
                        ),
                      ],
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(companion.note, style: AppTypography.caption),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.xs),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${companion.matchPercent}%',
                  style: AppTypography.sectionTitle.copyWith(color: tone),
                ),
                Text(
                  companion.fitLabel,
                  style: AppTypography.caption.copyWith(
                    color: tone,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _JourneyCover extends StatelessWidget {
  const _JourneyCover({required this.url});

  final String? url;

  @override
  Widget build(BuildContext context) {
    if (url == null || url!.isEmpty) {
      return const ColoredBox(color: AppColors.primaryLight);
    }
    return Image.network(
      url!,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) =>
          const ColoredBox(color: AppColors.primaryLight),
    );
  }
}

class _Meta extends StatelessWidget {
  const _Meta({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: AppColors.primary),
        const SizedBox(width: 4),
        Text(label, style: AppTypography.caption),
      ],
    );
  }
}

Color _fitColor(int percent) {
  if (percent >= 90) return AppColors.success;
  if (percent >= 80) return AppColors.primary;
  return AppColors.warning;
}
