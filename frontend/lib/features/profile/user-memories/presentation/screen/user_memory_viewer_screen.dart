import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/features/profile/presentation/widgets/profile_remote_image.dart';

class UserMemoryViewerScreen extends StatelessWidget {
  const UserMemoryViewerScreen({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.subtitle,
  });

  final String imageUrl;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.textPrimary,
      appBar: AppBar(
        backgroundColor: AppColors.textPrimary,
        foregroundColor: AppColors.textInverse,
        elevation: 0,
        title: Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTypography.cardTitle.copyWith(color: AppColors.textInverse),
        ),
      ),
      body: Column(
        children: [
          Expanded(child: ProfileRemoteImage(url: imageUrl)),
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.lg,
              AppSpacing.md,
              AppSpacing.lg,
              AppSpacing.xl,
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                subtitle,
                style: AppTypography.body.copyWith(
                  color: AppColors.textInverse,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void openUserMemoryViewer(
  BuildContext context, {
  required String imageUrl,
  required String title,
  required String subtitle,
}) {
  Navigator.of(context).push(
    MaterialPageRoute<void>(
      builder: (context) => UserMemoryViewerScreen(
        imageUrl: imageUrl,
        title: title,
        subtitle: subtitle,
      ),
    ),
  );
}
