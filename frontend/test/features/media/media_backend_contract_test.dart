import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travel_frontend_v1/features/media/data/media_backend_contract.dart';
import 'package:travel_frontend_v1/features/media/data/models/complete_upload_item.dart';
import 'package:travel_frontend_v1/features/media/data/models/media_upload_folder.dart';
import 'package:travel_frontend_v1/features/media/data/models/upload_source.dart';

void main() {
  test('presign and complete use the uploads contract', () {
    expect(MediaBackendContract.presignMultiplePath, '/uploads/presigns');
    expect(MediaBackendContract.completeMultiplePath, '/uploads/complete');

    final presign = MediaBackendContract.buildPresignMultipleBody(
      folder: MediaUploadFolder.posts,
      sources: [
        UploadSource(
          file: XFile('photo.jpg'),
          mimeType: 'image/jpeg',
          size: 12,
        ),
      ],
    );
    expect(presign['folder'], 'posts');
    expect(presign['files'], [
      {'contentType': 'image/jpeg'},
    ]);
    expect(presign.containsKey('uploads'), isFalse);

    final complete = MediaBackendContract.buildCompleteBody(
      items: [
        const CompleteUploadItem(
          objectKey: 'posts/user/abc.jpg',
          mimeType: 'image/jpeg',
          fileSize: 12,
        ),
      ],
    );
    expect(complete['files'], [
      {
        'objectKey': 'posts/user/abc.jpg',
        'mimeType': 'image/jpeg',
        'fileSize': 12,
      },
    ]);
  });

  test('parses a root presign payload and a bare complete list', () {
    final presign = MediaBackendContract.parsePresignResponse({
      'method': 'PUT',
      'expiresIn': 3600,
      'uploads': [
        {
          'url': 'https://r2.example/put',
          'key': 'posts/user/abc.jpg',
          'headers': {'Content-Type': 'image/jpeg'},
        },
      ],
    });
    expect(presign.expiresIn, 3600);
    expect(presign.uploads.single.objectKey, 'posts/user/abc.jpg');
    expect(presign.uploads.single.url, 'https://r2.example/put');
    expect(presign.uploads.single.method, 'PUT');

    final wrapped = MediaBackendContract.parsePresignResponse({
      'data': {
        'uploads': [
          {'url': 'https://r2.example/put-2', 'key': 'posts/user/def.jpg'},
        ],
      },
    });
    expect(wrapped.uploads.single.objectKey, 'posts/user/def.jpg');

    final completed = MediaBackendContract.parseCompleteResponse([
      {
        'id': 'media-1',
        'objectKey': 'posts/user/abc.jpg',
        'mimeType': 'image/jpeg',
        'fileSize': 12,
      },
    ]);
    expect(completed.single.id, 'media-1');

    final wrappedComplete = MediaBackendContract.parseCompleteResponse({
      'data': [
        {
          'id': 'media-2',
          'objectKey': 'posts/user/def.jpg',
          'mimeType': 'image/png',
          'fileSize': 8,
        },
      ],
    });
    expect(wrappedComplete.single.id, 'media-2');
  });
}
