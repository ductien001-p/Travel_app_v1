import '../datasources/public_images_datasource.dart';
import '../models/public_image_models.dart';

class PublicImagesRepository {
  const PublicImagesRepository({required PublicImagesDataSource dataSource})
    : _dataSource = dataSource;

  final PublicImagesDataSource _dataSource;

  Future<PublicImageAlbum> getAlbum(String albumId) {
    return _dataSource.getAlbum(albumId);
  }
}
