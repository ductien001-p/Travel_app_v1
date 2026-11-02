import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:travel_frontend_v1/core/location/device_location_service.dart';
import 'package:travel_frontend_v1/core/networks/api_exception.dart';
import 'package:travel_frontend_v1/features/trips/application/device_location_controller.dart';
import 'package:travel_frontend_v1/features/trips/trip-details/application/trip_detail_overview_controller.dart';
import 'package:travel_frontend_v1/features/trips/trip-details/application/trip_itinerary_action_controller.dart';
import 'package:travel_frontend_v1/features/trips/trip-details/application/trip_itinerary_controller.dart';
import 'package:travel_frontend_v1/features/trips/trip-details/application/trip_itinerary_view.dart';
import 'package:travel_frontend_v1/features/trips/trip-details/provider/trip_detail_provider.dart';
import 'package:travel_frontend_v1/features/trips/trip-details/utils/trip_itinerary_formatters.dart';
import 'package:travel_frontend_v1/features/trips/trip-itineraies/application/trip_itinerary_controller.dart';
import 'package:travel_frontend_v1/features/trips/trip-itineraies/provider/trip_itinerary_provider.dart';

import 'trip_detail_fixture.dart';
import 'trip_itinerary_fixture.dart';

const _tripId = 'trip-1';

void main() {
  late FakeItineraryBackend backend;
  late ProviderContainer container;

  final viewProvider = tripItineraryViewProvider(_tripId);
  final actionProvider = tripItineraryActionControllerProvider(_tripId);

  ProviderContainer createContainer({
    DeviceLocationFailure? locationFailure,
    Map<String, dynamic>? tripJson,
  }) {
    final container = ProviderContainer(
      overrides: [
        tripItineraryRemoteDataSourceProvider.overrideWithValue(
          FakeTripItineraryRemoteDataSource(backend),
        ),
        tripDetailRemoteDataSourceProvider.overrideWithValue(
          FakeItineraryTripDetailDataSource(backend, tripJson),
        ),
        deviceLocationServiceProvider.overrideWithValue(
          FakeDeviceLocationService(failure: locationFailure),
        ),
        tripItineraryClockProvider.overrideWithValue(() => itineraryNow),
      ],
    );
    container
      ..listen(viewProvider, (_, _) {})
      ..listen(actionProvider, (_, _) {});
    addTearDown(container.dispose);
    return container;
  }

  Future<TripItineraryView> loadView() async {
    await container.read(tripItineraryControllerProvider(_tripId).future);
    await container.read(tripItineraryViewerCheckinsProvider(_tripId).future);
    await container.read(tripDetailOverviewControllerProvider(_tripId).future);
    return container.read(viewProvider).requireValue;
  }

  setUp(() {
    backend = FakeItineraryBackend();
    container = createContainer();
  });

  test('combines itinerary, viewer check-ins and trip permissions', () async {
    final view = await loadView();

    expect(view.canCheckin, isTrue);
    expect(view.canManageItinerary, isTrue);
    expect(view.selectedDay!.checkedInCount, 2);
  });

  test('a visitor cannot check in', () async {
    container = createContainer(tripJson: visitorTripDetailJson());

    expect((await loadView()).canCheckin, isFalse);
  });

  test('selection switches destination and day', () async {
    await loadView();
    final selection = container.read(
      tripItinerarySelectionProvider(_tripId).notifier,
    );

    await selection.selectDay(
      destinationId: 'destination-danang',
      dayId: 'day-3',
    );
    expect((await loadView()).selectedDay!.id, 'day-3');

    await selection.selectDestination('destination-hoian');
    expect((await loadView()).selectedDay!.id, 'day-5');
  });

  test('checkin sends the device position and refreshes progress', () async {
    await loadView();

    await container.read(actionProvider.notifier).checkin('activity-linh-ung');
    final day = (await loadView()).selectedDay!;

    final (activityId, request) = backend.checkinRequests.single;
    expect(activityId, 'activity-linh-ung');
    expect(request.latitude, FakeDeviceLocationService.coordinate.latitude);
    expect(day.checkedInCount, 3);
    expect(day.activities.last.status, TripItineraryActivityStatus.next);
    expect(container.read(actionProvider).isBusy, isFalse);
  });

  test('checkin without location permission never calls the API', () async {
    container = createContainer(locationFailure: DeviceLocationFailure.denied);
    await loadView();

    await expectLater(
      container.read(actionProvider.notifier).checkin('activity-linh-ung'),
      throwsA(isA<DeviceLocationException>()),
    );
    expect(backend.checkinRequests, isEmpty);
    expect(container.read(actionProvider).isBusy, isFalse);
  });

  test('rejects a second action while one is running', () async {
    await loadView();
    final notifier = container.read(actionProvider.notifier);

    final pending = notifier.checkin('activity-linh-ung');
    expect(
      container
          .read(actionProvider)
          .isPending(TripItineraryAction.checkin, 'activity-linh-ung'),
      isTrue,
    );
    await expectLater(
      notifier.deleteActivity('activity-dragon-bridge'),
      throwsA(isA<StateError>()),
    );
    await pending;
  });

  test('deleteActivity removes the activity from the day', () async {
    await loadView();

    await container
        .read(actionProvider.notifier)
        .deleteActivity('activity-dragon-bridge');

    final ids = (await loadView()).selectedDay!.activities.map((a) => a.id);
    expect(ids, isNot(contains('activity-dragon-bridge')));
  });

  test('maps action failures to readable messages', () {
    expect(
      tripItineraryActionErrorMessage(
        TripItineraryAction.checkin,
        const ApiException(message: 'You are 900m away', statusCode: 400),
      ),
      contains('quá xa'),
    );
    expect(
      tripItineraryActionErrorMessage(
        TripItineraryAction.uncheckin,
        const ApiException(message: 'Completed', statusCode: 409),
      ),
      contains('hoàn thành chuyến đi'),
    );
    expect(
      tripItineraryActionErrorMessage(
        TripItineraryAction.checkin,
        const DeviceLocationException(DeviceLocationFailure.serviceDisabled),
      ),
      contains('bật định vị'),
    );
  });
}
