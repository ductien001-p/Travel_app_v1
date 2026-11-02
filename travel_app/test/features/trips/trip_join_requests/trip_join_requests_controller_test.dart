import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:travel_frontend_v1/core/networks/api_exception.dart';
import 'package:travel_frontend_v1/features/trips/trip-details/application/trip_detail_overview_controller.dart';
import 'package:travel_frontend_v1/features/trips/trip-details/provider/trip_detail_provider.dart';
import 'package:travel_frontend_v1/features/trips/trip-invitation/application/trip_join_request_action_controller.dart';
import 'package:travel_frontend_v1/features/trips/trip-invitation/application/trip_join_request_settings_controller.dart';
import 'package:travel_frontend_v1/features/trips/trip-invitation/application/trip_join_requests_controller.dart';
import 'package:travel_frontend_v1/features/trips/trip-invitation/application/trip_join_requests_header.dart';
import 'package:travel_frontend_v1/features/trips/trip-invitation/data/models/trip_join_request_models.dart';
import 'package:travel_frontend_v1/features/trips/trip-invitation/provider/trip_join_requests_provider.dart';

import 'trip_join_requests_fixture.dart';

void main() {
  const tripId = 'trip-1';
  late FakeTripJoinRequestsDataSource dataSource;
  late CountingTripDetailDataSource tripDetail;

  ProviderContainer createContainer({int maxMembers = 6}) {
    tripDetail = CountingTripDetailDataSource(
      joinRequestsTripJson(maxMembers: maxMembers),
    );
    final container = ProviderContainer(
      overrides: [
        tripJoinRequestsDataSourceProvider.overrideWithValue(dataSource),
        tripDetailRemoteDataSourceProvider.overrideWithValue(tripDetail),
      ],
    );
    addTearDown(container.dispose);
    return container;
  }

  /// Keeps the screen providers alive like the mounted screen does.
  Future<void> openScreen(ProviderContainer container) async {
    container.listen(tripJoinRequestsHeaderProvider(tripId), (_, _) {});
    container.listen(tripJoinRequestsControllerProvider(tripId), (_, _) {});
    container.listen(
      tripJoinRequestActionControllerProvider(tripId),
      (_, _) {},
    );
    await container.read(tripJoinRequestsControllerProvider(tripId).future);
    while (!container.read(tripJoinRequestsHeaderProvider(tripId)).hasValue) {
      await Future<void>.delayed(Duration.zero);
    }
  }

  TripJoinRequestsState listOf(ProviderContainer container) =>
      container.read(tripJoinRequestsControllerProvider(tripId)).requireValue;

  TripJoinRequestActionController actionsOf(ProviderContainer container) =>
      container.read(tripJoinRequestActionControllerProvider(tripId).notifier);

  setUp(() => dataSource = FakeTripJoinRequestsDataSource());

  test('loads the pending tab first, then the selected tab', () async {
    final container = createContainer();
    await openScreen(container);

    expect(listOf(container).status, TripJoinRequestStatus.pending);
    expect(listOf(container).requests, hasLength(3));

    container
        .read(tripJoinRequestStatusProvider(tripId).notifier)
        .select(TripJoinRequestStatus.approved);
    final approved = await container.read(
      tripJoinRequestsControllerProvider(tripId).future,
    );

    expect(approved.status, TripJoinRequestStatus.approved);
    expect(approved.requests, hasLength(4));
    expect(dataSource.pageRequests.map((r) => r.status), [
      TripJoinRequestStatus.pending,
      TripJoinRequestStatus.approved,
    ]);
  });

  test(
    'approving takes the request off the tab and reloads the trip',
    () async {
      final container = createContainer();
      await openScreen(container);
      final loadsBefore = tripDetail.loads;

      final reviewed = await actionsOf(
        container,
      ).approve('join-request-minh-anh');

      expect(reviewed.status, TripJoinRequestStatus.approved);
      expect(
        listOf(container).requests.map((r) => r.id),
        isNot(contains('join-request-minh-anh')),
      );
      expect(listOf(container).counts.pending, 2);
      expect(listOf(container).counts.approved, 5);
      await container.read(tripDetailOverviewControllerProvider(tripId).future);
      expect(tripDetail.loads, loadsBefore + 1);
    },
  );

  test('rejecting does not reload the trip', () async {
    final container = createContainer();
    await openScreen(container);
    final loadsBefore = tripDetail.loads;

    await actionsOf(container).reject('join-request-dang-khoa');

    expect(listOf(container).counts.rejected, 2);
    expect(tripDetail.loads, loadsBefore);
  });

  test('does not ask the backend to approve into a full trip', () async {
    final container = createContainer(maxMembers: 4);
    await openScreen(container);

    await expectLater(
      actionsOf(container).approve('join-request-minh-anh'),
      throwsA(
        isA<TripJoinApprovalBlockedException>().having(
          (e) => e.block,
          'block',
          TripJoinApprovalBlock.full,
        ),
      ),
    );
    expect(dataSource.decisions, isEmpty);
    expect(listOf(container).requests, hasLength(3));
  });

  test('sends one decision at a time', () async {
    final container = createContainer();
    await openScreen(container);

    final first = actionsOf(container).approve('join-request-minh-anh');
    await expectLater(
      actionsOf(container).reject('join-request-dang-khoa'),
      throwsStateError,
    );
    await first;

    expect(dataSource.decisions, hasLength(1));
    expect(
      container.read(tripJoinRequestActionControllerProvider(tripId)).isBusy,
      isFalse,
    );
  });

  test('reloads the tab when the request was already reviewed', () async {
    final container = createContainer();
    await openScreen(container);
    final requestsBefore = dataSource.pageRequests.length;
    dataSource.decisionError = const ApiException(
      message: 'Join request has already been reviewed',
      statusCode: 409,
    );

    await expectLater(
      actionsOf(container).approve('join-request-minh-anh'),
      throwsA(isA<ApiException>()),
    );
    await Future<void>.delayed(Duration.zero);

    expect(dataSource.pageRequests.length, requestsBefore + 1);
    expect(listOf(container).requests, hasLength(3));
  });

  test('keeps the list when a refresh fails', () async {
    final container = createContainer();
    await openScreen(container);
    dataSource.listError = const ApiException(message: 'offline');

    await expectLater(
      container
          .read(tripJoinRequestsControllerProvider(tripId).notifier)
          .refresh(),
      throwsA(isA<ApiException>()),
    );

    expect(listOf(container).requests, hasLength(3));
  });

  group('auto approve setting', () {
    Future<ProviderContainer> loadSettings() async {
      final container = createContainer();
      container.listen(
        tripJoinRequestSettingsControllerProvider(tripId),
        (_, _) {},
      );
      await container.read(
        tripJoinRequestSettingsControllerProvider(tripId).future,
      );
      return container;
    }

    bool? valueOf(ProviderContainer container) => container
        .read(tripJoinRequestSettingsControllerProvider(tripId))
        .value
        ?.autoApproveFriends;

    test('saves the new value', () async {
      final container = await loadSettings();

      await container
          .read(tripJoinRequestSettingsControllerProvider(tripId).notifier)
          .setAutoApproveFriends(false);

      expect(valueOf(container), isFalse);
      expect(dataSource.savedSettings.single.autoApproveFriends, isFalse);
    });

    test('restores the previous value when saving fails', () async {
      final container = await loadSettings();
      dataSource.settingsSaveError = const ApiException(message: 'offline');

      await expectLater(
        container
            .read(tripJoinRequestSettingsControllerProvider(tripId).notifier)
            .setAutoApproveFriends(false),
        throwsA(isA<ApiException>()),
      );

      expect(valueOf(container), isTrue);
    });
  });
}
