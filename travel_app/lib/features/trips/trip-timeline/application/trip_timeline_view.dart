import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../trip-details/application/trip_detail_overview_controller.dart';
import '../data/models/trip_timeline_models.dart';
import 'trip_timeline_events_controller.dart';
import 'trip_timeline_filter.dart';

enum TripTimelineDayKind { today, yesterday, tripStart, other }

class TripTimelineDayGroup {
  const TripTimelineDayGroup({
    required this.date,
    required this.kind,
    required this.entries,
  });

  /// Calendar day of the user's wall clock, stored as UTC midnight like every
  /// other date-only value in the app.
  final DateTime date;
  final TripTimelineDayKind kind;
  final List<TripTimelineEntry> entries;
}

/// What the list area shows below the summary and the filter chips.
enum TripTimelineBodyStatus { ready, switchingFilter, filterError }

class TripTimelineView {
  const TripTimelineView({
    required this.filter,
    required this.groups,
    required this.counts,
    required this.hasMore,
    required this.isLoadingMore,
    required this.loadMoreError,
    this.status = TripTimelineBodyStatus.ready,
    this.filterError,
  });

  /// Filter selected by the user; the list may still show another one while
  /// [status] is [TripTimelineBodyStatus.switchingFilter].
  final TripTimelineFilter filter;
  final List<TripTimelineDayGroup> groups;

  /// Totals of the whole trip, from the backend.
  final TripTimelineCounts counts;
  final bool hasMore;
  final bool isLoadingMore;
  final Object? loadMoreError;
  final TripTimelineBodyStatus status;
  final Object? filterError;

  bool get isEmpty => groups.isEmpty;

  int countOf(TripTimelineFilter filter) => counts.of(filter);
}

/// Trip facts for the header, taken from `GET /trips/{id}`.
class TripTimelineHeader {
  const TripTimelineHeader({
    required this.tripName,
    required this.memberCount,
    this.inviteCode,
  });

  final String tripName;
  final int memberCount;

  /// Only sent to the trip owner by the backend.
  final String? inviteCode;
}

/// [selected] differs from `events.filter` while the newly selected filter is
/// loading ([pendingError] is set when that load failed).
///
/// Events happen at real instants, so they are grouped by the user's wall
/// clock ([toWallClock]), unlike trip dates and activity times which are a UTC
/// wall clock across the app.
TripTimelineView buildTripTimelineView({
  required TripTimelineEventsState events,
  required TripTimelineFilter selected,
  required DateTime now,
  required TripTimelineWallClock toWallClock,
  Object? pendingError,
}) {
  final status = switch (events.filter == selected) {
    true => TripTimelineBodyStatus.ready,
    false when pendingError != null => TripTimelineBodyStatus.filterError,
    false => TripTimelineBodyStatus.switchingFilter,
  };
  final sorted = [...events.entries]..sort(_newestFirst);
  return TripTimelineView(
    filter: selected,
    groups: status == TripTimelineBodyStatus.ready
        ? _groupByDay(sorted, now: now, toWallClock: toWallClock)
        : const [],
    counts: events.counts,
    hasMore: events.hasMore,
    isLoadingMore: events.isLoadingMore,
    loadMoreError: events.loadMoreError,
    status: status,
    filterError: status == TripTimelineBodyStatus.filterError
        ? pendingError
        : null,
  );
}

List<TripTimelineDayGroup> _groupByDay(
  Iterable<TripTimelineEntry> entries, {
  required DateTime now,
  required TripTimelineWallClock toWallClock,
}) {
  final byDay = <DateTime, List<TripTimelineEntry>>{};
  for (final entry in entries) {
    final day = _calendarDay(toWallClock(entry.createdAt));
    byDay.putIfAbsent(day, () => []).add(entry);
  }
  final today = _calendarDay(toWallClock(now));
  return [
    for (final MapEntry(key: day, value: dayEntries) in byDay.entries)
      TripTimelineDayGroup(
        date: day,
        kind: _dayKind(day, today, dayEntries),
        entries: List.unmodifiable(dayEntries),
      ),
  ];
}

TripTimelineDayKind _dayKind(
  DateTime day,
  DateTime today,
  List<TripTimelineEntry> entries,
) {
  final offset = today.difference(day).inDays;
  if (offset == 0) return TripTimelineDayKind.today;
  if (offset == 1) return TripTimelineDayKind.yesterday;
  final hasTripStart = entries.any(
    (entry) => entry.type == TripTimelineEntryType.tripCreated,
  );
  return hasTripStart
      ? TripTimelineDayKind.tripStart
      : TripTimelineDayKind.other;
}

int _newestFirst(TripTimelineEntry a, TripTimelineEntry b) {
  final byTime = b.createdAt.compareTo(a.createdAt);
  return byTime != 0 ? byTime : b.id.compareTo(a.id);
}

DateTime _calendarDay(DateTime wallClock) =>
    DateTime.utc(wallClock.year, wallClock.month, wallClock.day);

/// Overridable clock so day labels ("Hôm nay") are testable.
final tripTimelineClockProvider = Provider<DateTime Function()>(
  (ref) => DateTime.now,
);

/// Maps an instant to the date and time fields the user reads on screen.
typedef TripTimelineWallClock = DateTime Function(DateTime instant);

DateTime _deviceWallClock(DateTime instant) => instant.toLocal();

/// The device time zone; overridable so tests do not depend on the machine.
final tripTimelineWallClockProvider = Provider<TripTimelineWallClock>(
  (ref) => _deviceWallClock,
);

/// Loading or error without any loaded page yet; otherwise data, so switching
/// filters keeps the summary and the chips on screen.
final tripTimelineViewProvider = Provider.autoDispose
    .family<AsyncValue<TripTimelineView>, String>((ref, tripId) {
      final events = ref.watch(tripTimelineEventsControllerProvider(tripId));
      final selected = ref.watch(tripTimelineFilterProvider(tripId));
      final now = ref.watch(tripTimelineClockProvider)();
      final toWallClock = ref.watch(tripTimelineWallClockProvider);
      final loaded = events.value;
      if (loaded == null) {
        return switch (events) {
          AsyncError(:final error, :final stackTrace) => AsyncError(
            error,
            stackTrace,
          ),
          _ => const AsyncLoading(),
        };
      }
      return AsyncData(
        buildTripTimelineView(
          events: loaded,
          selected: selected,
          now: now,
          toWallClock: toWallClock,
          pendingError: events.hasError ? events.error : null,
        ),
      );
    });

/// Null until the trip detail is loaded; the timeline does not wait for it.
final tripTimelineHeaderProvider = Provider.autoDispose
    .family<TripTimelineHeader?, String>((ref, tripId) {
      final trip = ref
          .watch(tripDetailOverviewControllerProvider(tripId))
          .value;
      if (trip == null) return null;
      return TripTimelineHeader(
        tripName: trip.name,
        memberCount: trip.members.length,
        inviteCode: trip.inviteCode,
      );
    });
