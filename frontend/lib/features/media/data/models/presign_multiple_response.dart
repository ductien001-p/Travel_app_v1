import 'presigned_upload.dart';

class PresignMultipleResponse {
  const PresignMultipleResponse({required this.uploads, this.expiresIn});

  final List<PresignedUpload> uploads;

  final int? expiresIn;

  factory PresignMultipleResponse.fromJson(Map<String, dynamic> json) {
    final rawUploads = json['uploads'];

    if (rawUploads is! List) {
      throw const FormatException('Presign response does not contain uploads.');
    }

    return PresignMultipleResponse(
      expiresIn: switch (json['expiresIn']) {
        int value => value,

        String value => int.tryParse(value),

        _ => null,
      },

      uploads: rawUploads
          .map(
            (item) => PresignedUpload.fromJson(
              Map<String, dynamic>.from(item as Map),
            ),
          )
          .toList(growable: false),
    );
  }
}
