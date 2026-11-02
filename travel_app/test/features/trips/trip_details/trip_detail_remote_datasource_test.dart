import 'package:flutter_test/flutter_test.dart';
import 'package:travel_frontend_v1/core/networks/api_client.dart';
import 'package:travel_frontend_v1/core/storage/token_storage.dart';
import 'package:travel_frontend_v1/features/trips/trip-details/data/datamock/trip_itinerary_datamock.dart';
import 'package:travel_frontend_v1/features/trips/trip-details/data/datasources/trip_detail_remote_datasource.dart';

import 'trip_detail_fixture.dart';

void main() {
  late _RecordingApiClient apiClient;
  late TripDetailRemoteDataSource dataSource;

  setUp(() {
    apiClient = _RecordingApiClient();
    dataSource = TripDetailRemoteDataSource(apiClient: apiClient);
  });

  test('getTripDetail reads the envelope of GET /trips/{id}', () async {
    apiClient.responses['GET /trips/trip%2F1'] = {
      'data': tripDetailJson(id: 'trip/1'),
      'message': 'Trip retrieved successfully',
    };

    final trip = await dataSource.getTripDetail('trip/1');

    expect(apiClient.calls, ['GET /trips/trip%2F1']);
    expect(trip.id, 'trip/1');
  });

  test('getTripDetail rejects a response without data', () async {
    apiClient.responses['GET /trips/trip-1'] = {'message': 'oops'};

    await expectLater(
      dataSource.getTripDetail('trip-1'),
      throwsA(isA<FormatException>()),
    );
  });

  test('member actions use the backend endpoints', () async {
    apiClient.responses['POST /trips/trip-1/completion'] = {
      'data': {'pointsAwarded': 30, 'totalPlaces': 8},
      'message': 'Trip completed successfully',
    };
    apiClient.responses['POST /trips/trip-1/invite-code/rotate'] = {
      'data': {'id': 'trip-1', 'inviteCode': 'ROTATED1'},
      'message': 'Invite code rotated successfully',
    };

    await dataSource.kickMember('trip-1', 'user-2');
    await dataSource.leaveTrip('trip-1');
    final claim = await dataSource.claimCompletionReward('trip-1');
    final code = await dataSource.rotateInviteCode('trip-1');

    expect(apiClient.calls, [
      'POST /trips/kick/trip-1/user-2',
      'POST /trips/leave/trip-1',
      'POST /trips/trip-1/completion',
      'POST /trips/trip-1/invite-code/rotate',
    ]);
    expect(claim.pointsAwarded, 30);
    expect(code, 'ROTATED1');
  });

  test(
    'getDayRoute reads GET /trips/{id}/itineraries/days/{dayId}/route',
    () async {
      apiClient.responses['GET /trips/trip-1/itineraries/days/day%2F2/route'] =
          tripItineraryDatamock['dayRoute'];

      final route = await dataSource.getDayRoute('trip-1', 'day/2');

      expect(route.dayId, 'day-2');
      expect(route.legs, hasLength(3));
      expect(route.legs.first.distanceMeters, 4200);
    },
  );

  test('share link endpoints', () async {
    apiClient.responses['POST /trips/trip-1/share-links'] = {
      'data': {
        'url': 'https://share.test/s/${'a' * 43}',
        'expiresAt': '2026-11-11T00:00:00.000Z',
      },
    };
    apiClient.responses['DELETE /trips/trip-1/share-links'] = {
      'data': {'revokedCount': 2},
    };

    final link = await dataSource.createShareLink('trip-1');
    final revoked = await dataSource.revokeShareLinks('trip-1');

    expect(link.url, 'https://share.test/s/${'a' * 43}');
    expect(link.expiresAt, DateTime.utc(2026, 11, 11));
    expect(revoked, 2);
    expect(apiClient.calls, [
      'POST /trips/trip-1/share-links',
      'DELETE /trips/trip-1/share-links',
    ]);
  });

  test('revokeShareLinks rejects a response without a count', () async {
    apiClient.responses['DELETE /trips/trip-1/share-links'] = {'data': {}};

    await expectLater(
      dataSource.revokeShareLinks('trip-1'),
      throwsA(isA<FormatException>()),
    );
  });

  test('getSharedItinerary parses the read-only envelope', () async {
    final token = 'b' * 43;
    final itinerary = tripItineraryDatamock['itinerary'] as Map;
    apiClient.responses['GET /trip-shares/$token'] = {
      'data': {
        'trip': {
          'id': 'trip-1',
          'name': 'Mùa hè',
          'startDate': '2026-07-15T00:00:00.000Z',
          'endDate': '2026-07-20T00:00:00.000Z',
          'status': 'UPCOMING',
          'coverImageUrl': null,
        },
        'destinations': itinerary['data'],
        'permissions': {'canManageItinerary': false},
        'viewer': {'isMember': false},
      },
    };

    final shared = await dataSource.getSharedItinerary(token);

    expect(shared.trip.name, 'Mùa hè');
    expect(shared.viewerIsMember, isFalse);
    expect(shared.itinerary.canManageItinerary, isFalse);
    expect(shared.itinerary.destinations, isNotEmpty);
  });

  test('getSharedItinerary rejects a response without viewer', () async {
    final token = 'c' * 43;
    apiClient.responses['GET /trip-shares/$token'] = {
      'data': {'trip': <String, Object?>{}, 'destinations': <Object>[]},
    };

    await expectLater(
      dataSource.getSharedItinerary(token),
      throwsA(isA<FormatException>()),
    );
  });
}

class _RecordingApiClient extends ApiClient {
  _RecordingApiClient()
    : super(tokenStorage: TokenStorage(), onSessionExpired: () {});

  final responses = <String, Object?>{};
  final calls = <String>[];

  @override
  Future<T> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    bool requiresAuth = true,
  }) async => _respond('GET $path');

  @override
  Future<T> post<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    bool requiresAuth = true,
  }) async => _respond('POST $path');

  @override
  Future<T> delete<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    bool requiresAuth = true,
  }) async => _respond('DELETE $path');

  T _respond<T>(String call) {
    calls.add(call);
    return responses[call] as T;
  }
}
