import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';
import 'package:travel_frontend_v1/app/router/router_names.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_gradients.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/widget/app_error_view.dart';
import 'package:travel_frontend_v1/core/widget/app_skeleton.dart';
import 'package:travel_frontend_v1/features/profile/application/profile_controller.dart';
import 'package:travel_frontend_v1/features/public-images/utils/public_image_navigation.dart';
import 'package:travel_frontend_v1/features/public-images/utils/public_image_social_mapper.dart';

import '../../application/social_post_detail_controller.dart';
import '../../application/social_post_detail_view.dart';
import '../../data/models/social_post_detail_models.dart';
import '../widgets/social_post_detail_actions.dart';
import '../widgets/social_post_detail_author_row.dart';
import '../widgets/social_post_detail_comments.dart';
import '../widgets/social_post_detail_composer.dart';
import '../widgets/social_post_detail_content.dart';
import '../widgets/social_post_detail_header.dart';
import '../widgets/social_post_detail_media_gallery.dart';
import '../widgets/social_post_detail_place_card.dart';

class SocialPostDetailScreen extends ConsumerStatefulWidget {
  const SocialPostDetailScreen({
    super.key,
    required this.postId,
    this.focusComments = false,
  });

  final String postId;
  final bool focusComments;

  @override
  ConsumerState<SocialPostDetailScreen> createState() =>
      _SocialPostDetailScreenState();
}

