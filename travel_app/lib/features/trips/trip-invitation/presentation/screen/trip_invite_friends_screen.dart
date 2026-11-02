import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_frontend_v1/app/router/router_names.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_empty_view.dart';
import 'package:travel_frontend_v1/core/widget/app_error_view.dart';
import 'package:travel_frontend_v1/core/widget/app_scaffold.dart';
import 'package:travel_frontend_v1/core/widget/app_warning_card.dart';

import '../../../trip-details/application/trip_detail_overview_controller.dart';
import '../../../trip-details/presentation/widgets/trip_detail_feedback.dart';
import '../../../trip-details/utils/trip_detail_formatters.dart';
import '../../application/trip_invite_friends_controller.dart';
import '../../application/trip_invite_friends_header.dart';
import '../../application/trip_invite_friends_view.dart';
import '../../data/models/trip_invite_friends_models.dart';
import '../../utils/trip_invite_friends_formatters.dart';
import '../widgets/trip_invite_friends_bottom_bar.dart';
import '../widgets/trip_invite_friends_candidate_tile.dart';
import '../widgets/trip_invite_friends_search.dart';
import '../widgets/trip_invite_friends_selected_ribbon.dart';
import '../widgets/trip_invite_friends_skeleton.dart';
import '../widgets/trip_invite_friends_top_bar.dart';

/// Owner invites friends onto a trip. Opened from the trip detail "Mời bạn".
class TripInviteFriendsScreen extends ConsumerWidget {
  const TripInviteFriendsScreen({super.key, required this.tripId});

  final String tripId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final header = ref.watch(tripInviteFriendsHeaderProvider(tripId));

    void goBack() => _goBack(context);

    return AppScaffold(
      extendBody: false,
      topBar: TripInviteFriendsTopBar(
        onBack: goBack,
        tripName: header.value?.tripName,
        slotsLabel: header.value == null
            ? null
            : tripInviteSlotsLabel(
                header.value!.openSlots,
                header.value!.memberCount,
                header.value!.maxMembers,
              ),
        onShowInviteCode: header.value?.inviteCode == null
            ? null
            : () => _showInviteCode(context, header.value!.inviteCode!),
      ),
      body: switch (header) {
        AsyncValue(:final value?) when value.canInvite => _InviteBody(
          tripId: tripId,
          header: value,
        ),
        AsyncValue(hasValue: true) => _LockedView(onBack: goBack),
        AsyncValue(:final error?) when isTripInviteFriendsForbidden(error) =>
          _LockedView(onBack: goBack),
        AsyncValue(:final error?) => AppErrorView(
          title: 'Không thể tải chuyến đi',
          message: tripDetailErrorMessage(error),
          actionLabel: 'Thử lại',
          onRetry: () =>
              ref.invalidate(tripDetailOverviewControllerProvider(tripId)),
        ),
        _ => const TripInviteFriendsSkeleton(),
      },
    );
  }

  void _goBack(BuildContext context) {
    if (context.canPop()) {
      context.pop();
    } else {
      context.goNamed(
        RouteNames.tripDetail,
        pathParameters: {'tripId': tripId},
      );
    }
  }

  Future<void> _showInviteCode(BuildContext context, String code) async {
    await showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Mã mời chuyến đi'),
        content: Text(
          code,
          style: AppTypography.sectionTitle.copyWith(
            color: AppColors.primaryActive,
            letterSpacing: 1,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Đóng'),
          ),
          TextButton(
            onPressed: () async {
              await Clipboard.setData(ClipboardData(text: code));
              if (dialogContext.mounted) Navigator.of(dialogContext).pop();
              if (context.mounted) {
                showTripDetailMessage(context, 'Đã sao chép mã mời.');
              }
            },
            child: const Text('Sao chép'),
          ),
        ],
      ),
    );
  }
}

class _InviteBody extends ConsumerWidget {
  const _InviteBody({required this.tripId, required this.header});

  final String tripId;
  final TripInviteFriendsHeader header;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncState = ref.watch(tripInviteFriendsControllerProvider(tripId));
    final state = asyncState.value;
    final view = state == null
        ? null
        : buildTripInviteFriendsView(
            candidates: state.candidates,
            searchResults: state.searchResults,
            hasMoreSearchResults: state.hasMoreSearchResults,
            filter: state.filter,
            selectedById: state.selectedById,
            excludedUserIds: header.excludedUserIds,
            now: DateTime.now(),
          );
    final canSend =
        state != null &&
        !state.isSending &&
        state.selectedById.isNotEmpty &&
        header.isOpen &&
        !header.isFull;

    if (asyncState case AsyncValue(:final error?) when state == null) {
      return AppErrorView(
        title: 'Không thể tải bạn bè',
        message: tripInviteFriendsErrorMessage(error),
        actionLabel: 'Thử lại',
        onRetry: () =>
            ref.invalidate(tripInviteFriendsControllerProvider(tripId)),
      );
    }
    if (state == null || view == null) return const TripInviteFriendsSkeleton();

