import 'models/complete_upload_item.dart';
import 'models/media_upload_folder.dart';
import 'models/presign_multiple_response.dart';
import 'models/upload_source.dart';
import 'models/uploaded_media.dart';

abstract final class MediaBackendContract {
  static const presignMultiplePath = '/uploads/presigns';

  static const completeMultiplePath = '/uploads/complete';

  static Map<String, dynamic> buildPresignMultipleBody({
    required MediaUploadFolder folder,

    required List<UploadSource> sources,
  }) {
    return {
      'folder': folder.apiValue,

      'files': sources
          .map((source) => {'contentType': source.mimeType})
          .toList(growable: false),
    };
  }

  static PresignMultipleResponse parsePresignResponse(
    Map<String, dynamic> body,
  ) {
    final rawData = body['data'];
    final payload = rawData is Map ? Map<String, dynamic>.from(rawData) : body;

    return PresignMultipleResponse.fromJson(payload);
  }

  static Map<String, dynamic> buildCompleteBody({
    required List<CompleteUploadItem> items,
  }) {
    return {
      'files': items.map((item) => item.toJson()).toList(growable: false),
    };
  }

  static List<UploadedMedia> parseCompleteResponse(Object? body) {
    Object? value = body;

    /*
     * {
     *   data: ...
     * }
     */
    if (value is Map) {
      value = value['data'] ?? value;
    }

    /*
     * {
     *   data: {
     *      media: [...]
     *   }
     * }
     */
    if (value is Map) {
      value = value['media'] ?? value['uploads'] ?? value['items'];
    }

    if (value is! List) {
      throw const FormatException(
        'Complete upload response does not contain media list.',
      );
    }

    return value
        .map(
          (item) =>
              UploadedMedia.fromJson(Map<String, dynamic>.from(item as Map)),
        )
        .toList(growable: false);
  }
}
