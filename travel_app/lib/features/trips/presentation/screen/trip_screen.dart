import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/router_names.dart';
import '../../../../core/networks/api_exception.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widget/app_avatar.dart';
import '../../../../core/widget/app_button.dart';
import '../../../../core/widget/app_empty_view.dart';
import '../../../../core/widget/app_error_view.dart';
import '../../../../core/widget/app_glass_surface.dart';
import '../../../../core/widget/app_progress_bar.dart';
import '../../../../core/widget/app_scaffold.dart';
import '../../../../core/widget/app_section_header.dart';
import '../../../../core/widget/app_skeleton.dart';
import '../../application/trip_invitations_controller.dart';
import '../../application/trip_list_controller.dart';
import '../../data/models/trip_enums.dart';
import '../../data/models/trip_list_item.dart';
import '../../data/models/trip_query.dart';
import '../../data/models/trip_related_models.dart';

enum _TripTab { ongoing, upcoming, completed, invitations }

class TripScreen extends ConsumerStatefulWidget {
  const TripScreen({super.key});

  @override
  ConsumerState<TripScreen> createState() => _TripScreenState();
}

class _TripScreenState extends ConsumerState<TripScreen> {
  _TripTab _tab = _TripTab.ongoing;

  Future<void> _selectTab(_TripTab tab) async {
    if (_tab == tab) return;
    setState(() => _tab = tab);
    if (tab == _TripTab.invitations || tab == _TripTab.ongoing) return;
    final status = switch (tab) {
      _TripTab.ongoing => TripStatus.ongoing,
      _TripTab.upcoming => TripStatus.upcoming,
      _TripTab.completed => TripStatus.completed,
      _TripTab.invitations => null,
    };
    await ref
        .read(tripListControllerProvider.notifier)
        .setQuery(TripQuery(status: status));
  }

