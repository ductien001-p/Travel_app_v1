import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_avatar.dart';
import 'package:travel_frontend_v1/core/widget/app_icon_button.dart';
import 'package:travel_frontend_v1/core/widget/app_pressable.dart';

class ExploreGreetingHeader extends StatelessWidget {
  const ExploreGreetingHeader({
    super.key,
    required this.displayName,
    required this.locationLabel,
    this.avatarUrl,
    this.hasUnreadNotifications = false,
    this.onAvatarTap,
    this.onNotificationsTap,
    this.onSearchTap,
  });

  final String displayName;
  final String locationLabel;
  final String? avatarUrl;
  final bool hasUnreadNotifications;
  final VoidCallback? onAvatarTap;
  final VoidCallback? onNotificationsTap;
  final VoidCallback? onSearchTap;

  @override
  Widget build(BuildContext context) {
    final initials = displayName.isNotEmpty
        ? displayName.characters.first.toUpperCase()
        : '?';

    return Row(
      children: [
        AppPressable(
          onTap: onAvatarTap,
          borderRadius: BorderRadius.circular(28),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              AppAvatar(size: 44, imageUrl: avatarUrl, initials: initials),
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: AppColors.success,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.surface, width: 2),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Xin chào, $displayName 🌿',
                style: AppTypography.sectionTitle.copyWith(fontSize: 18),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              if (locationLabel.trim().isNotEmpty) ...[
                const SizedBox(height: 2),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on_rounded,
                      size: 15,
                      color: AppColors.primary,
                    ),
                    const SizedBox(width: 2),
                    Expanded(
                      child: Text(
                        locationLabel,
                        style: AppTypography.caption.copyWith(
                          color: AppColors.textSecondary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
        if (onNotificationsTap != null)
          Stack(
            clipBehavior: Clip.none,
            children: [
              AppIconButton(
                icon: Icons.notifications_outlined,
                onPressed: onNotificationsTap,
                semanticLabel: 'Thông báo',
                iconColor: AppColors.textPrimary,
              ),
              if (hasUnreadNotifications)
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: AppColors.danger,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.surface, width: 2),
                    ),
                  ),
                ),
            ],
          ),
        if (onSearchTap != null) ...[
          const SizedBox(width: AppSpacing.xxs),
          AppIconButton(
            icon: Icons.search_rounded,
            onPressed: onSearchTap,
            semanticLabel: 'Tìm kiếm',
            iconColor: AppColors.primary,
          ),
        ],
      ],
    );
  }
}
