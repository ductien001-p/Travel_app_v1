import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';

import '../../../application/trip_itinerary_map.dart';
import 'trip_itinerary_map_markers.dart';

/// Google map of one day: numbered stops and the route between them.
///
/// Estimated legs (no road data) are drawn dashed.
class TripItineraryRouteMap extends StatefulWidget {
  const TripItineraryRouteMap({
    super.key,
    required this.data,
    required this.focusedActivityId,
    required this.onStopTap,
    this.bottomPadding = 0,
  });

  final TripItineraryMapData data;
  final String? focusedActivityId;
  final ValueChanged<String> onStopTap;

  /// Space covered by overlays, kept clear when fitting the camera.
  final double bottomPadding;

  @override
  State<TripItineraryRouteMap> createState() => _TripItineraryRouteMapState();
}

class _TripItineraryRouteMapState extends State<TripItineraryRouteMap> {
  static const _fitPadding = 56.0;
  static const _focusZoom = 15.0;

  GoogleMapController? _controller;
  Map<String, BitmapDescriptor> _icons = const {};

  @override
  void initState() {
    super.initState();
    _loadIcons();
  }

  @override
  void didUpdateWidget(covariant TripItineraryRouteMap oldWidget) {
    super.didUpdateWidget(oldWidget);
    final stopsChanged = !_sameStops(oldWidget.data, widget.data);
    if (stopsChanged ||
        oldWidget.focusedActivityId != widget.focusedActivityId) {
      _loadIcons();
    }
    if (stopsChanged) {
      _fitAll();
    } else if (oldWidget.focusedActivityId != widget.focusedActivityId) {
      _focus(widget.focusedActivityId);
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _loadIcons() async {
    final icons = <String, BitmapDescriptor>{};
    for (final stop in widget.data.stops) {
      icons[stop.item.id] = await buildItineraryStopMarker(
        stop.number,
        status: stop.item.status,
        focused: stop.item.id == widget.focusedActivityId,
      );
    }
    if (mounted) setState(() => _icons = icons);
  }

  @override
  Widget build(BuildContext context) {
    final stops = widget.data.stops;
    if (stops.isEmpty) {
      return ColoredBox(
        color: AppColors.surfaceSubdued,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.xl),
            child: Text(
              'Các hoạt động của ngày này chưa có vị trí trên bản đồ.',
              textAlign: TextAlign.center,
              style: AppTypography.body,
            ),
          ),
        ),
      );
    }
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: stops.first.position,
        zoom: 13,
      ),
      padding: EdgeInsets.only(bottom: widget.bottomPadding),
      onMapCreated: (controller) {
        _controller = controller;
        _fitAll();
      },
      markers: {
        for (final stop in stops)
          Marker(
            markerId: MarkerId(stop.item.id),
            position: stop.position,
            icon: _icons[stop.item.id] ?? BitmapDescriptor.defaultMarker,
            infoWindow: InfoWindow(
              title: '${stop.number}. ${stop.item.activity.title}',
            ),
            zIndexInt: stop.item.id == widget.focusedActivityId ? 2 : 1,
            onTap: () => widget.onStopTap(stop.item.id),
          ),
      },
      polylines: {
        for (final (index, leg) in widget.data.legs.indexed)
          Polyline(
            polylineId: PolylineId('leg-$index'),
            points: leg.points,
            color: leg.isEstimate ? AppColors.textTertiary : AppColors.primary,
            width: leg.isEstimate ? 4 : 6,
            patterns: leg.isEstimate
                ? [PatternItem.dash(18), PatternItem.gap(12)]
                : const [],
            startCap: Cap.roundCap,
            endCap: Cap.roundCap,
            jointType: JointType.round,
          ),
      },
      mapToolbarEnabled: false,
      myLocationButtonEnabled: false,
      zoomControlsEnabled: false,
      compassEnabled: false,
    );
  }

  Future<void> _fitAll() async {
    final controller = _controller;
    final points = [
      for (final stop in widget.data.stops) stop.position,
      for (final leg in widget.data.legs) ...leg.points,
    ];
    if (controller == null || points.isEmpty) return;
    // The platform view needs a frame with its final size before fitting.
    await Future<void>.delayed(const Duration(milliseconds: 120));
    if (!mounted) return;
    await controller.animateCamera(
      points.length == 1
          ? CameraUpdate.newLatLngZoom(points.single, _focusZoom)
          : CameraUpdate.newLatLngBounds(_bounds(points), _fitPadding),
    );
  }

  Future<void> _focus(String? activityId) async {
    final controller = _controller;
    if (controller == null || activityId == null) return;
    for (final stop in widget.data.stops) {
      if (stop.item.id != activityId) continue;
      await controller.animateCamera(
        CameraUpdate.newLatLngZoom(stop.position, _focusZoom),
      );
      return;
    }
  }

  static bool _sameStops(TripItineraryMapData a, TripItineraryMapData b) {
    if (a.stops.length != b.stops.length || a.legs.length != b.legs.length) {
      return false;
    }
    for (var i = 0; i < a.stops.length; i++) {
      if (a.stops[i].item.id != b.stops[i].item.id ||
          a.stops[i].item.status != b.stops[i].item.status) {
        return false;
      }
    }
    for (var i = 0; i < a.legs.length; i++) {
      if (a.legs[i].isEstimate != b.legs[i].isEstimate) return false;
    }
    return true;
  }
}

LatLngBounds _bounds(List<LatLng> points) {
  var minLat = points.first.latitude;
  var maxLat = minLat;
  var minLng = points.first.longitude;
  var maxLng = minLng;
  for (final point in points.skip(1)) {
    if (point.latitude < minLat) minLat = point.latitude;
    if (point.latitude > maxLat) maxLat = point.latitude;
    if (point.longitude < minLng) minLng = point.longitude;
    if (point.longitude > maxLng) maxLng = point.longitude;
  }
  const minSpan = 0.005;
  if (maxLat - minLat < minSpan) {
    minLat -= minSpan;
    maxLat += minSpan;
  }
  if (maxLng - minLng < minSpan) {
    minLng -= minSpan;
    maxLng += minSpan;
  }
  return LatLngBounds(
    southwest: LatLng(minLat, minLng),
    northeast: LatLng(maxLat, maxLng),
  );
}
