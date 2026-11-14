import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_avatar.dart';
import 'package:travel_frontend_v1/core/widget/app_pressable.dart';

import '../../application/friends_hub_view.dart';
import '../../data/models/friends_hub_models.dart';

class FriendsHubSentRequestTile extends StatelessWidget {
  const FriendsHubSentRequestTile({
    super.key,
    required this.request,
    required this.busy,
    required this.onCancel,
  });

  final FriendsHubRequest request;
  final bool busy;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    final user = request.user;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.glass90,
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(color: AppColors.glassBorder),
      ),
      child: Row(
        children: [
          AppAvatar(
            size: 48,
            imageUrl: user.avatarUrl,
            initials: user.displayName.isEmpty
                ? '?'
                : user.displayName[0].toUpperCase(),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.displayName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.cardTitle,
                ),
                Text(
                  '@${user.username}',
                  style: AppTypography.caption.copyWith(
                    color: AppColors.primary,
                  ),
                ),
                Text(
                  'Đã gửi ${friendsHubRelativeTime(request.createdAt).toLowerCase()}',
                  style: AppTypography.caption.copyWith(
                    color: AppColors.textTertiary,
                  ),
                ),
              ],
            ),
          ),
          Opacity(
            opacity: busy ? 0.6 : 1,
            child: AppPressable(
              onTap: busy ? null : onCancel,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: AppColors.surfaceSubdued,
                  borderRadius: BorderRadius.circular(AppRadius.pill),
                  border: Border.all(color: AppColors.borderNeutral),
                ),
                child: Text(
                  'Hủy',
                  style: AppTypography.caption.copyWith(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
