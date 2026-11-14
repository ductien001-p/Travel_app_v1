import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_bottom_sheet.dart';
import 'package:travel_frontend_v1/core/widget/app_button.dart';
import 'package:travel_frontend_v1/core/widget/app_text_field.dart';

import '../../application/social_feed_controller.dart';
import '../../data/models/social_post_comment.dart';

Future<void> showSocialPostCommentsSheet({
  required BuildContext context,
  required String postId,
}) {
  return showAppBottomSheet<void>(
    context: context,
    child: _SocialPostCommentsSheet(postId: postId),
  );
}

class _SocialPostCommentsSheet extends ConsumerStatefulWidget {
  const _SocialPostCommentsSheet({required this.postId});

  final String postId;

  @override
  ConsumerState<_SocialPostCommentsSheet> createState() =>
      _SocialPostCommentsSheetState();
}

class _SocialPostCommentsSheetState
    extends ConsumerState<_SocialPostCommentsSheet> {
  final _input = TextEditingController();
  final _comments = <SocialPostComment>[];
  var _loading = true;
  var _submitting = false;
  var _loadingMore = false;
  var _page = 1;
  var _hasNext = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    _input.dispose();
    super.dispose();
  }

  Future<void> _load({bool more = false}) async {
    if (more) {
      if (_loadingMore || !_hasNext) return;
      setState(() => _loadingMore = true);
    } else {
      setState(() {
        _loading = true;
        _error = null;
      });
    }

    try {
      final page = more ? _page + 1 : 1;
      final result = await ref
          .read(socialFeedControllerProvider.notifier)
          .getComments(postId: widget.postId, page: page);
      if (!mounted) return;
      setState(() {
        if (more) {
          _comments.addAll(result.data);
        } else {
          _comments
            ..clear()
            ..addAll(result.data);
        }
        _page = result.meta.page;
        _hasNext = result.meta.hasNextPage;
        _loading = false;
        _loadingMore = false;
        _error = null;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _loading = false;
        _loadingMore = false;
        _error = more
            ? 'Không tải thêm được bình luận.'
            : 'Không tải được bình luận.';
      });
    }
  }

  Future<void> _submit() async {
    final text = _input.text.trim();
    if (text.isEmpty || _submitting) return;
    setState(() => _submitting = true);
    try {
      final created = await ref
          .read(socialFeedControllerProvider.notifier)
          .createComment(postId: widget.postId, content: text);
      if (!mounted) return;
      if (created != null) {
        setState(() {
          _comments.insert(0, created);
          _input.clear();
          _submitting = false;
        });
      } else {
        setState(() => _submitting = false);
      }
    } catch (_) {
      if (!mounted) return;
      setState(() => _submitting = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Không gửi được bình luận. Thử lại.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final height = size.height * 0.62;
    return SizedBox(
      width: size.width - (AppSpacing.xl * 2),
      height: height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Bình luận', style: AppTypography.sectionTitle),
          const SizedBox(height: AppSpacing.sm),
          Expanded(child: _buildList()),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              Expanded(
                child: AppTextField(
                  controller: _input,
                  hint: 'Viết bình luận...',
                  textInputAction: TextInputAction.send,
                  onFieldSubmitted: (_) => _submit(),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              AppButton(
                label: 'Gửi',
                expand: false,
                isLoading: _submitting,
                onPressed: _submitting ? null : _submit,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildList() {
    if (_loading) {
      return const Center(
        child: SizedBox(
          width: 28,
          height: 28,
          child: CircularProgressIndicator(strokeWidth: 2.4),
        ),
      );
    }
    if (_error != null && _comments.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(_error!, style: AppTypography.body),
            const SizedBox(height: AppSpacing.sm),
            AppButton(
              label: 'Thử lại',
              expand: false,
              variant: AppButtonVariant.secondary,
              onPressed: _load,
            ),
          ],
        ),
      );
    }
    if (_comments.isEmpty) {
      return Center(
        child: Text(
          'Chưa có bình luận. Hãy là người đầu tiên!',
          style: AppTypography.body.copyWith(color: AppColors.textSecondary),
          textAlign: TextAlign.center,
        ),
      );
    }

    return ListView.separated(
      itemCount: _comments.length + (_hasNext || _error != null ? 1 : 0),
      separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.sm),
      itemBuilder: (context, index) {
        if (index >= _comments.length) {
          return Column(
            children: [
              if (_error != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.xs),
                  child: Text(
                    _error!,
                    style: AppTypography.caption.copyWith(
                      color: AppColors.danger,
                    ),
                  ),
                ),
              AppButton(
                label: 'Xem thêm',
                expand: false,
                variant: AppButtonVariant.secondary,
                isLoading: _loadingMore,
                onPressed: _loadingMore ? null : () => _load(more: true),
              ),
            ],
          );
        }
        final comment = _comments[index];
        return _CommentTile(comment: comment);
      },
    );
  }
}

class _CommentTile extends StatelessWidget {
  const _CommentTile({required this.comment});

  final SocialPostComment comment;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: AppColors.surfaceSubdued,
        borderRadius: BorderRadius.circular(AppRadius.card),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(comment.authorName, style: AppTypography.bodyMedium),
          const SizedBox(height: 4),
          Text(comment.content, style: AppTypography.body),
        ],
      ),
    );
  }
}
