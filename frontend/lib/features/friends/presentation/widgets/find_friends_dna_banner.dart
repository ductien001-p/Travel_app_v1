import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_avatar.dart';
import 'package:travel_frontend_v1/core/widget/app_pressable.dart';

import '../../data/models/find_friends_models.dart';

class FindFriendsDnaBannerCard extends StatelessWidget {
  const FindFriendsDnaBannerCard({
    super.key,
    required this.banner,
    required this.onScan,
  });

  final FindFriendsDnaBanner banner;
  final VoidCallback onScan;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.cardLarge),
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            AppColors.primaryLight,
            AppColors.surface,
            Color(0xFFE0F8F6),
          ],
        ),
        border: Border.all(color: AppColors.primary12),
        boxShadow: const [
          BoxShadow(
            color: AppColors.marine08,
            blurRadius: 24,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppRadius.image),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [AppColors.primary, AppColors.primaryActive],
              ),
            ),
            child: const Icon(
              Icons.explore_rounded,
              color: AppColors.textInverse,
              size: 26,
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primary08,
                        borderRadius: BorderRadius.circular(AppRadius.pill),
                      ),
                      child: Text(
                        banner.badgeLabel,
                        style: AppTypography.caption.copyWith(
                          color: AppColors.primaryActive,
                          fontWeight: FontWeight.w800,
                          fontSize: 10,
                          letterSpacing: 0.6,
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Text('✨', style: TextStyle(fontSize: 12)),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  banner.title,
                  style: AppTypography.cardTitle.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  banner.subtitle,
                  style: AppTypography.caption.copyWith(
                    color: AppColors.textSecondary,
                    height: 1.35,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Row(
                  children: [
                    _AvatarStack(
                      urls: banner.previewAvatars,
                      extraCount: banner.extraCount,
                    ),
                    const Spacer(),
                    AppPressable(
                      onTap: onScan,
                      borderRadius: BorderRadius.circular(AppRadius.pill),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(AppRadius.pill),
                          boxShadow: const [
                            BoxShadow(
                              color: AppColors.primary38,
                              blurRadius: 16,
                              offset: Offset(0, 6),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.radar_rounded,
                              size: 15,
                              color: AppColors.textInverse,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              banner.ctaLabel,
                              style: AppTypography.caption.copyWith(
                                color: AppColors.textInverse,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AvatarStack extends StatelessWidget {
  const _AvatarStack({required this.urls, required this.extraCount});

  final List<String> urls;
  final int extraCount;

  @override
  Widget build(BuildContext context) {
    final shown = urls.take(3).toList(growable: false);
    return SizedBox(
      height: 28,
      width: 28.0 * shown.length + (extraCount > 0 ? 20 : 0),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          for (var i = 0; i < shown.length; i++)
            Positioned(
              left: i * 18.0,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.surface, width: 2),
                ),
                child: AppAvatar(size: 24, imageUrl: shown[i]),
              ),
            ),
          if (extraCount > 0)
            Positioned(
              left: shown.length * 18.0,
              child: Container(
                width: 28,
                height: 28,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.surface, width: 2),
                ),
                child: Text(
                  '+$extraCount',
                  style: AppTypography.caption.copyWith(
                    color: AppColors.primaryActive,
                    fontWeight: FontWeight.w800,
                    fontSize: 10,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
