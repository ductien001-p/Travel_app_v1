import '../models/trip_publish_models.dart';

abstract class TripPublishDataSource {
  Future<RecruitmentSummary> summary();

  Future<RecruitmentMine> mine();

  Future<RecruitmentPublishResult> patch(
    String tripId,
    Map<String, dynamic> body,
  );

  Future<RecruitmentPublishResult> publish(
    String tripId,
    String idempotencyKey,
  );

  Future<RecruitmentPublishResult> close(String tripId);

  Future<RecruitmentPublishResult> reopen(String tripId);
}
