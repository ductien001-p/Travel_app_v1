import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_sizes.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_avatar.dart';
import 'package:travel_frontend_v1/core/widget/app_icon_button.dart';
import 'package:travel_frontend_v1/core/widget/app_text_field.dart';

import '../../../trip-details/presentation/widgets/trip_detail_feedback.dart';
import '../../../trip-details/utils/trip_detail_formatters.dart';
import '../../application/trip_memories_action_controller.dart';
import '../../application/trip_memories_view.dart';
import '../../utils/trip_memories_formatters.dart';
import '../widgets/trip_memory_photo_tile.dart';

/// Full-screen photos of the album, swiping through [tiles].
class TripMemoryViewerScreen extends ConsumerStatefulWidget {
  const TripMemoryViewerScreen({
    super.key,
    required this.tripId,
    required this.tiles,
    this.initialIndex = 0,
  });

  final String tripId;
  final List<TripMemoryTile> tiles;
  final int initialIndex;

  static Route<void> route({
    required String tripId,
    required List<TripMemoryTile> tiles,
    required int initialIndex,
  }) => MaterialPageRoute(
    fullscreenDialog: true,
    builder: (_) => TripMemoryViewerScreen(
      tripId: tripId,
      tiles: tiles,
      initialIndex: initialIndex,
    ),
  );

  @override
  ConsumerState<TripMemoryViewerScreen> createState() =>
      _TripMemoryViewerScreenState();
}

class _TripMemoryViewerScreenState
    extends ConsumerState<TripMemoryViewerScreen> {
  late final PageController _pageController;
  late int _index;
  late List<TripMemoryTile> _tiles;

  static const _captionMaxLength = 1000;

  @override
  void initState() {
    super.initState();
    _tiles = List.of(widget.tiles);
    _index = widget.initialIndex.clamp(0, _tiles.length - 1);
    _pageController = PageController(initialPage: _index);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  TripMemoryTile get _current => _tiles[_index];

  @override
  Widget build(BuildContext context) {
    final action = ref.watch(
      tripMemoriesActionControllerProvider(widget.tripId),
    );
    final isDeleting = action.deletingId == _current.entry.id;
    final isUpdating = action.updatingId == _current.entry.id;
    return Scaffold(
      backgroundColor: AppColors.textPrimary,
      body: Stack(
        fit: StackFit.expand,
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: _tiles.length,
            onPageChanged: (index) => setState(() => _index = index),
            itemBuilder: (context, index) => InteractiveViewer(
              maxScale: 4,
              child: TripMemoryNetworkImage(
                url: _tiles[index].entry.imageUrl,
                fit: BoxFit.contain,
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Row(
                children: [
                  AppIconButton(
                    icon: Icons.close_rounded,
                    iconColor: AppColors.textPrimary,
                    onPressed: () => Navigator.of(context).pop(),
                    semanticLabel: 'Đóng',
                  ),
                  Expanded(
                    child: Text(
                      '${_index + 1}/${_tiles.length}',
                      textAlign: TextAlign.center,
                      style: AppTypography.cardTitle.copyWith(
                        color: AppColors.textInverse,
                      ),
                    ),
                  ),
                  if (_current.canEdit)
                    isUpdating
                        ? const SizedBox.square(
                            dimension: AppSizes.iconButton,
                            child: Padding(
                              padding: EdgeInsets.all(AppSpacing.xs),
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: AppColors.textInverse,
                              ),
                            ),
                          )
                        : AppIconButton(
                            icon: Icons.edit_outlined,
                            iconColor: AppColors.textInverse,
                            onPressed: action.isBusy ? null : _editCaption,
                            semanticLabel: 'Sửa mô tả',
                          )
                  else
                    const SizedBox(width: AppSizes.iconButton),
                  if (_current.canDelete)
                    isDeleting
                        ? const SizedBox.square(
                            dimension: AppSizes.iconButton,
                            child: Padding(
                              padding: EdgeInsets.all(AppSpacing.xs),
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: AppColors.textInverse,
                              ),
                            ),
                          )
                        : AppIconButton(
                            icon: Icons.delete_outline_rounded,
                            iconColor: AppColors.danger,
                            onPressed: action.isBusy ? null : _confirmDelete,
                            semanticLabel: 'Xóa ảnh',
                          )
                  else
                    const SizedBox(width: AppSizes.iconButton),
                ],
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: _PhotoDetails(tile: _current),
          ),
        ],
      ),
    );
  }

  Future<void> _editCaption() async {
    final tile = _current;
    final next = await showDialog<String?>(
      context: context,
      builder: (ctx) => _EditCaptionDialog(
        initialCaption: tile.entry.caption,
        maxLength: _captionMaxLength,
      ),
    );
    // `null` means cancelled; empty string means clear caption.
    if (next == null || !mounted) return;
    final messenger = ScaffoldMessenger.of(context);
    try {
      final updated = await ref
          .read(tripMemoriesActionControllerProvider(widget.tripId).notifier)
          .updateCaption(tile.entry.id, caption: next);
      if (!mounted) return;
      setState(() {
        _tiles[_index] = tile.withEntry(updated);
      });
      messenger
        ..hideCurrentSnackBar()
        ..showSnackBar(const SnackBar(content: Text('Đã cập nhật mô tả.')));
    } catch (error) {
      if (mounted) {
        showTripDetailMessage(context, tripMemoryUpdateErrorMessage(error));
      }
    }
  }

  Future<void> _confirmDelete() async {
    final tile = _current;
    final confirmed = await confirmTripDetailAction(
      context,
      title: 'Xóa ảnh này?',
      message: 'Ảnh sẽ bị xóa khỏi album của chuyến đi cho mọi thành viên.',
      confirmLabel: 'Xóa',
    );
    if (!confirmed || !mounted) return;
    final messenger = ScaffoldMessenger.of(context);
    try {
      await ref
          .read(tripMemoriesActionControllerProvider(widget.tripId).notifier)
          .delete(tile.entry.id, day: tile.day);
      if (!mounted) return;
      Navigator.of(context).pop();
      messenger
        ..hideCurrentSnackBar()
        ..showSnackBar(const SnackBar(content: Text('Đã xóa ảnh khỏi album.')));
    } catch (error) {
      if (mounted) {
        showTripDetailMessage(context, tripMemoryDeleteErrorMessage(error));
      }
    }
  }
}

