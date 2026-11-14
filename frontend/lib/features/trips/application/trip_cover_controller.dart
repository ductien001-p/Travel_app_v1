import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';

import '../../media/data/models/media_upload_folder.dart';
import '../../media/data/models/uploaded_media.dart';
import '../../media/providers/media_providers.dart';

final tripCoverControllerProvider =
    NotifierProvider.autoDispose<TripCoverController, TripCoverState>(
      TripCoverController.new,
    );

enum TripCoverStatus { empty, uploading, uploaded, failed }

class TripCoverState {
  const TripCoverState({
    this.status = TripCoverStatus.empty,
    this.file,
    this.previewBytes,
    this.media,
    this.progress = 0,
    this.errorMessage,
  });

  final TripCoverStatus status;
  final XFile? file;
  final Uint8List? previewBytes;
  final UploadedMedia? media;
  final double progress;
  final String? errorMessage;

  bool get isUploading => status == TripCoverStatus.uploading;

  /// Only set once the backend has registered the upload, so it is safe to
  /// send as `coverMediaId`.
  String? get mediaId => status == TripCoverStatus.uploaded ? media?.id : null;

  TripCoverState copyWith({double? progress}) => TripCoverState(
    status: status,
    file: file,
    previewBytes: previewBytes,
    media: media,
    progress: progress ?? this.progress,
    errorMessage: errorMessage,
  );
}

/// Rejected before upload; the current cover is left untouched.
class TripCoverException implements Exception {
  const TripCoverException(this.message);

  final String message;

  @override
  String toString() => message;
}

class TripCoverController extends Notifier<TripCoverState> {
  static const maxFileBytes = 10 * 1024 * 1024;

  /// Must stay in sync with `PRESIGN_IMAGE_CONTENT_TYPES` on the backend.
  static const allowedMimeTypes = {
    'image/jpeg',
    'image/jpg',
    'image/png',
    'image/gif',
    'image/webp',
  };

  CancelToken? _cancelToken;

  @override
  TripCoverState build() {
    ref.onDispose(() => _cancelToken?.cancel('Trip cover disposed.'));
    return const TripCoverState();
  }

  /// Validates [file] and uploads it, replacing any current cover.
  ///
  /// Throws [TripCoverException] when the file is not an acceptable image.
  Future<void> select(XFile file) async {
    await _validate(file);
    final previewBytes = await _readBytes(file);
    if (!ref.mounted) return;
    await _upload(file, previewBytes);
  }

  Future<void> retry() async {
    final file = state.file;
    final previewBytes = state.previewBytes;
    if (state.status != TripCoverStatus.failed ||
        file == null ||
        previewBytes == null) {
      return;
    }
    await _upload(file, previewBytes);
  }

  void clear() {
    _cancelToken?.cancel('Trip cover removed.');
    _cancelToken = null;
    state = const TripCoverState();
  }

  Future<void> _validate(XFile file) async {
    final mimeType = file.mimeType ?? lookupMimeType(file.name);
    if (mimeType == null || !allowedMimeTypes.contains(mimeType)) {
      throw const TripCoverException(
        'Ảnh bìa chỉ hỗ trợ định dạng JPG, PNG, WEBP hoặc GIF.',
      );
    }
    final size = await file.length();
    if (size <= 0) {
      throw const TripCoverException('Ảnh đã chọn bị lỗi hoặc trống.');
    }
    if (size > maxFileBytes) {
      throw const TripCoverException('Ảnh bìa tối đa 10MB.');
    }
  }

  Future<Uint8List> _readBytes(XFile file) async {
    try {
      return await file.readAsBytes();
    } catch (_) {
      throw const TripCoverException('Không thể đọc ảnh đã chọn.');
    }
  }

  Future<void> _upload(XFile file, Uint8List previewBytes) async {
    _cancelToken?.cancel('Replaced by a newer cover.');
    final cancelToken = _cancelToken = CancelToken();
    state = TripCoverState(
      status: TripCoverStatus.uploading,
      file: file,
      previewBytes: previewBytes,
    );
    try {
      final uploaded = await ref
          .read(mediaUploadRepositoryProvider)
          .uploadFiles(
            folder: MediaUploadFolder.trips,
            files: [file],
            maxConcurrentUploads: 1,
            cancelToken: cancelToken,
            onProgress: (progress) {
              if (!_isCurrent(cancelToken)) return;
              state = state.copyWith(progress: progress.overallProgress);
            },
          );
      if (!_isCurrent(cancelToken)) return;
      if (uploaded.length != 1) {
        throw StateError('Cover upload did not return exactly one media item.');
      }
      state = TripCoverState(
        status: TripCoverStatus.uploaded,
        file: file,
        previewBytes: previewBytes,
        media: uploaded.single,
        progress: 1,
      );
    } catch (_) {
      if (!_isCurrent(cancelToken)) return;
      state = TripCoverState(
        status: TripCoverStatus.failed,
        file: file,
        previewBytes: previewBytes,
        errorMessage: 'Tải ảnh bìa thất bại. Vui lòng thử lại.',
      );
    } finally {
      if (identical(_cancelToken, cancelToken)) _cancelToken = null;
    }
  }

  bool _isCurrent(CancelToken token) =>
      ref.mounted && identical(_cancelToken, token) && !token.isCancelled;
}
