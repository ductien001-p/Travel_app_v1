import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:travel_frontend_v1/features/trips/application/trip_list_controller.dart';
import 'package:travel_frontend_v1/features/trips/data/models/trip_list_item.dart';
import 'package:travel_frontend_v1/features/trips/data/models/trip_pagination.dart';
import 'package:travel_frontend_v1/features/trips/data/models/trip_query.dart';
import 'package:travel_frontend_v1/features/trips/data/repositories/trip_repository.dart';
import 'package:travel_frontend_v1/features/trips/provider/trips_provider.dart';

void main() {
  test('a failed next page keeps the list and can be retried', () async {
    final repository = _Trips();
    final container = ProviderContainer(
      overrides: [tripRepositoryProvider.overrideWithValue(repository)],
    );
    addTearDown(container.dispose);
    container.listen(tripListControllerProvider, (_, _) {});

    final first = await container.read(tripListControllerProvider.future);
    expect(first.items.single.id, 'trip-1');
    expect(first.hasMore, isTrue);

    repository.failNext = true;
    await container.read(tripListControllerProvider.notifier).loadNextPage();
    final failed = container.read(tripListControllerProvider).requireValue;
    expect(failed.isLoadingMore, isFalse);
    expect(failed.loadMoreError, isA<StateError>());
    expect(failed.items.single.id, 'trip-1');
    expect(failed.hasMore, isTrue);

    repository.failNext = false;
    await container.read(tripListControllerProvider.notifier).loadNextPage();
    final loaded = container.read(tripListControllerProvider).requireValue;
    expect(loaded.loadMoreError, isNull);
    expect(loaded.isLoadingMore, isFalse);
    expect(loaded.items.map((item) => item.id), ['trip-1', 'trip-2']);
  });
}

class _Trips implements TripRepository {
  var failNext = false;

  @override
  Future<TripListPage> getTrips(TripQuery query) async {
    if (query.page > 1 && failNext) throw StateError('down');
    return TripListPage(
      items: [
        TripListItem.fromJson({
          'id': 'trip-${query.page}',
          'name': 'Đà Nẵng',
          'startDate': '2026-09-25T00:00:00.000Z',
          'endDate': '2026-09-28T00:00:00.000Z',
          'maxMembers': 5,
          'tripType': 'FRIENDS',
          'visibility': 'PRIVATE',
          'status': 'ONGOING',
          'destinations': <Map<String, Object?>>[],
          'memberCount': 1,
          'memberPreviews': <Map<String, Object?>>[],
          'checkinCount': 0,
          'totalActivities': 0,
          'completedActivities': 0,
          'progressPercent': 0,
        }),
      ],
      meta: PageMeta(
        page: query.page,
        limit: query.limit,
        total: 2,
        totalPages: 2,
        hasNextPage: query.page < 2,
        hasPreviousPage: query.page > 1,
      ),
      summary: const TripSummary(
        total: 2,
        upcoming: 0,
        ongoing: 2,
        completed: 0,
        cancelled: 0,
        notCompleted: 0,
        totalCheckins: 0,
      ),
    );
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
