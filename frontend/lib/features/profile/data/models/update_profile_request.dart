import 'profile_model.dart';

class UpdateProfileRequest {
  const UpdateProfileRequest({
    this.displayName,
    this.username,
    this.phone,
    this.avatarId,
    this.gender,
    this.clearGender = false,
    this.dateOfBirth,
    this.clearDateOfBirth = false,
    this.address,
    this.bio,
    this.location,
    this.notificationEnabled,
    this.budgetLevel,
    this.languages,
    this.interests,
  });
  final String? displayName;
  final String? username;
  final String? phone;
  final String? avatarId;
  final String? gender;
  final bool clearGender;
  final String? dateOfBirth;
  final bool clearDateOfBirth;
  final String? address;
  final String? bio;
  final String? location;
  final bool? notificationEnabled;
  final BudgetLevel? budgetLevel;
  final List<String>? languages;
  final List<String>? interests;
  bool get isEmpty =>
      displayName == null &&
      username == null &&
      phone == null &&
      avatarId == null &&
      gender == null &&
      !clearGender &&
      dateOfBirth == null &&
      !clearDateOfBirth &&
      address == null &&
      bio == null &&
      location == null &&
      notificationEnabled == null &&
      budgetLevel == null &&
      languages == null &&
      interests == null;
  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (displayName != null) json['displayname'] = displayName;
    if (username != null) json['username'] = username;
    if (phone != null) json['phone'] = phone;
    if (avatarId != null) json['avatarId'] = avatarId;
    if (clearGender) {
      json['gender'] = null;
    } else if (gender != null) {
      json['gender'] = gender;
    }
    if (clearDateOfBirth) {
      json['dateofBirth'] = null;
    } else if (dateOfBirth != null) {
      json['dateofBirth'] = dateOfBirth;
    }
    if (address != null) json['address'] = address;
    if (bio != null) json['bio'] = bio;
    if (location != null) json['location'] = location;
    if (notificationEnabled != null) {
      json['notificationEnabled'] = notificationEnabled;
    }
    if (budgetLevel != null) json['budgetLevel'] = budgetLevel!.apiValue;
    if (languages != null) json['languages'] = languages;
    if (interests != null) json['interests'] = interests;
    return json;
  }
}
