import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';

import '../../application/social_post_detail_view.dart';

class SocialPostDetailContent extends StatelessWidget {
  const SocialPostDetailContent({super.key, required this.view});

  final SocialPostDetailView view;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.screenHorizontal,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (view.captionBody.isNotEmpty)
            Text(
              view.captionBody,
              style: AppTypography.body.copyWith(
                color: AppColors.textPrimary,
                height: 1.5,
              ),
            ),
          if (view.hashtags.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.sm),
            Wrap(
              spacing: 8,
              runSpacing: 6,
              children: [
                for (final tag in view.hashtags)
                  Text(
                    tag,
                    style: AppTypography.bodyMedium.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
              ],
            ),
          ],
          if (view.post.tipTitle != null || view.post.tipBody != null) ...[
            const SizedBox(height: AppSpacing.md),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: AppColors.surfaceSubdued,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.borderNeutral),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (view.post.tipTitle != null)
                    Text(
                      view.post.tipTitle!,
                      style: AppTypography.cardTitle.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  if (view.post.tipBody != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      view.post.tipBody!,
                      style: AppTypography.body.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
