import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_frontend_v1/app/router/router_names.dart';
import 'package:travel_frontend_v1/core/testing/e2e_keys.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_gradients.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/widget/app_error_view.dart';
import 'package:travel_frontend_v1/core/widget/app_skeleton.dart';

import '../../application/friend_chat_controller.dart';
import '../../data/models/friend_chat_models.dart';
import '../widgets/friend_chat_composer.dart';
import '../widgets/friend_chat_header.dart';
import '../widgets/friend_chat_invite_sheet.dart';
import '../widgets/friend_chat_message_list.dart';
import '../widgets/friend_chat_shared_trip_banner.dart';

class FriendChatScreen extends ConsumerStatefulWidget {
  const FriendChatScreen({super.key, required this.conversationId});

  final String conversationId;

  @override
  ConsumerState<FriendChatScreen> createState() => _FriendChatScreenState();
}

class _FriendChatScreenState extends ConsumerState<FriendChatScreen> {
  late final TextEditingController _composer;

  @override
  void initState() {
    super.initState();
    _composer = TextEditingController();
  }

  @override
  void dispose() {
    _composer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(
      friendChatControllerProvider(widget.conversationId),
    );

    return Scaffold(
      key: E2eKeys.friendChatScreenRoot,
      backgroundColor: Colors.transparent,
      body: DecoratedBox(
        decoration: const BoxDecoration(gradient: AppGradients.pageAtmosphere),
        child: SafeArea(
          bottom: false,
          child: async.when(
            loading: () => const _LoadingScaffold(),
            error: (error, _) {
              final unauthorized = friendChatFailureIsUnauthorized(error);
              return Column(
                children: [
                  _ErrorHeader(onBack: () => context.pop()),
                  Expanded(
                    child: AppErrorView(
                      title: unauthorized
                          ? 'Phiên đăng nhập đã hết hạn'
                          : 'Không tải được hội thoại',
                      message: friendChatFailureMessage(error),
                      actionLabel: 'Thử lại',
                      onRetry: unauthorized
                          ? null
                          : () => ref
                                .read(
                                  friendChatControllerProvider(
                                    widget.conversationId,
                                  ).notifier,
                                )
                                .refresh(),
                    ),
                  ),
                ],
              );
            },
            data: (thread) => _LoadedBody(
              thread: thread,
              composer: _composer,
              onBack: () => context.pop(),
              onInfo: _comingSoon,
              onSharedTrip: () {
                final tripId = thread.sharedTrip?.tripId;
                if (tripId == null || tripId.isEmpty) {
                  _comingSoon();
                  return;
                }
                context.pushNamed(
                  RouteNames.tripDetail,
                  pathParameters: {'tripId': tripId},
                );
              },
              onSend: () => _send(thread),
              onShortcut: (shortcut) => _onShortcut(thread, shortcut),
              onAttach: () => _openInviteSheet(thread),
              onCamera: _comingSoon,
              onMic: _comingSoon,
              onAddPlaceToTrip: (_) => _comingSoon(),
              onJoinTrip: (card) {
                context.pushNamed(
                  RouteNames.tripDetail,
                  pathParameters: {'tripId': card.tripId},
                );
              },
              onTripDetails: (card) {
                context.pushNamed(
                  RouteNames.tripDetail,
                  pathParameters: {'tripId': card.tripId},
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _send(FriendChatThread thread) async {
    final text = _composer.text;
    if (text.trim().isEmpty) return;
    _composer.clear();
    final ok = await ref
        .read(friendChatControllerProvider(widget.conversationId).notifier)
        .sendText(text);
    if (!ok && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Không gửi được tin nhắn. Thử lại.')),
      );
    }
  }

  Future<void> _onShortcut(
    FriendChatThread thread,
    FriendChatShortcut shortcut,
  ) async {
    switch (shortcut.kind) {
      case FriendChatShortcutKind.inviteTrip:
        await _openInviteSheet(thread);
      case FriendChatShortcutKind.sendLocation:
      case FriendChatShortcutKind.splitBill:
      case FriendChatShortcutKind.suggestItinerary:
      case FriendChatShortcutKind.sendPhoto:
        _comingSoon();
    }
  }

  Future<void> _openInviteSheet(FriendChatThread thread) async {
    final selected = await showFriendChatInviteSheet(
      context: context,
      candidates: thread.inviteCandidates,
      onCreateTrip: () => context.pushNamed(RouteNames.createTrip),
    );
    if (!mounted || selected == null) return;
    final ok = await ref
        .read(friendChatControllerProvider(widget.conversationId).notifier)
        .sendTripInvite(selected);
    if (!mounted) return;
    if (!ok) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Không gửi được lời mời. Thử lại.')),
      );
    }
  }

  void _comingSoon() {
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Tính năng đang phát triển')));
  }
}

class _LoadedBody extends StatelessWidget {
  const _LoadedBody({
    required this.thread,
    required this.composer,
    required this.onBack,
    required this.onInfo,
    required this.onSharedTrip,
    required this.onSend,
    required this.onShortcut,
    required this.onAttach,
    required this.onCamera,
    required this.onMic,
    required this.onAddPlaceToTrip,
    required this.onJoinTrip,
    required this.onTripDetails,
  });

  final FriendChatThread thread;
  final TextEditingController composer;
  final VoidCallback onBack;
  final VoidCallback onInfo;
  final VoidCallback onSharedTrip;
  final VoidCallback onSend;
  final ValueChanged<FriendChatShortcut> onShortcut;
  final VoidCallback onAttach;
  final VoidCallback onCamera;
  final VoidCallback onMic;
  final ValueChanged<FriendChatPlaceCard> onAddPlaceToTrip;
  final ValueChanged<FriendChatTripInviteCard> onJoinTrip;
  final ValueChanged<FriendChatTripInviteCard> onTripDetails;

  @override
  Widget build(BuildContext context) {
    final sharedTrip = thread.sharedTrip;
    return Column(
      children: [
        FriendChatHeader(peer: thread.peer, onBack: onBack, onInfo: onInfo),
        if (sharedTrip != null)
          FriendChatSharedTripBanner(
            sharedTrip: sharedTrip,
            onTap: onSharedTrip,
          ),
        Expanded(
          child: FriendChatMessageList(
            thread: thread,
            bottomInset: 8,
            onAddPlaceToTrip: onAddPlaceToTrip,
            onJoinTrip: onJoinTrip,
            onTripDetails: onTripDetails,
          ),
        ),
        FriendChatComposer(
          peerName: thread.peer.displayName.split(' ').first,
          shortcuts: thread.shortcuts,
          controller: composer,
          onSend: onSend,
          onShortcut: onShortcut,
          onAttach: onAttach,
          onCamera: onCamera,
          onMic: onMic,
        ),
      ],
    );
  }
}

class _LoadingScaffold extends StatelessWidget {
  const _LoadingScaffold();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Padding(
          padding: EdgeInsets.all(AppSpacing.md),
          child: Row(
            children: [
              AppSkeleton(width: 40, height: 40, radius: AppRadius.pill),
              SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppSkeleton(width: 140, height: 16, radius: 8),
                    SizedBox(height: 8),
                    AppSkeleton(width: 180, height: 12, radius: 8),
                  ],
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(AppSpacing.md),
            child: Column(
              children: [
                AppSkeleton(width: 160, height: 28, radius: AppRadius.pill),
                SizedBox(height: AppSpacing.md),
                AppSkeleton(
                  width: double.infinity,
                  height: 88,
                  radius: AppRadius.card,
                ),
                SizedBox(height: AppSpacing.sm),
                Align(
                  alignment: Alignment.centerRight,
                  child: AppSkeleton(
                    width: 220,
                    height: 72,
                    radius: AppRadius.card,
                  ),
                ),
                SizedBox(height: AppSpacing.sm),
                AppSkeleton(
                  width: double.infinity,
                  height: 160,
                  radius: AppRadius.card,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _ErrorHeader extends StatelessWidget {
  const _ErrorHeader({required this.onBack});

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: IconButton(
        onPressed: onBack,
        icon: const Icon(Icons.arrow_back_rounded),
        color: AppColors.textPrimary,
      ),
    );
  }
}
