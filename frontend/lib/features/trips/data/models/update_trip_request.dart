import 'trip_destination.dart';
import 'trip_enums.dart';

class UpdateTripRequest {
  const UpdateTripRequest({
    this.name,
    this.description,
    this.budgetLevel,
    this.maxMembers,
    this.tripType,
    this.visibility,
    this.coverMediaId,
    this.acknowledgeRecruitmentImpact = false,
    this.addDestinations = const [],
    this.removeDestinationIds = const [],
  });

  final String? name;
  final String? description;
  final TripBudgetLevel? budgetLevel;
  final int? maxMembers;
  final TripType? tripType;
  final TripVisibility? visibility;
  final String? coverMediaId;
  final bool acknowledgeRecruitmentImpact;
  final List<TripDestinationInput> addDestinations;
  final List<String> removeDestinationIds;

  UpdateTripRequest copyWith({bool? acknowledgeRecruitmentImpact}) {
    return UpdateTripRequest(
      name: name,
      description: description,
      budgetLevel: budgetLevel,
      maxMembers: maxMembers,
      tripType: tripType,
      visibility: visibility,
      coverMediaId: coverMediaId,
      acknowledgeRecruitmentImpact:
          acknowledgeRecruitmentImpact ?? this.acknowledgeRecruitmentImpact,
      addDestinations: addDestinations,
      removeDestinationIds: removeDestinationIds,
    );
  }

  Map<String, dynamic> toJson() => {
    if (name != null) 'name': name,
    if (description != null) 'description': description,
    if (budgetLevel != null) 'budgetLevel': budgetLevel!.wireValue,
    if (maxMembers != null) 'maxMembers': maxMembers,
    if (tripType != null) 'tripType': tripType!.wireValue,
    if (visibility != null) 'visibility': visibility!.wireValue,
    if (coverMediaId != null) 'coverMediaId': coverMediaId,
    if (acknowledgeRecruitmentImpact) 'acknowledgeRecruitmentImpact': true,
    if (addDestinations.isNotEmpty)
      'addDestinations': addDestinations.map((item) => item.toJson()).toList(),
    if (removeDestinationIds.isNotEmpty)
      'removeDestinationIds': removeDestinationIds,
  };
}
