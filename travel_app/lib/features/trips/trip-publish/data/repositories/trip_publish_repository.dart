import 'package:travel_frontend_v1/core/networks/api_exception.dart';

import '../datasources/trip_publish_datasource.dart';
import '../models/trip_publish_models.dart';

class TripPublishRepository {
  const TripPublishRepository({required TripPublishDataSource remote})
    : _remote = remote;

  final TripPublishDataSource _remote;

  Future<RecruitmentSummary> summary() => _remote.summary();

  Future<RecruitmentMine> mine() => _remote.mine();

  Future<RecruitmentPublishResult> patch(
    String tripId,
    Map<String, dynamic> body,
  ) => _remote.patch(tripId, body);

  /// A 409 is success when mine already shows this trip effectively open.
  Future<RecruitmentPublishResult> publish(
    String tripId,
    String idempotencyKey,
  ) async {
    try {
      return await _remote.publish(tripId, idempotencyKey);
    } on ApiException catch (error) {
      if (error.statusCode != 409 && error.code != 'RECRUITMENT_ALREADY_OPEN') {
        rethrow;
      }
      final mine = await _remote.mine();
      for (final trip in mine.trips) {
        if (trip.tripId == tripId &&
            trip.effectiveState == RecruitmentState.open) {
          return RecruitmentPublishResult(
            tripId: tripId,
            state: RecruitmentState.open,
            effectiveState: RecruitmentState.open,
            expiresAt: trip.expiresAt,
            visibility: 'PUBLIC',
          );
        }
      }
      rethrow;
    }
  }

  Future<RecruitmentPublishResult> close(String tripId) =>
      _remote.close(tripId);

  Future<RecruitmentPublishResult> reopen(String tripId) =>
      _remote.reopen(tripId);
}
