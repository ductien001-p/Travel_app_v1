class AppNotification {
  const AppNotification({
    required this.id,
    required this.type,
    required this.title,
    required this.message,
    required this.isRead,
    required this.createdAt,
    this.tripId,
    this.actorId,
  });

  final String id;
  final String type;
  final String title;
  final String message;
  final bool isRead;
  final DateTime createdAt;
  final String? tripId;
  final String? actorId;

  AppNotification copyWith({bool? isRead}) {
    return AppNotification(
      id: id,
      type: type,
      title: title,
      message: message,
      isRead: isRead ?? this.isRead,
      createdAt: createdAt,
      tripId: tripId,
      actorId: actorId,
    );
  }

  factory AppNotification.fromJson(Map<String, dynamic> json) {
    final created = json['createdAt'];
    return AppNotification(
      id: json['id'] as String,
      type: json['type'] as String? ?? '',
      title: json['title'] as String? ?? '',
      message: json['message'] as String? ?? '',
      isRead: json['isRead'] == true,
      createdAt: created is String
          ? DateTime.tryParse(created)?.toLocal() ?? DateTime.now()
          : DateTime.now(),
      tripId: json['tripId'] as String?,
      actorId: json['actorId'] as String?,
    );
  }
}

class NotificationPage {
  const NotificationPage({
    required this.items,
    required this.unreadCount,
    this.nextCursor,
    this.hasMore = false,
  });

  final List<AppNotification> items;
  final String? nextCursor;
  final bool hasMore;
  final int unreadCount;

  NotificationPage copyWith({
    List<AppNotification>? items,
    String? nextCursor,
    bool? hasMore,
    int? unreadCount,
  }) {
    return NotificationPage(
      items: items ?? this.items,
      nextCursor: nextCursor ?? this.nextCursor,
      hasMore: hasMore ?? this.hasMore,
      unreadCount: unreadCount ?? this.unreadCount,
    );
  }
}
