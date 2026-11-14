import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_shadows.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_pressable.dart';

import '../../data/models/friend_chat_models.dart';

class FriendChatTripInviteCardWidget extends StatelessWidget {
  const FriendChatTripInviteCardWidget({
    super.key,
    required this.card,
    required this.timeLabel,
    required this.onJoin,
    required this.onDetails,
  });

  final FriendChatTripInviteCard card;
  final String timeLabel;
  final VoidCallback onJoin;
  final VoidCallback onDetails;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(AppRadius.card),
          topRight: Radius.circular(AppRadius.card),
          bottomRight: Radius.circular(AppRadius.card),
          bottomLeft: Radius.circular(6),
        ),
        border: Border.all(color: AppColors.borderBrandSoft),
        boxShadow: const [
          BoxShadow(
            color: AppColors.primary08,
            blurRadius: 16,
            offset: Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 112,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(
                  card.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) => const ColoredBox(
                    color: AppColors.surfaceSubdued,
                    child: Icon(
                      Icons.landscape_outlined,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                if (card.badgeLabel != null)
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.85),
                        borderRadius: BorderRadius.circular(AppRadius.pill),
                        border: Border.all(color: AppColors.glassBorder),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.backpack_rounded,
                            size: 12,
                            color: AppColors.textInverse,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            card.badgeLabel!,
                            style: AppTypography.badge.copyWith(
                              color: AppColors.textInverse,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                Positioned(
                  right: 8,
                  bottom: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.heroOverlay.withValues(alpha: 0.7),
                      borderRadius: BorderRadius.circular(AppRadius.pill),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.group_rounded,
                          size: 12,
                          color: AppColors.warning,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          card.seatsLabel,
                          style: AppTypography.caption.copyWith(
                            color: AppColors.textInverse,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppSpacing.sm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  card.title,
                  style: AppTypography.cardTitle.copyWith(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 6),
                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.calendar_month_rounded,
                          size: 13,
                          color: AppColors.primary,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          card.dateLabel,
                          style: AppTypography.caption.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.account_balance_wallet_outlined,
                          size: 13,
                          color: AppColors.primary,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          card.priceLabel,
                          style: AppTypography.caption.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                const Divider(height: 1, color: AppColors.borderNeutral),
                const SizedBox(height: 10),
                Wrap(
                  spacing: AppSpacing.xs,
                  runSpacing: AppSpacing.xs,
                  children: [
                    AppPressable(
                      onTap: onJoin,
                      pressedScale: 0.97,
                      borderRadius: BorderRadius.circular(AppRadius.pill),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(AppRadius.pill),
                          boxShadow: AppShadows.primaryGlow,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.group_add_rounded,
                              size: 15,
                              color: AppColors.textInverse,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              card.primaryActionLabel ?? 'Tham gia chuyến đi',
                              style: AppTypography.badge.copyWith(
                                color: AppColors.textInverse,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    AppPressable(
                      onTap: onDetails,
                      pressedScale: 0.97,
                      borderRadius: BorderRadius.circular(AppRadius.pill),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceSubdued,
                          borderRadius: BorderRadius.circular(AppRadius.pill),
                          border: Border.all(color: AppColors.borderNeutral),
                        ),
                        child: Text(
                          card.secondaryActionLabel ?? 'Xem chi tiết',
                          style: AppTypography.badge.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    timeLabel,
                    style: AppTypography.caption.copyWith(fontSize: 11),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
