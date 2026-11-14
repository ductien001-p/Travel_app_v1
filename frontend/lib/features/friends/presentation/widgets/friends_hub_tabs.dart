import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_pressable.dart';

import '../../data/models/friends_hub_models.dart';

class FriendsHubTabs extends StatelessWidget {
  const FriendsHubTabs({
    super.key,
    required this.tab,
    required this.friendsCount,
    required this.receivedCount,
    required this.sentCount,
    required this.onChanged,
  });

  final FriendsHubTab tab;
  final int friendsCount;
  final int receivedCount;
  final int sentCount;
  final ValueChanged<FriendsHubTab> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: AppColors.glass90,
        borderRadius: BorderRadius.circular(AppRadius.pill),
        border: Border.all(color: AppColors.borderBrandSoft),
        boxShadow: const [
          BoxShadow(
            color: AppColors.black03,
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: _TabChip(
              label: 'Bạn bè',
              count: friendsCount,
              selected: tab == FriendsHubTab.friends,
              badgeTone: _BadgeTone.soft,
              onTap: () => onChanged(FriendsHubTab.friends),
            ),
          ),
          Expanded(
            child: _TabChip(
              label: 'Đã nhận',
              count: receivedCount,
              selected: tab == FriendsHubTab.received,
              badgeTone: receivedCount > 0
                  ? _BadgeTone.danger
                  : _BadgeTone.muted,
              onTap: () => onChanged(FriendsHubTab.received),
            ),
          ),
          Expanded(
            child: _TabChip(
              label: 'Đã gửi',
              count: sentCount,
              selected: tab == FriendsHubTab.sent,
              badgeTone: _BadgeTone.muted,
              onTap: () => onChanged(FriendsHubTab.sent),
            ),
          ),
        ],
      ),
    );
  }
}

enum _BadgeTone { soft, danger, muted }

class _TabChip extends StatelessWidget {
  const _TabChip({
    required this.label,
    required this.count,
    required this.selected,
    required this.badgeTone,
    required this.onTap,
  });

  final String label;
  final int count;
  final bool selected;
  final _BadgeTone badgeTone;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final bg = selected ? AppColors.primary : Colors.transparent;
    final fg = selected ? AppColors.textInverse : AppColors.textSecondary;
    return AppPressable(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(AppRadius.pill),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.bodyMedium.copyWith(
                  color: fg,
                  fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(width: 4),
            Container(
              constraints: const BoxConstraints(minWidth: 18),
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: selected
                    ? AppColors.glassBorder
                    : switch (badgeTone) {
                        _BadgeTone.danger => AppColors.danger,
                        _BadgeTone.soft => AppColors.primaryLight,
                        _BadgeTone.muted => AppColors.surfaceSubdued,
                      },
                borderRadius: BorderRadius.circular(AppRadius.pill),
              ),
              child: Text(
                '$count',
                textAlign: TextAlign.center,
                style: AppTypography.badge.copyWith(
                  color: selected
                      ? AppColors.textInverse
                      : switch (badgeTone) {
                          _BadgeTone.danger => AppColors.textInverse,
                          _BadgeTone.soft => AppColors.primary,
                          _BadgeTone.muted => AppColors.textSecondary,
                        },
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
