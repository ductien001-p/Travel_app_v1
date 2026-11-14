// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'social_post_detail_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SocialPostDetail _$SocialPostDetailFromJson(
  Map<String, dynamic> json,
) => _SocialPostDetail(
  id: json['id'] as String,
  authorId: json['authorId'] as String,
  placeId: json['placeId'] as String?,
  caption: json['caption'] as String?,
  visibility: json['visibility'] as String? ?? 'PUBLIC',
  tipTitle: json['tipTitle'] as String?,
  tipBody: json['tipBody'] as String?,
  topic: json['topic'] as String?,
  placeDetail: json['placeDetail'] as String?,
  likesCount: json['likesCount'] == null ? 0 : _readInt(json['likesCount']),
  commentsCount: json['commentsCount'] == null
      ? 0
      : _readInt(json['commentsCount']),
  sharesCount: json['sharesCount'] == null ? 0 : _readInt(json['sharesCount']),
  savesCount: json['savesCount'] == null ? 0 : _readInt(json['savesCount']),
  createdAt: _readDateTime(json['createdAt']),
  author: SocialPostDetailAuthor.fromJson(
    json['author'] as Map<String, dynamic>,
  ),
  place: json['place'] == null
      ? null
      : SocialPostDetailPlace.fromJson(json['place'] as Map<String, dynamic>),
  postMedias:
      (json['postMedias'] as List<dynamic>?)
          ?.map(
            (e) => SocialPostDetailMedia.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const <SocialPostDetailMedia>[],
  liked: json['liked'] as bool? ?? false,
  shared: json['shared'] as bool? ?? false,
  bookmarked: json['bookmarked'] as bool? ?? false,
  trendLabel: json['trendLabel'] as String?,
  timeLabel: json['timeLabel'] as String? ?? '',
);

Map<String, dynamic> _$SocialPostDetailToJson(_SocialPostDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'authorId': instance.authorId,
      'placeId': instance.placeId,
      'caption': instance.caption,
      'visibility': instance.visibility,
      'tipTitle': instance.tipTitle,
      'tipBody': instance.tipBody,
      'topic': instance.topic,
      'placeDetail': instance.placeDetail,
      'likesCount': instance.likesCount,
      'commentsCount': instance.commentsCount,
      'sharesCount': instance.sharesCount,
      'savesCount': instance.savesCount,
      'createdAt': instance.createdAt.toIso8601String(),
      'author': instance.author,
      'place': instance.place,
      'postMedias': instance.postMedias,
      'liked': instance.liked,
      'shared': instance.shared,
      'bookmarked': instance.bookmarked,
      'trendLabel': instance.trendLabel,
      'timeLabel': instance.timeLabel,
    };

_SocialPostDetailAuthor _$SocialPostDetailAuthorFromJson(
  Map<String, dynamic> json,
) => _SocialPostDetailAuthor(
  id: json['id'] as String,
  username: json['username'] as String,
  displayName: json['displayName'] as String?,
  avatarId: json['avatarId'] as String?,
  avatarUrl: json['avatarUrl'] as String?,
  badgeLabel: json['badgeLabel'] as String?,
  verified: json['verified'] as bool? ?? false,
);

Map<String, dynamic> _$SocialPostDetailAuthorToJson(
  _SocialPostDetailAuthor instance,
) => <String, dynamic>{
  'id': instance.id,
  'username': instance.username,
  'displayName': instance.displayName,
  'avatarId': instance.avatarId,
  'avatarUrl': instance.avatarUrl,
  'badgeLabel': instance.badgeLabel,
  'verified': instance.verified,
};

_SocialPostDetailPlace _$SocialPostDetailPlaceFromJson(
  Map<String, dynamic> json,
) => _SocialPostDetailPlace(
  id: json['id'] as String,
  name: json['name'] as String,
  detail: json['detail'] as String?,
);

Map<String, dynamic> _$SocialPostDetailPlaceToJson(
  _SocialPostDetailPlace instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'detail': instance.detail,
};

_SocialPostDetailMedia _$SocialPostDetailMediaFromJson(
  Map<String, dynamic> json,
) => _SocialPostDetailMedia(
  mediaId: json['mediaId'] as String,
  orderIndex: json['orderIndex'] == null ? 0 : _readInt(json['orderIndex']),
  url: json['url'] as String?,
);

Map<String, dynamic> _$SocialPostDetailMediaToJson(
  _SocialPostDetailMedia instance,
) => <String, dynamic>{
  'mediaId': instance.mediaId,
  'orderIndex': instance.orderIndex,
  'url': instance.url,
};

_SocialPostDetailComment _$SocialPostDetailCommentFromJson(
  Map<String, dynamic> json,
) => _SocialPostDetailComment(
  id: json['id'] as String,
  postId: json['postId'] as String,
  userId: json['userId'] as String,
  content: json['content'] as String,
  createdAt: _readDateTime(json['createdAt']),
  user: SocialPostDetailCommentUser.fromJson(
    json['user'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$SocialPostDetailCommentToJson(
  _SocialPostDetailComment instance,
) => <String, dynamic>{
  'id': instance.id,
  'postId': instance.postId,
  'userId': instance.userId,
  'content': instance.content,
  'createdAt': instance.createdAt.toIso8601String(),
  'user': instance.user,
};

_SocialPostDetailCommentUser _$SocialPostDetailCommentUserFromJson(
  Map<String, dynamic> json,
) => _SocialPostDetailCommentUser(
  id: json['id'] as String,
  username: json['username'] as String,
  avatarId: json['avatarId'] as String?,
  avatarUrl: json['avatarUrl'] as String?,
);

Map<String, dynamic> _$SocialPostDetailCommentUserToJson(
  _SocialPostDetailCommentUser instance,
) => <String, dynamic>{
  'id': instance.id,
  'username': instance.username,
  'avatarId': instance.avatarId,
  'avatarUrl': instance.avatarUrl,
};

_SocialPostDetailCommentsPage _$SocialPostDetailCommentsPageFromJson(
  Map<String, dynamic> json,
) => _SocialPostDetailCommentsPage(
  data:
      (json['data'] as List<dynamic>?)
          ?.map(
            (e) => SocialPostDetailComment.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const <SocialPostDetailComment>[],
  meta: SocialPostDetailPageMeta.fromJson(json['meta'] as Map<String, dynamic>),
);

Map<String, dynamic> _$SocialPostDetailCommentsPageToJson(
  _SocialPostDetailCommentsPage instance,
) => <String, dynamic>{'data': instance.data, 'meta': instance.meta};

_SocialPostDetailPageMeta _$SocialPostDetailPageMetaFromJson(
  Map<String, dynamic> json,
) => _SocialPostDetailPageMeta(
  page: json['page'] == null ? 1 : _readInt(json['page']),
  limit: json['limit'] == null ? 20 : _readInt(json['limit']),
  total: json['total'] == null ? 0 : _readInt(json['total']),
  totalPages: json['totalPages'] == null ? 0 : _readInt(json['totalPages']),
  hasNextPage: json['hasNextPage'] as bool? ?? false,
  hasPreviousPage: json['hasPreviousPage'] as bool? ?? false,
);

Map<String, dynamic> _$SocialPostDetailPageMetaToJson(
  _SocialPostDetailPageMeta instance,
) => <String, dynamic>{
  'page': instance.page,
  'limit': instance.limit,
  'total': instance.total,
  'totalPages': instance.totalPages,
  'hasNextPage': instance.hasNextPage,
  'hasPreviousPage': instance.hasPreviousPage,
};
