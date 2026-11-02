class MediaUploadProgress {
  const MediaUploadProgress({
    required this.fileIndex,
    required this.fileSentBytes,
    required this.fileTotalBytes,
    required this.totalSentBytes,
    required this.totalBytes,
  });

  final int fileIndex;

  final int fileSentBytes;

  final int fileTotalBytes;

  final int totalSentBytes;

  final int totalBytes;

  double get fileProgress {
    if (fileTotalBytes <= 0) {
      return 0;
    }

    return (fileSentBytes / fileTotalBytes).clamp(0.0, 1.0);
  }

  double get overallProgress {
    if (totalBytes <= 0) {
      return 0;
    }

    return (totalSentBytes / totalBytes).clamp(0.0, 1.0);
  }
}
