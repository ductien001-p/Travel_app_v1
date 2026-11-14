import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_error_view.dart';
import 'package:travel_frontend_v1/core/widget/app_pressable.dart';

import '../../application/public_image_viewer_controller.dart';
import '../../data/models/public_image_models.dart';
import '../../utils/public_image_formatters.dart';
import '../widgets/public_image_network.dart';

/// Stitch: Xem Vị Trí Trên Bản Đồ - Chế Độ Vệ Tinh.
class PublicImageMapScreen extends ConsumerStatefulWidget {
  const PublicImageMapScreen({super.key, required this.albumId, this.imageId});

  final String albumId;
  final String? imageId;

  @override
  ConsumerState<PublicImageMapScreen> createState() =>
      _PublicImageMapScreenState();
}

class _PublicImageMapScreenState extends ConsumerState<PublicImageMapScreen>
    with SingleTickerProviderStateMixin {
  GoogleMapController? _mapController;
  PublicImageMapLayer _layer = PublicImageMapLayer.satellite;
  late final AnimationController _pulse;

  PublicImageViewerArgs get _args => PublicImageViewerArgs(
    albumId: widget.albumId,
    initialImageId: widget.imageId,
  );

  @override
  void initState() {
    super.initState();
    _pulse = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2800),
    )..repeat();
  }

  @override
  void dispose() {
    _pulse.dispose();
    _mapController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(publicImageViewerControllerProvider(_args));

    return Scaffold(
      backgroundColor: AppColors.textPrimary,
      body: async.when(
        loading: () => const Center(
          child: CircularProgressIndicator(color: AppColors.primary),
        ),
        error: (error, _) => AppErrorView(
          title: 'Không tải được vị trí',
          message: 'Vui lòng thử lại.',
          actionLabel: 'Thử lại',
          onRetry: () => ref
              .read(publicImageViewerControllerProvider(_args).notifier)
              .refresh(),
        ),
        data: (view) {
          if (view.total == 0) {
            return AppErrorView(
              title: 'Không có ảnh',
              message: 'Album không còn ảnh để định vị.',
              actionLabel: 'Quay lại',
              onRetry: () => Navigator.of(context).maybePop(),
            );
          }
          final image = view.current;
          final lat = image.latitude;
          final lng = image.longitude;
          if (lat == null || lng == null) {
            return AppErrorView(
              title: 'Thiếu tọa độ',
              message: 'Ảnh này chưa gắn vị trí GPS.',
              actionLabel: 'Quay lại',
              onRetry: () => Navigator.of(context).maybePop(),
            );
          }
          return _MapBody(
            image: image,
            layer: _layer,
            pulse: _pulse,
            onBack: () => Navigator.of(context).maybePop(),
            onShare: () => _shareLocation(image),
            onLayerChanged: (layer) => setState(() => _layer = layer),
            onMapCreated: (controller) {
              _mapController = controller;
              controller.moveCamera(
                CameraUpdate.newLatLngZoom(LatLng(lat, lng), 15.2),
              );
            },
            onRecenter: () {
              _mapController?.animateCamera(
                CameraUpdate.newLatLngZoom(LatLng(lat, lng), 15.2),
              );
            },
            onZoomIn: () =>
                _mapController?.animateCamera(CameraUpdate.zoomIn()),
            onZoomOut: () =>
                _mapController?.animateCamera(CameraUpdate.zoomOut()),
            onOpenGoogleMaps: () => _shareText(
              googleMapsSearchUrl(
                latitude: lat,
                longitude: lng,
                label: image.locationLabel,
              ),
            ),
            onDirections: () => _shareText(
              googleMapsDirectionsUrl(latitude: lat, longitude: lng),
            ),
          );
        },
      ),
    );
  }

  Future<void> _shareLocation(PublicImageItem image) async {
    final lat = image.latitude;
    final lng = image.longitude;
    if (lat == null || lng == null) return;
    final label = image.locationLabel ?? 'Vị trí bức ảnh';
    await _shareText(
      '$label\n${googleMapsSearchUrl(latitude: lat, longitude: lng, label: label)}',
    );
  }

  Future<void> _shareText(String text) {
    final box = context.findRenderObject();
    final origin = box is RenderBox
        ? box.localToGlobal(Offset.zero) & box.size
        : null;
    return SharePlus.instance.share(
      ShareParams(text: text, sharePositionOrigin: origin),
    );
  }
}

