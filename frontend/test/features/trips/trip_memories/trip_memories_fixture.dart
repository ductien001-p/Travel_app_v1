import 'dart:async';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travel_frontend_v1/features/media/data/datasource/media_remote_datasource.dart';
import 'package:travel_frontend_v1/features/media/data/datasource/r2_upload_datasource.dart';
import 'package:travel_frontend_v1/features/media/data/models/media_upload_folder.dart';
import 'package:travel_frontend_v1/features/media/data/models/media_upload_progress.dart';
import 'package:travel_frontend_v1/features/media/data/models/uploaded_media.dart';
import 'package:travel_frontend_v1/features/media/data/repository/media_upload_repository.dart';
import 'package:travel_frontend_v1/features/trips/trip-memories/data/datamock/trip_memories_datamock.dart';
import 'package:travel_frontend_v1/features/trips/trip-memories/data/datasources/trip_memories_remote_datasource.dart';
import 'package:travel_frontend_v1/features/trips/trip-memories/data/models/trip_memory_models.dart';

import '../trip_details/trip_detail_fixture.dart';

/// A device on UTC, so expectations do not depend on the test machine.
DateTime utcWallClock(DateTime instant) => instant.toUtc();

Map<String, dynamic> memoriesDatamockPage() =>
    _deepCopy(tripMemoriesDatamock['tripMemoriesPage'] as Map<String, dynamic>);

Map<String, dynamic> memoriesBatchResponse() => _deepCopy(
  tripMemoriesDatamock['tripMemoriesBatchResponse'] as Map<String, dynamic>,
);

Map<String, dynamic> _deepCopy(Map<String, dynamic> json) => {
  for (final MapEntry(:key, :value) in json.entries)
    key: switch (value) {
      Map() => _deepCopy(Map<String, dynamic>.from(value)),
      List() => [
        for (final item in value)
          item is Map ? _deepCopy(Map<String, dynamic>.from(item)) : item,
      ],
      _ => value,
    },
};

/// The trip of `tripDetailJson()` with the photo counts of the datamock.
Map<String, dynamic> memoriesTripDetailJson({
  String role = 'OWNER',
  String status = 'ONGOING',
}) {
  const counts = {
    'user-alex': 3,
    'user-trang': 3,
    'user-bao': 2,
    'user-phuong': 1,
  };
  final json = tripDetailJson();
  return {
    ...json,
    'status': status,
    'viewer': {'userId': 'user-alex', 'role': role},
    'members': [
      for (final member in json['members'] as List)
        {
          ...member as Map<String, dynamic>,
          'memoryCount': counts[member['userId']] ?? 0,
        },
    ],
    'memories': {'totalCount': 10, 'items': const []},
  };
}

Map<String, dynamic> memoryJson({
  required String id,
  String createdAt = '2025-07-15T03:00:00.000Z',
  String? userId = 'user-alex',
  String? caption,
  String? badge,
}) => {
  'id': id,
  'tripId': 'trip-1',
  'caption': caption,
  'createdAt': createdAt,
  'imageUrl': 'https://cdn.test/memories/$id.jpg',
  'badge': badge,
  'user': userId == null
      ? null
      : {'id': userId, 'username': userId.substring(5), 'avatarId': null},
  'media': {'id': 'media-$id', 'mimeType': 'image/jpeg'},
};

Map<String, dynamic> memoriesPageJson(
  List<Map<String, dynamic>> memories, {
  String? nextCursor,
  int? totalCount,
  Map<int, int>? dayCounts,
}) => {
  'data': memories,
  'meta': {
    'nextCursor': nextCursor,
    'hasMore': nextCursor != null,
    'totalCount': totalCount,
    'dayCounts': dayCounts == null
        ? null
        : [
            for (final MapEntry(:key, :value) in dayCounts.entries)
              {'day': key, 'count': value},
          ],
  },
};

typedef MemoriesRequest = ({int? day, String? uploaderId, String? cursor});

const MemoriesRequest firstPage = (day: null, uploaderId: null, cursor: null);

/// Serves pages keyed by filters and cursor. A value that is not a map is
/// thrown instead of returned.
class FakeTripMemoriesDataSource extends TripMemoriesRemoteDataSource {
  FakeTripMemoriesDataSource(this.pages) : super(apiClient: unusedApiClient());

  final Map<MemoriesRequest, Object> pages;
  final requests = <MemoriesRequest>[];
  final created = <List<NewTripMemory>>[];
  final deleted = <String>[];
  final updated = <({String memoryId, String? caption})>[];
  Object? deleteError;
  Object? updateError;

  @override
  Future<TripMemoriesPage> getMemories(
    String tripId, {
    required int limit,
    String? cursor,
    int? day,
    String? uploaderId,
  }) async {
    final request = (day: day, uploaderId: uploaderId, cursor: cursor);
    requests.add(request);
    final result = pages[request];
    if (result is Map<String, dynamic>) {
      return TripMemoriesPage.fromJson(result);
    }
    throw result ?? StateError('No page for $request');
  }

  @override
  Future<List<TripMemoryEntry>> createTripMemories(
    String tripId,
    List<NewTripMemory> items,
  ) async {
    created.add(items);
    return [
      for (final item in items)
        TripMemoryEntry.fromJson(memoryJson(id: 'new-${item.mediaId}')),
    ];
  }

  @override
  Future<TripMemoryEntry> updateMemory(
    String memoryId, {
    required String? caption,
  }) async {
    updated.add((memoryId: memoryId, caption: caption));
    final error = updateError;
    if (error != null) throw error;
    return TripMemoryEntry.fromJson(memoryJson(id: memoryId, caption: caption));
  }

  @override
  Future<void> deleteMemory(String memoryId) async {
    deleted.add(memoryId);
    final error = deleteError;
    if (error != null) throw error;
  }
}

/// Skips presign and R2: reports half then full progress, then returns one
/// uploaded media per file. [gate] holds the upload at 50% until completed.
class FakeMediaUploadRepository extends MediaUploadRepository {
  FakeMediaUploadRepository({this.gate, this.error})
    : super(
        remoteDataSource: MediaRemoteDataSource(apiClient: unusedApiClient()),
        r2UploadDataSource: R2UploadDataSource(dio: Dio()),
      );

  final Completer<void>? gate;
  final Object? error;
  final uploads = <({MediaUploadFolder folder, int fileCount})>[];

  @override
  Future<List<UploadedMedia>> uploadFiles({
    required MediaUploadFolder folder,
    required List<XFile> files,
    int maxConcurrentUploads = 3,
    CancelToken? cancelToken,
    MediaUploadProgressCallback? onProgress,
  }) async {
    uploads.add((folder: folder, fileCount: files.length));
    onProgress?.call(_progress(50));
    await gate?.future;
    final error = this.error;
    if (error != null) throw error;
    onProgress?.call(_progress(100));
    return [
      for (var i = 0; i < files.length; i++)
        UploadedMedia(
          id: 'upload-$i',
          objectKey: 'trips/upload-$i.jpg',
          mimeType: 'image/jpeg',
          fileSize: 4,
        ),
    ];
  }

  static MediaUploadProgress _progress(int sent) => MediaUploadProgress(
    fileIndex: 0,
    fileSentBytes: sent,
    fileTotalBytes: 100,
    totalSentBytes: sent,
    totalBytes: 100,
  );
}

List<XFile> fakePhotos(int count) => [
  for (var i = 0; i < count; i++)
    XFile.fromData(
      Uint8List.fromList(const [1, 2, 3, 4]),
      name: 'photo-$i.jpg',
      mimeType: 'image/jpeg',
    ),
];
