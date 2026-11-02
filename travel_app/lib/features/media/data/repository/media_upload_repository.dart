import 'dart:math' as math;

import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travel_frontend_v1/features/media/data/datasource/media_remote_datasource.dart';
import 'package:travel_frontend_v1/features/media/data/datasource/r2_upload_datasource.dart';

import '../models/complete_upload_item.dart';
import '../models/media_upload_folder.dart';
import '../models/media_upload_progress.dart';
import '../models/upload_source.dart';
import '../models/uploaded_media.dart';

import 'media_upload_exception.dart';

typedef MediaUploadProgressCallback =
    void Function(MediaUploadProgress progress);

class MediaUploadRepository {
  MediaUploadRepository({
    required MediaRemoteDataSource remoteDataSource,

    required R2UploadDataSource r2UploadDataSource,
  }) : _remoteDataSource = remoteDataSource,
       _r2UploadDataSource = r2UploadDataSource;

  final MediaRemoteDataSource _remoteDataSource;

  final R2UploadDataSource _r2UploadDataSource;

  Future<List<UploadedMedia>> uploadFiles({
    required MediaUploadFolder folder,

    required List<XFile> files,

    int maxConcurrentUploads = 3,

    CancelToken? cancelToken,

    MediaUploadProgressCallback? onProgress,
  }) async {
    if (files.isEmpty) {
      return const [];
    }

    if (maxConcurrentUploads < 1) {
      throw ArgumentError('maxConcurrentUploads must be >= 1');
    }

    /*
     * XFile → UploadSource.
     */
    final sources = await Future.wait(files.map(UploadSource.fromXFile));

    /*
     * BƯỚC 1
     *
     * Xin presigned URLs từ NestJS.
     */
    final presign = await _remoteDataSource.presignMultiple(
      folder: folder,

      sources: sources,
    );

    if (presign.uploads.length != sources.length) {
      throw StateError('Backend returned wrong number of presigned URLs.');
    }

    /*
     * Tổng byte của toàn batch.
     */
    final totalBytes = sources.fold<int>(
      0,
      (total, source) => total + source.size,
    );

    /*
     * Theo dõi byte từng file.
     */
    final sentPerFile = List<int>.filled(sources.length, 0);

    final completedKeys = <String>[];

    final uploadCancelToken = cancelToken ?? CancelToken();

    int nextIndex = 0;

    Future<void> worker() async {
      while (true) {
        if (uploadCancelToken.isCancelled) {
          return;
        }

        final index = nextIndex;

        if (index >= sources.length) {
          return;
        }

        /*
         * Tăng trước await để mỗi worker
         * lấy index riêng.
         */
        nextIndex++;

        final source = sources[index];

        final presigned = presign.uploads[index];

        /*
         * BƯỚC 2
         *
         * PUT trực tiếp lên R2.
         */
        await _r2UploadDataSource.putFile(
          source: source,

          presigned: presigned,

          cancelToken: uploadCancelToken,

          onSendProgress: (sent, total) {
            sentPerFile[index] = math.min(sent, source.size);

            final totalSent = sentPerFile.fold<int>(
              0,
              (total, value) => total + value,
            );

            onProgress?.call(
              MediaUploadProgress(
                fileIndex: index,

                fileSentBytes: sentPerFile[index],

                fileTotalBytes: source.size,

                totalSentBytes: totalSent,

                totalBytes: totalBytes,
              ),
            );
          },
        );

        completedKeys.add(presigned.objectKey);

        /*
         * Đảm bảo file đạt 100%.
         */
        sentPerFile[index] = source.size;

        final totalSent = sentPerFile.fold<int>(
          0,
          (total, value) => total + value,
        );

        onProgress?.call(
          MediaUploadProgress(
            fileIndex: index,

            fileSentBytes: source.size,

            fileTotalBytes: source.size,

            totalSentBytes: totalSent,

            totalBytes: totalBytes,
          ),
        );
      }
    }

    try {
      /*
       * Tối đa 3 uploads song song.
       */
      final workerCount = math.min(maxConcurrentUploads, sources.length);

      await Future.wait(
        List.generate(workerCount, (_) => worker()),
        eagerError: true,
      );

      if (uploadCancelToken.isCancelled) {
        throw StateError('Upload cancelled.');
      }

      /*
       * BƯỚC 3
       *
       * Tất cả PUT thành công.
       *
       * Báo backend complete.
       */
      final completeItems = List.generate(sources.length, (index) {
        return CompleteUploadItem(
          objectKey: presign.uploads[index].objectKey,

          mimeType: sources[index].mimeType,

          fileSize: sources[index].size,
        );
      }, growable: false);

      /*
       * BƯỚC 4
       *
       * Backend tạo UploadedMedia.
       */
      return await _remoteDataSource.completeMultiple(items: completeItems);
    } catch (error) {
      if (!uploadCancelToken.isCancelled) {
        uploadCancelToken.cancel('Batch upload failed.');
      }

      throw MediaUploadException(
        message: 'Unable to upload media.',

        cause: error,

        uploadedObjectKeys: List.unmodifiable(completedKeys),
      );
    }
  }

  Future<String> getMediaUrl(String mediaId) async {
    return await _remoteDataSource.getMediaUrl(mediaId);
  }

  Future<String> getOwnMediaUrl(String mediaId) async {
    return await _remoteDataSource.getOwnMediaUrl(mediaId);
  }
}
