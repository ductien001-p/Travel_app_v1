import 'package:flutter_test/flutter_test.dart';
import 'package:travel_frontend_v1/features/home/data/mappers/explore_home_trip_mapper.dart';
import 'package:travel_frontend_v1/features/trips/data/models/trip_creation_models.dart';
import 'package:travel_frontend_v1/features/trips/data/models/trip_destination.dart';
import 'package:travel_frontend_v1/features/trips/data/models/trip_enums.dart';
import 'package:travel_frontend_v1/features/trips/data/models/trip_list_item.dart';

void main() {
  test('tags a trip beach when a stop snapshot is BEACH', () {
    final card = mapTripListItemToCommunityCard(
      _trip(destinationType: 'BEACH'),
    );

    expect(card.filterTags, contains('beach'));
    expect(card.badges, contains('Đang tuyển'));
    expect(card.recruiting, isTrue);
    expect(card.urgent, isFalse);
  });

  test('copies the publisher urgent flag onto the card', () {
    final card = mapTripListItemToCommunityCard(
      _trip(destinationType: 'MOUNTAIN', urgent: true),
    );

    expect(card.urgent, isTrue);
  });

  test('keeps the discover match score on the card', () {
    final card = mapTripListItemToCommunityCard(
      _trip(destinationType: 'BEACH', matchScore: 80),
    );

    expect(card.matchScore, 80);
  });

  test('does not tag beach when no stop is BEACH', () {
    final card = mapTripListItemToCommunityCard(
      _trip(destinationType: 'MOUNTAIN'),
    );

    expect(card.filterTags, isNot(contains('beach')));
  });

  test('catalog destinations stay visible when the trip page has no city', () {
    final destinations = exploreDestinations(
      trips: const [],
      catalog: const [
        DestinationCatalogItem(
          id: 'da-lat',
          name: 'Đà Lạt',
          country: 'Việt Nam',
          lat: 11.94,
          lng: 108.44,
          highlights: [],
        ),
      ],
    );

    expect(destinations, hasLength(1));
    expect(destinations.single.name, 'Đà Lạt');
    expect(destinations.single.id, 'da-lat');
    expect(destinations.single.openTripCount, 0);
  });
}

TripListItem _trip({
  required String? destinationType,
  int? matchScore,
  bool urgent = false,
}) {
  final start = DateTime.utc(2026, 8, 1);
  final end = DateTime.utc(2026, 8, 3);
  return TripListItem(
    id: 'trip-1',
    name: 'Cô Tô',
    startDate: start,
    endDate: end,
    maxMembers: 6,
    tripType: TripType.friends,
    visibility: TripVisibility.public,
    status: TripStatus.upcoming,
    destinations: [
      TripDestination(
        id: 'destination-1',
        tripId: 'trip-1',
        city: 'Cô Tô',
        country: 'Việt Nam',
        latitude: 21.0,
        longitude: 107.0,
        order: 1,
        startDate: start,
        endDate: end,
        destinationType: destinationType,
      ),
    ],
    memberCount: 1,
    memberPreviews: const [],
    recruiting: true,
    checkinCount: 0,
    totalActivities: 0,
    completedActivities: 0,
    progressPercent: 0,
    matchScore: matchScore,
    urgent: urgent,
  );
}
