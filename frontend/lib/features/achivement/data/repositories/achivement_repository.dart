import '../datasources/achivement_datasource.dart';
import '../models/achivement_models.dart';

class AchivementRepository {
  const AchivementRepository({required AchivementDataSource dataSource})
    : _dataSource = dataSource;

  final AchivementDataSource _dataSource;

  Future<TripMissionsPage> getTripMissions(String tripId) =>
      _dataSource.getTripMissions(tripId);

  Future<AchivementProgressPage> getProgress({String period = 'ALL_TIME'}) =>
      _dataSource.getProgress(period: period);

  Future<AchivementCompletionResult> claimCompletion(
    String tripId, {
    String? tripName,
  }) => _dataSource.claimCompletion(tripId, tripName: tripName);
}
