import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/social_post_detail_models.dart';
import '../provider/social_post_detail_provider.dart';
import 'social_post_detail_view.dart';

class SocialPostDetailState {
  const SocialPostDetailState({
    required this.post,
    required this.comments,
    required this.commentsMeta,
    this.sort = SocialPostCommentSort.relevant,
    this.loadingMoreComments = false,
    this.submittingComment = false,
    this.commentsError,
  });

  final SocialPostDetail post;
  final List<SocialPostDetailComment> comments;
  final SocialPostDetailPageMeta commentsMeta;
  final SocialPostCommentSort sort;
  final bool loadingMoreComments;
  final bool submittingComment;
  final String? commentsError;

  SocialPostDetailView get view => buildSocialPostDetailView(
    post: post,
    comments: comments,
    hasNextComments: commentsMeta.hasNextPage,
    commentsTotal: commentsMeta.total > 0
        ? commentsMeta.total
        : post.commentsCount,
    sort: sort,
  );

  SocialPostDetailState copyWith({
    SocialPostDetail? post,
    List<SocialPostDetailComment>? comments,
    SocialPostDetailPageMeta? commentsMeta,
    SocialPostCommentSort? sort,
    bool? loadingMoreComments,
    bool? submittingComment,
    Object? commentsError = _keep,
  }) {
    return SocialPostDetailState(
      post: post ?? this.post,
      comments: comments ?? this.comments,
      commentsMeta: commentsMeta ?? this.commentsMeta,
      sort: sort ?? this.sort,
      loadingMoreComments: loadingMoreComments ?? this.loadingMoreComments,
      submittingComment: submittingComment ?? this.submittingComment,
      commentsError: identical(commentsError, _keep)
          ? this.commentsError
          : commentsError as String?,
    );
  }
}

const _keep = Object();

final socialPostDetailsControllerProvider = AsyncNotifierProvider.autoDispose
    .family<SocialPostDetailsController, SocialPostDetailState, String>(
      SocialPostDetailsController.new,
      retry: (_, _) => null,
    );

class SocialPostDetailsController extends AsyncNotifier<SocialPostDetailState> {
  SocialPostDetailsController(this.postId);

  final String postId;
  var _mutating = false;

  @override
  Future<SocialPostDetailState> build() async {
    final repo = ref.watch(socialPostDetailRepositoryProvider);
    final post = await repo.getPost(postId);
    try {
      final page = await repo.getComments(postId: postId, page: 1, limit: 20);
      return SocialPostDetailState(
        post: post,
        comments: page.data,
        commentsMeta: page.meta,
      );
    } catch (error) {
      return SocialPostDetailState(
        post: post,
        comments: const <SocialPostDetailComment>[],
        commentsMeta: const SocialPostDetailPageMeta(),
        commentsError: socialPostDetailFailureMessage(error),
      );
    }
  }

  Future<bool> refresh() async {
    final previous = state.asData?.value;
    state = const AsyncLoading<SocialPostDetailState>();
    state = await AsyncValue.guard(build);
    if (state.hasError && previous != null) {
      state = AsyncData(previous);
      return false;
    }
    return !state.hasError;
  }

  void setSort(SocialPostCommentSort sort) {
    final current = state.asData?.value;
    if (current == null || current.sort == sort) return;
    state = AsyncData(current.copyWith(sort: sort));
  }

  Future<void> loadMoreComments() async {
    final current = state.asData?.value;
    if (current == null ||
        current.loadingMoreComments ||
        !current.commentsMeta.hasNextPage) {
      return;
    }
    state = AsyncData(
      current.copyWith(loadingMoreComments: true, commentsError: null),
    );
    try {
      final page = await ref
          .read(socialPostDetailRepositoryProvider)
          .getComments(
            postId: postId,
            page: current.commentsMeta.page + 1,
            limit: current.commentsMeta.limit,
          );
      final latest = state.asData?.value ?? current;
      state = AsyncData(
        latest.copyWith(
          comments: [...latest.comments, ...page.data],
          commentsMeta: page.meta,
          loadingMoreComments: false,
          commentsError: null,
        ),
      );
    } catch (error) {
      final latest = state.asData?.value ?? current;
      state = AsyncData(
        latest.copyWith(
          loadingMoreComments: false,
          commentsError: socialPostDetailFailureMessage(error),
        ),
      );
    }
  }

  Future<bool> submitComment(String raw) async {
    final text = raw.trim();
    final current = state.asData?.value;
    if (text.isEmpty || current == null || current.submittingComment) {
      return false;
    }
    state = AsyncData(current.copyWith(submittingComment: true));
    try {
      final created = await ref
          .read(socialPostDetailRepositoryProvider)
          .createComment(postId: postId, content: text);
      final latest = state.asData?.value ?? current;
      state = AsyncData(
        latest.copyWith(
          comments: [created, ...latest.comments],
          post: latest.post.copyWith(
            commentsCount: latest.post.commentsCount + 1,
          ),
          commentsMeta: latest.commentsMeta.copyWith(
            total: latest.commentsMeta.total + 1,
          ),
          submittingComment: false,
          commentsError: null,
        ),
      );
      return true;
    } catch (_) {
      final latest = state.asData?.value ?? current;
      state = AsyncData(latest.copyWith(submittingComment: false));
      return false;
    }
  }

  Future<void> toggleLike() async {
    final current = state.asData?.value;
    if (current == null || _mutating) return;
    final nextLiked = !current.post.liked;
    final likes = current.post.likesCount + (nextLiked ? 1 : -1);
    state = AsyncData(
      current.copyWith(
        post: current.post.copyWith(
          liked: nextLiked,
          likesCount: likes < 0 ? 0 : likes,
        ),
      ),
    );
    _mutating = true;
    try {
      final repo = ref.read(socialPostDetailRepositoryProvider);
      if (nextLiked) {
        await repo.likePost(postId);
      } else {
        await repo.unlikePost(postId);
      }
    } catch (_) {
      state = AsyncData(current);
    } finally {
      _mutating = false;
    }
  }

  Future<void> toggleBookmark() async {
    final current = state.asData?.value;
    if (current == null || _mutating) return;
    final nextSaved = !current.post.bookmarked;
    final saves = current.post.savesCount + (nextSaved ? 1 : -1);
    state = AsyncData(
      current.copyWith(
        post: current.post.copyWith(
          bookmarked: nextSaved,
          savesCount: saves < 0 ? 0 : saves,
        ),
      ),
    );
    _mutating = true;
    try {
      final repo = ref.read(socialPostDetailRepositoryProvider);
      if (nextSaved) {
        await repo.savePost(postId);
      } else {
        await repo.unsavePost(postId);
      }
    } catch (_) {
      state = AsyncData(current);
    } finally {
      _mutating = false;
    }
  }

  Future<bool> share() async {
    final current = state.asData?.value;
    if (current == null || _mutating) return false;
    _mutating = true;
    try {
      await ref.read(socialPostDetailRepositoryProvider).sharePost(postId);
      final latest = state.asData?.value ?? current;
      state = AsyncData(
        latest.copyWith(
          post: latest.post.copyWith(
            shared: true,
            sharesCount: latest.post.sharesCount + 1,
          ),
        ),
      );
      return true;
    } catch (_) {
      return false;
    } finally {
      _mutating = false;
    }
  }
}
