import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:travel_frontend_v1/core/networks/api_exception.dart';
import 'package:travel_frontend_v1/features/trips/trip-invitation/application/trip_join_by_code_controller.dart';
import 'package:travel_frontend_v1/features/trips/trip-invitation/data/datamock/trip_join_by_code_datamock.dart';
import 'package:travel_frontend_v1/features/trips/trip-invitation/data/models/trip_join_request_models.dart';
import 'package:travel_frontend_v1/features/trips/trip-invitation/provider/trip_join_requests_provider.dart';
import 'package:travel_frontend_v1/features/trips/trip-invitation/utils/trip_join_by_code_formatters.dart';

import '../trip_join_requests/in_memory_trip_join_requests_datasource.dart';

void main() {
  late InMemoryTripJoinRequestsDataSource dataSource;

  ProviderContainer createContainer() {
    final container = ProviderContainer(
      overrides: [
        tripJoinRequestsDataSourceProvider.overrideWithValue(dataSource),
      ],
    );
    addTearDown(container.dispose);
    return container;
  }

  setUp(
    () => dataSource = InMemoryTripJoinRequestsDataSource(
      now: () => DateTime.utc(2025, 7, 10, 8),
    ),
  );

  test('normalizeInviteCode strips hyphen and uppercases', () {
    expect(normalizeInviteCode('he2025-vn'), tripJoinByCodeDemoInviteCode);
    expect(isInviteCodeComplete(tripJoinByCodeDemoInviteCode), isTrue);
  });

  test('preview loads TripJoinInvitePreview from GET join lookup', () async {
    final container = createContainer();
    container.listen(
      tripJoinInvitePreviewProvider(tripJoinByCodeDemoInviteCode),
      (_, _) {},
    );

    final preview = await container.read(
      tripJoinInvitePreviewProvider(tripJoinByCodeDemoInviteCode).future,
    );

    expect(preview, isNotNull);
    expect(preview!.inviteCode, tripJoinByCodeDemoInviteCode);
    expect(preview.tripId, 'trip-demo-summer-2025');
    expect(preview.ownerDisplayName, 'Alex Nguyễn');
    expect(preview.memberCount, 4);
    expect(preview.maxMembers, 5);
    expect(preview.matchScore, 94);
  });

  test('preview is null while the code is incomplete', () async {
    final container = createContainer();
    final preview = await container.read(
      tripJoinInvitePreviewProvider('HE20').future,
    );
    expect(preview, isNull);
  });

  test('submit sends a pending join request for a complete code', () async {
    final container = createContainer();
    container.listen(tripJoinByCodeControllerProvider, (_, _) {});

    final result = await container
        .read(tripJoinByCodeControllerProvider.notifier)
        .submit(inviteCode: 'HE2025-VN', message: 'Xin chào nhóm!');

    expect(result, isNotNull);
    expect(result!.request.status, TripJoinRequestStatus.pending);
    expect(result.request.message, 'Xin chào nhóm!');
    expect(container.read(tripJoinByCodeControllerProvider).error, isNull);
    expect(
      container.read(tripJoinByCodeControllerProvider).isSubmitting,
      isFalse,
    );
  });

  test('submit rejects an incomplete code', () async {
    final container = createContainer();
    container.listen(tripJoinByCodeControllerProvider, (_, _) {});

    final result = await container
        .read(tripJoinByCodeControllerProvider.notifier)
        .submit(inviteCode: 'HE20');

    expect(result, isNull);
    expect(container.read(tripJoinByCodeControllerProvider).error, isNotNull);
  });

  test('submit surfaces API errors', () async {
    dataSource = _FailingJoinDataSource();
    final container = createContainer();
    container.listen(tripJoinByCodeControllerProvider, (_, _) {});

    final result = await container
        .read(tripJoinByCodeControllerProvider.notifier)
        .submit(inviteCode: tripJoinByCodeDemoInviteCode);

    expect(result, isNull);
    final error = container.read(tripJoinByCodeControllerProvider).error;
    expect(error, isA<ApiException>());
    expect((error! as ApiException).statusCode, 404);
  });
}

class _FailingJoinDataSource extends InMemoryTripJoinRequestsDataSource {
  _FailingJoinDataSource() : super(now: () => DateTime.utc(2025, 7, 10, 8));

  @override
  Future<TripJoinRequest> requestToJoin(
    String inviteCode, {
    String? message,
  }) async {
    throw const ApiException(message: 'Mã mời không hợp lệ', statusCode: 404);
  }
}
