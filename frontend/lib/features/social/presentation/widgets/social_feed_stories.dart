import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_pressable.dart';

import '../../data/models/social_feed_models.dart';

class SocialFeedStories extends StatelessWidget {
  const SocialFeedStories({
    super.key,
    required this.stories,
    this.onSeeAll,
    this.onStoryTap,
  });

  final List<SocialFeedStory> stories;
  final VoidCallback? onSeeAll;
  final ValueChanged<SocialFeedStory>? onStoryTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.screenHorizontal,
          ),
          child: Row(
            children: [
              Text(
                'Khoảnh khắc hành trình',
                style: AppTypography.sectionTitle.copyWith(fontSize: 17),
              ),
              const SizedBox(width: AppSpacing.xs),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.danger.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppRadius.pill),
                ),
                child: Text(
                  'LIVE',
                  style: AppTypography.badge.copyWith(
                    color: AppColors.danger,
                    fontSize: 10,
                  ),
                ),
              ),
              const Spacer(),
              AppPressable(
                onTap: onSeeAll,
                borderRadius: BorderRadius.circular(AppRadius.pill),
                child: Row(
                  children: [
                    Text(
                      'Xem tất cả',
                      style: AppTypography.caption.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Icon(
                      Icons.chevron_right_rounded,
                      size: 16,
                      color: AppColors.primary,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        SizedBox(
          height: 96,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.screenHorizontal,
            ),
            itemCount: stories.length,
            separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.sm),
            itemBuilder: (context, index) {
              final story = stories[index];
              return _StoryNode(
                story: story,
                onTap: () => onStoryTap?.call(story),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _StoryNode extends StatelessWidget {
  const _StoryNode({required this.story, this.onTap});

  final SocialFeedStory story;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final ringColor = story.isSelf
        ? AppColors.primary.withValues(alpha: 0.45)
        : (story.isActive ? AppColors.primary : AppColors.borderNeutral);

    return AppPressable(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: SizedBox(
        width: 72,
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: 64,
                  height: 64,
                  padding: const EdgeInsets.all(2.5),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: ringColor,
                      width: story.isSelf ? 2 : 2.5,
                      strokeAlign: BorderSide.strokeAlignOutside,
                    ),
                  ),
                  child: ClipOval(
                    child: story.imageUrl != null && story.imageUrl!.isNotEmpty
                        ? Image.network(
                            story.imageUrl!,
                            fit: BoxFit.cover,
                            errorBuilder: (_, _, _) => const ColoredBox(
                              color: AppColors.primaryLight,
                              child: Icon(
                                Icons.person,
                                color: AppColors.primary,
                              ),
                            ),
                          )
                        : const ColoredBox(
                            color: AppColors.primaryLight,
                            child: Icon(Icons.person, color: AppColors.primary),
                          ),
                  ),
                ),
                if (story.isSelf)
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.surface, width: 2),
                      ),
                      child: const Icon(
                        Icons.add,
                        size: 14,
                        color: AppColors.textInverse,
                      ),
                    ),
                  ),
                if (story.badge != SocialFeedStoryBadge.none)
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: -2,
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 1,
                        ),
                        decoration: BoxDecoration(
                          color: story.badge == SocialFeedStoryBadge.live
                              ? AppColors.danger
                              : AppColors.primary,
                          borderRadius: BorderRadius.circular(AppRadius.pill),
                        ),
                        child: Text(
                          story.badge == SocialFeedStoryBadge.live
                              ? 'LIVE'
                              : 'Mới',
                          style: AppTypography.badge.copyWith(
                            color: AppColors.textInverse,
                            fontSize: 9,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              story.label,
              style: AppTypography.caption.copyWith(
                color: story.isActive || story.isSelf
                    ? AppColors.textPrimary
                    : AppColors.textSecondary,
                fontWeight: story.isActive || story.isSelf
                    ? FontWeight.w700
                    : FontWeight.w500,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
