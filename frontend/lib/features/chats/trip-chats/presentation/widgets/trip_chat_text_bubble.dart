import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_shadows.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';

import '../../data/models/trip_chat_models.dart';

class TripChatTextBubble extends StatelessWidget {
  const TripChatTextBubble({super.key, required this.message});

  final TripChatMessage message;

  @override
  Widget build(BuildContext context) {
    final isMine = message.isMine;
    final radius = BorderRadius.only(
      topLeft: const Radius.circular(AppRadius.card),
      topRight: const Radius.circular(AppRadius.card),
      bottomLeft: Radius.circular(isMine ? AppRadius.card : 6),
      bottomRight: Radius.circular(isMine ? 6 : AppRadius.card),
    );

    return Column(
      crossAxisAlignment: isMine
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(14, 10, 14, 10),
          decoration: BoxDecoration(
            color: isMine ? AppColors.primary : AppColors.glass90,
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
                  height: 1.4,
                ),
              ),
              if (!isMine) ...[
                const SizedBox(height: 4),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    message.timeLabel,
                    style: AppTypography.caption.copyWith(
                      fontSize: 11,
                      color: AppColors.textTertiary,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
        if (isMine) ...[
          const SizedBox(height: 4),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                message.timeLabel,
                style: AppTypography.caption.copyWith(
                  fontSize: 11,
                  color: AppColors.textTertiary,
                ),
              ),
              if (message.readStatus != null) ...[
                const SizedBox(width: 4),
                const Icon(
                  Icons.done_all_rounded,
                  size: 13,
                  color: AppColors.primary,
                ),
                if (message.readStatus == TripChatReadStatus.read) ...[
                  const SizedBox(width: 2),
                  Text(
                    'Đã xem',
                    style: AppTypography.caption.copyWith(
                      fontSize: 10,
                      color: AppColors.textTertiary,
                    ),
                  ),
                ],
              ],
            ],
          ),
        ],
      ],
    );
  }
}
