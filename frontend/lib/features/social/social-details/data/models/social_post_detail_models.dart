import 'package:freezed_annotation/freezed_annotation.dart';

part 'social_post_detail_models.freezed.dart';
part 'social_post_detail_models.g.dart';

int _readInt(Object? value) {
  if (value is int) return value;
  if (value is num) return value.toInt();
  return int.tryParse(value?.toString() ?? '') ?? 0;
}

DateTime _readDateTime(Object? value) {
  if (value is DateTime) return value;
  return DateTime.tryParse(value?.toString() ?? '') ?? DateTime.now();
}

@freezed
abstract class SocialPostDetail with _$SocialPostDetail {
  const factory SocialPostDetail({
    required String id,
    required String authorId,
    String? placeId,
    String? caption,
    @Default('PUBLIC') String visibility,
    String? tipTitle,
    String? tipBody,
    String? topic,
    String? placeDetail,
    @JsonKey(fromJson: _readInt) @Default(0) int likesCount,
    @JsonKey(fromJson: _readInt) @Default(0) int commentsCount,
    @JsonKey(fromJson: _readInt) @Default(0) int sharesCount,
    @JsonKey(fromJson: _readInt) @Default(0) int savesCount,
    @JsonKey(fromJson: _readDateTime) required DateTime createdAt,
    required SocialPostDetailAuthor author,
    SocialPostDetailPlace? place,
    @Default(<SocialPostDetailMedia>[]) List<SocialPostDetailMedia> postMedias,
    @Default(false) bool liked,
    @Default(false) bool shared,
    @Default(false) bool bookmarked,
    String? trendLabel,
    @Default('') String timeLabel,
  }) = _SocialPostDetail;

  factory SocialPostDetail.fromJson(Map<String, dynamic> json) =>
      _$SocialPostDetailFromJson(json);
}

@freezed
abstract class SocialPostDetailAuthor with _$SocialPostDetailAuthor {
  const factory SocialPostDetailAuthor({
    required String id,
    required String username,
    String? displayName,
    String? avatarId,
    String? avatarUrl,
    String? badgeLabel,
    @Default(false) bool verified,
  }) = _SocialPostDetailAuthor;

  factory SocialPostDetailAuthor.fromJson(Map<String, dynamic> json) =>
      _$SocialPostDetailAuthorFromJson(json);
}

@freezed
abstract class SocialPostDetailPlace with _$SocialPostDetailPlace {
  const factory SocialPostDetailPlace({
    required String id,
    required String name,
    String? detail,
  }) = _SocialPostDetailPlace;

  factory SocialPostDetailPlace.fromJson(Map<String, dynamic> json) =>
      _$SocialPostDetailPlaceFromJson(json);
}

@freezed
abstract class SocialPostDetailMedia with _$SocialPostDetailMedia {
  const factory SocialPostDetailMedia({
    required String mediaId,
    @JsonKey(fromJson: _readInt) @Default(0) int orderIndex,
    String? url,
  }) = _SocialPostDetailMedia;

  factory SocialPostDetailMedia.fromJson(Map<String, dynamic> json) =>
      _$SocialPostDetailMediaFromJson(json);
}

@freezed
abstract class SocialPostDetailComment with _$SocialPostDetailComment {
  const factory SocialPostDetailComment({
    required String id,
    required String postId,
    required String userId,
    required String content,
    @JsonKey(fromJson: _readDateTime) required DateTime createdAt,
    required SocialPostDetailCommentUser user,
  }) = _SocialPostDetailComment;

  factory SocialPostDetailComment.fromJson(Map<String, dynamic> json) =>
      _$SocialPostDetailCommentFromJson(json);
}

@freezed
abstract class SocialPostDetailCommentUser with _$SocialPostDetailCommentUser {
  const factory SocialPostDetailCommentUser({
    required String id,
    required String username,
    String? avatarId,
    String? avatarUrl,
  }) = _SocialPostDetailCommentUser;

  factory SocialPostDetailCommentUser.fromJson(Map<String, dynamic> json) =>
      _$SocialPostDetailCommentUserFromJson(json);
}

@freezed
abstract class SocialPostDetailCommentsPage
    with _$SocialPostDetailCommentsPage {
  const factory SocialPostDetailCommentsPage({
    @Default(<SocialPostDetailComment>[]) List<SocialPostDetailComment> data,
    required SocialPostDetailPageMeta meta,
  }) = _SocialPostDetailCommentsPage;

  factory SocialPostDetailCommentsPage.fromJson(Map<String, dynamic> json) =>
      _$SocialPostDetailCommentsPageFromJson(json);
}

@freezed
abstract class SocialPostDetailPageMeta with _$SocialPostDetailPageMeta {
  const factory SocialPostDetailPageMeta({
    @JsonKey(fromJson: _readInt) @Default(1) int page,
    @JsonKey(fromJson: _readInt) @Default(20) int limit,
    @JsonKey(fromJson: _readInt) @Default(0) int total,
    @JsonKey(fromJson: _readInt) @Default(0) int totalPages,
    @Default(false) bool hasNextPage,
    @Default(false) bool hasPreviousPage,
  }) = _SocialPostDetailPageMeta;

  factory SocialPostDetailPageMeta.fromJson(Map<String, dynamic> json) =>
      _$SocialPostDetailPageMetaFromJson(json);
}
