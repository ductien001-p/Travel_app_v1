import '../datasources/chats_hub_datasource.dart';
import '../models/chats_hub_models.dart';

class ChatsHubRepository {
  const ChatsHubRepository({required ChatsHubDataSource dataSource})
    : _dataSource = dataSource;

  final ChatsHubDataSource _dataSource;

  Future<ChatsHub> getHub() => _dataSource.getHub();
}
