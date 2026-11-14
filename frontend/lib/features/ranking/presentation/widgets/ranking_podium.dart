import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_shadows.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_avatar.dart';

import '../../application/ranking_view.dart';
import '../../data/models/ranking_models.dart';

class RankingPodiumSection extends StatelessWidget {
  const RankingPodiumSection({
    super.key,
    required this.travelers,
    required this.updatedLabel,
  });

  final List<RankingTraveler> travelers;
  final String updatedLabel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Icon(
              Icons.emoji_events_rounded,
              size: 20,
              color: AppColors.warning,
            ),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                'Top Nhà Thám Hiểm',
                style: AppTypography.sectionTitle.copyWith(fontSize: 18),
              ),
            ),
            Text(
              updatedLabel,
              style: AppTypography.caption.copyWith(
                color: AppColors.textTertiary,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        if (travelers.isEmpty)
          Text(
            'Chưa có bảng xếp hạng',
            style: AppTypography.body.copyWith(color: AppColors.textTertiary),
          )
        else
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              for (var i = 0; i < travelers.length; i++) ...[
                if (i > 0) const SizedBox(width: 10),
                Expanded(child: _PodiumColumn(traveler: travelers[i])),
              ],
            ],
          ),
      ],
    );
  }
}

class _PodiumColumn extends StatelessWidget {
  const _PodiumColumn({required this.traveler});

  final RankingTraveler traveler;

  bool get _isFirst => traveler.rank == 1;

  @override
  Widget build(BuildContext context) {
    final avatarSize = _isFirst ? 80.0 : 64.0;
    final ringColor = switch (traveler.rank) {
      1 => const Color(0xFFFBBF24),
      2 => const Color(0xFFCBD5E1),
      _ => const Color(0xFFB45309),
    };
    final badgeColor = switch (traveler.rank) {
      1 => const Color(0xFFF59E0B),
      2 => const Color(0xFF475569),
      _ => const Color(0xFF92400E),
    };

    return Column(
      children: [
        if (_isFirst)
          const Padding(
            padding: EdgeInsets.only(bottom: 4),
            child: Icon(
              Icons.workspace_premium_rounded,
              size: 28,
              color: Color(0xFFF59E0B),
            ),
          )
        else
          Icon(
            traveler.rank == 2
                ? Icons.military_tech_rounded
                : Icons.military_tech_outlined,
            size: 20,
            color: ringColor,
          ),
        const SizedBox(height: 4),
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              padding: EdgeInsets.all(_isFirst ? 3 : 2),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: ringColor, width: _isFirst ? 3 : 2),
                boxShadow: _isFirst
                    ? const [
                        BoxShadow(
                          color: Color.fromRGBO(245, 158, 11, 0.35),
                          blurRadius: 18,
                          offset: Offset(0, 8),
                        ),
                      ]
                    : AppShadows.level1,
              ),
              child: AppAvatar(
                size: avatarSize,
                imageUrl: traveler.avatarUrl,
                initials: traveler.displayName,
                verified: false,
              ),
            ),
            Positioned(
              right: -2,
              bottom: -2,
              child: Container(
                width: _isFirst ? 24 : 20,
                height: _isFirst ? 24 : 20,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: badgeColor,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.surface, width: 2),
                ),
                child: Text(
                  '${traveler.rank}',
                  style: AppTypography.badge.copyWith(
                    color: AppColors.textInverse,
                    fontSize: 10,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          traveler.displayName,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: (_isFirst ? AppTypography.bodyMedium : AppTypography.caption)
              .copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w800,
              ),
        ),
        Text(
          '@${traveler.username}',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: AppTypography.caption.copyWith(
            color: AppColors.textTertiary,
            fontSize: 10,
          ),
        ),
        if (traveler.badgeLabel != null) ...[
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: _isFirst
                  ? const Color(0xFFFFFBEB)
                  : AppColors.primaryLight,
              borderRadius: BorderRadius.circular(AppRadius.pill),
            ),
            child: Text(
              traveler.badgeLabel!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTypography.badge.copyWith(
                color: _isFirst ? const Color(0xFF92400E) : AppColors.primary,
                fontSize: 10,
                letterSpacing: 0,
              ),
            ),
          ),
        ],
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: EdgeInsets.fromLTRB(4, _isFirst ? 14 : 12, 4, 10),
          decoration: BoxDecoration(
            gradient: _isFirst
                ? const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFFFFF3C4),
                      Color(0xFFFFFBEB),
                      Color(0xFFFFFFFF),
                    ],
                  )
                : const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFFF7FBFA), Color(0xFFEAF3F2)],
                  ),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            border: Border.all(
              color: _isFirst
                  ? const Color.fromRGBO(251, 191, 36, 0.55)
                  : AppColors.borderBrandSoft,
            ),
            boxShadow: AppShadows.level1,
          ),
          child: Column(
            children: [
              Text(
                _isFirst
                    ? rankingPointsLabel(traveler.points, withUnit: true)
                    : rankingPointsLabel(traveler.points),
                style: AppTypography.cardTitle.copyWith(
                  color: _isFirst ? AppColors.primary : AppColors.textPrimary,
                  fontWeight: FontWeight.w800,
                  fontSize: _isFirst ? 16 : 14,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                '${traveler.tripsCompleted} chuyến đi',
                style: AppTypography.caption.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: _isFirst ? FontWeight.w700 : FontWeight.w500,
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
