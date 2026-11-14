import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_icon_button.dart';
import 'package:travel_frontend_v1/core/widget/app_pressable.dart';

import '../../data/models/social_feed_models.dart';

class SocialFeedTopBar extends StatelessWidget {
  const SocialFeedTopBar({
    super.key,
    required this.header,
    this.onSearchTap,
    this.onNotificationsTap,
    this.onFriendsTap,
  });

  final SocialFeedHeader header;
  final VoidCallback? onSearchTap;
  final VoidCallback? onNotificationsTap;
  final VoidCallback? onFriendsTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.screenHorizontal,
        AppSpacing.sm,
        AppSpacing.screenHorizontal,
        AppSpacing.xs,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(header.title, style: AppTypography.screenTitle),
                const SizedBox(height: 2),
                Row(
                  children: [
                    const Icon(
                      Icons.local_fire_department_rounded,
                      size: 14,
                      color: AppColors.warning,
                    ),
                    const SizedBox(width: 4),
                    Flexible(
                      child: Text(
                        header.streakLabel,
                        style: AppTypography.caption.copyWith(
                          color: AppColors.warning,
                          fontWeight: FontWeight.w700,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          AppIconButton(
            icon: Icons.search_rounded,
            onPressed: onSearchTap,
            semanticLabel: 'Tìm kiếm',
          ),
          const SizedBox(width: AppSpacing.xxs),
          Stack(
            clipBehavior: Clip.none,
            children: [
              AppIconButton(
                icon: Icons.notifications_none_rounded,
                onPressed: onNotificationsTap,
                semanticLabel: 'Thông báo',
              ),
              if (header.hasUnreadNotifications)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: AppColors.danger,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.surface, width: 1.5),
                    ),
                  ),
                ),
            ],
          ),
          if (header.showFriendsCta) ...[
            const SizedBox(width: AppSpacing.xs),
            AppPressable(
              onTap: onFriendsTap,
              borderRadius: BorderRadius.circular(AppRadius.pill),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm,
                  vertical: AppSpacing.xs,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(AppRadius.pill),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.group_rounded,
                      size: 16,
                      color: AppColors.textInverse,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Bạn bè',
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
        ],
      ),
    );
  }
}
