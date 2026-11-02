import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travel_frontend_v1/features/media/data/models/media_upload_folder.dart';
import 'package:travel_frontend_v1/features/media/data/models/uploaded_media.dart';
import 'package:travel_frontend_v1/features/media/data/repository/media_upload_repository.dart';
import 'package:travel_frontend_v1/features/media/providers/media_providers.dart';
import 'package:travel_frontend_v1/features/trips/application/trip_cover_controller.dart';

void main() {
  late _FakeMediaUploadRepository repository;
  late ProviderContainer container;

  setUp(() {
    repository = _FakeMediaUploadRepository();
    container = ProviderContainer(
      overrides: [mediaUploadRepositoryProvider.overrideWithValue(repository)],
    );
    container.listen(tripCoverControllerProvider, (_, _) {});
  });

  tearDown(() => container.dispose());

  TripCoverController controller() =>
      container.read(tripCoverControllerProvider.notifier);
  TripCoverState state() => container.read(tripCoverControllerProvider);

  test('uploads the cover to the trips folder and exposes its id', () async {
    await controller().select(_image());

    expect(repository.folders, [MediaUploadFolder.trips]);
    expect(state().status, TripCoverStatus.uploaded);
    expect(state().mediaId, 'media-1');
    expect(state().previewBytes, isNotNull);
  });

  test('rejects file types the backend does not accept', () async {
    await expectLater(
      controller().select(
        XFile.fromData(
          Uint8List.fromList([1, 2, 3]),
          name: 'notes.pdf',
          mimeType: 'application/pdf',
        ),
      ),
      throwsA(isA<TripCoverException>()),
    );

    expect(repository.folders, isEmpty);
    expect(state().status, TripCoverStatus.empty);
  });

  test('rejects images larger than the limit', () async {
    await expectLater(
      controller().select(_image(size: TripCoverController.maxFileBytes + 1)),
      throwsA(isA<TripCoverException>()),
    );

    expect(repository.folders, isEmpty);
  });

  test('an invalid pick keeps the previously uploaded cover', () async {
    await controller().select(_image());

    await expectLater(
      controller().select(
        XFile.fromData(Uint8List(1), name: 'a.bmp', mimeType: 'image/bmp'),
      ),
      throwsA(isA<TripCoverException>()),
    );

    expect(state().mediaId, 'media-1');
  });

  test('a failed upload exposes no media id and can be retried', () async {
    repository.error = StateError('network down');

    await controller().select(_image());

    expect(state().status, TripCoverStatus.failed);
    expect(state().mediaId, isNull);
    expect(state().errorMessage, isNotNull);

    repository.error = null;
    await controller().retry();

    expect(state().status, TripCoverStatus.uploaded);
    expect(state().mediaId, 'media-2');
  });

  test('clear resets the cover', () async {
    await controller().select(_image());

    controller().clear();

    expect(state().status, TripCoverStatus.empty);
    expect(state().mediaId, isNull);
    expect(state().previewBytes, isNull);
  });
}

XFile _image({int size = 16}) =>
    XFile.fromData(Uint8List(size), name: 'cover.jpg', mimeType: 'image/jpeg');

class _FakeMediaUploadRepository implements MediaUploadRepository {
  final folders = <MediaUploadFolder>[];
  Object? error;
  int _uploads = 0;

  @override
  Future<List<UploadedMedia>> uploadFiles({
    required MediaUploadFolder folder,
    required List<XFile> files,
    int maxConcurrentUploads = 3,
    CancelToken? cancelToken,
    MediaUploadProgressCallback? onProgress,
  }) async {
    folders.add(folder);
    _uploads++;
    if (error != null) throw error!;
    return [
      UploadedMedia(
        id: 'media-$_uploads',
        objectKey: 'trips/cover-$_uploads.jpg',
        mimeType: 'image/jpeg',
        fileSize: 16,
      ),
    ];
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
