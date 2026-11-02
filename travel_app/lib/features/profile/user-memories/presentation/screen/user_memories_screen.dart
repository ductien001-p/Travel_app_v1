import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';
import 'package:travel_frontend_v1/app/router/router_names.dart';
import 'package:travel_frontend_v1/core/networks/api_exception.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_bottom_sheet.dart';
import 'package:travel_frontend_v1/core/widget/app_error_view.dart';
import 'package:travel_frontend_v1/core/widget/app_icon_button.dart';
import 'package:travel_frontend_v1/core/widget/app_scaffold.dart';
import 'package:travel_frontend_v1/core/widget/app_skeleton.dart';

import '../../application/user_memories_controller.dart';
import '../../application/user_memories_view.dart';
import '../../data/models/user_memories_models.dart';
import '../widgets/user_memories_body.dart';
import '../widgets/user_memories_manage_sheet.dart';
import 'user_memory_viewer_screen.dart';

class UserMemoriesScreen extends ConsumerWidget {
  const UserMemoriesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final galleryState = ref.watch(userMemoriesControllerProvider);
    final filter = ref.watch(userMemoriesFilterProvider);
    final gallery = galleryState.value;

    return AppScaffold(
      topBar: _TopBar(
        subtitle: gallery == null ? null : userMemoriesSubtitle(gallery),
        searchOpen: filter.searchOpen,
        layout: filter.layout,
        onBack: () => _back(context),
        onToggleSearch: () =>
            ref.read(userMemoriesFilterProvider.notifier).toggleSearch(),
        onToggleLayout: () =>
            ref.read(userMemoriesFilterProvider.notifier).toggleLayout(),
      ),
      body: _body(context, ref, galleryState, filter),
    );
  }

  Widget _body(
    BuildContext context,
    WidgetRef ref,
    AsyncValue<UserMemoriesState> galleryState,
    UserMemoriesFilterState filter,
  ) {
    if (!galleryState.hasValue && galleryState.isLoading) {
      return const _Skeleton();
    }
    if (galleryState.hasError && !galleryState.hasValue) {
      return _Failure(
        error: galleryState.error!,
        onRetry: () =>
            ref.read(userMemoriesControllerProvider.notifier).refresh(),
      );
    }
    final gallery = galleryState.requireValue;
    return RefreshIndicator(
      color: AppColors.primary,
      onRefresh: () => _refresh(context, ref),
      child: UserMemoriesBody(
        gallery: gallery,
        filter: filter,
        onSelectTrip: (tripId) =>
            ref.read(userMemoriesFilterProvider.notifier).selectTrip(tripId),
        onQueryChanged: (value) =>
            ref.read(userMemoriesFilterProvider.notifier).setQuery(value),
        onManage: () => _manage(context, ref, gallery.collections),
        onOpenHighlight: () {
          final highlight = gallery.highlight;
          if (highlight == null) return;
          _open(context, highlight);
        },
        onLikeHighlight: () => _like(context, ref, gallery.highlight?.id),
        onShareHighlight: () {
          final highlight = gallery.highlight;
          if (highlight == null) return;
          _share(context, highlight);
        },
        onOpenItem: (item) => _open(context, item),
        onLikeItem: (item) => _like(context, ref, item.id),
        onLoadMore: () =>
            ref.read(userMemoriesControllerProvider.notifier).loadMore(),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar({
    required this.onBack,
    required this.onToggleSearch,
    required this.onToggleLayout,
    required this.searchOpen,
    required this.layout,
    this.subtitle,
  });

  final VoidCallback onBack;
  final VoidCallback onToggleSearch;
  final VoidCallback onToggleLayout;
  final bool searchOpen;
  final UserMemoriesLayout layout;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.screenHorizontal,
      ),
      child: SizedBox(
        height: 64,
        child: Row(
          children: [
            AppIconButton(
              icon: Icons.arrow_back_rounded,
              iconColor: AppColors.primary,
              semanticLabel: 'Quay lại',
              onPressed: onBack,
            ),
            const SizedBox(width: AppSpacing.xs),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Khoảnh Khắc Hành Trình',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.cardTitle.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  if (subtitle != null)
                    Text(
                      subtitle!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.caption.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.xs),
            AppIconButton(
              icon: layout == UserMemoriesLayout.bento
                  ? Icons.grid_view_rounded
                  : Icons.view_agenda_outlined,
              semanticLabel: 'Đổi chế độ xem',
              onPressed: onToggleLayout,
            ),
            const SizedBox(width: AppSpacing.xxs),
            AppIconButton(
              icon: searchOpen ? Icons.close_rounded : Icons.search_rounded,
              semanticLabel: searchOpen ? 'Đóng tìm kiếm' : 'Tìm kiếm kỷ niệm',
              onPressed: onToggleSearch,
            ),
          ],
        ),
      ),
    );
  }
}

