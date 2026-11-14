import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_avatar.dart';
import 'package:travel_frontend_v1/core/widget/app_pressable.dart';

import '../../data/models/friends_hub_models.dart';

class FriendsHubFriendTile extends StatelessWidget {
  const FriendsHubFriendTile({
    super.key,
    required this.friend,
    required this.busy,
    required this.onMessage,
    required this.onMore,
  });

  final FriendsHubFriend friend;
  final bool busy;
  final VoidCallback onMessage;
  final VoidCallback onMore;

  @override
  Widget build(BuildContext context) {
    final user = friend.user;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.glass90,
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(color: AppColors.glassBorder),
        boxShadow: const [
          BoxShadow(
            color: AppColors.black03,
            blurRadius: 14,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Stack(
            children: [
              AppAvatar(
                size: 48,
                imageUrl: user.avatarUrl,
                initials: _initials(user.displayName),
                verified: user.verified,
              ),
              if (user.isOnline)
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: 14,
                    height: 14,
                    decoration: BoxDecoration(
                      color: AppColors.success,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.surface, width: 2),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.displayName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.cardTitle,
                ),
                Text(
                  [
                    '@${user.username}',
                    if ((user.subtitle ?? '').isNotEmpty) user.subtitle!,
                  ].join(' • '),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.caption.copyWith(
                    color: AppColors.textTertiary,
                  ),
                ),
                if ((user.badgeLabel ?? '').isNotEmpty) ...[
                  const SizedBox(height: 4),
                  _Badge(user: user),
                ] else if ((user.metaLine ?? '').isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        _metaIcon(user.metaIcon),
                        size: 13,
                        color: AppColors.primary,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          user.metaLine!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTypography.caption.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.xs),
          Opacity(
            opacity: busy ? 0.6 : 1,
            child: AppPressable(
              onTap: busy ? null : onMessage,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(AppRadius.pill),
                ),
                child: const Icon(
                  Icons.chat_bubble_rounded,
                  size: 16,
                  color: AppColors.textInverse,
                ),
              ),
            ),
          ),
          const SizedBox(width: 6),
          AppPressable(
            onTap: busy ? null : onMore,
            child: Container(
              width: 36,
              height: 36,
              decoration: const BoxDecoration(
                color: AppColors.surfaceSubdued,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.more_vert_rounded,
                size: 18,
                color: AppColors.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  static String _initials(String name) {
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty || parts.first.isEmpty) return '?';
    if (parts.length == 1) return parts.first[0].toUpperCase();
    return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
  }

  static IconData _metaIcon(String? raw) {
    return switch (raw) {
      'connecting_airports' => Icons.connecting_airports_rounded,
      'psychology' => Icons.psychology_rounded,
      'pin_drop' => Icons.pin_drop_rounded,
      'group' => Icons.group_rounded,
      _ => Icons.info_outline_rounded,
    };
  }
}

class _Badge extends StatelessWidget {
  const _Badge({required this.user});

  final FriendsHubUser user;

  @override
  Widget build(BuildContext context) {
    final (bg, fg) = switch (user.badgeTone) {
      FriendsHubBadgeTone.primary => (
        AppColors.primaryLight,
        AppColors.primary,
      ),
      FriendsHubBadgeTone.secondary => (
        const Color(0x8099F2EC),
        const Color(0xFF00716D),
      ),
      FriendsHubBadgeTone.info => (const Color(0xFFD8E2FF), AppColors.info),
      FriendsHubBadgeTone.subdued => (
        AppColors.surfaceSubdued,
        AppColors.textSecondary,
      ),
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if ((user.metaIcon ?? '').isNotEmpty) ...[
            Icon(
              FriendsHubFriendTile._metaIcon(user.metaIcon),
              size: 12,
              color: fg,
            ),
            const SizedBox(width: 4),
          ],
          Flexible(
            child: Text(
              user.badgeLabel!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTypography.badge.copyWith(color: fg),
            ),
          ),
        ],
      ),
    );
  }
}
