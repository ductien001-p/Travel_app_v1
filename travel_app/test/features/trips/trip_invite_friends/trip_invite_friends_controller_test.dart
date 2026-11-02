import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:travel_frontend_v1/features/trips/trip-invitation/application/trip_invite_friends_controller.dart';
import 'package:travel_frontend_v1/features/trips/trip-invitation/application/trip_invite_friends_view.dart';
import 'package:travel_frontend_v1/features/trips/trip-invitation/data/datamock/trip_invite_friends_datamock.dart';
import 'package:travel_frontend_v1/features/trips/trip-invitation/data/models/trip_invite_friends_models.dart';
import 'package:travel_frontend_v1/features/trips/trip-invitation/provider/trip_invite_friends_provider.dart';
import 'package:travel_frontend_v1/features/trips/trip-invitation/utils/trip_invite_friends_formatters.dart';

import 'fake_trip_invite_friends_datasource.dart';

void main() {
  late FakeTripInviteFriendsDataSource dataSource;

  ProviderContainer createContainer() {
    final container = ProviderContainer(
      overrides: [
        tripInviteFriendsDataSourceProvider.overrideWithValue(dataSource),
      ],
    );
    addTearDown(container.dispose);
    return container;
  }

  Future<TripInviteFriendsController> load(ProviderContainer container) async {
    final provider = tripInviteFriendsControllerProvider('trip-1');
    container.listen(provider, (_, _) {});
    await container.read(provider.future);
    return container.read(provider.notifier);
  }

  TripInviteCandidate person(ProviderContainer container, String id) =>
      container
          .read(tripInviteFriendsControllerProvider('trip-1'))
          .value!
          .candidates
          .firstWhere((item) => item.user.id == id);

  setUp(() => dataSource = FakeTripInviteFriendsDataSource());

  test('selects until the open seats run out', () async {
    final container = createContainer();
    final controller = await load(container);

    controller.toggle(person(container, 'user-duc-huy'), openSlots: 1);
    controller.toggle(person(container, 'user-khanh-vy'), openSlots: 1);

    final state = container
        .read(tripInviteFriendsControllerProvider('trip-1'))
        .value!;
    expect(state.selectedById.keys, ['user-duc-huy']);
    expect(state.actionError, isA<TripInviteFriendsBlockedException>());
    expect(
      tripInviteFriendsErrorMessage(state.actionError!),
      'Chuyến đi đã đủ chỗ.',
    );
  });

  test('does not select a pending invitation', () async {
    final container = createContainer();
    final controller = await load(container);
    final pending = person(container, 'user-thanh-hang');

    controller.toggle(pending, openSlots: 2);

    expect(
      container
          .read(tripInviteFriendsControllerProvider('trip-1'))
          .value!
          .selectedById,
      isEmpty,
    );
    expect(pending.canInvite, isFalse);
  });

  test('send posts one invitation per selected friend', () async {
    final container = createContainer();
    final controller = await load(container);
    controller
      ..toggle(person(container, 'user-minh-anh'), openSlots: 2)
      ..toggle(person(container, 'user-duc-huy'), openSlots: 2);

    final result = await controller.send(tripIsOpen: true, openSlots: 2);

    expect(result?.sentCount, 2);
    expect(result?.hasFailure, isFalse);
    expect(dataSource.invitedIds, ['user-minh-anh', 'user-duc-huy']);
    final state = container
        .read(tripInviteFriendsControllerProvider('trip-1'))
        .value!;
    expect(state.selectedById, isEmpty);
    expect(state.isSending, isFalse);
    expect(
      state.candidates
          .firstWhere((item) => item.user.id == 'user-duc-huy')
          .invitationStatus,
      TripInviteStatus.pending,
    );
  });

  test('a pending conflict still counts as sent', () async {
    dataSource.inviteError = alreadyPendingInvite;
    final container = createContainer();
    final controller = await load(container);
    controller.toggle(person(container, 'user-duc-huy'), openSlots: 1);

    final result = await controller.send(tripIsOpen: true, openSlots: 1);

    expect(result?.sentCount, 1);
    expect(result?.failedCount, 0);
  });

  test('refuses to send when the trip is not upcoming', () async {
    final container = createContainer();
    final controller = await load(container);
    controller.toggle(person(container, 'user-duc-huy'), openSlots: 1);

    final result = await controller.send(tripIsOpen: false, openSlots: 1);

    expect(result, isNull);
    expect(dataSource.invitedIds, isEmpty);
    expect(
      container
          .read(tripInviteFriendsControllerProvider('trip-1'))
          .value!
          .actionError,
      isA<TripInviteFriendsBlockedException>(),
    );
  });

  test('search merges hits with the friends already loaded', () async {
    final container = createContainer();
    final controller = await load(container);
    controller.setQuery('huy');
    await Future<void>.delayed(const Duration(milliseconds: 400));

    final state = container
        .read(tripInviteFriendsControllerProvider('trip-1'))
        .value!;
    expect(dataSource.lastQuery, 'huy');
    expect(state.isSearching, isFalse);
    expect(state.searchResults?.map((item) => item.user.displayName), [
      'Đức Huy',
      'Bảo Nam',
    ]);
    final view = buildTripInviteFriendsView(
      candidates: state.candidates,
      searchResults: state.searchResults,
      hasMoreSearchResults: state.hasMoreSearchResults,
      filter: state.filter,
      selectedById: state.selectedById,
      excludedUserIds: const {},
      now: DateTime.parse(tripInviteFriendsDatamockNow),
    );
    expect(view.isSearch, isTrue);
    expect(view.singleSectionTitle, 'Kết quả tìm kiếm');
  });
}
