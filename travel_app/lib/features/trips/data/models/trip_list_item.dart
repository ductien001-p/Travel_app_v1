import 'trip_destination.dart';
import 'trip_enums.dart';
import 'trip_pagination.dart';

class TripListMemberPreview {
  const TripListMemberPreview({
    required this.id,
    required this.username,
    this.avatarUrl,
  });

  final String id;
  final String username;
  final String? avatarUrl;

  factory TripListMemberPreview.fromJson(Map<String, dynamic> json) =>
      TripListMemberPreview(
        id: json['id'] as String,
        username: json['username'] as String,
        avatarUrl: json['avatarUrl'] as String?,
      );
}

class TripListOwner {
  const TripListOwner({
    required this.id,
    required this.displayname,
    required this.username,
    this.avatarUrl,
  });

  final String id;
  final String displayname;
  final String username;
  final String? avatarUrl;

  factory TripListOwner.fromJson(Map<String, dynamic> json) => TripListOwner(
    id: json['id'] as String,
    displayname: json['displayname'] as String,
    username: json['username'] as String,
    avatarUrl: json['avatarUrl'] as String?,
  );
}

class TripListNextActivity {
  const TripListNextActivity({
    required this.id,
    required this.title,
    this.startTime,
  });

  final String id;
  final String title;
  final DateTime? startTime;

  factory TripListNextActivity.fromJson(Map<String, dynamic> json) =>
      TripListNextActivity(
        id: json['id'] as String,
        title: json['title'] as String,
        startTime: json['startTime'] == null
            ? null
            : DateTime.parse(json['startTime'] as String),
      );
}

class TripListItem {
  const TripListItem({
    required this.id,
    required this.name,
    required this.startDate,
    required this.endDate,
    required this.maxMembers,
    required this.tripType,
    required this.visibility,
    required this.status,
    required this.destinations,
    required this.memberCount,
    required this.memberPreviews,
    required this.recruiting,
    required this.checkinCount,
    required this.totalActivities,
    required this.completedActivities,
    required this.progressPercent,
    this.description,
    this.budgetLevel,
    this.coverImageUrl,
    this.owner,
    this.nextActivity,
    this.requirements,
    this.estimatedBudgetPerPerson,
    this.slotsRemaining,
    this.expiresAt,
    this.matchScore,
    this.urgent = false,
  });

  final String id;
  final String name;
  final String? description;
  final DateTime startDate;
  final DateTime endDate;
  final TripBudgetLevel? budgetLevel;
  final int maxMembers;
  final TripType tripType;
  final TripVisibility visibility;
  final TripStatus status;
  final List<TripDestination> destinations;
  final int memberCount;
  final List<TripListMemberPreview> memberPreviews;
  final TripListOwner? owner;
  final bool recruiting;
  final String? coverImageUrl;
  final int checkinCount;
  final int totalActivities;
  final int completedActivities;
  final int progressPercent;
  final TripListNextActivity? nextActivity;
  final String? requirements;
  final String? estimatedBudgetPerPerson;
  final int? slotsRemaining;
  final DateTime? expiresAt;
  final int? matchScore;
  final bool urgent;

  factory TripListItem.fromJson(Map<String, dynamic> json) {
    final maxMembers = json['maxMembers'] as int;
    final memberCount = json['memberCount'] as int;
    return TripListItem(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      budgetLevel: json['budgetLevel'] == null
          ? null
          : parseTripEnum(json['budgetLevel'] as String, const {
              'LOW': TripBudgetLevel.low,
              'MEDIUM': TripBudgetLevel.medium,
              'HIGH': TripBudgetLevel.high,
            }, 'budget level'),
      maxMembers: maxMembers,
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
      destinations: (json['destinations'] as List? ?? const [])
          .map(
            (item) => TripDestination.fromJson(
              Map<String, dynamic>.from(item as Map),
              fallbackTripId: json['id'] as String,
            ),
          )
          .toList(growable: false),
      memberCount: memberCount,
      memberPreviews: (json['memberPreviews'] as List? ?? const [])
          .map(
            (item) => TripListMemberPreview.fromJson(
              Map<String, dynamic>.from(item as Map),
            ),
          )
          .toList(growable: false),
      owner: json['owner'] is Map
          ? TripListOwner.fromJson(
              Map<String, dynamic>.from(json['owner'] as Map),
            )
          : null,
      recruiting: json['recruiting'] as bool? ?? memberCount < maxMembers,
      coverImageUrl: json['coverImageUrl'] as String?,
      checkinCount: json['checkinCount'] as int,
      totalActivities: json['totalActivities'] as int,
      completedActivities: json['completedActivities'] as int,
      progressPercent: json['progressPercent'] as int,
      nextActivity: json['nextActivity'] is Map
          ? TripListNextActivity.fromJson(
              Map<String, dynamic>.from(json['nextActivity'] as Map),
            )
          : null,
      requirements: json['requirements'] as String?,
      estimatedBudgetPerPerson: json['estimatedBudgetPerPerson']?.toString(),
      slotsRemaining: json['slotsRemaining'] as int?,
      expiresAt: json['expiresAt'] == null
          ? null
          : DateTime.parse(json['expiresAt'] as String),
      matchScore: json['matchScore'] as int?,
      urgent: json['urgent'] as bool? ?? false,
    );
  }
}

class TripSummary {
  const TripSummary({
    required this.total,
    required this.upcoming,
    required this.ongoing,
    required this.completed,
    required this.cancelled,
    required this.notCompleted,
    required this.totalCheckins,
  });

  final int total;
  final int upcoming;
  final int ongoing;
  final int completed;
  final int cancelled;
  final int notCompleted;
  final int totalCheckins;

  factory TripSummary.fromJson(Map<String, dynamic> json) => TripSummary(
    total: json['total'] as int,
    upcoming: json['upcoming'] as int,
    ongoing: json['ongoing'] as int,
    completed: json['completed'] as int,
    cancelled: json['cancelled'] as int,
    notCompleted: json['notCompleted'] as int,
    totalCheckins: json['totalCheckins'] as int,
  );
}

class TripListPage {
  const TripListPage({
    required this.items,
    required this.meta,
    required this.summary,
  });

  final List<TripListItem> items;
  final PageMeta meta;
  final TripSummary summary;
}
