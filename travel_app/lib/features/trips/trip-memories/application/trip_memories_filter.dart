import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Day and photographer chips of the album. Both can be combined.
class TripMemoriesFilter {
  const TripMemoriesFilter({this.day, this.uploaderId});

  static const all = TripMemoriesFilter();

  /// 1-based trip day; null for every day.
  final int? day;

  /// User who posted the photo; null for every member.
  final String? uploaderId;

  bool get isAll => day == null && uploaderId == null;

  TripMemoriesFilter withDay(int? day) =>
      TripMemoriesFilter(day: day, uploaderId: uploaderId);

  TripMemoriesFilter withUploader(String? uploaderId) =>
      TripMemoriesFilter(day: day, uploaderId: uploaderId);

  @override
  bool operator ==(Object other) =>
      other is TripMemoriesFilter &&
      other.day == day &&
      other.uploaderId == uploaderId;

  @override
  int get hashCode => Object.hash(day, uploaderId);
}

final tripMemoriesFilterProvider = NotifierProvider.autoDispose
    .family<TripMemoriesFilterController, TripMemoriesFilter, String>(
      TripMemoriesFilterController.new,
    );

class TripMemoriesFilterController extends Notifier<TripMemoriesFilter> {
  TripMemoriesFilterController(this.tripId);

  final String tripId;

  @override
  TripMemoriesFilter build() => TripMemoriesFilter.all;

  void selectDay(int? day) => state = state.withDay(day);

  void selectUploader(String? uploaderId) =>
      state = state.withUploader(uploaderId);

  void reset() => state = TripMemoriesFilter.all;
}