  Future<void> _refresh() async {
    if (_tab == _TripTab.ongoing) {
      await Future.wait([
        ref.read(tripDashboardControllerProvider.notifier).refresh(),
        ref.read(tripInvitationsControllerProvider.notifier).refresh(),
      ]);
      return;
    }
    if (_tab == _TripTab.invitations) {
      await ref.read(tripInvitationsControllerProvider.notifier).refresh();
      return;
    }
    await Future.wait([
      ref.read(tripListControllerProvider.notifier).refresh(),
      ref.read(tripInvitationsControllerProvider.notifier).refresh(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final trips = ref.watch(tripListControllerProvider);
    final dashboard = ref.watch(tripDashboardControllerProvider);
    final invitations = ref.watch(tripInvitationsControllerProvider);
    return AppScaffold(
      topBar: const _TripTopBar(),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'create-trip',
        onPressed: () => context.pushNamed(RouteNames.createTrip),
        backgroundColor: AppColors.primaryActive,
        foregroundColor: AppColors.textInverse,
        icon: const Icon(Icons.add_rounded),
        label: Text('Tạo Chuyến Đi', style: AppTypography.buttonSmall),
      ),
      body: RefreshIndicator(
        color: AppColors.primary,
        onRefresh: _refresh,
        child: (_tab == _TripTab.ongoing ? dashboard : trips).when(
          skipLoadingOnRefresh: true,
          data: (value) {
            final state = value is TripListState ? value : null;
            final dashboardState = value is TripDashboardState ? value : null;
            return _TripContent(
              state: state,
              dashboard: dashboardState,
              invitations: invitations,
              selectedTab: _tab,
              onTabChanged: _selectTab,
            );
          },
          loading: () => const _TripSkeleton(),
          error: (error, _) => ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            children: [
              SizedBox(
                height: MediaQuery.sizeOf(context).height * .65,
                child: AppErrorView(
                  title: 'Không thể tải chuyến đi',
                  message: _errorMessage(error),
                  onRetry: _refresh,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TripContent extends ConsumerWidget {
  const _TripContent({
    this.state,
    this.dashboard,
    required this.invitations,
    required this.selectedTab,
    required this.onTabChanged,
  });

  final TripListState? state;
  final TripDashboardState? dashboard;
  final AsyncValue<TripInvitationsState> invitations;
  final _TripTab selectedTab;
  final ValueChanged<_TripTab> onTabChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final invitationCount = invitations.value?.meta.total ?? 0;
    final summary = dashboard?.summary ?? state!.summary;
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.screenHorizontal,
        AppSpacing.md,
        AppSpacing.screenHorizontal,
        AppSpacing.safeBottom,
      ),
      children: [
        _Stats(summary: summary),
        const SizedBox(height: AppSpacing.lg),
        _StatusTabs(
          selected: selectedTab,
          summary: summary,
          invitationCount: invitationCount,
          onChanged: onTabChanged,
        ),
        const SizedBox(height: AppSpacing.xl),
        if (selectedTab == _TripTab.ongoing && dashboard != null)
          _DashboardSections(state: dashboard!, invitations: invitations)
        else if (selectedTab == _TripTab.invitations)
          _InvitationList(value: invitations)
        else if (state!.items.isEmpty)
          _TripEmpty(tab: selectedTab)
        else ...[
          AppSectionHeader(title: _sectionTitle(selectedTab)),
          const SizedBox(height: AppSpacing.sm),
          if (selectedTab == _TripTab.ongoing)
            ...state!.items.map(
              (trip) => Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.md),
                child: _OngoingTripCard(trip: trip),
              ),
            )
          else
            ...state!.items.map(
              (trip) => Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                child: _TripListCard(trip: trip),
              ),
            ),
          if (state!.meta.hasNextPage) ...[
            const SizedBox(height: AppSpacing.xs),
            AppButton(
              label: 'Xem thêm',
              variant: AppButtonVariant.secondary,
              isLoading: state!.isLoadingMore,
              onPressed: state!.isLoadingMore
                  ? null
                  : ref.read(tripListControllerProvider.notifier).loadNextPage,
            ),
          ],
        ],
      ],
    );
  }
}

class _DashboardSections extends StatelessWidget {
  const _DashboardSections({required this.state, required this.invitations});

  final TripDashboardState state;
  final AsyncValue<TripInvitationsState> invitations;

  @override
  Widget build(BuildContext context) {
    final invitationItems =
        invitations.value?.items ?? const <TripInvitation>[];
    final invitation = invitationItems.isEmpty ? null : invitationItems.first;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (state.ongoing.isEmpty)
          const AppEmptyView(
            title: 'Không có chuyến đi đang diễn ra',
            description: 'Các chuyến đang diễn ra sẽ xuất hiện tại đây.',
            icon: Icons.luggage_outlined,
          )
        else ...[
          AppSectionHeader(
            title: 'Chuyến Đi Đang Diễn Ra',
            actionLabel: 'Chi tiết lịch trình',
            onAction: () => _openTrip(context, state.ongoing.first.id),
          ),
          const SizedBox(height: AppSpacing.sm),
          _OngoingTripCard(trip: state.ongoing.first),
        ],
        if (invitation != null) ...[
          const SizedBox(height: AppSpacing.xl),
          _InvitationCard(invitation: invitation),
        ],
        const SizedBox(height: AppSpacing.xl),
        AppSectionHeader(
          title: 'Chuyến Đi Sắp Tới (${state.summary.upcoming})',
          actionLabel: state.upcoming.length > 2 ? 'Xem tất cả' : null,
          onAction: state.upcoming.length > 2
              ? () => _showComingSoon(context, 'Danh sách chuyến đi sắp tới')
              : null,
        ),
        const SizedBox(height: AppSpacing.sm),
        if (state.upcoming.isEmpty)
          const AppEmptyView(
            title: 'Chưa có chuyến đi sắp tới',
            description: 'Tạo một chuyến đi mới để bắt đầu hành trình.',
            icon: Icons.calendar_month_outlined,
          )
        else
          ...state.upcoming
              .take(2)
              .map(
                (trip) => Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                  child: _TripListCard(trip: trip),
                ),
              ),
        const SizedBox(height: AppSpacing.sm),
        _ExplorePrompt(
          onTap: () => _showComingSoon(context, 'Khám phá hành trình'),
        ),
      ],
    );
  }
}

class _ExplorePrompt extends StatelessWidget {
  const _ExplorePrompt({required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(AppSpacing.md),
    decoration: BoxDecoration(
      color: AppColors.primary08,
      borderRadius: BorderRadius.circular(AppRadius.card),
      border: Border.all(color: AppColors.borderBrandSoft),
    ),
    child: Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Chưa tìm được ý tưởng mới?',
                style: AppTypography.cardTitle.copyWith(
                  color: AppColors.primaryActive,
                ),
              ),
              Text(
                'Khám phá những hành trình thịnh hành tuần này',
                style: AppTypography.caption,
              ),
            ],
          ),
        ),
        AppButton(
          label: 'Khám phá',
          variant: AppButtonVariant.secondary,
          expand: false,
          onPressed: onTap,
        ),
      ],
    ),
  );
}

