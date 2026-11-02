import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:travel_frontend_v1/core/maps/google_polyline_decoder.dart';

import '../data/models/trip_itinerary_route_models.dart';
import 'trip_itinerary_view.dart';

/// Google Maps only renders on Android and iOS; overridden in widget tests.
final tripMapsSupportedProvider = Provider<bool>(
  (ref) =>
      !kIsWeb &&
      (defaultTargetPlatform == TargetPlatform.android ||
          defaultTargetPlatform == TargetPlatform.iOS),
);

/// A located activity on the map; [number] is its 1-based visiting order.
class TripItineraryMapStop {
  const TripItineraryMapStop({
    required this.number,
    required this.item,
    required this.position,
  });

  final int number;
  final TripItineraryActivityView item;
  final LatLng position;
}

/// Path between two consecutive stops.
class TripItineraryMapLeg {
  const TripItineraryMapLeg({
    required this.fromActivityId,
    required this.toActivityId,
    required this.points,
    required this.isEstimate,
    this.distanceMeters,
    this.durationSeconds,
  });

  final String fromActivityId;
  final String toActivityId;

  /// Road geometry, or the straight segment when [isEstimate].
  final List<LatLng> points;
  final bool isEstimate;
  final int? distanceMeters;
  final int? durationSeconds;
}

class TripItineraryMapData {
  const TripItineraryMapData({required this.stops, required this.legs});

  final List<TripItineraryMapStop> stops;
  final List<TripItineraryMapLeg> legs;

  bool get isEmpty => stops.isEmpty;

  /// Leg leaving [activityId], if any.
  TripItineraryMapLeg? legFrom(String activityId) {
    for (final leg in legs) {
      if (leg.fromActivityId == activityId) return leg;
    }
    return null;
  }
}

/// Located stops in visiting order and the legs between them.
///
/// [route] null (loading or failed) draws every leg as a straight estimate.
TripItineraryMapData buildTripItineraryMap(
  TripItineraryDayView day,
  TripDayRoute? route,
) {
  final roadLegs = {
    for (final leg in route?.legs ?? const <TripRouteLeg>[])
      (leg.fromActivityId, leg.toActivityId): leg,
  };

  final stops = <TripItineraryMapStop>[];
  for (final (index, item) in day.activities.indexed) {
    final place = item.activity.place;
    final latitude = place?.latitude;
    final longitude = place?.longitude;
    if (latitude == null || longitude == null) continue;
    stops.add(
      TripItineraryMapStop(
        number: index + 1,
        item: item,
        position: LatLng(latitude, longitude),
      ),
    );
  }

  final legs = <TripItineraryMapLeg>[];
  for (var i = 1; i < stops.length; i++) {
    final from = stops[i - 1];
    final to = stops[i];
    final roadLeg = roadLegs[(from.item.id, to.item.id)];
    final roadPoints = _decode(roadLeg);
    final isRoad = roadLeg != null && roadLeg.available;
    legs.add(
      TripItineraryMapLeg(
        fromActivityId: from.item.id,
        toActivityId: to.item.id,
        points: roadPoints ?? [from.position, to.position],
        isEstimate: !isRoad,
        distanceMeters: isRoad ? roadLeg.distanceMeters : null,
        durationSeconds: isRoad ? roadLeg.durationSeconds : null,
      ),
    );
  }
  return TripItineraryMapData(
    stops: List.unmodifiable(stops),
    legs: List.unmodifiable(legs),
  );
}

List<LatLng>? _decode(TripRouteLeg? leg) {
  final polyline = leg?.polyline;
  if (leg == null || !leg.available || polyline == null) return null;
  final points = GooglePolylineDecoder.decode(polyline);
  return points.length < 2 ? null : points;
}

/// The day with [dayId] and its destination, wherever it is in the trip.
({TripItineraryDestinationView destination, TripItineraryDayView day})?
findItineraryDay(TripItineraryView view, String? dayId) {
  if (dayId != null) {
    for (final destination in view.destinations) {
      for (final day in destination.days) {
        if (day.id == dayId) return (destination: destination, day: day);
      }
    }
  }
  final destination = view.selectedDestination;
  final day = view.selectedDay;
  if (destination == null || day == null) return null;
  return (destination: destination, day: day);
}
