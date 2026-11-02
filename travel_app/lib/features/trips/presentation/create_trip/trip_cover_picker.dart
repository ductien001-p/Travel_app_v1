import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widget/app_button.dart';
import '../../application/trip_cover_controller.dart';

class TripCoverPicker extends StatelessWidget {
  const TripCoverPicker({
    super.key,
    required this.state,
    required this.onPick,
    required this.onRetry,
    required this.onRemove,
  });

  final TripCoverState state;
  final VoidCallback onPick;
  final VoidCallback onRetry;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final previewBytes = state.previewBytes;
    if (previewBytes == null) return _EmptyCover(onPick: onPick);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _CoverPreview(bytes: previewBytes, state: state, onRetry: onRetry),
        const SizedBox(height: AppSpacing.sm),
        Row(
          children: [
            Expanded(
              child: AppButton(
                label: 'Đổi ảnh',
                leadingIcon: Icons.photo_library_outlined,
                variant: AppButtonVariant.secondary,
                onPressed: onPick,
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: AppButton(
                label: state.isUploading ? 'Hủy tải' : 'Xóa ảnh',
                leadingIcon: state.isUploading
                    ? Icons.close_rounded
                    : Icons.delete_outline,
                variant: AppButtonVariant.secondary,
                onPressed: onRemove,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _EmptyCover extends StatelessWidget {
  const _EmptyCover({required this.onPick});

  final VoidCallback onPick;

  @override
  Widget build(BuildContext context) => Semantics(
    button: true,
    label: 'Thêm ảnh bìa',
    child: Material(
      color: AppColors.surfaceSubdued,
      borderRadius: BorderRadius.circular(AppRadius.image),
      child: InkWell(
        onTap: onPick,
        borderRadius: BorderRadius.circular(AppRadius.image),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.image),
            border: Border.all(color: AppColors.primary38),
          ),
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.add_photo_alternate_outlined,
                  size: 36,
                  color: AppColors.primary,
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  'Thêm ảnh bìa',
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.primaryActive,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: AppSpacing.xxs),
                Text(
                  'JPG, PNG, WEBP, GIF • Tối đa 10MB',
                  style: AppTypography.caption.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

class _CoverPreview extends StatelessWidget {
  const _CoverPreview({
    required this.bytes,
    required this.state,
    required this.onRetry,
  });

  final Uint8List bytes;
  final TripCoverState state;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) => ClipRRect(
    borderRadius: BorderRadius.circular(AppRadius.image),
    child: AspectRatio(
      aspectRatio: 16 / 9,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.memory(
            bytes,
            fit: BoxFit.cover,
            gaplessPlayback: true,
            semanticLabel: 'Ảnh bìa chuyến đi',
          ),
          switch (state.status) {
            TripCoverStatus.uploading => _UploadingOverlay(state.progress),
            TripCoverStatus.failed => _FailedOverlay(
              message: state.errorMessage,
              onRetry: onRetry,
            ),
            TripCoverStatus.uploaded => const _UploadedBadge(),
            TripCoverStatus.empty => const SizedBox.shrink(),
          },
        ],
      ),
    ),
  );
}

class _UploadingOverlay extends StatelessWidget {
  const _UploadingOverlay(this.progress);

  final double progress;

  @override
  Widget build(BuildContext context) => ColoredBox(
    color: AppColors.heroOverlay,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox.square(
          dimension: 36,
          child: CircularProgressIndicator(
            value: progress > 0 ? progress : null,
            strokeWidth: 3,
            color: AppColors.textInverse,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          'Đang tải lên ${(progress * 100).round()}%',
          style: AppTypography.caption.copyWith(color: AppColors.textInverse),
        ),
      ],
    ),
  );
}

class _FailedOverlay extends StatelessWidget {
  const _FailedOverlay({required this.message, required this.onRetry});

  final String? message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) => ColoredBox(
    color: AppColors.heroOverlay,
    child: Padding(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline_rounded,
            color: AppColors.textInverse,
            size: 28,
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            message ?? 'Tải ảnh bìa thất bại.',
            textAlign: TextAlign.center,
            style: AppTypography.caption.copyWith(color: AppColors.textInverse),
          ),
          const SizedBox(height: AppSpacing.xs),
          AppButton(
            label: 'Thử lại',
            leadingIcon: Icons.refresh_rounded,
            variant: AppButtonVariant.glass,
            expand: false,
            onPressed: onRetry,
          ),
        ],
      ),
    ),
  );
}

class _UploadedBadge extends StatelessWidget {
  const _UploadedBadge();

  @override
  Widget build(BuildContext context) => Align(
    alignment: Alignment.topRight,
    child: Padding(
      padding: const EdgeInsets.all(AppSpacing.sm),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.glass90,
          borderRadius: BorderRadius.circular(AppRadius.pill),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.sm,
            vertical: AppSpacing.xxs,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.check_circle_rounded,
                size: 16,
                color: AppColors.success,
              ),
              const SizedBox(width: AppSpacing.xxs),
              Text(
                'Đã tải lên',
                style: AppTypography.badge.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
