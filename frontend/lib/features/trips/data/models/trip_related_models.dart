import 'trip.dart';
import 'trip_enums.dart';

class TripInvitation {
  const TripInvitation({
    required this.id,
    required this.tripId,
    required this.inviterId,
    required this.inviteeId,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.inviter,
    this.trip,
  });
  final String id;
  final String tripId;
  final String inviterId;
  final String inviteeId;
  final TripInvitationStatus status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final TripOwner? inviter;
  final TripInvitationSummary? trip;

  factory TripInvitation.fromJson(Map<String, dynamic> json) => TripInvitation(
    id: json['id'] as String,
    tripId: json['tripId'] as String,
    inviterId: json['inviterId'] as String,
    inviteeId: json['inviteeId'] as String,
    status: parseTripEnum(json['status'] as String, const {
      'PENDING': TripInvitationStatus.pending,
      'ACCEPTED': TripInvitationStatus.accepted,
      'REJECTED': TripInvitationStatus.rejected,
    }, 'invitation status'),
    createdAt: DateTime.parse(json['createdAt'] as String),
    updatedAt: DateTime.parse(json['updatedAt'] as String),
    inviter: json['inviter'] is Map
        ? TripOwner.fromJson(Map<String, dynamic>.from(json['inviter'] as Map))
        : null,
    trip: json['trip'] is Map
        ? TripInvitationSummary.fromJson(
            Map<String, dynamic>.from(json['trip'] as Map),
          )
        : null,
  );
}

class TripInvitationSummary {
  const TripInvitationSummary({
    required this.id,
    required this.name,
    required this.status,
    required this.startDate,
    required this.endDate,
  });
  final String id;
  final String name;
  final TripStatus status;
  final DateTime startDate;
  final DateTime endDate;

  factory TripInvitationSummary.fromJson(Map<String, dynamic> json) =>
      TripInvitationSummary(
        id: json['id'] as String,
        name: json['name'] as String,
        status: parseTripEnum(
          json['status'] as String,
          tripStatusFromWire,
          'trip status',
        ),
        startDate: DateTime.parse(json['startDate'] as String),
        endDate: DateTime.parse(json['endDate'] as String),
      );
}
