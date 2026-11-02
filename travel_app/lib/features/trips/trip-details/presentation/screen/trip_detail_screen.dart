import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_frontend_v1/app/router/router_names.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_error_view.dart';
import 'package:travel_frontend_v1/core/widget/app_scaffold.dart';

import '../../../trip-memories/presentation/screen/trip_memories_screen.dart';
import '../../application/trip_detail_action_controller.dart';
import '../../application/trip_detail_overview_controller.dart';
import '../../data/models/trip_detail_models.dart';
import '../../../trip-publish/application/publish_entry.dart';
import '../../utils/trip_detail_formatters.dart';
import '../widgets/trip_detail_bars.dart';
import '../widgets/trip_detail_feedback.dart';
import '../widgets/trip_detail_hero.dart';
import '../widgets/trip_detail_journey_section.dart';
import '../widgets/trip_detail_members_section.dart';
import '../widgets/trip_detail_memories_section.dart';
import '../widgets/trip_detail_metrics.dart';
import '../widgets/trip_detail_reward_card.dart';
import '../widgets/trip_detail_skeleton.dart';
import '../widgets/trip_detail_timeline_section.dart';

class TripDetailScreen extends ConsumerWidget {
  const TripDetailScreen({super.key, required this.tripId});

  final String tripId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = tripDetailOverviewControllerProvider(tripId);
    final detail = ref.watch(provider);
    final trip = detail.value;

    return AppScaffold(
      topBar: TripDetailTopBar(
        title: trip?.name,
        onBack: () => _goBack(context),
        onShare: trip == null ? null : () => showTripDetailComingSoon(context),
        onMore: trip == null ? null : () => showTripDetailComingSoon(context),
      ),
      bottomNavigationBar: trip == null
          ? null
          : TripDetailBottomBar(
              onExpenses: () => _openExpenses(context),
              onViewItinerary: () => _openItinerary(context),
            ),
      body: switch (detail) {
        AsyncValue(:final value?) => RefreshIndicator(
          color: AppColors.primary,
          onRefresh: () => _refresh(context, ref),
          child: _TripDetailContent(trip: value),
        ),
        AsyncValue(:final error?) => AppErrorView(
          title: 'Không thể tải chuyến đi',
          message: tripDetailErrorMessage(error),
          actionLabel: 'Thử lại',
          onRetry: () => ref.invalidate(provider),
        ),
        _ => const TripDetailSkeleton(),
      },
    );
  }

  Future<void> _refresh(BuildContext context, WidgetRef ref) async {
    final provider = tripDetailOverviewControllerProvider(tripId);
    await ref.read(provider.notifier).refresh();
    final error = ref.read(provider).error;
    if (error != null && context.mounted) {
      showTripDetailMessage(context, tripDetailErrorMessage(error));
    }
  }

  void _goBack(BuildContext context) {
    if (context.canPop()) {
      context.pop();
    } else {
      context.goNamed(RouteNames.trips);
    }
  }

  void _openItinerary(BuildContext context) => context.pushNamed(
    RouteNames.tripItinerary,
    pathParameters: {'tripId': tripId},
  );

  void _openExpenses(BuildContext context) => context.pushNamed(
    RouteNames.tripExpenses,
    pathParameters: {'tripId': tripId},
  );
}

class _TripDetailContent extends ConsumerWidget {
  const _TripDetailContent({required this.trip});

