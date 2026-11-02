import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_frontend_v1/app/router/router_names.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_sizes.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/widget/app_empty_view.dart';
import 'package:travel_frontend_v1/core/widget/app_error_view.dart';
import 'package:travel_frontend_v1/core/widget/app_scaffold.dart';
import 'package:travel_frontend_v1/core/widget/app_warning_card.dart';

import '../../../trip-details/application/trip_detail_overview_controller.dart';
import '../../../trip-details/application/trip_itinerary_share_controller.dart';
import '../../../trip-details/presentation/widgets/trip_detail_feedback.dart';
import '../../../trip-details/utils/trip_detail_formatters.dart';
import '../../application/trip_join_request_action_controller.dart';
import '../../application/trip_join_request_settings_controller.dart';
import '../../application/trip_join_requests_controller.dart';
import '../../application/trip_join_requests_header.dart';
import '../../data/models/trip_join_request_models.dart';
import '../../provider/trip_join_requests_provider.dart';
import '../../utils/trip_join_request_formatters.dart';
import '../widgets/trip_join_request_auto_approve_card.dart';
import '../widgets/trip_join_request_card.dart';
import '../widgets/trip_join_request_status_tabs.dart';
import '../widgets/trip_join_request_trip_card.dart';
import '../widgets/trip_join_requests_manage_bar.dart';
import '../widgets/trip_join_requests_paging_footer.dart';
import '../widgets/trip_join_requests_skeleton.dart';
import '../widgets/trip_join_requests_top_bar.dart';

/// Owner and admins approve or reject the people asking to join a trip.
class TripJoinRequestsScreen extends ConsumerWidget {
  const TripJoinRequestsScreen({super.key, required this.tripId});

  final String tripId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final header = ref.watch(tripJoinRequestsHeaderProvider(tripId));
    final reviewer = header.value;
    final canReview = reviewer?.canReview ?? false;
    final pendingCount = canReview
        ? ref
              .watch(tripJoinRequestsControllerProvider(tripId))
              .value
              ?.counts
              .pending
        : null;

    void goBack() => _goBack(context);

    return AppScaffold(
      topBar: TripJoinRequestsTopBar(
        onBack: goBack,
        reviewerLabel: canReview ? joinRequestReviewerLabel(reviewer!) : null,
        pendingCount: pendingCount,
      ),
      body: switch (header) {
        AsyncValue(:final value?) when value.canReview => _ReviewBody(
          tripId: tripId,
          header: value,
          onReviewMembers: () => _openMembers(context),
        ),
        AsyncValue(hasValue: true) => _NotReviewerView(onBack: goBack),
        AsyncValue(:final error?) when isTripJoinRequestsForbidden(error) =>
          _NotReviewerView(onBack: goBack),
        AsyncValue(:final error?) => AppErrorView(
          title: 'Không thể tải chuyến đi',
          message: tripDetailErrorMessage(error),
          actionLabel: 'Thử lại',
          onRetry: () =>
              ref.invalidate(tripDetailOverviewControllerProvider(tripId)),
        ),
        _ => const TripJoinRequestsSkeleton(),
      },
    );
  }

  void _openMembers(BuildContext context) => context.goNamed(
    RouteNames.tripDetail,
    pathParameters: {'tripId': tripId},
  );

  void _goBack(BuildContext context) {
    if (context.canPop()) {
      context.pop();
    } else {
      _openMembers(context);
    }
  }
}

class _ReviewBody extends ConsumerWidget {
  const _ReviewBody({
    required this.tripId,
    required this.header,
    required this.onReviewMembers,
  });

  final String tripId;
  final TripJoinRequestsHeader header;
  final VoidCallback onReviewMembers;

  static const _manageBarSpace =
      AppSizes.buttonSecondaryHeight + AppSpacing.xl * 2;

