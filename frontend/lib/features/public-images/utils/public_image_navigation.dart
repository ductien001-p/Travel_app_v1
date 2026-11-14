import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../application/public_image_album_seed_store.dart';
import '../data/models/public_image_models.dart';

/// Seeds [album] then opens the fullscreen public image viewer.
Future<T?> openPublicImageViewer<T extends Object?>(
  BuildContext context,
  WidgetRef ref, {
  required PublicImageAlbum album,
  int initialIndex = 0,
  String? initialImageId,
}) {
  if (album.images.isEmpty) return Future<T?>.value(null);

  ref.read(publicImageAlbumSeedStoreProvider).put(album);

  var index = initialIndex;
  if (initialImageId != null && initialImageId.isNotEmpty) {
    final found = album.images.indexWhere((item) => item.id == initialImageId);
    if (found >= 0) index = found;
  }
  index = index.clamp(0, album.images.length - 1);

  final query = <String, String>{
    'index': '$index',
    if (initialImageId != null && initialImageId.isNotEmpty)
      'imageId': initialImageId,
  };
  final uri = Uri(
    path: '/images/${Uri.encodeComponent(album.id)}',
    queryParameters: query,
  );
  return context.push<T>(uri.toString());
}
