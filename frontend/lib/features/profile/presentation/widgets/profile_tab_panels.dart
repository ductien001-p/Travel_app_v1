import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_empty_view.dart';
import 'package:travel_frontend_v1/core/widget/app_glass_surface.dart';
import 'package:travel_frontend_v1/core/widget/app_section_header.dart';

import '../../data/models/profile_showcase_models.dart';
import '../profile_count_format.dart';
import '../profile_showcase_labels.dart';
import 'profile_remote_image.dart';

class ProfileDnaIndex extends StatelessWidget {
  const ProfileDnaIndex({super.key, required this.traits});

  final List<ProfileTravelDnaBadge> traits;

  @override
  Widget build(BuildContext context) {
    if (traits.isEmpty) {
      return const AppEmptyView(
        title: 'Chưa có chỉ số DNA',
        description: 'Hoàn thiện sở thích để xem bản đồ du lịch của bạn.',
        icon: Icons.insights_outlined,
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const AppSectionHeader(title: 'Chỉ số Travel DNA'),
        const SizedBox(height: AppSpacing.sm),
        for (final trait in traits) ...[
          _DnaRow(trait: trait),
          const SizedBox(height: AppSpacing.xs),
        ],
      ],
    );
  }
}

class _DnaRow extends StatelessWidget {
  const _DnaRow({required this.trait});

  final ProfileTravelDnaBadge trait;

  @override
  Widget build(BuildContext context) => AppGlassSurface(
    radius: AppRadius.card,
    padding: const EdgeInsets.all(AppSpacing.md),
    child: Column(
      children: [
        Row(
          children: [
            Text(trait.icon, style: const TextStyle(fontSize: 22)),
            const SizedBox(width: AppSpacing.sm),
            Expanded(child: Text(trait.name, style: AppTypography.cardTitle)),
            Text(
              '${trait.score}',
              style: AppTypography.cardTitle.copyWith(color: AppColors.primary),
            ),
            Text('/100', style: AppTypography.caption),
          ],
        ),
        const SizedBox(height: AppSpacing.xs),
        ClipRRect(
          borderRadius: BorderRadius.circular(AppRadius.pill),
          child: ColoredBox(
            color: AppColors.surfaceSubdued,
            child: SizedBox(
              height: 8,
              width: double.infinity,
              child: Align(
                alignment: Alignment.centerLeft,
                child: FractionallySizedBox(
                  widthFactor: profileRatio(trait.score, 100),
                  heightFactor: 1,
                  child: const ColoredBox(color: AppColors.primary),
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

class ProfileSavedList extends StatelessWidget {
  const ProfileSavedList({
    super.key,
    required this.items,
    required this.onOpen,
    this.onSeeAll,
  });

  final List<ProfileShowcaseSavedPlace> items;
  final ValueChanged<ProfileShowcaseSavedPlace> onOpen;
  final VoidCallback? onSeeAll;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppSectionHeader(
            title: 'Đã lưu',
            actionLabel: onSeeAll == null ? null : 'Xem tất cả',
            onAction: onSeeAll,
          ),
          const SizedBox(height: AppSpacing.sm),
          const AppEmptyView(
            title: 'Chưa lưu mục nào',
            description: 'Địa điểm và chuyến đi bạn đánh dấu sẽ hiện ở đây.',
            icon: Icons.bookmark_outline_rounded,
          ),
        ],
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppSectionHeader(
          title: 'Đã lưu',
          actionLabel: onSeeAll == null ? null : 'Xem tất cả',
          onAction: onSeeAll,
        ),
        const SizedBox(height: AppSpacing.sm),
        for (final item in items) ...[
          AppGlassSurface(
            radius: AppRadius.card,
            padding: const EdgeInsets.all(AppSpacing.sm),
            child: Material(
              type: MaterialType.transparency,
              child: InkWell(
                onTap: () => onOpen(item),
                borderRadius: BorderRadius.circular(AppRadius.card),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(AppRadius.input),
                      child: SizedBox(
                        width: 64,
                        height: 64,
                        child: ProfileRemoteImage(url: item.coverImageUrl),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTypography.cardTitle,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            profileSavedPlaceSubtitle(item),
                            style: AppTypography.caption,
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.bookmark_rounded,
                      color: AppColors.primary,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
        ],
      ],
    );
  }
}

class ProfilePostsGrid extends StatelessWidget {
  const ProfilePostsGrid({
    super.key,
    required this.posts,
    required this.onOpen,
  });

  final List<ProfileShowcasePost> posts;
  final ValueChanged<ProfileShowcasePost> onOpen;

  @override
  Widget build(BuildContext context) {
    if (posts.isEmpty) {
      return const AppEmptyView(
        title: 'Chưa có bài viết',
        description: 'Ảnh và ghi chú hành trình sẽ hiện ở đây.',
        icon: Icons.grid_on_rounded,
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const AppSectionHeader(title: 'Bài viết'),
        const SizedBox(height: AppSpacing.sm),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: posts.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: AppSpacing.xs,
            mainAxisSpacing: AppSpacing.xs,
          ),
          itemBuilder: (context, index) {
            final post = posts[index];
            return ClipRRect(
              borderRadius: BorderRadius.circular(AppRadius.input),
              child: Material(
                color: AppColors.surfaceSubdued,
                child: InkWell(
                  onTap: () => onOpen(post),
                  child: Semantics(
                    label: post.caption ?? 'Bài viết',
                    child: ProfileRemoteImage(url: post.imageUrl),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
