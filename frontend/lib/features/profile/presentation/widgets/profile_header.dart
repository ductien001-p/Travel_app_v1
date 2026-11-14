import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_avatar.dart';

import '../../data/models/profile_model.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    super.key,
    required this.profile,
    required this.verified,
    required this.rankLabel,
    required this.pointsLabel,
  });

  final ProfileModel profile;
  final bool verified;
  final String rankLabel;
  final String pointsLabel;

  @override
  Widget build(BuildContext context) => Column(
    children: [
      Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: const EdgeInsets.all(3),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [AppColors.primaryActive, AppColors.primary],
              ),
            ),
            child: AppAvatar(
              size: 92,
              initials: profile.initials,
              imageUrl: profile.avatarUrl,
            ),
          ),
          if (verified)
            Positioned(
              right: -2,
              bottom: 1,
              child: Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.surface, width: 2),
                ),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.verified_rounded,
                  size: 16,
                  color: AppColors.textInverse,
                ),
              ),
            ),
        ],
      ),
      const SizedBox(height: AppSpacing.sm),
      Text(
        profile.displayName ?? profile.username,
        style: AppTypography.sectionTitle,
        textAlign: TextAlign.center,
      ),
      const SizedBox(height: AppSpacing.xxs),
      Wrap(
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: AppSpacing.xxs,
        children: [
          Text('@${profile.username}', style: AppTypography.caption),
          if (profile.location != null) ...[
            Text('•', style: AppTypography.caption),
            Text(profile.location!, style: AppTypography.caption),
          ],
        ],
      ),
      const SizedBox(height: AppSpacing.sm),
      _RankPill(label: rankLabel, pointsLabel: pointsLabel),
      if (profile.bio case final bio?) ...[
        const SizedBox(height: AppSpacing.sm),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 320),
          child: Text(
            bio,
            style: AppTypography.bodyMedium.copyWith(height: 1.45),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    ],
  );
}

class _RankPill extends StatelessWidget {
  const _RankPill({required this.label, required this.pointsLabel});

  final String label;
  final String pointsLabel;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
    decoration: BoxDecoration(
      color: AppColors.warning.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(AppRadius.pill),
      border: Border.all(color: AppColors.warning.withValues(alpha: 0.35)),
    ),
    child: Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 6,
      children: [
        const Icon(
          Icons.emoji_events_rounded,
          size: 14,
          color: AppColors.warning,
        ),
        Text(label, style: AppTypography.badge),
        Container(
          width: 6,
          height: 6,
          decoration: const BoxDecoration(
            color: AppColors.star,
            shape: BoxShape.circle,
          ),
        ),
        Text(
          pointsLabel,
          style: AppTypography.badge.copyWith(color: AppColors.warning),
        ),
      ],
    ),
  );
}
