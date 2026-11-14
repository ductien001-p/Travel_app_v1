import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_frontend_v1/app/router/router_names.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_gradients.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_shadows.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_chip.dart';
import 'package:travel_frontend_v1/core/widget/app_empty_view.dart';
import 'package:travel_frontend_v1/core/widget/app_error_view.dart';
import 'package:travel_frontend_v1/core/widget/app_pressable.dart';
import 'package:travel_frontend_v1/core/widget/app_search_bar.dart';
import 'package:travel_frontend_v1/core/widget/app_section_header.dart';
import 'package:travel_frontend_v1/core/widget/app_skeleton.dart';
import 'package:travel_frontend_v1/features/home/application/home_failure_message.dart';
import 'package:travel_frontend_v1/features/home/data/models/explore_home_models.dart';
import 'package:travel_frontend_v1/features/trips/trip-invitation/data/models/trip_join_request_models.dart';

import '../../application/destination_trips_controller.dart';
import '../../../places/place-details/presentation/place_detail_navigation.dart';
import '../widgets/destination_hero_banner.dart';
import '../widgets/destination_spot_tile.dart';
import '../widgets/destination_trip_card.dart';
import '../widgets/destination_trips_top_bar.dart';

class DestinationTripsScreen extends ConsumerStatefulWidget {
  const DestinationTripsScreen({
    super.key,
    required this.cityName,
    this.catalogId,
  });

  final String cityName;
  final String? catalogId;

  @override
  ConsumerState<DestinationTripsScreen> createState() =>
      _DestinationTripsScreenState();
}

