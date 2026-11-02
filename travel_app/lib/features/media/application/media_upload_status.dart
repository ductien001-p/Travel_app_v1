import '../data/models/uploaded_media.dart';

enum MediaUploadStatus { idle, uploading, success, failure, cancelled }

class MediaUploadState {
  const MediaUploadState({
    this.status = MediaUploadStatus.idle,

    this.progress = 0,

    this.uploadedMedia = const [],

    this.errorMessage,
  });

  final MediaUploadStatus status;

  final double progress;

  final List<UploadedMedia> uploadedMedia;

  final String? errorMessage;

  bool get isUploading {
    return status == MediaUploadStatus.uploading;
  }

  MediaUploadState copyWith({
    MediaUploadStatus? status,

    double? progress,

    List<UploadedMedia>? uploadedMedia,

    String? errorMessage,

    bool clearError = false,
  }) {
    return MediaUploadState(
      status: status ?? this.status,

      progress: progress ?? this.progress,

      uploadedMedia: uploadedMedia ?? this.uploadedMedia,

      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
    );
  }
}
