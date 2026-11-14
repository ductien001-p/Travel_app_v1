import '../datasources/destination_trips_datasource.dart';
import '../models/destination_trips_models.dart';

class DestinationTripsRepository {
  const DestinationTripsRepository({
    required DestinationTripsDataSource dataSource,
  }) : _dataSource = dataSource;

  final DestinationTripsDataSource _dataSource;

  Future<DestinationTripsPage> load(DestinationTripsQuery query) {
    return _dataSource.load(query);
  }
}