    return Column(
      children: [
        Expanded(
          child: RefreshIndicator(
            color: AppColors.primary,
            onRefresh: () => ref
                .read(tripInviteFriendsControllerProvider(tripId).notifier)
                .refresh(),
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.screenHorizontal,
                AppSpacing.sm,
                AppSpacing.screenHorizontal,
                AppSpacing.lg,
              ),
              children: [
                TripInviteFriendsSearch(
                  filter: state.filter,
                  tripTravelPersona: state.tripTravelPersona,
                  onFilter: (filter) => ref
                      .read(
                        tripInviteFriendsControllerProvider(tripId).notifier,
                      )
                      .setFilter(filter),
                  onQueryChanged: (query) => ref
                      .read(
                        tripInviteFriendsControllerProvider(tripId).notifier,
                      )
                      .setQuery(query),
                ),
                const SizedBox(height: AppSpacing.md),
                TripInviteFriendsSelectedRibbon(
                  selected: view.selected,
                  onClear: () => ref
                      .read(
                        tripInviteFriendsControllerProvider(tripId).notifier,
                      )
                      .clearSelection(),
                  onRemove: (person) => _toggle(ref, person),
                ),
                if (view.selected.isNotEmpty)
                  const SizedBox(height: AppSpacing.md),
                if (state.actionError != null) ...[
                  AppWarningCard(
                    message: tripInviteFriendsErrorMessage(state.actionError!),
                  ),
                  const SizedBox(height: AppSpacing.md),
                ],
                if (!header.isOpen)
                  const AppWarningCard(
                    icon: Icons.info_outline_rounded,
                    message: 'Chỉ mời thêm người khi chuyến đi sắp diễn ra.',
                  )
                else if (header.isFull)
                  const AppWarningCard(message: 'Chuyến đi đã đủ chỗ.'),
                if (!header.isOpen || header.isFull)
                  const SizedBox(height: AppSpacing.md),
                if (state.isSearching)
                  const Padding(
                    padding: EdgeInsets.only(bottom: AppSpacing.md),
                    child: LinearProgressIndicator(
                      color: AppColors.primary,
                      minHeight: 2,
                    ),
                  ),
                if (view.isEmpty)
                  const AppEmptyView(
                    icon: Icons.group_outlined,
                    title: 'Không có bạn để mời',
                    description:
                        'Thử từ khóa khác, hoặc mời khi đã kết bạn trên Teal Horizon.',
                  )
                else ...[
                  if (view.suggested.isNotEmpty)
                    _Section(
                      title: view.suggestedTitle,
                      subtitle: view.suggestedSubtitle,
                      people: view.suggested,
                      selectedIds: state.selectedById.keys.toSet(),
                      onPressed: (person) => _toggle(ref, person),
                    ),
                  if (view.directory.isNotEmpty) ...[
                    if (view.suggested.isNotEmpty)
                      const SizedBox(height: AppSpacing.lg),
                    _Section(
                      title:
                          view.singleSectionTitle ??
                          'Danh bạ bạn bè (${view.directory.length})',
                      subtitle: view.singleSectionTitle == null
                          ? view.directorySubtitle
                          : null,
                      people: view.directory,
                      selectedIds: state.selectedById.keys.toSet(),
                      onPressed: (person) => _toggle(ref, person),
                    ),
                  ],
                ],
                if (view.hasMoreSearchResults) ...[
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    'Chỉ hiện 20 kết quả đầu. Hãy gõ thêm để thu hẹp.',
                    style: AppTypography.caption.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
                const SizedBox(height: AppSpacing.lg),
                const _Notice(),
              ],
            ),
          ),
        ),
        TripInviteFriendsBottomBar(
          selectedCount: state.selectedById.length,
          slotsLabel: tripInviteSlotsLabel(
            header.openSlots,
            header.memberCount,
            header.maxMembers,
          ),
          isSending: state.isSending,
          canSend: canSend,
          onSend: () => _send(context, ref),
        ),
      ],
    );
  }

  void _toggle(WidgetRef ref, TripInviteCandidate person) {
    ref
        .read(tripInviteFriendsControllerProvider(tripId).notifier)
        .toggle(person, openSlots: header.openSlots);
  }

  Future<void> _send(BuildContext context, WidgetRef ref) async {
    final result = await ref
        .read(tripInviteFriendsControllerProvider(tripId).notifier)
        .send(tripIsOpen: header.isOpen, openSlots: header.openSlots);
    if (!context.mounted || result == null || result.hasFailure) return;
    final count = result.sentCount;
    showTripDetailMessage(
      context,
      count == 1 ? 'Đã gửi 1 lời mời.' : 'Đã gửi $count lời mời.',
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({
    required this.title,
    required this.people,
    required this.selectedIds,
    required this.onPressed,
    this.subtitle,
  });

  final String title;
  final String? subtitle;
  final List<TripInviteCandidate> people;
  final Set<String> selectedIds;
  final ValueChanged<TripInviteCandidate> onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(child: Text(title, style: AppTypography.sectionTitle)),
            if (subtitle != null)
              Flexible(
                child: Text(
                  subtitle!,
                  textAlign: TextAlign.end,
                  style: AppTypography.caption.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        for (final person in people) ...[
          TripInviteFriendsCandidateTile(
            person: person,
            selected: selectedIds.contains(person.user.id),
            onPressed: person.canInvite ? () => onPressed(person) : null,
          ),
          const SizedBox(height: AppSpacing.xs),
        ],
      ],
    );
  }
}

class _Notice extends StatelessWidget {
  const _Notice();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: AppColors.primary08,
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(color: AppColors.borderBrandSoft),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.info_outline_rounded,
            size: 20,
            color: AppColors.primary,
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              'Người nhận sẽ được thông báo và có thể chấp nhận hoặc từ chối. '
              'Chỉ trưởng nhóm gửi lời mời, và chỉ khi chuyến đi sắp diễn ra.',
              style: AppTypography.caption.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LockedView extends StatelessWidget {
  const _LockedView({required this.onBack});

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return AppEmptyView(
      icon: Icons.lock_outline_rounded,
      title: 'Chỉ trưởng nhóm mới mời được bạn',
      description: 'Bạn có thể xem chuyến đi, nhưng không gửi lời mời từ đây.',
      actionLabel: 'Quay lại',
      onAction: onBack,
    );
  }
}
