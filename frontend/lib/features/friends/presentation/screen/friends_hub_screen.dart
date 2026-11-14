import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_frontend_v1/app/router/router_names.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_gradients.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_empty_view.dart';
import 'package:travel_frontend_v1/core/widget/app_error_view.dart';
import 'package:travel_frontend_v1/core/widget/app_pressable.dart';

import '../../application/friends_hub_controller.dart';
import '../../application/friends_hub_view.dart';
import '../../data/models/friends_hub_models.dart';
import '../widgets/friends_hub_friend_tile.dart';
import '../widgets/friends_hub_request_card.dart';
import '../widgets/friends_hub_search_bar.dart';
import '../widgets/friends_hub_sent_banner.dart';
import '../widgets/friends_hub_sent_request_tile.dart';
import '../widgets/friends_hub_skeleton.dart';
import '../widgets/friends_hub_tabs.dart';
import '../widgets/friends_hub_top_bar.dart';

class FriendsHubScreen extends ConsumerStatefulWidget {
  const FriendsHubScreen({super.key});

  @override
  ConsumerState<FriendsHubScreen> createState() => _FriendsHubScreenState();
}

class _FriendsHubScreenState extends ConsumerState<FriendsHubScreen> {
  late final TextEditingController _search;

  @override
  void initState() {
    super.initState();
    _search = TextEditingController();
  }

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(friendsHubControllerProvider);