  static const _horizontal = EdgeInsets.symmetric(
    horizontal: AppSpacing.screenHorizontal,
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final requests = ref.watch(tripJoinRequestsControllerProvider(tripId));
    final selected = ref.watch(tripJoinRequestStatusProvider(tripId));
    final warning = joinRequestQuotaWarning(header);

    return Stack(
      children: [
        RefreshIndicator(
          color: AppColors.primary,
          onRefresh: () => _refresh(context, ref),
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.screenHorizontal,
                  AppSpacing.md,
                  AppSpacing.screenHorizontal,
                  AppSpacing.lg,
                ),
                sliver: SliverList.list(
                  children: [
                    TripJoinRequestTripCard(
                      header: header,
                      onCopyInviteCode: () => _copyInviteCode(context),
                      onShareInviteCode: () => _shareInviteCode(context, ref),
                    ),
                    if (warning != null) ...[
                      const SizedBox(height: AppSpacing.lg),
                      AppWarningCard(message: warning),
                    ],
                  ],
                ),
              ),
              SliverToBoxAdapter(
                child: TripJoinRequestStatusTabs(
                  selected: selected,
                  counts: requests.value?.counts,
                  onSelect: ref
                      .read(tripJoinRequestStatusProvider(tripId).notifier)
                      .select,
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.screenHorizontal,
                  AppSpacing.md,
                  AppSpacing.screenHorizontal,
                  0,
                ),
                sliver: _requestsSliver(context, ref, requests, selected),
              ),
              SliverPadding(
                padding: _horizontal.copyWith(
                  top: AppSpacing.lg,
                  bottom: AppSpacing.xl + _manageBarSpace,
                ),
                sliver: SliverToBoxAdapter(
                  child: _AutoApproveSection(tripId: tripId),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          left: AppSpacing.screenHorizontal,
          right: AppSpacing.screenHorizontal,
          bottom: AppSpacing.md,
          child: TripJoinRequestsManageBar(onReviewMembers: onReviewMembers),
        ),
      ],
    );
  }

  Widget _requestsSliver(
    BuildContext context,
    WidgetRef ref,
    AsyncValue<TripJoinRequestsState> requests,
    TripJoinRequestStatus selected,
  ) {
    final loaded = requests.value;
    if (loaded != null && loaded.status == selected) {
      if (loaded.requests.isEmpty) {
        return SliverToBoxAdapter(child: _EmptyTab(status: selected));
      }
      return _RequestList(tripId: tripId, header: header, state: loaded);
    }
    final error = requests.error;
    if (error != null && !requests.isLoading) {
      return SliverToBoxAdapter(
        child: isTripJoinRequestsForbidden(error)
            ? AppEmptyView(
                icon: Icons.lock_outline_rounded,
                title: 'Không thể duyệt yêu cầu',
                description: tripJoinRequestsErrorMessage(error),
              )
            : AppErrorView(
                title: 'Không thể tải yêu cầu',
                message: tripJoinRequestsErrorMessage(error),
                actionLabel: 'Thử lại',
                onRetry: () =>
                    ref.invalidate(tripJoinRequestsControllerProvider(tripId)),
              ),
      );
    }
    return const SliverToBoxAdapter(child: TripJoinRequestCardsSkeleton());
  }

  Future<void> _refresh(BuildContext context, WidgetRef ref) async {
    ref.invalidate(tripDetailOverviewControllerProvider(tripId));
    ref.invalidate(tripJoinRequestSettingsControllerProvider(tripId));
    try {
      await ref
          .read(tripJoinRequestsControllerProvider(tripId).notifier)
          .refresh();
    } catch (error) {
      if (context.mounted) {
        showTripDetailMessage(context, tripJoinRequestsErrorMessage(error));
      }
    }
  }

  Future<void> _copyInviteCode(BuildContext context) async {
    final code = header.inviteCode;
    if (code == null) return;
    await Clipboard.setData(ClipboardData(text: code));
    if (context.mounted) showTripDetailMessage(context, 'Đã sao chép mã mời');
  }

  Future<void> _shareInviteCode(BuildContext context, WidgetRef ref) async {
    final code = header.inviteCode;
    if (code == null) return;
    final box = context.findRenderObject() as RenderBox?;
    try {
      await ref
          .read(tripShareSheetProvider)
          .share(
            joinRequestInviteShareMessage(header.tripName, code),
            subject: 'Mã mời chuyến đi',
            origin: box == null
                ? null
                : box.localToGlobal(Offset.zero) & box.size,
          );
    } catch (_) {
      if (context.mounted) {
        showTripDetailMessage(context, 'Không thể mở trình chia sẻ.');
      }
    }
  }
}

class _RequestList extends ConsumerWidget {
  const _RequestList({
    required this.tripId,
    required this.header,
    required this.state,
  });

  final String tripId;
  final TripJoinRequestsHeader header;
  final TripJoinRequestsState state;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final action = ref.watch(tripJoinRequestActionControllerProvider(tripId));
    final now = ref.watch(tripJoinRequestsClockProvider)();
    final requests = state.requests;
    final controller = ref.read(
      tripJoinRequestsControllerProvider(tripId).notifier,
    );

