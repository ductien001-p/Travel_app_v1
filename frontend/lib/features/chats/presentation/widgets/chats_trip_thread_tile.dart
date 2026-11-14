import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_glass_surface.dart';
import 'package:travel_frontend_v1/core/widget/app_pressable.dart';

import '../../application/chats_hub_view.dart';
import '../../data/models/chats_hub_models.dart';

class ChatsTripThreadTile extends StatelessWidget {
  const ChatsTripThreadTile({
    super.key,
    required this.thread,
    required this.onTap,
  });

  final ChatsTripThread thread;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final completed = thread.status == ChatsTripThreadStatus.completed;
    final unread = thread.unreadCount > 0;

    return Opacity(
      opacity: completed ? 0.85 : 1,
      child: AppPressable(
        onTap: onTap,
        pressedScale: 0.99,
        borderRadius: BorderRadius.circular(AppRadius.cardLarge),
        child: AppGlassSurface(
          padding: const EdgeInsets.all(14),
          borderColor: thread.emphasize
              ? AppColors.primary
              : AppColors.glassBorder,
          child: DecoratedBox(
            decoration: thread.emphasize
                ? const BoxDecoration(
                    border: Border(
                      left: BorderSide(color: AppColors.primary, width: 4),
                    ),
                  )
                : const BoxDecoration(),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (thread.emphasize) const SizedBox(width: 8),
                _Cover(url: thread.coverUrl, badgeIcon: thread.badgeIcon),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              thread.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTypography.cardTitle.copyWith(
                                fontSize: 15,
                                fontWeight: unread
                                    ? FontWeight.w700
                                    : FontWeight.w600,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            thread.timeLabel,
                            style: AppTypography.caption.copyWith(
                              color: unread
                                  ? AppColors.primary
                                  : AppColors.textTertiary,
                              fontWeight: unread
                                  ? FontWeight.w700
                                  : FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          _StatusTag(status: thread.status),
                          const SizedBox(width: 8),
                          Flexible(
                            child: Text(
                              '• ${thread.memberLabel}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTypography.caption.copyWith(
                                fontSize: 11,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Expanded(
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: '${thread.lastSenderName}: ',
                                    style: AppTypography.body.copyWith(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                  TextSpan(
                                    text: thread.lastMessage,
                                    style: AppTypography.body.copyWith(
                                      fontSize: 13,
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                ],
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (unread) ...[
                            const SizedBox(width: 8),
                            Container(
                              width: 20,
                              height: 20,
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                color: AppColors.primary,
                                shape: BoxShape.circle,
                              ),
                              child: Text(
                                '${thread.unreadCount}',
                                style: AppTypography.badge.copyWith(
                                  fontSize: 11,
                                  color: AppColors.textInverse,
                                  letterSpacing: 0,
                                ),
                              ),
                            ),
                          ] else if (thread.isReadReceipt) ...[
                            const SizedBox(width: 8),
                            const Icon(
                              Icons.done_all_rounded,
                              size: 18,
                              color: AppColors.primary,
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Cover extends StatelessWidget {
  const _Cover({required this.url, required this.badgeIcon});

  final String url;
  final String badgeIcon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 48,
      height: 48,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(AppRadius.image),
            child: ColoredBox(
              color: AppColors.primaryLight,
              child: Image.network(
                url,
                width: 48,
                height: 48,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => const ColoredBox(
                  color: AppColors.primaryLight,
                  child: Icon(
                    Icons.landscape_rounded,
                    color: AppColors.primary,
                    size: 22,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            right: -4,
            bottom: -4,
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: _badgeColor(badgeIcon),
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.surface, width: 2),
              ),
              child: Icon(
                _badgeIconData(badgeIcon),
                size: 11,
                color: AppColors.textInverse,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _badgeColor(String icon) {
    if (icon == 'task_alt') return AppColors.textTertiary;
    if (icon == 'sailing') return const Color(0xFF006A66);
    return AppColors.primary;
  }

  IconData _badgeIconData(String icon) => switch (icon) {
    'sailing' => Icons.sailing_rounded,
    'hiking' => Icons.hiking_rounded,
    'task_alt' => Icons.task_alt_rounded,
    _ => Icons.landscape_rounded,
  };
}

class _StatusTag extends StatelessWidget {
  const _StatusTag({required this.status});

  final ChatsTripThreadStatus status;

  @override
  Widget build(BuildContext context) {
    final (bg, fg) = switch (status) {
      ChatsTripThreadStatus.ongoing => (
        AppColors.primaryLight,
        AppColors.primary,
      ),
      ChatsTripThreadStatus.upcoming => (
        const Color(0xFF99F2EC).withValues(alpha: 0.30),
        const Color(0xFF00504D),
      ),
      ChatsTripThreadStatus.completed => (
        AppColors.surfaceSubdued,
        AppColors.textSecondary,
      ),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        chatsTripStatusLabel(status),
        style: AppTypography.caption.copyWith(
          fontSize: 10.5,
          fontWeight: FontWeight.w600,
          color: fg,
          letterSpacing: 0,
        ),
      ),
    );
  }
}
