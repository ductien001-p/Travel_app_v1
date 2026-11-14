import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_shadows.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_avatar.dart';
import 'package:travel_frontend_v1/core/widget/app_pressable.dart';

class SocialPostDetailComposer extends StatelessWidget {
  const SocialPostDetailComposer({
    super.key,
    required this.controller,
    required this.hint,
    required this.avatarUrl,
    required this.displayName,
    required this.submitting,
    required this.onSubmit,
    this.replyHint,
    this.onCancelReply,
  });

  final TextEditingController controller;
  final String hint;
  final String? avatarUrl;
  final String displayName;
  final bool submitting;
  final VoidCallback onSubmit;
  final String? replyHint;
  final VoidCallback? onCancelReply;

  @override
  Widget build(BuildContext context) {
    final initial = displayName.isNotEmpty
        ? displayName.characters.first.toUpperCase()
        : '?';
    final bottom = MediaQuery.paddingOf(context).bottom;

    return Container(
      padding: EdgeInsets.fromLTRB(
        AppSpacing.screenHorizontal,
        AppSpacing.sm,
        AppSpacing.screenHorizontal,
        AppSpacing.sm + bottom,
      ),
      decoration: const BoxDecoration(
        color: AppColors.glass90,
        border: Border(top: BorderSide(color: AppColors.borderNeutral)),
        boxShadow: AppShadows.level1,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (replyHint != null) ...[
            Row(
              children: [
                const Icon(
                  Icons.reply_rounded,
                  size: 16,
                  color: AppColors.primary,
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    replyHint!,
                    style: AppTypography.caption.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                AppPressable(
                  onTap: onCancelReply,
                  child: const Icon(
                    Icons.close_rounded,
                    size: 18,
                    color: AppColors.textTertiary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xs),
          ],
          Row(
            children: [
              AppAvatar(size: 36, imageUrl: avatarUrl, initials: initial),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceSubdued,
                    borderRadius: BorderRadius.circular(AppRadius.pill),
                    border: Border.all(color: AppColors.borderNeutral),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: controller,
                          minLines: 1,
                          maxLines: 4,
                          textInputAction: TextInputAction.send,
                          onSubmitted: (_) => onSubmit(),
                          decoration: InputDecoration(
                            hintText: hint,
                            hintStyle: AppTypography.body.copyWith(
                              color: AppColors.textTertiary,
                            ),
                            border: InputBorder.none,
                            isDense: true,
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 12,
                            ),
                          ),
                          style: AppTypography.body,
                        ),
                      ),
                      const Icon(
                        Icons.image_outlined,
                        size: 18,
                        color: AppColors.textTertiary,
                      ),
                      const SizedBox(width: 8),
                      const Icon(
                        Icons.alternate_email_rounded,
                        size: 18,
                        color: AppColors.textTertiary,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              AppPressable(
                onTap: submitting ? null : onSubmit,
                borderRadius: BorderRadius.circular(999),
                child: Container(
                  width: 42,
                  height: 42,
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                    boxShadow: AppShadows.primaryGlow,
                  ),
                  alignment: Alignment.center,
                  child: submitting
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: AppColors.textInverse,
                          ),
                        )
                      : const Icon(
                          Icons.send_rounded,
                          size: 18,
                          color: AppColors.textInverse,
                        ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
