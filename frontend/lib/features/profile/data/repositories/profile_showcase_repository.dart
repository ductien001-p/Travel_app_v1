import '../datasources/profile_showcase_datasource.dart';
import '../models/profile_showcase_models.dart';

class ProfileShowcaseRepository {
  const ProfileShowcaseRepository({
    required ProfileShowcaseDataSource dataSource,
  }) : _dataSource = dataSource;

  final ProfileShowcaseDataSource _dataSource;

  Future<ProfileShowcase> getProfileShowcase() =>
      _dataSource.getProfileShowcase();
}
