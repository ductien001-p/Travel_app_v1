import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:travel_frontend_v1/features/profile/user-saved-trip/data/datamock/saved_places_datamock.dart';
import 'package:travel_frontend_v1/features/profile/user-saved-trip/data/models/saved_places_models.dart';

void main() {
  test('parses the saved places page and count contract', () {
    final page = SavedPlacesPage.fromJson(
      jsonDecode(jsonEncode(savedPlacesDatamock['savedPlacesPage']))
          as Map<String, dynamic>,
    );
    final count = SavedPlacesCountEnvelope.fromJson(
      jsonDecode(jsonEncode(savedPlacesDatamock['savedPlacesCount']))
          as Map<String, dynamic>,
    );

    expect(page.items, hasLength(2));
    expect(page.items.first.place.name, 'Phố Cổ Hội An');
    expect(page.items.first.place.category, 'OLD_TOWN');
    expect(page.items.first.place.averageRating, 4.9);
    expect(page.items.last.place.averageRating, 5);
    expect(page.meta.hasNextPage, isFalse);
    expect(page.meta.total, 2);
    expect(count.data.count, 2);
  });
}
