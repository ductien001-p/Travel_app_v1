import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:travel_frontend_v1/core/networks/api_exception.dart';
import 'package:travel_frontend_v1/features/trips/trip-details/application/trip_itinerary_share_controller.dart';
import 'package:travel_frontend_v1/features/trips/trip-details/data/models/trip_detail_models.dart';
import 'package:travel_frontend_v1/features/trips/trip-details/provider/trip_detail_provider.dart';

import 'trip_detail_fixture.dart';
import 'trip_itinerary_fixture.dart';

void main() {
  late FakeItineraryBackend backend;
  late RecordingShareSheet sheet;
  late ProviderContainer container;
  final trip = TripDetailOverview.fromJson(tripDetailJson());
  final provider = tripItineraryShareControllerProvider('trip-1');

  setUp(() {
    backend = FakeItineraryBackend();
    sheet = RecordingShareSheet();
    container = ProviderContainer(
      overrides: [
        tripDetailRemoteDataSourceProvider.overrideWithValue(
          FakeItineraryTripDetailDataSource(backend),
        ),
        tripShareSheetProvider.overrideWithValue(sheet),
      ],
    );
    addTearDown(container.dispose);
    container.listen(provider, (_, _) {});
  });

  test('share creates a link and hands the message to the sheet', () async {
    await container.read(provider.notifier).share(trip);

    expect(backend.shareLinkRequests, 1);
    expect(sheet.shared.single.subject, trip.name);
    expect(
      sheet.shared.single.text,
      endsWith('https://share.travel.test/s/${'a' * 43}'),
    );
    expect(container.read(provider), isNull);
  });

  test('a second action is rejected while one is in flight', () async {
    final first = container.read(provider.notifier).share(trip);
    expect(container.read(provider), TripShareAction.share);

    expect(
      () => container.read(provider.notifier).revokeAll(),
      throwsStateError,
    );
    await first;
    expect(backend.shareLinkRequests, 1);
  });

  test('revokeAll returns how many links were revoked', () async {
    expect(await container.read(provider.notifier).revokeAll(), 2);
    expect(await container.read(provider.notifier).revokeAll(), 0);
  });

  test(
    'a failed share leaves the sheet closed and the controller idle',
    () async {
      backend.shareError = const ApiException(message: 'nope', statusCode: 403);

      await expectLater(
        container.read(provider.notifier).share(trip),
        throwsA(isA<ApiException>()),
      );
      expect(sheet.shared, isEmpty);
      expect(container.read(provider), isNull);
    },
  );

  test('error messages never echo the server text', () {
    for (final status in [403, 409, 429, 503, 500]) {
      final message = tripShareErrorMessage(
        ApiException(message: 'internal detail', statusCode: status),
      );
      expect(message, isNot(contains('internal detail')));
    }
    expect(
      tripShareErrorMessage(StateError('x')),
      'Không thể chia sẻ lúc này. Vui lòng thử lại.',
    );
  });

  test('only members of an active trip can share', () {
    expect(isTripShareable(trip), isTrue);
    expect(
      isTripShareable(TripDetailOverview.fromJson(visitorTripDetailJson())),
      isFalse,
    );
    expect(
      isTripShareable(
        TripDetailOverview.fromJson({...tripDetailJson(), 'status': 'DRAFT'}),
      ),
      isFalse,
    );
    expect(
      isTripShareable(
        TripDetailOverview.fromJson({
          ...tripDetailJson(),
          'status': 'CANCELLED',
        }),
      ),
      isFalse,
    );
  });
}
