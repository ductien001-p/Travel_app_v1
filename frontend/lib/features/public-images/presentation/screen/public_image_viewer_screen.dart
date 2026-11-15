import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';
import 'package:travel_frontend_v1/app/router/router_names.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_error_view.dart';

import '../../application/public_image_viewer_controller.dart';
import '../../application/public_image_viewer_view.dart';
import '../../data/models/public_image_models.dart';
import '../widgets/public_image_network.dart';
import '../widgets/public_image_options_sheet.dart';
import '../widgets/public_image_viewer_chrome.dart';

/// Stitch: Fullscreen Photo Viewer + Menu Tùy Chọn 3 Chấm.
class PublicImageViewerScreen extends ConsumerStatefulWidget {
  const PublicImageViewerScreen({
    super.key,
    required this.albumId,
    this.initialIndex = 0,
    this.initialImageId,
  });

  final String albumId;
  final int initialIndex;
  final String? initialImageId;

  static const defaultAlbumId = 'ban-co-sunrise';

  @override
  ConsumerState<PublicImageViewerScreen> createState() =>
      _PublicImageViewerScreenState();
}

class _PublicImageViewerScreenState
    extends ConsumerState<PublicImageViewerScreen> {
  static const _canvas = Color(0xFF0A0F12);

  PageController? _pageController;
  final Map<int, TransformationController> _transforms = {};
  double _rotationTurns = 0;
  bool _moreHighlighted = false;
  int? _boundIndex;

  PublicImageViewerArgs get _args => PublicImageViewerArgs(
    albumId: widget.albumId,
    initialIndex: widget.initialIndex,
    initialImageId: widget.initialImageId,
  );

  @override
  void dispose() {
    _pageController?.dispose();
    for (final controller in _transforms.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(publicImageViewerControllerProvider(_args));

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: _canvas,
        body: async.when(
          loading: () => const Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          ),
          error: (error, _) => AppErrorView(
            title: 'Không tải được ảnh',
            message: 'Vui lòng thử lại.',
            actionLabel: 'Thử lại',
            onRetry: () => ref
                .read(publicImageViewerControllerProvider(_args).notifier)
                .refresh(),
          ),
          data: _buildBody,
        ),
      ),
    );
  }

  Widget _buildBody(PublicImageViewerViewState view) {
    if (view.total == 0) {
      return AppErrorView(
        title: 'Album trống',
        message: 'Không còn ảnh để xem.',
        actionLabel: 'Đóng',
        onRetry: () => Navigator.of(context).maybePop(),
      );
    }

    _ensurePageController(view.index);

    return Stack(
      fit: StackFit.expand,
      children: [
        DecoratedBox(
          decoration: const BoxDecoration(
            gradient: RadialGradient(
              center: Alignment.center,
              radius: 1.05,
              colors: [Colors.transparent, Color(0xD9000000)],
              stops: [0.40, 1.0],
            ),
          ),
        ),
        PageView.builder(
          controller: _pageController,
          itemCount: view.total,
          onPageChanged: (index) {
            ref
                .read(publicImageViewerControllerProvider(_args).notifier)
                .setIndex(index);
            setState(() {
              _rotationTurns = 0;
              _moreHighlighted = false;
            });
          },
          itemBuilder: (context, index) {
            final image = view.album.images[index];
            final transform = _transforms.putIfAbsent(
              index,
              TransformationController.new,
            );
            return GestureDetector(
              onTap: () => ref
                  .read(publicImageViewerControllerProvider(_args).notifier)
                  .toggleChrome(),
              onDoubleTap: () => _toggleZoom(transform),
              child: InteractiveViewer(
                transformationController: transform,
                minScale: 1,
                maxScale: 4,
                child: Center(
                  child: Transform.rotate(
                    angle: _rotationTurns * math.pi / 2,
                    child: PublicImageNetwork(
                      url: image.imageUrl,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
        if (view.showChrome) ...[
          SafeArea(
            bottom: false,
            child: Column(
              children: [
                PublicImageViewerTopBar(
                  index: view.index,
                  total: view.total,
                  capturedAt: view.current.capturedAt,
                  onClose: () => Navigator.of(context).maybePop(),
                  onRotate: () => setState(() => _rotationTurns += 1),
                  onInfo: () => ref
                      .read(publicImageViewerControllerProvider(_args).notifier)
                      .toggleExif(),
                  onMore: () => _openOptions(view),
                  moreHighlighted: _moreHighlighted,
                ),
                if (view.showExif) ...[
                  const SizedBox(height: AppSpacing.sm),
                  PublicImageExifPill(summary: view.current.exifSummary ?? ''),
                ],
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: SafeArea(
              top: false,
              child: PublicImageViewerBottomChrome(
                images: view.album.images,
                index: view.index,
                current: view.current,
                onSelectIndex: (index) {
                  _pageController?.animateToPage(
                    index,
                    duration: const Duration(milliseconds: 240),
                    curve: Curves.easeOutCubic,
                  );
                  ref
                      .read(publicImageViewerControllerProvider(_args).notifier)
                      .setIndex(index);
                },
                onLike: null,
                onComment: null,
                onDownload: null,
                onShare: () => _share(view.current),
              ),
            ),
          ),
        ] else
          Positioned(
            left: 0,
            right: 0,
            bottom: AppSpacing.xxl,
            child: Center(
              child: PublicImageLocationPill(
                label: view.current.locationLabel ?? '',
                onTap: () => _openMap(view),
              ),
            ),
          ),
      ],
    );
  }

  void _ensurePageController(int index) {
    if (_pageController == null) {
      _pageController = PageController(initialPage: index);
      _boundIndex = index;
      return;
    }
    if (_boundIndex != index && !(_pageController?.hasClients ?? false)) {
      _pageController?.dispose();
      _pageController = PageController(initialPage: index);
      _boundIndex = index;
    }
  }

  void _toggleZoom(TransformationController controller) {
    final current = controller.value.getMaxScaleOnAxis();
    controller.value = current > 1.05
        ? Matrix4.identity()
        : (Matrix4.identity()..scale(2.4));
  }

  Future<void> _openOptions(PublicImageViewerViewState view) async {
    setState(() => _moreHighlighted = true);
    await showPublicImageOptionsSheet(
      context: context,
      image: view.current,
      index: view.index,
      total: view.total,
      onViewMap: () => _openMap(view),
    );
    if (mounted) setState(() => _moreHighlighted = false);
  }

  void _openMap(PublicImageViewerViewState view) {
    final image = view.current;
    if (image.latitude == null || image.longitude == null) {
      _snack('Ảnh này chưa có tọa độ.');
      return;
    }
    context.pushNamed(
      RouteNames.publicImageMap,
      pathParameters: {'albumId': widget.albumId},
      queryParameters: {'imageId': image.id},
    );
  }

  Future<void> _share(PublicImageItem image) async {
    final url = image.shareUrl ?? image.imageUrl;
    await SharePlus.instance.share(
      ShareParams(text: url, title: image.caption),
    );
  }

  void _snack(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text(message, style: AppTypography.body)),
      );
  }
}
