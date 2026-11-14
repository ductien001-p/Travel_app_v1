import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_avatar.dart';
import 'package:travel_frontend_v1/core/widget/app_pressable.dart';

import '../../application/find_friends_view.dart';
import '../../data/models/find_friends_models.dart';

class FindFriendsResultCard extends StatelessWidget {
  const FindFriendsResultCard({
    super.key,
    required this.user,
    required this.busy,
    required this.onAction,
  });

  final FindFriendsUser user;
  final bool busy;
  final VoidCallback onAction;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.glass90,
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(color: AppColors.glassBorder),
        boxShadow: const [
          BoxShadow(
            color: AppColors.marine08,
            blurRadius: 20,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Avatar(user: user),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Flexible(
                                child: Text(
                                  user.displayName,
                                  style: AppTypography.cardTitle,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              if (user.verified) ...[
                                const SizedBox(width: 4),
                                const Icon(
                                  Icons.check_circle_rounded,
                                  size: 15,
                                  color: AppColors.primary,
                                ),
                              ],
                            ],
                          ),
                          Text(
                            '@${user.username}',
                            style: AppTypography.caption.copyWith(
                              color: AppColors.textTertiary,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 6),
                    Flexible(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: _ActionButton(
                          action: user.action,
                          busy: busy,
                          onPressed: onAction,
                        ),
                      ),
                    ),
                  ],
                ),
                if (user.badges.isNotEmpty) ...[
                  const SizedBox(height: AppSpacing.xs),
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: [
                      for (final badge in user.badges) _BadgeChip(badge: badge),
                    ],
                  ),
                ],
                if ((user.metaLine ?? '').isNotEmpty) ...[
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Icon(
                        _metaIcon(user.metaIcon),
                        size: 14,
                        color: user.metaIcon == 'luggage'
                            ? AppColors.primary
                            : AppColors.textTertiary,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          user.metaLine!,
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
        ],
      ),
    );
  }

  IconData _metaIcon(String? name) => switch (name) {
    'group' => Icons.group_rounded,
    'location_on' => Icons.location_on_rounded,
    'luggage' => Icons.luggage_rounded,
    'diversity_1' => Icons.diversity_3_rounded,
    _ => Icons.info_outline_rounded,
  };
}

class _Avatar extends StatelessWidget {
  const _Avatar({required this.user});

  final FindFriendsUser user;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 48,
      height: 48,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: user.verified
                    ? const Color(0xFF99F2EC)
                    : AppColors.primaryLight,
                width: 2,
              ),
            ),
            child: AppAvatar(
              size: 44,
              imageUrl: user.avatarUrl,
              initials: user.displayName.isNotEmpty
                  ? user.displayName.characters.first
                  : '?',
              verified: false,
            ),
          ),
          if (user.isOnline)
            Positioned(
              right: -1,
              bottom: -1,
              child: Container(
                width: 14,
                height: 14,
                decoration: BoxDecoration(
                  color: AppColors.success,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.surface, width: 2),
                ),
              ),
            )
          else if (user.verified)
            Positioned(
              right: -1,
              bottom: -1,
              child: Container(
                width: 16,
                height: 16,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color(0xFF66D8D2),
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.surface, width: 2),
                ),
                child: const Icon(
                  Icons.verified_rounded,
                  size: 10,
                  color: AppColors.primaryActive,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.action,
    required this.busy,
    required this.onPressed,
  });

  final FindFriendsAction action;
  final bool busy;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final enabled = !busy;
    final (bg, fg, border, icon) = switch (action) {
      FindFriendsAction.addFriend => (
        AppColors.primary,
        AppColors.textInverse,
        Colors.transparent,
        Icons.person_add_alt_1_rounded,
      ),
      FindFriendsAction.requestSent => (
        AppColors.surfaceSubdued,
        AppColors.textSecondary,
        AppColors.borderNeutral,
        Icons.person_remove_alt_1_rounded,
      ),
      FindFriendsAction.message => (
        AppColors.primaryLight,
        AppColors.primaryActive,
        Colors.transparent,
        Icons.chat_bubble_outline_rounded,
      ),
      FindFriendsAction.follow => (
        AppColors.surface,
        AppColors.primary,
        AppColors.primary,
        Icons.add_rounded,
      ),
      FindFriendsAction.following => (
        AppColors.surfaceSubdued,
        AppColors.textSecondary,
        AppColors.borderNeutral,
        Icons.check_rounded,
      ),
    };

    return AppPressable(
      onTap: enabled ? onPressed : null,
      borderRadius: BorderRadius.circular(AppRadius.pill),
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 150),
        opacity: busy ? 0.7 : 1,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(AppRadius.pill),
            border: Border.all(color: border),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (busy)
                SizedBox(
                  width: 14,
                  height: 14,
                  child: CircularProgressIndicator(strokeWidth: 2, color: fg),
                )
              else
                Icon(icon, size: 15, color: fg),
              const SizedBox(width: 4),
              Text(
                findFriendsActionLabel(action),
                style: AppTypography.caption.copyWith(
                  color: fg,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BadgeChip extends StatelessWidget {
  const _BadgeChip({required this.badge});

  final FindFriendsBadge badge;

  @override
  Widget build(BuildContext context) {
    final (bg, fg, border) = switch (badge.tone) {
      FindFriendsBadgeTone.amber => (
        const Color(0xFFFFFBEB),
        const Color(0xFF92400E),
        const Color(0xFFFDE68A),
      ),
      FindFriendsBadgeTone.teal => (
        const Color(0xFFF0FDFA),
        const Color(0xFF115E59),
        const Color(0xFF99F6E4),
      ),
      FindFriendsBadgeTone.indigo => (
        const Color(0xFFEEF2FF),
        const Color(0xFF4338CA),
        const Color(0xFFC7D2FE),
      ),
      FindFriendsBadgeTone.rose => (
        const Color(0xFFFFF1F2),
        const Color(0xFF9F1239),
        const Color(0xFFFECDD3),
      ),
      FindFriendsBadgeTone.primary => (
        AppColors.primaryLight,
        AppColors.primaryActive,
        Colors.transparent,
      ),
      FindFriendsBadgeTone.primarySoft => (
        AppColors.primary08,
        AppColors.primaryActive,
        Colors.transparent,
      ),
      FindFriendsBadgeTone.subdued => (
        AppColors.surfaceSubdued,
        AppColors.textSecondary,
        Colors.transparent,
      ),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(AppRadius.pill),
        border: Border.all(color: border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (badge.icon != null) ...[
            Icon(_badgeIcon(badge.icon!), size: 12, color: fg),
            const SizedBox(width: 3),
          ],
          Text(
            badge.label,
            style: AppTypography.badge.copyWith(
              color: fg,
              fontWeight: FontWeight.w600,
              letterSpacing: 0,
            ),
          ),
        ],
      ),
    );
  }

  IconData _badgeIcon(String name) => switch (name) {
    'hiking' => Icons.hiking_rounded,
    'bolt' => Icons.bolt_rounded,
    'how_to_reg' => Icons.how_to_reg_rounded,
    _ => Icons.label_rounded,
  };
}
