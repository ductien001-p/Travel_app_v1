import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/maps/google_polyline_decoder.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widget/app_button.dart';
import '../../../../core/widget/app_card.dart';
import '../../application/trip_creation_support_controller.dart';

class DestinationMapStop {
  const DestinationMapStop({
    required this.id,
    required this.name,
    required this.country,
    required this.latitude,
    required this.longitude,
  });

  final String id;
  final String name;
  final String country;
  final double latitude;
  final double longitude;

  LatLng get position => LatLng(latitude, longitude);
}

class DestinationMapOverview extends ConsumerStatefulWidget {
  const DestinationMapOverview({
    super.key,
    required this.stops,
    this.currentLocation,
    this.highlightedIndex,
    this.onStopTap,
    this.showSummary = true,
  });

  final List<DestinationMapStop> stops;
  final LatLng? currentLocation;
  final int? highlightedIndex;
  final ValueChanged<int>? onStopTap;
  final bool showSummary;

  @override
  ConsumerState<DestinationMapOverview> createState() =>
      _DestinationMapOverviewState();
}

class _DestinationMapOverviewState
    extends ConsumerState<DestinationMapOverview> {
  GoogleMapController? _controller;
  Map<int, BitmapDescriptor> _numberedIcons = const {};
  bool _showRoute = false;

  bool get _supportsGoogleMaps =>
      defaultTargetPlatform == TargetPlatform.android ||
      defaultTargetPlatform == TargetPlatform.iOS;

  @override
  void initState() {
    super.initState();
    _loadMarkerIcons();
  }

  @override
  void didUpdateWidget(covariant DestinationMapOverview oldWidget) {
    super.didUpdateWidget(oldWidget);
    final stopsChanged = !listEquals(
      oldWidget.stops.map((stop) => stop.id).toList(),
      widget.stops.map((stop) => stop.id).toList(),
    );
    if (stopsChanged || oldWidget.highlightedIndex != widget.highlightedIndex) {
      if (stopsChanged) _showRoute = false;
      _loadMarkerIcons();
      WidgetsBinding.instance.addPostFrameCallback((_) => _fitMap());
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _loadMarkerIcons() async {
    final icons = <int, BitmapDescriptor>{};
    for (var index = 0; index < widget.stops.length; index++) {
      icons[index] = await _numberedMarker(
        index + 1,
        highlighted: widget.highlightedIndex == index,
      );
    }
    if (mounted) setState(() => _numberedIcons = icons);
  }

  @override
  Widget build(BuildContext context) {
    final routeValues = <AsyncValue<dynamic>>[];
    if (_showRoute) {
      for (var index = 0; index < widget.stops.length - 1; index++) {
        final origin = widget.stops[index];
        final destination = widget.stops[index + 1];
        routeValues.add(
          ref.watch(
            routePreviewProvider((
              originLat: origin.latitude,
              originLng: origin.longitude,
              destinationLat: destination.latitude,
              destinationLng: destination.longitude,
            )),
          ),
        );
      }
    }

    final polylines = <Polyline>{};
    for (var index = 0; index < routeValues.length; index++) {
      final value = routeValues[index].value;
      if (value == null || value.polyline == null) continue;
      final points = GooglePolylineDecoder.decode(value.polyline!);
      if (points.isEmpty) continue;
      polylines.add(
        Polyline(
          polylineId: PolylineId('route-$index'),
          points: points,
          color: AppColors.primaryActive,
          width: 6,
          startCap: Cap.roundCap,
          endCap: Cap.roundCap,
          jointType: JointType.round,
        ),
      );
    }
    final routeLoading = routeValues.any((value) => value.isLoading);
    final routeFailed = routeValues.any((value) => value.hasError);

    return AppCard(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (!_supportsGoogleMaps)
            const SizedBox(
              height: 220,
              child: Center(
                child: Text('Google Maps chưa hỗ trợ nền tảng này.'),
              ),
            )
          else
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(AppRadius.cardLarge),
              ),
              child: SizedBox(
                height: 260,
                child: _allPoints.isEmpty
                    ? const ColoredBox(
                        color: AppColors.surfaceSubdued,
                        child: Center(
                          child: Text('Thêm điểm đến để xem trên bản đồ.'),
                        ),
                      )
                    : GoogleMap(
                        initialCameraPosition: CameraPosition(
                          target: _center(_allPoints),
                          zoom: _allPoints.length == 1 ? 9 : 6,
                        ),
                        onMapCreated: (controller) {
                          _controller = controller;
                          _fitMap();
                        },
                        markers: _markers,
                        polylines: polylines,
                        mapToolbarEnabled: false,
                        myLocationButtonEnabled: false,
                        zoomControlsEnabled: false,
                        compassEnabled: false,
                      ),
              ),
            ),
          if (widget.showSummary)
            Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    '${widget.stops.length} điểm đến',
                    style: AppTypography.cardTitle,
                  ),
                  if (widget.stops.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      widget.stops.map((stop) => stop.name).join(' → '),
                      style: AppTypography.body.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                  if (widget.stops.length >= 2) ...[
                    const SizedBox(height: AppSpacing.md),
                    AppButton(
                      label: _showRoute ? 'Ẩn tuyến đường' : 'Xem tuyến đường',
                      leadingIcon: _showRoute
                          ? Icons.layers_clear_outlined
                          : Icons.alt_route_rounded,
                      variant: AppButtonVariant.secondary,
                      isLoading: routeLoading,
                      onPressed: routeLoading
                          ? null
                          : () => setState(() => _showRoute = !_showRoute),
                    ),
                    if (routeFailed) ...[
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        'Chưa thể tải đầy đủ tuyến đường. Các điểm đến vẫn được giữ trên bản đồ.',
                        style: AppTypography.caption.copyWith(
                          color: AppColors.danger,
                        ),
                      ),
                    ],
                  ],
                ],
              ),
            ),
        ],
      ),
    );
  }

  List<LatLng> get _allPoints => [
    ...widget.stops.map((stop) => stop.position),
    if (widget.currentLocation != null) widget.currentLocation!,
  ];

  Set<Marker> get _markers => {
    for (var index = 0; index < widget.stops.length; index++)
      Marker(
        markerId: MarkerId('destination-${widget.stops[index].id}'),
        position: widget.stops[index].position,
        icon:
            _numberedIcons[index] ??
            BitmapDescriptor.defaultMarkerWithHue(
              widget.highlightedIndex == index
                  ? BitmapDescriptor.hueOrange
                  : BitmapDescriptor.hueAzure,
            ),
        infoWindow: InfoWindow(
          title: '${index + 1}. ${widget.stops[index].name}',
          snippet: widget.stops[index].country,
        ),
        onTap: () => widget.onStopTap?.call(index),
        zIndexInt: widget.highlightedIndex == index ? 2 : 1,
      ),
    if (widget.currentLocation != null)
      Marker(
        markerId: const MarkerId('current-location'),
        position: widget.currentLocation!,
        infoWindow: const InfoWindow(title: 'Bạn đang ở đây'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        zIndexInt: 0,
      ),
  };

  Future<void> _fitMap() async {
    final controller = _controller;
    if (controller == null || _allPoints.isEmpty) return;
    await Future<void>.delayed(const Duration(milliseconds: 120));
    if (!mounted) return;
    if (_allPoints.length == 1) {
      await controller.animateCamera(
        CameraUpdate.newLatLngZoom(_allPoints[0], 9),
      );
      return;
    }
    await controller.animateCamera(
      CameraUpdate.newLatLngBounds(_bounds(_allPoints), 48),
    );
  }
}

