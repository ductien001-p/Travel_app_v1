// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'public_image_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PublicImageAlbum _$PublicImageAlbumFromJson(Map<String, dynamic> json) =>
    _PublicImageAlbum(
      id: json['id'] as String,
      title: json['title'] as String,
      tripTitle: json['tripTitle'] as String? ?? 'Chuyến đi',
      images:
          (json['images'] as List<dynamic>?)
              ?.map((e) => PublicImageItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <PublicImageItem>[],
    );

Map<String, dynamic> _$PublicImageAlbumToJson(_PublicImageAlbum instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'tripTitle': instance.tripTitle,
      'images': instance.images,
    };

_PublicImageItem _$PublicImageItemFromJson(Map<String, dynamic> json) =>
    _PublicImageItem(
      id: json['id'] as String,
      imageUrl: json['imageUrl'] as String,
      thumbnailUrl: json['thumbnailUrl'] as String?,
      caption: json['caption'] as String?,
      cityLabel: json['cityLabel'] as String?,
      locationLabel: json['locationLabel'] as String?,
      locationShortLabel: json['locationShortLabel'] as String?,
      placeCategoryLabel: json['placeCategoryLabel'] as String?,
      regionLabel: json['regionLabel'] as String?,
      countryLabel: json['countryLabel'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      altitudeMeters: (json['altitudeMeters'] as num?)?.toDouble(),
      capturedAt: json['capturedAt'] == null
          ? null
          : DateTime.parse(json['capturedAt'] as String),
      clockLabel: json['clockLabel'] as String?,
      exifSummary: json['exifSummary'] as String?,
      resolutionLabel: json['resolutionLabel'] as String?,
      shareUrl: json['shareUrl'] as String?,
      likeCount: (json['likeCount'] as num?)?.toInt() ?? 0,
      commentCount: (json['commentCount'] as num?)?.toInt() ?? 0,
      likedByMe: json['likedByMe'] as bool? ?? false,
      canSetAsCover: json['canSetAsCover'] as bool? ?? true,
      canDelete: json['canDelete'] as bool? ?? true,
    );

Map<String, dynamic> _$PublicImageItemToJson(_PublicImageItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'imageUrl': instance.imageUrl,
      'thumbnailUrl': instance.thumbnailUrl,
      'caption': instance.caption,
      'cityLabel': instance.cityLabel,
      'locationLabel': instance.locationLabel,
      'locationShortLabel': instance.locationShortLabel,
      'placeCategoryLabel': instance.placeCategoryLabel,
      'regionLabel': instance.regionLabel,
      'countryLabel': instance.countryLabel,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'altitudeMeters': instance.altitudeMeters,
      'capturedAt': instance.capturedAt?.toIso8601String(),
      'clockLabel': instance.clockLabel,
      'exifSummary': instance.exifSummary,
      'resolutionLabel': instance.resolutionLabel,
      'shareUrl': instance.shareUrl,
      'likeCount': instance.likeCount,
      'commentCount': instance.commentCount,
      'likedByMe': instance.likedByMe,
      'canSetAsCover': instance.canSetAsCover,
      'canDelete': instance.canDelete,
    };
