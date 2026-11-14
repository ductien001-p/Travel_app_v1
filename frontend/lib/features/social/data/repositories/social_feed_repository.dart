import '../datasources/social_feed_datasource.dart';
import '../models/social_feed_models.dart';
import '../models/social_post_comment.dart';

class SocialFeedRepository {
  const SocialFeedRepository({required SocialFeedDataSource dataSource})
    : _dataSource = dataSource;

  final SocialFeedDataSource _dataSource;

  Future<SocialFeed> getFeed(SocialFeedQuery query) =>
      _dataSource.getFeed(query);

  Future<void> likePost(String postId) => _dataSource.likePost(postId);

  Future<void> unlikePost(String postId) => _dataSource.unlikePost(postId);

  Future<void> savePost(String postId) => _dataSource.savePost(postId);

  Future<void> unsavePost(String postId) => _dataSource.unsavePost(postId);

  Future<void> sharePost(String postId) => _dataSource.sharePost(postId);

  Future<SocialPostCommentsPage> getComments({
    required String postId,
    int page = 1,
    int limit = 20,
  }) => _dataSource.getComments(postId: postId, page: page, limit: limit);

  Future<SocialPostComment> createComment({
    required String postId,
    required String content,
  }) => _dataSource.createComment(postId: postId, content: content);

  Future<SocialFeedChallenge> joinChallenge(String challengeId) =>
      _dataSource.joinChallenge(challengeId);

  Future<void> createPost({
    required String caption,
    required List<String> mediaIds,
    String? tipTitle,
    String? tipBody,
    String? topic,
    String? placeDetail,
  }) => _dataSource.createPost(
    caption: caption,
    mediaIds: mediaIds,
    tipTitle: tipTitle,
    tipBody: tipBody,
    topic: topic,
    placeDetail: placeDetail,
  );

  Future<SocialFeedStory> createStory({
    required String mediaId,
    required String label,
    bool isLive = false,
  }) => _dataSource.createStory(mediaId: mediaId, label: label, isLive: isLive);

  Future<SocialFeedReviewPost> getPost(String postId) =>
      _dataSource.getPost(postId);
}
