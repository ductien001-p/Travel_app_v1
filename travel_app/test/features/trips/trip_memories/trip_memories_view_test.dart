import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:travel_frontend_v1/features/trips/trip-details/data/models/trip_detail_models.dart';
import 'package:travel_frontend_v1/features/trips/trip-memories/application/trip_memories_controller.dart';
import 'package:travel_frontend_v1/features/trips/trip-memories/application/trip_memories_filter.dart';
import 'package:travel_frontend_v1/features/trips/trip-memories/application/trip_memories_view.dart';
import 'package:travel_frontend_v1/features/trips/trip-memories/data/models/trip_memory_models.dart';
import 'package:travel_frontend_v1/features/trips/trip-memories/utils/trip_memories_formatters.dart';

import 'trip_memories_fixture.dart';

void main() {
  TripMemoriesHeader header({
    String role = 'OWNER',
    String status = 'ONGOING',
  }) => TripMemoriesHeader.fromTrip(
    TripDetailOverview.fromJson(
      memoriesTripDetailJson(role: role, status: status),
    ),
  );

  TripMemoriesState state(
    Map<String, dynamic> page, {
    TripMemoriesFilter filter = TripMemoriesFilter.all,
  }) => TripMemoriesState.fromPage(
    TripMemoriesPage.fromJson(page),
    filter: filter,
  );

  TripMemoriesView build(
    TripMemoriesState memories, {
    TripMemoriesHeader? tripHeader,
    TripMemoriesFilter selected = TripMemoriesFilter.all,
    TripMemoriesWallClock wallClock = utcWallClock,
    Object? pendingError,
  }) => buildTripMemoriesView(
    memories: memories,
    selected: selected,
    toWallClock: wallClock,
    header: tripHeader,
    pendingError: pendingError,
  );

  test('groups the datamock by trip day, newest day first, with the city', () {
    final view = build(state(memoriesDatamockPage()), tripHeader: header());

    expect(view.groups.map(memoryGroupTitle), [
      'Ngày 4: Phố Cổ Hội An',
      'Ngày 1: Đà Nẵng',
    ]);
    expect(view.groups.map((g) => g.count), [5, 5]);
    expect(view.groups.last.tiles.first.entry.id, 'memory-linh-ung');
    expect(view.totalCount, 10);
  });

  test('offers one chip per trip day with the backend counts', () {
    final view = build(state(memoriesDatamockPage()), tripHeader: header());

    expect(view.dayOptions.map(memoryDayChipLabel), [
      'Ngày 1 - Đà Nẵng (5)',
      'Ngày 2 - Đà Nẵng (0)',
      'Ngày 3 - Đà Nẵng (0)',
      'Ngày 4 - Phố Cổ Hội An (5)',
      'Ngày 5 - Phố Cổ Hội An (0)',
      'Ngày 6 - Phố Cổ Hội An (0)',
    ]);
  });

  test('counts loaded photos per day when the backend sends no counts', () {
    final complete = build(
      state(
        memoriesPageJson([
          memoryJson(id: 'a', createdAt: '2025-07-16T03:00:00.000Z'),
          memoryJson(id: 'b', createdAt: '2025-07-16T04:00:00.000Z'),
        ]),
      ),
      tripHeader: header(),
    );
    expect(complete.dayOptions[1].count, 2);
    expect(complete.dayOptions[0].count, 0);

    final partial = build(
      state(memoriesPageJson([memoryJson(id: 'a')], nextCursor: 'a')),
      tripHeader: header(),
    );
    expect(partial.dayOptions.first.count, isNull);
  });

  test('names photographers from the trip members', () {
    final tiles = build(
      state(memoriesDatamockPage()),
      tripHeader: header(),
    ).tiles;

    String nameOf(String id) =>
        tiles.firstWhere((tile) => tile.entry.id == id).uploaderName;
    expect(nameOf('memory-ban-co'), 'Alex Nguyễn');
    expect(nameOf('memory-lanterns'), 'Minh Trang');
    expect(nameOf('memory-mi-quang'), 'Tài khoản đã xóa');
  });

  test('falls back to the username before the trip detail is loaded', () {
    final view = build(state(memoriesDatamockPage()));

    expect(view.tiles.first.uploaderName, isNotEmpty);
    expect(
      view.tiles.firstWhere((t) => t.entry.id == 'memory-ban-co').uploaderName,
      'alex',
    );
    expect(view.dayOptions, isEmpty);
    expect(view.tiles.every((tile) => !tile.canDelete), isTrue);
    expect(view.totalCount, 10);
  });

  test('owners may delete every photo, members only their own', () {
    final asOwner = build(state(memoriesDatamockPage()), tripHeader: header());
    expect(asOwner.tiles.every((tile) => tile.canDelete), isTrue);
    // Caption edit stays uploader-only even for owners.
    expect(
      asOwner.tiles.where((tile) => tile.canEdit).map((tile) => tile.entry.id),
      unorderedEquals(const [
        'memory-ban-co',
        'memory-salt-coffee',
        'memory-yellow-wall',
      ]),
    );

    final asMember = build(
      state(memoriesDatamockPage()),
      tripHeader: header(role: 'MEMBER'),
    );
    final deletable = asMember.tiles
        .where((tile) => tile.canDelete)
        .map((tile) => tile.entry.id);
    expect(
      deletable,
      unorderedEquals(const [
        'memory-ban-co',
        'memory-salt-coffee',
        'memory-yellow-wall',
      ]),
    );
    expect(
      asMember.tiles.where((tile) => tile.canEdit).map((tile) => tile.entry.id),
      unorderedEquals(deletable),
    );
  });

  test('only members of an active trip may post photos', () {
    expect(header().canPost, isTrue);
    expect(header(status: 'COMPLETED').canPost, isTrue);
    expect(header(status: 'DRAFT').canPost, isFalse);
    expect(header(status: 'CANCELLED').canPost, isFalse);
  });

  test('lists contributors with photos, most active first', () {
    final view = build(state(memoriesDatamockPage()), tripHeader: header());

    expect(view.contributors.map((c) => c.memoryCount), [3, 3, 2, 1]);
    expect(view.contributors.last.name, 'Lan Phương');
  });

  test('groups by the wall clock of the user', () {
    final memories = state(
      memoriesPageJson([
        memoryJson(id: 'late', createdAt: '2025-07-15T20:00:00.000Z'),
      ]),
    );

    final utc = build(memories, tripHeader: header());
    final vietnam = build(
      memories,
      tripHeader: header(),
      wallClock: (instant) => instant.toUtc().add(const Duration(hours: 7)),
    );

    expect(utc.groups.single.day, 1);
    expect(vietnam.groups.single.day, 2);
    expect(formatMemoryClock(vietnam.tiles.single.time), '03:00');
  });

  test('reads trip days in UTC by default, like the backend', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final toWallClock = container.read(tripMemoriesWallClockProvider);
    final wallClock = toWallClock(DateTime.parse('2025-07-16T02:00:00+07:00'));

    expect(wallClock.isUtc, isTrue);
    expect((wallClock.day, wallClock.hour), (15, 19));
  });

  test('titles photos posted outside the trip with their date', () {
    final view = build(
      state(
        memoriesPageJson([
          memoryJson(id: 'after', createdAt: '2025-07-25T03:00:00.000Z'),
        ]),
      ),
      tripHeader: header(),
    );

    expect(view.groups.single.day, isNull);
    expect(memoryGroupTitle(view.groups.single), '25/07/2025');
  });

  test('reports a switching or failed filter without stale groups', () {
    final memories = state(memoriesDatamockPage());
    const byDay = TripMemoriesFilter(day: 1);

    final switching = build(memories, selected: byDay, tripHeader: header());
    expect(switching.status, TripMemoriesBodyStatus.switchingFilter);
    expect(switching.groups, isEmpty);

    final failed = build(
      memories,
      selected: byDay,
      tripHeader: header(),
      pendingError: StateError('x'),
    );
    expect(failed.status, TripMemoriesBodyStatus.filterError);
    expect(failed.filterError, isA<StateError>());
  });

  test('removing a memory updates the total and its day count', () {
    final memories = state(memoriesDatamockPage());

    final next = memories.removing('memory-ban-co', day: 1);

    expect(next.entries, hasLength(9));
    expect(next.totalCount, 9);
    expect(next.dayCounts, {1: 4, 4: 5});
    expect(identical(next.removing('missing'), next), isTrue);
  });
}
