import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../trip-details/application/trip_detail_overview_controller.dart';
import '../../trip-details/data/models/trip_detail_models.dart';
import '../data/models/trip_memory_models.dart';
import 'trip_memories_controller.dart';
import 'trip_memories_filter.dart';

/// Member who can appear as a photographer, from `GET /trips/{id}`.
class TripMemoryContributor {
  const TripMemoryContributor({
    required this.userId,
    required this.name,
    required this.memoryCount,
    this.avatarUrl,
  });

  final String userId;
  final String name;
  final String? avatarUrl;
  final int memoryCount;
}

/// Trip facts the album needs, taken from `GET /trips/{id}`.
class TripMemoriesHeader {
  const TripMemoriesHeader({
    required this.tripName,
    required this.viewerId,
    required this.isMember,
    required this.canModerate,
    required this.canPost,
    required this.startDate,
    required this.endDate,
    required this.destinations,
    required this.members,
    this.totalCount,
  });

  factory TripMemoriesHeader.fromTrip(TripDetailOverview trip) =>
      TripMemoriesHeader(
        tripName: trip.name,
        viewerId: trip.viewer.userId,
        isMember: trip.isMember,
        canModerate: trip.canManageMembers,
        canPost: trip.isMember && _postableStatuses.contains(trip.status),
        startDate: trip.startDate,
        endDate: trip.endDate,
        destinations: trip.destinations,
        members: [
          for (final member in trip.members)
            TripMemoryContributor(
              userId: member.userId,
              name: member.displayName,
              avatarUrl: member.avatarUrl,
              memoryCount: member.memoryCount,
            ),
        ],
        totalCount: trip.memories?.totalCount,
      );

  /// Mirrors the backend: drafts are private planning and cancelled trips
  /// never happened.
  static const _postableStatuses = {
    TripDetailStatus.upcoming,
    TripDetailStatus.ongoing,
    TripDetailStatus.completed,
    TripDetailStatus.notCompleted,
  };

  final String tripName;
  final String viewerId;
  final bool isMember;

  /// Owners and admins may delete any memory of the trip.
  final bool canModerate;
  final bool canPost;
  final DateTime startDate;
  final DateTime endDate;
  final List<TripDetailDestination> destinations;
  final List<TripMemoryContributor> members;

  /// Memories of the whole trip; null for visitors.
  final int? totalCount;

  int get dayCount =>
      _dateOf(endDate).difference(_dateOf(startDate)).inDays + 1;

  /// 1-based trip day of a calendar [date], or null outside the trip.
  int? dayOf(DateTime date) {
    final offset = _dateOf(date).difference(_dateOf(startDate)).inDays;
    return offset < 0 || offset >= dayCount ? null : offset + 1;
  }

  DateTime dateOfDay(int day) =>
      _dateOf(startDate).add(Duration(days: day - 1));

  /// City of the destination on [date]; on a travel day, the one arrived at.
  String? placeOn(DateTime date) {
    final day = _dateOf(date);
    TripDetailDestination? match;
    for (final destination in destinations) {
      final covers =
          !day.isBefore(_dateOf(destination.startDate)) &&
          !day.isAfter(_dateOf(destination.endDate));
      if (covers && (match == null || destination.order > match.order)) {
        match = destination;
      }
    }
    return match?.city;
  }

  TripMemoryContributor? memberOf(String? userId) {
    if (userId == null) return null;
    for (final member in members) {
      if (member.userId == userId) return member;
    }
    return null;
  }
}

class TripMemoryTile {
  const TripMemoryTile({
    required this.entry,
    required this.time,
    required this.uploaderName,
    required this.canDelete,
    required this.canEdit,
    this.uploaderAvatarUrl,
    this.day,
  });

  final TripMemoryEntry entry;

  /// `entry.createdAt` on the user's wall clock.
  final DateTime time;
  final String uploaderName;
  final String? uploaderAvatarUrl;

  /// 1-based trip day, or null when posted outside the trip dates.
  final int? day;
  final bool canDelete;

  /// Caption edit is uploader-only (stricter than [canDelete]).
  final bool canEdit;

  TripMemoryTile withEntry(TripMemoryEntry entry) => TripMemoryTile(
    entry: entry,
    time: time,
    uploaderName: uploaderName,
    uploaderAvatarUrl: uploaderAvatarUrl,
    day: day,
    canDelete: canDelete,
    canEdit: canEdit,
  );
}

