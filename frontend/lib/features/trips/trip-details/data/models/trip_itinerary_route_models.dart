import 'package:freezed_annotation/freezed_annotation.dart';

part 'trip_itinerary_route_models.freezed.dart';
part 'trip_itinerary_route_models.g.dart';

@JsonEnum(fieldRename: FieldRename.screamingSnake)
enum TripRouteUnavailableReason {
  missingCoordinates,
  providerUnavailable,
  stopLimitExceeded,
  unknown,
}

/// Road route between two consecutive activities of a day.
@freezed
abstract class TripRouteLeg with _$TripRouteLeg {
  const factory TripRouteLeg({
    required String fromActivityId,
    required String toActivityId,
    required bool available,
    int? distanceMeters,
    int? durationSeconds,

    /// Google encoded polyline; null when unavailable or for a repeated place.
    String? polyline,
    @JsonKey(unknownEnumValue: TripRouteUnavailableReason.unknown)
    TripRouteUnavailableReason? unavailableReason,
  }) = _TripRouteLeg;

  factory TripRouteLeg.fromJson(Map<String, dynamic> json) =>
      _$TripRouteLegFromJson(json);
}

/// Response of `GET /trips/{id}/itineraries/days/{dayId}/route`.
///
/// Totals only cover available legs; [available] is true when every leg has
/// route data.
@freezed
abstract class TripDayRoute with _$TripDayRoute {
  const factory TripDayRoute({
    required String dayId,
    required bool available,
    required int totalDistanceMeters,
    required int totalDurationSeconds,
    required List<TripRouteLeg> legs,
  }) = _TripDayRoute;

  factory TripDayRoute.fromJson(Map<String, dynamic> json) =>
      _$TripDayRouteFromJson(json);
}
