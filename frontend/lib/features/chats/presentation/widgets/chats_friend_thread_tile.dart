import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_avatar.dart';
import 'package:travel_frontend_v1/core/widget/app_glass_surface.dart';
import 'package:travel_frontend_v1/core/widget/app_pressable.dart';

import '../../data/models/chats_hub_models.dart';

class ChatsFriendThreadTile extends StatelessWidget {
  const ChatsFriendThreadTile({
    super.key,
    required this.thread,
    required this.onTap,
  });

  final ChatsFriendThread thread;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AppPressable(
      onTap: onTap,
      pressedScale: 0.99,
      borderRadius: BorderRadius.circular(AppRadius.cardLarge),
      child: AppGlassSurface(
        padding: const EdgeInsets.all(AppSpacing.sm),
        child: Row(
          children: [
            SizedBox(
              width: 48,
              height: 48,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  AppAvatar(
                    size: 48,
                    imageUrl: thread.avatarUrl,
                    initials: _initials(thread.displayName),
                  ),
                  if (thread.isOnline)
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        width: 12,
                        height: 12,
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
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Flexible(
                              child: Text(
                                thread.displayName,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppTypography.cardTitle.copyWith(
                                  fontSize: 14.5,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                            ),
                            if (thread.roleBadge != null) ...[
                              const SizedBox(width: 6),
                              _RoleBadge(
                                label: thread.roleBadge!,
                                tone: thread.roleTone,
                              ),
                            ],
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        thread.timeLabel,
                        style: AppTypography.caption.copyWith(
                          fontSize: 11.5,
                          color: thread.timeEmphasized
                              ? AppColors.primary
                              : AppColors.textTertiary,
                          fontWeight: thread.timeEmphasized
                              ? FontWeight.w600
                              : FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    thread.lastMessage,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.body.copyWith(
                      fontSize: 13,
                      color: thread.isOnline
                          ? AppColors.textSecondary
                          : AppColors.textTertiary,
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

  String _initials(String name) {
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty || parts.first.isEmpty) return '?';
    if (parts.length == 1) return parts.first[0].toUpperCase();
    final a = parts.first[0];
    final b = parts.last.isEmpty ? '' : parts.last[0];
    return '$a$b'.toUpperCase();
  }
}

class _RoleBadge extends StatelessWidget {
  const _RoleBadge({required this.label, required this.tone});

  final String label;
  final ChatsFriendRoleTone? tone;

  @override
  Widget build(BuildContext context) {
    final primary = tone != ChatsFriendRoleTone.secondary;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: primary
            ? AppColors.primaryLight
            : const Color(0xFF99F2EC).withValues(alpha: 0.40),
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
      child: Text(
        label,
        style: AppTypography.badge.copyWith(
          fontSize: 9.5,
          letterSpacing: 0,
          color: primary ? AppColors.primary : const Color(0xFF00504D),
        ),
      ),
    );
  }
}
