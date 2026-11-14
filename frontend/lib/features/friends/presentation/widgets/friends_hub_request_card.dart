import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_avatar.dart';
import 'package:travel_frontend_v1/core/widget/app_pressable.dart';

import '../../application/friends_hub_view.dart';
import '../../data/models/friends_hub_models.dart';

class FriendsHubRequestCard extends StatelessWidget {
  const FriendsHubRequestCard({
    super.key,
    required this.request,
    required this.busy,
    required this.onAccept,
    required this.onReject,
    this.showReject = true,
    this.secondaryLabel = 'Từ chối',
  });

  final FriendsHubRequest request;
  final bool busy;
  final VoidCallback onAccept;
  final VoidCallback onReject;
  final bool showReject;
  final String secondaryLabel;

  @override
  Widget build(BuildContext context) {
    final user = request.user;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.glass90,
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(color: AppColors.glassBorder),
        boxShadow: const [
          BoxShadow(
            color: AppColors.black03,
            blurRadius: 16,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  AppAvatar(
                    size: 52,
                    imageUrl: user.avatarUrl,
                    initials: _initials(user.displayName),
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
                          border: Border.all(
                            color: AppColors.surface,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            user.displayName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTypography.cardTitle,
                          ),
                        ),
                        Text(
                          friendsHubRelativeTime(request.createdAt),
                          style: AppTypography.caption.copyWith(
                            color: AppColors.textTertiary,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '@${user.username}',
                      style: AppTypography.caption.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    if ((user.metaLine ?? '').isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            _metaIcon(user.metaIcon),
                            size: 15,
                            color: AppColors.primary,
                          ),
                          const SizedBox(width: 6),
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
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              Expanded(
                child: _ActionButton(
                  label: 'Chấp nhận',
                  icon: Icons.check_rounded,
                  primary: true,
                  enabled: !busy,
                  onTap: onAccept,
                ),
              ),
              if (showReject) ...[
                const SizedBox(width: AppSpacing.xs),
                Expanded(
                  child: _ActionButton(
                    label: secondaryLabel,
                    icon: Icons.close_rounded,
                    primary: false,
                    enabled: !busy,
                    onTap: onReject,
                  ),
                ),
              ],
            ],
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
      'groups' => Icons.groups_rounded,
      'hiking' => Icons.hiking_rounded,
      'group' => Icons.group_rounded,
      _ => Icons.favorite_outline_rounded,
    };
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.label,
    required this.icon,
    required this.primary,
    required this.enabled,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool primary;
  final bool enabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: enabled ? 1 : 0.6,
      child: AppPressable(
        onTap: enabled ? onTap : null,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: primary ? AppColors.primary : AppColors.surfaceSubdued,
            borderRadius: BorderRadius.circular(AppRadius.pill),
            border: primary ? null : Border.all(color: AppColors.borderNeutral),
            boxShadow: primary
                ? const [
                    BoxShadow(
                      color: AppColors.primary38,
                      blurRadius: 18,
                      offset: Offset(0, 8),
                    ),
                  ]
                : null,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 18,
                color: primary
                    ? AppColors.textInverse
                    : AppColors.textSecondary,
              ),
              const SizedBox(width: 6),
              Text(
                label,
                style: AppTypography.bodyMedium.copyWith(
                  color: primary
                      ? AppColors.textInverse
                      : AppColors.textSecondary,
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