class _DestinationTripsScreenState
    extends ConsumerState<DestinationTripsScreen> {
  final _searchController = TextEditingController();
  var _searchVisible = false;

  DestinationTripsArgs get _args => DestinationTripsArgs(
    cityName: widget.cityName.trim(),
    catalogId: _blankToNull(widget.catalogId),
  );

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final city = widget.cityName.trim();
    if (city.isEmpty) {
      return const _MissingCity();
    }

    final viewState = ref.watch(destinationTripsControllerProvider(_args));
    return DecoratedBox(
      decoration: const BoxDecoration(gradient: AppGradients.pageAtmosphere),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          bottom: false,
          child: viewState.when(
            loading: () => _Loading(cityName: city, onBack: _back),
            error: (error, _) => _Failure(
              cityName: city,
              error: error,
              onBack: _back,
              onRetry: () => ref
                  .read(destinationTripsControllerProvider(_args).notifier)
                  .refresh(),
            ),
            data: (view) => _DestinationBody(
              view: view,
              args: _args,
              searchVisible: _searchVisible,
              searchController: _searchController,
              onBack: _back,
              onToggleSearch: _toggleSearch,
              onTune: () => _openFilters(view.selectedFilterId),
            ),
          ),
        ),
      ),
    );
  }

  void _back() {
    if (context.canPop()) {
      context.pop();
      return;
    }
    context.goNamed(RouteNames.home);
  }

  void _toggleSearch() {
    setState(() => _searchVisible = !_searchVisible);
    if (!_searchVisible) {
      _searchController.clear();
      ref
          .read(destinationTripsControllerProvider(_args).notifier)
          .setSearchQuery('');
    }
  }

  Future<void> _openFilters(String selectedId) async {
    await showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppRadius.sheet),
        ),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Wrap(
              spacing: AppSpacing.xs,
              runSpacing: AppSpacing.xs,
              children: [
                for (final filter in destinationTripFilters)
                  AppChip(
                    label: filter.label,
                    selected: filter.id == selectedId,
                    onTap: () {
                      Navigator.of(context).pop();
                      ref
                          .read(
                            destinationTripsControllerProvider(_args).notifier,
                          )
                          .selectFilter(filter.id);
                    },
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _DestinationBody extends ConsumerWidget {
  const _DestinationBody({
    required this.view,
    required this.args,
    required this.searchVisible,
    required this.searchController,
    required this.onBack,
    required this.onToggleSearch,
    required this.onTune,
  });

  final DestinationTripsViewState view;
  final DestinationTripsArgs args;
  final bool searchVisible;
  final TextEditingController searchController;
  final VoidCallback onBack;
  final VoidCallback onToggleSearch;
  final VoidCallback onTune;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(
      destinationTripsControllerProvider(args).notifier,
    );
    final profile = view.page.profile;
    final city = profile.name.trim().isEmpty ? args.cityName : profile.name;

    return Stack(
      children: [
        Column(
          children: [
            DestinationTripsTopBar(
              title: city,
              regionLabel: profile.regionLabel,
              openTripCount: view.openTripCount,
              onBack: onBack,
              onSearch: onToggleSearch,
              onTune: onTune,
            ),
            if (searchVisible)
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.md,
                  AppSpacing.xs,
                  AppSpacing.md,
                  0,
                ),
                child: AppSearchBar(
                  controller: searchController,
                  hintText: 'Tìm chuyến ở $city',
                  onChanged: controller.setSearchQuery,
                ),
              ),
            Expanded(
              child: RefreshIndicator(
                color: AppColors.primary,
                onRefresh: controller.refresh,
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.md,
                    AppSpacing.md,
                    AppSpacing.md,
                    120,
                  ),
                  children: [
                    if (view.reloadError != null) ...[
                      Text(
                        view.reloadError!,
                        style: AppTypography.body.copyWith(
                          color: AppColors.danger,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.md),
                    ],
                    DestinationHeroBanner(
                      profile: profile,
                      saved: view.saved,
                      onToggleSaved: controller.toggleSaved,
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Tìm chuyến phù hợp',
                            style: AppTypography.sectionTitle,
                          ),
                        ),
                        AppPressable(
                          onTap: controller.resetFilters,
                          child: Row(
                            children: [
                              Text(
                                'Đặt lại',
                                style: AppTypography.caption.copyWith(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const Icon(
                                Icons.refresh_rounded,
                                size: 16,
                                color: AppColors.primary,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    SizedBox(
                      height: 36,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: destinationTripFilters.length,
                        separatorBuilder: (_, _) =>
                            const SizedBox(width: AppSpacing.xs),
                        itemBuilder: (context, index) {
                          final filter = destinationTripFilters[index];
                          final label = filter.id == 'all'
                              ? 'Tất cả (${view.openTripCount})'
                              : filter.label;
                          return AppChip(
                            label: label,
                            selected: filter.id == view.selectedFilterId,
                            onTap: () => controller.selectFilter(filter.id),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    if (view.visibleTrips.isEmpty)
                      const AppEmptyView(
                        title: 'Chưa có chuyến đi phù hợp',
                        description:
                            'Thử đổi bộ lọc hoặc tạo chuyến đi mới tới điểm này.',
                      )
                    else
                      for (final trip in view.visibleTrips) ...[
                        DestinationTripCard(
                          trip: trip,
                          bookmarked: view.bookmarkedTripIds.contains(trip.id),
                          joining: view.joiningTripId == trip.id,
                          onBookmark: () => controller.toggleBookmark(trip.id),
                          onOpen: () => context.pushNamed(
                            RouteNames.tripDetail,
                            pathParameters: {'tripId': trip.id},
                          ),
                          onJoin: () => _join(context, ref, trip),
                        ),
                        const SizedBox(height: AppSpacing.md),
                      ],
                    const SizedBox(height: AppSpacing.sm),
                    AppSectionHeader(
                      title: 'Không thể bỏ qua tại $city',
                      subtitle: 'Các toạ độ check-in được lưu nhiều nhất',
                      actionLabel: view.canExpandSpots ? 'Xem tất cả' : null,
                      onAction: view.canExpandSpots
                          ? controller.expandSpots
                          : null,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    if (view.page.spots.isEmpty)
                      const AppEmptyView(
                        title: 'Chưa có địa điểm nổi bật',
                        description:
                            'Danh sách sẽ hiện khi điểm đến có địa điểm.',
                      )
                    else
                      for (final spot in view.page.spots) ...[
                        DestinationSpotTile(
                          spot: spot,
                          onOpen: () => openPlaceDetail(context, spot.id),
                        ),
                        const SizedBox(height: AppSpacing.sm),
                      ],
                  ],
                ),
              ),
            ),
          ],
        ),
        Positioned(
          left: AppSpacing.lg,
          right: AppSpacing.lg,
          bottom: AppSpacing.lg,
          child: AppPressable(
            onTap: () => context.pushNamed(RouteNames.createTrip),
            pressedScale: 0.97,
            borderRadius: BorderRadius.circular(AppRadius.pill),
            child: Container(
              height: 52,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(AppRadius.pill),
                boxShadow: AppShadows.primaryGlow,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.add_rounded, color: AppColors.textInverse),
                  const SizedBox(width: 8),
                  Flexible(
                    child: Text(
                      'Tạo chuyến đi tới $city',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.buttonLarge,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _join(
    BuildContext context,
    WidgetRef ref,
    CommunityTripCard trip,
  ) async {
    final messenger = ScaffoldMessenger.of(context);
    try {
      final request = await ref
          .read(destinationTripsControllerProvider(args).notifier)
          .joinTrip(trip.id);
      if (!context.mounted) return;
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
      if (!context.mounted) return;
      messenger.showSnackBar(
        SnackBar(content: Text(homeFailureMessage(error))),
      );
    }
  }
}

class _Loading extends StatelessWidget {
  const _Loading({required this.cityName, required this.onBack});

  final String cityName;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DestinationTripsTopBar(
          title: cityName,
          onBack: onBack,
          onSearch: () {},
          onTune: () {},
        ),
        const Expanded(
          child: Padding(
            padding: EdgeInsets.all(AppSpacing.md),
            child: Column(
              children: [
                AppSkeleton(width: double.infinity, height: 220),
                SizedBox(height: AppSpacing.md),
                AppSkeleton(width: double.infinity, height: 36),
                SizedBox(height: AppSpacing.md),
                AppSkeleton(width: double.infinity, height: 180),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _Failure extends StatelessWidget {
  const _Failure({
    required this.cityName,
    required this.error,
    required this.onBack,
    required this.onRetry,
  });

  final String cityName;
  final Object error;
  final VoidCallback onBack;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final unauthorized = homeFailureIsUnauthorized(error);
    return Column(
      children: [
        DestinationTripsTopBar(
          title: cityName,
          onBack: onBack,
          onSearch: () {},
          onTune: () {},
        ),
        Expanded(
          child: AppErrorView(
            title: unauthorized
                ? 'Phiên đăng nhập đã hết hạn'
                : 'Không tải được chuyến đi',
            message: unauthorized
                ? 'Đăng nhập lại để xem các chuyến tới $cityName.'
                : homeFailureMessage(error),
            actionLabel: 'Thử lại',
            onRetry: unauthorized ? null : onRetry,
          ),
        ),
      ],
    );
  }
}

class _MissingCity extends StatelessWidget {
  const _MissingCity();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppErrorView(
        title: 'Thiếu điểm đến',
        message: 'Mở lại từ danh sách điểm đến trên Khám phá.',
        actionLabel: 'Về Khám phá',
        onRetry: () => context.goNamed(RouteNames.home),
      ),
    );
  }
}

String? _blankToNull(String? value) {
  final trimmed = value?.trim();
  if (trimmed == null || trimmed.isEmpty) return null;
  return trimmed;
}
