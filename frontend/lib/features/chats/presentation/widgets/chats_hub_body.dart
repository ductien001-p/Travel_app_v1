import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_empty_view.dart';
import 'package:travel_frontend_v1/core/widget/app_search_bar.dart';

import '../../application/chats_hub_view.dart';
import '../../data/models/chats_hub_models.dart';
import 'chats_active_trip_banner.dart';
import 'chats_friend_thread_tile.dart';
import 'chats_hub_filter_pills.dart';
import 'chats_trip_thread_tile.dart';

class ChatsHubBody extends StatelessWidget {
  const ChatsHubBody({
    super.key,
    required this.view,
    required this.searchController,
    required this.onFilterSelected,
    required this.onSearchChanged,
    required this.onOpenTripChat,
    required this.onOpenFriendChat,
    this.onSearchFilterPressed,
    this.onSeeMoreFriends,
  });

  final ChatsHubViewState view;
  final TextEditingController searchController;
  final ValueChanged<ChatsHubFilter> onFilterSelected;
  final ValueChanged<String> onSearchChanged;
  final ValueChanged<ChatsTripThread> onOpenTripChat;
  final ValueChanged<ChatsFriendThread> onOpenFriendChat;
  final VoidCallback? onSearchFilterPressed;
  final VoidCallback? onSeeMoreFriends;

  @override
  Widget build(BuildContext context) {
    final trips = view.visibleTripThreads;
    final friends = view.visibleFriendThreads;
    final pulse = view.hub.activeTripPulse;

    return CustomScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(top: AppSpacing.sm),
            child: ChatsHubFilterPills(
              selected: view.filter,
              totalCount: view.hub.totalThreadCount,
              hasUnread: view.hub.hasUnread,
              onSelected: onFilterSelected,
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.screenHorizontal,
              AppSpacing.sm,
              AppSpacing.screenHorizontal,
              AppSpacing.xs,
            ),
            child: AppSearchBar(
              controller: searchController,
              hintText: 'Tìm kiếm tin nhắn, tên chuyến đi, thành viên...',
              onChanged: onSearchChanged,
              onFilterPressed: onSearchFilterPressed,
            ),
          ),
        ),
        if (view.showActivePulse && pulse != null)
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.screenHorizontal,
                AppSpacing.sm,
                AppSpacing.screenHorizontal,
                AppSpacing.md,
              ),
              child: ChatsActiveTripBanner(
                pulse: pulse,
                onOpenChat: () => onOpenTripChat(
                  ChatsTripThread(
                    id: pulse.tripId,
                    tripId: pulse.tripId,
                    title: pulse.title,
                    coverUrl: '',
                    badgeIcon: 'sailing',
                    status: ChatsTripThreadStatus.ongoing,
                    memberCount: pulse.onlineMemberCount,
                    memberLabel:
                        '${pulse.onlineMemberCount}/${pulse.memberCapacity}',
                    lastSenderName: pulse.pinnedSenderName,
                    lastMessage: pulse.pinnedMessage,
                    timeLabel: pulse.pinnedTimeLabel,
                    unreadCount: pulse.newExchangeCount,
                  ),
                ),
              ),
            ),
          ),
        if (view.isEmpty)
          const SliverFillRemaining(
            hasScrollBody: false,
            child: AppEmptyView(
              title: 'Chưa có đoạn chat',
              description:
                  'Tham gia chuyến đi hoặc kết bạn để bắt đầu trò chuyện.',
              icon: Icons.forum_outlined,
            ),
          )
        else ...[
          if (trips.isNotEmpty) ...[
            SliverToBoxAdapter(
              child: _SectionHeader(
                icon: Icons.luggage_rounded,
                title: 'Kênh Chat Chuyến Đi',
                trailing: '${trips.length} nhóm hoạt động',
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.screenHorizontal,
              ),
              sliver: SliverList.separated(
                itemCount: trips.length,
                separatorBuilder: (_, _) =>
                    const SizedBox(height: AppSpacing.sm),
                itemBuilder: (context, index) {
                  final thread = trips[index];
                  return ChatsTripThreadTile(
                    thread: thread,
                    onTap: () => onOpenTripChat(thread),
                  );
                },
              ),
            ),
          ],
          if (friends.isNotEmpty) ...[
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(
                  top: trips.isEmpty ? 0 : AppSpacing.md,
                ),
                child: _SectionHeader(
                  icon: Icons.forum_rounded,
                  title: 'Bạn Đồng Hành (1-on-1)',
                  actionLabel: 'Xem thêm',
                  onAction: onSeeMoreFriends,
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.screenHorizontal,
                0,
                AppSpacing.screenHorizontal,
                AppSpacing.safeBottom,
              ),
              sliver: SliverList.separated(
                itemCount: friends.length,
                separatorBuilder: (_, _) =>
                    const SizedBox(height: AppSpacing.xs),
                itemBuilder: (context, index) {
                  final thread = friends[index];
                  return ChatsFriendThreadTile(
                    thread: thread,
                    onTap: () => onOpenFriendChat(thread),
                  );
                },
              ),
            ),
          ] else
            const SliverToBoxAdapter(
              child: SizedBox(height: AppSpacing.safeBottom),
            ),
        ],
      ],
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.icon,
    required this.title,
    this.trailing,
    this.actionLabel,
    this.onAction,
  });

  final IconData icon;
  final String title;
  final String? trailing;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.screenHorizontal,
        AppSpacing.xs,
        AppSpacing.screenHorizontal,
        AppSpacing.sm,
      ),
      child: Row(
        children: [
          Icon(icon, size: 20, color: AppColors.primary),
          const SizedBox(width: AppSpacing.xs),
          Expanded(
            child: Text(
              title,
              style: AppTypography.sectionTitle.copyWith(fontSize: 18),
            ),
          ),
          if (trailing != null)
            Text(
              trailing!,
              style: AppTypography.caption.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          if (actionLabel != null)
            TextButton(
              onPressed: onAction,
              style: TextButton.styleFrom(
                foregroundColor: AppColors.primary,
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                actionLabel!,
                style: AppTypography.caption.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
