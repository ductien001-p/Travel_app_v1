import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_pressable.dart';

import '../../data/models/friend_chat_models.dart';

class FriendChatPlaceCardWidget extends StatelessWidget {
  const FriendChatPlaceCardWidget({
    super.key,
    required this.card,
    required this.onAddToTrip,
  });

  final FriendChatPlaceCard card;
  final VoidCallback onAddToTrip;

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
                    child: Icon(Icons.place_outlined, color: AppColors.primary),
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.glass90,
                      borderRadius: BorderRadius.circular(AppRadius.pill),
                      border: Border.all(color: AppColors.glassBorder),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.star_rounded,
                          size: 13,
                          color: AppColors.warning,
                        ),
                        const SizedBox(width: 2),
                        Text(
                          card.rating.toStringAsFixed(1),
                          style: AppTypography.badge,
                        ),
                        const SizedBox(width: 2),
                        Text(
                          '(${card.reviewCount})',
                          style: AppTypography.caption.copyWith(fontSize: 10),
                        ),
                      ],
                    ),
                  ),
                ),
                if (card.badgeLabel != null)
                  Positioned(
                    left: 8,
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
                            Icons.local_cafe_rounded,
                            size: 12,
                            color: AppColors.textInverse,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            card.badgeLabel!,
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
                  card.name,
                  style: AppTypography.cardTitle.copyWith(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on_rounded,
                      size: 13,
                      color: AppColors.primary,
                    ),
                    const SizedBox(width: 2),
                    Expanded(
                      child: Text(
                        card.address,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTypography.caption.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Divider(height: 1, color: AppColors.borderNeutral),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        card.footerLabel ?? '',
                        style: AppTypography.caption.copyWith(fontSize: 11),
                      ),
                    ),
                    AppPressable(
                      onTap: onAddToTrip,
                      pressedScale: 0.96,
                      borderRadius: BorderRadius.circular(AppRadius.pill),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primaryLight,
                          borderRadius: BorderRadius.circular(AppRadius.pill),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.add_circle_outline_rounded,
                              size: 14,
                              color: AppColors.primary,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              card.actionLabel ?? 'Thêm vào chuyến đi +',
                              style: AppTypography.badge.copyWith(
                                color: AppColors.primary,
                              ),
                            ),
                          ],
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
    );
  }
}
