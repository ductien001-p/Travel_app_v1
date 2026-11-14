import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/trip_itinerary_route_models.dart';
import '../provider/trip_detail_provider.dart';
import 'trip_itinerary_view.dart';

/// Keyed by the ordered places of the day so any add, delete, reorder or
/// place change fetches a fresh route without manual invalidation.
typedef TripDayRouteKey = ({String tripId, String dayId, String stops});

TripDayRouteKey tripDayRouteKey(String tripId, TripItineraryDayView day) => (
  tripId: tripId,
  dayId: day.id,
  stops: day.activities.map((item) => item.activity.placeId).join(','),
);

/// No automatic retry: each attempt hits the paid routing provider, and the
/// UI already falls back to estimates with a manual retry.
final tripItineraryDayRouteProvider = FutureProvider.autoDispose
    .family<TripDayRoute, TripDayRouteKey>(
      (ref, key) => ref
          .watch(tripDetailRepositoryProvider)
          .getDayRoute(key.tripId, key.dayId),
      retry: (_, _) => null,
    );

/// True only while the first answer for the day is still pending.
bool isDayRoutePending(AsyncValue<TripDayRoute>? route) =>
    route != null && !route.hasValue && !route.hasError;

/// Travel between the day's stops, shown on the route and progress cards.
class TripItineraryRouteSummary {
  const TripItineraryRouteSummary({
    required this.distanceKm,
    required this.isEstimate,
    this.travelMinutes,
  });

  final double distanceKm;

  /// True when at least one leg falls back to straight-line distance.
  final bool isEstimate;

  /// Driving time; only known when every leg has road data.
  final int? travelMinutes;
}

/// Road data per leg, straight-line distance for legs without it.
///
/// [route] null (loading or failed) means every leg is estimated.
TripItineraryRouteSummary? summarizeDayRoute(
  TripItineraryDayView day,
  TripDayRoute? route,
) {
  final activities = day.activities;
  if (activities.length < 2) return null;

  final legs = {
    for (final leg in route?.legs ?? const <TripRouteLeg>[])
      (leg.fromActivityId, leg.toActivityId): leg,
  };
  var meters = 0.0;
  var seconds = 0;
  var estimated = false;
  var measured = false;
  for (var i = 1; i < activities.length; i++) {
    final from = activities[i - 1].activity;
    final to = activities[i].activity;
    final leg = legs[(from.id, to.id)];
    if (leg != null && leg.available && leg.distanceMeters != null) {
      meters += leg.distanceMeters!;
      seconds += leg.durationSeconds ?? 0;
      measured = true;
      continue;
    }
    estimated = true;
    final straight = straightLineKm(from, to);
    if (straight != null) {
      meters += straight * 1000;
      measured = true;
    }
  }
  if (!measured) return null;
  return TripItineraryRouteSummary(
    distanceKm: meters / 1000,
    isEstimate: estimated,
    travelMinutes: estimated ? null : (seconds / 60).round(),
  );
}
