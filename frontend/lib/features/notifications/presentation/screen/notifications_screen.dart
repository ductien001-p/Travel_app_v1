import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_frontend_v1/app/router/router_names.dart';
import 'package:travel_frontend_v1/core/testing/e2e_keys.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_gradients.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_error_view.dart';
import 'package:travel_frontend_v1/core/widget/app_skeleton.dart';
import 'package:travel_frontend_v1/features/home/application/explore_home_controller.dart';
import 'package:travel_frontend_v1/features/social/application/social_feed_controller.dart';

import '../../application/notification_destination.dart';
import '../../application/notifications_controller.dart';
import '../../data/models/notification_models.dart';

class NotificationsScreen extends ConsumerWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final inbox = ref.watch(notificationsControllerProvider);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: DecoratedBox(
        decoration: const BoxDecoration(gradient: AppGradients.pageAtmosphere),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  4,
                  AppSpacing.xs,
                  AppSpacing.sm,
                  AppSpacing.xs,
                ),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => context.pop(),
                      icon: const Icon(Icons.arrow_back_rounded),
                      color: AppColors.textPrimary,
                    ),
                    Expanded(
                      child: Text(
                        'Thông báo',
                        key: E2eKeys.notificationsScreenTitle,
                        style: AppTypography.cardTitle.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: inbox.asData?.value.unreadCount == 0
                          ? null
                          : () => _markAll(context, ref),
                      child: const Text('Đọc hết'),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: inbox.when(
                  loading: () => const _LoadingList(),
                  error: (error, _) => AppErrorView(
                    title: notificationsFailureIsUnauthorized(error)
                        ? 'Phiên đăng nhập đã hết hạn'
                        : 'Không tải được hộp thư',
                    message: notificationsFailureMessage(error),
                    actionLabel: 'Thử lại',
                    onRetry: notificationsFailureIsUnauthorized(error)
                        ? null
                        : () => ref
                              .read(notificationsControllerProvider.notifier)
                              .refresh(),
                  ),
                  data: (page) {
                    if (page.items.isEmpty) {
                      return const Center(child: Text('Chưa có thông báo.'));
                    }
                    return RefreshIndicator(
                      color: AppColors.primary,
                      onRefresh: () => ref
                          .read(notificationsControllerProvider.notifier)
                          .refresh(),
                      child: ListView.separated(
                        physics: const AlwaysScrollableScrollPhysics(),
                        padding: const EdgeInsets.fromLTRB(
                          AppSpacing.md,
                          AppSpacing.sm,
                          AppSpacing.md,
                          AppSpacing.lg,
                        ),
                        itemCount: page.items.length + (page.hasMore ? 1 : 0),
                        separatorBuilder: (_, _) =>
                            const SizedBox(height: AppSpacing.sm),
                        itemBuilder: (context, index) {
                          if (index >= page.items.length) {
                            return TextButton(
                              onPressed: () => ref
                                  .read(
                                    notificationsControllerProvider.notifier,
                                  )
                                  .loadMore(),
                              child: const Text('Xem thêm'),
                            );
                          }
                          final item = page.items[index];
                          return _NotificationTile(
                            item: item,
                            onTap: () => _open(context, ref, item),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _markAll(BuildContext context, WidgetRef ref) async {
    final ok = await ref
        .read(notificationsControllerProvider.notifier)
        .markAllRead();
    if (!ok || !context.mounted) return;
    _refreshSurfaces(ref);
  }

  Future<void> _open(
    BuildContext context,
    WidgetRef ref,
    AppNotification item,
  ) async {
    if (!item.isRead) {
      final ok = await ref
          .read(notificationsControllerProvider.notifier)
          .markRead(item.id);
      if (ok) _refreshSurfaces(ref);
    }
    if (!context.mounted) return;
    final destination = notificationDestination(
      type: item.type,
      tripId: item.tripId,
    );
    switch (destination.target) {
      case NotificationOpenTarget.joinRequests:
        context.pushNamed(
          RouteNames.tripJoinRequests,
          pathParameters: {'tripId': destination.tripId!},
        );
      case NotificationOpenTarget.tripDetail:
        context.pushNamed(
          RouteNames.tripDetail,
          pathParameters: {'tripId': destination.tripId!},
        );
      case NotificationOpenTarget.none:
        break;
    }
  }

  void _refreshSurfaces(WidgetRef ref) {
    ref.invalidate(exploreHomeControllerProvider);
    ref.invalidate(socialFeedControllerProvider);
  }
}

class _NotificationTile extends StatelessWidget {
  const _NotificationTile({required this.item, required this.onTap});

  final AppNotification item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: item.isRead
          ? AppColors.surface.withValues(alpha: 0.7)
          : AppColors.primaryLight.withValues(alpha: 0.55),
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.title,
                style: AppTypography.cardTitle.copyWith(
                  fontWeight: item.isRead ? FontWeight.w600 : FontWeight.w800,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                item.message,
                style: AppTypography.body.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                _label(item.createdAt),
                style: AppTypography.caption.copyWith(
                  color: AppColors.textTertiary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _label(DateTime time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '${time.day}/${time.month} $hour:$minute';
  }
}

class _LoadingList extends StatelessWidget {
  const _LoadingList();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(AppSpacing.md),
      child: Column(
        children: [
          AppSkeleton(width: double.infinity, height: 84, radius: 16),
          SizedBox(height: AppSpacing.sm),
          AppSkeleton(width: double.infinity, height: 84, radius: 16),
        ],
      ),
    );
  }
}
