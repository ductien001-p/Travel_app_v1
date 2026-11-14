import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_avatar.dart';
import 'package:travel_frontend_v1/core/widget/app_button.dart';
import 'package:travel_frontend_v1/core/widget/app_pressable.dart';

import '../../application/social_post_detail_view.dart';
import '../../data/models/social_post_detail_models.dart';

class SocialPostDetailCommentsSection extends StatelessWidget {
  const SocialPostDetailCommentsSection({
    super.key,
    required this.view,
    required this.authorId,
    required this.loadingMore,
    required this.error,
    required this.onSortChanged,
    required this.onLoadMore,
    required this.onRetry,
    required this.onReply,
  });

  final SocialPostDetailView view;
  final String authorId;
  final bool loadingMore;
  final String? error;
  final ValueChanged<SocialPostCommentSort> onSortChanged;
  final VoidCallback onLoadMore;
  final VoidCallback onRetry;
  final ValueChanged<SocialPostDetailComment> onReply;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.screenHorizontal,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('Bình luận', style: AppTypography.sectionTitle),
              const SizedBox(width: 8),
              Text(
                formatCountLabel(view.post.commentsCount),
                style: AppTypography.caption.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacer(),
              PopupMenuButton<SocialPostCommentSort>(
                onSelected: onSortChanged,
                itemBuilder: (context) => const [
                  PopupMenuItem(
                    value: SocialPostCommentSort.relevant,
                    child: Text('Phù hợp nhất'),
                  ),
                  PopupMenuItem(
                    value: SocialPostCommentSort.newest,
                    child: Text('Mới nhất'),
                  ),
                ],
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      view.sort == SocialPostCommentSort.newest
                          ? 'Mới nhất'
                          : 'Phù hợp nhất',
                      style: AppTypography.caption.copyWith(
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Icon(
                      Icons.expand_more_rounded,
                      size: 18,
                      color: AppColors.textSecondary,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          if (error != null && view.comments.isEmpty)
            Column(
              children: [
                Text(
                  error!,
                  style: AppTypography.body.copyWith(
                    color: AppColors.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppSpacing.sm),
                AppButton(
                  label: 'Thử lại',
                  expand: false,
                  variant: AppButtonVariant.secondary,
                  onPressed: onRetry,
                ),
              ],
            )
          else if (view.comments.isEmpty)
            Text(
              'Chưa có bình luận. Hãy là người đầu tiên!',
              style: AppTypography.body.copyWith(
                color: AppColors.textSecondary,
              ),
            )
          else ...[
            for (final comment in view.comments) ...[
              SocialPostDetailCommentTile(
                comment: comment,
                isAuthor: comment.userId == authorId,
                onReply: () => onReply(comment),
              ),
              const SizedBox(height: AppSpacing.sm),
            ],
            if (error != null)
              Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.xs),
                child: Text(
                  error!,
                  style: AppTypography.caption.copyWith(
                    color: AppColors.danger,
                  ),
                ),
              ),
            if (view.hasNextComments || view.remainingComments > 0)
              AppPressable(
                onTap: loadingMore ? null : onLoadMore,
                borderRadius: BorderRadius.circular(AppRadius.pill),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceSubdued,
                    borderRadius: BorderRadius.circular(AppRadius.pill),
                    border: Border.all(color: AppColors.borderNeutral),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (loadingMore)
                        const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      else ...[
                        Text(
                          view.remainingComments > 0
                              ? 'Xem thêm ${view.remainingComments} bình luận khác'
                              : 'Xem thêm bình luận',
                          style: AppTypography.bodyMedium.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: AppColors.primary,
                        ),
                      ],
                    ],
                  ),
                ),
              ),
          ],
        ],
      ),
    );
  }
}

class SocialPostDetailCommentTile extends StatelessWidget {
  const SocialPostDetailCommentTile({
    super.key,
    required this.comment,
    required this.isAuthor,
    required this.onReply,
  });

  final SocialPostDetailComment comment;
  final bool isAuthor;
  final VoidCallback onReply;

  @override
  Widget build(BuildContext context) {
    final name = comment.user.username;
    final initial = name.isNotEmpty ? name.characters.first.toUpperCase() : '?';

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppAvatar(
          size: 36,
          imageUrl: comment.user.avatarUrl,
          initials: initial,
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(AppSpacing.sm + 2),
            decoration: BoxDecoration(
              color: isAuthor
                  ? AppColors.primaryLight
                  : AppColors.surfaceSubdued,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isAuthor
                    ? AppColors.borderBrandSoft
                    : AppColors.borderNeutral,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 6,
                  runSpacing: 4,
                  children: [
                    Text(
                      name,
                      style: AppTypography.bodyMedium.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    if (isAuthor)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(AppRadius.pill),
                        ),
                        child: Text(
                          'Tác giả',
                          style: AppTypography.badge.copyWith(
                            color: AppColors.textInverse,
                          ),
                        ),
                      ),
                    Text(
                      formatCommentTimeLabel(comment.createdAt),
                      style: AppTypography.caption.copyWith(
                        color: AppColors.textTertiary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(comment.content, style: AppTypography.body),
                const SizedBox(height: 8),
                AppPressable(
                  onTap: onReply,
                  child: Text(
                    'Trả lời',
                    style: AppTypography.caption.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
