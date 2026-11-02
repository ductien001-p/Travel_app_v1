import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/widget/app_avatar.dart';

class ProfileAvatarSection extends StatelessWidget {
  const ProfileAvatarSection({
    super.key,
    required this.initials,
    this.imageUrl,
    this.onSelectAvatar,
  });
  final String initials;
  final String? imageUrl;
  final VoidCallback? onSelectAvatar;
  @override
  Widget build(BuildContext context) => Stack(
    clipBehavior: Clip.none,
    children: [
      AppAvatar(size: 104, initials: initials, imageUrl: imageUrl),
      if (onSelectAvatar != null)
        Positioned(
          right: 0,
          bottom: 0,
          child: IconButton.filled(
            onPressed: onSelectAvatar,
            icon: const Icon(Icons.camera_alt_outlined, size: 18),
            style: IconButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.textInverse,
            ),
          ),
        ),
    ],
  );
}
