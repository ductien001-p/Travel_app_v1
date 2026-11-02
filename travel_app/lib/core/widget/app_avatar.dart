import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_shadows.dart';
import '../theme/app_typography.dart';

class AppAvatar extends StatelessWidget {
  const AppAvatar({
    super.key,
    required this.size,
    this.imageUrl,
    this.initials,
    this.verified = false,
  });

  final double size;
  final String? imageUrl;
  final String? initials;
  final bool verified;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: size,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.surface,
              boxShadow: AppShadows.level1,
            ),
            padding: const EdgeInsets.all(2),
            child: ClipOval(
              child: ColoredBox(
                color: AppColors.primaryLight,
                child: imageUrl != null && imageUrl!.isNotEmpty
                    ? Image.network(
                        imageUrl!,
                        fit: BoxFit.cover,
                        width: size,
                        height: size,
                        errorBuilder: (_, _, _) =>
                            _FallbackAvatar(initials: initials),
                      )
                    : _FallbackAvatar(initials: initials),
              ),
            ),
          ),
          if (verified)
            Positioned(
              right: -1,
              bottom: -1,
              child: Container(
                width: size * 0.28,
                height: size * 0.28,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary,
                ),
                alignment: Alignment.center,
                child: Icon(
                  Icons.check_rounded,
                  size: size * 0.18,
                  color: AppColors.textInverse,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _FallbackAvatar extends StatelessWidget {
  const _FallbackAvatar({this.initials});

  final String? initials;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        initials ?? '?',
        style: AppTypography.cardTitle.copyWith(color: AppColors.primaryActive),
      ),
    );
  }
}
