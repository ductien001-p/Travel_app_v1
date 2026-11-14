import 'package:flutter_test/flutter_test.dart';
import 'package:travel_frontend_v1/core/networks/api_client.dart';
import 'package:travel_frontend_v1/core/storage/token_storage.dart';
import 'package:travel_frontend_v1/features/trips/trip-timeline/data/datasources/trip_timeline_remote_datasource.dart';
import 'package:travel_frontend_v1/features/trips/trip-timeline/data/models/trip_timeline_models.dart';

import 'trip_timeline_fixture.dart';

void main() {
  group('TripTimelinePage', () {
    test('parses the datamock page including metadata and counts', () {
      final page = TripTimelinePage.fromJson(timelineDatamockPage());

      expect(page.items, hasLength(9));
      expect(page.meta.hasMore, isFalse);
      expect(page.meta.counts?.all, 9);
      expect(page.meta.counts?.checkin, 2);

      final memory = page.items.first;
      expect(memory.type, TripTimelineEntryType.memoryAdded);
      expect(memory.member.user.name, 'Quốc Bảo');
      expect(memory.targetType, TripTimelineTargetType.memory);
      expect(memory.metadata?.photoUrls, hasLength(5));
      expect(memory.metadata?.photoCount, 5);

      final update = page.items.firstWhere(
        (entry) => entry.type == TripTimelineEntryType.activityUpdated,
      );
      expect(
        update.metadata?.previousStartTime,
        DateTime.utc(2025, 7, 21, 11, 30),
      );
    });

    test('reads money sent as a base-10 string', () {
      final page = TripTimelinePage.fromJson(timelineDatamockPage());
      final expense = page.items.firstWhere(
        (entry) => entry.type == TripTimelineEntryType.expenseCreated,
      );

      expect(expense.metadata?.amount, 1200000);
      expect(expense.metadata?.splitType, TripTimelineSplitType.equal);
      expect(
        TripTimelineEntryMetadata.fromJson({'amount': 'abc'}).amount,
        isNull,
      );
      expect(TripTimelineEntryMetadata.fromJson({'amount': 12.5}).amount, 12.5);
    });

    test('parses a legacy event without metadata or target', () {
      final page = TripTimelinePage.fromJson(
        timelinePageJson([
          timelineEventJson(id: 'e-1', type: 'MEMBER_JOINED'),
        ], nextCursor: 'e-1'),
      );

      final entry = page.items.single;
      expect(entry.metadata, isNull);
      expect(entry.targetId, isNull);
      expect(entry.member.user.avatarUrl, isNull);
      expect(page.meta.counts, isNull);
      expect(page.meta.nextCursor, 'e-1');
      expect(page.meta.hasMore, isTrue);
    });

    test('maps unknown enum values safely', () {
      final page = TripTimelinePage.fromJson(
        timelinePageJson([
          timelineEventJson(
            id: 'e-1',
            type: 'NEW_TYPE',
            targetType: 'NEW_TARGET',
            metadata: {'via': 'QR_CODE', 'splitType': 'PERCENT'},
          ),
        ]),
      );

      final entry = page.items.single;
      expect(entry.type, TripTimelineEntryType.system);
      expect(entry.targetType, isNull);
      expect(entry.metadata?.via, isNull);
      expect(entry.metadata?.splitType, isNull);
    });

    test('falls back to the username when the display name is blank', () {
      final user = TripTimelineEntryUser.fromJson({
        'id': 'u-1',
        'username': 'alex',
        'displayName': '  ',
      });

      expect(user.name, 'alex');
    });
  });

  group('TripTimelineRemoteDataSource', () {
    late _RecordingApiClient apiClient;
    late TripTimelineRemoteDataSource dataSource;

    setUp(() {
      apiClient = _RecordingApiClient();
      dataSource = TripTimelineRemoteDataSource(apiClient: apiClient);
    });

    test(
      'reads GET /trips/timeline/{tripId} with limit, cursor and category',
      () async {
        apiClient.response = timelinePageJson([timelineEventJson(id: 'e-2')]);

        final page = await dataSource.getTripTimeline(
          'trip/1',
          limit: 30,
          cursor: 'e-1',
          category: 'expense',
        );

        expect(apiClient.path, '/trips/timeline/trip%2F1');
        expect(apiClient.query, {
          'limit': 30,
          'cursor': 'e-1',
          'category': 'expense',
        });
        expect(page.items.single.id, 'e-2');
      },
    );

    test('omits the cursor and category when not set', () async {
      apiClient.response = timelinePageJson([]);

      await dataSource.getTripTimeline('trip-1', limit: 30);

      expect(apiClient.query, {'limit': 30});
    });

    test('rejects a response without data or meta', () async {
      apiClient.response = {'message': 'oops'};

      await expectLater(
        dataSource.getTripTimeline('trip-1', limit: 30),
        throwsA(isA<FormatException>()),
      );
    });
  });
}

class _RecordingApiClient extends ApiClient {
  _RecordingApiClient()
    : super(tokenStorage: TokenStorage(), onSessionExpired: () {});

  Map<String, dynamic> response = const {};
  String? path;
  Map<String, dynamic>? query;

  @override
  Future<T> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    bool requiresAuth = true,
  }) async {
    this.path = path;
    query = queryParameters;
    return response as T;
  }
}
