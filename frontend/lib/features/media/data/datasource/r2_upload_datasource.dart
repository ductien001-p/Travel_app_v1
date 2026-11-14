import 'package:dio/dio.dart';

import '../models/presigned_upload.dart';
import '../models/upload_source.dart';

class R2UploadDataSource {
  R2UploadDataSource({Dio? dio}) : _dio = dio ?? Dio();

  final Dio _dio;

  Future<void> putFile({
    required UploadSource source,

    required PresignedUpload presigned,

    CancelToken? cancelToken,

    ProgressCallback? onSendProgress,
  }) async {
    if (presigned.method != 'PUT') {
      throw UnsupportedError('Expected PUT but received ${presigned.method}.');
    }

    final headers = <String, dynamic>{...presigned.headers};

    /*
     * Content-Length để Dio có thể
     * tính upload progress.
     */
    headers[Headers.contentLengthHeader] = source.size;

    /*
     * Nếu backend đã trả Content-Type
     * thì PHẢI giữ nguyên.
     *
     * Vì Content-Type có thể là một phần
     * của R2 signature.
     */
    final hasContentType = headers.keys.any(
      (key) => key.toLowerCase() == Headers.contentTypeHeader,
    );

    if (!hasContentType) {
      headers[Headers.contentTypeHeader] = source.mimeType;
    }

    await _dio.putUri<void>(
      Uri.parse(presigned.url),

      /*
       * Stream file.
       *
       * Không readAsBytes toàn bộ file
       * vào RAM.
       */
      data: source.file.openRead(),

      cancelToken: cancelToken,

      onSendProgress: onSendProgress,

      options: Options(
        headers: headers,

        responseType: ResponseType.plain,

        validateStatus: (status) {
          return status != null && status >= 200 && status < 300;
        },
      ),
    );
  }

  void close() {
    _dio.close(force: true);
  }
}
