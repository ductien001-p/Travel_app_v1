import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:travel_frontend_v1/features/home/destination_trips/application/destination_trips_controller.dart';
import 'package:travel_frontend_v1/features/home/destination_trips/data/datamock/destination_trips_datamock.dart';
import 'package:travel_frontend_v1/features/home/destination_trips/data/datasources/destination_trips_datasource.dart';
import 'package:travel_frontend_v1/features/home/destination_trips/data/mappers/destination_trips_editorial.dart';
import 'package:travel_frontend_v1/features/home/destination_trips/data/models/destination_trips_models.dart';
import 'package:travel_frontend_v1/features/home/destination_trips/data/repositories/destination_trips_repository.dart';
import 'package:travel_frontend_v1/features/home/destination_trips/provider/destination_trips_provider.dart';
import 'package:travel_frontend_v1/features/trips/trip-invitation/data/models/trip_join_request_models.dart';
import 'package:travel_frontend_v1/features/trips/trip-invitation/data/repositories/trip_join_requests_repository.dart';
import 'package:travel_frontend_v1/features/trips/trip-invitation/provider/trip_join_requests_provider.dart';

import '../trips/trip_join_requests/trip_join_requests_fixture.dart';

class _FakeDestinationTripsDataSource implements DestinationTripsDataSource {
  final queries = <DestinationTripsQuery>[];
  var failNext = false;

  @override
  Future<DestinationTripsPage> load(DestinationTripsQuery query) async {
    queries.add(query);
    if (failNext) {
      failNext = false;
      throw Exception('destination down');
    }
    final page = DestinationTripsPage.fromJson(
      jsonDecode(jsonEncode(destinationTripsDatamock['daLat']))
          as Map<String, dynamic>,
    );
    return page.copyWith(spotsTotal: 10);
  }
}

