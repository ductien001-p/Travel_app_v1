import 'package:freezed_annotation/freezed_annotation.dart';

part 'public_image_models.freezed.dart';
part 'public_image_models.g.dart';

enum PublicImageMapLayer {
  @JsonValue('SATELLITE')
  satellite,
  @JsonValue('TERRAIN')
  terrain,
  @JsonValue('STANDARD')
  standard,
}

/// Album + photos for the public fullscreen viewer (Stitch Teal Horizon).
@freezed
abstract class PublicImageAlbum with _$PublicImageAlbum {
  const factory PublicImageAlbum({
    required String id,
    required String title,
    @Default('Chuyến đi') String tripTitle,
    @Default(<PublicImageItem>[]) List<PublicImageItem> images,
  }) = _PublicImageAlbum;

  factory PublicImageAlbum.fromJson(Map<String, dynamic> json) =>
      _$PublicImageAlbumFromJson(json);
}

@freezed
abstract class PublicImageItem with _$PublicImageItem {
  const factory PublicImageItem({
    required String id,
    required String imageUrl,
    String? thumbnailUrl,
    String? caption,
    String? cityLabel,
    String? locationLabel,
    String? locationShortLabel,
    String? placeCategoryLabel,
    String? regionLabel,
    String? countryLabel,
    double? latitude,
    double? longitude,
    double? altitudeMeters,
    DateTime? capturedAt,
    String? clockLabel,
    String? exifSummary,
    String? resolutionLabel,
    String? shareUrl,
    @Default(0) int likeCount,
    @Default(0) int commentCount,
    @Default(false) bool likedByMe,
    @Default(true) bool canSetAsCover,
    @Default(true) bool canDelete,
  }) = _PublicImageItem;

  factory PublicImageItem.fromJson(Map<String, dynamic> json) =>
      _$PublicImageItemFromJson(json);
}
