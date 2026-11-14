import 'social_feed_models.dart';

/// Maps enriched `GET /social/posts/:id` payload → feed review card model.
SocialFeedReviewPost socialPostDetailToReview(Map<String, dynamic> json) {
  final authorJson = json['author'];
  final authorMap = authorJson is Map<String, dynamic>
      ? authorJson
      : authorJson is Map
      ? Map<String, dynamic>.from(authorJson)
      : const <String, dynamic>{};
  final placeJson = json['place'];
  final placeMap = placeJson is Map<String, dynamic>
      ? placeJson
      : placeJson is Map
      ? Map<String, dynamic>.from(placeJson)
      : null;
  final mediasRaw = json['postMedias'];
  final medias = <SocialFeedMedia>[];
  if (mediasRaw is List) {
    for (var i = 0; i < mediasRaw.length; i++) {
      final item = mediasRaw[i];
      final map = item is Map<String, dynamic>
          ? item
          : item is Map
          ? Map<String, dynamic>.from(item)
          : null;
      if (map == null) continue;
      final url = map['url']?.toString() ?? '';
      if (url.isEmpty) continue;
      medias.add(
        SocialFeedMedia(
          id: map['mediaId']?.toString() ?? 'media-$i',
          imageUrl: url,
          isHero: i == 0,
          overlayLabel: i == 0 ? (placeMap?['name']?.toString()) : null,
        ),
      );
    }
  }

  final previewJson = json['previewComment'];
  SocialFeedPreviewComment? preview;
  if (previewJson is Map) {
    final previewMap = previewJson is Map<String, dynamic>
        ? previewJson
        : Map<String, dynamic>.from(previewJson);
    preview = SocialFeedPreviewComment(
      id: previewMap['id']?.toString() ?? '',
      authorName: previewMap['authorName']?.toString() ?? '',
      avatarUrl: previewMap['avatarUrl']?.toString(),
      text: previewMap['text']?.toString() ?? '',
      timeLabel: previewMap['timeLabel']?.toString() ?? '',
      replyLabel: previewMap['replyLabel']?.toString(),
    );
  }

  final visible = medias.take(2).toList(growable: false);
  return SocialFeedReviewPost(
    postId: json['id']?.toString() ?? '',
    author: SocialFeedAuthor(
      id: authorMap['id']?.toString() ?? '',
      displayName:
          authorMap['displayName']?.toString() ??
          authorMap['displayname']?.toString() ??
          authorMap['username']?.toString() ??
          'Traveler',
      avatarUrl: authorMap['avatarUrl']?.toString(),
      badgeLabel: authorMap['badgeLabel']?.toString(),
      verified: authorMap['verified'] == true,
    ),
    timeLabel: json['timeLabel']?.toString() ?? '',
    trendLabel: json['trendLabel']?.toString(),
    placeLabel: placeMap?['name']?.toString(),
    placeDetail:
        json['placeDetail']?.toString() ?? placeMap?['detail']?.toString(),
    placeId: json['placeId']?.toString() ?? placeMap?['id']?.toString(),
    caption: json['caption']?.toString() ?? '',
    tipTitle: json['tipTitle']?.toString(),
    tipBody: json['tipBody']?.toString(),
    medias: visible,
    extraMediaCount: medias.length > visible.length
        ? medias.length - visible.length
        : 0,
    primaryCtaLabel: 'Xem địa điểm',
    secondaryCtaLabel: 'Lưu / lịch trình',
    likesCount: _asInt(json['likesCount']),
    commentsCount: _asInt(json['commentsCount']),
    savesCount: _asInt(json['savesCount']),
    liked: json['liked'] == true,
    bookmarked: json['bookmarked'] == true,
    previewComment: preview,
  );
}

int _asInt(Object? value) {
  if (value is int) return value;
  if (value is num) return value.toInt();
  return int.tryParse(value?.toString() ?? '') ?? 0;
}
