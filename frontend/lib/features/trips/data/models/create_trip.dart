import 'package:travel_frontend_v1/features/trips/data/models/requets-create-trip/create_trip_destination_request.dart';

class CreateTripRequest {
  final String name;
  final String? description;
  final String tripType;
  final String budgetLevel;
  final int maxMembers;
  final String visibility;
  final List<String> interestIds;
  final String? coverMediaId;
  final String? estimatedBudgetPerPerson;
  final String? budgetCurrency;
  final List<CreateTripDestinationRequest> destinations;

  const CreateTripRequest({
    required this.name,
    this.description,
    required this.tripType,
    required this.budgetLevel,
    required this.maxMembers,
    required this.visibility,
    this.interestIds = const [],
    this.coverMediaId,
    this.estimatedBudgetPerPerson,
    this.budgetCurrency,
    required this.destinations,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      if (description != null) 'description': description,
      'tripType': tripType,
      'budgetLevel': budgetLevel,
      'maxMembers': maxMembers,
      'visibility': visibility,
      'interestIds': interestIds,
      if (coverMediaId != null) 'coverMediaId': coverMediaId,
      if (estimatedBudgetPerPerson != null)
        'estimatedBudgetPerPerson': estimatedBudgetPerPerson,
      if (budgetCurrency != null) 'budgetCurrency': budgetCurrency,
      'destinations': destinations.map((e) => e.toJson()).toList(),
    };
  }
}

class CreateTripDraftRequest {
  const CreateTripDraftRequest({
    this.name,
    this.description,
    this.tripType,
    this.budgetLevel,
    this.maxMembers,
    this.visibility,
    this.interestIds,
    this.coverMediaId,
    this.estimatedBudgetPerPerson,
    this.budgetCurrency,
    this.destinations,
  });

  final String? name;
  final String? description;
  final String? tripType;
  final String? budgetLevel;
  final int? maxMembers;
  final String? visibility;
  final List<String>? interestIds;
  final String? coverMediaId;
  final String? estimatedBudgetPerPerson;
  final String? budgetCurrency;
  final List<CreateTripDestinationRequest>? destinations;

  Map<String, dynamic> toJson() => {
    if (name != null) 'name': name,
    if (description != null) 'description': description,
    if (tripType != null) 'tripType': tripType,
    if (budgetLevel != null) 'budgetLevel': budgetLevel,
    if (maxMembers != null) 'maxMembers': maxMembers,
    if (visibility != null) 'visibility': visibility,
    if (interestIds != null) 'interestIds': interestIds,
    if (coverMediaId != null) 'coverMediaId': coverMediaId,
    if (estimatedBudgetPerPerson != null)
      'estimatedBudgetPerPerson': estimatedBudgetPerPerson,
    if (budgetCurrency != null) 'budgetCurrency': budgetCurrency,
    if (destinations != null)
      'destinations': destinations!.map((item) => item.toJson()).toList(),
  };
}
