import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_shadows.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_pressable.dart';

import '../../data/models/trip_chat_models.dart';

class TripChatExpenseCard extends StatelessWidget {
  const TripChatExpenseCard({
    super.key,
    required this.message,
    required this.expense,
    required this.onOpenDetails,
  });

  final TripChatMessage message;
  final TripChatExpensePayload expense;
  final VoidCallback onOpenDetails;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.glass90,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(6),
          topRight: Radius.circular(AppRadius.card),
          bottomLeft: Radius.circular(AppRadius.card),
          bottomRight: Radius.circular(AppRadius.card),
        ),
        border: Border.all(color: AppColors.glassBorder),
        boxShadow: AppShadows.level1,
      ),
      clipBehavior: Clip.antiAlias,
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(width: 4, color: AppColors.primary),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 32,
                          height: 32,
                          decoration: const BoxDecoration(
                            color: AppColors.primaryLight,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.receipt_long_rounded,
                            size: 18,
                            color: AppColors.primary,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                expense.title,
                                style: AppTypography.caption.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              Text(
                                expense.subtitle,
                                style: AppTypography.caption.copyWith(
                                  fontSize: 11,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          expense.amountLabel,
                          style: AppTypography.bodyMedium.copyWith(
                            fontWeight: FontWeight.w700,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceSubdued,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppColors.borderNeutral.withValues(alpha: 0.6),
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.pie_chart_rounded,
                            size: 14,
                            color: AppColors.textTertiary,
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              expense.splitLabel,
                              style: AppTypography.caption.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ),
                          Text(
                            expense.perPersonLabel,
                            style: AppTypography.caption.copyWith(
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Flexible(
                          child: AppPressable(
                            onTap: onOpenDetails,
                            pressedScale: 0.97,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Flexible(
                                  child: Text(
                                    expense.actionLabel ??
                                        'Xem chi tiết chi tiêu',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppTypography.badge.copyWith(
                                      color: AppColors.primary,
                                      fontSize: 11,
                                    ),
                                  ),
                                ),
                                const Icon(
                                  Icons.chevron_right_rounded,
                                  size: 14,
                                  color: AppColors.primary,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          message.timeLabel,
                          style: AppTypography.caption.copyWith(
                            fontSize: 11,
                            color: AppColors.textTertiary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
