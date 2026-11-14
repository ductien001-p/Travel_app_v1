import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_pressable.dart';

import '../../data/models/friend_chat_models.dart';

class FriendChatShortcuts extends StatelessWidget {
  const FriendChatShortcuts({
    super.key,
    required this.shortcuts,
    required this.onSelected,
  });

  final List<FriendChatShortcut> shortcuts;
  final ValueChanged<FriendChatShortcut> onSelected;

  @override
  Widget build(BuildContext context) {
    if (shortcuts.isEmpty) return const SizedBox.shrink();
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.sm,
          AppSpacing.xs,
          AppSpacing.sm,
          0,
        ),
        itemCount: shortcuts.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final shortcut = shortcuts[index];
          final emphasized = shortcut.emphasized;
          return AppPressable(
            onTap: () => onSelected(shortcut),
            pressedScale: 0.96,
            borderRadius: BorderRadius.circular(AppRadius.pill),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: emphasized ? AppColors.primaryLight : AppColors.glass90,
                borderRadius: BorderRadius.circular(AppRadius.pill),
                border: Border.all(
                  color: emphasized
                      ? AppColors.primary20
                      : AppColors.borderBrandSoft,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (emphasized) ...[
                    const Icon(
                      Icons.luggage_rounded,
                      size: 15,
                      color: AppColors.primary,
                    ),
                    const SizedBox(width: 6),
                  ],
                  Text(
                    shortcut.label,
                    style: AppTypography.caption.copyWith(
                      fontWeight: emphasized
                          ? FontWeight.w700
                          : FontWeight.w500,
                      color: emphasized
                          ? AppColors.primary
                          : AppColors.textPrimary,
                      fontSize: 12,
                    ),
                  ),
                  if (emphasized) ...[
                    const SizedBox(width: 6),
                    Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