class _SocialPostDetailScreenState
    extends ConsumerState<SocialPostDetailScreen> {
  late final TextEditingController _composer;
  late final ScrollController _scroll;
  final _commentsKey = GlobalKey();
  var _mediaIndex = 0;
  String? _replyToName;
  var _didAutoFocusComments = false;

  @override
  void initState() {
    super.initState();
    _composer = TextEditingController();
    _scroll = ScrollController();
  }

  @override
  void dispose() {
    _composer.dispose();
    _scroll.dispose();
    super.dispose();
  }

  void _back() {
    if (context.canPop()) {
      context.pop();
      return;
    }
    context.goNamed(RouteNames.social);
  }

  void _comingSoon(String label) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('$label đang phát triển.')));
  }

  Future<void> _openPublicImages(SocialPostDetail post, int index) async {
    final album = publicImageAlbumFromSocialMedias(
      postId: post.id,
      authorId: post.authorId,
      authorName: post.author.displayName?.trim().isNotEmpty == true
          ? post.author.displayName!.trim()
          : post.author.username,
      caption: post.caption,
      placeLabel: post.place?.name,
      placeDetail: post.place?.detail ?? post.placeDetail,
      createdAt: post.createdAt,
      likesCount: post.likesCount,
      commentsCount: post.commentsCount,
      likedByMe: post.liked,
      medias: [
        for (final media in post.postMedias)
          if (media.url != null && media.url!.trim().isNotEmpty)
            (id: media.mediaId, imageUrl: media.url!.trim(), caption: null),
      ],
    );
    if (album.images.isEmpty) {
      _comingSoon('Xem ảnh toàn màn hình');
      return;
    }
    await openPublicImageViewer(
      context,
      ref,
      album: album,
      initialIndex: index,
    );
  }

  void _scrollToComments() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final target = _commentsKey.currentContext;
      if (target == null) return;
      Scrollable.ensureVisible(
        target,
        duration: const Duration(milliseconds: 320),
        curve: Curves.easeOutCubic,
        alignment: 0.08,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.postId.trim().isEmpty) {
      return Scaffold(
        body: DecoratedBox(
          decoration: const BoxDecoration(
            gradient: AppGradients.pageAtmosphere,
          ),
          child: const SafeArea(
            child: AppErrorView(
              title: 'Không mở được bài viết',
              message: 'Thiếu mã bài viết.',
            ),
          ),
        ),
      );
    }

    final async = ref.watch(socialPostDetailsControllerProvider(widget.postId));
    final profile = ref.watch(profileControllerProvider).asData?.value;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: DecoratedBox(
        decoration: const BoxDecoration(gradient: AppGradients.pageAtmosphere),
        child: SafeArea(
          bottom: false,
          child: async.when(
            loading: () => const _LoadingBody(),
            error: (error, _) {
              final unauthorized = socialPostDetailFailureIsUnauthorized(error);
              return Column(
                children: [
                  SocialPostDetailHeader(
                    subtitle: 'Teal Horizon',
                    bookmarked: false,
                    onBack: _back,
                    onBookmark: () {},
                    onMore: () {},
                  ),
                  Expanded(
                    child: AppErrorView(
                      title: unauthorized
                          ? 'Phiên đăng nhập đã hết hạn'
                          : 'Không tải được bài viết',
                      message: socialPostDetailFailureMessage(error),
                      actionLabel: 'Thử lại',
                      onRetry: unauthorized
                          ? null
                          : () => ref
                                .read(
                                  socialPostDetailsControllerProvider(
                                    widget.postId,
                                  ).notifier,
                                )
                                .refresh(),
                    ),
                  ),
                ],
              );
            },
            data: (state) {
              final view = state.view;
              if (widget.focusComments && !_didAutoFocusComments) {
                _didAutoFocusComments = true;
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  _scrollToComments();
                });
              }

              return Column(
                children: [
                  SocialPostDetailHeader(
                    subtitle: view.logSubtitle,
                    bookmarked: view.post.bookmarked,
                    onBack: _back,
                    onBookmark: () => ref
                        .read(
                          socialPostDetailsControllerProvider(
                            widget.postId,
                          ).notifier,
                        )
                        .toggleBookmark(),
                    onMore: () => _showMoreMenu(view),
                  ),
                  Expanded(
                    child: RefreshIndicator(
                      color: AppColors.primary,
                      onRefresh: () => ref
                          .read(
                            socialPostDetailsControllerProvider(
                              widget.postId,
                            ).notifier,
                          )
                          .refresh(),
                      child: ListView(
                        controller: _scroll,
                        physics: const AlwaysScrollableScrollPhysics(),
                        padding: const EdgeInsets.only(bottom: AppSpacing.xl),
                        children: [
                          const SizedBox(height: AppSpacing.sm),
                          SocialPostDetailAuthorRow(
                            view: view,
                            onFollow: () => _comingSoon('Theo dõi'),
                          ),
                          if (view.post.place != null) ...[
                            const SizedBox(height: AppSpacing.md),
                            SocialPostDetailPlaceCard(
                              view: view,
                              onOpenPlace:
                                  view.post.placeId == null ||
                                      view.post.placeId!.isEmpty
                                  ? null
                                  : () => context.pushNamed(
                                      RouteNames.placeDetail,
                                      pathParameters: {
                                        'placeId': view.post.placeId!,
                                      },
                                    ),
                            ),
                          ],
                          const SizedBox(height: AppSpacing.md),
                          SocialPostDetailContent(view: view),
                          const SizedBox(height: AppSpacing.md),
                          SocialPostDetailMediaGallery(
                            medias: view.post.postMedias,
                            pageIndex: _mediaIndex,
                            onPageChanged: (index) =>
                                setState(() => _mediaIndex = index),
                            onFullscreen: () =>
                                _openPublicImages(view.post, _mediaIndex),
                            onImageTap: (index) =>
                                _openPublicImages(view.post, index),
                          ),
                          const SizedBox(height: AppSpacing.md),
                          SocialPostDetailStats(post: view.post),
                          const SizedBox(height: AppSpacing.sm),
                          SocialPostDetailActionBar(
                            post: view.post,
                            onLike: () => ref
                                .read(
                                  socialPostDetailsControllerProvider(
                                    widget.postId,
                                  ).notifier,
                                )
                                .toggleLike(),
                            onComment: _scrollToComments,
                            onShare: () => _share(view),
                            onBookmark: () => ref
                                .read(
                                  socialPostDetailsControllerProvider(
                                    widget.postId,
                                  ).notifier,
                                )
                                .toggleBookmark(),
                          ),
                          const SizedBox(height: AppSpacing.xl),
                          KeyedSubtree(
                            key: _commentsKey,
                            child: SocialPostDetailCommentsSection(
                              view: view,
                              authorId: view.post.authorId,
                              loadingMore: state.loadingMoreComments,
                              error: state.commentsError,
                              onSortChanged: (sort) => ref
                                  .read(
                                    socialPostDetailsControllerProvider(
                                      widget.postId,
                                    ).notifier,
                                  )
                                  .setSort(sort),
                              onLoadMore: () => ref
                                  .read(
                                    socialPostDetailsControllerProvider(
                                      widget.postId,
                                    ).notifier,
                                  )
                                  .loadMoreComments(),
                              onRetry: () => ref
                                  .read(
                                    socialPostDetailsControllerProvider(
                                      widget.postId,
                                    ).notifier,
                                  )
                                  .refresh(),
                              onReply: (comment) {
                                setState(() {
                                  _replyToName = comment.user.username;
                                  _composer.text = '@${comment.user.username} ';
                                  _composer
                                      .selection = TextSelection.fromPosition(
                                    TextPosition(offset: _composer.text.length),
                                  );
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SocialPostDetailComposer(
                    controller: _composer,
                    hint: view.composerHint,
                    avatarUrl: profile?.avatarUrl,
                    displayName: profile?.displayName?.trim().isNotEmpty == true
                        ? profile!.displayName!.trim()
                        : (profile?.username ?? 'Bạn'),
                    submitting: state.submittingComment,
                    replyHint: _replyToName == null
                        ? null
                        : 'Đang trả lời $_replyToName',
                    onCancelReply: () {
                      setState(() {
                        _replyToName = null;
                        _composer.clear();
                      });
                    },
                    onSubmit: () => _submitComment(),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> _submitComment() async {
    final ok = await ref
        .read(socialPostDetailsControllerProvider(widget.postId).notifier)
        .submitComment(_composer.text);
    if (!mounted) return;
    if (ok) {
      setState(() {
        _composer.clear();
        _replyToName = null;
      });
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Không gửi được bình luận. Thử lại.')),
    );
  }

  Future<void> _share(SocialPostDetailView view) async {
    final ok = await ref
        .read(socialPostDetailsControllerProvider(widget.postId).notifier)
        .share();
    if (!mounted) return;
    if (!ok) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Không chia sẻ được. Thử lại.')),
      );
      return;
    }
    final text = [
      view.authorDisplayName,
      if (view.captionBody.isNotEmpty) view.captionBody,
      if (view.post.place?.name != null) '📍 ${view.post.place!.name}',
    ].join('\n');
    await SharePlus.instance.share(ShareParams(text: text));
  }

  void _showMoreMenu(SocialPostDetailView view) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.share_outlined),
                title: const Text('Chia sẻ bài viết'),
                onTap: () {
                  Navigator.pop(context);
                  _share(view);
                },
              ),
              ListTile(
                leading: const Icon(Icons.link_rounded),
                title: const Text('Sao chép liên kết'),
                onTap: () {
                  Navigator.pop(context);
                  _comingSoon('Sao chép liên kết');
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.flag_outlined,
                  color: AppColors.danger,
                ),
                title: const Text(
                  'Báo cáo bài viết',
                  style: TextStyle(color: AppColors.danger),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _comingSoon('Báo cáo');
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class _LoadingBody extends StatelessWidget {
  const _LoadingBody();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(AppSpacing.screenHorizontal),
      child: Column(
        children: [
          SizedBox(height: AppSpacing.sm),
          AppSkeleton(width: double.infinity, height: 56, radius: 18),
          SizedBox(height: AppSpacing.md),
          AppSkeleton(width: double.infinity, height: 72, radius: 18),
          SizedBox(height: AppSpacing.md),
          AppSkeleton(width: double.infinity, height: 120, radius: 18),
          SizedBox(height: AppSpacing.md),
          AppSkeleton(width: double.infinity, height: 320, radius: 22),
        ],
      ),
    );
  }
}
