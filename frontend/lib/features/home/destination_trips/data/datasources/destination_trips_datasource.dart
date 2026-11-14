import '../models/destination_trips_models.dart';

class DestinationTripsQuery {
  const DestinationTripsQuery({
    required this.cityName,
    this.catalogId,
    this.category = 'all',
    this.search,
    this.seed,
    this.timezoneOffsetMinutes,
    this.placesLimit = 3,
  });

  final String cityName;
  final String? catalogId;
  final String category;
  final String? search;
  final String? seed;
  final int? timezoneOffsetMinutes;
  final int placesLimit;
}

abstract class DestinationTripsDataSource {
  Future<DestinationTripsPage> load(DestinationTripsQuery query);
}
