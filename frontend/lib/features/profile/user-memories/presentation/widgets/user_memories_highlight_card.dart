import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_gradients.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_shadows.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_pressable.dart';
import 'package:travel_frontend_v1/features/profile/presentation/widgets/profile_remote_image.dart';

import '../../application/user_memories_view.dart';
import '../../data/models/user_memories_models.dart';

class UserMemoriesHighlightCard extends StatelessWidget {
  const UserMemoriesHighlightCard({
    super.key,
    required this.highlight,
    required this.onOpen,
    required this.onLike,
    required this.onShare,
  });

  final UserMemoryPhoto highlight;
  final VoidCallback onOpen;
  final VoidCallback onLike;
  final VoidCallback onShare;

  @override
  Widget build(BuildContext context) {
    final caption = highlight.caption?.trim();
    final badge = highlight.badge;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.hero),
        border: Border.all(color: AppColors.glassBorder),
        boxShadow: AppShadows.level1,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppRadius.hero),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppPressable(
              onTap: onOpen,
              child: SizedBox(
                height: 288,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    ProfileRemoteImage(url: highlight.imageUrl),
                    const DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: AppGradients.heroImageOverlay,
                      ),
                    ),
                    if (badge != null && badge.isNotEmpty)
                      Positioned(
                        top: AppSpacing.md,
                        left: AppSpacing.md,
                        child: _GlassTag(
                          icon: Icons.photo_camera_outlined,
                          label: badge,
                        ),
                      ),
                    Positioned(
                      left: AppSpacing.md,
                      right: AppSpacing.md,
                      bottom: AppSpacing.md,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.calendar_today_outlined,
                                size: 14,
                                color: AppColors.primaryLight,
                              ),
                              const SizedBox(width: AppSpacing.xxs),
                              Text(
                                userMemoryDateLabel(highlight.createdAt),
                                style: AppTypography.caption.copyWith(
                                  color: AppColors.textInverse,
                                ),
                              ),
                              const SizedBox(width: AppSpacing.xs),
                              const Icon(
                                Icons.place_outlined,
                                size: 14,
                                color: AppColors.primaryLight,
                              ),
                              const SizedBox(width: AppSpacing.xxs),
                              Flexible(
                                child: Text(
                                  highlight.tripName,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTypography.caption.copyWith(
                                    color: AppColors.textInverse,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          if (caption != null && caption.isNotEmpty) ...[
                            const SizedBox(height: AppSpacing.xxs),
                            Text(
                              caption,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: AppTypography.bodyMedium.copyWith(
                                color: AppColors.textInverse,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.lg,
                vertical: AppSpacing.sm,
              ),
              child: Row(
                children: [
                  const Spacer(),
                  _CountButton(
                    icon: highlight.liked
                        ? Icons.favorite_rounded
                        : Icons.favorite_border_rounded,
                    color: AppColors.danger,
                    label: '${highlight.likeCount}',
                    onPressed: onLike,
                    semanticLabel: 'Thích kỷ niệm',
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  IconButton(
                    onPressed: onShare,
                    visualDensity: VisualDensity.compact,
                    tooltip: 'Chia sẻ kỷ niệm',
                    icon: const Icon(
                      Icons.share_outlined,
                      size: 18,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GlassTag extends StatelessWidget {
  const _GlassTag({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: AppColors.textPrimary.withValues(alpha: 0.35),
        borderRadius: BorderRadius.circular(AppRadius.pill),
        border: Border.all(
          color: AppColors.textInverse.withValues(alpha: 0.20),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: AppColors.primaryLight),
          const SizedBox(width: AppSpacing.xxs),
          Text(
            label,
            style: AppTypography.badge.copyWith(color: AppColors.textInverse),
          ),
        ],
      ),
    );
  }
}

class _CountButton extends StatelessWidget {
  const _CountButton({
    required this.icon,
    required this.color,
    required this.label,
    required this.onPressed,
    required this.semanticLabel,
  });

  final IconData icon;
  final Color color;
  final String label;
  final VoidCallback onPressed;
  final String semanticLabel;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: semanticLabel,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(AppRadius.pill),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 4),
          child: Row(
            children: [
              Icon(icon, size: 18, color: color),
              const SizedBox(width: 2),
              Text(
                label,
                style: AppTypography.caption.copyWith(
                  color: color,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
