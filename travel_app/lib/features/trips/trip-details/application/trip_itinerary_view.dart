import 'dart:math' as math;

import '../../trip-itineraies/data/models/itinerary_models.dart';

enum TripItineraryActivityStatus { checkedIn, next, upcoming }

enum TripItineraryDayStatus { done, today, planned }

class TripItineraryActivityView {
  const TripItineraryActivityView({
    required this.activity,
    required this.status,
  });

  final ItineraryActivity activity;
  final TripItineraryActivityStatus status;

  String get id => activity.id;

  bool get isCheckedIn => status == TripItineraryActivityStatus.checkedIn;

  DateTime? get endTime {
    final start = activity.startTime;
    final duration = activity.estimatedDuration;
    if (start == null || duration == null || duration <= 0) return null;
    return start.add(Duration(minutes: duration));
  }
}

class TripItineraryDayView {
  const TripItineraryDayView({
    required this.day,
    required this.status,
    required this.activities,
    required this.totalCost,
    required this.totalDurationMinutes,
    this.approxDistanceKm,
  });

  final ItineraryDay day;
  final TripItineraryDayStatus status;
  final List<TripItineraryActivityView> activities;
  final double totalCost;
  final int totalDurationMinutes;

  /// Straight-line distance between consecutive stops, null below two stops.
  /// Fallback for when the road route is not available.
  final double? approxDistanceKm;

  String get id => day.id;

  int get checkedInCount => activities.where((a) => a.isCheckedIn).length;

  int get progressPercent => activities.isEmpty
      ? 0
      : ((checkedInCount / activities.length) * 100).round();
}

class TripItineraryDestinationView {
  const TripItineraryDestinationView({
    required this.destination,
    required this.days,
  });

  final DestinationItinerary destination;
  final List<TripItineraryDayView> days;

  String get id => destination.id;
}

class TripItineraryView {
  const TripItineraryView({
    required this.destinations,
    required this.selectedDestination,
    required this.selectedDay,
    required this.canManageItinerary,
    required this.canCheckin,
  });

  final List<TripItineraryDestinationView> destinations;
  final TripItineraryDestinationView? selectedDestination;
  final TripItineraryDayView? selectedDay;
  final bool canManageItinerary;
  final bool canCheckin;

  bool get isEmpty => destinations.isEmpty;
}

/// Builds the screen model from raw itinerary data.
///
/// [viewerCheckedInPlaceIds] null means per-viewer check-ins are unknown, so
/// the group-level `isCheckin` flag is used instead.
TripItineraryView buildTripItineraryView({
  required TripItineraryData itinerary,
  required Set<String>? viewerCheckedInPlaceIds,
  required bool canCheckin,
  required DateTime now,
  String? selectedDestinationId,
  String? selectedDayId,
}) {
  final today = _utcDate(now);
  bool isCheckedIn(ItineraryActivity activity) =>
      viewerCheckedInPlaceIds?.contains(activity.placeId) ?? activity.isCheckin;

  final destinations =
      ([...itinerary.destinations]..sort((a, b) => a.order.compareTo(b.order)))
          .map(
            (destination) => TripItineraryDestinationView(
              destination: destination,
              days:
                  ([...destination.days]
                        ..sort((a, b) => a.dayNumber.compareTo(b.dayNumber)))
                      .map((day) => _buildDay(day, today, isCheckedIn))
                      .toList(growable: false),
            ),
          )
          .toList(growable: false);

  final selectedDestination = _resolveDestination(
    destinations,
    selectedDestinationId,
    today,
  );
  final selectedDay = selectedDestination == null
      ? null
      : _resolveDay(selectedDestination.days, selectedDayId, today);

  return TripItineraryView(
    destinations: destinations,
    selectedDestination: selectedDestination,
    selectedDay: selectedDay,
    canManageItinerary: itinerary.canManageItinerary,
    canCheckin: canCheckin,
  );
}

