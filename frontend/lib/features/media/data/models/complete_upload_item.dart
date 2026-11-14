class CompleteUploadItem {
  const CompleteUploadItem({
    required this.objectKey,
    required this.mimeType,
    required this.fileSize,
  });

  final String objectKey;

  final String mimeType;

  final int fileSize;

  Map<String, dynamic> toJson() {
    return {'objectKey': objectKey, 'mimeType': mimeType, 'fileSize': fileSize};
  }
}
