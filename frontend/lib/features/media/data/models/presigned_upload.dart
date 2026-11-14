class PresignedUpload {
  const PresignedUpload({
    required this.url,
    required this.objectKey,
    required this.method,
    required this.headers,
  });

  final String url;

  final String objectKey;

  final String method;

  final Map<String, String> headers;

  factory PresignedUpload.fromJson(Map<String, dynamic> json) {
    final rawHeaders = json['headers'];

    final headers = <String, String>{};

    if (rawHeaders is Map) {
      for (final entry in rawHeaders.entries) {
        headers[entry.key.toString()] = entry.value.toString();
      }
    }

    final objectKey = json['key']?.toString() ?? json['objectKey']?.toString();

    if (objectKey == null || objectKey.isEmpty) {
      throw const FormatException('Missing object key.');
    }

    final url = json['url']?.toString();

    if (url == null || url.isEmpty) {
      throw const FormatException('Missing presigned URL.');
    }

    return PresignedUpload(
      url: url,

      objectKey: objectKey,

      method: json['method']?.toString().toUpperCase() ?? 'PUT',

      headers: headers,
    );
  }
}
