import 'package:freezed_annotation/freezed_annotation.dart';

part 'trip_itinerary_checkin_models.freezed.dart';
part 'trip_itinerary_checkin_models.g.dart';

/// One place the current viewer has checked in to
/// (`GET /trips/{id}/itineraries/checkins/me`).
///
/// The backend stores check-ins per place, so every activity sharing
/// [placeId] counts as checked in for the viewer. [activityId] is null once
/// the activity used for the check-in has been deleted.
@freezed
abstract class TripItineraryViewerCheckin with _$TripItineraryViewerCheckin {
  const factory TripItineraryViewerCheckin({
    String? activityId,
    required String placeId,
    required DateTime visitedAt,
  }) = _TripItineraryViewerCheckin;

  factory TripItineraryViewerCheckin.fromJson(Map<String, dynamic> json) =>
      _$TripItineraryViewerCheckinFromJson(json);
}
