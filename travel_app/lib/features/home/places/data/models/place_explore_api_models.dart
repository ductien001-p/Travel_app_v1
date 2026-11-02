import 'package:freezed_annotation/freezed_annotation.dart';

part 'place_explore_api_models.freezed.dart';
part 'place_explore_api_models.g.dart';

int _readInt(Object? value) {
  if (value is int) return value;
  if (value is num) return value.toInt();
  return int.parse('$value');
}

double _readDouble(Object? value) {
  if (value is double) return value;
  if (value is num) return value.toDouble();
  return double.parse('$value');
}

double? _readDoubleOrNull(Object? value) {
  if (value == null) return null;
  return _readDouble(value);
}

@freezed
abstract class FeaturedPlacesData with _$FeaturedPlacesData {
  const factory FeaturedPlacesData({
    required String subtitle,
    required String date,
    @Default(<FeaturedPlaceApi>[]) List<FeaturedPlaceApi> places,
  }) = _FeaturedPlacesData;

  factory FeaturedPlacesData.fromJson(Map<String, dynamic> json) =>
      _$FeaturedPlacesDataFromJson(json);
}

@freezed
abstract class FeaturedPlaceApi with _$FeaturedPlaceApi {
  const factory FeaturedPlaceApi({
    required String id,
    required String name,
    String? coverImageUrl,
    required String category,
    @JsonKey(fromJson: _readDouble) required double averageRating,
    @JsonKey(fromJson: _readInt) required int saveCount,
    required String city,
    required String address,
    String? description,
    @Default(false) bool bookmarked,
  }) = _FeaturedPlaceApi;

  factory FeaturedPlaceApi.fromJson(Map<String, dynamic> json) =>
      _$FeaturedPlaceApiFromJson(json);
}

@freezed
abstract class NearbyPlaceApi with _$NearbyPlaceApi {
  const factory NearbyPlaceApi({
    required String id,
    required String name,
    String? coverImageUrl,
    required String category,
    @JsonKey(fromJson: _readDouble) required double averageRating,
    @JsonKey(fromJson: _readInt) required int reviewCount,
    required String address,
    @JsonKey(fromJson: _readInt) required int distanceMeters,
    required String travelMode,
    @JsonKey(fromJson: _readInt) required int travelMinutes,
  }) = _NearbyPlaceApi;

  factory NearbyPlaceApi.fromJson(Map<String, dynamic> json) =>
      _$NearbyPlaceApiFromJson(json);
}

@freezed
abstract class FeaturedCollectionApi with _$FeaturedCollectionApi {
  const factory FeaturedCollectionApi({
    required String id,
    required String title,
    required String ownerDisplayName,
    String? coverImageUrl,
    @JsonKey(fromJson: _readInt) required int placeCount,
    @JsonKey(fromJson: _readDoubleOrNull) double? averageRating,
    @JsonKey(fromJson: _readInt) required int ratingCount,
  }) = _FeaturedCollectionApi;

  factory FeaturedCollectionApi.fromJson(Map<String, dynamic> json) =>
      _$FeaturedCollectionApiFromJson(json);
}

@freezed
abstract class OwnedPlaceCollection with _$OwnedPlaceCollection {
  const factory OwnedPlaceCollection({
    required String id,
    required String title,
    required String visibility,
    @JsonKey(fromJson: _readInt) required int placeCount,
    @Default(<String>[]) List<String> placeIds,
  }) = _OwnedPlaceCollection;

  factory OwnedPlaceCollection.fromJson(Map<String, dynamic> json) =>
      _$OwnedPlaceCollectionFromJson(json);
}

@freezed
abstract class CollectionPlaceItem with _$CollectionPlaceItem {
  const factory CollectionPlaceItem({
    required String id,
    required String name,
    String? coverImageUrl,
    required String category,
    required String city,
    @JsonKey(fromJson: _readDouble) required double averageRating,
  }) = _CollectionPlaceItem;

  factory CollectionPlaceItem.fromJson(Map<String, dynamic> json) =>
      _$CollectionPlaceItemFromJson(json);
}

@freezed
abstract class PlaceCollectionDetail with _$PlaceCollectionDetail {
  const factory PlaceCollectionDetail({
    required String id,
    required String title,
    required String visibility,
    required String ownerDisplayName,
    String? coverImageUrl,
    @JsonKey(fromJson: _readInt) required int placeCount,
    @JsonKey(fromJson: _readDoubleOrNull) double? averageRating,
    @JsonKey(fromJson: _readInt) required int ratingCount,
    @JsonKey(fromJson: _readIntNullable) int? viewerRating,
    @Default(false) bool copiedByViewer,
    @Default(<CollectionPlaceItem>[]) List<CollectionPlaceItem> places,
  }) = _PlaceCollectionDetail;

  factory PlaceCollectionDetail.fromJson(Map<String, dynamic> json) =>
      _$PlaceCollectionDetailFromJson(json);
}

int? _readIntNullable(Object? value) {
  if (value == null) return null;
  return _readInt(value);
}

@freezed
abstract class PlaceEmbeddingSearchApi with _$PlaceEmbeddingSearchApi {
  const factory PlaceEmbeddingSearchApi({
    required String id,
    required String name,
    String? description,
    @JsonKey(fromJson: _readDouble) required double latitude,
    @JsonKey(fromJson: _readDouble) required double longitude,
    @JsonKey(fromJson: _readDouble) required double similarity,
    @JsonKey(name: 'distance_km', fromJson: _readDoubleOrNull)
    double? distanceKm,
    String? category,
    String? address,
    @JsonKey(fromJson: _readDoubleOrNull) double? averageRating,
    @JsonKey(fromJson: _readIntNullable) int? reviewCount,
    String? thumbnailUrl,
    @JsonKey(fromJson: _readInt) required int saveCount,
    @Default(false) bool bookmarked,
  }) = _PlaceEmbeddingSearchApi;

  factory PlaceEmbeddingSearchApi.fromJson(Map<String, dynamic> json) =>
      _$PlaceEmbeddingSearchApiFromJson(json);
}
