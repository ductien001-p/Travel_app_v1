import 'package:flutter_test/flutter_test.dart';
import 'package:travel_frontend_v1/features/trips/trip-itineraies/data/models/itinerary_models.dart';
import 'package:travel_frontend_v1/features/trips/trip-itineraies/data/models/itinerary_requests.dart';

void main() {
  test('parses authoritative itinerary management capability', () {
    final itinerary = TripItineraryData.fromEnvelope({
      'data': const [],
      'permissions': {'canManageItinerary': true},
    });

    expect(itinerary.canManageItinerary, isTrue);
    expect(itinerary.destinations, isEmpty);
  });

  test('rejects itinerary responses without authoritative permissions', () {
    expect(
      () => TripItineraryData.fromEnvelope({'data': const []}),
      throwsFormatException,
    );
  });

  test('parses nested itinerary and decimal cost from OpenAPI response', () {
    final destination = DestinationItinerary.fromJson({
      'id': 'destination-1',
      'tripId': 'trip-1',
      'city': 'Da Nang',
      'country': 'Vietnam',
      'lat': 16.0544,
      'lng': 108.2022,
      'order': 1,
      'startDate': '2026-09-25T00:00:00.000Z',
      'endDate': '2026-09-26T00:00:00.000Z',
      'itineraryDays': [
        {
          'id': 'day-1',
          'tripId': 'trip-1',
          'destinationId': 'destination-1',
          'dayNumber': 1,
          'date': '2026-09-25T00:00:00.000Z',
          'summary': {
            'activityCount': 1,
            'estimatedDurationMinutes': 90,
            'estimatedCost': '150000.50',
          },
          'activities': [
            {
              'id': 'activity-1',
              'tripId': 'trip-1',
              'dayId': 'day-1',
              'placeId': 'place-1',
              'title': 'Beach',
              'startTime': null,
              'estimatedCost': '150000.50',
              'estimatedDuration': 90,
              'isCheckin': false,
              'orderIndex': 1000,
              'place': {'id': 'place-1', 'name': 'My Khe'},
              'createdAt': '2026-09-25T01:00:00.000Z',
              'updatedAt': '2026-09-25T01:00:00.000Z',
            },
          ],
        },
      ],
    });

    expect(destination.days.single.activities.single.estimatedCost, 150000.5);
    expect(destination.days.single.activities.single.place?.name, 'My Khe');
    expect(destination.days.single.summary?.activityCount, 1);
    expect(destination.days.single.summary?.estimatedDurationMinutes, 90);
    expect(destination.days.single.summary?.estimatedCost, '150000.50');
  });

  test('check-in parser accepts the backend runtime shape', () {
    final checkin = TripCheckin.fromJson({
      'id': 'checkin-1',
      'memberId': 'member-1',
      'activityId': 'activity-1',
      'latitude': 16.0,
      'longitude': 108.0,
      'visitedAt': '2026-09-25T02:00:00.000Z',
      'createdAt': '2026-09-25T02:00:00.000Z',
    });

    expect(checkin.visitedAt, DateTime.parse('2026-09-25T02:00:00.000Z'));
    expect(checkin.createdAt, DateTime.parse('2026-09-25T02:00:00.000Z'));
  });

  test('serializes a batch create request using the backend contract', () {
    final request = CreateItineraryItemsBatchRequest(
      items: [
        CreateItineraryItemRequest(
          dayId: 'day-1',
          placeId: 'place-1',
          title: 'Lunch',
          startTime: DateTime.parse('2026-09-25T12:00:00.000Z'),
          estimatedDuration: 60,
          estimatedCost: 150000,
          orderIndex: 1000,
        ),
      ],
    );

    expect(request.toJson(), {
      'items': [
        {
          'dayId': 'day-1',
          'placeId': 'place-1',
          'title': 'Lunch',
          'startTime': '2026-09-25T12:00:00.000Z',
          'estimatedDuration': 60,
          'estimatedCost': 150000.0,
          'orderIndex': 1000,
        },
      ],
    });
  });

  test('update request can explicitly clear nullable backend fields', () {
    const request = UpdateActivityRequest(
      clearStartTime: true,
      clearEstimatedDuration: true,
      clearEstimatedCost: true,
    );

    expect(request.toJson(), {
      'startTime': null,
      'estimatedDuration': null,
      'estimatedCost': null,
    });
  });
}
