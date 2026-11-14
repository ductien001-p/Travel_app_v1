import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_bottom_sheet.dart';
import 'package:travel_frontend_v1/core/widget/app_pressable.dart';

import '../../data/models/friend_chat_models.dart';

Future<FriendChatInviteCandidate?> showFriendChatInviteSheet({
  required BuildContext context,
  required List<FriendChatInviteCandidate> candidates,
  required VoidCallback onCreateTrip,
}) {
  return showAppBottomSheet<FriendChatInviteCandidate>(
    context: context,
    child: FriendChatInviteSheet(
      candidates: candidates,
      onCreateTrip: onCreateTrip,
    ),
  );
}

class FriendChatInviteSheet extends StatelessWidget {
  const FriendChatInviteSheet({
    super.key,
    required this.candidates,
    required this.onCreateTrip,
  });

  final List<FriendChatInviteCandidate> candidates;
  final VoidCallback onCreateTrip;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: const BoxDecoration(
                color: AppColors.primaryLight,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.flight_takeoff_rounded,
                size: 18,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(width: AppSpacing.xs),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Mời tham gia chuyến đi',
                    style: AppTypography.cardTitle.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  Text(
                    'Chọn lịch trình bạn đang làm trưởng nhóm hoặc tham gia',
                    style: AppTypography.caption.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () => Navigator.of(context).maybePop(),
              icon: const Icon(Icons.close_rounded),
              color: AppColors.textTertiary,
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 280),
          child: ListView.separated(
            shrinkWrap: true,
            itemCount: candidates.length,
            separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.sm),
            itemBuilder: (context, index) {
              final item = candidates[index];
              return Container(
                padding: const EdgeInsets.all(AppSpacing.sm),
                decoration: BoxDecoration(
                  color: AppColors.surfaceSubdued.withValues(alpha: 0.8),
                  borderRadius: BorderRadius.circular(AppRadius.card),
                  border: Border.all(color: AppColors.borderBrandSoft),
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: SizedBox(
                        width: 48,
                        height: 48,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.network(
                              item.imageUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (_, _, _) => const ColoredBox(
                                color: AppColors.primaryLight,
                              ),
                            ),
                            Positioned(
                              right: 0,
                              bottom: 0,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 4,
                                  vertical: 1,
                                ),
                                color: AppColors.primary,
                                child: Text(
                                  item.badgeLabel,
                                  style: AppTypography.badge.copyWith(
                                    color: AppColors.textInverse,
                                    fontSize: 9,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: AppTypography.cardTitle.copyWith(
                              fontSize: 13.5,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            item.metaLabel,
                            style: AppTypography.caption.copyWith(fontSize: 11),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: AppSpacing.xs),
                    AppPressable(
                      onTap: () => Navigator.of(context).pop(item),
                      pressedScale: 0.95,
                      borderRadius: BorderRadius.circular(AppRadius.pill),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(AppRadius.pill),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.send_rounded,
                              size: 13,
                              color: AppColors.textInverse,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              item.actionLabel,
                              style: AppTypography.badge.copyWith(
                                color: AppColors.textInverse,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        AppPressable(
          onTap: () {
            Navigator.of(context).maybePop();
            onCreateTrip();
          },
          pressedScale: 0.98,
          borderRadius: BorderRadius.circular(AppRadius.pill),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: AppColors.primaryLight.withValues(alpha: 0.4),
              borderRadius: BorderRadius.circular(AppRadius.pill),
              border: Border.all(
                color: AppColors.primary.withValues(alpha: 0.5),
                style: BorderStyle.solid,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.add_circle_outline_rounded,
                  size: 16,
                  color: AppColors.primary,
                ),
                const SizedBox(width: 6),
                Text(
                  'Tạo chuyến đi mới để mời bạn bè',
                  style: AppTypography.caption.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
