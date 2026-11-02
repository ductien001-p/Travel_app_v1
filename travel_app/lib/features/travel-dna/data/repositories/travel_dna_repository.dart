import '../datasources/travel_dna_remote_datasource.dart';
import '../models/travel_dna_models.dart';

class TravelDnaRepository {
  const TravelDnaRepository({required TravelDnaRemoteDataSource dataSource})
    : _dataSource = dataSource;

  final TravelDnaRemoteDataSource _dataSource;

  Future<TravelDnaRadar> loadRadar() => _dataSource.getRadar();
}
