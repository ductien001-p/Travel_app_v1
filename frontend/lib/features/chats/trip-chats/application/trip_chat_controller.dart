import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_frontend_v1/core/providers/core_provider.dart';
import 'package:travel_frontend_v1/core/realtime/trip_socket_client.dart';

import '../data/models/trip_chat_models.dart';
import '../provider/trip_chat_provider.dart';

final tripChatControllerProvider = AsyncNotifierProvider.autoDispose
    .family<TripChatController, TripChatThread, String>(TripChatController.new);

class TripChatController extends AsyncNotifier<TripChatThread> {
  TripChatController(this.tripId);

  final String tripId;
  bool _sending = false;
  bool _joinedBefore = false;
  bool _typingEmitted = false;
  String? _viewerUserId;
  Timer? _typingStopTimer;

  @override
  Future<TripChatThread> build() async {
    _joinedBefore = false;
    _typingEmitted = false;
    _viewerUserId = null;
    _typingStopTimer?.cancel();

    final subscription = ref
        .watch(tripSocketClientProvider)
        .watchTrip(tripId)
        .listen(_onRoomEvent);
    ref.onDispose(() {
      _typingStopTimer?.cancel();
      if (_typingEmitted) {
        ref
            .read(tripSocketClientProvider)
            .emitTyping(tripId: tripId, isTyping: false);
      }
      subscription.cancel();
    });

    final thread = await ref
        .watch(tripChatRepositoryProvider)
        .getThread(tripId);
    _viewerUserId = _inferViewerUserId(thread.messages);
    unawaited(_markReadQuietly(tripId));
    return thread.copyWith(
      isSomeoneTyping: false,
      typingLabel: null,
      typingAvatarUrl: null,
    );
  }

  Future<bool> refresh() async {
    final previous = state.asData?.value;
    state = const AsyncLoading<TripChatThread>();
    state = await AsyncValue.guard(
      () => ref.read(tripChatRepositoryProvider).getThread(tripId),
    );
    if (state.hasError && previous != null) {
      state = AsyncData(previous);
      return false;
    }
    if (!state.hasError) {
      final thread = state.asData!.value;
      _viewerUserId = _inferViewerUserId(thread.messages) ?? _viewerUserId;
      state = AsyncData(
        thread.copyWith(
          isSomeoneTyping: false,
          typingLabel: null,
          typingAvatarUrl: null,
        ),
      );
      unawaited(_markReadQuietly(tripId));
    }
    return !state.hasError;
  }

  Future<bool> sendText(String raw) async {
    final text = raw.trim();
    if (text.isEmpty || _sending) return false;
    final current = state.asData?.value;
    if (current == null) return false;

    setTyping(false);
    _sending = true;
    final optimisticId = 'local-${DateTime.now().millisecondsSinceEpoch}';
    final optimistic = TripChatMessage(
      id: optimisticId,
      kind: TripChatMessageKind.text,
      isMine: true,
      text: text,
      timeLabel: _nowLabel(),
      readStatus: TripChatReadStatus.sent,
      showAvatar: false,
    );
    state = AsyncData(
      current.copyWith(
        messages: [...current.messages, optimistic],
        isSomeoneTyping: false,
        typingLabel: null,
        typingAvatarUrl: null,
      ),
    );

    try {
      final sent = await ref
          .read(tripChatRepositoryProvider)
          .sendText(tripId: tripId, text: text);
      _viewerUserId = sent.sender?.userId ?? _viewerUserId;
      final latest = state.asData?.value ?? current;
      final withoutDup = [
        for (final message in latest.messages)
          if (message.id != optimisticId && message.id != sent.id) message,
      ];
      state = AsyncData(latest.copyWith(messages: [...withoutDup, sent]));
      unawaited(_markReadQuietly(tripId));
      return true;
    } catch (_) {
      final latest = state.asData?.value ?? current;
      state = AsyncData(
        latest.copyWith(
          messages: [
            for (final message in latest.messages)
              if (message.id != optimisticId) message,
          ],
        ),
      );
      return false;
    } finally {
      _sending = false;
    }
  }

  Future<bool> sendImage(String mediaId) async {
    final id = mediaId.trim();
    if (id.isEmpty || _sending) return false;
    final current = state.asData?.value;
    if (current == null) return false;

    setTyping(false);
    _sending = true;
    try {
      final sent = await ref
          .read(tripChatRepositoryProvider)
          .sendImage(tripId: tripId, mediaId: id);
      _viewerUserId = sent.sender?.userId ?? _viewerUserId;
      final latest = state.asData?.value ?? current;
      if (latest.messages.any((message) => message.id == sent.id)) {
        return true;
      }
      state = AsyncData(
        latest.copyWith(messages: [...latest.messages, sent]),
      );
      unawaited(_markReadQuietly(tripId));
      return true;
    } catch (_) {
      return false;
    } finally {
      _sending = false;
    }
  }

  Future<void> toggleReaction({
    required String messageId,
    required String emoji,
    required bool remove,
  }) async {
    if (messageId.startsWith('local-')) return;
    try {
      final reactions = remove
          ? await ref
                .read(tripChatRepositoryProvider)
                .removeReaction(
                  tripId: tripId,
                  messageId: messageId,
                  emoji: emoji,
                )
          : await ref
                .read(tripChatRepositoryProvider)
                .addReaction(
                  tripId: tripId,
                  messageId: messageId,
                  emoji: emoji,
                );
      _applyReactions(messageId, [
        for (final reaction in reactions) reaction.toJson(),
      ]);
    } catch (_) {
      // Giữ reactions hiện tại nếu request thất bại.
    }
  }

