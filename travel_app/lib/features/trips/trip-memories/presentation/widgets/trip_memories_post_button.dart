import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/widget/app_button.dart';

/// Floating "Đăng Khoảnh Khắc Mới" button; shows the progress while posting.
class TripMemoriesPostButton extends StatelessWidget {
  const TripMemoriesPostButton({
    super.key,
    required this.onPressed,
    this.uploadProgress,
  });

  final VoidCallback? onPressed;

  /// 0..1 while photos are being posted.
  final double? uploadProgress;

  @override
  Widget build(BuildContext context) {
    final progress = uploadProgress;
    final isUploading = progress != null;
    // Hugs the label like a pill, yet ellipsizes it on narrow screens or with
    // large text instead of overflowing.
    return Semantics(
      liveRegion: isUploading,
      child: IntrinsicWidth(
        child: AppButton(
          label: isUploading
              ? 'Đang tải lên ${(progress.clamp(0, 1) * 100).round()}%'
              : 'Đăng Khoảnh Khắc Mới',
          leadingIcon: isUploading
              ? Icons.cloud_upload_outlined
              : Icons.photo_camera_outlined,
          onPressed: isUploading ? null : onPressed,
        ),
      ),
    );
  }
}
