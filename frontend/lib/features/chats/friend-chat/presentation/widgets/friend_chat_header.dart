import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_avatar.dart';
import 'package:travel_frontend_v1/core/widget/app_icon_button.dart';

import '../../data/models/friend_chat_models.dart';

class FriendChatHeader extends StatelessWidget {
  const FriendChatHeader({
    super.key,
    required this.peer,
    required this.onBack,
    required this.onInfo,
  });

  final FriendChatPeer peer;
  final VoidCallback onBack;
  final VoidCallback onInfo;

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
        child: Container(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.sm,
            AppSpacing.xs,
            AppSpacing.sm,
            AppSpacing.sm,
          ),
          decoration: BoxDecoration(
            color: AppColors.glass85,
            boxShadow: [
              BoxShadow(
                color: AppColors.primary08,
                blurRadius: 20,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              AppIconButton(
                icon: Icons.arrow_back_rounded,
                onPressed: onBack,
                semanticLabel: 'Quay lại',
                iconColor: AppColors.textPrimary,
                backgroundColor: AppColors.glass90,
              ),
              const SizedBox(width: AppSpacing.xs),
              Expanded(
                child: Row(
                  children: [
                    SizedBox(
                      width: 44,
                      height: 44,
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          AppAvatar(
                            size: 44,
                            imageUrl: peer.avatarUrl,
                            initials: _initials(peer.displayName),
                          ),
                          if (peer.isOnline)
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
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Flexible(
                                child: Text(
                                  peer.displayName,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTypography.cardTitle.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                              ),
                              if (peer.roleBadge != null) ...[
                                const SizedBox(width: 6),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 6,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryLight,
                                    borderRadius: BorderRadius.circular(999),
                                    border: Border.all(
                                      color: AppColors.borderBrandSoft,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(
                                        Icons.verified_rounded,
                                        size: 12,
                                        color: AppColors.primary,
                                      ),
                                      const SizedBox(width: 2),
                                      Text(
                                        peer.roleBadge!,
                                        style: AppTypography.badge.copyWith(
                                          color: AppColors.primary,
                                          fontSize: 10,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ],
                          ),
                          const SizedBox(height: 2),
                          Row(
                            children: [
                              if (peer.isOnline) ...[
                                Container(
                                  width: 6,
                                  height: 6,
                                  decoration: const BoxDecoration(
                                    color: AppColors.success,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 4),
                              ],
                              Flexible(
                                child: Text(
                                  [
                                    if (peer.presenceLabel != null)
                                      peer.presenceLabel!,
                                    if (peer.sharedTripsLabel != null)
                                      peer.sharedTripsLabel!,
                                  ].join(' • '),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTypography.caption.copyWith(
                                    color: peer.isOnline
                                        ? AppColors.success
                                        : AppColors.textTertiary,
                                    fontWeight: FontWeight.w500,
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
              ),
              AppIconButton(
                icon: Icons.info_outline_rounded,
                onPressed: onInfo,
                semanticLabel: 'Thông tin hội thoại',
                iconColor: AppColors.textPrimary,
                backgroundColor: Colors.transparent,
              ),
            ],
          ),
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
