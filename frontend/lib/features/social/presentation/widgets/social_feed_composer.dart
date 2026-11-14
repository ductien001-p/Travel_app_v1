import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_shadows.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_avatar.dart';
import 'package:travel_frontend_v1/core/widget/app_pressable.dart';

import '../../data/models/social_feed_models.dart';

class SocialFeedComposerCard extends StatelessWidget {
  const SocialFeedComposerCard({
    super.key,
    required this.composer,
    this.onComposeTap,
    this.onPhotoTap,
    this.onCheckInTap,
    this.onInviteTap,
  });

  final SocialFeedComposer composer;
  final VoidCallback? onComposeTap;
  final VoidCallback? onPhotoTap;
  final VoidCallback? onCheckInTap;
  final VoidCallback? onInviteTap;

  @override
  Widget build(BuildContext context) {
    final initials = composer.displayName.isNotEmpty
        ? composer.displayName.characters.first.toUpperCase()
        : '?';

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppSpacing.screenHorizontal,
      ),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.glass90,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.15)),
        boxShadow: AppShadows.level1,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  AppAvatar(
                    size: 40,
                    imageUrl: composer.avatarUrl,
                    initials: initials,
                  ),
                  Positioned(
                    right: -2,
                    bottom: -2,
                    child: Container(
                      width: 14,
                      height: 14,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                      child: const Text('✨', style: TextStyle(fontSize: 8)),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: AppPressable(
                  onTap: onComposeTap,
                  borderRadius: BorderRadius.circular(AppRadius.pill),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceSubdued,
                      borderRadius: BorderRadius.circular(AppRadius.pill),
                      border: Border.all(color: AppColors.borderNeutral),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            composer.prompt,
                            style: AppTypography.bodyMedium.copyWith(
                              fontSize: 13,
                              color: AppColors.textSecondary,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const Icon(
                          Icons.edit_note_rounded,
                          size: 20,
                          color: AppColors.primary,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          const Divider(height: 1, color: AppColors.borderNeutral),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              Expanded(
                child: _ComposerAction(
                  icon: Icons.photo_camera_rounded,
                  iconColor: AppColors.primary,
                  label: 'Ảnh/Video HD',
                  onTap: onPhotoTap,
                ),
              ),
              Container(width: 1, height: 14, color: AppColors.borderNeutral),
              Expanded(
                child: _ComposerAction(
                  icon: Icons.stars_rounded,
                  iconColor: AppColors.warning,
                  label: 'Check-in nhận xu',
                  onTap: onCheckInTap,
                ),
              ),
              Container(width: 1, height: 14, color: AppColors.borderNeutral),
              Expanded(
                child: _ComposerAction(
                  icon: Icons.group_add_rounded,
                  iconColor: AppColors.primary,
                  label: 'Rủ bạn vi vu',
                  onTap: onInviteTap,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ComposerAction extends StatelessWidget {
  const _ComposerAction({
    required this.icon,
    required this.iconColor,
    required this.label,
    this.onTap,
  });

  final IconData icon;
  final Color iconColor;
  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return AppPressable(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.pill),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 16, color: iconColor),
            const SizedBox(width: 4),
            Flexible(
              child: Text(
                label,
                style: AppTypography.caption.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.textSecondary,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