  final TripDetailOverview trip;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final actions = ref.watch(tripDetailActionControllerProvider(trip.id));
    final now = DateTime.now();
    final reward = trip.completionReward;
    final memories = trip.memories;
    final timeline = trip.timeline;

    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.screenHorizontal,
        AppSpacing.md,
        AppSpacing.screenHorizontal,
        AppSpacing.safeBottom,
      ),
      children: [
        TripDetailHero(trip: trip),
        const SizedBox(height: AppSpacing.section),
        TripDetailMetrics(trip: trip),
        if (trip.requirements != null ||
            trip.estimatedBudgetPerPerson != null ||
            trip.expiresAt != null) ...[
          const SizedBox(height: AppSpacing.section),
          _PublicRecruitment(trip: trip),
        ],
        const SizedBox(height: AppSpacing.section),
        TripDetailMembersSection(
          trip: trip,
          actionsEnabled: !actions.isBusy,
          isRemoving: (member) => actions.isPending(
            TripDetailAction.kickMember,
            targetUserId: member.userId,
          ),
          onInvite: () => context.pushNamed(
            RouteNames.tripInviteFriends,
            pathParameters: {'tripId': trip.id},
          ),
          onCopyInviteCode: (code) => _copyInviteCode(context, code),
          onRotateInviteCode: () => _rotateInviteCode(context, ref),
          isRotatingInviteCode: actions.isPending(
            TripDetailAction.rotateInviteCode,
          ),
          onTransferAdmin: (_) => showTripDetailComingSoon(context),
          onRemove: (member) => _removeMember(context, ref, member),
          onViewPhotos: (member) => context.pushNamed(
            RouteNames.tripMemories,
            pathParameters: {'tripId': trip.id},
            queryParameters: TripMemoriesScreen.uploaderQuery(member.userId),
          ),
          onOpenJoinRequests: trip.canManageMembers
              ? () => context.pushNamed(
                  RouteNames.tripJoinRequests,
                  pathParameters: {'tripId': trip.id},
                )
              : null,
        ),
        const SizedBox(height: AppSpacing.section),
        TripDetailJourneySection(
          destinations: trip.destinations,
          nextActivity: trip.nextActivity,
          now: now,
          onViewItinerary: () => context.pushNamed(
            RouteNames.tripItinerary,
            pathParameters: {'tripId': trip.id},
          ),
        ),
        if (memories != null) ...[
          const SizedBox(height: AppSpacing.section),
          TripDetailMemoriesSection(
            memories: memories,
            onSeeAll: () => context.pushNamed(
              RouteNames.tripMemories,
              pathParameters: {'tripId': trip.id},
            ),
            onAddPhoto: () => context.pushNamed(
              RouteNames.tripMemories,
              pathParameters: {'tripId': trip.id},
              queryParameters: TripMemoriesScreen.startPostingQuery,
            ),
          ),
        ],
        if (reward != null) ...[
          const SizedBox(height: AppSpacing.section),
          TripDetailRewardCard(
            reward: reward,
            isClaiming: actions.isPending(TripDetailAction.claimReward),
            onClaim: actions.isBusy ? null : () => _claimReward(context, ref),
          ),
        ],
        if (timeline != null) ...[
          const SizedBox(height: AppSpacing.section),
          TripDetailTimelineSection(
            timeline: timeline,
            now: now,
            onSeeMore: () => context.pushNamed(
              RouteNames.tripTimeline,
              pathParameters: {'tripId': trip.id},
            ),
          ),
        ],
        if (trip.canLeave) ...[
          const SizedBox(height: AppSpacing.md),
          Center(
            child: _LeaveTripButton(
              isLoading: actions.isPending(TripDetailAction.leaveTrip),
              onPressed: actions.isBusy ? null : () => _leaveTrip(context, ref),
            ),
          ),
        ],
      ],
    );
  }

  Future<void> _copyInviteCode(BuildContext context, String code) async {
    await Clipboard.setData(ClipboardData(text: code));
    if (context.mounted) {
      showTripDetailMessage(context, 'Đã sao chép mã mời: $code');
    }
  }

  Future<void> _rotateInviteCode(BuildContext context, WidgetRef ref) async {
    final confirmed = await confirmTripDetailAction(
      context,
      title: 'Đổi mã mời?',
      message:
          'Mã mời hiện tại sẽ hết hiệu lực. Người chưa tham gia sẽ cần mã mới.',
      confirmLabel: 'Đổi mã',
    );
    if (!confirmed || !context.mounted) return;
    try {
      final code = await ref
          .read(tripDetailActionControllerProvider(trip.id).notifier)
          .rotateInviteCode();
      if (context.mounted) {
        showTripDetailMessage(context, 'Đã tạo mã mời mới: $code');
      }
    } catch (error) {
      if (context.mounted) {
        showTripDetailMessage(context, tripDetailErrorMessage(error));
      }
    }
  }

  Future<void> _removeMember(
    BuildContext context,
    WidgetRef ref,
    TripDetailMember member,
  ) async {
    final confirmed = await confirmTripDetailAction(
      context,
      title: 'Mời ra khỏi nhóm?',
      message:
          'Bạn có chắc chắn muốn xóa ${member.displayName} khỏi chuyến đi này?',
      confirmLabel: 'Xóa khỏi nhóm',
    );
    if (!confirmed || !context.mounted) return;
    await _runAction(
      context,
      () => ref
          .read(tripDetailActionControllerProvider(trip.id).notifier)
          .kickMember(member.userId),
      successMessage: 'Đã xóa ${member.displayName} khỏi nhóm',
    );
  }

  Future<void> _leaveTrip(BuildContext context, WidgetRef ref) async {
    final confirmed = await confirmTripDetailAction(
      context,
      title: 'Rời khỏi chuyến đi?',
      message: 'Bạn có chắc chắn muốn rời khỏi chuyến đi này không?',
      confirmLabel: 'Rời chuyến đi',
    );
    if (!confirmed || !context.mounted) return;
    final left = await _runAction(
      context,
      () => ref
          .read(tripDetailActionControllerProvider(trip.id).notifier)
          .leaveTrip(),
      successMessage: 'Bạn đã rời khỏi chuyến đi',
    );
    if (left && context.mounted) context.goNamed(RouteNames.trips);
  }

  Future<void> _claimReward(BuildContext context, WidgetRef ref) async {
    try {
      final points = await ref
          .read(tripDetailActionControllerProvider(trip.id).notifier)
          .claimReward();
      if (context.mounted) {
        showTripDetailMessage(context, 'Đã nhận +$points điểm thưởng');
      }
    } catch (error) {
      if (context.mounted) {
        showTripDetailMessage(context, tripDetailErrorMessage(error));
      }
    }
  }

  Future<bool> _runAction(
    BuildContext context,
    Future<void> Function() action, {
    required String successMessage,
  }) async {
    try {
      await action();
      if (context.mounted) showTripDetailMessage(context, successMessage);
      return true;
    } catch (error) {
      if (context.mounted) {
        showTripDetailMessage(context, tripDetailErrorMessage(error));
      }
      return false;
    }
  }
}

