// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_memory_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TripMemoriesPage _$TripMemoriesPageFromJson(Map<String, dynamic> json) =>
    _TripMemoriesPage(
      items:
          (json['data'] as List<dynamic>?)
              ?.map((e) => TripMemoryEntry.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <TripMemoryEntry>[],
      meta: TripMemoriesCursor.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TripMemoriesPageToJson(_TripMemoriesPage instance) =>
    <String, dynamic>{'data': instance.items, 'meta': instance.meta};

_TripMemoriesCursor _$TripMemoriesCursorFromJson(Map<String, dynamic> json) =>
    _TripMemoriesCursor(
      nextCursor: json['nextCursor'] as String?,
      hasMore: json['hasMore'] as bool? ?? false,
      totalCount: (json['totalCount'] as num?)?.toInt(),
      dayCounts: (json['dayCounts'] as List<dynamic>?)
          ?.map((e) => TripMemoriesDayCount.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TripMemoriesCursorToJson(_TripMemoriesCursor instance) =>
    <String, dynamic>{
      'nextCursor': instance.nextCursor,
      'hasMore': instance.hasMore,
      'totalCount': instance.totalCount,
      'dayCounts': instance.dayCounts,
    };

_TripMemoriesDayCount _$TripMemoriesDayCountFromJson(
  Map<String, dynamic> json,
) => _TripMemoriesDayCount(
  day: (json['day'] as num).toInt(),
  count: (json['count'] as num).toInt(),
);

Map<String, dynamic> _$TripMemoriesDayCountToJson(
  _TripMemoriesDayCount instance,
) => <String, dynamic>{'day': instance.day, 'count': instance.count};

_TripMemoryEntry _$TripMemoryEntryFromJson(Map<String, dynamic> json) =>
    _TripMemoryEntry(
      id: json['id'] as String,
      tripId: json['tripId'] as String,
      caption: json['caption'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      imageUrl: json['imageUrl'] as String,
      user: json['user'] == null
          ? null
          : TripMemoryUploader.fromJson(json['user'] as Map<String, dynamic>),
      media: TripMemoryAsset.fromJson(json['media'] as Map<String, dynamic>),
      badge: json['badge'] as String?,
    );

Map<String, dynamic> _$TripMemoryEntryToJson(_TripMemoryEntry instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tripId': instance.tripId,
      'caption': instance.caption,
      'createdAt': instance.createdAt.toIso8601String(),
      'imageUrl': instance.imageUrl,
      'user': instance.user,
      'media': instance.media,
      'badge': instance.badge,
    };

_TripMemoryUploader _$TripMemoryUploaderFromJson(Map<String, dynamic> json) =>
    _TripMemoryUploader(
      id: json['id'] as String,
      username: json['username'] as String,
      avatarId: json['avatarId'] as String?,
    );

Map<String, dynamic> _$TripMemoryUploaderToJson(_TripMemoryUploader instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'avatarId': instance.avatarId,
    };

_TripMemoryAsset _$TripMemoryAssetFromJson(Map<String, dynamic> json) =>
    _TripMemoryAsset(
      id: json['id'] as String,
      mimeType: json['mimeType'] as String? ?? 'application/octet-stream',
      width: (json['width'] as num?)?.toInt(),
      height: (json['height'] as num?)?.toInt(),
    );

Map<String, dynamic> _$TripMemoryAssetToJson(_TripMemoryAsset instance) =>
    <String, dynamic>{
      'id': instance.id,
      'mimeType': instance.mimeType,
      'width': instance.width,
      'height': instance.height,
    };

_NewTripMemory _$NewTripMemoryFromJson(Map<String, dynamic> json) =>
    _NewTripMemory(
      mediaId: json['mediaId'] as String,
      caption: json['caption'] as String?,
    );

Map<String, dynamic> _$NewTripMemoryToJson(_NewTripMemory instance) =>
    <String, dynamic>{
      'mediaId': instance.mediaId,
      'caption': ?instance.caption,
    };
