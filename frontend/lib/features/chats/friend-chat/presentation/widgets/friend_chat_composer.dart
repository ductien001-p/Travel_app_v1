import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_shadows.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_pressable.dart';

import '../../data/models/friend_chat_models.dart';
import 'friend_chat_shortcuts.dart';

class FriendChatComposer extends StatelessWidget {
  const FriendChatComposer({
    super.key,
    required this.peerName,
    required this.shortcuts,
    required this.controller,
    required this.onSend,
    required this.onShortcut,
    required this.onAttach,
    required this.onCamera,
    required this.onMic,
  });

  final String peerName;
  final List<FriendChatShortcut> shortcuts;
  final TextEditingController controller;
  final VoidCallback onSend;
  final ValueChanged<FriendChatShortcut> onShortcut;
  final VoidCallback onAttach;
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
            boxShadow: [
              BoxShadow(
                color: AppColors.marine08,
                blurRadius: 28,
                offset: Offset(0, -8),
              ),
            ],
          ),
          child: SafeArea(
            top: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FriendChatShortcuts(
                  shortcuts: shortcuts,
                  onSelected: onShortcut,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.sm,
                    6,
                    AppSpacing.sm,
                    AppSpacing.sm,
                  ),
                  child: Row(
                    children: [
                      _CircleAction(
                        icon: Icons.add_rounded,
                        onTap: onAttach,
                        semanticLabel: 'Mở tính năng đính kèm',
                      ),
                      const SizedBox(width: 8),
                      _CircleAction(
                        icon: Icons.photo_camera_outlined,
                        onTap: onCamera,
                        semanticLabel: 'Chụp ảnh',
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.surfaceSubdued.withValues(
                              alpha: 0.9,
                            ),
                            borderRadius: BorderRadius.circular(AppRadius.pill),
                            border: Border.all(
                              color: AppColors.borderBrandSoft,
                            ),
                          ),
                          child: TextField(
                            controller: controller,
                            minLines: 1,
                            maxLines: 4,
                            textInputAction: TextInputAction.send,
                            onSubmitted: (_) => onSend(),
                            style: AppTypography.body.copyWith(
                              fontSize: 13.5,
                              color: AppColors.textPrimary,
                            ),
                            decoration: InputDecoration(
                              isDense: true,
                              hintText: 'Nhập tin nhắn với $peerName...',
                              hintStyle: AppTypography.body.copyWith(
                                fontSize: 13.5,
                                color: AppColors.textTertiary,
                              ),
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.fromLTRB(
                                16,
                                10,
                                40,
                                10,
                              ),
                              suffixIcon: IconButton(
                                onPressed: onMic,
                                icon: const Icon(
                                  Icons.mic_none_rounded,
                                  color: AppColors.textTertiary,
                                ),
                                tooltip: 'Ghi âm giọng nói',
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
                          width: 40,
                          height: 40,
                          decoration: const BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                            boxShadow: AppShadows.primaryGlow,
                          ),
                          child: const Icon(
                            Icons.send_rounded,
                            size: 18,
                            color: AppColors.textInverse,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CircleAction extends StatelessWidget {
  const _CircleAction({
    required this.icon,
    required this.onTap,
    required this.semanticLabel,
  });

  final IconData icon;
  final VoidCallback onTap;
  final String semanticLabel;

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
            color: AppColors.surfaceSubdued,
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.borderNeutral),
          ),
          child: Icon(icon, size: 20, color: AppColors.textPrimary),
        ),
      ),
    );
  }
}
