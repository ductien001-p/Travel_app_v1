import 'package:flutter_test/flutter_test.dart';
import 'package:travel_frontend_v1/features/public-images/data/datamock/public_images_datamock.dart';
import 'package:travel_frontend_v1/features/public-images/data/models/public_image_models.dart';
import 'package:travel_frontend_v1/features/public-images/utils/public_image_formatters.dart';

void main() {
  test('datamock parses into PublicImageAlbum with geotagged first photo', () {
    final album = PublicImageAlbum.fromJson(publicImagesDatamock);
    expect(album.id, 'ban-co-sunrise');
    expect(album.images, isNotEmpty);
    final first = album.images.first;
    expect(first.latitude, closeTo(16.1205, 0.0001));
    expect(first.longitude, closeTo(108.2783, 0.0001));
    expect(first.locationLabel, contains('Bàn Cờ'));
  });

  test('formatters match Stitch counter and coordinates copy', () {
    expect(formatPublicImageCounter(0, 5), '1/5');
    expect(
      formatPublicImageCoordinates(latitude: 16.1205, longitude: 108.2783),
      '16.1205° N, 108.2783° E',
    );
    expect(
      formatPublicImageDateTime(DateTime.utc(2025, 7, 20, 5, 45)),
      '20/07/2025 • 05:45 AM',
    );
  });
}
