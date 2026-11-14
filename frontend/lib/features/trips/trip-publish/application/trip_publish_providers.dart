import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_frontend_v1/core/providers/core_provider.dart';
import 'package:uuid/uuid.dart';

import '../data/datasources/trip_publish_remote_datasource.dart';
import '../data/models/trip_publish_models.dart';
import '../data/repositories/trip_publish_repository.dart';

final tripPublishRepositoryProvider = Provider<TripPublishRepository>((ref) {
  return TripPublishRepository(
    remote: TripPublishRemoteDataSource(
      apiClient: ref.watch(apiClientProvider),
    ),
  );
});

final recruitmentSummaryProvider =
    AsyncNotifierProvider<RecruitmentSummaryController, RecruitmentSummary>(
      RecruitmentSummaryController.new,
    );

class RecruitmentSummaryController extends AsyncNotifier<RecruitmentSummary> {
  @override
  Future<RecruitmentSummary> build() =>
      ref.watch(tripPublishRepositoryProvider).summary();

  Future<void> refresh() async {
    state = await AsyncValue.guard(
      () => ref.read(tripPublishRepositoryProvider).summary(),
    );
  }
}

final publishFlowBusyProvider = NotifierProvider<PublishFlowBusy, bool>(
  PublishFlowBusy.new,
);

class PublishFlowBusy extends Notifier<bool> {
  @override
  bool build() => false;

  void setBusy(bool value) => state = value;
}

final publishIdempotencyProvider = NotifierProvider.autoDispose
    .family<PublishIdempotencyKey, String?, String>(PublishIdempotencyKey.new);

class PublishIdempotencyKey extends Notifier<String?> {
  PublishIdempotencyKey(this.tripId);

  final String tripId;

  @override
  String? build() {
    if (tripId.isEmpty) return null;
    return null;
  }

  /// One key per publish attempt. Retries keep it until the attempt succeeds.
  String keyForAttempt() => state ??= const Uuid().v4();

  void clear() => state = null;
}
