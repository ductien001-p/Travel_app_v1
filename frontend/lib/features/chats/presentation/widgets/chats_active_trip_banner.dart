import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_shadows.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_avatar.dart';
import 'package:travel_frontend_v1/core/widget/app_glass_surface.dart';
import 'package:travel_frontend_v1/core/widget/app_pressable.dart';

import '../../data/models/chats_hub_models.dart';

class ChatsActiveTripBanner extends StatelessWidget {
  const ChatsActiveTripBanner({
    super.key,
    required this.pulse,
    required this.onOpenChat,
  });

  final ChatsActiveTripPulse pulse;
  final VoidCallback onOpenChat;

  @override
  Widget build(BuildContext context) {
    return AppPressable(
      onTap: onOpenChat,
      pressedScale: 0.99,
      borderRadius: BorderRadius.circular(AppRadius.cardLarge),
      child: AppGlassSurface(
        padding: const EdgeInsets.all(AppSpacing.md),
        borderColor: AppColors.primary.withValues(alpha: 0.30),
        child: Stack(
          children: [
            Positioned(
              right: -24,
              top: -24,
              child: IgnorePointer(
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        const Color(0xFF84F5EF).withValues(alpha: 0.28),
                        const Color(0xFF99F2EC).withValues(alpha: 0.08),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primaryLight,
                            borderRadius: BorderRadius.circular(AppRadius.pill),
                            border: Border.all(
                              color: AppColors.primary.withValues(alpha: 0.20),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 6,
                                height: 6,
                                decoration: const BoxDecoration(
                                  color: AppColors.primary,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Flexible(
                                child: Text(
                                  pulse.statusLabel.toUpperCase(),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTypography.badge.copyWith(
                                    color: AppColors.primary,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.xs),
                    _StackedAvatars(
                      urls: pulse.memberAvatars,
                      extra: pulse.extraMemberCount,
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.xs),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Expanded(
                      child: Text(
                        pulse.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTypography.cardTitle.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.xs),
                    Text(
                      '${pulse.onlineMemberCount}/${pulse.memberCapacity} thành viên',
                      style: AppTypography.caption,
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.sm),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceSubdued.withValues(alpha: 0.80),
                    borderRadius: BorderRadius.circular(AppRadius.image),
                    border: Border.all(
                      color: AppColors.borderBrandSoft.withValues(alpha: 0.60),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.push_pin_rounded,
                        size: 18,
                        color: AppColors.primary,
                      ),
                      const SizedBox(width: AppSpacing.xs),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    pulse.pinnedSenderName,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppTypography.caption.copyWith(
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Text(
                                  pulse.pinnedTimeLabel,
                                  style: AppTypography.caption.copyWith(
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 2),
                            Text(
                              pulse.pinnedMessage,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTypography.body.copyWith(
                                fontSize: 13,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Row(
                  children: [
                    const Icon(
                      Icons.mark_chat_unread_rounded,
                      size: 16,
                      color: AppColors.primary,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        '${pulse.newExchangeCount} trao đổi mới',
                        style: AppTypography.caption.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                    DecoratedBox(
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.all(
                          Radius.circular(AppRadius.pill),
                        ),
                        boxShadow: AppShadows.primaryGlow,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 7,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Vào chat ngay',
                              style: AppTypography.caption.copyWith(
                                color: AppColors.textInverse,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(width: 4),
                            const Icon(
                              Icons.arrow_forward_rounded,
                              size: 14,
                              color: AppColors.textInverse,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StackedAvatars extends StatelessWidget {
  const _StackedAvatars({required this.urls, required this.extra});

  final List<String> urls;
  final int extra;

  @override
  Widget build(BuildContext context) {
    final shown = urls.take(3).toList(growable: false);
    return SizedBox(
      height: 24,
      width: 24.0 * shown.length + (extra > 0 ? 20 : 0),
      child: Stack(
        children: [
          for (var i = 0; i < shown.length; i++)
            Positioned(
              left: i * 16.0,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.surface, width: 2),
                ),
                child: AppAvatar(size: 24, imageUrl: shown[i]),
              ),
            ),
          if (extra > 0)
            Positioned(
              left: shown.length * 16.0,
              child: Container(
                width: 24,
                height: 24,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color(0xFF99F2EC),
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.surface, width: 2),
                ),
                child: Text(
                  '+$extra',
                  style: AppTypography.badge.copyWith(
                    fontSize: 10,
                    color: const Color(0xFF00201F),
                    letterSpacing: 0,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
