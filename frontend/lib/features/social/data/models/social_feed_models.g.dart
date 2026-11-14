// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'social_feed_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SocialFeed _$SocialFeedFromJson(Map<String, dynamic> json) => _SocialFeed(
  header: SocialFeedHeader.fromJson(json['header'] as Map<String, dynamic>),
  composer: SocialFeedComposer.fromJson(
    json['composer'] as Map<String, dynamic>,
  ),
  stories:
      (json['stories'] as List<dynamic>?)
          ?.map((e) => SocialFeedStory.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <SocialFeedStory>[],
  tabs:
      (json['tabs'] as List<dynamic>?)
          ?.map((e) => SocialFeedTab.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <SocialFeedTab>[],
  topicChips:
      (json['topicChips'] as List<dynamic>?)
          ?.map((e) => SocialFeedTopicChip.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <SocialFeedTopicChip>[],
  items:
      (json['items'] as List<dynamic>?)
          ?.map((e) => SocialFeedItem.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <SocialFeedItem>[],
  meta: json['meta'] == null
      ? null
      : SocialFeedMeta.fromJson(json['meta'] as Map<String, dynamic>),
);

Map<String, dynamic> _$SocialFeedToJson(_SocialFeed instance) =>
    <String, dynamic>{
      'header': instance.header,
      'composer': instance.composer,
      'stories': instance.stories,
      'tabs': instance.tabs,
      'topicChips': instance.topicChips,
      'items': instance.items,
      'meta': instance.meta,
    };

_SocialFeedMeta _$SocialFeedMetaFromJson(Map<String, dynamic> json) =>
    _SocialFeedMeta(
      page: json['page'] == null ? 1 : _readInt(json['page']),
      limit: json['limit'] == null ? 10 : _readInt(json['limit']),
      total: json['total'] == null ? 0 : _readInt(json['total']),
      totalPages: json['totalPages'] == null ? 0 : _readInt(json['totalPages']),
      hasNextPage: json['hasNextPage'] as bool? ?? false,
      hasPreviousPage: json['hasPreviousPage'] as bool? ?? false,
    );

Map<String, dynamic> _$SocialFeedMetaToJson(_SocialFeedMeta instance) =>
    <String, dynamic>{
      'page': instance.page,
      'limit': instance.limit,
      'total': instance.total,
      'totalPages': instance.totalPages,
      'hasNextPage': instance.hasNextPage,
      'hasPreviousPage': instance.hasPreviousPage,
    };

_SocialFeedHeader _$SocialFeedHeaderFromJson(Map<String, dynamic> json) =>
    _SocialFeedHeader(
      title: json['title'] as String,
      streakLabel: json['streakLabel'] as String,
      hasUnreadNotifications: json['hasUnreadNotifications'] as bool? ?? false,
      showFriendsCta: json['showFriendsCta'] as bool? ?? true,
    );

Map<String, dynamic> _$SocialFeedHeaderToJson(_SocialFeedHeader instance) =>
    <String, dynamic>{
      'title': instance.title,
      'streakLabel': instance.streakLabel,
      'hasUnreadNotifications': instance.hasUnreadNotifications,
      'showFriendsCta': instance.showFriendsCta,
    };

_SocialFeedComposer _$SocialFeedComposerFromJson(Map<String, dynamic> json) =>
    _SocialFeedComposer(
      displayName: json['displayName'] as String,
      avatarUrl: json['avatarUrl'] as String?,
      prompt: json['prompt'] as String,
    );

Map<String, dynamic> _$SocialFeedComposerToJson(_SocialFeedComposer instance) =>
    <String, dynamic>{
      'displayName': instance.displayName,
      'avatarUrl': instance.avatarUrl,
      'prompt': instance.prompt,
    };

_SocialFeedStory _$SocialFeedStoryFromJson(Map<String, dynamic> json) =>
    _SocialFeedStory(
      id: json['id'] as String,
      label: json['label'] as String,
      imageUrl: json['imageUrl'] as String?,
      isSelf: json['isSelf'] as bool? ?? false,
      isActive: json['isActive'] as bool? ?? false,
      badge:
          $enumDecodeNullable(_$SocialFeedStoryBadgeEnumMap, json['badge']) ??
          SocialFeedStoryBadge.none,
    );

Map<String, dynamic> _$SocialFeedStoryToJson(_SocialFeedStory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'label': instance.label,
      'imageUrl': instance.imageUrl,
      'isSelf': instance.isSelf,
      'isActive': instance.isActive,
      'badge': _$SocialFeedStoryBadgeEnumMap[instance.badge]!,
    };

const _$SocialFeedStoryBadgeEnumMap = {
  SocialFeedStoryBadge.none: 'NONE',
  SocialFeedStoryBadge.live: 'LIVE',
  SocialFeedStoryBadge.neu: 'NEW',
};

_SocialFeedTab _$SocialFeedTabFromJson(Map<String, dynamic> json) =>
    _SocialFeedTab(
      id: json['id'] as String,
      label: json['label'] as String,
      badgeLabel: json['badgeLabel'] as String?,
      emoji: json['emoji'] as String?,
      selected: json['selected'] as bool? ?? false,
    );

Map<String, dynamic> _$SocialFeedTabToJson(_SocialFeedTab instance) =>
    <String, dynamic>{
      'id': instance.id,
      'label': instance.label,
      'badgeLabel': instance.badgeLabel,
      'emoji': instance.emoji,
      'selected': instance.selected,
    };

_SocialFeedTopicChip _$SocialFeedTopicChipFromJson(Map<String, dynamic> json) =>
    _SocialFeedTopicChip(
      id: json['id'] as String,
      label: json['label'] as String,
      selected: json['selected'] as bool? ?? false,
    );

Map<String, dynamic> _$SocialFeedTopicChipToJson(
  _SocialFeedTopicChip instance,
) => <String, dynamic>{
  'id': instance.id,
  'label': instance.label,
  'selected': instance.selected,
};

_SocialFeedItem _$SocialFeedItemFromJson(
  Map<String, dynamic> json,
) => _SocialFeedItem(
  id: json['id'] as String,
  type: $enumDecode(_$SocialFeedItemTypeEnumMap, json['type']),
  review: json['review'] == null
      ? null
      : SocialFeedReviewPost.fromJson(json['review'] as Map<String, dynamic>),
  challenge: json['challenge'] == null
      ? null
      : SocialFeedChallenge.fromJson(json['challenge'] as Map<String, dynamic>),
  tripRecruit: json['tripRecruit'] == null
      ? null
      : SocialFeedTripRecruit.fromJson(
          json['tripRecruit'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$SocialFeedItemToJson(_SocialFeedItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': _$SocialFeedItemTypeEnumMap[instance.type]!,
      'review': instance.review,
      'challenge': instance.challenge,
      'tripRecruit': instance.tripRecruit,
    };

const _$SocialFeedItemTypeEnumMap = {
  SocialFeedItemType.review: 'REVIEW',
  SocialFeedItemType.challenge: 'CHALLENGE',
  SocialFeedItemType.tripRecruit: 'TRIP_RECRUIT',
};

_SocialFeedAuthor _$SocialFeedAuthorFromJson(Map<String, dynamic> json) =>
    _SocialFeedAuthor(
      id: json['id'] as String,
      displayName: json['displayName'] as String,
      avatarUrl: json['avatarUrl'] as String?,
      badgeLabel: json['badgeLabel'] as String?,
      verified: json['verified'] as bool? ?? false,
    );

Map<String, dynamic> _$SocialFeedAuthorToJson(_SocialFeedAuthor instance) =>
    <String, dynamic>{
      'id': instance.id,
      'displayName': instance.displayName,
      'avatarUrl': instance.avatarUrl,
      'badgeLabel': instance.badgeLabel,
      'verified': instance.verified,
    };

_SocialFeedMedia _$SocialFeedMediaFromJson(Map<String, dynamic> json) =>
    _SocialFeedMedia(
      id: json['id'] as String,
      imageUrl: json['imageUrl'] as String,
      caption: json['caption'] as String?,
      isHero: json['isHero'] as bool? ?? false,
      overlayLabel: json['overlayLabel'] as String?,
    );

Map<String, dynamic> _$SocialFeedMediaToJson(_SocialFeedMedia instance) =>
    <String, dynamic>{
      'id': instance.id,
      'imageUrl': instance.imageUrl,
      'caption': instance.caption,
      'isHero': instance.isHero,
      'overlayLabel': instance.overlayLabel,
    };

_SocialFeedPreviewComment _$SocialFeedPreviewCommentFromJson(
  Map<String, dynamic> json,
) => _SocialFeedPreviewComment(
  id: json['id'] as String,
  authorName: json['authorName'] as String,
  avatarUrl: json['avatarUrl'] as String?,
  text: json['text'] as String,
  timeLabel: json['timeLabel'] as String,
  replyLabel: json['replyLabel'] as String?,
);

Map<String, dynamic> _$SocialFeedPreviewCommentToJson(
  _SocialFeedPreviewComment instance,
) => <String, dynamic>{
  'id': instance.id,
  'authorName': instance.authorName,
  'avatarUrl': instance.avatarUrl,
  'text': instance.text,
  'timeLabel': instance.timeLabel,
  'replyLabel': instance.replyLabel,
};

_SocialFeedReviewPost _$SocialFeedReviewPostFromJson(
  Map<String, dynamic> json,
) => _SocialFeedReviewPost(
  postId: json['postId'] as String,
  author: SocialFeedAuthor.fromJson(json['author'] as Map<String, dynamic>),
  timeLabel: json['timeLabel'] as String,
  trendLabel: json['trendLabel'] as String?,
  placeLabel: json['placeLabel'] as String?,
  placeDetail: json['placeDetail'] as String?,
  placeId: json['placeId'] as String?,
  savedByLabel: json['savedByLabel'] as String?,
  caption: json['caption'] as String,
  tipTitle: json['tipTitle'] as String?,
  tipBody: json['tipBody'] as String?,
  medias:
      (json['medias'] as List<dynamic>?)
          ?.map((e) => SocialFeedMedia.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <SocialFeedMedia>[],
  extraMediaCount: json['extraMediaCount'] == null
      ? 0
      : _readInt(json['extraMediaCount']),
  primaryCtaLabel: json['primaryCtaLabel'] as String?,
  secondaryCtaLabel: json['secondaryCtaLabel'] as String?,
  likesCount: json['likesCount'] == null ? 0 : _readInt(json['likesCount']),
  commentsCount: json['commentsCount'] == null
      ? 0
      : _readInt(json['commentsCount']),
  savesCount: json['savesCount'] == null ? 0 : _readInt(json['savesCount']),
  liked: json['liked'] as bool? ?? false,
  bookmarked: json['bookmarked'] as bool? ?? false,
  previewComment: json['previewComment'] == null
      ? null
      : SocialFeedPreviewComment.fromJson(
          json['previewComment'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$SocialFeedReviewPostToJson(
  _SocialFeedReviewPost instance,
) => <String, dynamic>{
  'postId': instance.postId,
  'author': instance.author,
  'timeLabel': instance.timeLabel,
  'trendLabel': instance.trendLabel,
  'placeLabel': instance.placeLabel,
  'placeDetail': instance.placeDetail,
  'placeId': instance.placeId,
  'savedByLabel': instance.savedByLabel,
  'caption': instance.caption,
  'tipTitle': instance.tipTitle,
  'tipBody': instance.tipBody,
  'medias': instance.medias,
  'extraMediaCount': instance.extraMediaCount,
  'primaryCtaLabel': instance.primaryCtaLabel,
  'secondaryCtaLabel': instance.secondaryCtaLabel,
  'likesCount': instance.likesCount,
  'commentsCount': instance.commentsCount,
  'savesCount': instance.savesCount,
  'liked': instance.liked,
  'bookmarked': instance.bookmarked,
  'previewComment': instance.previewComment,
};

_SocialFeedChallenge _$SocialFeedChallengeFromJson(Map<String, dynamic> json) =>
    _SocialFeedChallenge(
      id: json['id'] as String,
      eyebrow: json['eyebrow'] as String,
      title: json['title'] as String,
      rewardLabel: json['rewardLabel'] as String,
      progressLabel: json['progressLabel'] as String,
      progressRatio: json['progressRatio'] == null
          ? 0
          : _readDouble(json['progressRatio']),
      daysLeftLabel: json['daysLeftLabel'] as String,
      badgeLabel: json['badgeLabel'] as String,
      ctaLabel: json['ctaLabel'] as String,
    );

Map<String, dynamic> _$SocialFeedChallengeToJson(
  _SocialFeedChallenge instance,
) => <String, dynamic>{
  'id': instance.id,
  'eyebrow': instance.eyebrow,
  'title': instance.title,
  'rewardLabel': instance.rewardLabel,
  'progressLabel': instance.progressLabel,
  'progressRatio': instance.progressRatio,
  'daysLeftLabel': instance.daysLeftLabel,
  'badgeLabel': instance.badgeLabel,
  'ctaLabel': instance.ctaLabel,
};

_SocialFeedTripRecruit _$SocialFeedTripRecruitFromJson(
  Map<String, dynamic> json,
) => _SocialFeedTripRecruit(
  postId: json['postId'] as String,
  author: SocialFeedAuthor.fromJson(json['author'] as Map<String, dynamic>),
  timeLabel: json['timeLabel'] as String,
  recruitBadge: json['recruitBadge'] as String,
  placeLabel: json['placeLabel'] as String,
  caption: json['caption'] as String,
  tripId: json['tripId'] as String,
  tripTitle: json['tripTitle'] as String,
  spotsLeftLabel: json['spotsLeftLabel'] as String,
  urgencyLabel: json['urgencyLabel'] as String,
  scheduleLabel: json['scheduleLabel'] as String,
  priceLabel: json['priceLabel'] as String,
  membersLabel: json['membersLabel'] as String,
  fillRatio: json['fillRatio'] == null ? 0 : _readDouble(json['fillRatio']),
  fillPercentLabel: json['fillPercentLabel'] as String,
  memberAvatars:
      (json['memberAvatars'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const <String>[],
  extraMemberCount: json['extraMemberCount'] == null
      ? 0
      : _readInt(json['extraMemberCount']),
  highlightLabel: json['highlightLabel'] as String?,
  highlightDetail: json['highlightDetail'] as String?,
  likesCount: json['likesCount'] == null ? 0 : _readInt(json['likesCount']),
  commentsCount: json['commentsCount'] == null
      ? 0
      : _readInt(json['commentsCount']),
  sharesCount: json['sharesCount'] == null ? 0 : _readInt(json['sharesCount']),
  liked: json['liked'] as bool? ?? false,
  bookmarked: json['bookmarked'] as bool? ?? false,
  itineraryCtaLabel: json['itineraryCtaLabel'] as String,
  joinCtaLabel: json['joinCtaLabel'] as String,
);

Map<String, dynamic> _$SocialFeedTripRecruitToJson(
  _SocialFeedTripRecruit instance,
) => <String, dynamic>{
  'postId': instance.postId,
  'author': instance.author,
  'timeLabel': instance.timeLabel,
  'recruitBadge': instance.recruitBadge,
  'placeLabel': instance.placeLabel,
  'caption': instance.caption,
  'tripId': instance.tripId,
  'tripTitle': instance.tripTitle,
  'spotsLeftLabel': instance.spotsLeftLabel,
  'urgencyLabel': instance.urgencyLabel,
  'scheduleLabel': instance.scheduleLabel,
  'priceLabel': instance.priceLabel,
  'membersLabel': instance.membersLabel,
  'fillRatio': instance.fillRatio,
  'fillPercentLabel': instance.fillPercentLabel,
  'memberAvatars': instance.memberAvatars,
  'extraMemberCount': instance.extraMemberCount,
  'highlightLabel': instance.highlightLabel,
  'highlightDetail': instance.highlightDetail,
  'likesCount': instance.likesCount,
  'commentsCount': instance.commentsCount,
  'sharesCount': instance.sharesCount,
  'liked': instance.liked,
  'bookmarked': instance.bookmarked,
  'itineraryCtaLabel': instance.itineraryCtaLabel,
  'joinCtaLabel': instance.joinCtaLabel,
};