class _Skeleton extends StatelessWidget {
  const _Skeleton();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.screenHorizontal),
      children: const [
        AppSkeleton(width: double.infinity, height: 36),
        SizedBox(height: AppSpacing.lg),
        AppSkeleton(width: double.infinity, height: 320),
        SizedBox(height: AppSpacing.md),
        AppSkeleton(width: double.infinity, height: 180),
      ],
    );
  }
}

class _Failure extends StatelessWidget {
  const _Failure({required this.error, required this.onRetry});

  final Object error;
  final Future<bool> Function() onRetry;

  @override
  Widget build(BuildContext context) {
    final failure = error;
    final unauthorized = failure is ApiException && failure.statusCode == 401;
    final message = unauthorized
        ? 'Đăng nhập lại để xem khoảnh khắc hành trình.'
        : failure is ApiException
        ? failure.message
        : 'Đã xảy ra lỗi. Vui lòng thử lại.';
    return AppErrorView(
      title: unauthorized
          ? 'Phiên đăng nhập đã hết hạn'
          : 'Không thể tải khoảnh khắc',
      message: message,
      actionLabel: 'Thử lại',
      onRetry: unauthorized ? null : () => onRetry(),
    );
  }
}

void _back(BuildContext context) {
  if (context.canPop()) {
    context.pop();
    return;
  }
  context.goNamed(RouteNames.profile);
}

Future<void> _refresh(BuildContext context, WidgetRef ref) async {
  final ok = await ref.read(userMemoriesControllerProvider.notifier).refresh();
  if (!ok && context.mounted) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Không tải lại được khoảnh khắc hành trình.'),
      ),
    );
  }
}

Future<void> _manage(
  BuildContext context,
  WidgetRef ref,
  List<UserMemoryCollection> collections,
) async {
  final tripId = await showAppBottomSheet<String>(
    context: context,
    child: UserMemoriesManageSheet(collections: collections),
  );
  if (tripId == null) return;
  ref.read(userMemoriesFilterProvider.notifier).selectTrip(tripId);
}

Future<void> _like(BuildContext context, WidgetRef ref, String? id) async {
  if (id == null) return;
  try {
    await ref.read(userMemoriesControllerProvider.notifier).toggleLike(id);
  } on ApiException catch (error) {
    if (error.statusCode == 401 || !context.mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(error.message)));
  } catch (_) {
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Không cập nhật được lượt thích.')),
    );
  }
}

void _open(BuildContext context, UserMemoryPhoto photo) {
  final caption = photo.caption?.trim();
  openUserMemoryViewer(
    context,
    imageUrl: photo.imageUrl,
    title: photo.tripName,
    subtitle: caption == null || caption.isEmpty
        ? userMemoryDateLabel(photo.createdAt)
        : caption,
  );
}

Future<void> _share(BuildContext context, UserMemoryPhoto photo) {
  final box = context.findRenderObject();
  final origin = box is RenderBox
      ? box.localToGlobal(Offset.zero) & box.size
      : null;
  final caption = photo.caption?.trim();
  final lines = [
    if (caption != null && caption.isNotEmpty) caption,
    '${photo.tripName} • ${userMemoryDateLabel(photo.createdAt)}',
  ];
  return SharePlus.instance.share(
    ShareParams(text: lines.join('\n'), sharePositionOrigin: origin),
  );
}
