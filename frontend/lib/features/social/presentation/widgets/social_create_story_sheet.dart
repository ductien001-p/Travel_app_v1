import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_bottom_sheet.dart';
import 'package:travel_frontend_v1/core/widget/app_button.dart';
import 'package:travel_frontend_v1/core/widget/app_pressable.dart';
import 'package:travel_frontend_v1/core/widget/app_text_field.dart';
import 'package:travel_frontend_v1/features/media/data/models/media_upload_folder.dart';
import 'package:travel_frontend_v1/features/media/providers/media_providers.dart';

import '../../application/social_feed_controller.dart';

Future<bool?> showSocialCreateStorySheet({
  required BuildContext context,
  required String defaultLabel,
}) {
  return showAppBottomSheet<bool>(
    context: context,
    child: _SocialCreateStorySheet(defaultLabel: defaultLabel),
  );
}

class _SocialCreateStorySheet extends ConsumerStatefulWidget {
  const _SocialCreateStorySheet({required this.defaultLabel});

  final String defaultLabel;

  @override
  ConsumerState<_SocialCreateStorySheet> createState() =>
      _SocialCreateStorySheetState();
}

class _SocialCreateStorySheetState
    extends ConsumerState<_SocialCreateStorySheet> {
  late final TextEditingController _label;
  XFile? _file;
  var _isLive = false;
  var _submitting = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _label = TextEditingController(text: widget.defaultLabel);
  }

  @override
  void dispose() {
    _label.dispose();
    super.dispose();
  }

  Future<void> _pick() async {
    final file = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1600,
      imageQuality: 88,
    );
    if (file == null || !mounted) return;
    setState(() {
      _file = file;
      _error = null;
    });
  }

  Future<void> _submit() async {
    final label = _label.text.trim();
    if (_file == null) {
      setState(() => _error = 'Chọn một ảnh cho story.');
      return;
    }
    if (label.isEmpty) {
      setState(() => _error = 'Nhập nhãn story.');
      return;
    }
    if (_submitting) return;

    setState(() {
      _submitting = true;
      _error = null;
    });

    try {
      final uploaded = await ref
          .read(mediaUploadRepositoryProvider)
          .uploadFiles(folder: MediaUploadFolder.posts, files: [_file!]);
      if (uploaded.isEmpty) {
        throw StateError('No media uploaded');
      }
      final ok = await ref
          .read(socialFeedControllerProvider.notifier)
          .createStory(
            mediaId: uploaded.first.id,
            label: label,
            isLive: _isLive,
          );
      if (!mounted) return;
      if (ok) {
        Navigator.of(context).pop(true);
        return;
      }
      setState(() {
        _submitting = false;
        _error = 'Không tạo được story. Thử lại.';
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _submitting = false;
        _error = 'Upload/tạo story thất bại. Thử lại.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Thêm khoảnh khắc', style: AppTypography.sectionTitle),
        const SizedBox(height: AppSpacing.md),
        AppPressable(
          onTap: _submitting ? null : _pick,
          borderRadius: BorderRadius.circular(AppRadius.card),
          child: Container(
            height: 180,
            decoration: BoxDecoration(
              color: AppColors.surfaceSubdued,
              borderRadius: BorderRadius.circular(AppRadius.card),
              border: Border.all(color: AppColors.borderNeutral),
            ),
            clipBehavior: Clip.antiAlias,
            child: _file == null
                ? const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add_photo_alternate_outlined,
                        color: AppColors.primary,
                        size: 36,
                      ),
                      SizedBox(height: 8),
                      Text('Chọn ảnh', style: AppTypography.bodyMedium),
                    ],
                  )
                : Image.file(File(_file!.path), fit: BoxFit.cover),
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        AppTextField(controller: _label, hint: 'Nhãn story'),
        SwitchListTile.adaptive(
          contentPadding: EdgeInsets.zero,
          title: Text('Đánh dấu LIVE', style: AppTypography.bodyMedium),
          value: _isLive,
          activeThumbColor: AppColors.primary,
          onChanged: _submitting
              ? null
              : (value) => setState(() => _isLive = value),
        ),
        if (_error != null)
          Text(
            _error!,
            style: AppTypography.caption.copyWith(color: AppColors.danger),
          ),
        const SizedBox(height: AppSpacing.sm),
        AppButton(
          label: 'Đăng story',
          isLoading: _submitting,
          onPressed: _submitting ? null : _submit,
        ),
      ],
    );
  }
}
