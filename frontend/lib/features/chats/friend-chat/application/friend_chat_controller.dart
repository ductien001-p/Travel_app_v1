import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_frontend_v1/core/providers/core_provider.dart';
import 'package:travel_frontend_v1/core/realtime/friend_socket_client.dart';

import '../data/friend_chat_socket_message.dart';
import '../data/models/friend_chat_models.dart';
import '../provider/friend_chat_provider.dart';

final friendChatControllerProvider = AsyncNotifierProvider.autoDispose
    .family<FriendChatController, FriendChatThread, String>(
      FriendChatController.new,
    );

class FriendChatController extends AsyncNotifier<FriendChatThread> {
  FriendChatController(this.conversationId);

  final String conversationId;
  bool _sending = false;

  @override
  Future<FriendChatThread> build() async {
    final subscription = ref
        .watch(friendSocketClientProvider)
        .watchConversation(conversationId)
        .listen(_onSocketMessage);
    ref.onDispose(() {
      subscription.cancel();
    });

    final thread = await ref
        .watch(friendChatRepositoryProvider)
        .getThread(conversationId);
    unawaited(_markReadQuietly(conversationId));
    return thread;
  }

  Future<bool> refresh() async {
    final previous = state.asData?.value;
    state = const AsyncLoading<FriendChatThread>();
    state = await AsyncValue.guard(
      () => ref.read(friendChatRepositoryProvider).getThread(conversationId),
    );
    if (state.hasError && previous != null) {
      state = AsyncData(previous);
      return false;
    }
    if (!state.hasError) {
      unawaited(_markReadQuietly(conversationId));
    }
    return !state.hasError;
  }

  Future<bool> sendText(String raw) async {
    final text = raw.trim();
    if (text.isEmpty || _sending) return false;
    final current = state.asData?.value;
    if (current == null) return false;

    _sending = true;
    final optimisticId = 'local-${DateTime.now().millisecondsSinceEpoch}';
    final optimistic = FriendChatMessage(
      id: optimisticId,
      kind: FriendChatMessageKind.text,
      isMine: true,
      text: text,
      timeLabel: _nowLabel(),
      readStatus: FriendChatReadStatus.sent,
      showAvatar: false,
    );
    state = AsyncData(
      current.copyWith(
        messages: [...current.messages, optimistic],
        isPeerTyping: false,
      ),
    );

    try {
      final sent = await ref
          .read(friendChatRepositoryProvider)
          .sendText(conversationId: conversationId, text: text);
      _replaceOptimistic(optimisticId, sent);
      return true;
    } catch (_) {
      final latest = state.asData?.value ?? current;
      state = AsyncData(
        latest.copyWith(
          messages: [
            for (final message in latest.messages)
              if (message.id == optimisticId)
                message.copyWith(readStatus: FriendChatReadStatus.failed)
              else
                message,
          ],
        ),
      );
      return false;
    } finally {
      _sending = false;
    }
  }

  Future<bool> sendTripInvite(FriendChatInviteCandidate candidate) async {
    if (_sending) return false;
    final current = state.asData?.value;
    if (current == null) return false;

    _sending = true;
    try {
      final sent = await ref
          .read(friendChatRepositoryProvider)
          .sendTripInvite(conversationId: conversationId, candidate: candidate);
      final latest = state.asData?.value ?? current;
      if (latest.messages.any((message) => message.id == sent.id)) {
        return true;
      }
      state = AsyncData(
        latest.copyWith(messages: [...latest.messages, sent]),
      );
      return true;
    } catch (_) {
      return false;
    } finally {
      _sending = false;
    }
  }

  void _onSocketMessage(FriendMessagePushed event) {
    final current = state.asData?.value;
    if (current == null) return;
    final parsed = friendChatMessageFromSocket(
      event.message,
      peerUserId: current.peer.userId,
    );
    if (parsed == null) return;
    if (current.messages.any((message) => message.id == parsed.id)) return;
    state = AsyncData(
      current.copyWith(messages: [...current.messages, parsed]),
    );
    if (!parsed.isMine) {
      unawaited(_markReadQuietly(conversationId));
    }
  }

  void _replaceOptimistic(String optimisticId, FriendChatMessage sent) {
    final latest = state.asData?.value;
    if (latest == null) return;
    final withoutDup = [
      for (final message in latest.messages)
        if (message.id != optimisticId && message.id != sent.id) message,
    ];
    state = AsyncData(latest.copyWith(messages: [...withoutDup, sent]));
  }

  Future<void> _markReadQuietly(String id) async {
    try {
      await ref.read(friendChatRepositoryProvider).markRead(id);
    } catch (_) {
      // Không chặn UI nếu đánh dấu đã đọc thất bại.
    }
  }

  String _nowLabel() {
    final now = DateTime.now();
    final hour = now.hour.toString().padLeft(2, '0');
    final minute = now.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}

String friendChatFailureMessage(Object error) {
  final text = error.toString();
  if (text.toLowerCase().contains('401') ||
      text.toLowerCase().contains('unauthorized')) {
    return 'Phiên đăng nhập đã hết hạn. Đăng nhập lại để xem đoạn chat.';
  }
  return 'Không tải được hội thoại. Thử lại sau.';
}

bool friendChatFailureIsUnauthorized(Object error) {
  final text = error.toString().toLowerCase();
  return text.contains('401') || text.contains('unauthorized');
}
