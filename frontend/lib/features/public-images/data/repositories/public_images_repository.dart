import '../datamock/public_images_datamock.dart';
import '../datasources/public_images_datasource.dart';
import '../models/public_image_models.dart';

class PublicImagesRepository {
  const PublicImagesRepository({required PublicImagesDataSource dataSource})
    : _dataSource = dataSource;

  final PublicImagesDataSource _dataSource;

  Future<PublicImageAlbum> getAlbum(String albumId) async {
    try {
      return await _dataSource.getAlbum(albumId);
    } catch (_) {
      // TODO(backend): bỏ fallback datamock khi endpoint /public-images sẵn sàng
      return PublicImageAlbum.fromJson(publicImagesDatamockForAlbum(albumId));
    }
  }

  Future<void> setAsCover({
    required String albumId,
    required String imageId,
  }) async {
    try {
      await _dataSource.setAsCover(albumId: albumId, imageId: imageId);
    } catch (_) {
      // TODO(backend): API demo — giữ no-op khi backend chưa có
    }
  }

  Future<void> deleteImage({
    required String albumId,
    required String imageId,
  }) async {
    try {
      await _dataSource.deleteImage(albumId: albumId, imageId: imageId);
    } catch (_) {
      // TODO(backend): API demo — vẫn cho UI xóa local khi backend chưa có
    }
  }

  Future<PublicImageItem> toggleLike({
    required String albumId,
    required PublicImageItem image,
  }) async {
    try {
      return await _dataSource.toggleLike(albumId: albumId, imageId: image.id);
    } catch (_) {
      // TODO(backend): API demo — optimistic local khi backend chưa có
      final liked = !image.likedByMe;
      final nextCount = liked
          ? image.likeCount + 1
          : (image.likeCount > 0 ? image.likeCount - 1 : 0);
      return image.copyWith(likedByMe: liked, likeCount: nextCount);
    }
  }
}