    ref.listen(friendsHubControllerProvider, (previous, next) {
      final error = next.asData?.value.actionError;
      if (error == null) return;
      if (previous?.asData?.value.actionError == error) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(friendsHubFailureMessage(error))));
    });

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: DecoratedBox(
        decoration: const BoxDecoration(gradient: AppGradients.pageAtmosphere),
        child: SafeArea(
          child: Column(
            children: [
              FriendsHubTopBar(
                friendsCountLabel:
                    state.asData?.value.page.friendsCountLabel ??
                    'Bạn bè đồng hành',
                onBack: () => _back(context),
                onSearchTap: () => context.pushNamed(RouteNames.findFriends),
              ),
              Expanded(child: _body(context, state)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _body(BuildContext context, AsyncValue<FriendsHubViewState> state) {
    if (!state.hasValue && state.isLoading) {
      return const FriendsHubSkeleton();
    }
    if (state.hasError && !state.hasValue) {
      final unauthorized = friendsHubFailureIsUnauthorized(state.error!);
      return AppErrorView(
        title: unauthorized
            ? 'Phiên đăng nhập đã hết hạn'
            : 'Không tải được danh sách bạn bè',
        message: friendsHubFailureMessage(state.error!),
        actionLabel: 'Thử lại',
        onRetry: unauthorized
            ? null
            : () => ref.read(friendsHubControllerProvider.notifier).refresh(),
      );
    }

    final view = state.requireValue;
    return RefreshIndicator(
      color: AppColors.primary,
      onRefresh: () async {
        await ref.read(friendsHubControllerProvider.notifier).refresh();
      },
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.screenHorizontal,
          0,
          AppSpacing.screenHorizontal,
          AppSpacing.xl,
        ),
        children: [
          FriendsHubTabs(
            tab: view.tab,
            friendsCount: view.friendsCount,
            receivedCount: view.receivedCount,
            sentCount: view.sentCount,
            onChanged: (tab) =>
                ref.read(friendsHubControllerProvider.notifier).setTab(tab),
          ),
          const SizedBox(height: AppSpacing.md),
          FriendsHubSearchBar(
            controller: _search,
            onChanged: (value) =>
                ref.read(friendsHubControllerProvider.notifier).setQuery(value),
          ),
          const SizedBox(height: AppSpacing.lg),
          ...switch (view.tab) {
            FriendsHubTab.friends => _friendsTab(context, view),
            FriendsHubTab.received => _receivedTab(context, view),
            FriendsHubTab.sent => _sentTab(context, view),
          },
        ],
      ),
    );
  }

  List<Widget> _friendsTab(BuildContext context, FriendsHubViewState view) {
    final preview = view.receivedPreview;
    final friends = view.filteredFriends;
    return [
      if (view.receivedCount > 0) ...[
        Row(
          children: [
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.25),
                    blurRadius: 8,
                    spreadRadius: 2,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Text('Lời mời kết bạn', style: AppTypography.sectionTitle),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: AppColors.primaryLight,
                borderRadius: BorderRadius.circular(AppRadius.pill),
              ),
              child: Text(
                '${view.receivedCount} mới',
                style: AppTypography.badge.copyWith(color: AppColors.primary),
              ),
            ),
            const Spacer(),
            AppPressable(
              onTap: () => ref
                  .read(friendsHubControllerProvider.notifier)
                  .setTab(FriendsHubTab.received),
              child: Row(
                children: [
                  Text(
                    'Xem tất cả',
                    style: AppTypography.caption.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Icon(
                    Icons.chevron_right_rounded,
                    size: 16,
                    color: AppColors.primary,
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        for (final request in preview) ...[
          FriendsHubRequestCard(
            request: request,
            busy: view.busyRequestId == request.id,
            onAccept: () => ref
                .read(friendsHubControllerProvider.notifier)
                .acceptRequest(request.id),
            onReject: () => ref
                .read(friendsHubControllerProvider.notifier)
                .rejectRequest(request.id),
          ),
          const SizedBox(height: AppSpacing.sm),
        ],
        const SizedBox(height: AppSpacing.sm),
      ],
      FriendsHubSentBanner(
        count: view.sentCount,
        onReview: () => ref
            .read(friendsHubControllerProvider.notifier)
            .setTab(FriendsHubTab.sent),
      ),
      if (view.sentCount > 0) const SizedBox(height: AppSpacing.lg),
      Row(
        children: [
          Text('Tất cả bạn bè', style: AppTypography.sectionTitle),
          const SizedBox(width: 6),
          Text(
            '(${view.friendsCount})',
            style: AppTypography.caption.copyWith(
              color: AppColors.textTertiary,
            ),
          ),
          const Spacer(),
          _SortChip(
            label: 'Gần đây',
            selected: view.sort == FriendsHubSort.recent,
            onTap: () => ref
                .read(friendsHubControllerProvider.notifier)
                .setSort(FriendsHubSort.recent),
          ),
          const SizedBox(width: 6),
          _SortChip(
            label: 'A-Z',
            selected: view.sort == FriendsHubSort.az,
            onTap: () => ref
                .read(friendsHubControllerProvider.notifier)
                .setSort(FriendsHubSort.az),
          ),
          const SizedBox(width: 6),
          _SortChip(
            label: 'Online',
            selected: view.sort == FriendsHubSort.online,
            showOnlineDot: true,
            onTap: () => ref
                .read(friendsHubControllerProvider.notifier)
                .setSort(FriendsHubSort.online),
          ),
        ],
      ),
      const SizedBox(height: AppSpacing.sm),
      if (friends.isEmpty)
        Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.xl),
          child: AppEmptyView(
            title: 'Chưa có bạn bè',
            description: 'Tìm bạn đồng hành để bắt đầu kết nối.',
            actionLabel: 'Tìm bạn',
            onAction: () => context.pushNamed(RouteNames.findFriends),
          ),
        )
      else
        for (final friend in friends) ...[
          FriendsHubFriendTile(
            friend: friend,
            busy: view.busyFriendId == friend.friendId,
            onMessage: () => _openChat(context, friend),
            onMore: () => _showFriendActions(context, friend),
          ),
          const SizedBox(height: AppSpacing.sm),
        ],
      const SizedBox(height: AppSpacing.sm),
      Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xB3E0F0F9),
          borderRadius: BorderRadius.circular(AppRadius.card),
          border: Border.all(color: AppColors.borderBrandSoft),
        ),
        child: Row(
          children: [
            const Icon(Icons.sync_rounded, size: 18, color: AppColors.primary),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Text(
                view.page.syncNotice,
                style: AppTypography.caption.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ),
          ],
        ),
      ),
    ];
  }

  List<Widget> _receivedTab(BuildContext context, FriendsHubViewState view) {
    final items = view.filteredReceived;
    if (items.isEmpty) {
      return const [
        Padding(
          padding: EdgeInsets.symmetric(vertical: AppSpacing.xl),
          child: AppEmptyView(
            title: 'Không có lời mời',
            description: 'Khi có lời mời kết bạn mới, chúng sẽ hiện ở đây.',
          ),
        ),
      ];
    }
    return [
      for (final request in items) ...[
        FriendsHubRequestCard(
          request: request,
          busy: view.busyRequestId == request.id,
          onAccept: () => ref
              .read(friendsHubControllerProvider.notifier)
              .acceptRequest(request.id),
          onReject: () => ref
              .read(friendsHubControllerProvider.notifier)
              .rejectRequest(request.id),
        ),
        const SizedBox(height: AppSpacing.sm),
      ],
    ];
  }

  List<Widget> _sentTab(BuildContext context, FriendsHubViewState view) {
    final items = view.filteredSent;
    if (items.isEmpty) {
      return const [
        Padding(
          padding: EdgeInsets.symmetric(vertical: AppSpacing.xl),
          child: AppEmptyView(
            title: 'Chưa gửi lời mời nào',
            description: 'Các yêu cầu kết bạn bạn đã gửi sẽ hiện tại đây.',
          ),
        ),
      ];
    }
    return [
      for (final request in items) ...[
        FriendsHubSentRequestTile(
          request: request,
          busy: view.busyRequestId == request.id,
          onCancel: () => ref
              .read(friendsHubControllerProvider.notifier)
              .cancelRequest(request.id),
        ),
        const SizedBox(height: AppSpacing.sm),
      ],
    ];
  }

  Future<void> _openChat(BuildContext context, FriendsHubFriend friend) async {
    var conversationId = friend.conversationId;
    if (conversationId == null || conversationId.isEmpty) {
      conversationId = await ref
          .read(friendsHubControllerProvider.notifier)
          .openConversation(friend.friendId);
    }
    if (!context.mounted) return;
    if (conversationId == null || conversationId.isEmpty) return;
    context.pushNamed(
      RouteNames.friendChat,
      pathParameters: {'conversationId': conversationId},
    );
  }

  Future<void> _showFriendActions(
    BuildContext context,
    FriendsHubFriend friend,
  ) async {
    final action = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.chat_bubble_outline_rounded),
                title: const Text('Nhắn tin'),
                onTap: () => Navigator.pop(context, 'message'),
              ),
              ListTile(
                leading: const Icon(
                  Icons.person_remove_outlined,
                  color: AppColors.danger,
                ),
                title: Text(
                  'Hủy kết bạn',
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.danger,
                  ),
                ),
                onTap: () => Navigator.pop(context, 'remove'),
              ),
            ],
          ),
        );
      },
    );
    if (!context.mounted || action == null) return;
    if (action == 'message') {
      await _openChat(context, friend);
      return;
    }
    if (action == 'remove') {
      final confirmed = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Hủy kết bạn?'),
          content: Text(
            'Bạn sẽ không còn là bạn bè với ${friend.user.displayName}.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Huỷ'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Xác nhận'),
            ),
          ],
        ),
      );
      if (confirmed != true || !context.mounted) return;
      await ref
          .read(friendsHubControllerProvider.notifier)
          .removeFriend(friend.friendId);
    }
  }

  void _back(BuildContext context) {
    if (context.canPop()) {
      context.pop();
      return;
    }
    context.goNamed(RouteNames.social);
  }
}

class _SortChip extends StatelessWidget {
  const _SortChip({
    required this.label,
    required this.selected,
    required this.onTap,
    this.showOnlineDot = false,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;
  final bool showOnlineDot;

  @override
  Widget build(BuildContext context) {
    return AppPressable(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: selected ? AppColors.primary : AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.pill),
          border: Border.all(
            color: selected ? AppColors.primary : AppColors.borderBrandSoft,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (showOnlineDot) ...[
              Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  color: selected ? AppColors.textInverse : AppColors.success,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 4),
            ],
            Text(
              label,
              style: AppTypography.caption.copyWith(
                color: selected
                    ? AppColors.textInverse
                    : AppColors.textSecondary,
                fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
