import '../datasources/user_memories_datasource.dart';
import '../models/user_memories_models.dart';

class UserMemoriesRepository {
  const UserMemoriesRepository({required UserMemoriesDataSource dataSource})
    : _dataSource = dataSource;

  final UserMemoriesDataSource _dataSource;

  Future<UserMemoriesPage> getMine({
    String? tripId,
    required int year,
    required int month,
    required int utcOffsetMinutes,
    String? cursor,
    int limit = 20,
    String? q,
  }) {
    return _dataSource.getMine(
      tripId: tripId,
      year: year,
      month: month,
      utcOffsetMinutes: utcOffsetMinutes,
      cursor: cursor,
      limit: limit,
      q: q,
    );
  }

  Future<UserMemoryLike> like(String memoryId) => _dataSource.like(memoryId);

  Future<UserMemoryLike> unlike(String memoryId) =>
      _dataSource.unlike(memoryId);
}
