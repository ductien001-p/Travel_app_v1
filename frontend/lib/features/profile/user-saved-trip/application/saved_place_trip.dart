import 'package:travel_frontend_v1/features/trips/trip-itineraies/data/models/itinerary_models.dart';
import 'package:travel_frontend_v1/features/trips/trip-itineraies/data/models/itinerary_requests.dart';

class SavedTripOption {
  const SavedTripOption({required this.id, required this.name});

  final String id;
  final String name;
}

class SavedTripDayChoice {
  const SavedTripDayChoice({required this.dayId, required this.label});

  final String dayId;
  final String label;
}

class SavedTripDayLookup {
  const SavedTripDayLookup.forbidden() : canManage = false, days = const [];

  const SavedTripDayLookup.allowed(this.days) : canManage = true;

  final bool canManage;
  final List<SavedTripDayChoice> days;
}

SavedTripDayLookup savedTripDays(TripItineraryData data) {
  if (!data.canManageItinerary) {
    return const SavedTripDayLookup.forbidden();
  }
  return SavedTripDayLookup.allowed([
    for (final destination in data.destinations)
      for (final day in destination.days)
        SavedTripDayChoice(
          dayId: day.id,
          label: '${destination.city} • Ngày ${day.dayNumber}',
        ),
  ]);
}

CreateItineraryItemsBatchRequest savedPlaceItineraryBatch({
  required String dayId,
  required String placeId,
  required String title,
}) {
  return CreateItineraryItemsBatchRequest(
    items: [
      CreateItineraryItemRequest(
        dayId: dayId,
        placeId: placeId,
        title: title,
        orderIndex: 0,
      ),
    ],
  );
}