Future<BitmapDescriptor> _numberedMarker(
  int number, {
  required bool highlighted,
}) async {
  const size = 96.0;
  final recorder = ui.PictureRecorder();
  final canvas = Canvas(recorder);
  final center = const Offset(size / 2, size / 2);
  final fill = Paint()
    ..color = highlighted ? AppColors.warning : AppColors.primary;
  final border = Paint()
    ..color = Colors.white
    ..style = PaintingStyle.stroke
    ..strokeWidth = highlighted ? 8 : 5;
  canvas.drawCircle(center, highlighted ? 40 : 34, fill);
  canvas.drawCircle(center, highlighted ? 40 : 34, border);

  final paragraph =
      (ui.ParagraphBuilder(
          ui.ParagraphStyle(textAlign: TextAlign.center, fontSize: 36),
        )..pushStyle(
          ui.TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
        ))
        ..addText('$number');
  final built = paragraph.build()
    ..layout(const ui.ParagraphConstraints(width: size));
  canvas.drawParagraph(built, Offset(0, (size - built.height) / 2));

  final image = await recorder.endRecording().toImage(
    size.toInt(),
    size.toInt(),
  );
  final data = await image.toByteData(format: ui.ImageByteFormat.png);
  final bytes = data?.buffer.asUint8List() ?? Uint8List(0);
  return BitmapDescriptor.bytes(bytes, width: 48, height: 48);
}

LatLng _center(List<LatLng> points) {
  if (points.isEmpty) return const LatLng(16.0, 106.0);
  final bounds = _bounds(points);
  return LatLng(
    (bounds.northeast.latitude + bounds.southwest.latitude) / 2,
    (bounds.northeast.longitude + bounds.southwest.longitude) / 2,
  );
}

LatLngBounds _bounds(List<LatLng> points) {
  var minLat = points.first.latitude;
  var maxLat = points.first.latitude;
  var minLng = points.first.longitude;
  var maxLng = points.first.longitude;
  for (final point in points.skip(1)) {
    minLat = point.latitude < minLat ? point.latitude : minLat;
    maxLat = point.latitude > maxLat ? point.latitude : maxLat;
    minLng = point.longitude < minLng ? point.longitude : minLng;
    maxLng = point.longitude > maxLng ? point.longitude : maxLng;
  }
  if (minLat == maxLat) {
    minLat -= 0.01;
    maxLat += 0.01;
  }
  if (minLng == maxLng) {
    minLng -= 0.01;
    maxLng += 0.01;
  }
  return LatLngBounds(
    southwest: LatLng(minLat, minLng),
    northeast: LatLng(maxLat, maxLng),
  );
}
