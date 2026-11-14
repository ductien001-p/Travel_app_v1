import 'package:freezed_annotation/freezed_annotation.dart';

part 'social_feed_models.freezed.dart';
part 'social_feed_models.g.dart';

/// Aggregate payload for Social Feed (`GET /social/feed`).
@freezed
abstract class SocialFeed with _$SocialFeed {
  const factory SocialFeed({
    required SocialFeedHeader header,
    required SocialFeedComposer composer,
    @Default(<SocialFeedStory>[]) List<SocialFeedStory> stories,
    @Default(<SocialFeedTab>[]) List<SocialFeedTab> tabs,
    @Default(<SocialFeedTopicChip>[]) List<SocialFeedTopicChip> topicChips,
    @Default(<SocialFeedItem>[]) List<SocialFeedItem> items,
    SocialFeedMeta? meta,
  }) = _SocialFeed;

  factory SocialFeed.fromJson(Map<String, dynamic> json) =>
      _$SocialFeedFromJson(json);
}

@freezed
abstract class SocialFeedMeta with _$SocialFeedMeta {
  const factory SocialFeedMeta({
    @JsonKey(fromJson: _readInt) @Default(1) int page,
    @JsonKey(fromJson: _readInt) @Default(10) int limit,
    @JsonKey(fromJson: _readInt) @Default(0) int total,
    @JsonKey(fromJson: _readInt) @Default(0) int totalPages,
    @Default(false) bool hasNextPage,
    @Default(false) bool hasPreviousPage,
  }) = _SocialFeedMeta;

  factory SocialFeedMeta.fromJson(Map<String, dynamic> json) =>
      _$SocialFeedMetaFromJson(json);
}

@freezed
abstract class SocialFeedHeader with _$SocialFeedHeader {
  const factory SocialFeedHeader({
    required String title,
    required String streakLabel,
    @Default(false) bool hasUnreadNotifications,
    @Default(true) bool showFriendsCta,
  }) = _SocialFeedHeader;

  factory SocialFeedHeader.fromJson(Map<String, dynamic> json) =>
      _$SocialFeedHeaderFromJson(json);
}

@freezed
abstract class SocialFeedComposer with _$SocialFeedComposer {
  const factory SocialFeedComposer({
    required String displayName,
    String? avatarUrl,
    required String prompt,
  }) = _SocialFeedComposer;

  factory SocialFeedComposer.fromJson(Map<String, dynamic> json) =>
      _$SocialFeedComposerFromJson(json);
}

enum SocialFeedStoryBadge {
  @JsonValue('NONE')
  none,
  @JsonValue('LIVE')
  live,
  @JsonValue('NEW')
  neu,
}

@freezed
abstract class SocialFeedStory with _$SocialFeedStory {
  const factory SocialFeedStory({
    required String id,
    required String label,
    String? imageUrl,
    @Default(false) bool isSelf,
    @Default(false) bool isActive,
    @Default(SocialFeedStoryBadge.none) SocialFeedStoryBadge badge,
  }) = _SocialFeedStory;

  factory SocialFeedStory.fromJson(Map<String, dynamic> json) =>
      _$SocialFeedStoryFromJson(json);
}

@freezed
abstract class SocialFeedTab with _$SocialFeedTab {
  const factory SocialFeedTab({
    required String id,
    required String label,
    String? badgeLabel,
    String? emoji,
    @Default(false) bool selected,
  }) = _SocialFeedTab;

  factory SocialFeedTab.fromJson(Map<String, dynamic> json) =>
      _$SocialFeedTabFromJson(json);
}

@freezed
abstract class SocialFeedTopicChip with _$SocialFeedTopicChip {
  const factory SocialFeedTopicChip({
    required String id,
    required String label,
    @Default(false) bool selected,
  }) = _SocialFeedTopicChip;

  factory SocialFeedTopicChip.fromJson(Map<String, dynamic> json) =>
      _$SocialFeedTopicChipFromJson(json);
}

enum SocialFeedItemType {
  @JsonValue('REVIEW')
  review,
  @JsonValue('CHALLENGE')
  challenge,
  @JsonValue('TRIP_RECRUIT')
  tripRecruit,
}

@freezed
abstract class SocialFeedItem with _$SocialFeedItem {
  const factory SocialFeedItem({
    required String id,
    required SocialFeedItemType type,
    SocialFeedReviewPost? review,
    SocialFeedChallenge? challenge,
    SocialFeedTripRecruit? tripRecruit,
  }) = _SocialFeedItem;

  factory SocialFeedItem.fromJson(Map<String, dynamic> json) =>
      _$SocialFeedItemFromJson(json);
}

