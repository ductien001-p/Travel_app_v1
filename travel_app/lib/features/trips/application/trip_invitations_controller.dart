import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/trip_pagination.dart';
import '../data/models/trip_related_models.dart';
import '../data/models/trip_requests.dart';
import '../provider/trips_provider.dart';
import 'trip_list_controller.dart';

class TripInvitationsState {
  const TripInvitationsState({
    required this.items,
    required this.meta,
    this.isLoadingMore = false,
  });
  final List<TripInvitation> items;
  final PageMeta meta;
  final bool isLoadingMore;
}

final tripInvitationsControllerProvider =
    AsyncNotifierProvider<TripInvitationsController, TripInvitationsState>(
      TripInvitationsController.new,
    );

class TripInvitationsController extends AsyncNotifier<TripInvitationsState> {
  bool _busy = false;
  static const _limit = 20;

  @override
  FutureOr<TripInvitationsState> build() async {
    final page = await ref
        .watch(tripRepositoryProvider)
        .getReceivedInvitations(limit: _limit);
    return TripInvitationsState(items: page.items, meta: page.meta);
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final page = await ref
          .read(tripRepositoryProvider)
          .getReceivedInvitations(limit: _limit);
      return TripInvitationsState(items: page.items, meta: page.meta);
    });
  }

  Future<void> loadMore() async {
    final current = state.value;
    if (current == null || !current.meta.hasNextPage || _busy) return;
    _busy = true;
    state = AsyncData(
      TripInvitationsState(
        items: current.items,
        meta: current.meta,
        isLoadingMore: true,
      ),
    );
    try {
      final page = await ref
          .read(tripRepositoryProvider)
          .getReceivedInvitations(page: current.meta.page + 1, limit: _limit);
      state = AsyncData(
        TripInvitationsState(
          items: [...current.items, ...page.items],
          meta: page.meta,
        ),
      );
    } finally {
      _busy = false;
    }
  }

  Future<TripInvitation> invite(CreateTripInvitationRequest request) =>
      ref.read(tripRepositoryProvider).createInvitation(request);

  Future<TripInvitation> accept(String invitationId) async {
    final result = await ref
        .read(tripRepositoryProvider)
        .acceptInvitation(invitationId);
    ref.invalidate(tripListControllerProvider);
    ref.invalidate(tripDashboardControllerProvider);
    await refresh();
    return result;
  }

  Future<TripInvitation> reject(String invitationId) async {
    final result = await ref
        .read(tripRepositoryProvider)
        .rejectInvitation(invitationId);
    await refresh();
    return result;
  }

  Future<TripInvitation> cancel(String tripId, String invitationId) async {
    final result = await ref
        .read(tripRepositoryProvider)
        .cancelInvitation(tripId, invitationId);
    await refresh();
    return result;
  }
}
