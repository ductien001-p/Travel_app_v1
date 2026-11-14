import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/public_image_models.dart';

/// Holds albums seeded from social (or other features) before navigating
/// to the fullscreen viewer / map. Keyed by [PublicImageAlbum.id].
class PublicImageAlbumSeedStore {
  final Map<String, PublicImageAlbum> _albums = <String, PublicImageAlbum>{};

  void put(PublicImageAlbum album) {
    _albums[album.id] = album;
  }

  PublicImageAlbum? get(String albumId) => _albums[albumId];
}

final publicImageAlbumSeedStoreProvider = Provider<PublicImageAlbumSeedStore>(
  (ref) => PublicImageAlbumSeedStore(),
);
