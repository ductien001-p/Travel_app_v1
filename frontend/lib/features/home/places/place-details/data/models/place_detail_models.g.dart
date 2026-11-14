// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_detail_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PlaceDetailApi _$PlaceDetailApiFromJson(Map<String, dynamic> json) =>
    _PlaceDetailApi(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      city: json['city'] as String,
      country: json['country'] as String,
      address: json['address'] as String,
      latitude: _readDouble(json['latitude']),
      longitude: _readDouble(json['longitude']),
      category: json['category'] as String,
      status: json['status'] as String,
      averageRating: _readDouble(json['averageRating']),
      coverImageUrls:
          (json['coverImageUrls'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
    );

Map<String, dynamic> _$PlaceDetailApiToJson(_PlaceDetailApi instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'city': instance.city,
      'country': instance.country,
      'address': instance.address,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'category': instance.category,
      'status': instance.status,
      'averageRating': instance.averageRating,
      'coverImageUrls': instance.coverImageUrls,
    };

_PlacePageMeta _$PlacePageMetaFromJson(Map<String, dynamic> json) =>
    _PlacePageMeta(
      page: _readInt(json['page']),
      limit: _readInt(json['limit']),
      total: _readInt(json['total']),
      totalPages: _readInt(json['totalPages']),
      hasNextPage: json['hasNextPage'] as bool,
      hasPreviousPage: json['hasPreviousPage'] as bool,
    );

Map<String, dynamic> _$PlacePageMetaToJson(_PlacePageMeta instance) =>
    <String, dynamic>{
      'page': instance.page,
      'limit': instance.limit,
      'total': instance.total,
      'totalPages': instance.totalPages,
      'hasNextPage': instance.hasNextPage,
      'hasPreviousPage': instance.hasPreviousPage,
    };

_PlaceRatingDistribution _$PlaceRatingDistributionFromJson(
  Map<String, dynamic> json,
) => _PlaceRatingDistribution(
  one: _readInt(json['1']),
  two: _readInt(json['2']),
  three: _readInt(json['3']),
  four: _readInt(json['4']),
  five: _readInt(json['5']),
);

Map<String, dynamic> _$PlaceRatingDistributionToJson(
  _PlaceRatingDistribution instance,
) => <String, dynamic>{
  '1': instance.one,
  '2': instance.two,
  '3': instance.three,
  '4': instance.four,
  '5': instance.five,
};

_PlaceRatingSummaryApi _$PlaceRatingSummaryApiFromJson(
  Map<String, dynamic> json,
) => _PlaceRatingSummaryApi(
  averageRating: _readDouble(json['averageRating']),
  totalReviews: _readInt(json['totalReviews']),
  distribution: PlaceRatingDistribution.fromJson(
    json['distribution'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$PlaceRatingSummaryApiToJson(
  _PlaceRatingSummaryApi instance,
) => <String, dynamic>{
  'averageRating': instance.averageRating,
  'totalReviews': instance.totalReviews,
  'distribution': instance.distribution,
};

_PlaceReviewUserApi _$PlaceReviewUserApiFromJson(Map<String, dynamic> json) =>
    _PlaceReviewUserApi(
      id: json['id'] as String,
      username: json['username'] as String,
      avatarId: json['avatarId'] as String?,
    );

Map<String, dynamic> _$PlaceReviewUserApiToJson(_PlaceReviewUserApi instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'avatarId': instance.avatarId,
    };

_PlaceReviewPlaceApi _$PlaceReviewPlaceApiFromJson(Map<String, dynamic> json) =>
    _PlaceReviewPlaceApi(
      id: json['id'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$PlaceReviewPlaceApiToJson(
  _PlaceReviewPlaceApi instance,
) => <String, dynamic>{'id': instance.id, 'name': instance.name};

_PlaceReviewApi _$PlaceReviewApiFromJson(Map<String, dynamic> json) =>
    _PlaceReviewApi(
      id: json['id'] as String,
      userId: json['userId'] as String,
      placeId: json['placeId'] as String,
      rating: _readDouble(json['rating']),
      comment: json['comment'] as String?,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
      user: PlaceReviewUserApi.fromJson(json['user'] as Map<String, dynamic>),
      place: json['place'] == null
          ? null
          : PlaceReviewPlaceApi.fromJson(json['place'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PlaceReviewApiToJson(_PlaceReviewApi instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'placeId': instance.placeId,
      'rating': instance.rating,
      'comment': instance.comment,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'user': instance.user,
      'place': instance.place,
    };

_PlaceReviewsPage _$PlaceReviewsPageFromJson(Map<String, dynamic> json) =>
    _PlaceReviewsPage(
      data:
          (json['data'] as List<dynamic>?)
              ?.map((e) => PlaceReviewApi.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <PlaceReviewApi>[],
      meta: PlacePageMeta.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PlaceReviewsPageToJson(_PlaceReviewsPage instance) =>
    <String, dynamic>{'data': instance.data, 'meta': instance.meta};

_PlaceSaveStatusApi _$PlaceSaveStatusApiFromJson(Map<String, dynamic> json) =>
    _PlaceSaveStatusApi(
      saved: json['saved'] as bool,
      savedAt: json['savedAt'] as String?,
    );

Map<String, dynamic> _$PlaceSaveStatusApiToJson(_PlaceSaveStatusApi instance) =>
    <String, dynamic>{'saved': instance.saved, 'savedAt': instance.savedAt};

_PlacePostAuthorApi _$PlacePostAuthorApiFromJson(Map<String, dynamic> json) =>
    _PlacePostAuthorApi(
      id: json['id'] as String,
      username: json['username'] as String,
      avatarId: json['avatarId'] as String?,
    );

Map<String, dynamic> _$PlacePostAuthorApiToJson(_PlacePostAuthorApi instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'avatarId': instance.avatarId,
    };

_PlacePostMediaApi _$PlacePostMediaApiFromJson(Map<String, dynamic> json) =>
    _PlacePostMediaApi(
      mediaId: json['mediaId'] as String,
      orderIndex: _readInt(json['orderIndex']),
    );

Map<String, dynamic> _$PlacePostMediaApiToJson(_PlacePostMediaApi instance) =>
    <String, dynamic>{
      'mediaId': instance.mediaId,
      'orderIndex': instance.orderIndex,
    };

_PlacePostApi _$PlacePostApiFromJson(
  Map<String, dynamic> json,
) => _PlacePostApi(
  id: json['id'] as String,
  caption: json['caption'] as String?,
  likesCount: _readInt(json['likesCount']),
  author: PlacePostAuthorApi.fromJson(json['author'] as Map<String, dynamic>),
  postMedias:
      (json['postMedias'] as List<dynamic>?)
          ?.map((e) => PlacePostMediaApi.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <PlacePostMediaApi>[],
);

Map<String, dynamic> _$PlacePostApiToJson(_PlacePostApi instance) =>
    <String, dynamic>{
      'id': instance.id,
      'caption': instance.caption,
      'likesCount': instance.likesCount,
      'author': instance.author,
      'postMedias': instance.postMedias,
    };

_PlacePostsPage _$PlacePostsPageFromJson(Map<String, dynamic> json) =>
    _PlacePostsPage(
      data:
          (json['data'] as List<dynamic>?)
              ?.map((e) => PlacePostApi.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <PlacePostApi>[],
      meta: PlacePageMeta.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PlacePostsPageToJson(_PlacePostsPage instance) =>
    <String, dynamic>{'data': instance.data, 'meta': instance.meta};
