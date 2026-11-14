import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:travel_frontend_v1/core/networks/api_exception.dart';
import 'package:travel_frontend_v1/features/trips/trip-timeline/application/trip_timeline_events_controller.dart';
import 'package:travel_frontend_v1/features/trips/trip-timeline/application/trip_timeline_filter.dart';
import 'package:travel_frontend_v1/features/trips/trip-timeline/data/models/trip_timeline_models.dart';
import 'package:travel_frontend_v1/features/trips/trip-timeline/provider/trip_timeline_provider.dart';

import 'trip_timeline_fixture.dart';

void main() {
  final provider = tripTimelineEventsControllerProvider('trip-1');
  final filterProvider = tripTimelineFilterProvider('trip-1');
  const serverDown = ApiException(message: 'down', statusCode: 503);
  const counts = {
    'all': 5,
    'checkin': 2,
    'expense': 1,
    'memory': 1,
    'member': 1,
  };

  ProviderContainer containerWith(FakeTripTimelineDataSource dataSource) {
    final container = ProviderContainer(
      overrides: [
        tripTimelineRemoteDataSourceProvider.overrideWithValue(dataSource),
      ],
    );
    addTearDown(container.dispose);
    container.listen(provider, (_, _) {});
    return container;
  }

  test('loads the first page with the trip counts', () async {
    final dataSource = FakeTripTimelineDataSource({
      null: timelinePageJson(
        [timelineEventJson(id: 'e-1')],
        nextCursor: 'e-1',
        counts: counts,
      ),
    });
    final container = containerWith(dataSource);

    final state = await container.read(provider.future);

    expect(state.entries.map((entry) => entry.id), ['e-1']);
    expect(state.hasMore, isTrue);
    expect(state.counts.all, 5);
    expect(state.filter, TripTimelineFilter.all);
    expect(dataSource.requests, [(category: null, cursor: null)]);
  });

  test('counts the loaded page when the backend sends no counts', () async {
    final dataSource = FakeTripTimelineDataSource({
      null: timelinePageJson([
        timelineEventJson(id: 'e-1', type: 'ACTIVITY_CHECKIN'),
        timelineEventJson(id: 'e-2', type: 'EXPENSE_SETTLED'),
      ]),
    });
    final container = containerWith(dataSource);

    final state = await container.read(provider.future);

    expect(
      state.counts,
      const TripTimelineCounts(all: 2, checkin: 1, expense: 1),
    );
  });

  test('selecting a filter loads that category from the backend', () async {
    final dataSource = FakeTripTimelineDataSource(
      {
        null: timelinePageJson([timelineEventJson(id: 'e-1')], counts: counts),
      },
      categoryPages: {
        'checkin': {
          null: timelinePageJson(
            [timelineEventJson(id: 'c-1', type: 'ACTIVITY_CHECKIN')],
            nextCursor: 'c-1',
            counts: counts,
          ),
          'c-1': timelinePageJson([
            timelineEventJson(id: 'c-2', type: 'ACTIVITY_CHECKIN'),
          ]),
        },
      },
    );
    final container = containerWith(dataSource);
    await container.read(provider.future);

    container.read(filterProvider.notifier).select(TripTimelineFilter.checkin);
    final state = await container.read(provider.future);
    await container.read(provider.notifier).loadMore();

    expect(state.filter, TripTimelineFilter.checkin);
    expect(
      container.read(provider).requireValue.entries.map((entry) => entry.id),
      ['c-1', 'c-2'],
    );
    expect(container.read(provider).requireValue.counts.all, 5);
    expect(dataSource.requests, [
      (category: null, cursor: null),
      (category: 'checkin', cursor: null),
      (category: 'checkin', cursor: 'c-1'),
    ]);
  });

  test('loadMore appends the next page and skips duplicates', () async {
    final dataSource = FakeTripTimelineDataSource({
      null: timelinePageJson([timelineEventJson(id: 'e-1')], nextCursor: 'e-1'),
      'e-1': timelinePageJson([
        timelineEventJson(id: 'e-1'),
        timelineEventJson(id: 'e-2'),
      ]),
    });
    final container = containerWith(dataSource);
    await container.read(provider.future);

    await container.read(provider.notifier).loadMore();

    final state = container.read(provider).requireValue;
    expect(state.entries.map((entry) => entry.id), ['e-1', 'e-2']);
    expect(state.hasMore, isFalse);
    expect(dataSource.requestedCursors, [null, 'e-1']);
  });

  test('a failed loadMore keeps the loaded events', () async {
    final dataSource = FakeTripTimelineDataSource({
      null: timelinePageJson([timelineEventJson(id: 'e-1')], nextCursor: 'e-1'),
      'e-1': serverDown,
    });
    final container = containerWith(dataSource);
    await container.read(provider.future);

    await container.read(provider.notifier).loadMore();

    final state = container.read(provider).requireValue;
    expect(state.entries.map((entry) => entry.id), ['e-1']);
    expect(state.loadMoreError, serverDown);
    expect(state.isLoadingMore, isFalse);
    expect(state.hasMore, isTrue);
  });

  test('loadMore does nothing on the last page', () async {
    final dataSource = FakeTripTimelineDataSource({
      null: timelinePageJson([timelineEventJson(id: 'e-1')]),
    });
    final container = containerWith(dataSource);
    await container.read(provider.future);

    await container.read(provider.notifier).loadMore();

    expect(dataSource.requestedCursors, [null]);
  });

  test('a failed refresh keeps the current list and rethrows', () async {
    final dataSource = FakeTripTimelineDataSource({
      null: timelinePageJson([timelineEventJson(id: 'e-1')]),
    });
    final container = containerWith(dataSource);
    await container.read(provider.future);
    dataSource.pages[null] = serverDown;

    await expectLater(
      container.read(provider.notifier).refresh(),
      throwsA(serverDown),
    );

    final state = container.read(provider).requireValue;
    expect(state.entries.map((entry) => entry.id), ['e-1']);
  });

  test('refresh replaces the list with the newest first page', () async {
    final dataSource = FakeTripTimelineDataSource({
      null: timelinePageJson([timelineEventJson(id: 'e-1')]),
    });
    final container = containerWith(dataSource);
    await container.read(provider.future);
    dataSource.pages[null] = timelinePageJson([
      timelineEventJson(id: 'e-new'),
      timelineEventJson(id: 'e-1'),
    ]);

    await container.read(provider.notifier).refresh();

    expect(
      container.read(provider).requireValue.entries.map((entry) => entry.id),
      ['e-new', 'e-1'],
    );
  });

  group('receive', () {
    Future<ProviderContainer> loaded({
      TripTimelineFilter filter = TripTimelineFilter.all,
    }) async {
      final dataSource = FakeTripTimelineDataSource(
        {
          null: timelinePageJson([
            timelineEventJson(id: 'e-1'),
          ], counts: counts),
        },
        categoryPages: {
          'checkin': {
            null: timelinePageJson([
              timelineEventJson(id: 'c-1', type: 'ACTIVITY_CHECKIN'),
            ], counts: counts),
          },
        },
      );
      final container = containerWith(dataSource);
      container.read(filterProvider.notifier).select(filter);
      await container.read(provider.future);
      return container;
    }

    test('puts a live event on top and bumps its counts', () async {
      final container = await loaded();

      container
          .read(provider.notifier)
          .receive(timelineEntry(id: 'live', type: 'ACTIVITY_CHECKIN'));

      final state = container.read(provider).requireValue;
      expect(state.entries.map((entry) => entry.id), ['live', 'e-1']);
      expect(state.counts.all, 6);
      expect(state.counts.checkin, 3);
      expect(state.counts.expense, 1);
    });

    test('ignores an event that is already listed', () async {
      final container = await loaded();
      final notifier = container.read(provider.notifier);

      notifier.receive(timelineEntry(id: 'live'));
      notifier.receive(timelineEntry(id: 'live'));

      final state = container.read(provider).requireValue;
      expect(state.entries.map((entry) => entry.id), ['live', 'e-1']);
      expect(state.counts.all, 6);
    });

    test('only counts an event outside the selected filter', () async {
      final container = await loaded(filter: TripTimelineFilter.checkin);

      container
          .read(provider.notifier)
          .receive(timelineEntry(id: 'x-1', type: 'EXPENSE_CREATED'));

      final state = container.read(provider).requireValue;
      expect(state.entries.map((entry) => entry.id), ['c-1']);
      expect(state.counts.expense, 2);
    });

    test('ignores an event of another trip', () async {
      final container = await loaded();

      container
          .read(provider.notifier)
          .receive(timelineEntry(id: 'other', tripId: 'trip-2'));

      expect(container.read(provider).requireValue.entries, hasLength(1));
    });
  });
}
