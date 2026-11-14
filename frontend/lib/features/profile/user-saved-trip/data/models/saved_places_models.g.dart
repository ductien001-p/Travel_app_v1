// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saved_places_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SavedPlacesPage _$SavedPlacesPageFromJson(Map<String, dynamic> json) =>
    _SavedPlacesPage(
      items:
          (json['data'] as List<dynamic>?)
              ?.map((e) => SavedPlace.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <SavedPlace>[],
      meta: SavedPlacesPageMeta.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SavedPlacesPageToJson(_SavedPlacesPage instance) =>
    <String, dynamic>{'data': instance.items, 'meta': instance.meta};

_SavedPlacesPageMeta _$SavedPlacesPageMetaFromJson(Map<String, dynamic> json) =>
    _SavedPlacesPageMeta(
      page: _readInt(json['page']),
      limit: _readInt(json['limit']),
      total: _readInt(json['total']),
      totalPages: _readInt(json['totalPages']),
      hasNextPage: json['hasNextPage'] as bool,
      hasPreviousPage: json['hasPreviousPage'] as bool,
    );

Map<String, dynamic> _$SavedPlacesPageMetaToJson(
  _SavedPlacesPageMeta instance,
) => <String, dynamic>{
  'page': instance.page,
  'limit': instance.limit,
  'total': instance.total,
  'totalPages': instance.totalPages,
  'hasNextPage': instance.hasNextPage,
  'hasPreviousPage': instance.hasPreviousPage,
};

_SavedPlacesCountEnvelope _$SavedPlacesCountEnvelopeFromJson(
  Map<String, dynamic> json,
) => _SavedPlacesCountEnvelope(
  data: SavedPlacesCount.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$SavedPlacesCountEnvelopeToJson(
  _SavedPlacesCountEnvelope instance,
) => <String, dynamic>{'data': instance.data};

_SavedPlacesCount _$SavedPlacesCountFromJson(Map<String, dynamic> json) =>
    _SavedPlacesCount(count: _readInt(json['count']));

Map<String, dynamic> _$SavedPlacesCountToJson(_SavedPlacesCount instance) =>
    <String, dynamic>{'count': instance.count};

_SavedPlace _$SavedPlaceFromJson(Map<String, dynamic> json) => _SavedPlace(
  id: json['id'] as String,
  userId: json['userId'] as String,
  placeId: json['placeId'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
  place: SavedPlaceDetails.fromJson(json['place'] as Map<String, dynamic>),
);

Map<String, dynamic> _$SavedPlaceToJson(_SavedPlace instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'placeId': instance.placeId,
      'createdAt': instance.createdAt.toIso8601String(),
      'place': instance.place,
    };

_SavedPlaceDetails _$SavedPlaceDetailsFromJson(Map<String, dynamic> json) =>
    _SavedPlaceDetails(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      category: json['category'] as String?,
      city: json['city'] as String,
      country: json['country'] as String,
      address: json['address'] as String?,
      latitude: _readDouble(json['latitude']),
      longitude: _readDouble(json['longitude']),
      averageRating: _readDouble(json['averageRating']),
    );

Map<String, dynamic> _$SavedPlaceDetailsToJson(_SavedPlaceDetails instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'category': instance.category,
      'city': instance.city,
      'country': instance.country,
      'address': instance.address,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'averageRating': instance.averageRating,
    };
