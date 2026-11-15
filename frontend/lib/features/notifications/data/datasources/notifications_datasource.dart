import 'package:travel_frontend_v1/core/networks/api_client.dart';

import '../models/notification_models.dart';

abstract class NotificationsDataSource {
  Future<NotificationPage> list({String? cursor, int limit = 30});

  Future<AppNotification> markRead(String id);

  Future<int> markAllRead();
}

class NotificationsRemoteDataSource implements NotificationsDataSource {
  const NotificationsRemoteDataSource({required ApiClient apiClient})
    : _apiClient = apiClient;

  final ApiClient _apiClient;

  @override
  Future<NotificationPage> list({String? cursor, int limit = 30}) async {
    final response = await _apiClient.get<Map<String, dynamic>>(
      '/notifications',
      queryParameters: {
        'limit': limit,
        if (cursor != null && cursor.isNotEmpty) 'cursor': cursor,
      },
    );
    final raw = response['data'];
    final items = <AppNotification>[
      if (raw is List)
        for (final item in raw)
          if (item is Map)
            AppNotification.fromJson(Map<String, dynamic>.from(item)),
    ];
    final meta = response['meta'];
    final metaMap = meta is Map ? Map<String, dynamic>.from(meta) : const {};
    final unread = metaMap['unreadCount'];
    return NotificationPage(
      items: items,
      nextCursor: metaMap['nextCursor'] as String?,
      hasMore: metaMap['hasMore'] == true,
      unreadCount: unread is num ? unread.toInt() : 0,
    );
  }

  @override
  Future<AppNotification> markRead(String id) async {
    final response = await _apiClient.post<Map<String, dynamic>>(
      '/notifications/${Uri.encodeComponent(id)}/read',
    );
    final data = response['data'];
    if (data is! Map) {
      throw const FormatException('Notification read response is invalid.');
    }
    return AppNotification.fromJson(Map<String, dynamic>.from(data));
  }

  @override
  Future<int> markAllRead() async {
    final response = await _apiClient.post<Map<String, dynamic>>(
      '/notifications/read-all',
    );
    final data = response['data'];
    if (data is Map && data['updated'] is num) {
      return (data['updated'] as num).toInt();
    }
    return 0;
  }
}
