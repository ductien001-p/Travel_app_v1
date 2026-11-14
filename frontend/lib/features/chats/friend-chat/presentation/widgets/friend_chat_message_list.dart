import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_avatar.dart';

import '../../data/models/friend_chat_models.dart';
import 'friend_chat_place_card.dart';
import 'friend_chat_text_bubble.dart';
import 'friend_chat_trip_invite_card.dart';
import 'friend_chat_typing_indicator.dart';

class FriendChatMessageList extends StatelessWidget {
  const FriendChatMessageList({
    super.key,
    required this.thread,
    required this.bottomInset,
    required this.onAddPlaceToTrip,
    required this.onJoinTrip,
    required this.onTripDetails,
  });

  final FriendChatThread thread;
  final double bottomInset;
  final ValueChanged<FriendChatPlaceCard> onAddPlaceToTrip;
  final ValueChanged<FriendChatTripInviteCard> onJoinTrip;
  final ValueChanged<FriendChatTripInviteCard> onTripDetails;

  @override
  Widget build(BuildContext context) {
    final peer = thread.peer;
    return ListView(
      padding: EdgeInsets.fromLTRB(
        AppSpacing.md,
        AppSpacing.sm,
        AppSpacing.md,
        bottomInset,
      ),
      children: [
        Center(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.surfaceSubdued.withValues(alpha: 0.8),
              borderRadius: BorderRadius.circular(AppRadius.pill),
              border: Border.all(color: AppColors.borderNeutral),
            ),
            child: Text(
              thread.dateLabel,
              style: AppTypography.caption.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        for (final message in thread.messages) ...[
          _MessageRow(
            message: message,
            peer: peer,
            onAddPlaceToTrip: onAddPlaceToTrip,
            onJoinTrip: onJoinTrip,
            onTripDetails: onTripDetails,
          ),
          const SizedBox(height: AppSpacing.md),
        ],
        if (thread.isPeerTyping && (thread.typingLabel?.isNotEmpty ?? false))
          FriendChatTypingIndicator(label: thread.typingLabel!),
      ],
    );
  }
}

class _MessageRow extends StatelessWidget {
  const _MessageRow({
    required this.message,
    required this.peer,
    required this.onAddPlaceToTrip,
    required this.onJoinTrip,
    required this.onTripDetails,
  });

  final FriendChatMessage message;
  final FriendChatPeer peer;
  final ValueChanged<FriendChatPlaceCard> onAddPlaceToTrip;
  final ValueChanged<FriendChatTripInviteCard> onJoinTrip;
  final ValueChanged<FriendChatTripInviteCard> onTripDetails;

  @override
  Widget build(BuildContext context) {
    if (message.isMine) {
      return Align(
        alignment: Alignment.centerRight,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.sizeOf(context).width * 0.8,
          ),
          child: _bubbleBody(),
        ),
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (message.showAvatar)
          AppAvatar(
            size: 28,
            imageUrl: peer.avatarUrl,
            initials: _initials(peer.displayName),
          )
        else
          const SizedBox(width: 28),
        const SizedBox(width: 8),
        Flexible(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.sizeOf(context).width * 0.82,
            ),
            child: _bubbleBody(),
          ),
        ),
      ],
    );
  }

  Widget _bubbleBody() {
    return switch (message.kind) {
      FriendChatMessageKind.text => FriendChatTextBubble(message: message),
      FriendChatMessageKind.placeCard =>
        message.placeCard == null
            ? const SizedBox.shrink()
            : FriendChatPlaceCardWidget(
                card: message.placeCard!,
                onAddToTrip: () => onAddPlaceToTrip(message.placeCard!),
              ),
      FriendChatMessageKind.tripInvite =>
        message.tripInvite == null
            ? const SizedBox.shrink()
            : FriendChatTripInviteCardWidget(
                card: message.tripInvite!,
                timeLabel: message.timeLabel,
                onJoin: () => onJoinTrip(message.tripInvite!),
                onDetails: () => onTripDetails(message.tripInvite!),
              ),
    };
  }

  String _initials(String name) {
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty || parts.first.isEmpty) return '?';
    if (parts.length == 1) return parts.first[0].toUpperCase();
    return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
  }
}
