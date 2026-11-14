import 'package:flutter_test/flutter_test.dart';
import 'package:travel_frontend_v1/features/trips/trip-details/application/trip_itinerary_view.dart';

import 'trip_itinerary_fixture.dart';

void main() {
  TripItineraryView build({
    Set<String>? viewerPlaceIds,
    bool useViewerCheckins = true,
    DateTime? now,
    String? destinationId,
    String? dayId,
  }) => buildTripItineraryView(
    itinerary: datamockItinerary(),
    viewerCheckedInPlaceIds: useViewerCheckins
        ? viewerPlaceIds ?? datamockViewerPlaceIds()
        : null,
    canCheckin: true,
    now: now ?? itineraryNow,
    selectedDestinationId: destinationId,
    selectedDayId: dayId,
  );

  test('selects today and marks the first unchecked activity as next', () {
    final view = build();
    final day = view.selectedDay!;

    expect(view.selectedDestination!.destination.city, 'Đà Nẵng');
    expect(day.id, 'day-2');
    expect(day.status, TripItineraryDayStatus.today);
    expect(day.activities.map((a) => a.status), [
      TripItineraryActivityStatus.checkedIn,
      TripItineraryActivityStatus.checkedIn,
      TripItineraryActivityStatus.next,
      TripItineraryActivityStatus.upcoming,
    ]);
    expect(day.checkedInCount, 2);
    expect(day.progressPercent, 50);
  });

  test('sums cost, duration and approximate distance of a day', () {
    final day = build().selectedDay!;

    expect(day.totalCost, 430000);
    expect(day.totalDurationMinutes, 450);
    expect(day.approxDistanceKm, isNotNull);
    expect(day.approxDistanceKm, greaterThan(10));
    expect(day.activities.first.endTime, DateTime.utc(2026, 7, 16, 10, 30));
  });

  test('labels past, today and planned days', () {
    final days = build().selectedDestination!.days;

    expect(days.map((d) => d.status), [
      TripItineraryDayStatus.done,
      TripItineraryDayStatus.today,
      TripItineraryDayStatus.planned,
      TripItineraryDayStatus.planned,
    ]);
    expect(days.last.approxDistanceKm, isNull);
  });

  test('falls back to the group check-in flag when viewer data is unknown', () {
    final view = build(useViewerCheckins: false);

    expect(
      view.selectedDestination!.days.first.status,
      TripItineraryDayStatus.done,
    );
    expect(
      view.selectedDay!.activities.first.status,
      TripItineraryActivityStatus.next,
    );
  });

  test('honours an explicit destination and resets the day to its first', () {
    final view = build(destinationId: 'destination-hoian');

    expect(view.selectedDestination!.destination.city, 'Hội An');
    expect(view.selectedDay!.id, 'day-5');
    expect(
      view.selectedDay!.activities.single.status,
      TripItineraryActivityStatus.upcoming,
    );
  });

  test('ignores a stale selection that no longer exists', () {
    final view = build(destinationId: 'gone', dayId: 'gone');

    expect(view.selectedDay!.id, 'day-2');
  });

  test('before the trip, opens the first day and has no next activity', () {
    final view = build(now: DateTime.utc(2026, 6, 1));

    expect(view.selectedDay!.id, 'day-1');
    expect(
      view.destinations
          .expand((d) => d.days)
          .expand((d) => d.activities)
          .where((a) => a.status == TripItineraryActivityStatus.next),
      isEmpty,
    );
  });

  test('after the trip, falls back to the first destination', () {
    final view = build(now: DateTime.utc(2026, 9, 1));

    expect(view.selectedDestination!.id, 'destination-danang');
    expect(view.selectedDay!.id, 'day-1');
  });
}