class _LeaveTripButton extends StatelessWidget {
  const _LeaveTripButton({required this.isLoading, required this.onPressed});

  final bool isLoading;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: isLoading ? null : onPressed,
      style: TextButton.styleFrom(foregroundColor: AppColors.danger),
      icon: isLoading
          ? const SizedBox.square(
              dimension: 16,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: AppColors.danger,
              ),
            )
          : const Icon(Icons.logout_rounded, size: 16),
      label: Text(
        'Rời khỏi chuyến đi này',
        style: AppTypography.caption.copyWith(color: AppColors.danger),
      ),
    );
  }
}

class _PublicRecruitment extends StatelessWidget {
  const _PublicRecruitment({required this.trip});

  final TripDetailOverview trip;

  @override
  Widget build(BuildContext context) {
    final expires = trip.expiresAt;
    final budget = trip.estimatedBudgetPerPerson;
    final requirements = trip.requirements?.trim();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Bài tuyển', style: AppTypography.sectionTitle),
        const SizedBox(height: AppSpacing.sm),
        if (budget != null && budget.isNotEmpty)
          Text('Ngân sách mỗi người: $budget', style: AppTypography.body),
        if (trip.slotsRemaining != null)
          Text('Còn ${trip.slotsRemaining} chỗ', style: AppTypography.body),
        if (expires != null)
          Text(
            'Hết hạn ${formatRecruitmentInstant(expires)}',
            style: AppTypography.caption,
          ),
        if (requirements != null && requirements.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.xs),
          Text(requirements, style: AppTypography.body),
        ],
      ],
    );
  }
}
