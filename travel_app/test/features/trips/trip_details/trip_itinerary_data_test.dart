import 'package:flutter_test/flutter_test.dart';
import 'package:travel_frontend_v1/core/networks/api_client.dart';
import 'package:travel_frontend_v1/core/networks/api_exception.dart';
import 'package:travel_frontend_v1/core/storage/token_storage.dart';
import 'package:travel_frontend_v1/features/trips/trip-details/data/datamock/trip_itinerary_datamock.dart';
import 'package:travel_frontend_v1/features/trips/trip-details/data/datasources/trip_detail_remote_datasource.dart';
import 'package:travel_frontend_v1/features/trips/trip-details/data/repositories/trip_detail_repository.dart';

void main() {
  late _StubApiClient apiClient;
  late TripDetailRepository repository;

  setUp(() {
    apiClient = _StubApiClient();
    repository = TripDetailRepository(
      remoteDataSource: TripDetailRemoteDataSource(apiClient: apiClient),
    );
  });

  test('reads viewer check-ins from the itinerary endpoint', () async {
    apiClient.response = tripItineraryDatamock['viewerCheckins'];

    final placeIds = await repository.getViewerCheckedInPlaceIds('trip/1');

    expect(apiClient.calls, ['GET /trips/trip%2F1/itineraries/checkins/me']);
    expect(placeIds, {
      'place-ban-co',
      'place-han-market',
      'place-my-khe',
      'place-mi-quang-ba-mua',
    });
  });

  test('keeps a check-in whose activity was deleted', () async {
    apiClient.response = {
      'data': [
        {
          'activityId': null,
          'placeId': 'place-1',
          'visitedAt': '2026-07-16T02:00:00.000Z',
        },
      ],
    };

    expect(await repository.getViewerCheckedInPlaceIds('trip-1'), {'place-1'});
  });

  test('propagates failures, including 404', () async {
    for (final status in [404, 500]) {
      apiClient.error = ApiException(message: 'Boom', statusCode: status);

      await expectLater(
        repository.getViewerCheckedInPlaceIds('trip-1'),
        throwsA(isA<ApiException>()),
      );
    }
  });

  test('rejects a response without a data list', () async {
    apiClient.response = {'data': <String, dynamic>{}};

    await expectLater(
      repository.getViewerCheckedInPlaceIds('trip-1'),
      throwsA(isA<FormatException>()),
    );
  });
}

class _StubApiClient extends ApiClient {
  _StubApiClient()
    : super(tokenStorage: TokenStorage(), onSessionExpired: () {});

  Object? response;
  ApiException? error;
  final calls = <String>[];

  @override
  Future<T> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    bool requiresAuth = true,
  }) async {
    calls.add('GET $path');
    final error = this.error;
    if (error != null) throw error;
    return response as T;
  }
}
