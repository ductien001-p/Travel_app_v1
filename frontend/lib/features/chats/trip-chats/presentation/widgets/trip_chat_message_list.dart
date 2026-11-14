import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_avatar.dart';

import '../../data/models/trip_chat_models.dart';
import 'trip_chat_expense_card.dart';
import 'trip_chat_photo_bubble.dart';
import 'trip_chat_system_chip.dart';
import 'trip_chat_text_bubble.dart';
import 'trip_chat_typing_indicator.dart';

class TripChatMessageList extends StatelessWidget {
  const TripChatMessageList({
    super.key,
    required this.thread,
    required this.bottomInset,
    required this.onOpenExpense,
  });

  final TripChatThread thread;
  final double bottomInset;
  final ValueChanged<TripChatExpensePayload> onOpenExpense;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.fromLTRB(
        AppSpacing.sm,
        AppSpacing.sm,
        AppSpacing.sm,
        bottomInset,
      ),
      children: [
        Center(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.surface.withValues(alpha: 0.8),
              borderRadius: BorderRadius.circular(AppRadius.pill),
              border: Border.all(color: AppColors.borderNeutral),
            ),
            child: Text(
              thread.dateLabel,
              style: AppTypography.caption.copyWith(
                color: AppColors.textTertiary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        for (final message in thread.messages) ...[
          _MessageRow(message: message, onOpenExpense: onOpenExpense),
          const SizedBox(height: AppSpacing.md),
        ],
        if (thread.isSomeoneTyping && (thread.typingLabel?.isNotEmpty ?? false))
          TripChatTypingIndicator(
            label: thread.typingLabel!,
            avatarUrl: thread.typingAvatarUrl,
          ),
      ],
    );
  }
}

class _MessageRow extends StatelessWidget {
  const _MessageRow({required this.message, required this.onOpenExpense});

  final TripChatMessage message;
  final ValueChanged<TripChatExpensePayload> onOpenExpense;

  @override
  Widget build(BuildContext context) {
    if (message.kind == TripChatMessageKind.system) {
      final system = message.system;
      if (system == null) return const SizedBox.shrink();
      return TripChatSystemChip(payload: system);
    }

    if (message.isMine) {
      return Align(
        alignment: Alignment.centerRight,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.sizeOf(context).width * 0.85,
          ),
          child: _bubbleBody(),
        ),
      );
    }

    final sender = message.sender;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (message.showAvatar && sender != null)
          _SenderAvatar(sender: sender)
        else
          const SizedBox(width: 36),
        const SizedBox(width: 10),
        Flexible(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.sizeOf(context).width * 0.82,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (sender != null) _SenderIdentity(sender: sender),
                _bubbleBody(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _bubbleBody() {
    return switch (message.kind) {
      TripChatMessageKind.text => TripChatTextBubble(message: message),
      TripChatMessageKind.photo =>
        message.photo == null
            ? const SizedBox.shrink()
            : TripChatPhotoBubble(message: message, photo: message.photo!),
      TripChatMessageKind.expense =>
        message.expense == null
            ? const SizedBox.shrink()
            : TripChatExpenseCard(
                message: message,
                expense: message.expense!,
                onOpenDetails: () => onOpenExpense(message.expense!),
              ),
      TripChatMessageKind.system => const SizedBox.shrink(),
    };
  }
}

class _SenderAvatar extends StatelessWidget {
  const _SenderAvatar({required this.sender});

  final TripChatSender sender;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 36,
      height: 36,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: sender.isLeader ? AppColors.primary : AppColors.surface,
                width: 2,
              ),
            ),
            child: AppAvatar(
              size: 32,
              imageUrl: sender.avatarUrl,
              initials: _initials(sender.displayName),
            ),
          ),
          if (sender.isLeader)
            Positioned(
              right: -2,
              bottom: -2,
              child: Container(
                width: 16,
                height: 16,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.surface, width: 1),
                ),
                child: const Text(
                  '★',
                  style: TextStyle(fontSize: 8, color: AppColors.textInverse),
                ),
              ),
            ),
        ],
      ),
    );
  }

  String _initials(String name) {
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty || parts.first.isEmpty) return '?';
    if (parts.length == 1) return parts.first[0].toUpperCase();
    return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
  }
}

class _SenderIdentity extends StatelessWidget {
  const _SenderIdentity({required this.sender});

  final TripChatSender sender;

  @override
  Widget build(BuildContext context) {
    final (bg, fg) = switch (sender.roleTone) {
      TripChatRoleTone.leader => (AppColors.primaryLight, AppColors.primary),
      TripChatRoleTone.photographer => (
        const Color(0xFF99F2EC),
        const Color(0xFF00716D),
      ),
      TripChatRoleTone.treasurer => (
        const Color(0xFFD8E2FF),
        const Color(0xFF004395),
      ),
      TripChatRoleTone.member => (
        AppColors.surfaceSubdued,
        AppColors.textSecondary,
      ),
    };

    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 4),
      child: Row(
        children: [
          Flexible(
            child: Text(
              sender.displayName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTypography.caption.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          if (sender.roleBadge != null) ...[
            const SizedBox(width: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
              decoration: BoxDecoration(
                color: bg,
                borderRadius: BorderRadius.circular(AppRadius.pill),
              ),
              child: Text(
                sender.roleBadge!,
                style: AppTypography.badge.copyWith(
                  fontSize: 10,
                  color: fg,
                  letterSpacing: 0,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
