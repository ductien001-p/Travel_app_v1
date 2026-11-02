import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:travel_frontend_v1/features/home/application/explore_home_controller.dart';
import 'package:travel_frontend_v1/features/home/data/datamock/explore_home_datamock.dart';
import 'package:travel_frontend_v1/features/home/data/datasources/explore_home_datasource.dart';
import 'package:travel_frontend_v1/features/home/data/models/explore_home_models.dart';
import 'package:travel_frontend_v1/features/home/data/repositories/explore_home_repository.dart';
import 'package:travel_frontend_v1/features/home/provider/explore_home_provider.dart';
import 'package:travel_frontend_v1/features/trips/trip-invitation/data/models/trip_join_request_models.dart';
import 'package:travel_frontend_v1/features/trips/trip-invitation/data/repositories/trip_join_requests_repository.dart';
import 'package:travel_frontend_v1/features/trips/trip-invitation/provider/trip_join_requests_provider.dart';

import '../trips/trip_join_requests/trip_join_requests_fixture.dart';

class _FakeExploreHomeDataSource implements ExploreHomeDataSource {
  final queries = <ExploreHomeQuery>[];
  var failNext = false;

  @override
  Future<ExploreHomeFeed> getCommunityExploreFeed([
    ExploreHomeQuery? query,
  ]) async {
    final resolved = query ?? const ExploreHomeQuery();
    queries.add(resolved);
    if (failNext) {
      failNext = false;
      throw Exception('discover down');
    }
    final base = ExploreHomeFeed.fromJson(exploreHomeDatamock);
    if (resolved.page <= 1) {
      return base.copyWith(page: 1, hasNextPage: true);
    }
    return base.copyWith(
      page: resolved.page,
      hasNextPage: false,
      hotTrips: [
        base.hotTrips.first.copyWith(id: 'trip-page-${resolved.page}'),
      ],
    );
  }
}

