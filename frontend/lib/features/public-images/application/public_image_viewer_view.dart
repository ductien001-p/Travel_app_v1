import '../data/models/public_image_models.dart';

class PublicImageViewerViewState {
  const PublicImageViewerViewState({
    required this.album,
    required this.index,
    this.showExif = false,
    this.showChrome = true,
    this.busy = false,
    this.actionError,
  });

  final PublicImageAlbum album;
  final int index;
  final bool showExif;
  final bool showChrome;
  final bool busy;
  final Object? actionError;

  PublicImageItem get current {
    if (album.images.isEmpty) {
      throw StateError('Album has no images.');
    }
    return album.images[index.clamp(0, album.images.length - 1)];
  }

  int get total => album.images.length;

  PublicImageViewerViewState copyWith({
    PublicImageAlbum? album,
    int? index,
    bool? showExif,
    bool? showChrome,
    bool? busy,
    Object? actionError,
    bool clearActionError = false,
  }) {
    return PublicImageViewerViewState(
      album: album ?? this.album,
      index: index ?? this.index,
      showExif: showExif ?? this.showExif,
      showChrome: showChrome ?? this.showChrome,
      busy: busy ?? this.busy,
      actionError: clearActionError ? null : (actionError ?? this.actionError),
    );
  }
}
