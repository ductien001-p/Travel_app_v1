import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/public_images_provider.dart';
import 'public_image_album_seed_store.dart';
import 'public_image_viewer_view.dart';

class PublicImageViewerArgs {
  const PublicImageViewerArgs({
    required this.albumId,
    this.initialIndex = 0,
    this.initialImageId,
  });

  final String albumId;
  final int initialIndex;
  final String? initialImageId;

  @override
  bool operator ==(Object other) {
    return other is PublicImageViewerArgs &&
        other.albumId == albumId &&
        other.initialIndex == initialIndex &&
        other.initialImageId == initialImageId;
  }

  @override
  int get hashCode => Object.hash(albumId, initialIndex, initialImageId);
}

final publicImageViewerControllerProvider = AsyncNotifierProvider.autoDispose
    .family<
      PublicImageViewerController,
      PublicImageViewerViewState,
      PublicImageViewerArgs
    >(PublicImageViewerController.new, retry: (_, _) => null);

class PublicImageViewerController
    extends AsyncNotifier<PublicImageViewerViewState> {
  PublicImageViewerController(this.args);

  final PublicImageViewerArgs args;

  @override
  Future<PublicImageViewerViewState> build() => _load();

  Future<bool> refresh() async {
    final previous = state.asData?.value;
    state = const AsyncLoading<PublicImageViewerViewState>();
    state = await AsyncValue.guard(_load);
    if (state.hasError && previous != null) {
      state = AsyncData(previous);
      return false;
    }
    return !state.hasError;
  }

  void setIndex(int index) {
    final current = state.asData?.value;
    if (current == null) return;
    final next = index.clamp(0, current.total - 1);
    if (next == current.index) return;
    state = AsyncData(
      current.copyWith(index: next, showExif: false, clearActionError: true),
    );
  }

  void toggleChrome() {
    final current = state.asData?.value;
    if (current == null) return;
    state = AsyncData(current.copyWith(showChrome: !current.showChrome));
  }

  void toggleExif() {
    final current = state.asData?.value;
    if (current == null) return;
    state = AsyncData(current.copyWith(showExif: !current.showExif));
  }

  Future<PublicImageViewerViewState> _load() async {
    final seeded = ref
        .read(publicImageAlbumSeedStoreProvider)
        .get(args.albumId);
    final album = seeded != null && seeded.images.isNotEmpty
        ? seeded
        : await ref.read(publicImagesRepositoryProvider).getAlbum(args.albumId);
    if (album.images.isEmpty) {
      throw StateError('Không có ảnh để xem.');
    }

    var index = args.initialIndex;
    final imageId = args.initialImageId;
    if (imageId != null && imageId.isNotEmpty) {
      final found = album.images.indexWhere((item) => item.id == imageId);
      if (found >= 0) index = found;
    }
    return PublicImageViewerViewState(
      album: album,
      index: index.clamp(0, album.images.length - 1),
    );
  }
}
