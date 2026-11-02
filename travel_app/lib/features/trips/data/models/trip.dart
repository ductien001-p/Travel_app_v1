import 'trip_destination.dart';
import 'trip_enums.dart';

class TripOwner {
  const TripOwner({
    required this.id,
    required this.username,
    this.avatarId,
    this.avatarUrl,
  });
  final String id;
  final String username;
  final String? avatarId;
  final String? avatarUrl;

  factory TripOwner.fromJson(Map<String, dynamic> json) => TripOwner(
    id: json['id'] as String,
    username: json['username'] as String,
    avatarId: json['avatarId'] as String?,
    avatarUrl: json['avatarUrl'] as String?,
  );
}

class TripInterest {
  const TripInterest({required this.id, required this.name});
  final String id;
  final String name;

  factory TripInterest.fromJson(Map<String, dynamic> json) =>
      TripInterest(id: json['id'] as String, name: json['name'] as String);
}

class TripMember {
  const TripMember({
    required this.id,
    required this.tripId,
    required this.userId,
    required this.role,
    required this.status,
    required this.joinedAt,
    this.leftAt,
    this.notificationEnabled,
  });
  final String id;
  final String tripId;
  final String userId;
  final TripRole role;
  final TripMemberStatus status;
  final DateTime joinedAt;
  final DateTime? leftAt;
  final bool? notificationEnabled;

  factory TripMember.fromJson(Map<String, dynamic> json) => TripMember(
    id: json['id'] as String,
    tripId: json['tripId'] as String,
    userId: json['userId'] as String,
    role: parseTripEnum(json['role'] as String, const {
      'MEMBER': TripRole.member,
      'ADMIN': TripRole.admin,
      'OWNER': TripRole.owner,
    }, 'trip role'),
    status: parseTripEnum(json['status'] as String, const {
      'ACTIVE': TripMemberStatus.active,
      'LEFT': TripMemberStatus.left,
      'KICKED': TripMemberStatus.kicked,
    }, 'member status'),
    joinedAt: DateTime.parse(json['joinedAt'] as String),
    leftAt: json['leftAt'] == null
        ? null
        : DateTime.parse(json['leftAt'] as String),
    notificationEnabled: json['notificationEnabled'] as bool?,
  );
}

class Trip {
  const Trip({
    required this.id,
    required this.name,
    required this.startDate,
    required this.endDate,
    required this.maxMembers,
    required this.tripType,
    required this.visibility,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.inviteCode,
    this.ownerId,
    this.description,
    this.coverImageUrl,
    this.budgetLevel,
    this.estimatedBudgetPerPerson,
    this.budgetCurrency,
    this.owner,
    this.destinations = const [],
    this.interests = const [],
    this.members = const [],
    this.timelineEvents = const [],
  });

  final String id;
  final String? ownerId;
  final String name;
  final String? description;
  final String? coverImageUrl;
  final DateTime startDate;
  final DateTime endDate;
  final TripBudgetLevel? budgetLevel;
  final int maxMembers;
  final TripType tripType;
  final TripVisibility visibility;
  final TripStatus status;
  final String? estimatedBudgetPerPerson;
  final String? budgetCurrency;
  final DateTime createdAt;
  final DateTime updatedAt;
  final TripOwner? owner;
  final String inviteCode;
  final List<TripDestination> destinations;
  final List<TripInterest> interests;
  final List<TripMember> members;
  final List<Map<String, dynamic>> timelineEvents;

  factory Trip.fromJson(Map<String, dynamic> json) {
    final rawInterests = json['tripInterests'] ?? json['interests'];
    return Trip(
      id: json['id'] as String,
      ownerId: json['ownerId'] as String?,
      name: json['name'] as String,
      description: json['description'] as String?,
      coverImageUrl: json['coverImageUrl'] as String?,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      budgetLevel: json['budgetLevel'] == null
          ? null
          : parseTripEnum(json['budgetLevel'] as String, const {
              'LOW': TripBudgetLevel.low,
              'MEDIUM': TripBudgetLevel.medium,
              'HIGH': TripBudgetLevel.high,
            }, 'budget level'),
      estimatedBudgetPerPerson: json['estimatedBudgetPerPerson']?.toString(),
      budgetCurrency: json['budgetCurrency'] as String?,
      maxMembers: json['maxMembers'] as int,
      tripType: parseTripEnum(json['tripType'] as String, const {
        'SOLO': TripType.solo,
        'COUPLE': TripType.couple,
        'FAMILY': TripType.family,
        'FRIENDS': TripType.friends,
        'BACKPACKER': TripType.backpacker,
        'OTHER': TripType.other,
      }, 'trip type'),
      visibility: parseTripEnum(json['visibility'] as String, const {
        'PUBLIC': TripVisibility.public,
        'PRIVATE': TripVisibility.private,
      }, 'trip visibility'),
      status: parseTripEnum(
        json['status'] as String,
        tripStatusFromWire,
        'trip status',
      ),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      owner: json['owner'] is Map
          ? TripOwner.fromJson(Map<String, dynamic>.from(json['owner'] as Map))
          : null,
      inviteCode: json['inviteCode'] as String,
      destinations: _mapList(json['destinations'], TripDestination.fromJson),
      interests: _mapList(rawInterests, TripInterest.fromJson),
      members: _mapList(json['members'], TripMember.fromJson),
      timelineEvents: (json['timelineEvents'] as List? ?? const [])
          .map((item) => Map<String, dynamic>.from(item as Map))
          .toList(growable: false),
    );
  }
}

List<T> _mapList<T>(Object? value, T Function(Map<String, dynamic>) parser) {
  return (value as List? ?? const [])
      .map((item) => parser(Map<String, dynamic>.from(item as Map)))
      .toList(growable: false);
}
