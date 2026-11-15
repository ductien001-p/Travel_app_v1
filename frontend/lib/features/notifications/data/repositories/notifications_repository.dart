import '../datasources/notifications_datasource.dart';
import '../models/notification_models.dart';

class NotificationsRepository {
  const NotificationsRepository({required NotificationsDataSource dataSource})
    : _dataSource = dataSource;

  final NotificationsDataSource _dataSource;

  Future<NotificationPage> list({String? cursor, int limit = 30}) =>
      _dataSource.list(cursor: cursor, limit: limit);

  Future<AppNotification> markRead(String id) => _dataSource.markRead(id);

  Future<int> markAllRead() => _dataSource.markAllRead();
}
