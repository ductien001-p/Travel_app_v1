import '../data/models/public_image_models.dart';

/// Builds a viewer album from a social post's media list.
PublicImageAlbum publicImageAlbumFromSocialMedias({
  required String postId,
  required String authorId,
  required String authorName,
  String? caption,
  String? placeLabel,
  String? placeDetail,
  DateTime? createdAt,
  int likesCount = 0,
  int commentsCount = 0,
  bool likedByMe = false,
  required List<({String id, String imageUrl, String? caption})> medias,
}) {
  final images = medias
      .where((item) => item.imageUrl.trim().isNotEmpty)
      .map(
        (item) => PublicImageItem(
          id: item.id,
          imageUrl: item.imageUrl,
          thumbnailUrl: item.imageUrl,
          caption: (item.caption ?? caption)?.trim(),
          cityLabel: placeLabel,
          locationLabel: placeDetail ?? placeLabel,
          locationShortLabel: placeLabel,
          capturedAt: createdAt,
          likeCount: likesCount,
          commentCount: commentsCount,
          likedByMe: likedByMe,
          canSetAsCover: false,
          canDelete: false,
          shareUrl: null,
        ),
      )
      .toList(growable: false);

  return PublicImageAlbum(
    id: socialPublicImageAlbumId(postId),
    title: caption?.trim().isNotEmpty == true
        ? caption!.trim()
        : 'Ảnh của $authorName',
    tripTitle: placeLabel?.trim().isNotEmpty == true
        ? placeLabel!.trim()
        : 'Bài viết cộng đồng',
    images: images,
  );
}

String socialPublicImageAlbumId(String postId) => 'social-post-$postId';