class TripMemoryDayGroup {
  const TripMemoryDayGroup({
    required this.date,
    required this.tiles,
    required this.count,
    this.day,
    this.place,
  });

  /// Calendar day of the user's wall clock, stored as UTC midnight.
  final DateTime date;
  final int? day;
  final String? place;
  final List<TripMemoryTile> tiles;

  /// Memories of the whole day, which may exceed the loaded [tiles].
  final int count;
}

class TripMemoryDayOption {
  const TripMemoryDayOption({required this.day, this.place, this.count});

  final int day;
  final String? place;
  final int? count;
}

/// What the list area shows below the overview and the filter chips.
enum TripMemoriesBodyStatus { ready, switchingFilter, filterError }

class TripMemoriesView {
  const TripMemoriesView({
    required this.filter,
    required this.groups,
    required this.dayOptions,
    required this.contributors,
    required this.hasMore,
    required this.isLoadingMore,
    required this.loadMoreError,
    this.totalCount,
    this.status = TripMemoriesBodyStatus.ready,
    this.filterError,
  });

  /// Filter selected by the user; the list may still show another one while
  /// [status] is [TripMemoriesBodyStatus.switchingFilter].
  final TripMemoriesFilter filter;
  final List<TripMemoryDayGroup> groups;
  final List<TripMemoryDayOption> dayOptions;

  /// Members who posted at least one photo, most active first.
  final List<TripMemoryContributor> contributors;

  /// Memories of the whole trip, or null when unknown.
  final int? totalCount;
  final bool hasMore;
  final bool isLoadingMore;
  final Object? loadMoreError;
  final TripMemoriesBodyStatus status;
  final Object? filterError;

  bool get isEmpty => groups.isEmpty;

  /// Loaded memories in display order, for the photo viewer.
  List<TripMemoryTile> get tiles => [
    for (final group in groups) ...group.tiles,
  ];
}

/// Memories happen at real instants, so they are grouped by the user's wall
/// clock ([toWallClock]); trip dates are compared as calendar days.
TripMemoriesView buildTripMemoriesView({
  required TripMemoriesState memories,
  required TripMemoriesFilter selected,
  required TripMemoriesWallClock toWallClock,
  TripMemoriesHeader? header,
  Object? pendingError,
}) {
  final status = switch (memories.filter == selected) {
    true => TripMemoriesBodyStatus.ready,
    false when pendingError != null => TripMemoriesBodyStatus.filterError,
    false => TripMemoriesBodyStatus.switchingFilter,
  };
  final isReady = status == TripMemoriesBodyStatus.ready;
  final isComplete = isReady && !memories.hasMore;
  final groups = isReady
      ? _groupByDay(memories, header: header, toWallClock: toWallClock)
      : const <TripMemoryDayGroup>[];
  final loadedDayCounts = isComplete && memories.filter.isAll
      ? {
          for (final group in groups)
            if (group.day != null) group.day!: group.tiles.length,
        }
      : null;
  return TripMemoriesView(
    filter: selected,
    groups: groups,
    dayOptions: _dayOptions(header, memories.dayCounts ?? loadedDayCounts),
    contributors: _contributors(header),
    totalCount:
        header?.totalCount ??
        (memories.filter.isAll
            ? memories.totalCount ??
                  (isComplete ? memories.entries.length : null)
            : null),
    hasMore: memories.hasMore,
    isLoadingMore: memories.isLoadingMore,
    loadMoreError: memories.loadMoreError,
    status: status,
    filterError: status == TripMemoriesBodyStatus.filterError
        ? pendingError
        : null,
  );
}

List<TripMemoryDayGroup> _groupByDay(
  TripMemoriesState memories, {
  required TripMemoriesHeader? header,
  required TripMemoriesWallClock toWallClock,
}) {
  final sorted = [...memories.entries]..sort(_newestFirst);
  final byDate = <DateTime, List<TripMemoryTile>>{};
  for (final entry in sorted) {
    final time = toWallClock(entry.createdAt);
    final date = _dateOf(time);
    final day = header?.dayOf(date);
    byDate
        .putIfAbsent(date, () => [])
        .add(_tile(entry, time: time, day: day, header: header));
  }
  return [
    for (final MapEntry(key: date, value: tiles) in byDate.entries)
      _group(date, tiles, header: header, dayCounts: memories.dayCounts),
  ];
}

