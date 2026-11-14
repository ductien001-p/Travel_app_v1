import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_frontend_v1/app/router/router_names.dart';
import 'package:travel_frontend_v1/core/testing/e2e_keys.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_gradients.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_avatar.dart';
import 'package:travel_frontend_v1/core/widget/app_error_view.dart';
import 'package:travel_frontend_v1/core/widget/app_icon_button.dart';
import 'package:travel_frontend_v1/core/widget/app_skeleton.dart';
import 'package:travel_frontend_v1/features/profile/application/profile_controller.dart';

import '../../application/chats_hub_controller.dart';
import '../../application/chats_hub_view.dart';
import '../../data/models/chats_hub_models.dart';
import '../widgets/chats_hub_body.dart';

class ChatsHubScreen extends ConsumerStatefulWidget {
  const ChatsHubScreen({super.key});

  @override
  ConsumerState<ChatsHubScreen> createState() => _ChatsHubScreenState();
}

class _ChatsHubScreenState extends ConsumerState<ChatsHubScreen> {
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
    final hubState = ref.watch(chatsHubControllerProvider);
    final profile = ref.watch(profileControllerProvider).asData?.value;

    return Scaffold(
      key: E2eKeys.chatsHubScreenRoot,
      backgroundColor: Colors.transparent,
      body: DecoratedBox(
        decoration: const BoxDecoration(gradient: AppGradients.pageAtmosphere),
        child: SafeArea(
          child: Column(
            children: [
              _Header(
                displayName: profile?.displayName,
                avatarUrl: profile?.avatarUrl,
                viewer: hubState.asData?.value.hub.viewer,
                onSearchFocus: () {
                  // Search field is already on-screen; keep affordance for Stitch.
                },
                onCreateChat: _comingSoon,
              ),
              Expanded(child: _body(hubState)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _body(AsyncValue<ChatsHubViewState> hubState) {
    if (!hubState.hasValue && hubState.isLoading) {
      return const _Skeleton();
    }
    if (hubState.hasError && !hubState.hasValue) {
      final unauthorized = chatsHubFailureIsUnauthorized(hubState.error!);
      return AppErrorView(
        title: unauthorized
            ? 'Phiên đăng nhập đã hết hạn'
            : 'Không tải được tin nhắn',
        message: chatsHubFailureMessage(hubState.error!),
        actionLabel: 'Thử lại',
        onRetry: unauthorized
            ? null
            : () => ref.read(chatsHubControllerProvider.notifier).refresh(),
      );
    }

    final view = hubState.requireValue;
    return RefreshIndicator(
      color: AppColors.primary,
      onRefresh: () async {
        await ref.read(chatsHubControllerProvider.notifier).refresh();
      },
      child: ChatsHubBody(
        view: view,
        searchController: _search,
        onFilterSelected: (filter) =>
            ref.read(chatsHubControllerProvider.notifier).selectFilter(filter),
        onSearchChanged: (query) =>
            ref.read(chatsHubControllerProvider.notifier).setSearchQuery(query),
        onOpenTripChat: (thread) {
          context.pushNamed(
            RouteNames.tripChat,
            pathParameters: {'tripId': thread.tripId},
          );
        },
        onOpenFriendChat: (thread) {
          context.pushNamed(
            RouteNames.friendChat,
            pathParameters: {'conversationId': thread.conversationId},
          );
        },
        onSearchFilterPressed: _comingSoon,
        onSeeMoreFriends: _comingSoon,
      ),
    );
  }

  void _comingSoon() {
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Tính năng đang phát triển')));
  }
}

class _Header extends StatelessWidget {
  const _Header({
    required this.onSearchFocus,
    required this.onCreateChat,
    this.displayName,
    this.avatarUrl,
    this.viewer,
  });

  final String? displayName;
  final String? avatarUrl;
  final ChatsHubViewer? viewer;
  final VoidCallback onSearchFocus;
  final VoidCallback onCreateChat;

  @override
  Widget build(BuildContext context) {
    final name = (displayName?.trim().isNotEmpty ?? false)
        ? displayName!.trim()
        : (viewer?.displayName ?? 'Bạn');
    final imageUrl = avatarUrl ?? viewer?.avatarUrl;
    final online = viewer?.isOnline ?? true;

    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
        child: Container(
          height: 64,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.screenHorizontal,
          ),
          decoration: BoxDecoration(
            color: AppColors.glass85,
            boxShadow: [
              BoxShadow(
                color: AppColors.black03,
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              SizedBox(
                width: 40,
                height: 40,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    DecoratedBox(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight,
                          colors: [Color(0xFF006A66), Color(0xFF99F2EC)],
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(2),
                        child: AppAvatar(
                          size: 36,
                          imageUrl: imageUrl,
                          initials: _initials(name),
                        ),
                      ),
                    ),
                    if (online)
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.surface,
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Tin Nhắn', style: AppTypography.screenTitle),
                    Text(
                      'Teal Horizon Hub',
                      style: AppTypography.caption.copyWith(
                        fontSize: 11,
                        height: 1,
                      ),
                    ),
                  ],
                ),
              ),
              AppIconButton(
                icon: Icons.search_rounded,
                onPressed: onSearchFocus,
                semanticLabel: 'Tìm kiếm',
              ),
              const SizedBox(width: 6),
              Material(
                color: AppColors.primary,
                shape: const CircleBorder(),
                child: InkWell(
                  customBorder: const CircleBorder(),
                  onTap: onCreateChat,
                  child: const SizedBox(
                    width: 36,
                    height: 36,
                    child: Icon(
                      Icons.edit_outlined,
                      size: 19,
                      color: AppColors.textInverse,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _initials(String name) {
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty || parts.first.isEmpty) return '?';
    if (parts.length == 1) return parts.first[0].toUpperCase();
    final a = parts.first[0];
    final b = parts.last.isEmpty ? '' : parts.last[0];
    return '$a$b'.toUpperCase();
  }
}

class _Skeleton extends StatelessWidget {
  const _Skeleton();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.screenHorizontal),
      children: [
        const AppSkeleton(
          width: double.infinity,
          height: 36,
          radius: AppRadius.pill,
        ),
        const SizedBox(height: AppSpacing.sm),
        const AppSkeleton(
          width: double.infinity,
          height: 44,
          radius: AppRadius.pill,
        ),
        const SizedBox(height: AppSpacing.md),
        const AppSkeleton(
          width: double.infinity,
          height: 160,
          radius: AppRadius.cardLarge,
        ),
        const SizedBox(height: AppSpacing.md),
        for (var i = 0; i < 4; i++) ...[
          const AppSkeleton(
            width: double.infinity,
            height: 88,
            radius: AppRadius.cardLarge,
          ),
          const SizedBox(height: AppSpacing.sm),
        ],
      ],
    );
  }
}
