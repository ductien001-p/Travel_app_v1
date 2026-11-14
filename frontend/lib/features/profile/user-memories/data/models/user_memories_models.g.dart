// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_memories_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserMemoriesPage _$UserMemoriesPageFromJson(Map<String, dynamic> json) =>
    _UserMemoriesPage(
      items:
          (json['data'] as List<dynamic>?)
              ?.map((e) => UserMemoryPhoto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <UserMemoryPhoto>[],
      collections: (json['collections'] as List<dynamic>?)
          ?.map((e) => UserMemoryCollection.fromJson(e as Map<String, dynamic>))
          .toList(),
      highlight: json['highlight'] == null
          ? null
          : UserMemoryPhoto.fromJson(json['highlight'] as Map<String, dynamic>),
      meta: UserMemoriesMeta.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserMemoriesPageToJson(_UserMemoriesPage instance) =>
    <String, dynamic>{
      'data': instance.items,
      'collections': instance.collections,
      'highlight': instance.highlight,
      'meta': instance.meta,
    };

_UserMemoriesMeta _$UserMemoriesMetaFromJson(Map<String, dynamic> json) =>
    _UserMemoriesMeta(
      nextCursor: json['nextCursor'] as String?,
      hasMore: json['hasMore'] as bool? ?? false,
      totalCount: (json['totalCount'] as num?)?.toInt(),
    );

Map<String, dynamic> _$UserMemoriesMetaToJson(_UserMemoriesMeta instance) =>
    <String, dynamic>{
      'nextCursor': instance.nextCursor,
      'hasMore': instance.hasMore,
      'totalCount': instance.totalCount,
    };

_UserMemoryCollection _$UserMemoryCollectionFromJson(
  Map<String, dynamic> json,
) => _UserMemoryCollection(
  tripId: json['tripId'] as String,
  name: json['name'] as String,
  status: json['status'] as String,
  memoryCount: (json['memoryCount'] as num).toInt(),
);

Map<String, dynamic> _$UserMemoryCollectionToJson(
  _UserMemoryCollection instance,
) => <String, dynamic>{
  'tripId': instance.tripId,
  'name': instance.name,
  'status': instance.status,
  'memoryCount': instance.memoryCount,
};

_UserMemoryPhoto _$UserMemoryPhotoFromJson(Map<String, dynamic> json) =>
    _UserMemoryPhoto(
      id: json['id'] as String,
      tripId: json['tripId'] as String,
      tripName: json['tripName'] as String,
      caption: json['caption'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      imageUrl: json['imageUrl'] as String,
      badge: json['badge'] as String?,
      likeCount: (json['likeCount'] as num).toInt(),
      liked: json['liked'] as bool? ?? false,
    );

Map<String, dynamic> _$UserMemoryPhotoToJson(_UserMemoryPhoto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tripId': instance.tripId,
      'tripName': instance.tripName,
      'caption': instance.caption,
      'createdAt': instance.createdAt.toIso8601String(),
      'imageUrl': instance.imageUrl,
      'badge': instance.badge,
      'likeCount': instance.likeCount,
      'liked': instance.liked,
    };

_UserMemoryLike _$UserMemoryLikeFromJson(Map<String, dynamic> json) =>
    _UserMemoryLike(
      likeCount: (json['likeCount'] as num).toInt(),
      liked: json['liked'] as bool,
    );

Map<String, dynamic> _$UserMemoryLikeToJson(_UserMemoryLike instance) =>
    <String, dynamic>{'likeCount': instance.likeCount, 'liked': instance.liked};