TripMemoryDayGroup _group(
  DateTime date,
  List<TripMemoryTile> tiles, {
  required TripMemoriesHeader? header,
  required Map<int, int>? dayCounts,
}) {
  final day = tiles.first.day;
  final total = day == null ? null : dayCounts?[day];
  return TripMemoryDayGroup(
    date: date,
    day: day,
    place: header?.placeOn(date),
    tiles: List.unmodifiable(tiles),
    count: total != null && total > tiles.length ? total : tiles.length,
  );
}

TripMemoryTile _tile(
  TripMemoryEntry entry, {
  required DateTime time,
  required int? day,
  required TripMemoriesHeader? header,
}) {
  final uploaderId = entry.user?.id;
  final member = header?.memberOf(uploaderId);
  final isOwn = uploaderId != null && uploaderId == header?.viewerId;
  final isMember = header?.isMember ?? false;
  return TripMemoryTile(
    entry: entry,
    time: time,
    day: day,
    uploaderName: member?.name ?? entry.user?.username ?? 'Tài khoản đã xóa',
    uploaderAvatarUrl: member?.avatarUrl,
    canDelete: isMember && (isOwn || header!.canModerate),
    canEdit: isMember && isOwn,
  );
}

List<TripMemoryDayOption> _dayOptions(
  TripMemoriesHeader? header,
  Map<int, int>? dayCounts,
) {
  if (header == null) return const [];
  return [
    for (var day = 1; day <= header.dayCount; day++)
      TripMemoryDayOption(
        day: day,
        place: header.placeOn(header.dateOfDay(day)),
        count: dayCounts == null ? null : dayCounts[day] ?? 0,
      ),
  ];
}

List<TripMemoryContributor> _contributors(TripMemoriesHeader? header) {
  if (header == null) return const [];
  return [
    for (final member in header.members)
      if (member.memoryCount > 0) member,
  ]..sort((a, b) => b.memoryCount.compareTo(a.memoryCount));
}

int _newestFirst(TripMemoryEntry a, TripMemoryEntry b) {
  final byTime = b.createdAt.compareTo(a.createdAt);
  return byTime != 0 ? byTime : b.id.compareTo(a.id);
}

DateTime _dateOf(DateTime value) =>
    DateTime.utc(value.year, value.month, value.day);

/// Maps an instant to the date and time fields the user reads on screen.
typedef TripMemoriesWallClock = DateTime Function(DateTime instant);

DateTime _utcWallClock(DateTime instant) => instant.toUtc();

/// UTC, the time zone the backend uses for trip days, so the groups match the
/// `day` filter and `dayCounts`.
final tripMemoriesWallClockProvider = Provider<TripMemoriesWallClock>(
  (ref) => _utcWallClock,
);

/// Null until the trip detail is loaded; the album does not wait for it.
final tripMemoriesHeaderProvider = Provider.autoDispose
    .family<TripMemoriesHeader?, String>((ref, tripId) {
      final trip = ref
          .watch(tripDetailOverviewControllerProvider(tripId))
          .value;
      return trip == null ? null : TripMemoriesHeader.fromTrip(trip);
    });

/// Loading or error without any loaded page yet; otherwise data, so switching
/// filters keeps the overview and the chips on screen.
final tripMemoriesViewProvider = Provider.autoDispose
    .family<AsyncValue<TripMemoriesView>, String>((ref, tripId) {
      final memories = ref.watch(tripMemoriesControllerProvider(tripId));
      final selected = ref.watch(tripMemoriesFilterProvider(tripId));
      final header = ref.watch(tripMemoriesHeaderProvider(tripId));
      final toWallClock = ref.watch(tripMemoriesWallClockProvider);
      final loaded = memories.value;
      if (loaded == null) {
        return switch (memories) {
          AsyncError(:final error, :final stackTrace) => AsyncError(
            error,
            stackTrace,
          ),
          _ => const AsyncLoading(),
        };
      }
      return AsyncData(
        buildTripMemoriesView(
          memories: loaded,
          selected: selected,
          toWallClock: toWallClock,
          header: header,
          pendingError: memories.hasError ? memories.error : null,
        ),
      );
    });