  void setTyping(bool isTyping) {
    final socket = ref.read(tripSocketClientProvider);
    _typingStopTimer?.cancel();
    if (isTyping) {
      if (!_typingEmitted) {
        socket.emitTyping(tripId: tripId, isTyping: true);
        _typingEmitted = true;
      }
      _typingStopTimer = Timer(const Duration(seconds: 2), () {
        setTyping(false);
      });
      return;
    }
    if (_typingEmitted) {
      socket.emitTyping(tripId: tripId, isTyping: false);
      _typingEmitted = false;
    }
  }

  void _onRoomEvent(TripRoomEvent event) {
    switch (event) {
      case TripRoomJoined():
        if (_joinedBefore) unawaited(refresh());
        _joinedBefore = true;
      case TripRoomLeft():
      case TripRoomRejected():
      case TripTimelinePushed():
        break;
      case TripChatMessagePushed(:final message):
        _applyRemoteMessage(message);
      case TripChatTypingPushed(
        :final userId,
        :final isTyping,
        :final typingLabel,
        :final typingAvatarUrl,
      ):
        _applyTyping(
          userId: userId,
          isTyping: isTyping,
          typingLabel: typingLabel,
          typingAvatarUrl: typingAvatarUrl,
        );
      case TripChatReactionPushed(:final messageId, :final reactions):
        _applyReactions(messageId, reactions);
    }
  }

  void _applyRemoteMessage(Map<String, dynamic> raw) {
    final current = state.asData?.value;
    if (current == null) return;

    final parsed = _tryParseUiMessage(raw);
    if (parsed == null) {
      unawaited(refresh());
      return;
    }

    final message = _withViewerPerspective(parsed);
    if (current.messages.any((item) => item.id == message.id)) return;

    if (message.isMine && message.sender?.userId != null) {
      _viewerUserId = message.sender!.userId;
    }

    state = AsyncData(
      current.copyWith(
        messages: [...current.messages, message],
        isSomeoneTyping: false,
        typingLabel: null,
        typingAvatarUrl: null,
      ),
    );
    if (!message.isMine) {
      unawaited(_markReadQuietly(tripId));
    }
  }

  void _applyTyping({
    required String userId,
    required bool isTyping,
    required String? typingLabel,
    required String? typingAvatarUrl,
  }) {
    if (_viewerUserId != null && userId == _viewerUserId) return;
    final current = state.asData?.value;
    if (current == null) return;
    state = AsyncData(
      current.copyWith(
        isSomeoneTyping: isTyping,
        typingLabel: isTyping ? typingLabel : null,
        typingAvatarUrl: isTyping ? typingAvatarUrl : null,
      ),
    );
  }

  void _applyReactions(
    String messageId,
    List<Map<String, dynamic>> rawReactions,
  ) {
    final current = state.asData?.value;
    if (current == null) return;
    final reactions = [
      for (final item in rawReactions) TripChatReaction.fromJson(item),
    ];
    state = AsyncData(
      current.copyWith(
        messages: [
          for (final message in current.messages)
            if (message.id == messageId)
              message.copyWith(
                reactions: reactions,
                photo: message.photo?.copyWith(reactions: reactions),
              )
            else
              message,
        ],
      ),
    );
  }

  TripChatMessage? _tryParseUiMessage(Map<String, dynamic> raw) {
    if (raw['kind'] is! String) return null;
    try {
      return TripChatMessage.fromJson(raw);
    } catch (_) {
      return null;
    }
  }

  TripChatMessage _withViewerPerspective(TripChatMessage message) {
    final viewerId = _viewerUserId;
    if (viewerId == null || message.sender == null) return message;
    final isMine = message.sender!.userId == viewerId;
    if (isMine == message.isMine) return message;
    return message.copyWith(
      isMine: isMine,
      showAvatar: isMine ? false : message.showAvatar,
      readStatus: isMine
          ? (message.readStatus ?? TripChatReadStatus.delivered)
          : null,
    );
  }

  String? _inferViewerUserId(List<TripChatMessage> messages) {
    for (final message in messages) {
      if (message.isMine && message.sender?.userId != null) {
        return message.sender!.userId;
      }
    }
    return null;
  }

  Future<void> _markReadQuietly(String id) async {
    try {
      await ref.read(tripChatRepositoryProvider).markRead(id);
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

String tripChatFailureMessage(Object error) {
  final text = error.toString();
  if (text.toLowerCase().contains('401') ||
      text.toLowerCase().contains('unauthorized')) {
    return 'Phiên đăng nhập đã hết hạn. Đăng nhập lại để xem chat nhóm.';
  }
  if (text.toLowerCase().contains('403') ||
      text.toLowerCase().contains('forbidden')) {
    return 'Bạn không có quyền xem chat chuyến đi này.';
  }
  return 'Không tải được chat chuyến đi. Thử lại sau.';
}

bool tripChatFailureIsUnauthorized(Object error) {
  final text = error.toString().toLowerCase();
  return text.contains('401') || text.contains('unauthorized');
}