    return SliverList.separated(
      itemCount: requests.length + (state.hasMore ? 1 : 0),
      separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.md),
      itemBuilder: (context, index) {
        if (index == requests.length) {
          return TripJoinRequestsPagingFooter(
            isLoadingMore: state.isLoadingMore,
            hasLoadMoreError: state.loadMoreError != null,
            onLoadMore: controller.loadMore,
          );
        }
        final request = requests[index];
        final idle = !action.isBusy;
        return TripJoinRequestCard(
          key: ValueKey(request.id),
          request: request,
          now: now,
          isApproving: action.isDeciding(
            request.id,
            TripJoinRequestStatus.approved,
          ),
          isRejecting: action.isDeciding(
            request.id,
            TripJoinRequestStatus.rejected,
          ),
          onApprove: idle && header.canApprove
              ? () => _approve(context, ref, request)
              : null,
          onReject: idle ? () => _reject(context, ref, request) : null,
        );
      },
    );
  }

  TripJoinRequestActionController _actions(WidgetRef ref) =>
      ref.read(tripJoinRequestActionControllerProvider(tripId).notifier);

  Future<void> _approve(
    BuildContext context,
    WidgetRef ref,
    TripJoinRequest request,
  ) => _run(context, () => _actions(ref).approve(request.id));

  Future<void> _reject(
    BuildContext context,
    WidgetRef ref,
    TripJoinRequest request,
  ) async {
    final confirmed = await confirmTripDetailAction(
      context,
      title: 'Từ chối yêu cầu?',
      message:
          '${request.requester.displayName} sẽ không được tham gia chuyến đi '
          'này.',
      confirmLabel: 'Từ chối',
    );
    if (!confirmed || !context.mounted) return;
    await _run(context, () => _actions(ref).reject(request.id));
  }

  Future<void> _run(
    BuildContext context,
    Future<TripJoinRequest> Function() decide,
  ) async {
    try {
      final reviewed = await decide();
      if (context.mounted) {
        showTripDetailMessage(context, joinRequestDecisionMessage(reviewed));
      }
    } catch (error) {
      if (context.mounted) {
        showTripDetailMessage(context, tripJoinDecisionErrorMessage(error));
      }
    }
  }
}

class _AutoApproveSection extends ConsumerWidget {
  const _AutoApproveSection({required this.tripId});

  final String tripId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = tripJoinRequestSettingsControllerProvider(tripId);
    final settings = ref.watch(provider);
    final error = settings.hasValue ? null : settings.error;
    return TripJoinRequestAutoApproveCard(
      value: settings.value?.autoApproveFriends,
      errorMessage: error == null
          ? null
          : 'Không tải được cài đặt duyệt tự động.',
      onRetry: () => ref.invalidate(provider),
      onChanged: (enabled) async {
        try {
          await ref.read(provider.notifier).setAutoApproveFriends(enabled);
        } catch (error) {
          if (context.mounted) {
            showTripDetailMessage(context, tripJoinSettingsErrorMessage(error));
          }
        }
      },
    );
  }
}

class _EmptyTab extends StatelessWidget {
  const _EmptyTab({required this.status});

  final TripJoinRequestStatus status;

  @override
  Widget build(BuildContext context) {
    final (icon, title, description) = switch (status) {
      TripJoinRequestStatus.pending => (
        Icons.mark_email_read_outlined,
        'Không có yêu cầu chờ duyệt',
        'Chia sẻ mã mời để bạn bè gửi yêu cầu tham gia chuyến đi.',
      ),
      TripJoinRequestStatus.approved => (
        Icons.how_to_reg_outlined,
        'Chưa duyệt yêu cầu nào',
        'Những người bạn đồng ý sẽ xuất hiện tại đây.',
      ),
      TripJoinRequestStatus.rejected => (
        Icons.person_off_outlined,
        'Chưa từ chối yêu cầu nào',
        'Những yêu cầu bạn từ chối sẽ xuất hiện tại đây.',
      ),
    };
    return AppEmptyView(icon: icon, title: title, description: description);
  }
}

class _NotReviewerView extends StatelessWidget {
  const _NotReviewerView({required this.onBack});

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return AppEmptyView(
      icon: Icons.lock_outline_rounded,
      title: 'Không thể duyệt yêu cầu',
      description:
          'Chỉ trưởng nhóm hoặc quản trị viên mới duyệt được yêu cầu tham gia.',
      actionLabel: 'Quay lại',
      onAction: onBack,
    );
  }
}
