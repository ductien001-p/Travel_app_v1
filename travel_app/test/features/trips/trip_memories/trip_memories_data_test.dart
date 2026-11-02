import 'package:flutter_test/flutter_test.dart';
import 'package:travel_frontend_v1/core/networks/api_client.dart';
import 'package:travel_frontend_v1/core/storage/token_storage.dart';
import 'package:travel_frontend_v1/features/media/data/models/media_upload_folder.dart';
import 'package:travel_frontend_v1/features/trips/trip-memories/data/datasources/trip_memories_remote_datasource.dart';
import 'package:travel_frontend_v1/features/trips/trip-memories/data/models/trip_memory_models.dart';
import 'package:travel_frontend_v1/features/trips/trip-memories/data/repositories/trip_memories_repository.dart';

import 'trip_memories_fixture.dart';

void main() {
  group('TripMemoriesPage', () {
    test('parses the datamock page with the totals and badges', () {
      final page = TripMemoriesPage.fromJson(memoriesDatamockPage());

      expect(page.items, hasLength(10));
      expect(page.meta.hasMore, isFalse);
      expect(page.meta.totalCount, 10);
      expect(page.meta.dayCounts?.map((c) => (c.day, c.count)), [
        (1, 5),
        (4, 5),
      ]);

      final first = page.items.first;
      expect(first.badge, 'Khoảnh khắc đêm');
      expect(first.user?.username, 'minhtrang');
      expect(first.media.width, 1600);
      expect(first.createdAt, DateTime.utc(2025, 7, 18, 13, 15));
    });

    test('lists the datamock newest first, like the backend', () {
      final items = TripMemoriesPage.fromJson(memoriesDatamockPage()).items;

      for (var i = 1; i < items.length; i++) {
        expect(
          items[i - 1].createdAt.isAfter(items[i].createdAt),
          isTrue,
          reason: '${items[i - 1].id} before ${items[i].id}',
        );
      }
    });

    test('uses only the badge labels the backend sends', () {
      final badges = TripMemoriesPage.fromJson(
        memoriesDatamockPage(),
      ).items.map((item) => item.badge).whereType<String>().toSet();

      expect(
        badges.difference(const {
          'Khoảnh khắc đêm',
          'Khoảnh khắc nổi bật',
          'Khoảnh khắc đáng nhớ',
          'Khoảnh khắc ẩm thực',
        }),
        isEmpty,
      );
    });

    test('parses a later page, which has no totals', () {
      final page = TripMemoriesPage.fromJson({
        'data': [
          {
            'id': 'm-1',
            'tripId': 'trip-1',
            'caption': null,
            'createdAt': '2025-07-15T03:00:00.000Z',
            'imageUrl': 'https://cdn.test/m-1.jpg',
            'user': null,
            'media': {
              'id': 'media-1',
              'objectKey': 'trips/m-1.jpg',
              'userId': null,
              'mimeType': 'image/png',
              'createdAt': '2025-07-15T03:00:00.000Z',
            },
          },
        ],
        'meta': {
          'nextCursor': 'm-1',
          'hasMore': true,
          'totalCount': null,
          'dayCounts': null,
        },
      });

      final memory = page.items.single;
      expect(memory.user, isNull);
      expect(memory.badge, isNull);
      expect(memory.media.mimeType, 'image/png');
      expect(page.meta.totalCount, isNull);
      expect(page.meta.dayCounts, isNull);
      expect(page.meta.nextCursor, 'm-1');
    });

    test('omits an empty caption from a new memory', () {
      expect(const NewTripMemory(mediaId: 'media-1').toJson(), {
        'mediaId': 'media-1',
      });
      expect(const NewTripMemory(mediaId: 'media-1', caption: 'Hi').toJson(), {
        'mediaId': 'media-1',
        'caption': 'Hi',
      });
    });
  });

  group('TripMemoriesRemoteDataSource', () {
    late _RecordingApiClient apiClient;
    late TripMemoriesRemoteDataSource dataSource;

    setUp(() {
      apiClient = _RecordingApiClient();
      dataSource = TripMemoriesRemoteDataSource(apiClient: apiClient);
    });

    test(
      'reads GET /trips/memories/{tripId} with only the limit by default',
      () async {
        apiClient.response = memoriesPageJson([memoryJson(id: 'm-1')]);

        final page = await dataSource.getMemories('trip/1', limit: 20);

        expect(apiClient.calls.single, ('GET', '/trips/memories/trip%2F1'));
        expect(apiClient.query, {'limit': 20});
        expect(page.items.single.id, 'm-1');
      },
    );

    test('sends the cursor and the day / user filters when set', () async {
      apiClient.response = memoriesPageJson([]);

      await dataSource.getMemories(
        'trip-1',
        limit: 20,
        cursor: 'm-9',
        day: 2,
        uploaderId: 'user-bao',
      );

      expect(apiClient.query, {
        'limit': 20,
        'cursor': 'm-9',
        'day': 2,
        'userId': 'user-bao',
      });
    });

    test('rejects a page without data or meta', () async {
      apiClient.response = {'message': 'oops'};

      await expectLater(
        dataSource.getMemories('trip-1', limit: 20),
        throwsA(isA<FormatException>()),
      );
    });

    test('posts photos to the batch endpoint', () async {
      apiClient.response = memoriesBatchResponse();

      final created = await dataSource.createTripMemories('trip-1', const [
        NewTripMemory(mediaId: 'media-1'),
        NewTripMemory(mediaId: 'media-2', caption: 'Biển'),
      ]);

      expect(apiClient.calls.single, ('POST', '/trips/memories/trip-1/batch'));
      expect(apiClient.body, {
        'items': [
          {'mediaId': 'media-1'},
          {'mediaId': 'media-2', 'caption': 'Biển'},
        ],
      });
      expect(created.single.id, 'memory-new-1');
      expect(created.single.badge, isNull);
    });

    test('deletes through DELETE /trips/memories/{memoryId}', () async {
      apiClient.response = {
        'success': true,
        'message': 'Memory deleted successfully',
      };

      await dataSource.deleteMemory('m-1');

      expect(apiClient.calls.single, ('DELETE', '/trips/memories/m-1'));
    });

    test('patches caption through PATCH /trips/memories/{memoryId}', () async {
      apiClient.response = {
        'data': memoryJson(id: 'm-1', caption: 'Hoàng hôn'),
        'message': 'Memory updated successfully',
      };

      final updated = await dataSource.updateMemory(
        'm-1',
        caption: 'Hoàng hôn',
      );

      expect(apiClient.calls.single, ('PATCH', '/trips/memories/m-1'));
      expect(apiClient.body, {'caption': 'Hoàng hôn'});
      expect(updated.caption, 'Hoàng hôn');
    });
  });

  group('TripMemoriesRepository.postPhotos', () {
    test('uploads to the trips folder, then adds the uploaded media', () async {
      final media = FakeMediaUploadRepository();
      final remote = FakeTripMemoriesDataSource({});
      final repository = TripMemoriesRepository(
        remoteDataSource: remote,
        mediaUploadRepository: media,
      );

      final created = await repository.postPhotos('trip-1', fakePhotos(2));

      expect(media.uploads.single, (
        folder: MediaUploadFolder.trips,
        fileCount: 2,
      ));
      expect(remote.created.single.map((item) => item.mediaId), [
        'upload-0',
        'upload-1',
      ]);
      expect(created, hasLength(2));
    });

    test('refuses more photos than one batch accepts', () async {
      final media = FakeMediaUploadRepository();
      final repository = TripMemoriesRepository(
        remoteDataSource: FakeTripMemoriesDataSource({}),
        mediaUploadRepository: media,
      );

      await expectLater(
        repository.postPhotos(
          'trip-1',
          fakePhotos(TripMemoriesRepository.maxPhotosPerPost + 1),
        ),
        throwsArgumentError,
      );
      expect(media.uploads, isEmpty);
    });
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

  @override
  Future<T> delete<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    bool requiresAuth = true,
  }) async {
    calls.add(('DELETE', path));
    return response as T;
  }
}
