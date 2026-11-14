import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';
import 'package:travel_frontend_v1/core/networks/api_exception.dart';

import '../data/models/trip_detail_models.dart';
import '../provider/trip_detail_provider.dart';
import '../utils/trip_detail_formatters.dart';

/// Platform share sheet, replaceable in tests.
abstract interface class TripShareSheet {
  Future<void> share(String text, {required String subject, Rect? origin});
}

class SharePlusTripShareSheet implements TripShareSheet {
  const SharePlusTripShareSheet();

  @override
  Future<void> share(String text, {required String subject, Rect? origin}) =>
      SharePlus.instance.share(
        ShareParams(text: text, subject: subject, sharePositionOrigin: origin),
      );
}

final tripShareSheetProvider = Provider<TripShareSheet>(
  (ref) => const SharePlusTripShareSheet(),
);

/// Members may share any trip that is neither a draft nor cancelled.
bool isTripShareable(TripDetailOverview trip) =>
    trip.isMember &&
    trip.status != TripDetailStatus.draft &&
    trip.status != TripDetailStatus.cancelled;

/// `<trip name> (15 - 18/07)` then the link on its own line.
String tripShareMessage(TripDetailOverview trip, String url) =>
    '${trip.name} (${formatShortDateRange(trip.startDate, trip.endDate)})\n'
    'Xem lịch trình chuyến đi: $url';

/// Safe message for share/revoke failures; never echoes raw server text.
String tripShareErrorMessage(Object error) {
  if (error is! ApiException) {
    return 'Không thể chia sẻ lúc này. Vui lòng thử lại.';
  }
  return switch (error.statusCode) {
    403 => 'Bạn không có quyền thực hiện thao tác này.',
    409 => 'Chuyến đi nháp hoặc đã hủy không thể chia sẻ.',
    429 => 'Bạn đã tạo quá nhiều link. Vui lòng thử lại sau.',
    503 => 'Tính năng chia sẻ đang tạm ngưng.',
    _ => 'Không thể chia sẻ lúc này. Vui lòng thử lại.',
  };
}

enum TripShareAction { share, revoke }

final tripItineraryShareControllerProvider = NotifierProvider.autoDispose
    .family<TripItineraryShareController, TripShareAction?, String>(
      TripItineraryShareController.new,
    );

/// State is the action in flight, null when idle.
class TripItineraryShareController extends Notifier<TripShareAction?> {
  TripItineraryShareController(this.tripId);

  final String tripId;

  @override
  TripShareAction? build() => null;

  /// Creates a fresh link and opens the share sheet with it.
  Future<void> share(TripDetailOverview trip, {Rect? origin}) =>
      _run(TripShareAction.share, () async {
        final link = await ref
            .read(tripDetailRepositoryProvider)
            .createShareLink(tripId);
        await ref
            .read(tripShareSheetProvider)
            .share(
              tripShareMessage(trip, link.url),
              subject: trip.name,
              origin: origin,
            );
      });

  /// Revokes every live link of the trip (owner/admin); returns how many.
  Future<int> revokeAll() => _run(
    TripShareAction.revoke,
    () => ref.read(tripDetailRepositoryProvider).revokeShareLinks(tripId),
  );

  Future<T> _run<T>(TripShareAction action, Future<T> Function() task) async {
    if (state != null) {
      throw StateError('A share action is already in progress.');
    }
    state = action;
    try {
      return await task();
    } finally {
      if (ref.mounted) state = null;
    }
  }
}
