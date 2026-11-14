import '../data/models/public_image_models.dart';

String _twoDigits(int value) => value.toString().padLeft(2, '0');

String formatPublicImageCounter(int index, int total) => '${index + 1}/$total';

/// `20/07/2025 • 05:45 AM` from wall-clock fields (Stitch).
String formatPublicImageDateTime(DateTime? value) {
  if (value == null) return '';
  final utc = value.toUtc();
  final hour24 = utc.hour;
  final period = hour24 >= 12 ? 'PM' : 'AM';
  final hour12 = hour24 % 12 == 0 ? 12 : hour24 % 12;
  return '${_twoDigits(utc.day)}/${_twoDigits(utc.month)}/${utc.year} • '
      '${_twoDigits(hour12)}:${_twoDigits(utc.minute)} $period';
}

String formatPublicImageClock(PublicImageItem image) {
  final label = image.clockLabel?.trim();
  if (label != null && label.isNotEmpty) return label;
  final captured = image.capturedAt;
  if (captured == null) return '';
  final utc = captured.toUtc();
  return '${_twoDigits(utc.hour)}:${_twoDigits(utc.minute)}';
}

String formatPublicImageDateOnly(DateTime? value) {
  if (value == null) return '—';
  final utc = value.toUtc();
  return '${_twoDigits(utc.day)}/${_twoDigits(utc.month)}/${utc.year}';
}

String formatPublicImageCoordinates({
  required double? latitude,
  required double? longitude,
}) {
  if (latitude == null || longitude == null) return '';
  return '${formatPublicImageLat(latitude)}, ${formatPublicImageLng(longitude)}';
}

String formatPublicImageLat(double? latitude) {
  if (latitude == null) return '—';
  final hemisphere = latitude >= 0 ? 'N' : 'S';
  return '${latitude.abs().toStringAsFixed(4)}° $hemisphere';
}

String formatPublicImageLng(double? longitude) {
  if (longitude == null) return '—';
  final hemisphere = longitude >= 0 ? 'E' : 'W';
  return '${longitude.abs().toStringAsFixed(4)}° $hemisphere';
}

String googleMapsSearchUrl({
  required double latitude,
  required double longitude,
  String? label,
}) {
  final query = (label == null || label.isEmpty)
      ? '$latitude,$longitude'
      : Uri.encodeComponent('$label@$latitude,$longitude');
  return 'https://www.google.com/maps/search/?api=1&query=$query';
}

String googleMapsDirectionsUrl({
  required double latitude,
  required double longitude,
}) {
  return 'https://www.google.com/maps/dir/?api=1&destination=$latitude,$longitude';
}
