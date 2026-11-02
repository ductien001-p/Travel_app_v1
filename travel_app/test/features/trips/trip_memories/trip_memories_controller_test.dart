import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:travel_frontend_v1/features/media/providers/media_providers.dart';
import 'package:travel_frontend_v1/features/trips/trip-details/provider/trip_detail_provider.dart';
import 'package:travel_frontend_v1/features/trips/trip-memories/application/trip_memories_action_controller.dart';
import 'package:travel_frontend_v1/features/trips/trip-memories/application/trip_memories_controller.dart';
import 'package:travel_frontend_v1/features/trips/trip-memories/application/trip_memories_filter.dart';
import 'package:travel_frontend_v1/features/trips/trip-memories/provider/trip_memories_provider.dart';

import '../trip_details/trip_detail_fixture.dart';
import 'trip_memories_fixture.dart';

void main() {
  const tripId = 'trip-1';

  late FakeTripMemoriesDataSource dataSource;
  late FakeMediaUploadRepository media;
  late ProviderContainer container;

  ProviderContainer createContainer() {
    final container = ProviderContainer(
      overrides: [
        tripMemoriesRemoteDataSourceProvider.overrideWithValue(dataSource),
        mediaUploadRepositoryProvider.overrideWithValue(media),
        tripDetailRemoteDataSourceProvider.overrideWithValue(
          FakeTripDetailRemoteDataSource(memoriesTripDetailJson()),
        ),
      ],
    );
    addTearDown(container.dispose);
    container.listen(tripMemoriesControllerProvider(tripId), (_, _) {});
    container.listen(tripMemoriesActionControllerProvider(tripId), (_, _) {});
    return container;
  }

  Future<TripMemoriesState> loaded() =>
      container.read(tripMemoriesControllerProvider(tripId).future);

  TripMemoriesController controller() =>
      container.read(tripMemoriesControllerProvider(tripId).notifier);

  TripMemoriesActionController actions() =>
      container.read(tripMemoriesActionControllerProvider(tripId).notifier);

  setUp(() {
    dataSource = FakeTripMemoriesDataSource({
      firstPage: memoriesPageJson(
        [memoryJson(id: 'm-3'), memoryJson(id: 'm-2')],
        nextCursor: 'm-2',
        totalCount: 3,
        dayCounts: const {1: 3},
      ),
      (day: null, uploaderId: null, cursor: 'm-2'): memoriesPageJson([
        memoryJson(id: 'm-2'),
        memoryJson(id: 'm-1'),
      ]),
      (day: 2, uploaderId: null, cursor: null): memoriesPageJson([
        memoryJson(id: 'd-1'),
      ]),
      (day: 2, uploaderId: 'user-bao', cursor: null): memoriesPageJson([]),
    });
    media = FakeMediaUploadRepository();
    container = createContainer();
  });

  test('loads the first page without filters', () async {
    final state = await loaded();

    expect(state.entries.map((e) => e.id), ['m-3', 'm-2']);
    expect(state.hasMore, isTrue);
    expect(dataSource.requests, [firstPage]);
  });

  test('loadMore appends the next page and skips duplicates', () async {
    await loaded();

    await controller().loadMore();

    final state = container.read(tripMemoriesControllerProvider(tripId)).value!;
    expect(state.entries.map((e) => e.id), ['m-3', 'm-2', 'm-1']);
    expect(state.hasMore, isFalse);
    expect(state.totalCount, 3);
  });

  test('a failed loadMore keeps the loaded photos', () async {
    await loaded();
    dataSource.pages.remove((day: null, uploaderId: null, cursor: 'm-2'));

    await controller().loadMore();

    final state = container.read(tripMemoriesControllerProvider(tripId)).value!;
    expect(state.entries, hasLength(2));
    expect(state.loadMoreError, isNotNull);
  });

  test('filters are sent to the backend and combine', () async {
    await loaded();
    final filter = container.read(tripMemoriesFilterProvider(tripId).notifier);

    filter.selectDay(2);
    var state = await loaded();
    expect(state.filter, const TripMemoriesFilter(day: 2));
    expect(state.entries.single.id, 'd-1');

    filter.selectUploader('user-bao');
    state = await loaded();
    expect(state.entries, isEmpty);
    expect(dataSource.requests.last, (
      day: 2,
      uploaderId: 'user-bao',
      cursor: null,
    ));

    filter.reset();
    state = await loaded();
    expect(state.filter.isAll, isTrue);
  });

  test('posting photos uploads, adds them and reloads the album', () async {
    await loaded();
    final progress = <double?>[];
    container.listen(
      tripMemoriesActionControllerProvider(tripId),
      (_, next) => progress.add(next.uploadProgress),
    );

    final added = await actions().postPhotos(fakePhotos(2));

    expect(added, 2);
    expect(dataSource.created.single.map((m) => m.mediaId), [
      'upload-0',
      'upload-1',
    ]);
    expect(dataSource.requests, [firstPage, firstPage]);
    expect(progress, [0, 0.5, 1, null]);
  });

  test('only one album operation runs at a time', () async {
    final gate = Completer<void>();
    media = FakeMediaUploadRepository(gate: gate);
    container = createContainer();
    await loaded();

    final first = actions().postPhotos(fakePhotos(1));
    await Future<void>.delayed(Duration.zero);

    await expectLater(actions().delete('m-3'), throwsA(isA<StateError>()));
    expect(dataSource.deleted, isEmpty);
    gate.complete();
    await first;
    expect(
      container.read(tripMemoriesActionControllerProvider(tripId)).isBusy,
      isFalse,
    );
  });

  test('deleting removes the photo and its counts locally', () async {
    await loaded();

    await actions().delete('m-3', day: 1);

    final state = container.read(tripMemoriesControllerProvider(tripId)).value!;
    expect(dataSource.deleted, ['m-3']);
    expect(state.entries.map((e) => e.id), ['m-2']);
    expect(state.totalCount, 2);
    expect(state.dayCounts, {1: 2});
    expect(dataSource.requests, [firstPage]);
  });

  test('a failed delete keeps the photo and reports the error', () async {
    await loaded();
    dataSource.deleteError = StateError('denied');

    await expectLater(actions().delete('m-3'), throwsA(isA<StateError>()));

    final state = container.read(tripMemoriesControllerProvider(tripId)).value!;
    expect(state.entries, hasLength(2));
    expect(
      container.read(tripMemoriesActionControllerProvider(tripId)).isBusy,
      isFalse,
    );
  });
}
