import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_frontend_v1/app/router/router_names.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_gradients.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_button.dart';
import 'package:travel_frontend_v1/core/widget/app_chip.dart';
import 'package:travel_frontend_v1/core/widget/app_empty_view.dart';
import 'package:travel_frontend_v1/core/widget/app_error_view.dart';
import 'package:travel_frontend_v1/core/widget/app_search_bar.dart';
import 'package:travel_frontend_v1/core/widget/app_segmented_control.dart';
import 'package:travel_frontend_v1/core/widget/app_skeleton.dart';
import 'package:travel_frontend_v1/features/profile/application/profile_controller.dart';

import 'package:travel_frontend_v1/features/trips/trip-invitation/data/models/trip_join_request_models.dart';

import '../../application/explore_home_controller.dart';
import '../../application/home_failure_message.dart';
import '../../data/models/explore_home_models.dart';
import '../../places/application/explore_places_controller.dart';
import '../../places/presentation/widgets/explore_places_tab.dart';
import '../widgets/community_trip_card.dart';
import '../widgets/explore_destination_card.dart';
import '../widgets/explore_home_header.dart';
import '../widgets/explore_live_trip_card.dart';
import '../widgets/explore_publish_banner.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final feedState = ref.watch(exploreHomeControllerProvider);
    final profile = ref.watch(profileControllerProvider).asData?.value;

    return DecoratedBox(
      decoration: const BoxDecoration(gradient: AppGradients.pageAtmosphere),
      child: SafeArea(
        bottom: false,
        child: feedState.when(
          loading: () => const _ExploreLoading(),
          error: (error, _) {
            final unauthorized = homeFailureIsUnauthorized(error);
            return AppErrorView(
              title: unauthorized
                  ? 'Phiên đăng nhập đã hết hạn'
                  : 'Không tải được khám phá',
              message: unauthorized
                  ? 'Đăng nhập lại để xem khám phá.'
                  : homeFailureMessage(error),
              actionLabel: 'Thử lại',
              onRetry: unauthorized
                  ? null
                  : () => ref
                        .read(exploreHomeControllerProvider.notifier)
                        .refresh(),
            );
          },
          data: (view) => _ExploreBody(
            view: view,
            profileDisplayName: profile?.displayName,
            profileAvatarUrl: profile?.avatarUrl,
            profileLocation: profile?.location,
          ),
        ),
      ),
    );
  }
}

class _ExploreBody extends ConsumerWidget {
  const _ExploreBody({
    required this.view,
    this.profileDisplayName,
    this.profileAvatarUrl,
    this.profileLocation,
  });

  final ExploreHomeViewState view;
  final String? profileDisplayName;
  final String? profileAvatarUrl;
  final String? profileLocation;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(exploreHomeControllerProvider.notifier);
    final header = view.feed.header;
    final displayName = (profileDisplayName?.trim().isNotEmpty ?? false)
        ? profileDisplayName!.trim()
        : header.displayName;
    final avatarUrl = profileAvatarUrl ?? header.avatarUrl;
    final locationLabel = profileLocation?.trim() ?? '';

