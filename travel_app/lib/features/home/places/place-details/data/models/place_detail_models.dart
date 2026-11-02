import 'package:freezed_annotation/freezed_annotation.dart';

part 'place_detail_models.freezed.dart';
part 'place_detail_models.g.dart';

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

@freezed
abstract class PlaceDetailApi with _$PlaceDetailApi {
  const factory PlaceDetailApi({
    required String id,
    required String name,
    String? description,
    required String city,
    required String country,
    required String address,
    @JsonKey(fromJson: _readDouble) required double latitude,
    @JsonKey(fromJson: _readDouble) required double longitude,
    required String category,
    required String status,
    @JsonKey(fromJson: _readDouble) required double averageRating,
    @Default(<String>[]) List<String> coverImageUrls,
  }) = _PlaceDetailApi;

  factory PlaceDetailApi.fromJson(Map<String, dynamic> json) =>
      _$PlaceDetailApiFromJson(json);
}

@freezed
abstract class PlacePageMeta with _$PlacePageMeta {
  const factory PlacePageMeta({
    @JsonKey(fromJson: _readInt) required int page,
    @JsonKey(fromJson: _readInt) required int limit,
    @JsonKey(fromJson: _readInt) required int total,
    @JsonKey(fromJson: _readInt) required int totalPages,
    required bool hasNextPage,
    required bool hasPreviousPage,
  }) = _PlacePageMeta;

  factory PlacePageMeta.fromJson(Map<String, dynamic> json) {
    final page = _readInt(json['page']);
    final totalPages = _readInt(json['totalPages']);
    return _$PlacePageMetaFromJson({
      ...json,
      'hasNextPage': json['hasNextPage'] ?? page < totalPages,
      'hasPreviousPage': json['hasPreviousPage'] ?? page > 1,
    });
  }
}

@freezed
abstract class PlaceRatingDistribution with _$PlaceRatingDistribution {
  const factory PlaceRatingDistribution({
    @JsonKey(name: '1', fromJson: _readInt) required int one,
    @JsonKey(name: '2', fromJson: _readInt) required int two,
    @JsonKey(name: '3', fromJson: _readInt) required int three,
    @JsonKey(name: '4', fromJson: _readInt) required int four,
    @JsonKey(name: '5', fromJson: _readInt) required int five,
  }) = _PlaceRatingDistribution;

  factory PlaceRatingDistribution.fromJson(Map<String, dynamic> json) =>
      _$PlaceRatingDistributionFromJson(json);
}

@freezed
abstract class PlaceRatingSummaryApi with _$PlaceRatingSummaryApi {
  const factory PlaceRatingSummaryApi({
    @JsonKey(fromJson: _readDouble) required double averageRating,
    @JsonKey(fromJson: _readInt) required int totalReviews,
    required PlaceRatingDistribution distribution,
  }) = _PlaceRatingSummaryApi;

  factory PlaceRatingSummaryApi.fromJson(Map<String, dynamic> json) =>
      _$PlaceRatingSummaryApiFromJson(json);
}

@freezed
abstract class PlaceReviewUserApi with _$PlaceReviewUserApi {
  const factory PlaceReviewUserApi({
    required String id,
    required String username,
    String? avatarId,
  }) = _PlaceReviewUserApi;

  factory PlaceReviewUserApi.fromJson(Map<String, dynamic> json) =>
      _$PlaceReviewUserApiFromJson(json);
}

@freezed
abstract class PlaceReviewPlaceApi with _$PlaceReviewPlaceApi {
  const factory PlaceReviewPlaceApi({
    required String id,
    required String name,
  }) = _PlaceReviewPlaceApi;

  factory PlaceReviewPlaceApi.fromJson(Map<String, dynamic> json) =>
      _$PlaceReviewPlaceApiFromJson(json);
}

@freezed
abstract class PlaceReviewApi with _$PlaceReviewApi {
  const factory PlaceReviewApi({
    required String id,
    required String userId,
    required String placeId,
    @JsonKey(fromJson: _readDouble) required double rating,
    String? comment,
    required String createdAt,
    required String updatedAt,
    required PlaceReviewUserApi user,
    PlaceReviewPlaceApi? place,
  }) = _PlaceReviewApi;

  factory PlaceReviewApi.fromJson(Map<String, dynamic> json) =>
      _$PlaceReviewApiFromJson({
        ...json,
        'updatedAt': json['updatedAt'] ?? json['createdAt'],
      });
}

@freezed
abstract class PlaceReviewsPage with _$PlaceReviewsPage {
  const factory PlaceReviewsPage({
    @Default(<PlaceReviewApi>[]) List<PlaceReviewApi> data,
    required PlacePageMeta meta,
  }) = _PlaceReviewsPage;

  factory PlaceReviewsPage.fromJson(Map<String, dynamic> json) =>
      _$PlaceReviewsPageFromJson(json);
}

@freezed
abstract class PlaceSaveStatusApi with _$PlaceSaveStatusApi {
  const factory PlaceSaveStatusApi({required bool saved, String? savedAt}) =
      _PlaceSaveStatusApi;

  factory PlaceSaveStatusApi.fromJson(Map<String, dynamic> json) =>
      _$PlaceSaveStatusApiFromJson(json);
}

@freezed
abstract class PlacePostAuthorApi with _$PlacePostAuthorApi {
  const factory PlacePostAuthorApi({
    required String id,
    required String username,
    String? avatarId,
  }) = _PlacePostAuthorApi;

  factory PlacePostAuthorApi.fromJson(Map<String, dynamic> json) =>
      _$PlacePostAuthorApiFromJson(json);
}

@freezed
abstract class PlacePostMediaApi with _$PlacePostMediaApi {
  const factory PlacePostMediaApi({
    required String mediaId,
    @JsonKey(fromJson: _readInt) required int orderIndex,
  }) = _PlacePostMediaApi;

  factory PlacePostMediaApi.fromJson(Map<String, dynamic> json) =>
      _$PlacePostMediaApiFromJson(json);
}

@freezed
abstract class PlacePostApi with _$PlacePostApi {
  const factory PlacePostApi({
    required String id,
    String? caption,
    @JsonKey(fromJson: _readInt) required int likesCount,
    required PlacePostAuthorApi author,
    @Default(<PlacePostMediaApi>[]) List<PlacePostMediaApi> postMedias,
  }) = _PlacePostApi;

  factory PlacePostApi.fromJson(Map<String, dynamic> json) =>
      _$PlacePostApiFromJson(json);
}

@freezed
abstract class PlacePostsPage with _$PlacePostsPage {
  const factory PlacePostsPage({
    @Default(<PlacePostApi>[]) List<PlacePostApi> data,
    required PlacePageMeta meta,
  }) = _PlacePostsPage;

  factory PlacePostsPage.fromJson(Map<String, dynamic> json) =>
      _$PlacePostsPageFromJson(json);
}
