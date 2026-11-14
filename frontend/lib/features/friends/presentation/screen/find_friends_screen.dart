import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_frontend_v1/app/router/router_names.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_gradients.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_empty_view.dart';
import 'package:travel_frontend_v1/core/widget/app_error_view.dart';

import '../../application/find_friends_controller.dart';
import '../../application/find_friends_view.dart';
import '../../data/models/find_friends_models.dart';
import '../widgets/find_friends_dna_banner.dart';
import '../widgets/find_friends_nearby_card.dart';
import '../widgets/find_friends_recent_searches.dart';
import '../widgets/find_friends_result_card.dart';
import '../widgets/find_friends_skeleton.dart';
import '../widgets/find_friends_top_bar.dart';

class FindFriendsScreen extends ConsumerStatefulWidget {
  const FindFriendsScreen({super.key});

  @override
  ConsumerState<FindFriendsScreen> createState() => _FindFriendsScreenState();
}

class _FindFriendsScreenState extends ConsumerState<FindFriendsScreen> {
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
    final state = ref.watch(findFriendsControllerProvider);

    ref.listen(findFriendsControllerProvider, (previous, next) {
      final error = next.asData?.value.actionError;
      if (error == null) return;
      if (previous?.asData?.value.actionError == error) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(findFriendsFailureMessage(error))));
    });

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: DecoratedBox(
        decoration: const BoxDecoration(gradient: AppGradients.pageAtmosphere),
        child: SafeArea(
          child: Column(
            children: [
              FindFriendsTopBar(
                controller: _search,
                onBack: () => _back(context),
                onChanged: (value) {
                  setState(() {});
                  ref
                      .read(findFriendsControllerProvider.notifier)
                      .setQuery(value);
                },
                onClear: () {
                  _search.clear();
                  setState(() {});
                  ref.read(findFriendsControllerProvider.notifier).setQuery('');
                },
                onSubmitted: (value) {
                  ref
                      .read(findFriendsControllerProvider.notifier)
                      .submitQuery(value);
                },
              ),
              Expanded(child: _body(context, state)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _body(BuildContext context, AsyncValue<FindFriendsViewState> state) {
    if (!state.hasValue && state.isLoading) {
      return const FindFriendsSkeleton();
    }
    if (state.hasError && !state.hasValue) {
      final unauthorized = findFriendsFailureIsUnauthorized(state.error!);
      return AppErrorView(
        title: unauthorized
            ? 'Phiên đăng nhập đã hết hạn'
            : 'Không tải được tìm kiếm bạn bè',
        message: findFriendsFailureMessage(state.error!),
        actionLabel: 'Thử lại',
        onRetry: unauthorized
            ? null
            : () => ref.read(findFriendsControllerProvider.notifier).refresh(),
      );
    }

    final view = state.requireValue;
    return RefreshIndicator(
      color: AppColors.primary,
      onRefresh: () async {
        await ref.read(findFriendsControllerProvider.notifier).refresh();
      },
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.screenHorizontal,
          AppSpacing.xs,
          AppSpacing.screenHorizontal,
          AppSpacing.safeBottom,
        ),
        children: [
          FindFriendsRecentSearches(
            items: view.recentSearches,
            onTap: (term) {
              _search.text = term;
              setState(() {});
              ref
                  .read(findFriendsControllerProvider.notifier)
                  .applyRecentSearch(term);
            },
            onRemove: (term) {
              ref
                  .read(findFriendsControllerProvider.notifier)
                  .removeRecentSearch(term);
            },
            onClearAll: () {
              ref
                  .read(findFriendsControllerProvider.notifier)
                  .clearRecentSearches();
            },
          ),
          if (view.recentSearches.isNotEmpty)
            const SizedBox(height: AppSpacing.md),
          FindFriendsDnaBannerCard(
            banner: view.dnaBanner,
            onScan: () => context.pushNamed(RouteNames.travelDnaRadar),
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Gợi ý & Kết quả phù hợp',
                  style: AppTypography.sectionTitle,
                ),
              ),
              if (view.isSearching)
                const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: AppColors.primary,
                  ),
                )
              else
                Text(
                  view.matchCountLabel,
                  style: AppTypography.caption.copyWith(
                    color: AppColors.textTertiary,
                  ),
                ),
            ],
          ),
          if (view.searchError != null) ...[
            const SizedBox(height: AppSpacing.xs),
            Text(
              findFriendsFailureMessage(view.searchError!),
              style: AppTypography.caption.copyWith(color: AppColors.danger),
            ),
          ],
          const SizedBox(height: AppSpacing.sm),
          if (view.results.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: AppSpacing.xl),
              child: AppEmptyView(
                title: 'Không tìm thấy bạn bè',
                description:
                    'Thử tìm theo tên, username (@) hoặc gu du lịch khác.',
                icon: Icons.person_search_rounded,
              ),
            )
          else
            for (final user in view.results) ...[
              FindFriendsResultCard(
                user: user,
                busy: view.busyUserId == user.id,
                onAction: () => _onUserAction(context, user),
              ),
              const SizedBox(height: AppSpacing.sm),
            ],
          if (view.nearbySuggestions.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.sm),
            Row(
              children: [
                const Icon(
                  Icons.near_me_rounded,
                  size: 18,
                  color: AppColors.primary,
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    'Gợi ý gần bạn',
                    style: AppTypography.sectionTitle,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            Builder(
              builder: (context) {
                final nearby = view.nearbySuggestions.take(2).toList();
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (var i = 0; i < nearby.length; i++) ...[
                      if (i > 0) const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: FindFriendsNearbyCard(
                          suggestion: nearby[i],
                          busy: view.busyUserId == nearby[i].id,
                          onAction: () => _onNearbyAction(context, nearby[i]),
                        ),
                      ),
                    ],
                  ],
                );
              },
            ),
          ],
        ],
      ),
    );
  }

  Future<void> _onUserAction(BuildContext context, FindFriendsUser user) async {
    final notifier = ref.read(findFriendsControllerProvider.notifier);
    switch (user.action) {
      case FindFriendsAction.addFriend:
        await notifier.sendFriendRequest(user.id);
        return;
      case FindFriendsAction.requestSent:
        final requestId = user.friendRequestId;
        if (requestId == null || requestId.isEmpty) return;
        await notifier.cancelFriendRequest(
          userId: user.id,
          requestId: requestId,
        );
        return;
      case FindFriendsAction.message:
        var conversationId = user.conversationId;
        if (conversationId == null || conversationId.isEmpty) {
          conversationId = await notifier.openConversation(user.id);
        }
        if (!context.mounted) return;
        if (conversationId == null || conversationId.isEmpty) return;
        context.pushNamed(
          RouteNames.friendChat,
          pathParameters: {'conversationId': conversationId},
        );
        return;
      case FindFriendsAction.follow:
        await notifier.followUser(user.id);
        return;
      case FindFriendsAction.following:
        final confirmed = await _confirmUnfollow(
          context,
          displayName: user.displayName,
        );
        if (!confirmed || !context.mounted) return;
        await notifier.unfollowUser(user.id);
        return;
    }
  }

  Future<void> _onNearbyAction(
    BuildContext context,
    FindFriendsNearbySuggestion suggestion,
  ) async {
    final notifier = ref.read(findFriendsControllerProvider.notifier);
    switch (suggestion.action) {
      case FindFriendsAction.addFriend:
        await notifier.sendFriendRequest(suggestion.id);
        return;
      case FindFriendsAction.follow:
        await notifier.followUser(suggestion.id);
        return;
      case FindFriendsAction.requestSent:
        final requestId = suggestion.friendRequestId;
        if (requestId == null || requestId.isEmpty) return;
        await notifier.cancelFriendRequest(
          userId: suggestion.id,
          requestId: requestId,
        );
        return;
      case FindFriendsAction.following:
        final confirmed = await _confirmUnfollow(
          context,
          displayName: suggestion.displayName,
        );
        if (!confirmed || !context.mounted) return;
        await notifier.unfollowUser(suggestion.id);
        return;
      case FindFriendsAction.message:
        return;
    }
  }

  Future<bool> _confirmUnfollow(
    BuildContext context, {
    required String displayName,
  }) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Hủy theo dõi?'),
        content: Text('Bạn có chắc muốn hủy theo dõi $displayName không?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Giữ theo dõi'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: AppColors.danger),
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Hủy theo dõi'),
          ),
        ],
      ),
    );
    return confirmed ?? false;
  }

  void _back(BuildContext context) {
    if (context.canPop()) {
      context.pop();
      return;
    }
    context.goNamed(RouteNames.social);
  }
}
