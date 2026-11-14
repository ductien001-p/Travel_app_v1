import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../trip-itineraies/data/models/itinerary_models.dart';
import 'trip_detail_models.dart';

part 'trip_share_models.freezed.dart';
part 'trip_share_models.g.dart';

/// Response of `POST /trips/{id}/share-links`.
@freezed
abstract class TripShareLink with _$TripShareLink {
  const factory TripShareLink({
    required String url,
    required DateTime expiresAt,
  }) = _TripShareLink;

  factory TripShareLink.fromJson(Map<String, dynamic> json) =>
      _$TripShareLinkFromJson(json);
}

/// Trip header returned with a shared itinerary.
@freezed
abstract class SharedTripSummary with _$SharedTripSummary {
  const factory SharedTripSummary({
    required String id,
    required String name,
    required DateTime startDate,
    required DateTime endDate,
    required TripDetailStatus status,
    String? coverImageUrl,
  }) = _SharedTripSummary;

  factory SharedTripSummary.fromJson(Map<String, dynamic> json) =>
      _$SharedTripSummaryFromJson(json);
}

/// Response of `GET /trip-shares/{token}`: a read-only itinerary.
///
/// The destinations reuse the hand-written itinerary model, so this wrapper
/// is parsed by [SharedItinerary.parse] instead of generated JSON code.
@freezed
abstract class SharedItinerary with _$SharedItinerary {
  const SharedItinerary._();

  const factory SharedItinerary({
    required SharedTripSummary trip,
    required TripItineraryData itinerary,
    required bool viewerIsMember,
  }) = _SharedItinerary;

  factory SharedItinerary.parse(Map<String, dynamic> json) {
    final trip = json['trip'];
    final viewer = json['viewer'];
    if (trip is! Map || viewer is! Map || viewer['isMember'] is! bool) {
      throw const FormatException('Invalid shared itinerary response.');
    }
    return SharedItinerary(
      trip: SharedTripSummary.fromJson(Map<String, dynamic>.from(trip)),
      itinerary: TripItineraryData.fromEnvelope({
        'data': json['destinations'],
        'permissions': json['permissions'],
      }),
      viewerIsMember: viewer['isMember'] as bool,
    );
  }
}