class _TripTopBar extends StatelessWidget {
  const _TripTopBar();

  @override
  Widget build(BuildContext context) => AppGlassSurface(
    radius: 0,
    shadows: const [],
    padding: const EdgeInsets.symmetric(
      horizontal: AppSpacing.screenHorizontal,
    ),
    child: SizedBox(
      height: 64,
      child: Row(
        children: [
          const Icon(
            Icons.luggage_outlined,
            size: 28,
            color: AppColors.primaryActive,
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Teal Horizon',
                  style: AppTypography.caption.copyWith(
                    color: AppColors.primaryActive,
                  ),
                ),
                Text('Hành Trình Của Tôi', style: AppTypography.screenTitle),
              ],
            ),
          ),
          _HeaderAction(
            icon: Icons.qr_code_scanner_rounded,
            label: 'Nhập\nmã mời',
            onTap: () => context.pushNamed(RouteNames.tripJoinByCode),
          ),
          const SizedBox(width: AppSpacing.xs),
          _RoundIconButton(
            icon: Icons.filter_list_rounded,
            onTap: () => _showComingSoon(context, 'Bộ lọc chuyến đi'),
          ),
        ],
      ),
    ),
  );
}

class _HeaderAction extends StatelessWidget {
  const _HeaderAction({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Material(
    color: AppColors.glass85,
    shape: const StadiumBorder(
      side: BorderSide(color: AppColors.borderBrandSoft),
    ),
    child: InkWell(
      onTap: onTap,
      customBorder: const StadiumBorder(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
        child: Row(
          children: [
            Icon(icon, size: 18, color: AppColors.primaryActive),
            const SizedBox(width: 7),
            Text(
              label,
              textAlign: TextAlign.center,
              style: AppTypography.badge.copyWith(
                color: AppColors.primaryActive,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

class _RoundIconButton extends StatelessWidget {
  const _RoundIconButton({required this.icon, required this.onTap});
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Material(
    color: AppColors.glass85,
    shape: const CircleBorder(
      side: BorderSide(color: AppColors.borderBrandSoft),
    ),
    child: IconButton(
      visualDensity: VisualDensity.compact,
      onPressed: onTap,
      icon: Icon(icon, size: 20, color: AppColors.textSecondary),
    ),
  );
}

class _Stats extends StatelessWidget {
  const _Stats({required this.summary});
  final TripSummary summary;

  @override
  Widget build(BuildContext context) => Row(
    children: [
      Expanded(
        child: _StatCard(
          value: '${summary.completed}',
          label: 'Chuyến đi đã đi',
          icon: Icons.map_outlined,
        ),
      ),
      const SizedBox(width: AppSpacing.xs),
      Expanded(
        child: _StatCard(
          value: '${summary.totalCheckins}',
          label: 'Điểm check-in',
          icon: Icons.location_on_outlined,
        ),
      ),
    ],
  );
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.value,
    required this.label,
    required this.icon,
  });
  final String value;
  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) => SizedBox(
    height: 102,
    child: AppGlassSurface(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Stack(
        children: [
          Positioned(
            right: -3,
            bottom: -5,
            child: Icon(icon, size: 42, color: AppColors.primary12),
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  value,
                  style: AppTypography.display.copyWith(
                    color: AppColors.primaryActive,
                  ),
                ),
                const SizedBox(height: AppSpacing.xxs),
                Text(
                  label,
                  textAlign: TextAlign.center,
                  style: AppTypography.body,
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

class _StatusTabs extends StatelessWidget {
  const _StatusTabs({
    required this.selected,
    required this.summary,
    required this.invitationCount,
    required this.onChanged,
  });
  final _TripTab selected;
  final TripSummary summary;
  final int invitationCount;
  final ValueChanged<_TripTab> onChanged;

  @override
  Widget build(BuildContext context) {
    final entries = [
      (_TripTab.ongoing, 'Đang diễn ra', summary.ongoing),
      (_TripTab.upcoming, 'Sắp tới', summary.upcoming),
      (_TripTab.completed, 'Đã hoàn thành', summary.completed),
      (_TripTab.invitations, 'Lời mời', invitationCount),
    ];
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.surfaceSubdued,
        borderRadius: BorderRadius.circular(AppRadius.pill),
        border: Border.all(color: AppColors.borderNeutral),
      ),
      child: Row(
        children: entries
            .map((entry) {
              final active = selected == entry.$1;
              return Expanded(
                child: InkWell(
                  onTap: () => onChanged(entry.$1),
                  borderRadius: BorderRadius.circular(AppRadius.pill),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 4,
                    ),
                    decoration: BoxDecoration(
                      color: active
                          ? AppColors.primaryActive
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(AppRadius.pill),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          entry.$2,
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          style: AppTypography.caption.copyWith(
                            color: active
                                ? AppColors.textInverse
                                : AppColors.textSecondary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '${entry.$3}',
                          style: AppTypography.badge.copyWith(
                            color: active
                                ? AppColors.textInverse
                                : entry.$1 == _TripTab.invitations &&
                                      entry.$3 > 0
                                ? AppColors.danger
                                : AppColors.primaryActive,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            })
            .toList(growable: false),
      ),
    );
  }
}

class _OngoingTripCard extends StatelessWidget {
  const _OngoingTripCard({required this.trip});
  final TripListItem trip;

  @override
  Widget build(BuildContext context) => AppGlassSurface(
    padding: EdgeInsets.zero,
    radius: AppRadius.hero,
    child: Column(
      children: [
        _TripCover(trip: trip, height: 225),
        Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Tiến độ trải nghiệm',
                      style: AppTypography.caption,
                    ),
                  ),
                  Text(
                    '${trip.completedActivities}/${trip.totalActivities} hoạt động (${trip.progressPercent}%)',
                    style: AppTypography.caption.copyWith(
                      color: AppColors.primaryActive,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.xs),
              AppProgressBar(value: trip.progressPercent / 100),
              if (trip.nextActivity != null) ...[
                const SizedBox(height: AppSpacing.md),
                _NextActivity(activity: trip.nextActivity!),
              ],
              const SizedBox(height: AppSpacing.md),
              const Divider(height: 1, color: AppColors.borderNeutral),
              const SizedBox(height: AppSpacing.sm),
              Row(
                children: [
                  Expanded(child: _MemberStack(trip: trip)),
                  AppButton(
                    label: 'Vào Quản Trị',
                    trailingIcon: Icons.arrow_forward_rounded,
                    expand: false,
                    onPressed: () => _openTrip(context, trip.id),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

class _TripCover extends StatelessWidget {
  const _TripCover({required this.trip, required this.height});
  final TripListItem trip;
  final double height;

  @override
  Widget build(BuildContext context) {
    final location = trip.destinations
        .map((item) => item.city)
        .where((item) => item.isNotEmpty)
        .join(' • ');
    return SizedBox(
      height: height,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (trip.coverImageUrl != null)
            Image.network(
              trip.coverImageUrl!,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => const _CoverFallback(),
            )
          else
            const _CoverFallback(),
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, AppColors.heroOverlay],
              ),
            ),
          ),
          Positioned(
            left: AppSpacing.md,
            top: AppSpacing.md,
            child: _StatusPill(trip: trip),
          ),
          Positioned(
            right: AppSpacing.md,
            top: AppSpacing.md,
            child: _RoundIconButton(
              icon: Icons.share_outlined,
              onTap: () => _showComingSoon(context, 'Chia sẻ chuyến đi'),
            ),
          ),
          Positioned(
            left: AppSpacing.md,
            right: AppSpacing.md,
            bottom: AppSpacing.md,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (location.isNotEmpty)
                  Text(
                    location.toUpperCase(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.badge.copyWith(
                      color: const Color(0xFF9EF4EF),
                    ),
                  ),
                const SizedBox(height: AppSpacing.xxs),
                Text(
                  trip.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.screenTitle.copyWith(
                    color: AppColors.textInverse,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CoverFallback extends StatelessWidget {
  const _CoverFallback();
  @override
  Widget build(BuildContext context) => const DecoratedBox(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFF65CEC8), Color(0xFF167E7A)],
      ),
    ),
    child: Center(
      child: Icon(Icons.landscape_rounded, size: 64, color: AppColors.glass75),
    ),
  );
}

class _StatusPill extends StatelessWidget {
  const _StatusPill({required this.trip});
  final TripListItem trip;

  @override
  Widget build(BuildContext context) {
    final label = switch (trip.status) {
      TripStatus.draft => 'BẢN NHÁP',
      TripStatus.ongoing => 'ĐANG DIỄN RA • ${_currentDay(trip)}',
      TripStatus.upcoming => 'SẮP TỚI',
      TripStatus.completed => 'ĐÃ HOÀN THÀNH',
      TripStatus.cancelled => 'ĐÃ HỦY',
      TripStatus.notCompleted => 'CHƯA HOÀN THÀNH',
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.heroOverlay,
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
      child: Text(
        label,
        style: AppTypography.badge.copyWith(color: AppColors.textInverse),
      ),
    );
  }
}

class _NextActivity extends StatelessWidget {
  const _NextActivity({required this.activity});
  final TripListNextActivity activity;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(AppSpacing.sm),
    decoration: BoxDecoration(
      color: AppColors.primaryLight,
      borderRadius: BorderRadius.circular(AppRadius.input),
      border: Border.all(color: AppColors.borderBrandSoft),
    ),
    child: Row(
      children: [
        const CircleAvatar(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.textInverse,
          child: Icon(Icons.place_outlined, size: 19),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Điểm dừng kế tiếp', style: AppTypography.caption),
              Text(
                activity.startTime == null
                    ? activity.title
                    : '${activity.title} • ${_formatTime(activity.startTime!)}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        const Icon(Icons.arrow_forward_rounded, color: AppColors.primary),
      ],
    ),
  );
}

class _MemberStack extends StatelessWidget {
  const _MemberStack({required this.trip});
  final TripListItem trip;

  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      for (final member in trip.memberPreviews.take(3)) ...[
        AppAvatar(
          size: 30,
          imageUrl: member.avatarUrl,
          initials: _initials(member.username),
        ),
        const SizedBox(width: 2),
      ],
      const SizedBox(width: AppSpacing.xxs),
      Flexible(
        child: Text(
          '${trip.memberCount} thành viên',
          overflow: TextOverflow.ellipsis,
          style: AppTypography.caption,
        ),
      ),
    ],
  );
}

class _TripListCard extends StatelessWidget {
  const _TripListCard({required this.trip});
  final TripListItem trip;

  @override
  Widget build(BuildContext context) => AppGlassSurface(
    padding: const EdgeInsets.all(AppSpacing.sm),
    child: InkWell(
      onTap: () => _openTrip(context, trip.id),
      borderRadius: BorderRadius.circular(AppRadius.cardLarge),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(AppRadius.image),
            child: SizedBox(
              width: 96,
              height: 96,
              child: trip.coverImageUrl == null
                  ? const _CoverFallback()
                  : Image.network(
                      trip.coverImageUrl!,
                      fit: BoxFit.cover,
                      errorBuilder: (_, _, _) => const _CoverFallback(),
                    ),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${_formatDate(trip.startDate)} – ${_formatDate(trip.endDate)}',
                  style: AppTypography.caption.copyWith(
                    color: AppColors.primaryActive,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: AppSpacing.xxs),
                Text(
                  trip.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.cardTitle,
                ),
                const SizedBox(height: AppSpacing.xs),
                Row(
                  children: [
                    const Icon(
                      Icons.group_outlined,
                      size: 15,
                      color: AppColors.primary,
                    ),
                    const SizedBox(width: 3),
                    Text(
                      '${trip.memberCount}/${trip.maxMembers} người',
                      style: AppTypography.caption,
                    ),
                    const SizedBox(width: AppSpacing.xs),
                    const Icon(
                      Icons.schedule_rounded,
                      size: 15,
                      color: AppColors.primary,
                    ),
                    const SizedBox(width: 3),
                    Text(
                      '${trip.endDate.difference(trip.startDate).inDays + 1} ngày',
                      style: AppTypography.caption,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right_rounded, color: AppColors.primary),
        ],
      ),
    ),
  );
}

class _InvitationList extends ConsumerWidget {
  const _InvitationList({required this.value});
  final AsyncValue<TripInvitationsState> value;

  @override
  Widget build(BuildContext context, WidgetRef ref) => value.when(
    skipLoadingOnRefresh: true,
    data: (state) {
      if (state.items.isEmpty) {
        return const AppEmptyView(
          title: 'Không có lời mời mới',
          description: 'Lời mời tham gia chuyến đi sẽ xuất hiện tại đây.',
          icon: Icons.mark_email_read_outlined,
        );
      }
      return Column(
        children: state.items
            .map(
              (item) => Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                child: _InvitationCard(invitation: item),
              ),
            )
            .toList(growable: false),
      );
    },
    loading: () => const Center(
      child: CircularProgressIndicator(color: AppColors.primary),
    ),
    error: (error, _) => AppErrorView(
      title: 'Không thể tải lời mời',
      message: _errorMessage(error),
      onRetry: ref.read(tripInvitationsControllerProvider.notifier).refresh,
    ),
  );
}

class _InvitationCard extends ConsumerStatefulWidget {
  const _InvitationCard({required this.invitation});
  final TripInvitation invitation;

  @override
  ConsumerState<_InvitationCard> createState() => _InvitationCardState();
}

class _InvitationCardState extends ConsumerState<_InvitationCard> {
  bool _busy = false;

  Future<void> _respond(bool accept) async {
    setState(() => _busy = true);
    try {
      final notifier = ref.read(tripInvitationsControllerProvider.notifier);
      if (accept) {
        await notifier.accept(widget.invitation.id);
      } else {
        await notifier.reject(widget.invitation.id);
      }
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(accept ? 'Đã đồng ý lời mời.' : 'Đã từ chối lời mời.'),
        ),
      );
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(_errorMessage(error))));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final inviter = widget.invitation.inviter;
    final trip = widget.invitation.trip;
    return AppGlassSurface(
      padding: const EdgeInsets.all(AppSpacing.md),
      borderColor: AppColors.primary38,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppAvatar(
            size: 46,
            imageUrl: inviter?.avatarUrl,
            initials: _initials(inviter?.username ?? '?'),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'LỜI MỜI CHUYẾN ĐI MỚI',
                  style: AppTypography.badge.copyWith(
                    color: AppColors.primaryActive,
                  ),
                ),
                const SizedBox(height: AppSpacing.xxs),
                Text(
                  '${inviter?.username ?? 'Một người dùng'} mời bạn tham gia',
                  style: AppTypography.body,
                ),
                Text(
                  trip?.name ?? 'Chuyến đi',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.cardTitle,
                ),
                const SizedBox(height: AppSpacing.sm),
                Row(
                  children: [
                    Expanded(
                      child: AppButton(
                        label: 'Đồng ý',
                        leadingIcon: Icons.check_rounded,
                        isLoading: _busy,
                        onPressed: _busy ? null : () => _respond(true),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.xs),
                    AppButton(
                      label: 'Từ chối',
                      variant: AppButtonVariant.secondary,
                      expand: false,
                      onPressed: _busy ? null : () => _respond(false),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TripEmpty extends StatelessWidget {
  const _TripEmpty({required this.tab});
  final _TripTab tab;
  @override
  Widget build(BuildContext context) => AppEmptyView(
    title: switch (tab) {
      _TripTab.ongoing => 'Không có chuyến đi đang diễn ra',
      _TripTab.upcoming => 'Chưa có chuyến đi sắp tới',
      _TripTab.completed => 'Chưa có chuyến đi đã hoàn thành',
      _TripTab.invitations => 'Không có lời mời mới',
    },
    description: 'Kéo xuống để làm mới dữ liệu.',
    icon: Icons.luggage_outlined,
  );
}

class _TripSkeleton extends StatelessWidget {
  const _TripSkeleton();
  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.all(AppSpacing.screenHorizontal),
    children: const [
      Row(
        children: [
          Expanded(child: AppSkeleton(width: 120, height: 112)),
          SizedBox(width: AppSpacing.xs),
          Expanded(child: AppSkeleton(width: 120, height: 112)),
        ],
      ),
      SizedBox(height: AppSpacing.lg),
      AppSkeleton(width: double.infinity, height: 54, radius: AppRadius.pill),
      SizedBox(height: AppSpacing.xl),
      AppSkeleton(width: 220, height: 24),
      SizedBox(height: AppSpacing.sm),
      AppSkeleton(width: double.infinity, height: 430, radius: AppRadius.hero),
    ],
  );
}

void _openTrip(BuildContext context, String tripId) => context.pushNamed(
  RouteNames.tripDetail,
  pathParameters: {'tripId': tripId},
);

String _sectionTitle(_TripTab tab) => switch (tab) {
  _TripTab.ongoing => 'Chuyến Đi Đang Diễn Ra',
  _TripTab.upcoming => 'Chuyến Đi Sắp Tới',
  _TripTab.completed => 'Chuyến Đi Đã Hoàn Thành',
  _TripTab.invitations => 'Lời Mời',
};

String _formatDate(DateTime date) =>
    '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';

String _formatTime(DateTime date) =>
    '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')} ${_formatDate(date)}';

String _currentDay(TripListItem trip) {
  final current = DateTime.now().difference(trip.startDate).inDays + 1;
  final total = trip.endDate.difference(trip.startDate).inDays + 1;
  return 'NGÀY ${current.clamp(1, total)}/$total';
}

String _initials(String value) {
  final parts = value.trim().split(RegExp(r'\s+'));
  if (parts.isEmpty || parts.first.isEmpty) return '?';
  return parts.take(2).map((part) => part[0].toUpperCase()).join();
}

String _errorMessage(Object error) =>
    error is ApiException ? error.message : 'Đã xảy ra lỗi. Vui lòng thử lại.';

void _showComingSoon(BuildContext context, String feature) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('$feature sẽ được bổ sung khi luồng sẵn sàng.')),
  );
}
