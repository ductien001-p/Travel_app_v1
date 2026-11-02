import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_frontend_v1/app/router/router_names.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_shadows.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/widget/app_button.dart';
import 'package:travel_frontend_v1/core/widget/app_empty_view.dart';
import 'package:travel_frontend_v1/core/widget/app_error_view.dart';
import 'package:travel_frontend_v1/core/widget/app_glass_surface.dart';
import 'package:travel_frontend_v1/core/widget/app_scaffold.dart';
import 'package:travel_frontend_v1/core/widget/app_top_bar.dart';

import '../../application/shared_itinerary_controller.dart';
import '../../application/trip_itinerary_controller.dart';
import '../../application/trip_itinerary_route.dart';
import '../../data/models/trip_share_models.dart';
import '../../utils/trip_detail_formatters.dart';
import '../widgets/itinerary/shared_itinerary_header.dart';
import '../widgets/itinerary/trip_itinerary_body.dart';
import '../widgets/itinerary/trip_itinerary_skeleton.dart';

/// Read-only itinerary opened from a share link (`/shared/:token`).
class SharedItineraryScreen extends ConsumerStatefulWidget {
  const SharedItineraryScreen({super.key, required this.token});

  final String token;

  @override
  ConsumerState<SharedItineraryScreen> createState() =>
      _SharedItineraryScreenState();
}

class _SharedItineraryScreenState extends ConsumerState<SharedItineraryScreen> {
  String? _destinationId;
  String? _dayId;

  @override
  Widget build(BuildContext context) {
    final provider = sharedItineraryProvider(widget.token);
    final shared = ref.watch(provider);
    final value = shared.value;

    return AppScaffold(
      topBar: AppTopBar(title: 'Lịch trình được chia sẻ', onBack: _goBack),
      bottomNavigationBar: value != null && value.viewerIsMember
          ? _OpenTripBar(onPressed: () => _openTrip(value.trip.id))
          : null,
      body: switch (shared) {
        AsyncValue(:final value?) => _buildContent(value),
        AsyncValue(:final error?) when isShareLinkGone(error) => AppEmptyView(
          icon: Icons.link_off_rounded,
          title: 'Link không còn hiệu lực',
          description:
              'Link chia sẻ đã hết hạn, bị thu hồi hoặc không tồn tại. '
              'Hãy nhờ người chia sẻ gửi link mới.',
          actionLabel: 'Về trang chủ',
          onAction: () => context.goNamed(RouteNames.home),
        ),
        AsyncValue(:final error?) => AppErrorView(
          title: 'Không thể tải lịch trình',
          message: tripDetailErrorMessage(error),
          actionLabel: 'Thử lại',
          onRetry: () => ref.invalidate(provider),
        ),
        _ => const TripItinerarySkeleton(),
      },
    );
  }

  Widget _buildContent(SharedItinerary shared) {
    final view = buildSharedItineraryView(
      shared,
      now: ref.read(tripItineraryClockProvider)(),
      destinationId: _destinationId,
      dayId: _dayId,
    );
    final header = SharedItineraryHeader(trip: shared.trip);
    if (view.isEmpty) {
      return ListView(
        padding: const EdgeInsets.all(AppSpacing.screenHorizontal),
        children: [
          header,
          const SizedBox(height: AppSpacing.xl),
          const AppEmptyView(
            icon: Icons.event_note_outlined,
            title: 'Chưa có lịch trình',
            description: 'Chuyến đi này chưa có điểm đến nào.',
          ),
        ],
      );
    }
    final day = view.selectedDay;
    return TripItineraryBody(
      view: view,
      header: header,
      onSelectDestination: (destinationId) => setState(() {
        _destinationId = destinationId;
        _dayId = null;
      }),
      onSelectDay: ({required destinationId, required dayId}) => setState(() {
        _destinationId = destinationId;
        _dayId = dayId;
      }),
      // Road routes are member-only; a shared view shows estimates.
      route: day == null ? null : summarizeDayRoute(day, null),
    );
  }

  void _openTrip(String tripId) => context.goNamed(
    RouteNames.tripItinerary,
    pathParameters: {'tripId': tripId},
  );

  void _goBack() {
    if (context.canPop()) {
      context.pop();
    } else {
      context.goNamed(RouteNames.home);
    }
  }
}

class _OpenTripBar extends StatelessWidget {
  const _OpenTripBar({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return AppGlassSurface(
      radius: 0,
      color: AppColors.glass85,
      shadows: AppShadows.level2,
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: AppButton(
            label: 'Mở chuyến đi',
            trailingIcon: Icons.arrow_forward_rounded,
            onPressed: onPressed,
          ),
        ),
      ),
    );
  }
}