@freezed
abstract class SocialFeedAuthor with _$SocialFeedAuthor {
  const factory SocialFeedAuthor({
    required String id,
    required String displayName,
    String? avatarUrl,
    String? badgeLabel,
    @Default(false) bool verified,
  }) = _SocialFeedAuthor;

  factory SocialFeedAuthor.fromJson(Map<String, dynamic> json) =>
      _$SocialFeedAuthorFromJson(json);
}

@freezed
abstract class SocialFeedMedia with _$SocialFeedMedia {
  const factory SocialFeedMedia({
    required String id,
    required String imageUrl,
    String? caption,
    @Default(false) bool isHero,
    String? overlayLabel,
  }) = _SocialFeedMedia;

  factory SocialFeedMedia.fromJson(Map<String, dynamic> json) =>
      _$SocialFeedMediaFromJson(json);
}

@freezed
abstract class SocialFeedPreviewComment with _$SocialFeedPreviewComment {
  const factory SocialFeedPreviewComment({
    required String id,
    required String authorName,
    String? avatarUrl,
    required String text,
    required String timeLabel,
    String? replyLabel,
  }) = _SocialFeedPreviewComment;

  factory SocialFeedPreviewComment.fromJson(Map<String, dynamic> json) =>
      _$SocialFeedPreviewCommentFromJson(json);
}

@freezed
abstract class SocialFeedReviewPost with _$SocialFeedReviewPost {
  const factory SocialFeedReviewPost({
    required String postId,
    required SocialFeedAuthor author,
    required String timeLabel,
    String? trendLabel,
    String? placeLabel,
    String? placeDetail,
    String? placeId,
    String? savedByLabel,
    required String caption,
    String? tipTitle,
    String? tipBody,
    @Default(<SocialFeedMedia>[]) List<SocialFeedMedia> medias,
    @JsonKey(fromJson: _readInt) @Default(0) int extraMediaCount,
    String? primaryCtaLabel,
    String? secondaryCtaLabel,
    @JsonKey(fromJson: _readInt) @Default(0) int likesCount,
    @JsonKey(fromJson: _readInt) @Default(0) int commentsCount,
    @JsonKey(fromJson: _readInt) @Default(0) int savesCount,
    @Default(false) bool liked,
    @Default(false) bool bookmarked,
    SocialFeedPreviewComment? previewComment,
  }) = _SocialFeedReviewPost;

  factory SocialFeedReviewPost.fromJson(Map<String, dynamic> json) =>
      _$SocialFeedReviewPostFromJson(json);
}

@freezed
abstract class SocialFeedChallenge with _$SocialFeedChallenge {
  const factory SocialFeedChallenge({
    required String id,
    required String eyebrow,
    required String title,
    required String rewardLabel,
    required String progressLabel,
    @JsonKey(fromJson: _readDouble) @Default(0) double progressRatio,
    required String daysLeftLabel,
    required String badgeLabel,
    required String ctaLabel,
  }) = _SocialFeedChallenge;

  factory SocialFeedChallenge.fromJson(Map<String, dynamic> json) =>
      _$SocialFeedChallengeFromJson(json);
}

@freezed
abstract class SocialFeedTripRecruit with _$SocialFeedTripRecruit {
  const factory SocialFeedTripRecruit({
    required String postId,
    required SocialFeedAuthor author,
    required String timeLabel,
    required String recruitBadge,
    required String placeLabel,
    required String caption,
    required String tripId,
    required String tripTitle,
    required String spotsLeftLabel,
    required String urgencyLabel,
    required String scheduleLabel,
    required String priceLabel,
    required String membersLabel,
    @JsonKey(fromJson: _readDouble) @Default(0) double fillRatio,
    required String fillPercentLabel,
    @Default(<String>[]) List<String> memberAvatars,
    @JsonKey(fromJson: _readInt) @Default(0) int extraMemberCount,
    String? highlightLabel,
    String? highlightDetail,
    @JsonKey(fromJson: _readInt) @Default(0) int likesCount,
    @JsonKey(fromJson: _readInt) @Default(0) int commentsCount,
    @JsonKey(fromJson: _readInt) @Default(0) int sharesCount,
    @Default(false) bool liked,
    @Default(false) bool bookmarked,
    required String itineraryCtaLabel,
    required String joinCtaLabel,
  }) = _SocialFeedTripRecruit;

  factory SocialFeedTripRecruit.fromJson(Map<String, dynamic> json) =>
      _$SocialFeedTripRecruitFromJson(json);
}

int _readInt(Object? value) {
  if (value is int) return value;
  if (value is num) return value.toInt();
  throw const FormatException('Expected an integer.');
}

double _readDouble(Object? value) {
  if (value is double) return value;
  if (value is num) return value.toDouble();
  throw const FormatException('Expected a number.');
}
