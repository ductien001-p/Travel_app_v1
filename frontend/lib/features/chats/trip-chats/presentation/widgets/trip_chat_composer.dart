import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_shadows.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_pressable.dart';

import '../../data/models/trip_chat_models.dart';

class TripChatComposer extends StatelessWidget {
  const TripChatComposer({
    super.key,
    required this.utilities,
    required this.controller,
    required this.utilityExpanded,
    required this.onToggleUtility,
    required this.onUtilitySelected,
    required this.onSend,
    required this.onCamera,
    required this.onMic,
  });

  final List<TripChatUtility> utilities;
  final TextEditingController controller;
  final bool utilityExpanded;
  final VoidCallback onToggleUtility;
  final ValueChanged<TripChatUtility> onUtilitySelected;
  final VoidCallback onSend;
  final VoidCallback onCamera;
  final VoidCallback onMic;

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          decoration: const BoxDecoration(
            color: AppColors.glass90,
            border: Border(top: BorderSide(color: AppColors.borderBrandSoft)),
          ),
          child: SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.sm,
                AppSpacing.sm,
                AppSpacing.sm,
                AppSpacing.sm,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AnimatedSize(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeOutCubic,
                    child: utilityExpanded
                        ? _UtilityMenu(
                            utilities: utilities,
                            onSelected: onUtilitySelected,
                          )
                        : const SizedBox.shrink(),
                  ),
                  Row(
                    children: [
                      _CircleAction(
                        icon: Icons.add_rounded,
                        onTap: onToggleUtility,
                        semanticLabel: 'Mở menu tiện ích chuyến đi',
                        emphasized: utilityExpanded,
                      ),
                      const SizedBox(width: 8),
                      _CircleAction(
                        icon: Icons.photo_camera_outlined,
                        onTap: onCamera,
                        semanticLabel: 'Chụp ảnh hoặc gửi ảnh',
                        plain: true,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.surfaceSubdued,
                            borderRadius: BorderRadius.circular(AppRadius.pill),
                            border: Border.all(color: AppColors.borderNeutral),
                          ),
                          child: TextField(
                            controller: controller,
                            minLines: 1,
                            maxLines: 4,
                            textInputAction: TextInputAction.send,
                            onSubmitted: (_) => onSend(),
                            style: AppTypography.body.copyWith(
                              color: AppColors.textPrimary,
                            ),
                            decoration: InputDecoration(
                              isDense: true,
                              hintText: 'Nhập tin nhắn với nhóm...',
                              hintStyle: AppTypography.body.copyWith(
                                color: AppColors.textTertiary,
                              ),
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.fromLTRB(
                                16,
                                12,
                                40,
                                12,
                              ),
                              suffixIcon: IconButton(
                                onPressed: onMic,
                                icon: const Icon(
                                  Icons.mic_none_rounded,
                                  color: AppColors.textTertiary,
                                ),
                                tooltip: 'Gửi tin nhắn âm thanh',
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      AppPressable(
                        onTap: onSend,
                        pressedScale: 0.9,
                        borderRadius: BorderRadius.circular(AppRadius.pill),
                        child: Container(
                          width: 44,
                          height: 44,
                          decoration: const BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                            boxShadow: AppShadows.primaryGlow,
                          ),
                          child: const Icon(
                            Icons.send_rounded,
                            size: 20,
                            color: AppColors.textInverse,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _UtilityMenu extends StatelessWidget {
  const _UtilityMenu({required this.utilities, required this.onSelected});

  final List<TripChatUtility> utilities;
  final ValueChanged<TripChatUtility> onSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: AppColors.surface.withValues(alpha: 0.95),
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(color: AppColors.borderBrandSoft),
        boxShadow: AppShadows.level1,
      ),
      child: Row(
        children: [
          for (final utility in utilities)
            Expanded(
              child: AppPressable(
                onTap: () => onSelected(utility),
                pressedScale: 0.94,
                borderRadius: BorderRadius.circular(12),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Column(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: _bg(utility.kind),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          _icon(utility.kind),
                          size: 20,
                          color: _fg(utility.kind),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        utility.label,
                        textAlign: TextAlign.center,
                        style: AppTypography.caption.copyWith(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Color _bg(TripChatUtilityKind kind) => switch (kind) {
    TripChatUtilityKind.liveLocation => AppColors.primaryLight,
    TripChatUtilityKind.splitBill => const Color(0xFF99F2EC),
    TripChatUtilityKind.album => const Color(0xFFE0F0F9),
    TripChatUtilityKind.addStop => const Color(0xFFDBEBF3),
  };

  Color _fg(TripChatUtilityKind kind) => switch (kind) {
    TripChatUtilityKind.liveLocation => AppColors.primary,
    TripChatUtilityKind.splitBill => const Color(0xFF00716D),
    TripChatUtilityKind.album => const Color(0xFF005AC2),
    TripChatUtilityKind.addStop => AppColors.primary,
  };

  IconData _icon(TripChatUtilityKind kind) => switch (kind) {
    TripChatUtilityKind.liveLocation => Icons.share_location_rounded,
    TripChatUtilityKind.splitBill => Icons.request_quote_rounded,
    TripChatUtilityKind.album => Icons.photo_library_rounded,
    TripChatUtilityKind.addStop => Icons.add_circle_rounded,
  };
}

class _CircleAction extends StatelessWidget {
  const _CircleAction({
    required this.icon,
    required this.onTap,
    required this.semanticLabel,
    this.emphasized = false,
    this.plain = false,
  });

  final IconData icon;
  final VoidCallback onTap;
  final String semanticLabel;
  final bool emphasized;
  final bool plain;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: semanticLabel,
      child: AppPressable(
        onTap: onTap,
        pressedScale: 0.92,
        borderRadius: BorderRadius.circular(AppRadius.pill),
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: plain
                ? Colors.transparent
                : emphasized
                ? AppColors.primaryLight
                : AppColors.surfaceSubdued,
            shape: BoxShape.circle,
            border: plain ? null : Border.all(color: AppColors.borderNeutral),
          ),
          child: Icon(
            icon,
            size: 22,
            color: plain ? AppColors.textSecondary : AppColors.primary,
          ),
        ),
      ),
    );
  }
}