class _EditCaptionDialog extends StatefulWidget {
  const _EditCaptionDialog({
    required this.initialCaption,
    required this.maxLength,
  });

  final String? initialCaption;
  final int maxLength;

  @override
  State<_EditCaptionDialog> createState() => _EditCaptionDialogState();
}

class _EditCaptionDialogState extends State<_EditCaptionDialog> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialCaption ?? '');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Sửa mô tả'),
      content: AppTextField(
        controller: _controller,
        label: 'Mô tả',
        hint: 'Thêm mô tả cho ảnh…',
        maxLines: 4,
        minLines: 2,
        inputFormatters: [LengthLimitingTextInputFormatter(widget.maxLength)],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Hủy'),
        ),
        FilledButton(
          onPressed: () => Navigator.of(context).pop(_controller.text),
          child: const Text('Lưu'),
        ),
      ],
    );
  }
}

class _PhotoDetails extends StatelessWidget {
  const _PhotoDetails({required this.tile});

  final TripMemoryTile tile;

  @override
  Widget build(BuildContext context) {
    final caption = tile.entry.caption?.trim();
    final badge = tile.entry.badge?.trim();
    final inverse = AppTypography.caption.copyWith(
      color: AppColors.textInverse,
    );
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            AppColors.heroOverlay,
            AppColors.heroOverlay.withValues(alpha: 0),
          ],
        ),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.screenHorizontal,
            AppSpacing.xxl,
            AppSpacing.screenHorizontal,
            AppSpacing.md,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (badge != null && badge.isNotEmpty) ...[
                TripMemoryBadge(label: badge),
                const SizedBox(height: AppSpacing.xs),
              ],
              if (caption != null && caption.isNotEmpty) ...[
                Text(
                  caption,
                  style: AppTypography.cardTitle.copyWith(
                    color: AppColors.textInverse,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
              ],
              Row(
                children: [
                  AppAvatar(
                    size: AppSizes.avatarSm,
                    imageUrl: tile.uploaderAvatarUrl,
                    initials: initialsOf(tile.uploaderName),
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  Expanded(
                    child: Text(
                      tile.uploaderName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: inverse.copyWith(fontWeight: FontWeight.w700),
                    ),
                  ),
                  Text(
                    '${formatMemoryDate(tile.time)} • '
                    '${formatMemoryClock(tile.time)}',
                    style: inverse,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
