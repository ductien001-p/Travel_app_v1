class UploadedMedia {
  const UploadedMedia({
    required this.id,
    required this.objectKey,
    required this.mimeType,
    required this.fileSize,
    this.publicUrl,
    this.width,
    this.height,
  });

  final String id;

  final String objectKey;

  final String mimeType;

  final int fileSize;

  final String? publicUrl;

  final int? width;

  final int? height;

  factory UploadedMedia.fromJson(Map<String, dynamic> json) {
    int? parseInt(Object? value) {
      return switch (value) {
        int v => v,

        num v => v.toInt(),

        String v => int.tryParse(v),

        _ => null,
      };
    }

    return UploadedMedia(
      id: json['id'].toString(),

      objectKey: json['objectKey'].toString(),

      mimeType: json['mimeType'].toString(),

      fileSize: parseInt(json['fileSize']) ?? 0,

      publicUrl: json['publicUrl']?.toString() ?? json['url']?.toString(),

      width: parseInt(json['width']),

      height: parseInt(json['height']),
    );
  }
}
