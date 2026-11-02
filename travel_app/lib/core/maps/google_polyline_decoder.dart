import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract final class GooglePolylineDecoder {
  static List<LatLng> decode(String encoded) {
    if (encoded.isEmpty) return const [];

    final points = <LatLng>[];
    var index = 0;
    var latitude = 0;
    var longitude = 0;

    try {
      while (index < encoded.length) {
        final latitudeDelta = _decodeValue(encoded, index);
        index = latitudeDelta.nextIndex;
        final longitudeDelta = _decodeValue(encoded, index);
        index = longitudeDelta.nextIndex;

        latitude += latitudeDelta.value;
        longitude += longitudeDelta.value;
        points.add(LatLng(latitude / 1e5, longitude / 1e5));
      }
    } on FormatException {
      return const [];
    }

    return List.unmodifiable(points);
  }

  static ({int value, int nextIndex}) _decodeValue(
    String encoded,
    int startIndex,
  ) {
    var index = startIndex;
    var result = 0;
    var shift = 0;

    while (true) {
      if (index >= encoded.length || shift > 30) {
        throw const FormatException('Invalid encoded Google polyline.');
      }
      final value = encoded.codeUnitAt(index++) - 63;
      if (value < 0 || value > 63) {
        throw const FormatException('Invalid encoded Google polyline.');
      }
      result |= (value & 0x1f) << shift;
      shift += 5;
      if (value < 0x20) break;
    }

    final decoded = (result & 1) == 1 ? ~(result >> 1) : result >> 1;
    return (value: decoded, nextIndex: index);
  }
}
