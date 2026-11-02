import 'package:flutter_test/flutter_test.dart';
import 'package:travel_frontend_v1/features/trips/trip-details/application/trip_itinerary_map.dart';
import 'package:travel_frontend_v1/features/trips/trip-details/application/trip_itinerary_route.dart';
import 'package:travel_frontend_v1/features/trips/trip-details/application/trip_itinerary_view.dart';
import 'package:travel_frontend_v1/features/trips/trip-details/data/models/trip_itinerary_route_models.dart';
import 'package:travel_frontend_v1/features/trips/trip-details/utils/trip_itinerary_formatters.dart';

import 'trip_itinerary_fixture.dart';

void main() {
  final view = buildTripItineraryView(
    itinerary: datamockItinerary(),
    viewerCheckedInPlaceIds: datamockViewerPlaceIds(),
    canCheckin: true,
    now: itineraryNow,
  );
  final day = view.selectedDay!;
  final roadRoute = FakeItineraryBackend().dayRoute(day.id);

  TripDayRoute withLegs(List<TripRouteLeg> legs) =>
      roadRoute.copyWith(legs: legs);

  group('summarizeDayRoute', () {
    test('uses road distance and time when every leg is routed', () {
      final summary = summarizeDayRoute(day, roadRoute)!;

      expect(summary.isEstimate, isFalse);
      expect(summary.distanceKm, closeTo(21.4, 0.001));
      expect(summary.travelMinutes, 54);
      expect(formatRouteSummary(summary), 'Tổng 21 km · 54 phút');
    });

    test('falls back to straight lines for unavailable legs', () {
      final legs = [
        roadRoute.legs.first,
        roadRoute.legs[1].copyWith(
          available: false,
          distanceMeters: null,
          durationSeconds: null,
          polyline: null,
          unavailableReason: TripRouteUnavailableReason.providerUnavailable,
        ),
        roadRoute.legs.last,
      ];
      final summary = summarizeDayRoute(day, withLegs(legs))!;
      final straight = straightLineKm(
        day.activities[1].activity,
        day.activities[2].activity,
      )!;

      expect(summary.isEstimate, isTrue);
      expect(summary.travelMinutes, isNull);
      expect(summary.distanceKm, closeTo(4.2 + straight + 7.4, 0.001));
      expect(formatRouteSummary(summary), contains('(ước tính)'));
    });

    test('estimates everything while the route is unknown', () {
      final summary = summarizeDayRoute(day, null)!;

      expect(summary.isEstimate, isTrue);
      expect(summary.distanceKm, closeTo(day.approxDistanceKm!, 0.001));
    });

    test('is null for a day with fewer than two activities', () {
      final lastDay = view.selectedDestination!.days.last;
      expect(summarizeDayRoute(lastDay, null), isNull);
    });
  });

  test('route key changes when the order of places changes', () {
    final reversed = TripItineraryDayView(
      day: day.day,
      status: day.status,
      activities: day.activities.reversed.toList(),
      totalCost: day.totalCost,
      totalDurationMinutes: day.totalDurationMinutes,
      approxDistanceKm: day.approxDistanceKm,
    );

    expect(
      tripDayRouteKey('trip-1', day),
      isNot(tripDayRouteKey('trip-1', reversed)),
    );
    expect(tripDayRouteKey('trip-1', day), tripDayRouteKey('trip-1', day));
  });

  group('buildTripItineraryMap', () {
    test('numbers stops in order and decodes road polylines', () {
      final data = buildTripItineraryMap(day, roadRoute);

      expect(data.stops.map((s) => s.number), [1, 2, 3, 4]);
      expect(data.legs, hasLength(3));
      expect(data.legs.every((leg) => !leg.isEstimate), isTrue);
      expect(data.legs.first.points.length, greaterThan(2));
      expect(data.legFrom(day.activities.first.id)?.distanceMeters, 4200);
      expect(data.legFrom(day.activities.last.id), isNull);
    });

    test('draws straight estimates without a route or for bad polylines', () {
      final broken = withLegs([
        roadRoute.legs.first.copyWith(polyline: '\u0000'),
        ...roadRoute.legs.skip(1),
      ]);

      final noRoute = buildTripItineraryMap(day, null);
      expect(noRoute.legs.every((leg) => leg.isEstimate), isTrue);
      expect(noRoute.legs.first.points, hasLength(2));

      final data = buildTripItineraryMap(day, broken);
      expect(data.legs.first.points, [
        data.stops[0].position,
        data.stops[1].position,
      ]);
      expect(data.legs.first.isEstimate, isFalse);
    });
  });

  test('findItineraryDay falls back to the selected day', () {
    final otherDay = view.selectedDestination!.days.first;

    expect(findItineraryDay(view, otherDay.id)?.day.id, otherDay.id);
    expect(findItineraryDay(view, 'missing')?.day.id, day.id);
    expect(findItineraryDay(view, null)?.day.id, day.id);
  });
}
