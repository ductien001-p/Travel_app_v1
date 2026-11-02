import 'package:flutter_test/flutter_test.dart';
import 'package:travel_frontend_v1/features/profile/user-saved-trip/application/saved_place_trip.dart';
import 'package:travel_frontend_v1/features/trips/trip-itineraies/data/models/itinerary_models.dart';

void main() {
  test('batch request sends the place onto one itinerary day', () {
    final request = savedPlaceItineraryBatch(
      dayId: 'day-1',
      placeId: 'place-1',
      title: 'Phố Cổ Hội An',
    );
    expect(request.toJson(), {
      'items': [
        {
          'dayId': 'day-1',
          'placeId': 'place-1',
          'title': 'Phố Cổ Hội An',
          'orderIndex': 0,
        },
      ],
    });
  });

  test('day lookup follows canManageItinerary', () {
    final denied = savedTripDays(
      TripItineraryData(destinations: const [], canManageItinerary: false),
    );
    expect(denied.canManage, isFalse);
    expect(denied.days, isEmpty);

    final allowed = savedTripDays(
      TripItineraryData(
        canManageItinerary: true,
        destinations: [
          DestinationItinerary(
            id: 'dest',
            tripId: 'trip-1',
            city: 'Hội An',
            country: 'Việt Nam',
            latitude: 15,
            longitude: 108,
            order: 0,
            startDate: DateTime.utc(2026, 11, 1),
            endDate: DateTime.utc(2026, 11, 2),
            days: [
              ItineraryDay(
                id: 'day-1',
                tripId: 'trip-1',
                destinationId: 'dest',
                dayNumber: 1,
                date: DateTime.utc(2026, 11, 1),
                activities: const [],
              ),
            ],
          ),
        ],
      ),
    );
    expect(allowed.canManage, isTrue);
    expect(allowed.days.single.dayId, 'day-1');
    expect(allowed.days.single.label, 'Hội An • Ngày 1');
  });
}
