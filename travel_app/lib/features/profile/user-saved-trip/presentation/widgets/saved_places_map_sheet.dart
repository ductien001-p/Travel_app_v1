import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';

import '../../application/saved_places_view.dart';

class SavedPlacesMapSheet extends StatefulWidget {
  const SavedPlacesMapSheet({super.key, required this.pins});

  final List<SavedPlacePin> pins;

  @override
  State<SavedPlacesMapSheet> createState() => _SavedPlacesMapSheetState();
}

class _SavedPlacesMapSheetState extends State<SavedPlacesMapSheet> {
  GoogleMapController? _controller;

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pins = widget.pins;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Bản đồ địa điểm đã lưu', style: AppTypography.sectionTitle),
        const SizedBox(height: AppSpacing.sm),
        ClipRRect(
          borderRadius: BorderRadius.circular(AppRadius.card),
          child: SizedBox(
            height: 360,
            child: pins.isEmpty
                ? const ColoredBox(
                    color: AppColors.surfaceSubdued,
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.all(AppSpacing.md),
                        child: Text(
                          'Không có tọa độ để hiện trên bản đồ.',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  )
                : GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: LatLng(pins.first.latitude, pins.first.longitude),
                      zoom: pins.length == 1 ? 14 : 6,
                    ),
                    onMapCreated: (controller) {
                      _controller = controller;
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        if (mounted) _fit(controller);
                      });
                    },
                    markers: {
                      for (final pin in pins)
                        Marker(
                          markerId: MarkerId(pin.placeId),
                          position: LatLng(pin.latitude, pin.longitude),
                          infoWindow: InfoWindow(title: pin.name),
                        ),
                    },
                    mapToolbarEnabled: false,
                    myLocationButtonEnabled: false,
                    zoomControlsEnabled: false,
                    compassEnabled: false,
                  ),
          ),
        ),
      ],
    );
  }

  void _fit(GoogleMapController controller) {
    final pins = widget.pins;
    if (pins.isEmpty) return;
    final first = pins.first;
    if (pins.length == 1) {
      controller.moveCamera(
        CameraUpdate.newLatLngZoom(LatLng(first.latitude, first.longitude), 14),
      );
      return;
    }
    var minLat = first.latitude;
    var maxLat = first.latitude;
    var minLng = first.longitude;
    var maxLng = first.longitude;
    for (final pin in pins.skip(1)) {
      minLat = math.min(minLat, pin.latitude);
      maxLat = math.max(maxLat, pin.latitude);
      minLng = math.min(minLng, pin.longitude);
      maxLng = math.max(maxLng, pin.longitude);
    }
    if (minLat == maxLat && minLng == maxLng) {
      controller.moveCamera(
        CameraUpdate.newLatLngZoom(LatLng(minLat, minLng), 14),
      );
      return;
    }
    controller.moveCamera(
      CameraUpdate.newLatLngBounds(
        LatLngBounds(
          southwest: LatLng(minLat, minLng),
          northeast: LatLng(maxLat, maxLng),
        ),
        48,
      ),
    );
  }
}
