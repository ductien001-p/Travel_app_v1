// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_explore_api_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FeaturedPlacesData _$FeaturedPlacesDataFromJson(Map<String, dynamic> json) =>
    _FeaturedPlacesData(
      subtitle: json['subtitle'] as String,
      date: json['date'] as String,
      places:
          (json['places'] as List<dynamic>?)
              ?.map((e) => FeaturedPlaceApi.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <FeaturedPlaceApi>[],
    );

Map<String, dynamic> _$FeaturedPlacesDataToJson(_FeaturedPlacesData instance) =>
    <String, dynamic>{
      'subtitle': instance.subtitle,
      'date': instance.date,
      'places': instance.places,
    };

_FeaturedPlaceApi _$FeaturedPlaceApiFromJson(Map<String, dynamic> json) =>
    _FeaturedPlaceApi(
      id: json['id'] as String,
      name: json['name'] as String,
      coverImageUrl: json['coverImageUrl'] as String?,
      category: json['category'] as String,
      averageRating: _readDouble(json['averageRating']),
      saveCount: _readInt(json['saveCount']),
      city: json['city'] as String,
      address: json['address'] as String,
      description: json['description'] as String?,
      bookmarked: json['bookmarked'] as bool? ?? false,
    );

Map<String, dynamic> _$FeaturedPlaceApiToJson(_FeaturedPlaceApi instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'coverImageUrl': instance.coverImageUrl,
      'category': instance.category,
      'averageRating': instance.averageRating,
      'saveCount': instance.saveCount,
      'city': instance.city,
      'address': instance.address,
      'description': instance.description,
      'bookmarked': instance.bookmarked,
    };

_NearbyPlaceApi _$NearbyPlaceApiFromJson(Map<String, dynamic> json) =>
    _NearbyPlaceApi(
      id: json['id'] as String,
      name: json['name'] as String,
      coverImageUrl: json['coverImageUrl'] as String?,
      category: json['category'] as String,
      averageRating: _readDouble(json['averageRating']),
      reviewCount: _readInt(json['reviewCount']),
      address: json['address'] as String,
      distanceMeters: _readInt(json['distanceMeters']),
      travelMode: json['travelMode'] as String,
      travelMinutes: _readInt(json['travelMinutes']),
    );

Map<String, dynamic> _$NearbyPlaceApiToJson(_NearbyPlaceApi instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'coverImageUrl': instance.coverImageUrl,
      'category': instance.category,
      'averageRating': instance.averageRating,
      'reviewCount': instance.reviewCount,
      'address': instance.address,
      'distanceMeters': instance.distanceMeters,
      'travelMode': instance.travelMode,
      'travelMinutes': instance.travelMinutes,
    };

_FeaturedCollectionApi _$FeaturedCollectionApiFromJson(
  Map<String, dynamic> json,
) => _FeaturedCollectionApi(
  id: json['id'] as String,
  title: json['title'] as String,
  ownerDisplayName: json['ownerDisplayName'] as String,
  coverImageUrl: json['coverImageUrl'] as String?,
  placeCount: _readInt(json['placeCount']),
  averageRating: _readDoubleOrNull(json['averageRating']),
  ratingCount: _readInt(json['ratingCount']),
);

Map<String, dynamic> _$FeaturedCollectionApiToJson(
  _FeaturedCollectionApi instance,
) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'ownerDisplayName': instance.ownerDisplayName,
  'coverImageUrl': instance.coverImageUrl,
  'placeCount': instance.placeCount,
  'averageRating': instance.averageRating,
  'ratingCount': instance.ratingCount,
};

_OwnedPlaceCollection _$OwnedPlaceCollectionFromJson(
  Map<String, dynamic> json,
) => _OwnedPlaceCollection(
  id: json['id'] as String,
  title: json['title'] as String,
  visibility: json['visibility'] as String,
  placeCount: _readInt(json['placeCount']),
  placeIds:
      (json['placeIds'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const <String>[],
);

Map<String, dynamic> _$OwnedPlaceCollectionToJson(
  _OwnedPlaceCollection instance,
) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'visibility': instance.visibility,
  'placeCount': instance.placeCount,
  'placeIds': instance.placeIds,
};

_CollectionPlaceItem _$CollectionPlaceItemFromJson(Map<String, dynamic> json) =>
    _CollectionPlaceItem(
      id: json['id'] as String,
      name: json['name'] as String,
      coverImageUrl: json['coverImageUrl'] as String?,
      category: json['category'] as String,
      city: json['city'] as String,
      averageRating: _readDouble(json['averageRating']),
    );

Map<String, dynamic> _$CollectionPlaceItemToJson(
  _CollectionPlaceItem instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'coverImageUrl': instance.coverImageUrl,
  'category': instance.category,
  'city': instance.city,
  'averageRating': instance.averageRating,
};

_PlaceCollectionDetail _$PlaceCollectionDetailFromJson(
  Map<String, dynamic> json,
) => _PlaceCollectionDetail(
  id: json['id'] as String,
  title: json['title'] as String,
  visibility: json['visibility'] as String,
  ownerDisplayName: json['ownerDisplayName'] as String,
  coverImageUrl: json['coverImageUrl'] as String?,
  placeCount: _readInt(json['placeCount']),
  averageRating: _readDoubleOrNull(json['averageRating']),
  ratingCount: _readInt(json['ratingCount']),
  viewerRating: _readIntNullable(json['viewerRating']),
  copiedByViewer: json['copiedByViewer'] as bool? ?? false,
  places:
      (json['places'] as List<dynamic>?)
          ?.map((e) => CollectionPlaceItem.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <CollectionPlaceItem>[],
);

Map<String, dynamic> _$PlaceCollectionDetailToJson(
  _PlaceCollectionDetail instance,
) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'visibility': instance.visibility,
  'ownerDisplayName': instance.ownerDisplayName,
  'coverImageUrl': instance.coverImageUrl,
  'placeCount': instance.placeCount,
  'averageRating': instance.averageRating,
  'ratingCount': instance.ratingCount,
  'viewerRating': instance.viewerRating,
  'copiedByViewer': instance.copiedByViewer,
  'places': instance.places,
};

_PlaceEmbeddingSearchApi _$PlaceEmbeddingSearchApiFromJson(
  Map<String, dynamic> json,
) => _PlaceEmbeddingSearchApi(
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String?,
  latitude: _readDouble(json['latitude']),
  longitude: _readDouble(json['longitude']),
  similarity: _readDouble(json['similarity']),
  distanceKm: _readDoubleOrNull(json['distance_km']),
  category: json['category'] as String?,
  address: json['address'] as String?,
  averageRating: _readDoubleOrNull(json['averageRating']),
  reviewCount: _readIntNullable(json['reviewCount']),
  thumbnailUrl: json['thumbnailUrl'] as String?,
  saveCount: _readInt(json['saveCount']),
  bookmarked: json['bookmarked'] as bool? ?? false,
);

Map<String, dynamic> _$PlaceEmbeddingSearchApiToJson(
  _PlaceEmbeddingSearchApi instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'description': instance.description,
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'similarity': instance.similarity,
  'distance_km': instance.distanceKm,
  'category': instance.category,
  'address': instance.address,
  'averageRating': instance.averageRating,
  'reviewCount': instance.reviewCount,
  'thumbnailUrl': instance.thumbnailUrl,
  'saveCount': instance.saveCount,
  'bookmarked': instance.bookmarked,
};
