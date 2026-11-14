import 'package:dio/dio.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travel_frontend_v1/features/media/application/media_upload_status.dart';

import '../data/models/media_upload_folder.dart';
import '../data/models/uploaded_media.dart';

import '../providers/media_providers.dart';

final mediaUploadControllerProvider =
    NotifierProvider<MediaUploadController, MediaUploadState>(
      MediaUploadController.new,
    );

class MediaUploadController extends Notifier<MediaUploadState> {
  CancelToken? _cancelToken;

  @override
  MediaUploadState build() {
    ref.onDispose(() {
      _cancelToken?.cancel('Controller disposed.');
    });

    return const MediaUploadState();
  }

  Future<List<UploadedMedia>> upload({
    required MediaUploadFolder folder,

    required List<XFile> files,

    int maxConcurrentUploads = 3,
  }) async {
    if (state.isUploading) {
      throw StateError('Upload already running.');
    }

    if (files.isEmpty) {
      return const [];
    }

    _cancelToken = CancelToken();

    state = const MediaUploadState(
      status: MediaUploadStatus.uploading,

      progress: 0,
    );

    try {
      final result = await ref
          .read(mediaUploadRepositoryProvider)
          .uploadFiles(
            folder: folder,

            files: files,

            maxConcurrentUploads: maxConcurrentUploads,

            cancelToken: _cancelToken,

            onProgress: (progress) {
              state = state.copyWith(
                status: MediaUploadStatus.uploading,

                progress: progress.overallProgress,

                clearError: true,
              );
            },
          );

      state = MediaUploadState(
        status: MediaUploadStatus.success,

        progress: 1,

        uploadedMedia: result,
      );

      return result;
    } catch (error) {
      final cancelled = _cancelToken?.isCancelled == true;

      state = MediaUploadState(
        status: cancelled
            ? MediaUploadStatus.cancelled
            : MediaUploadStatus.failure,

        progress: state.progress,

        errorMessage: error.toString(),
      );

      rethrow;
    } finally {
      _cancelToken = null;
    }
  }

  Future<String> getMediaUrl(String mediaId) async {
    return await ref.read(mediaUploadRepositoryProvider).getMediaUrl(mediaId);
  }

  Future<String> getOwnMediaUrl(String mediaId) async {
    return await ref
        .read(mediaUploadRepositoryProvider)
        .getOwnMediaUrl(mediaId);
  }

  void cancel() {
    if (!state.isUploading) {
      return;
    }

    _cancelToken?.cancel('Cancelled by user.');

    state = state.copyWith(status: MediaUploadStatus.cancelled);
  }

  void reset() {
    if (state.isUploading) {
      return;
    }

    state = const MediaUploadState();
  }
}
