import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:travel_frontend_v1/core/networks/api_exception.dart';
import 'package:travel_frontend_v1/features/trips/trip-details/application/trip_detail_action_controller.dart';
import 'package:travel_frontend_v1/features/trips/trip-details/application/trip_detail_overview_controller.dart';
import 'package:travel_frontend_v1/features/trips/trip-details/data/models/trip_detail_models.dart';
import 'package:travel_frontend_v1/features/trips/trip-details/provider/trip_detail_provider.dart';

import 'trip_detail_fixture.dart';

const _tripId = 'trip-1';

void main() {
  late ProviderContainer container;

  final overviewProvider = tripDetailOverviewControllerProvider(_tripId);
  final actionProvider = tripDetailActionControllerProvider(_tripId);

  setUp(() {
    container = ProviderContainer(
      overrides: [
        tripDetailRemoteDataSourceProvider.overrideWithValue(
          FakeTripDetailRemoteDataSource(),
        ),
      ],
    );
    container
      ..listen(overviewProvider, (_, _) {})
      ..listen(actionProvider, (_, _) {});
  });

  tearDown(() => container.dispose());

  Future<TripDetailOverview> loadOverview() =>
      container.read(overviewProvider.future);

  test('loads the overview for the requested trip', () async {
    final trip = await loadOverview();

    expect(trip.id, _tripId);
    expect(trip.members, isNotEmpty);
  });

  test('kickMember removes the member and refreshes the overview', () async {
    final before = await loadOverview();
    final target = before.members.firstWhere(before.canRemove);

    await container.read(actionProvider.notifier).kickMember(target.userId);
    final after = await loadOverview();

    expect(after.members.map((m) => m.userId), isNot(contains(target.userId)));
    expect(after.members, hasLength(before.members.length - 1));
    expect(container.read(actionProvider).isBusy, isFalse);
  });

  test('marks the action as pending while it runs', () async {
    await loadOverview();
    final notifier = container.read(actionProvider.notifier);

    final pending = notifier.claimReward();
    expect(
      container.read(actionProvider).isPending(TripDetailAction.claimReward),
      isTrue,
    );
    await expectLater(notifier.leaveTrip(), throwsA(isA<StateError>()));

    await pending;
    expect(container.read(actionProvider).isBusy, isFalse);
  });

  test('claimReward returns the points and cannot be claimed twice', () async {
    await loadOverview();
    final notifier = container.read(actionProvider.notifier);

    final claim = await notifier.claimReward();
    final after = await loadOverview();

    expect(claim.pointsAwarded, 500);
    expect(after.completionReward?.claimed, isTrue);
    await expectLater(notifier.claimReward(), throwsA(isA<ApiException>()));
    expect(container.read(actionProvider).isBusy, isFalse);
  });

  test('leaveTrip removes the viewer from the trip', () async {
    final before = await loadOverview();

    await container.read(actionProvider.notifier).leaveTrip();
    final after = await container
        .read(tripDetailRepositoryProvider)
        .getTripDetail(_tripId);

    expect(
      after.members.map((m) => m.userId),
      isNot(contains(before.viewer.userId)),
    );
  });

  test(
    'rotateInviteCode replaces the invite code and refreshes overview',
    () async {
      final before = await loadOverview();
      expect(before.inviteCode, isNotNull);

      final code = await container
          .read(actionProvider.notifier)
          .rotateInviteCode();
      final after = await loadOverview();

      expect(code, 'NEWCODE1');
      expect(after.inviteCode, 'NEWCODE1');
      expect(after.inviteCode, isNot(before.inviteCode));
    },
  );
}
