import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';

import '../../../application/trip_itinerary_view.dart';

/// Circle marker with the stop's visiting order, coloured by its status.
Future<BitmapDescriptor> buildItineraryStopMarker(
  int number, {
  required TripItineraryActivityStatus status,
  required bool focused,
}) async {
  const size = 96.0;
  const center = Offset(size / 2, size / 2);
  final radius = focused ? 42.0 : 34.0;
  final fillColor = switch (status) {
    TripItineraryActivityStatus.checkedIn => AppColors.success,
    TripItineraryActivityStatus.next => AppColors.primary,
    TripItineraryActivityStatus.upcoming => AppColors.textTertiary,
  };

  final label = _label(number, size);
  final recorder = ui.PictureRecorder();
  Canvas(recorder)
    ..drawCircle(center, radius, Paint()..color = fillColor)
    ..drawCircle(
      center,
      radius,
      Paint()
        ..color = AppColors.surface
        ..style = PaintingStyle.stroke
        ..strokeWidth = focused ? 8 : 5,
    )
    ..drawParagraph(label, Offset(0, (size - label.height) / 2));

  final image = await recorder.endRecording().toImage(
    size.toInt(),
    size.toInt(),
  );
  final data = await image.toByteData(format: ui.ImageByteFormat.png);
  final bytes = data?.buffer.asUint8List() ?? Uint8List(0);
  return BitmapDescriptor.bytes(bytes, width: 44, height: 44);
}

ui.Paragraph _label(int number, double width) {
  final builder =
      ui.ParagraphBuilder(
          ui.ParagraphStyle(textAlign: TextAlign.center, fontSize: 36),
        )
        ..pushStyle(
          ui.TextStyle(color: AppColors.surface, fontWeight: FontWeight.w700),
        )
        ..addText('$number');
  return builder.build()..layout(ui.ParagraphConstraints(width: width));
}
