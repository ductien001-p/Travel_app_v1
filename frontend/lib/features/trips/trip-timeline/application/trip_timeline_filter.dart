import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/trip_timeline_models.dart';

enum TripTimelineFilter {
  all,
  checkin,
  expense,
  memory,
  member;

  /// `category` query value of `GET /trips/timeline/{tripId}`.
  String? get apiCategory => this == all ? null : name;

  /// Mirrors the backend category mapping; used to place live events.
  bool matches(TripTimelineEntryType type) => switch (this) {
    TripTimelineFilter.all => true,
    TripTimelineFilter.checkin => type == TripTimelineEntryType.activityCheckin,
    TripTimelineFilter.expense =>
      type == TripTimelineEntryType.expenseCreated ||
          type == TripTimelineEntryType.expenseSettled,
    TripTimelineFilter.memory =>
      type == TripTimelineEntryType.memoryAdded ||
          type == TripTimelineEntryType.photoAdded ||
          type == TripTimelineEntryType.memoryDeleted,
    TripTimelineFilter.member =>
      type == TripTimelineEntryType.memberJoined ||
          type == TripTimelineEntryType.memberLeft ||
          type == TripTimelineEntryType.memberKicked,
  };
}

extension TripTimelineCountsByFilter on TripTimelineCounts {
  int of(TripTimelineFilter filter) => switch (filter) {
    TripTimelineFilter.all => all,
    TripTimelineFilter.checkin => checkin,
    TripTimelineFilter.expense => expense,
    TripTimelineFilter.memory => memory,
    TripTimelineFilter.member => member,
  };

  /// Counts after one more event of [type] was recorded.
  TripTimelineCounts adding(TripTimelineEntryType type) {
    int bump(TripTimelineFilter filter) =>
        of(filter) + (filter.matches(type) ? 1 : 0);
    return TripTimelineCounts(
      all: bump(TripTimelineFilter.all),
      checkin: bump(TripTimelineFilter.checkin),
      expense: bump(TripTimelineFilter.expense),
      memory: bump(TripTimelineFilter.memory),
      member: bump(TripTimelineFilter.member),
    );
  }
}

final tripTimelineFilterProvider = NotifierProvider.autoDispose
    .family<TripTimelineFilterController, TripTimelineFilter, String>(
      TripTimelineFilterController.new,
    );

class TripTimelineFilterController extends Notifier<TripTimelineFilter> {
  TripTimelineFilterController(this.tripId);

  final String tripId;

  @override
  TripTimelineFilter build() => TripTimelineFilter.all;

  void select(TripTimelineFilter filter) => state = filter;
}
