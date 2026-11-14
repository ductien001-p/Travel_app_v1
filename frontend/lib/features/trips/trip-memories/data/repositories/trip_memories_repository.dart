import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travel_frontend_v1/features/media/data/models/media_upload_folder.dart';
import 'package:travel_frontend_v1/features/media/data/repository/media_upload_repository.dart';

import '../datasources/trip_memories_remote_datasource.dart';
import '../models/trip_memory_models.dart';

class TripMemoriesRepository {
  const TripMemoriesRepository({
    required TripMemoriesRemoteDataSource remoteDataSource,
    required MediaUploadRepository mediaUploadRepository,
  }) : _remote = remoteDataSource,
       _media = mediaUploadRepository;

  /// Backend accepts 1..50; 20 is its default page size.
  static const pageSize = 20;

  /// Photos posted in one go, so they land in one timeline event.
  static const maxPhotosPerPost = TripMemoriesRemoteDataSource.maxBatchSize;

  final TripMemoriesRemoteDataSource _remote;
  final MediaUploadRepository _media;

  Future<TripMemoriesPage> getMemories(
    String tripId, {
    String? cursor,
    int? day,
    String? uploaderId,
  }) => _remote.getMemories(
    tripId,
    limit: pageSize,
    cursor: cursor,
    day: day,
    uploaderId: uploaderId,
  );

  /// Uploads [photos] to storage, then adds them to the trip album.
  Future<List<TripMemoryEntry>> postPhotos(
    String tripId,
    List<XFile> photos, {
    MediaUploadProgressCallback? onProgress,
    CancelToken? cancelToken,
  }) async {
    if (photos.isEmpty) return const [];
    if (photos.length > maxPhotosPerPost) {
      throw ArgumentError.value(
        photos.length,
        'photos',
        'At most $maxPhotosPerPost photos per post',
      );
    }
    final uploaded = await _media.uploadFiles(
      folder: MediaUploadFolder.trips,
      files: photos,
      onProgress: onProgress,
      cancelToken: cancelToken,
    );
    return _remote.createTripMemories(tripId, [
      for (final media in uploaded) NewTripMemory(mediaId: media.id),
    ]);
  }

  /// Updates the caption of a memory the viewer uploaded.
  ///
  /// Pass an empty or whitespace-only [caption] to clear it (`null` on the API).
  Future<TripMemoryEntry> updateMemory(
    String memoryId, {
    required String? caption,
  }) {
    final trimmed = caption?.trim();
    return _remote.updateMemory(
      memoryId,
      caption: trimmed == null || trimmed.isEmpty ? null : trimmed,
    );
  }

  Future<void> deleteMemory(String memoryId) => _remote.deleteMemory(memoryId);
}
