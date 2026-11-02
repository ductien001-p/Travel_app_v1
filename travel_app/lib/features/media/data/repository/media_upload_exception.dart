class MediaUploadException implements Exception {
  const MediaUploadException({
    required this.message,
    this.cause,
    this.uploadedObjectKeys = const [],
  });

  final String message;

  final Object? cause;

  /*
   * Có thể đã PUT thành công nhưng
   * complete chưa chạy.
   */
  final List<String> uploadedObjectKeys;

  @override
  String toString() {
    return message;
  }
}
