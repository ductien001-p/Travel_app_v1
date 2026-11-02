import 'package:flutter_test/flutter_test.dart';
import 'package:travel_frontend_v1/core/maps/google_polyline_decoder.dart';

void main() {
  test('decodes a Google encoded polyline', () {
    final points = GooglePolylineDecoder.decode('_p~iF~ps|U_ulLnnqC_mqNvxq`@');

    expect(points, hasLength(3));
    expect(points[0].latitude, closeTo(38.5, 0.00001));
    expect(points[0].longitude, closeTo(-120.2, 0.00001));
    expect(points[2].latitude, closeTo(43.252, 0.00001));
    expect(points[2].longitude, closeTo(-126.453, 0.00001));
  });

  test('returns an empty list for a malformed polyline', () {
    expect(GooglePolylineDecoder.decode('_'), isEmpty);
  });
}
