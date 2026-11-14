import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../trip-details/application/trip_detail_overview_controller.dart';
import '../data/models/trip_memory_models.dart';
import '../provider/trip_memories_provider.dart';
import 'trip_memories_controller.dart';

/// Mutation running on the album; at most one at a time.
class TripMemoriesActionState {
  const TripMemoriesActionState({
    this.uploadProgress,
    this.deletingId,
    this.updatingId,
  });

  /// 0..1 while photos are being posted.
  final double? uploadProgress;
  final String? deletingId;
  final String? updatingId;

  bool get isUploading => uploadProgress != null;

  bool get isBusy => isUploading || deletingId != null || updatingId != null;
}

final tripMemoriesActionControllerProvider = NotifierProvider.autoDispose
    .family<TripMemoriesActionController, TripMemoriesActionState, String>(
      TripMemoriesActionController.new,
    );

class TripMemoriesActionController extends Notifier<TripMemoriesActionState> {
  TripMemoriesActionController(this.tripId);

  final String tripId;
  CancelToken? _uploadCancelToken;

  @override
  TripMemoriesActionState build() {
    ref.onDispose(() => _uploadCancelToken?.cancel('Album closed.'));
    return const TripMemoriesActionState();
  }

  /// Uploads [photos] and adds them to the album; returns how many were added.
  Future<int> postPhotos(List<XFile> photos) async {
    _ensureIdle();
    if (photos.isEmpty) return 0;
    final cancelToken = _uploadCancelToken = CancelToken();
    state = const TripMemoriesActionState(uploadProgress: 0);
    try {
      final created = await ref
          .read(tripMemoriesRepositoryProvider)
          .postPhotos(
            tripId,
            photos,
            cancelToken: cancelToken,
            onProgress: (progress) {
              if (!ref.mounted) return;
              state = TripMemoriesActionState(
                uploadProgress: progress.overallProgress,
              );
            },
          );
      if (ref.mounted) {
        _invalidateTripCounts();
        await _reloadAlbum();
      }
      return created.length;
    } finally {
      _uploadCancelToken = null;
      if (ref.mounted) state = const TripMemoriesActionState();
    }
  }

  /// [day] is the trip day of the memory, to keep the day counts right.
  Future<void> delete(String memoryId, {int? day}) async {
    _ensureIdle();
    state = TripMemoriesActionState(deletingId: memoryId);
    try {
      await ref.read(tripMemoriesRepositoryProvider).deleteMemory(memoryId);
      if (!ref.mounted) return;
      ref
          .read(tripMemoriesControllerProvider(tripId).notifier)
          .removeLocally(memoryId, day: day);
      _invalidateTripCounts();
    } finally {
      if (ref.mounted) state = const TripMemoriesActionState();
    }
  }

  /// Updates caption via `PATCH /trips/memories/{id}`; returns the saved entry.
  Future<TripMemoryEntry> updateCaption(
    String memoryId, {
    required String? caption,
  }) async {
    _ensureIdle();
    state = TripMemoriesActionState(updatingId: memoryId);
    try {
      final updated = await ref
          .read(tripMemoriesRepositoryProvider)
          .updateMemory(memoryId, caption: caption);
      if (ref.mounted) {
        ref
            .read(tripMemoriesControllerProvider(tripId).notifier)
            .replaceLocally(updated);
      }
      return updated;
    } finally {
      if (ref.mounted) state = const TripMemoriesActionState();
    }
  }

  void _ensureIdle() {
    if (state.isBusy) {
      throw StateError('An album operation is already in progress.');
    }
  }

  /// Member photo counts and the album total come from `GET /trips/{id}`.
  void _invalidateTripCounts() =>
      ref.invalidate(tripDetailOverviewControllerProvider(tripId));

  /// New photos are the newest, so they are on the first page.
  Future<void> _reloadAlbum() async {
    try {
      await ref.read(tripMemoriesControllerProvider(tripId).notifier).refresh();
    } catch (_) {
      // The photos were added; the current list stays and pull-to-refresh
      // can reload it.
    }
  }
}
