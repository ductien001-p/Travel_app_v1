import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_icon_button.dart';

import '../../data/models/trip_chat_models.dart';

class TripChatHeader extends StatelessWidget {
  const TripChatHeader({
    super.key,
    required this.thread,
    required this.onBack,
    required this.onMore,
  });

  final TripChatThread thread;
  final VoidCallback onBack;
  final VoidCallback onMore;

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
            border: const Border(
              bottom: BorderSide(color: AppColors.borderBrandSoft),
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.black03,
                blurRadius: 8,
                offset: const Offset(0, 2),
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
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      thread.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.cardTitle.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        if (thread.isLive) ...[
                          SizedBox(
                            width: 8,
                            height: 8,
                            child: Stack(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.success.withValues(
                                      alpha: 0.35,
                                    ),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                Center(
                                  child: Container(
                                    width: 6,
                                    height: 6,
                                    decoration: const BoxDecoration(
                                      color: AppColors.success,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 6),
                        ],
                        Flexible(
                          child: Text(
                            thread.memberSummaryLabel,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTypography.caption.copyWith(
                              color: AppColors.textSecondary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              AppIconButton(
                icon: Icons.more_vert_rounded,
                onPressed: onMore,
                semanticLabel: 'Tùy chọn nhóm',
                iconColor: AppColors.textSecondary,
                backgroundColor: Colors.transparent,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
