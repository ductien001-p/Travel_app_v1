import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_shadows.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_pressable.dart';

import '../../application/chats_hub_view.dart';

class ChatsHubFilterPills extends StatelessWidget {
  const ChatsHubFilterPills({
    super.key,
    required this.selected,
    required this.totalCount,
    required this.hasUnread,
    required this.onSelected,
  });

  final ChatsHubFilter selected;
  final int totalCount;
  final bool hasUnread;
  final ValueChanged<ChatsHubFilter> onSelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.screenHorizontal,
        ),
        children: [
          _Pill(
            label: 'Tất cả',
            selected: selected == ChatsHubFilter.all,
            trailing: _CountBadge(count: totalCount),
            onTap: () => onSelected(ChatsHubFilter.all),
          ),
          const SizedBox(width: AppSpacing.xs),
          _Pill(
            label: 'Chuyến đi (Trip Chats)',
            selected: selected == ChatsHubFilter.trips,
            leading: Icons.flight_takeoff_rounded,
            onTap: () => onSelected(ChatsHubFilter.trips),
          ),
          const SizedBox(width: AppSpacing.xs),
          _Pill(
            label: 'Bạn bè (1-on-1)',
            selected: selected == ChatsHubFilter.friends,
            leading: Icons.person_rounded,
            onTap: () => onSelected(ChatsHubFilter.friends),
          ),
          const SizedBox(width: AppSpacing.xs),
          _Pill(
            label: 'Chưa đọc',
            selected: selected == ChatsHubFilter.unread,
            trailing: hasUnread
                ? Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                  )
                : null,
            onTap: () => onSelected(ChatsHubFilter.unread),
          ),
        ],
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill({
    required this.label,
    required this.selected,
    required this.onTap,
    this.leading,
    this.trailing,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;
  final IconData? leading;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final foreground = selected
        ? const Color(0xFF00312F)
        : AppColors.textSecondary;

    return AppPressable(
      onTap: onTap,
      pressedScale: 0.95,
      borderRadius: BorderRadius.circular(AppRadius.pill),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? AppColors.primary : AppColors.glass85,
          borderRadius: BorderRadius.circular(AppRadius.pill),
          border: Border.all(
            color: selected ? AppColors.primary : AppColors.borderBrandSoft,
          ),
          boxShadow: selected
              ? const [
                  BoxShadow(
                    color: AppColors.primary38,
                    blurRadius: 14,
                    offset: Offset(0, 4),
                  ),
                ]
              : AppShadows.level1,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (leading != null) ...[
              Icon(leading, size: 15, color: foreground),
              const SizedBox(width: 6),
            ],
            Text(
              label,
              style: AppTypography.caption.copyWith(
                color: foreground,
                fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
            if (trailing != null) ...[const SizedBox(width: 6), trailing!],
          ],
        ),
      ),
    );
  }
}

class _CountBadge extends StatelessWidget {
  const _CountBadge({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 18,
      height: 18,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: Color(0xFFDBEBF3),
        shape: BoxShape.circle,
      ),
      child: Text(
        '$count',
        style: AppTypography.badge.copyWith(
          fontSize: 10,
          color: AppColors.primary,
          letterSpacing: 0,
        ),
      ),
    );
  }
}
