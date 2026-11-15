import '../datasources/public_images_datasource.dart';
import '../models/public_image_models.dart';

class PublicImagesRepository {
  const PublicImagesRepository({required PublicImagesDataSource dataSource})
    : _dataSource = dataSource;

  final PublicImagesDataSource _dataSource;

  Future<PublicImageAlbum> getAlbum(String albumId) {
    return _dataSource.getAlbum(albumId);
  }

  Future<void> setAsCover({
    required String albumId,
    required String imageId,
  }) {
    return _dataSource.setAsCover(albumId: albumId, imageId: imageId);
  }

  Future<void> deleteImage({
    required String albumId,
    required String imageId,
  }) {
    return _dataSource.deleteImage(albumId: albumId, imageId: imageId);
  }

  Future<PublicImageItem> toggleLike({
    required String albumId,
    required PublicImageItem image,
  }) {
    return _dataSource.toggleLike(albumId: albumId, imageId: image.id);
  }
}