TripItineraryDayView _buildDay(
  ItineraryDay day,
  DateTime today,
  bool Function(ItineraryActivity) isCheckedIn,
) {
  final sorted = [...day.activities]
    ..sort((a, b) => a.orderIndex.compareTo(b.orderIndex));
  final isToday = _utcDate(day.date) == today;

  var nextAssigned = false;
  final activities = <TripItineraryActivityView>[];
  var totalCost = 0.0;
  var totalDuration = 0;
  for (final activity in sorted) {
    totalCost += activity.estimatedCost ?? 0;
    totalDuration += activity.estimatedDuration ?? 0;

    final TripItineraryActivityStatus status;
    if (isCheckedIn(activity)) {
      status = TripItineraryActivityStatus.checkedIn;
    } else if (isToday && !nextAssigned) {
      status = TripItineraryActivityStatus.next;
      nextAssigned = true;
    } else {
      status = TripItineraryActivityStatus.upcoming;
    }
    activities.add(
      TripItineraryActivityView(activity: activity, status: status),
    );
  }

  final allDone =
      activities.isNotEmpty && activities.every((item) => item.isCheckedIn);
  return TripItineraryDayView(
    day: day,
    status: isToday
        ? TripItineraryDayStatus.today
        : allDone
        ? TripItineraryDayStatus.done
        : TripItineraryDayStatus.planned,
    activities: List.unmodifiable(activities),
    totalCost: totalCost,
    totalDurationMinutes: totalDuration,
    approxDistanceKm: _approxDistanceKm(sorted),
  );
}

/// Explicit selection first, then the destination that contains today, then
/// the next upcoming one, otherwise the first.
TripItineraryDestinationView? _resolveDestination(
  List<TripItineraryDestinationView> destinations,
  String? selectedId,
  DateTime today,
) {
  if (destinations.isEmpty) return null;
  for (final destination in destinations) {
    if (destination.id == selectedId) return destination;
  }
  for (final destination in destinations) {
    if (destination.days.any((d) => d.status == TripItineraryDayStatus.today)) {
      return destination;
    }
  }
  for (final destination in destinations) {
    if (!_utcDate(destination.destination.endDate).isBefore(today)) {
      return destination;
    }
  }
  return destinations.first;
}

TripItineraryDayView? _resolveDay(
  List<TripItineraryDayView> days,
  String? selectedId,
  DateTime today,
) {
  if (days.isEmpty) return null;
  for (final day in days) {
    if (day.id == selectedId) return day;
  }
  for (final day in days) {
    if (!_utcDate(day.day.date).isBefore(today)) return day;
  }
  return days.first;
}

double? _approxDistanceKm(List<ItineraryActivity> activities) {
  final points = [for (final activity in activities) ?_coordinateOf(activity)];
  if (points.length < 2) return null;
  var total = 0.0;
  for (var i = 1; i < points.length; i++) {
    total += _haversineKm(points[i - 1], points[i]);
  }
  return total;
}

/// Great-circle distance between two activities' places, if both are located.
double? straightLineKm(ItineraryActivity from, ItineraryActivity to) {
  final a = _coordinateOf(from);
  final b = _coordinateOf(to);
  if (a == null || b == null) return null;
  return _haversineKm(a, b);
}

(double, double)? _coordinateOf(ItineraryActivity activity) {
  final latitude = activity.place?.latitude;
  final longitude = activity.place?.longitude;
  if (latitude == null || longitude == null) return null;
  return (latitude, longitude);
}

double _haversineKm((double, double) from, (double, double) to) {
  const earthRadiusKm = 6371.0;
  double rad(double degrees) => degrees * math.pi / 180;
  final dLat = rad(to.$1 - from.$1);
  final dLng = rad(to.$2 - from.$2);
  final a =
      math.pow(math.sin(dLat / 2), 2) +
      math.cos(rad(from.$1)) *
          math.cos(rad(to.$1)) *
          math.pow(math.sin(dLng / 2), 2);
  return 2 * earthRadiusKm * math.asin(math.sqrt(a));
}

// Trip dates are a UTC wall clock across the whole app.
DateTime _utcDate(DateTime value) {
  final utc = value.toUtc();
  return DateTime.utc(utc.year, utc.month, utc.day);
}