void main() {
  late ProviderContainer container;
  late _FakeExploreHomeDataSource dataSource;
  late FakeTripJoinRequestsDataSource joinDataSource;

  setUp(() {
    dataSource = _FakeExploreHomeDataSource();
    joinDataSource = FakeTripJoinRequestsDataSource();
    container = ProviderContainer(
      overrides: [
        exploreHomeRepositoryProvider.overrideWithValue(
          ExploreHomeRepository(dataSource: dataSource),
        ),
        tripJoinRequestsRepositoryProvider.overrideWithValue(
          TripJoinRequestsRepository(dataSource: joinDataSource),
        ),
      ],
    );
  });

  tearDown(() => container.dispose());

  test(
    'loads a seeded feed and reloads every category on the server',
    () async {
      final state = await container.read(exploreHomeControllerProvider.future);
      expect(state.feed.hotTrips, hasLength(2));
      expect(state.filteredHotTrips, hasLength(2));
      final seed = dataSource.queries.single.seed;
      expect(seed, isNotEmpty);
      expect(dataSource.queries.single.category, 'all');

      for (final category in ['weekend', 'beach', 'budget', 'camping']) {
        await container
            .read(exploreHomeControllerProvider.notifier)
            .selectFilter(category);
        expect(dataSource.queries.last.category, category);
        expect(dataSource.queries.last.seed, seed);
      }
    },
  );

  test('backpacker chip reloads with the same visit seed', () async {
    await container.read(exploreHomeControllerProvider.future);
    final seed = dataSource.queries.single.seed;
    await container
        .read(exploreHomeControllerProvider.notifier)
        .selectFilter('backpacker');

    expect(dataSource.queries, hasLength(2));
    expect(dataSource.queries.last.category, 'backpacker');
    expect(dataSource.queries.last.seed, seed);
  });

  test(
    'refresh and revisit rotate the seed without dropping the category',
    () async {
      await container.read(exploreHomeControllerProvider.future);
      await container
          .read(exploreHomeControllerProvider.notifier)
          .selectFilter('beach');
      final visitSeed = dataSource.queries.last.seed;

      await container.read(exploreHomeControllerProvider.notifier).refresh();
      expect(dataSource.queries.last.category, 'beach');
      expect(dataSource.queries.last.seed, isNot(visitSeed));

      final refreshedSeed = dataSource.queries.last.seed;
      await container.read(exploreHomeControllerProvider.notifier).revisit();
      expect(dataSource.queries.last.category, 'beach');
      expect(dataSource.queries.last.seed, isNot(refreshedSeed));
    },
  );

  test('search query reloads via API search param', () async {
    // Keep autoDispose alive so the debounce Timer is not cancelled.
    final sub = container.listen(exploreHomeControllerProvider, (_, _) {});
    addTearDown(sub.close);

    await container.read(exploreHomeControllerProvider.future);
    final seed = dataSource.queries.single.seed;
    container
        .read(exploreHomeControllerProvider.notifier)
        .setSearchQuery('Cô Tô');
    await Future<void>.delayed(const Duration(milliseconds: 400));

    expect(dataSource.queries.last.search, 'Cô Tô');
    expect(dataSource.queries.last.seed, seed);
  });

  test('toggleBookmark adds and removes trip id', () async {
    await container.read(exploreHomeControllerProvider.future);
    final notifier = container.read(exploreHomeControllerProvider.notifier);
    notifier.toggleBookmark('trip-co-to');
    expect(
      container
          .read(exploreHomeControllerProvider)
          .requireValue
          .bookmarkedTripIds,
      contains('trip-co-to'),
    );
    notifier.toggleBookmark('trip-co-to');
    expect(
      container
          .read(exploreHomeControllerProvider)
          .requireValue
          .bookmarkedTripIds,
      isEmpty,
    );
  });

  test('refresh and filter keep the feed when discover fails', () async {
    await container.read(exploreHomeControllerProvider.future);
    final notifier = container.read(exploreHomeControllerProvider.notifier);
    dataSource.failNext = true;
    await notifier.refresh();
    final refreshed = container
        .read(exploreHomeControllerProvider)
        .requireValue;
    expect(refreshed.feed.hotTrips, hasLength(2));
    expect(refreshed.reloadError, 'Đã xảy ra lỗi. Vui lòng thử lại.');
    expect(container.read(exploreHomeControllerProvider).hasError, isFalse);

    dataSource.failNext = true;
    await notifier.selectFilter('beach');
    final filtered = container.read(exploreHomeControllerProvider).requireValue;
    expect(filtered.selectedFilterId, 'all');
    expect(filtered.feed.hotTrips, hasLength(2));
    expect(filtered.reloadError, isNotNull);
  });

  test('loadNextPage appends trips and keeps the bookmark', () async {
    await container.read(exploreHomeControllerProvider.future);
    final notifier = container.read(exploreHomeControllerProvider.notifier);
    notifier.toggleBookmark('trip-co-to');
    await notifier.loadNextPage();

    final state = container.read(exploreHomeControllerProvider).requireValue;
    expect(state.feed.page, 2);
    expect(state.feed.hasNextPage, isFalse);
    expect(state.loadingMore, isFalse);
    expect(
      state.feed.hotTrips.map((trip) => trip.id),
      containsAll(['trip-co-to', 'trip-page-2']),
    );
    expect(state.bookmarkedTripIds, contains('trip-co-to'));
    expect(dataSource.queries.last.page, 2);
    expect(dataSource.queries.last.includeCatalog, isFalse);
  });

  test('places segment does not search discover until community', () async {
    final sub = container.listen(exploreHomeControllerProvider, (_, _) {});
    addTearDown(sub.close);

    await container.read(exploreHomeControllerProvider.future);
    final notifier = container.read(exploreHomeControllerProvider.notifier);
    notifier.selectSegment(ExploreHomeSegment.places);
    notifier.setSearchQuery('Hội An');
    await Future<void>.delayed(const Duration(milliseconds: 400));
    expect(dataSource.queries, hasLength(1));

    notifier.selectSegment(ExploreHomeSegment.community);
    await Future<void>.delayed(const Duration(milliseconds: 50));
    expect(dataSource.queries.last.search, 'Hội An');
  });

  test('joinTrip keeps the list when the follow-up load fails', () async {
    await container.read(exploreHomeControllerProvider.future);
    dataSource.failNext = true;
    final request = await container
        .read(exploreHomeControllerProvider.notifier)
        .joinTrip('trip-co-to');

    final state = container.read(exploreHomeControllerProvider).requireValue;
    expect(request.tripId, 'trip-co-to');
    expect(state.feed.hotTrips, hasLength(2));
    expect(state.joiningTripId, isNull);
    expect(state.reloadError, isNotNull);
  });

  test('joinTrip calls requestToJoinByTripId', () async {
    await container.read(exploreHomeControllerProvider.future);
    final request = await container
        .read(exploreHomeControllerProvider.notifier)
        .joinTrip('trip-co-to');

    expect(request.status, TripJoinRequestStatus.pending);
    expect(request.tripId, 'trip-co-to');
  });
}
