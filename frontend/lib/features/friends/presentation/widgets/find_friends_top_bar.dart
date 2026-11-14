import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_icon_button.dart';
import 'package:travel_frontend_v1/core/widget/app_pressable.dart';

class FindFriendsTopBar extends StatelessWidget {
  const FindFriendsTopBar({
    super.key,
    required this.controller,
    required this.onBack,
    required this.onChanged,
    required this.onClear,
    required this.onSubmitted,
  });

  final TextEditingController controller;
  final VoidCallback onBack;
  final ValueChanged<String> onChanged;
  final VoidCallback onClear;
  final ValueChanged<String> onSubmitted;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.screenHorizontal,
        AppSpacing.sm,
        AppSpacing.screenHorizontal,
        AppSpacing.sm,
      ),
      child: Row(
        children: [
          AppIconButton(
            icon: Icons.arrow_back_rounded,
            onPressed: onBack,
            semanticLabel: 'Quay lại',
            backgroundColor: AppColors.glass90,
          ),
          const SizedBox(width: AppSpacing.xs),
          Expanded(
            child: Container(
              height: 44,
              decoration: BoxDecoration(
                color: AppColors.glass90,
                borderRadius: BorderRadius.circular(AppRadius.pill),
                border: Border.all(color: AppColors.borderBrandSoft),
                boxShadow: const [
                  BoxShadow(
                    color: AppColors.black03,
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  const SizedBox(width: AppSpacing.sm),
                  const Icon(
                    Icons.search_rounded,
                    size: 20,
                    color: AppColors.primary,
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  Expanded(
                    child: TextField(
                      controller: controller,
                      onChanged: onChanged,
                      onSubmitted: onSubmitted,
                      style: AppTypography.body.copyWith(
                        color: AppColors.textPrimary,
                      ),
                      textInputAction: TextInputAction.search,
                      decoration: InputDecoration(
                        isCollapsed: true,
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        filled: false,
                        hintText: 'Tìm bạn bè theo tên, username (@)...',
                        hintStyle: AppTypography.body.copyWith(
                          color: AppColors.textTertiary,
                        ),
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  ),
                  if (controller.text.isNotEmpty)
                    AppPressable(
                      onTap: onClear,
                      borderRadius: BorderRadius.circular(AppRadius.pill),
                      child: const Padding(
                        padding: EdgeInsets.all(AppSpacing.xs),
                        child: Icon(
                          Icons.close_rounded,
                          size: 16,
                          color: AppColors.textTertiary,
                        ),
                      ),
                    )
                  else
                    const SizedBox(width: AppSpacing.sm),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