void main() {
  const args = DestinationTripsArgs(cityName: 'Đà Lạt');

  late ProviderContainer container;
  late _FakeDestinationTripsDataSource dataSource;

  setUp(() {
    dataSource = _FakeDestinationTripsDataSource();
    container = ProviderContainer(
      overrides: [
        destinationTripsRepositoryProvider.overrideWithValue(
          DestinationTripsRepository(dataSource: dataSource),
        ),
        tripJoinRequestsRepositoryProvider.overrideWithValue(
          TripJoinRequestsRepository(
            dataSource: FakeTripJoinRequestsDataSource(),
          ),
        ),
      ],
    );
  });

  tearDown(() => container.dispose());

  test('editorial fills Da Lat copy and keeps a real cover', () {
    const remote = DestinationTripsPage(
      profile: DestinationProfile(
        catalogId: 'catalog-da-lat',
        name: 'Đà Lạt',
        regionLabel: 'Việt Nam',
        coverImageUrl: 'https://cdn.example/da-lat.jpg',
        tagline: '',
        summary: '',
      ),
      trips: [],
      spots: [],
      openTripCount: 4,
    );

    final merged = applyDestinationEditorial(remote);

    expect(merged.profile.regionLabel, 'Lâm Đồng');
    expect(merged.profile.weatherLabel, '18°C Mát mẻ • Mùa săn mây');
    expect(merged.profile.altitudeLabel, '1.500m');
    expect(merged.profile.coverImageUrl, 'https://cdn.example/da-lat.jpg');
    expect(merged.spots, hasLength(3));
    expect(merged.openTripCount, 4);
    expect(foldCityKey('Da Lat'), 'da lat');
  });

  test('editorial leaves unknown cities unchanged', () {
    const remote = DestinationTripsPage(
      profile: DestinationProfile(
        catalogId: 'catalog-hoi-an',
        name: 'Hội An',
        regionLabel: 'Việt Nam',
        coverImageUrl: '',
        tagline: 'Phố cổ',
        summary: '',
      ),
      trips: [],
      spots: [],
      openTripCount: 1,
    );

    final merged = applyDestinationEditorial(remote);

    expect(merged.profile.tagline, 'Phố cổ');
    expect(merged.profile.weatherLabel, isNull);
    expect(merged.spots, isEmpty);
  });

  test('loads open trips and keeps the visit seed across filters', () async {
    final state = await container.read(
      destinationTripsControllerProvider(args).future,
    );
    expect(state.openTripCount, 12);
    expect(state.visibleTrips, hasLength(3));
    final seed = dataSource.queries.single.seed;
    expect(seed, isNotEmpty);
    expect(dataSource.queries.single.category, 'all');
    expect(dataSource.queries.single.cityName, 'Đà Lạt');

    await container
        .read(destinationTripsControllerProvider(args).notifier)
        .selectFilter('weekend');
    expect(dataSource.queries.last.category, 'weekend');
    expect(dataSource.queries.last.seed, seed);

    await container
        .read(destinationTripsControllerProvider(args).notifier)
        .selectFilter('urgent');
    expect(dataSource.queries.last.category, 'all');
    expect(
      container
          .read(destinationTripsControllerProvider(args))
          .requireValue
          .visibleTrips,
      hasLength(2),
    );

    await container
        .read(destinationTripsControllerProvider(args).notifier)
        .selectFilter('friends');
    expect(
      container
          .read(destinationTripsControllerProvider(args))
          .requireValue
          .visibleTrips
          .single
          .id,
      'trip-mua-suong',
    );
  });

  test('reset and search reload through the repository', () async {
    final sub = container.listen(
      destinationTripsControllerProvider(args),
      (_, _) {},
    );
    addTearDown(sub.close);

    await container.read(destinationTripsControllerProvider(args).future);
    final notifier = container.read(
      destinationTripsControllerProvider(args).notifier,
    );
    await notifier.selectFilter('budget');
    notifier.setSearchQuery('cafe');
    await Future<void>.delayed(const Duration(milliseconds: 400));

    expect(dataSource.queries.last.category, 'budget');
    expect(dataSource.queries.last.search, 'cafe');

    await notifier.resetFilters();
    expect(dataSource.queries.last.category, 'all');
    expect(dataSource.queries.last.search, isNull);
    expect(
      container
          .read(destinationTripsControllerProvider(args))
          .requireValue
          .selectedFilterId,
      'all',
    );
  });

  test('bookmark, save, and expand spots stay on the same visit', () async {
    await container.read(destinationTripsControllerProvider(args).future);
    final notifier = container.read(
      destinationTripsControllerProvider(args).notifier,
    );
    notifier.toggleBookmark('trip-da-phu');
    notifier.toggleSaved();
    final seeded = container
        .read(destinationTripsControllerProvider(args))
        .requireValue;
    expect(seeded.bookmarkedTripIds, contains('trip-da-phu'));
    expect(seeded.saved, isTrue);

    await notifier.expandSpots();
    expect(dataSource.queries.last.placesLimit, 20);
    expect(dataSource.queries.last.seed, dataSource.queries.first.seed);
    final after = container
        .read(destinationTripsControllerProvider(args))
        .requireValue;
    expect(after.bookmarkedTripIds, contains('trip-da-phu'));
    expect(after.saved, isTrue);
  });

  test('repository returns the API page without editorial copy', () async {
    final page = await DestinationTripsRepository(
      dataSource: _PlainDestinationSource(),
    ).load(const DestinationTripsQuery(cityName: 'Đà Lạt'));

    expect(page.profile.name, 'Đà Lạt');
    expect(page.profile.weatherLabel, isNull);
    expect(page.profile.altitudeLabel, isNull);
    expect(page.spots, isEmpty);
  });

  test('selectFilter keeps trips when the reload fails', () async {
    await container.read(destinationTripsControllerProvider(args).future);
    dataSource.failNext = true;
    await container
        .read(destinationTripsControllerProvider(args).notifier)
        .selectFilter('weekend');

    final state = container
        .read(destinationTripsControllerProvider(args))
        .requireValue;
    expect(state.selectedFilterId, 'all');
    expect(state.visibleTrips, hasLength(3));
    expect(state.reloadError, 'Đã xảy ra lỗi. Vui lòng thử lại.');
  });

  test('joinTrip calls requestToJoinByTripId', () async {
    await container.read(destinationTripsControllerProvider(args).future);
    final request = await container
        .read(destinationTripsControllerProvider(args).notifier)
        .joinTrip('trip-da-phu');

    expect(request.status, TripJoinRequestStatus.pending);
    expect(request.tripId, 'trip-da-phu');
    expect(
      container
          .read(destinationTripsControllerProvider(args))
          .requireValue
          .joiningTripId,
      isNull,
    );
  });
}

class _PlainDestinationSource implements DestinationTripsDataSource {
  @override
  Future<DestinationTripsPage> load(DestinationTripsQuery query) async {
    return const DestinationTripsPage(
      profile: DestinationProfile(
        catalogId: 'catalog-da-lat',
        name: 'Đà Lạt',
        regionLabel: 'Việt Nam',
        coverImageUrl: 'https://cdn.example/da-lat.jpg',
        tagline: '',
        summary: '',
      ),
      trips: [],
      spots: [],
      openTripCount: 1,
    );
  }
}