class _MapBody extends StatelessWidget {
  const _MapBody({
    required this.image,
    required this.layer,
    required this.pulse,
    required this.onBack,
    required this.onShare,
    required this.onLayerChanged,
    required this.onMapCreated,
    required this.onRecenter,
    required this.onZoomIn,
    required this.onZoomOut,
    required this.onOpenGoogleMaps,
    required this.onDirections,
  });

  final PublicImageItem image;
  final PublicImageMapLayer layer;
  final AnimationController pulse;
  final VoidCallback onBack;
  final VoidCallback onShare;
  final ValueChanged<PublicImageMapLayer> onLayerChanged;
  final MapCreatedCallback onMapCreated;
  final VoidCallback onRecenter;
  final VoidCallback onZoomIn;
  final VoidCallback onZoomOut;
  final VoidCallback onOpenGoogleMaps;
  final VoidCallback onDirections;

  MapType get _mapType => switch (layer) {
    PublicImageMapLayer.satellite => MapType.hybrid,
    PublicImageMapLayer.terrain => MapType.terrain,
    PublicImageMapLayer.standard => MapType.normal,
  };

  @override
  Widget build(BuildContext context) {
    final lat = image.latitude!;
    final lng = image.longitude!;
    final target = LatLng(lat, lng);
    final altitude = image.altitudeMeters;
    final tipLabel = [
      image.locationShortLabel?.split(',').first.trim() ??
          image.locationLabel ??
          'Vị trí ảnh',
      if (altitude != null) '${altitude.round()}m',
    ].join(' • ');

    return Stack(
      fit: StackFit.expand,
      children: [
        GoogleMap(
          initialCameraPosition: CameraPosition(target: target, zoom: 15.2),
          mapType: _mapType,
          onMapCreated: onMapCreated,
          markers: {
            Marker(
              markerId: MarkerId(image.id),
              position: target,
              icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueAzure,
              ),
            ),
          },
          myLocationButtonEnabled: false,
          zoomControlsEnabled: false,
          compassEnabled: false,
          mapToolbarEnabled: false,
        ),
        IgnorePointer(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.textPrimary.withValues(alpha: 0.30),
                  Colors.transparent,
                  AppColors.textPrimary.withValues(alpha: 0.40),
                ],
              ),
            ),
          ),
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.md,
              AppSpacing.sm,
              AppSpacing.md,
              0,
            ),
            child: Column(
              children: [
                _TopBar(onBack: onBack, onShare: onShare),
                const SizedBox(height: AppSpacing.sm),
                _LayerSwitcher(layer: layer, onChanged: onLayerChanged),
              ],
            ),
          ),
        ),
        Align(
          alignment: const Alignment(0, -0.12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: AppColors.glass85,
                  borderRadius: BorderRadius.circular(AppRadius.pill),
                  border: Border.all(color: AppColors.glassBorder),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.marine16,
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      tipLabel,
                      style: AppTypography.caption.copyWith(
                        color: const Color(0xFF00312F),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(
                      Icons.verified_rounded,
                      size: 14,
                      color: AppColors.primary,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              SizedBox(
                width: 80,
                height: 80,
                child: AnimatedBuilder(
                  animation: pulse,
                  builder: (context, child) {
                    return Stack(
                      alignment: Alignment.center,
                      children: [
                        _PulseRing(progress: pulse.value),
                        _PulseRing(
                          progress: (pulse.value + 0.32) % 1.0,
                          color: const Color(0xFF84F5EF),
                        ),
                        child!,
                      ],
                    );
                  },
                  child: Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.surface, width: 2),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withValues(alpha: 0.35),
                          blurRadius: 16,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.photo_camera_rounded,
                      color: AppColors.textInverse,
                      size: 22,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          right: AppSpacing.md,
          top: MediaQuery.sizeOf(context).height * 0.30,
          child: _UtilityCluster(
            onCompass: () => _snack(context, 'La bàn 3D sắp có.'),
            onRecenter: onRecenter,
            onZoomIn: onZoomIn,
            onZoomOut: onZoomOut,
            onTilt: () => _snack(context, 'Góc nhìn 3D sắp có.'),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.md,
                0,
                AppSpacing.md,
                AppSpacing.md,
              ),
              child: _LocationCard(
                image: image,
                onOpenGoogleMaps: onOpenGoogleMaps,
                onDirections: onDirections,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _snack(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }
}

class _PulseRing extends StatelessWidget {
  const _PulseRing({required this.progress, this.color = AppColors.primary});

  final double progress;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final scale = 0.65 + progress * 1.75;
    final opacity = (1 - progress).clamp(0.0, 0.9);
    return Transform.scale(
      scale: scale,
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color.withValues(alpha: opacity * 0.35),
        ),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar({required this.onBack, required this.onShare});

  final VoidCallback onBack;
  final VoidCallback onShare;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xs + 2,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: AppColors.glass85,
        borderRadius: BorderRadius.circular(AppRadius.pill),
        border: Border.all(color: AppColors.glassBorder),
        boxShadow: [
          BoxShadow(
            color: AppColors.marine16,
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          _GlassRoundButton(
            icon: Icons.arrow_back_rounded,
            color: AppColors.primary,
            onTap: onBack,
            semanticLabel: 'Quay lại',
          ),
          Expanded(
            child: Column(
              children: [
                Text(
                  'BẢN ĐỒ VỆ TINH',
                  style: AppTypography.caption.copyWith(
                    color: AppColors.textTertiary,
                    letterSpacing: 0.8,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'Vị trí bức ảnh',
                  style: AppTypography.cardTitle.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          _GlassRoundButton(
            icon: Icons.share_rounded,
            color: AppColors.textSecondary,
            onTap: onShare,
            semanticLabel: 'Chia sẻ vị trí',
          ),
        ],
      ),
    );
  }
}

class _LayerSwitcher extends StatelessWidget {
  const _LayerSwitcher({required this.layer, required this.onChanged});

  final PublicImageMapLayer layer;
  final ValueChanged<PublicImageMapLayer> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.glass85,
        borderRadius: BorderRadius.circular(AppRadius.pill),
        border: Border.all(color: AppColors.glassBorder),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _LayerChip(
            selected: layer == PublicImageMapLayer.satellite,
            icon: Icons.satellite_alt_rounded,
            label: 'Vệ tinh',
            onTap: () => onChanged(PublicImageMapLayer.satellite),
          ),
          _LayerChip(
            selected: layer == PublicImageMapLayer.terrain,
            icon: Icons.terrain_rounded,
            label: 'Địa hình',
            onTap: () => onChanged(PublicImageMapLayer.terrain),
          ),
          _LayerChip(
            selected: layer == PublicImageMapLayer.standard,
            icon: Icons.map_rounded,
            label: 'Chuẩn',
            onTap: () => onChanged(PublicImageMapLayer.standard),
          ),
        ],
      ),
    );
  }
}

class _LayerChip extends StatelessWidget {
  const _LayerChip({
    required this.selected,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final bool selected;
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AppPressable(
      onTap: onTap,
      pressedScale: 0.96,
      borderRadius: BorderRadius.circular(AppRadius.pill),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm + 2,
          vertical: 6,
        ),
        decoration: BoxDecoration(
          color: selected ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(AppRadius.pill),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 16,
              color: selected ? AppColors.textInverse : AppColors.textSecondary,
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: AppTypography.badge.copyWith(
                color: selected
                    ? AppColors.textInverse
                    : AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _UtilityCluster extends StatelessWidget {
  const _UtilityCluster({
    required this.onCompass,
    required this.onRecenter,
    required this.onZoomIn,
    required this.onZoomOut,
    required this.onTilt,
  });

  final VoidCallback onCompass;
  final VoidCallback onRecenter;
  final VoidCallback onZoomIn;
  final VoidCallback onZoomOut;
  final VoidCallback onTilt;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _GlassRoundButton(
          icon: Icons.explore_rounded,
          color: AppColors.primary,
          onTap: onCompass,
          semanticLabel: 'La bàn 3D',
        ),
        const SizedBox(height: AppSpacing.xs + 2),
        _GlassRoundButton(
          icon: Icons.my_location_rounded,
          color: AppColors.primary,
          onTap: onRecenter,
          semanticLabel: 'Định vị lại vị trí',
        ),
        const SizedBox(height: AppSpacing.xs + 2),
        Container(
          decoration: BoxDecoration(
            color: AppColors.glass85,
            borderRadius: BorderRadius.circular(AppRadius.pill),
            border: Border.all(color: AppColors.glassBorder),
          ),
          child: Column(
            children: [
              _MiniMapButton(
                icon: Icons.add_rounded,
                onTap: onZoomIn,
                semanticLabel: 'Phóng to',
              ),
              Container(width: 24, height: 1, color: AppColors.borderNeutral),
              _MiniMapButton(
                icon: Icons.remove_rounded,
                onTap: onZoomOut,
                semanticLabel: 'Thu nhỏ',
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.xs + 2),
        _GlassRoundButton(
          icon: Icons.view_in_ar_rounded,
          color: AppColors.textSecondary,
          onTap: onTilt,
          semanticLabel: 'Góc nhìn nghiêng 3D',
        ),
      ],
    );
  }
}

class _MiniMapButton extends StatelessWidget {
  const _MiniMapButton({
    required this.icon,
    required this.onTap,
    required this.semanticLabel,
  });

  final IconData icon;
  final VoidCallback onTap;
  final String semanticLabel;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: semanticLabel,
      child: AppPressable(
        onTap: onTap,
        pressedScale: 0.92,
        borderRadius: BorderRadius.circular(AppRadius.pill),
        child: SizedBox(
          width: 44,
          height: 40,
          child: Icon(icon, size: 20, color: AppColors.textSecondary),
        ),
      ),
    );
  }
}

class _GlassRoundButton extends StatelessWidget {
  const _GlassRoundButton({
    required this.icon,
    required this.color,
    required this.onTap,
    required this.semanticLabel,
  });

  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  final String semanticLabel;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: semanticLabel,
      child: AppPressable(
        onTap: onTap,
        pressedScale: 0.92,
        borderRadius: BorderRadius.circular(AppRadius.pill),
        child: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: AppColors.glass85,
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.glassBorder),
            boxShadow: [
              BoxShadow(
                color: AppColors.marine16,
                blurRadius: 14,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Icon(icon, size: 22, color: color),
        ),
      ),
    );
  }
}

class _LocationCard extends StatelessWidget {
  const _LocationCard({
    required this.image,
    required this.onOpenGoogleMaps,
    required this.onDirections,
  });

  final PublicImageItem image;
  final VoidCallback onOpenGoogleMaps;
  final VoidCallback onDirections;

  @override
  Widget build(BuildContext context) {
    final thumb = image.thumbnailUrl ?? image.imageUrl;
    final altitude = image.altitudeMeters;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.glass90,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: AppColors.surface.withValues(alpha: 0.85)),
        boxShadow: [
          BoxShadow(
            color: AppColors.marine16,
            blurRadius: 28,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: SizedBox(
                  width: 80,
                  height: 80,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      PublicImageNetwork(url: thumb),
                      const DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.transparent, Color(0x800F1E24)],
                          ),
                        ),
                      ),
                      Positioned(
                        right: 4,
                        bottom: 4,
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            color: AppColors.glass85,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.zoom_in_rounded,
                            size: 13,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.sm + 2),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.xs,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primaryLight,
                            borderRadius: BorderRadius.circular(AppRadius.pill),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.landscape_rounded,
                                size: 12,
                                color: AppColors.primary,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                image.placeCategoryLabel ?? 'Điểm ngắm cảnh',
                                style: AppTypography.badge.copyWith(
                                  color: AppColors.primary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (image.regionLabel != null) ...[
                          const SizedBox(width: 6),
                          Text(
                            '• ${image.regionLabel}',
                            style: AppTypography.caption,
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      image.locationLabel ?? 'Vị trí bức ảnh',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.cardTitle.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on_rounded,
                          size: 15,
                          color: AppColors.primary,
                        ),
                        const SizedBox(width: 2),
                        Expanded(
                          child: Text(
                            image.countryLabel ?? '',
                            style: AppTypography.caption.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.sm,
              vertical: AppSpacing.xs,
            ),
            decoration: BoxDecoration(
              color: AppColors.surfaceSubdued.withValues(alpha: 0.80),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: AppColors.borderBrandSoft),
            ),
            child: Row(
              children: [
                Expanded(
                  child: _Metric(
                    label: 'TỌA ĐỘ GPS',
                    primary: formatPublicImageLat(image.latitude),
                    secondary: formatPublicImageLng(image.longitude),
                  ),
                ),
                Container(width: 1, height: 36, color: AppColors.borderNeutral),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: AppSpacing.xs),
                    child: _Metric(
                      label: 'ĐỘ CAO',
                      primary: altitude == null ? '—' : '${altitude.round()} m',
                      secondary: 'So với mực biển',
                      primaryColor: AppColors.primary,
                      leading: altitude == null
                          ? null
                          : const Icon(
                              Icons.height_rounded,
                              size: 14,
                              color: AppColors.primary,
                            ),
                    ),
                  ),
                ),
                Container(width: 1, height: 36, color: AppColors.borderNeutral),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: AppSpacing.xs),
                    child: _Metric(
                      label: 'THỜI ĐIỂM',
                      primary: _timeOfDayLabel(image),
                      secondary: formatPublicImageDateOnly(image.capturedAt),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: AppPressable(
                  onTap: onOpenGoogleMaps,
                  pressedScale: 0.97,
                  borderRadius: BorderRadius.circular(AppRadius.pill),
                  child: Container(
                    height: 48,
                    decoration: BoxDecoration(
                      color: AppColors.primaryLight,
                      borderRadius: BorderRadius.circular(AppRadius.pill),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.map_rounded,
                          size: 18,
                          color: AppColors.primary,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'Google Maps',
                          style: AppTypography.caption.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.xs + 2),
              Expanded(
                flex: 3,
                child: AppPressable(
                  onTap: onDirections,
                  pressedScale: 0.97,
                  borderRadius: BorderRadius.circular(AppRadius.pill),
                  child: Container(
                    height: 48,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(AppRadius.pill),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withValues(alpha: 0.42),
                          blurRadius: 18,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.near_me_rounded,
                          size: 20,
                          color: AppColors.textInverse,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Chỉ đường đến đây',
                          style: AppTypography.bodyMedium.copyWith(
                            color: AppColors.textInverse,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Icon(
                          Icons.arrow_forward_rounded,
                          size: 18,
                          color: AppColors.textInverse,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

String _timeOfDayLabel(PublicImageItem image) {
  final captured = image.capturedAt;
  if (captured != null) {
    final utc = captured.toUtc();
    final period = utc.hour >= 12 ? 'PM' : 'AM';
    final hour12 = utc.hour % 12 == 0 ? 12 : utc.hour % 12;
    final minute = utc.minute.toString().padLeft(2, '0');
    return '${hour12.toString().padLeft(2, '0')}:$minute $period';
  }
  final clock = formatPublicImageClock(image);
  return clock.isEmpty ? '—' : clock;
}

class _Metric extends StatelessWidget {
  const _Metric({
    required this.label,
    required this.primary,
    required this.secondary,
    this.primaryColor = AppColors.textPrimary,
    this.leading,
  });

  final String label;
  final String primary;
  final String secondary;
  final Color primaryColor;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTypography.badge.copyWith(
            color: AppColors.textTertiary,
            fontSize: 10,
          ),
        ),
        const SizedBox(height: 2),
        Row(
          children: [
            if (leading != null) ...[leading!, const SizedBox(width: 2)],
            Flexible(
              child: Text(
                primary,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.caption.copyWith(
                  color: primaryColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
        Text(
          secondary,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTypography.caption.copyWith(
            color: AppColors.textSecondary,
            fontSize: 11,
            height: 1.1,
          ),
        ),
      ],
    );
  }
}
