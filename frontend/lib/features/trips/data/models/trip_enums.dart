enum TripBudgetLevel { low, medium, high }

enum TripType { solo, couple, family, friends, backpacker, other }

enum TripVisibility { public, private }

enum TripStatus { draft, upcoming, ongoing, cancelled, completed, notCompleted }

enum TripRole { member, admin, owner }

enum TripMemberStatus { active, left, kicked }

enum TripInvitationStatus { pending, accepted, rejected }

T parseTripEnum<T>(String value, Map<String, T> values, String field) {
  final parsed = values[value];
  if (parsed == null) throw FormatException('Unknown $field value: $value');
  return parsed;
}

/// Wire values for [TripStatus]. Accepts legacy `NOTCOM` and Prisma `NOTCOMPLETED`.
const Map<String, TripStatus> tripStatusFromWire = {
  'DRAFT': TripStatus.draft,
  'UPCOMING': TripStatus.upcoming,
  'ONGOING': TripStatus.ongoing,
  'CANCELLED': TripStatus.cancelled,
  'COMPLETED': TripStatus.completed,
  'NOTCOM': TripStatus.notCompleted,
  'NOTCOMPLETED': TripStatus.notCompleted,
};

extension TripBudgetLevelJson on TripBudgetLevel {
  String get wireValue => const {
    TripBudgetLevel.low: 'LOW',
    TripBudgetLevel.medium: 'MEDIUM',
    TripBudgetLevel.high: 'HIGH',
  }[this]!;
}

extension TripTypeJson on TripType {
  String get wireValue => const {
    TripType.solo: 'SOLO',
    TripType.couple: 'COUPLE',
    TripType.family: 'FAMILY',
    TripType.friends: 'FRIENDS',
    TripType.backpacker: 'BACKPACKER',
    TripType.other: 'OTHER',
  }[this]!;
}

extension TripVisibilityJson on TripVisibility {
  String get wireValue => const {
    TripVisibility.public: 'PUBLIC',
    TripVisibility.private: 'PRIVATE',
  }[this]!;
}

extension TripStatusJson on TripStatus {
  String get wireValue => const {
    TripStatus.draft: 'DRAFT',
    TripStatus.upcoming: 'UPCOMING',
    TripStatus.ongoing: 'ONGOING',
    TripStatus.cancelled: 'CANCELLED',
    TripStatus.completed: 'COMPLETED',
    TripStatus.notCompleted: 'NOTCOMPLETED',
  }[this]!;
}