    return RefreshIndicator(
      color: AppColors.primary,
      onRefresh: () => _refreshExplore(ref, controller, view.segment),
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.screenHorizontal,
              AppSpacing.sm,
              AppSpacing.screenHorizontal,
              AppSpacing.safeBottom,
            ),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                ExploreGreetingHeader(
                  displayName: displayName,
                  locationLabel: locationLabel,
                  avatarUrl: avatarUrl,
                  onAvatarTap: () => context.goNamed(RouteNames.profile),
                ),
                const SizedBox(height: AppSpacing.md),
                AppSegmentedControl<ExploreHomeSegment>(
                  value: view.segment,
                  onChanged: controller.selectSegment,
                  items: const [
                    AppSegmentedItem(
                      value: ExploreHomeSegment.places,
                      label: 'Địa Điểm',
                    ),
                    AppSegmentedItem(
                      value: ExploreHomeSegment.community,
                      label: 'Chuyến Đi Cộng Đồng',
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.md),
                if (view.feed.destinations.isNotEmpty) ...[
                  const _SectionHeader(
                    icon: Icons.near_me_rounded,
                    title: 'Tìm Theo Điểm Đến',
                    trailing: Text(
                      'Điểm đến hot nhất',
                      style: AppTypography.caption,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  SizedBox(
                    height: 168,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: view.feed.destinations.length,
                      separatorBuilder: (_, _) =>
                          const SizedBox(width: AppSpacing.sm),
                      itemBuilder: (context, index) {
                        final dest = view.feed.destinations[index];
                        return ExploreDestinationCard(
                          destination: dest,
                          onTap: () => context.pushNamed(
                            RouteNames.destinationTrips,
                            queryParameters: {
                              'city': dest.name,
                              'catalogId': dest.id,
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: AppSpacing.section),
                ],
                if (view.reloadError != null) ...[
                  Text(
                    view.reloadError!,
                    style: AppTypography.body.copyWith(color: AppColors.danger),
                  ),
                  const SizedBox(height: AppSpacing.md),
                ],
                if (view.segment == ExploreHomeSegment.places)
                  const ExplorePlacesTab()
                else if (view.segment == ExploreHomeSegment.community) ...[
                  _CommunitySearch(
                    query: view.searchQuery,
                    onChanged: controller.setSearchQuery,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  _FilterChips(
                    filters: view.feed.filters,
                    selectedId: view.selectedFilterId,
                    onSelected: controller.selectFilter,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  const ExplorePublishBanner(),
                  const SizedBox(height: AppSpacing.section),
                  const _SectionHeader(
                    icon: Icons.local_fire_department_rounded,
                    title: 'Chuyến Đi Hot Đang Tuyển',
                  ),
                  const SizedBox(height: AppSpacing.md),
                  if (view.filteredHotTrips.isEmpty)
                    const AppEmptyView(
                      title: 'Không có chuyến đi phù hợp',
                      description: 'Thử đổi bộ lọc hoặc từ khóa tìm kiếm.',
                    )
                  else
                    for (final trip in view.filteredHotTrips) ...[
                      CommunityTripCardWidget(
                        trip: trip,
                        isBookmarked: view.bookmarkedTripIds.contains(trip.id),
                        joining: view.joiningTripId == trip.id,
                        onBookmark: () => controller.toggleBookmark(trip.id),
                        onViewItinerary: () => _openTrip(context, trip.id),
                        onJoin: () => _joinTrip(context, ref, trip),
                      ),
                      const SizedBox(height: AppSpacing.md),
                    ],
                  if (view.loadingMore)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: AppSpacing.md),
                      child: Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primary,
                        ),
                      ),
                    )
                  else if (view.feed.hasNextPage) ...[
                    AppButton(
                      label: 'Tải thêm',
                      onPressed: controller.loadNextPage,
                      variant: AppButtonVariant.secondary,
                      expand: true,
                    ),
                    const SizedBox(height: AppSpacing.md),
                  ],
                  if (view.loadMoreError != null) ...[
                    Text(
                      view.loadMoreError!,
                      style: AppTypography.body.copyWith(
                        color: AppColors.danger,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                  ],
                  if (view.feed.liveTrips.isNotEmpty) ...[
                    const SizedBox(height: AppSpacing.section),
                    Row(
                      children: [
                        Container(
                          width: 10,
                          height: 10,
                          decoration: const BoxDecoration(
                            color: AppColors.success,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'Chuyến Đi Đang Diễn Ra',
                          style: AppTypography.sectionTitle.copyWith(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.md),
                    for (final live in view.feed.liveTrips) ...[
                      ExploreLiveTripCard(update: live),
                      const SizedBox(height: AppSpacing.sm),
                    ],
                  ],
                ],
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _refreshExplore(
    WidgetRef ref,
    ExploreHomeController controller,
    ExploreHomeSegment segment,
  ) async {
    final places = segment == ExploreHomeSegment.places
        ? ref.read(explorePlacesControllerProvider.notifier).refresh()
        : null;
    await controller.refresh();
    await places;
  }

  void _openTrip(BuildContext context, String tripId) {
    context.pushNamed(
      RouteNames.tripDetail,
      pathParameters: {'tripId': tripId},
    );
  }

  Future<void> _joinTrip(
    BuildContext context,
    WidgetRef ref,
    CommunityTripCard trip,
  ) async {
    final messenger = ScaffoldMessenger.of(context);
    try {
      final request = await ref
          .read(exploreHomeControllerProvider.notifier)
          .joinTrip(trip.id);
      final approved = request.status == TripJoinRequestStatus.approved;
      messenger.showSnackBar(
        SnackBar(
          content: Text(
            approved
                ? 'Đã tham gia "${trip.title}"'
                : 'Đã gửi yêu cầu tham gia "${trip.title}"',
          ),
        ),
      );
    } catch (error) {
      messenger.showSnackBar(
        SnackBar(content: Text(homeFailureMessage(error))),
      );
    }
  }
}

class _FilterChips extends StatelessWidget {
  const _FilterChips({
    required this.filters,
    required this.selectedId,
    required this.onSelected,
  });

  final List<ExploreFilterChip> filters;
  final String selectedId;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.xs),
        itemBuilder: (context, index) {
          final filter = filters[index];
          return AppChip(
            label: filter.label,
            selected: filter.id == selectedId,
            onTap: () => onSelected(filter.id),
          );
        },
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.icon,
    required this.title,
    this.trailing,
  });

  final IconData icon;
  final String title;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20, color: AppColors.primary),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            title,
            style: AppTypography.sectionTitle.copyWith(fontSize: 18),
          ),
        ),
        ?trailing,
      ],
    );
  }
}

class _CommunitySearch extends StatefulWidget {
  const _CommunitySearch({required this.query, required this.onChanged});

  final String query;
  final ValueChanged<String> onChanged;

  @override
  State<_CommunitySearch> createState() => _CommunitySearchState();
}

class _CommunitySearchState extends State<_CommunitySearch> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.query);
  }

  @override
  void didUpdateWidget(covariant _CommunitySearch oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.query != _controller.text) {
      _controller.value = TextEditingValue(
        text: widget.query,
        selection: TextSelection.collapsed(offset: widget.query.length),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppSearchBar(
      controller: _controller,
      hintText: 'Tìm kiếm chuyến đi, điểm đến, bạn đồng hành...',
      onChanged: widget.onChanged,
    );
  }
}

class _ExploreLoading extends StatelessWidget {
  const _ExploreLoading();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.screenHorizontal),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              AppSkeleton(width: 44, height: 44, radius: 22),
              SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppSkeleton(width: 160, height: 18),
                    SizedBox(height: 6),
                    AppSkeleton(width: 120, height: 12),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: AppSpacing.md),
          AppSkeleton(width: double.infinity, height: 44, radius: 22),
          SizedBox(height: AppSpacing.md),
          AppSkeleton(width: double.infinity, height: 40, radius: 20),
          SizedBox(height: AppSpacing.md),
          AppSkeleton(width: double.infinity, height: 200, radius: 20),
          SizedBox(height: AppSpacing.md),
          AppSkeleton(width: double.infinity, height: 280, radius: 20),
        ],
      ),
    );
  }
}
