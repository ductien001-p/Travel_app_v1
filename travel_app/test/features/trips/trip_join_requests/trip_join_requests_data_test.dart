import 'package:flutter_test/flutter_test.dart';
import 'package:travel_frontend_v1/core/networks/api_client.dart';
import 'package:travel_frontend_v1/core/networks/api_exception.dart';
import 'package:travel_frontend_v1/core/storage/token_storage.dart';
import 'package:travel_frontend_v1/features/trips/trip-details/data/models/trip_detail_models.dart';
import 'package:travel_frontend_v1/features/trips/trip-invitation/application/trip_join_requests_header.dart';
import 'package:travel_frontend_v1/features/trips/trip-invitation/data/datamock/trip_join_by_code_datamock.dart';
import 'package:travel_frontend_v1/features/trips/trip-invitation/data/datamock/trip_join_requests_datamock.dart';
import 'package:travel_frontend_v1/features/trips/trip-invitation/data/datasources/trip_join_requests_remote_datasource.dart';
import 'package:travel_frontend_v1/features/trips/trip-invitation/data/models/trip_join_request_models.dart';
import 'package:travel_frontend_v1/features/trips/trip-invitation/data/repositories/trip_join_requests_repository.dart';
import 'package:travel_frontend_v1/features/trips/trip-invitation/utils/trip_join_request_formatters.dart';

import 'trip_join_requests_fixture.dart';

