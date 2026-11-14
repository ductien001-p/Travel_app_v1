import 'package:flutter_test/flutter_test.dart';
import 'package:travel_frontend_v1/features/social/social-details/application/social_post_detail_view.dart';
import 'package:travel_frontend_v1/features/social/social-details/data/datamock/social_post_detail_datamock.dart';
import 'package:travel_frontend_v1/features/social/social-details/data/models/social_post_detail_models.dart';

void main() {
  test('parses Stitch post detail datamock', () {
    final post = SocialPostDetail.fromJson(socialPostDetailDatamock);
    expect(post.id, 'post-hoi-an-lan');
    expect(post.author.displayName, 'Lan Phương');
    expect(post.place?.name, 'Phố Cổ Hội An');
    expect(post.postMedias, hasLength(4));
    expect(post.likesCount, 248);
    expect(post.commentsCount, 42);
    expect(post.sharesCount, 18);

    final comments = SocialPostDetailCommentsPage.fromJson(
      socialPostDetailCommentsDatamock,
    );
    expect(comments.data, hasLength(3));
    expect(comments.meta.hasNextPage, isTrue);
    expect(comments.data.first.user.username, 'Alex Nguyễn');
  });

  test('builds detail view with hashtags and caption body', () {
    final post = SocialPostDetail.fromJson(socialPostDetailDatamock);
    final comments = SocialPostDetailCommentsPage.fromJson(
      socialPostDetailCommentsDatamock,
    );
    final view = buildSocialPostDetailView(
      post: post,
      comments: comments.data,
      hasNextComments: comments.meta.hasNextPage,
      commentsTotal: comments.meta.total,
      sort: SocialPostCommentSort.relevant,
    );

    expect(view.hashtags, contains('#HoiAn'));
    expect(view.hashtags, contains('#TealHorizon'));
    expect(view.captionBody, isNot(contains('#HoiAn')));
    expect(view.visibilityLabel, 'Công khai');
    expect(view.remainingComments, 39);
    expect(view.composerHint, contains('Lan Phương'));
  });
}
