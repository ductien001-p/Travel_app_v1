import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_shadows.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';

import '../../data/models/friend_chat_models.dart';

class FriendChatTextBubble extends StatelessWidget {
  const FriendChatTextBubble({super.key, required this.message});

  final FriendChatMessage message;

  @override
  Widget build(BuildContext context) {
    final isMine = message.isMine;
    final radius = BorderRadius.only(
      topLeft: const Radius.circular(AppRadius.card),
      topRight: const Radius.circular(AppRadius.card),
      bottomLeft: Radius.circular(isMine ? AppRadius.card : 6),
      bottomRight: Radius.circular(isMine ? 6 : AppRadius.card),
    );

    return Container(
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 10),
      decoration: BoxDecoration(
        color: isMine ? AppColors.primary : AppColors.surface,
        borderRadius: radius,
        border: isMine ? null : Border.all(color: AppColors.glassBorder),
        boxShadow: isMine ? AppShadows.primaryGlow : AppShadows.level1,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            message.text ?? '',
            style: AppTypography.body.copyWith(
              color: isMine ? AppColors.textInverse : AppColors.textPrimary,
              height: 1.45,
            ),
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                message.timeLabel,
                style: AppTypography.caption.copyWith(
                  fontSize: 11,
                  color: isMine
                      ? AppColors.textInverse.withValues(alpha: 0.8)
                      : AppColors.textTertiary,
                ),
              ),
              if (isMine && message.readStatus != null) ...[
                const SizedBox(width: 4),
                Icon(
                  Icons.done_all_rounded,
                  size: 14,
                  color: const Color(0xFF84F5EF),
                ),
                if (message.readStatus == FriendChatReadStatus.read) ...[
                  const SizedBox(width: 2),
                  Text(
                    'Đã xem',
                    style: AppTypography.caption.copyWith(
                      fontSize: 11,
                      color: const Color(0xFF84F5EF),
                    ),
                  ),
                ],
              ],
            ],
          ),
        ],
      ),
    );
  }
}
