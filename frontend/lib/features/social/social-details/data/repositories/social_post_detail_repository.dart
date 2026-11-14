import '../datasources/social_post_detail_datasource.dart';
import '../models/social_post_detail_models.dart';

class SocialPostDetailRepository {
  const SocialPostDetailRepository({
    required SocialPostDetailDataSource dataSource,
  }) : _dataSource = dataSource;

  final SocialPostDetailDataSource _dataSource;

  Future<SocialPostDetail> getPost(String postId) =>
      _dataSource.getPost(postId);

  Future<SocialPostDetailCommentsPage> getComments({
    required String postId,
    int page = 1,
    int limit = 20,
  }) => _dataSource.getComments(postId: postId, page: page, limit: limit);

  Future<SocialPostDetailComment> createComment({
    required String postId,
    required String content,
  }) => _dataSource.createComment(postId: postId, content: content);

  Future<void> likePost(String postId) => _dataSource.likePost(postId);

  Future<void> unlikePost(String postId) => _dataSource.unlikePost(postId);

  Future<void> savePost(String postId) => _dataSource.savePost(postId);

  Future<void> unsavePost(String postId) => _dataSource.unsavePost(postId);

  Future<void> sharePost(String postId) => _dataSource.sharePost(postId);
}
