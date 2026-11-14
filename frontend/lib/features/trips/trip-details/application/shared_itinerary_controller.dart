import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_frontend_v1/core/deep_link/deep_link_service.dart';
import 'package:travel_frontend_v1/core/networks/api_exception.dart';

import '../data/models/trip_share_models.dart';
import '../provider/trip_detail_provider.dart';
import 'trip_itinerary_view.dart';

/// Thrown locally for tokens that cannot be valid, without a server call.
class InvalidShareLinkException implements Exception {
  const InvalidShareLinkException();
}

/// No automatic retry: a dead link stays dead, and the screen has a retry
/// button for transient failures.
final sharedItineraryProvider = FutureProvider.autoDispose
    .family<SharedItinerary, String>((ref, token) {
      if (!isValidShareToken(token)) {
        throw const InvalidShareLinkException();
      }
      return ref.watch(tripDetailRepositoryProvider).getSharedItinerary(token);
    }, retry: (_, _) => null);

/// Unknown, expired and revoked links all come back as 404 by design.
bool isShareLinkGone(Object error) =>
    error is InvalidShareLinkException ||
    (error is ApiException && error.statusCode == 404);

/// Read-only view: no check-in, and the group `isCheckin` flag for progress
/// because the viewer may not be a member.
TripItineraryView buildSharedItineraryView(
  SharedItinerary shared, {
  required DateTime now,
  String? destinationId,
  String? dayId,
}) => buildTripItineraryView(
  itinerary: shared.itinerary,
  viewerCheckedInPlaceIds: null,
  canCheckin: false,
  now: now,
  selectedDestinationId: destinationId,
  selectedDayId: dayId,
);
