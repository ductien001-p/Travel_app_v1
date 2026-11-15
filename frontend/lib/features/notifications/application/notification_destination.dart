enum NotificationOpenTarget { tripDetail, joinRequests, none }

class NotificationDestination {
  const NotificationDestination(this.target, this.tripId);

  final NotificationOpenTarget target;
  final String? tripId;
}

NotificationDestination notificationDestination({
  required String type,
  String? tripId,
}) {
  if (tripId == null || tripId.isEmpty) {
    return const NotificationDestination(NotificationOpenTarget.none, null);
  }
  if (type == 'TRIP_JOIN_REQUEST') {
    return NotificationDestination(NotificationOpenTarget.joinRequests, tripId);
  }
  return NotificationDestination(NotificationOpenTarget.tripDetail, tripId);
}