void main() {
  group('datamock', () {
    test('parses every request with its persona and match', () {
      final requests = [
        for (final json in tripJoinRequestsDatamock['joinRequests'] as List)
          TripJoinRequest.fromJson(Map<String, dynamic>.from(json as Map)),
      ];

      expect(requests, hasLength(8));
      expect(requests.every((r) => r.personaType != null), isTrue);
      final minhAnh = requests.first;
      expect(minhAnh.requester.displayName, 'Minh Anh');
      expect(minhAnh.requester.isVerified, isTrue);
      expect(minhAnh.personaType, TripJoinRequestPersonaType.foodieTraveler);
      expect(minhAnh.travelPersona, 'Foodie Traveler');
      expect(minhAnh.matchScore, 96);
      expect(minhAnh.createdAt, DateTime.utc(2025, 7, 10, 7, 45));
    });

    test('parses a request exactly as the backend serializes it', () {
      final request = TripJoinRequest.fromJson({
        'id': 'cm9request',
        'tripId': 'cm9trip',
        'status': 'PENDING',
        'requester': {
          'id': 'cm9user',
          'displayName': 'Minh Anh',
          'username': 'minhanh',
          'avatarUrl': null,
          'isVerified': false,
          'isOnline': false,
        },
        'message': null,
        'travelPersona': null,
        'personaType': null,
        'matchScore': null,
        'matchNote': null,
        'createdAt': '2026-10-15T08:00:00.000Z',
        'decidedAt': null,
      });

      expect(request.status, TripJoinRequestStatus.pending);
      expect(request.personaType, isNull);
      expect(request.matchScore, isNull);
      expect(request.createdAt, DateTime.utc(2026, 10, 15, 8));
    });

    test('ignores a persona type the app does not know yet', () {
      final request = TripJoinRequest.fromJson({
        ...Map<String, dynamic>.from(
          (tripJoinRequestsDatamock['joinRequests'] as List).first as Map,
        ),
        'personaType': 'SPACE_TRAVELER',
      });

      expect(request.personaType, isNull);
    });
  });

  group('InMemoryTripJoinRequestsDataSource', () {
    late FakeTripJoinRequestsDataSource dataSource;

    setUp(() => dataSource = FakeTripJoinRequestsDataSource());

    test(
      'lists the pending requests newest first with the trip counts',
      () async {
        final page = await dataSource.getJoinRequests(
          'trip-1',
          status: TripJoinRequestStatus.pending,
          limit: 20,
        );

        expect(page.items.map((r) => r.requester.displayName), [
          'Minh Anh',
          'Đăng Khoa',
          'Thanh Thảo',
        ]);
        expect(page.items.every((r) => r.tripId == 'trip-1'), isTrue);
        expect(page.meta.counts.pending, 3);
        expect(page.meta.counts.approved, 4);
        expect(page.meta.counts.rejected, 1);
        expect(page.meta.hasMore, isFalse);
      },
    );

    test('pages with a cursor', () async {
      final first = await dataSource.getJoinRequests(
        'trip-1',
        status: TripJoinRequestStatus.approved,
        limit: 3,
      );
      final second = await dataSource.getJoinRequests(
        'trip-1',
        status: TripJoinRequestStatus.approved,
        limit: 3,
        cursor: first.meta.nextCursor,
      );

      expect(first.items, hasLength(3));
      expect(first.meta.hasMore, isTrue);
      expect(second.items.single.requester.displayName, 'Hoàng Long');
      expect(second.meta.hasMore, isFalse);
    });

    test('approves a pending request once', () async {
      final approved = await dataSource.approveJoinRequest(
        'trip-1',
        'join-request-minh-anh',
      );
      final page = await dataSource.getJoinRequests(
        'trip-1',
        status: TripJoinRequestStatus.pending,
        limit: 20,
      );

      expect(approved.status, TripJoinRequestStatus.approved);
      expect(approved.decidedAt, fixtureNow);
      expect(page.meta.counts.pending, 2);
      expect(page.meta.counts.approved, 5);
      await expectLater(
        dataSource.rejectJoinRequest('trip-1', 'join-request-minh-anh'),
        throwsA(isA<ApiException>().having((e) => e.statusCode, 'status', 409)),
      );
    });

    test('rejects an unknown request with 404', () {
      expect(
        dataSource.approveJoinRequest('trip-1', 'missing'),
        throwsA(isA<ApiException>().having((e) => e.statusCode, 'status', 404)),
      );
    });

    test('keeps the saved settings', () async {
      final initial = await dataSource.getJoinRequestSettings('trip-1');
      await dataSource.updateJoinRequestSettings(
        'trip-1',
        const TripJoinRequestSettings(autoApproveFriends: false),
      );

      expect(initial.autoApproveFriends, isTrue);
      expect(
        (await dataSource.getJoinRequestSettings('trip-1')).autoApproveFriends,
        isFalse,
      );
    });
  });

  group('TripJoinRequestsRemoteDataSource', () {
    late _RecordingApiClient client;
    late TripJoinRequestsRemoteDataSource dataSource;

    setUp(() {
      client = _RecordingApiClient();
      dataSource = TripJoinRequestsRemoteDataSource(apiClient: client);
    });

    test('lists requests of one status', () async {
      client.response = {
        'data': const [],
        'meta': {
          'nextCursor': null,
          'hasMore': false,
          'counts': {'pending': 0, 'approved': 2, 'rejected': 1},
        },
      };

      final page = await dataSource.getJoinRequests(
        'trip/1',
        status: TripJoinRequestStatus.approved,
        limit: 20,
        cursor: 'c-1',
      );

      expect(client.calls.single, ('GET', '/trips/trip%2F1/join-requests'));
      expect(client.query, {
        'status': 'APPROVED',
        'limit': 20,
        'cursor': 'c-1',
      });
      expect(page.meta.counts.approved, 2);
    });

    test('asks to join with the invite code and the note', () async {
      client.response = {
        'data': {
          ...Map<String, dynamic>.from(
            (tripJoinRequestsDatamock['joinRequests'] as List).first as Map,
          ),
          'status': 'APPROVED',
        },
        'message': 'Joined trip successfully',
      };

      final request = await dataSource.requestToJoin(
        'HE 2025',
        message: 'Cho mình đi với',
      );

      expect(client.calls.single, ('POST', '/trips/join/HE%202025'));
      expect(client.body, {'message': 'Cho mình đi với'});
      expect(request.status, TripJoinRequestStatus.approved);
    });

    test('omits an absent note', () async {
      client.response = {
        'data': Map<String, dynamic>.from(
          (tripJoinRequestsDatamock['joinRequests'] as List).first as Map,
        ),
      };

      await dataSource.requestToJoin('CODE1234');

      expect(client.body, isEmpty);
    });

    test('previews and joins by trip id', () async {
      final preview = Map<String, dynamic>.from(
        tripJoinByCodeDatamock['invitePreview'] as Map,
      );
      client.response = {'data': preview};

      await dataSource.previewByTripId('trip-public');
      expect(client.calls.single, ('GET', '/trips/trip-public/join/preview'));

      client.calls.clear();
      client.response = {
        'data': Map<String, dynamic>.from(
          (tripJoinRequestsDatamock['joinRequests'] as List).first as Map,
        ),
      };
      await dataSource.requestToJoinByTripId('trip-public', message: 'Xin vào');
      expect(client.calls.single, ('POST', '/trips/trip-public/join'));
      expect(client.body, {'message': 'Xin vào'});
    });

    test('sends decisions to the request', () async {
      final request = Map<String, dynamic>.from(
        (tripJoinRequestsDatamock['joinRequests'] as List).first as Map,
      );
      client.response = {
        'data': request,
        'message': 'Join request approved successfully',
      };

      await dataSource.approveJoinRequest('trip-1', 'join-request-minh-anh');
      await dataSource.rejectJoinRequest('trip-1', 'join-request-minh-anh');

      expect(client.calls, [
        ('POST', '/trips/trip-1/join-requests/join-request-minh-anh/approve'),
        ('POST', '/trips/trip-1/join-requests/join-request-minh-anh/reject'),
      ]);
    });

    test('patches the settings', () async {
      client.response = {
        'data': {'autoApproveFriends': false},
        'message': 'Join request settings updated successfully',
      };

      final saved = await dataSource.updateJoinRequestSettings(
        'trip-1',
        const TripJoinRequestSettings(autoApproveFriends: false),
      );

      expect(client.calls.single, (
        'PATCH',
        '/trips/trip-1/join-requests/settings',
      ));
      expect(client.body, {'autoApproveFriends': false});
      expect(saved.autoApproveFriends, isFalse);
    });

    test('rejects a malformed list response', () {
      client.response = {'data': null};

      expect(
        dataSource.getJoinRequests(
          'trip-1',
          status: TripJoinRequestStatus.pending,
          limit: 20,
        ),
        throwsFormatException,
      );
    });
  });

  group('TripJoinRequestsRepository', () {
    late FakeTripJoinRequestsDataSource dataSource;
    late TripJoinRequestsRepository repository;

    setUp(() {
      dataSource = FakeTripJoinRequestsDataSource();
      repository = TripJoinRequestsRepository(dataSource: dataSource);
    });

    test('only applies a decision', () {
      expect(
        () => repository.decide('trip-1', 'id', TripJoinRequestStatus.pending),
        throwsArgumentError,
      );
    });

    test('trims the invite code and drops a blank note', () async {
      final request = await repository.requestToJoin(
        '  CODE1234 ',
        message: '   ',
      );

      expect(dataSource.joinCodes.single, 'CODE1234');
      expect(request.status, TripJoinRequestStatus.pending);
      expect(request.message, isNull);
    });

    test('refuses what the backend would reject', () {
      expect(() => repository.requestToJoin('  '), throwsArgumentError);
      expect(
        () => repository.requestToJoin('CODE1234', message: 'a' * 501),
        throwsArgumentError,
      );
      expect(dataSource.joinCodes, isEmpty);
    });

    test('requestToJoinByTripId rejects blank trip id and long message', () {
      expect(() => repository.requestToJoinByTripId('  '), throwsArgumentError);
      expect(
        () => repository.requestToJoinByTripId('trip-1', message: 'a' * 501),
        throwsArgumentError,
      );
    });
  });

  group('TripJoinRequestsHeader', () {
    TripJoinRequestsHeader header({
      String? role = 'OWNER',
      int maxMembers = 6,
      String status = 'UPCOMING',
    }) => buildTripJoinRequestsHeader(
      TripDetailOverview.fromJson(
        joinRequestsTripJson(
          role: role,
          maxMembers: maxMembers,
          status: status,
        ),
      ),
    );

    test('counts the free seats', () {
      final open = header(maxMembers: 6);

      expect(open.memberCount, 4);
      expect(open.remainingSlots, 2);
      expect(open.fillRatio, closeTo(4 / 6, 1e-9));
      expect(open.canApprove, isTrue);
    });

    test('blocks approving for the right reason', () {
      expect(header(maxMembers: 4).approvalBlock, TripJoinApprovalBlock.full);
      expect(
        header(status: 'COMPLETED').approvalBlock,
        TripJoinApprovalBlock.closed,
      );
      expect(
        header(status: 'ONGOING').approvalBlock,
        TripJoinApprovalBlock.closed,
      );
      expect(
        header(role: 'MEMBER').approvalBlock,
        TripJoinApprovalBlock.notReviewer,
      );
      expect(header(role: 'ADMIN').canApprove, isTrue);
    });

    test('warns when one seat or none is left', () {
      expect(joinRequestQuotaWarning(header(maxMembers: 6)), isNull);
      expect(
        joinRequestQuotaWarning(header(maxMembers: 5)),
        startsWith('Chuyến đi chỉ còn đúng 1 vị trí trống.'),
      );
      expect(
        joinRequestQuotaWarning(header(maxMembers: 4)),
        startsWith('Nhóm đã đủ quân số (4/4).'),
      );
      expect(joinRequestQuotaWarning(header(role: 'MEMBER')), isNull);
    });
  });

  test('formats the age of a request', () {
    final now = DateTime.utc(2025, 7, 10, 8);
    String age(Duration ago) =>
        formatJoinRequestAge(now.subtract(ago), now: now);

    expect(age(const Duration(seconds: 20)), 'Vừa xong');
    expect(age(const Duration(minutes: 15)), '15 phút trước');
    expect(age(const Duration(hours: 1)), '1 giờ trước');
    expect(age(const Duration(hours: 30)), 'Hôm qua');
    expect(age(const Duration(days: 3)), '3 ngày trước');
    expect(age(const Duration(days: 9)), '01/07/2025');
  });
}

class _RecordingApiClient extends ApiClient {
  _RecordingApiClient()
    : super(tokenStorage: TokenStorage(), onSessionExpired: () {});

  Map<String, dynamic> response = const {};
  final calls = <(String, String)>[];
  Map<String, dynamic>? query;
  Object? body;

  @override
  Future<T> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    bool requiresAuth = true,
  }) async {
    calls.add(('GET', path));
    query = queryParameters;
    return response as T;
  }

  @override
  Future<T> post<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    bool requiresAuth = true,
  }) async {
    calls.add(('POST', path));
    body = data;
    return response as T;
  }

  @override
  Future<T> patch<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    bool requiresAuth = true,
  }) async {
    calls.add(('PATCH', path));
    body = data;
    return response as T;
  }
}
