import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_avatar.dart';
import 'package:travel_frontend_v1/core/widget/app_pressable.dart';

import '../../application/find_friends_view.dart';
import '../../data/models/find_friends_models.dart';

class FindFriendsNearbyCard extends StatelessWidget {
  const FindFriendsNearbyCard({
    super.key,
    required this.suggestion,
    required this.busy,
    required this.onAction,
  });

  final FindFriendsNearbySuggestion suggestion;
  final bool busy;
  final VoidCallback onAction;

  @override
  Widget build(BuildContext context) {
    final chipBg = suggestion.chipTone == FindFriendsContactChipTone.primary
        ? AppColors.primaryLight
        : const Color(0x8099F2EC);
    final chipFg = AppColors.primaryActive;
    final (bg, fg, icon) = switch (suggestion.action) {
      FindFriendsAction.requestSent => (
        AppColors.surfaceSubdued,
        AppColors.textSecondary,
        Icons.person_remove_alt_1_rounded,
      ),
      FindFriendsAction.following => (
        AppColors.surfaceSubdued,
        AppColors.textSecondary,
        Icons.check_rounded,
      ),
      FindFriendsAction.follow => (
        AppColors.surface,
        AppColors.primary,
        Icons.add_rounded,
      ),
      FindFriendsAction.message => (
        AppColors.primaryLight,
        AppColors.primaryActive,
        Icons.chat_bubble_outline_rounded,
      ),
      FindFriendsAction.addFriend => (
        AppColors.primary,
        AppColors.textInverse,
        Icons.person_add_alt_1_rounded,
      ),
    };

    return Container(
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: AppColors.glass85,
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(color: AppColors.glassBorder),
        boxShadow: const [
          BoxShadow(
            color: AppColors.marine08,
            blurRadius: 16,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          AppAvatar(
            size: 56,
            imageUrl: suggestion.avatarUrl,
            initials: suggestion.displayName.isNotEmpty
                ? suggestion.displayName.characters.first
                : '?',
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            suggestion.displayName,
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
          Text(
            suggestion.subtitle,
            style: AppTypography.caption.copyWith(fontSize: 11),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.xs),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: chipBg,
              borderRadius: BorderRadius.circular(AppRadius.pill),
            ),
            child: Text(
              suggestion.chipLabel,
              style: AppTypography.badge.copyWith(
                color: chipFg,
                fontWeight: FontWeight.w600,
                letterSpacing: 0,
                fontSize: 10,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          AppPressable(
            onTap: busy ? null : onAction,
            borderRadius: BorderRadius.circular(AppRadius.pill),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 7),
              decoration: BoxDecoration(
                color: bg,
                borderRadius: BorderRadius.circular(AppRadius.pill),
                border: suggestion.action == FindFriendsAction.follow
                    ? Border.all(color: AppColors.primary)
                    : null,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (busy)
                    SizedBox(
                      width: 14,
                      height: 14,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: fg,
                      ),
                    )
                  else
                    Icon(icon, size: 14, color: fg),
                  const SizedBox(width: 4),
                  Flexible(
                    child: Text(
                      findFriendsActionLabel(suggestion.action),
                      style: AppTypography.caption.copyWith(
                        color: fg,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
