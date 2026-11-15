import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/notification_models.dart';
import '../provider/notifications_provider.dart';

final notificationsControllerProvider =
    AsyncNotifierProvider.autoDispose<
      NotificationsController,
      NotificationPage
    >(NotificationsController.new);

class NotificationsController extends AsyncNotifier<NotificationPage> {
  @override
  Future<NotificationPage> build() {
    return ref.watch(notificationsRepositoryProvider).list();
  }

  Future<bool> refresh() async {
    final previous = state.asData?.value;
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(notificationsRepositoryProvider).list(),
    );
    if (state.hasError && previous != null) {
      state = AsyncData(previous);
      return false;
    }
    return !state.hasError;
  }

  Future<void> loadMore() async {
    final current = state.asData?.value;
    if (current == null || !current.hasMore || current.nextCursor == null) {
      return;
    }
    final page = await ref
        .read(notificationsRepositoryProvider)
        .list(cursor: current.nextCursor);
    final latest = state.asData?.value ?? current;
    state = AsyncData(
      latest.copyWith(
        items: [...latest.items, ...page.items],
        nextCursor: page.nextCursor,
        hasMore: page.hasMore,
        unreadCount: page.unreadCount,
      ),
    );
  }

  Future<bool> markRead(String id) async {
    final current = state.asData?.value;
    if (current == null) return false;
    try {
      final updated = await ref
          .read(notificationsRepositoryProvider)
          .markRead(id);
      final wasUnread = current.items.any(
        (item) => item.id == id && !item.isRead,
      );
      state = AsyncData(
        current.copyWith(
          items: [
            for (final item in current.items)
              if (item.id == id) updated else item,
          ],
          unreadCount: wasUnread
              ? (current.unreadCount - 1).clamp(0, 1 << 30)
              : current.unreadCount,
        ),
      );
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<bool> markAllRead() async {
    final current = state.asData?.value;
    if (current == null) return false;
    try {
      await ref.read(notificationsRepositoryProvider).markAllRead();
      state = AsyncData(
        current.copyWith(
          items: [
            for (final item in current.items) item.copyWith(isRead: true),
          ],
          unreadCount: 0,
        ),
      );
      return true;
    } catch (_) {
      return false;
    }
  }
}

String notificationsFailureMessage(Object error) {
  final text = error.toString().toLowerCase();
  if (text.contains('401') || text.contains('unauthorized')) {
    return 'Phiên đăng nhập đã hết hạn. Đăng nhập lại để xem thông báo.';
  }
  return 'Không tải được hộp thư. Thử lại sau.';
}

bool notificationsFailureIsUnauthorized(Object error) {
  final text = error.toString().toLowerCase();
  return text.contains('401') || text.contains('unauthorized');
}
