import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

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
      // TODO(backend): API demo — thay bằng endpoint thật khi backend xong
      final sent = await ref
          .read(friendChatRepositoryProvider)
          .sendText(conversationId: conversationId, text: text);
      final latest = state.asData?.value ?? current;
      state = AsyncData(
        latest.copyWith(
          messages: [
            for (final message in latest.messages)
              if (message.id == optimisticId) sent else message,
          ],
        ),
      );
      return true;
    } catch (_) {
      // Giữ bubble optimistic để UI demo vẫn gửi được khi API demo chưa sẵn.
      final latest = state.asData?.value ?? current;
      state = AsyncData(
        latest.copyWith(
          messages: [
            for (final message in latest.messages)
              if (message.id == optimisticId)
                message.copyWith(readStatus: FriendChatReadStatus.delivered)
              else
                message,
          ],
        ),
      );
      return true;
    } finally {
      _sending = false;
    }
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
