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

const _topicOptions = <({String id, String label})>[
  (id: 'HIDDEN_EATS', label: '🍜 Quán ngon'),
  (id: 'PHOTO_SPOTS', label: '📸 Sống ảo'),
  (id: 'ITINERARY_2N1D', label: '🗺️ 2N1Đ'),
  (id: 'FIND_BUDDY', label: '🎒 Tìm buddy'),
];

Future<bool?> showSocialCreatePostSheet({
  required BuildContext context,
  String? initialHint,
}) {
  return showAppBottomSheet<bool>(
    context: context,
    child: _SocialCreatePostSheet(initialHint: initialHint),
  );
}

class _SocialCreatePostSheet extends ConsumerStatefulWidget {
  const _SocialCreatePostSheet({this.initialHint});

  final String? initialHint;

  @override
  ConsumerState<_SocialCreatePostSheet> createState() =>
      _SocialCreatePostSheetState();
}

class _SocialCreatePostSheetState
    extends ConsumerState<_SocialCreatePostSheet> {
  final _caption = TextEditingController();
  final _tipTitle = TextEditingController();
  final _tipBody = TextEditingController();
  final _picked = <XFile>[];
  String? _topic;
  var _submitting = false;
  String? _error;

  @override
  void dispose() {
    _caption.dispose();
    _tipTitle.dispose();
    _tipBody.dispose();
    super.dispose();
  }

  Future<void> _pickPhotos() async {
    final files = await ImagePicker().pickMultiImage(
      maxWidth: 1920,
      imageQuality: 88,
    );
    if (files.isEmpty || !mounted) return;
    setState(() {
      _picked
        ..clear()
        ..addAll(files.take(10));
      _error = null;
    });
  }

  Future<void> _submit() async {
    final caption = _caption.text.trim();
    if (caption.isEmpty) {
      setState(() => _error = 'Hãy viết caption cho bài đăng.');
      return;
    }
    if (_picked.isEmpty) {
      setState(() => _error = 'Thêm ít nhất 1 ảnh.');
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
          .uploadFiles(folder: MediaUploadFolder.posts, files: _picked);
      final mediaIds = uploaded.map((item) => item.id).toList(growable: false);
      final ok = await ref
          .read(socialFeedControllerProvider.notifier)
          .createPost(
            caption: caption,
            mediaIds: mediaIds,
            tipTitle: _tipTitle.text,
            tipBody: _tipBody.text,
            topic: _topic,
          );
      if (!mounted) return;
      if (ok) {
        Navigator.of(context).pop(true);
        return;
      }
      setState(() {
        _submitting = false;
        _error = 'Không đăng được bài. Thử lại.';
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _submitting = false;
        _error = 'Upload/đăng bài thất bại. Thử lại.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 0.78;
    return SizedBox(
      height: height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Chia sẻ khoảnh khắc', style: AppTypography.sectionTitle),
          if (widget.initialHint != null) ...[
            const SizedBox(height: AppSpacing.xs),
            Text(
              widget.initialHint!,
              style: AppTypography.caption.copyWith(color: AppColors.primary),
            ),
          ],
          const SizedBox(height: AppSpacing.md),
          Expanded(
            child: ListView(
              children: [
                AppTextField(
                  controller: _caption,
                  hint: 'Bạn đang khám phá điều gì?',
                  maxLines: 4,
                  minLines: 3,
                ),
                const SizedBox(height: AppSpacing.sm),
                AppTextField(
                  controller: _tipTitle,
                  hint: 'Tiêu đề mẹo (tuỳ chọn)',
                ),
                const SizedBox(height: AppSpacing.sm),
                AppTextField(
                  controller: _tipBody,
                  hint: 'Nội dung mẹo (tuỳ chọn)',
                  maxLines: 3,
                  minLines: 2,
                ),
                const SizedBox(height: AppSpacing.md),
                Text('Chủ đề', style: AppTypography.bodyMedium),
                const SizedBox(height: AppSpacing.xs),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    for (final topic in _topicOptions)
                      ChoiceChip(
                        label: Text(topic.label),
                        selected: _topic == topic.id,
                        onSelected: (selected) {
                          setState(() => _topic = selected ? topic.id : null);
                        },
                      ),
                  ],
                ),
                const SizedBox(height: AppSpacing.md),
                Text('Ảnh', style: AppTypography.bodyMedium),
                const SizedBox(height: AppSpacing.xs),
                SizedBox(
                  height: 88,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      AppPressable(
                        onTap: _submitting ? null : _pickPhotos,
                        borderRadius: BorderRadius.circular(AppRadius.card),
                        child: Container(
                          width: 88,
                          height: 88,
                          decoration: BoxDecoration(
                            color: AppColors.primaryLight,
                            borderRadius: BorderRadius.circular(AppRadius.card),
                            border: Border.all(
                              color: AppColors.borderBrandSoft,
                            ),
                          ),
                          child: const Icon(
                            Icons.add_a_photo_outlined,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                      for (final file in _picked) ...[
                        const SizedBox(width: AppSpacing.sm),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(AppRadius.card),
                          child: Image.file(
                            File(file.path),
                            width: 88,
                            height: 88,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                if (_error != null) ...[
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    _error!,
                    style: AppTypography.caption.copyWith(
                      color: AppColors.danger,
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          AppButton(
            label: 'Đăng bài',
            isLoading: _submitting,
            onPressed: _submitting ? null : _submit,
          ),
        ],
      ),
    );
  }
}
