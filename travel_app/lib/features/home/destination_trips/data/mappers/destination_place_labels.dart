import 'package:travel_frontend_v1/features/trips/data/models/trip_creation_models.dart';

import '../models/destination_trips_models.dart';

const Map<String, String> _placeCategoryLabels = {
  'FOOD': 'Ẩm thực',
  'CAFE': 'Cafe',
  'HOTEL': 'Khách sạn',
  'RESORT': 'Resort',
  'HOSTEL': 'Hostel',
  'HOMESTAY': 'Homestay',
  'VILLA': 'Villa',
  'MOUNTAIN': 'Núi',
  'BEACH': 'Biển',
  'CAVE': 'Hang',
  'WATERFALL': 'Thác',
  'LAKE': 'Hồ',
  'CAMPING': 'Cắm trại',
  'MUSEUM': 'Bảo tàng',
  'TEMPLES': 'Đền',
  'CHURCH': 'Nhà thờ',
  'HISTORICAL_SITE': 'Di sản',
  'MONUMENT': 'Tượng đài',
  'PALACE': 'Cung điện',
  'CASTLE': 'Lâu đài',
  'OLD_TOWN': 'Phố cổ',
  'ZOO': 'Thảo cầm viên',
  'WATER_PARK': 'Công viên nước',
  'PARK': 'Công viên',
  'CINEMA': 'Rạp',
  'THEATER': 'Nhà hát',
  'NIGHT_MARKET': 'Chợ đêm',
  'SHOPPING_MALL': 'Trung tâm thương mại',
  'MARKET': 'Chợ',
  'ZIPLINE': 'Zipline',
  'WALKING_STREET': 'Phố đi bộ',
};

String placeCategoryLabel(String category) =>
    _placeCategoryLabels[category] ?? category;

String spotNote(PlanningPlace place) {
  if (place.distanceKm > 0) {
    final km = place.distanceKm >= 10
        ? place.distanceKm.toStringAsFixed(0)
        : place.distanceKm.toStringAsFixed(1);
    return 'Cách trung tâm ${km}km';
  }
  final description = place.description?.trim();
  if (description != null && description.isNotEmpty) return description;
  return place.address;
}

DestinationSpot spotFromPlace(PlanningPlace place) => DestinationSpot(
  id: place.id,
  name: place.name,
  imageUrl: place.thumbnailUrl ?? '',
  rating: place.averageRating,
  categoryLabel: placeCategoryLabel(place.category),
  note: spotNote(place),
);
