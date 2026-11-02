class ProfileModel {
  const ProfileModel({
    required this.id,
    required this.displayName,
    required this.username,
    required this.email,
    required this.avatarId,
    required this.bio,
    required this.phone,
    required this.address,
    required this.location,
    required this.gender,
    required this.dateOfBirth,
    required this.budgetLevel,
    required this.travelStyle,
    required this.languages,
    required this.interests,
    required this.notificationEnabled,
    required this.visitedCount,
    this.avatarUrl,
  });
  final String id;
  final String? displayName;
  final String username;
  final String? email;
  final String? avatarId;
  final String? bio;
  final String? phone;
  final String? address;
  final String? location;
  final String? gender;
  final String? dateOfBirth;
  final BudgetLevel? budgetLevel;
  final List<Map<String, Object?>> travelStyle;
  final List<String> languages;
  final List<String> interests;
  final bool notificationEnabled;
  final num visitedCount;
  final String? avatarUrl;

  String get initials => username
      .trim()
      .split(RegExp(r'\s+'))
      .where((word) => word.isNotEmpty)
      .take(2)
      .map((word) => word[0].toUpperCase())
      .join();

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    final rawTravelStyle = json['travelStyle'];
    final rawLanguages = json['languages'];
    final rawInterests = json['interests'];
    final rawBudgetLevel = json['budgetLevel'];
    return ProfileModel(
      id: _requiredString(json, 'id'),
      displayName: _nullableString(json['displayname']),
      username: _requiredString(json, 'username'),
      email: _nullableString(json['email']),
      avatarId: _nullableString(json['avatarId']),
      bio: _nullableString(json['bio']),
      phone: _nullableString(json['phone']),
      address: _nullableString(json['address']),
      location: _nullableString(json['location']),
      gender: _nullableString(json['gender']),
      dateOfBirth: _nullableString(json['dateofBirth']),
      budgetLevel: rawBudgetLevel == null
          ? null
          : BudgetLevel.fromApiValue(rawBudgetLevel.toString()),
      travelStyle: rawTravelStyle is List
          ? rawTravelStyle
                .whereType<Map>()
                .map(
                  (item) => item.map<String, Object?>(
                    (key, value) => MapEntry(key.toString(), value),
                  ),
                )
                .toList(growable: false)
          : const [],
      languages: rawLanguages is List
          ? rawLanguages.whereType<String>().toList(growable: false)
          : const [],
      interests: rawInterests is List
          ? rawInterests.whereType<String>().toList(growable: false)
          : const [],
      notificationEnabled: json['notificationEnabled'] as bool,
      visitedCount: json['visitedCount'] as num,
    );
  }

  ProfileModel withAvatarUrl(String? value) => ProfileModel(
    id: id,
    displayName: displayName,
    username: username,
    email: email,
    avatarId: avatarId,
    bio: bio,
    phone: phone,
    address: address,
    location: location,
    gender: gender,
    dateOfBirth: dateOfBirth,
    budgetLevel: budgetLevel,
    travelStyle: travelStyle,
    languages: languages,
    interests: interests,
    notificationEnabled: notificationEnabled,
    visitedCount: visitedCount,
    avatarUrl: value,
  );

  static String _requiredString(Map<String, dynamic> json, String key) {
    final value = json[key];
    if (value is! String) {
      throw FormatException('Invalid $key in profile response.');
    }
    return value;
  }

  static String? _nullableString(Object? value) =>
      value is String && value.isNotEmpty ? value : null;
}

enum BudgetLevel {
  low('LOW'),
  medium('MEDIUM'),
  high('HIGH');

  const BudgetLevel(this.apiValue);
  final String apiValue;
  factory BudgetLevel.fromApiValue(String value) =>
      BudgetLevel.values.firstWhere(
        (level) => level.apiValue == value,
        orElse: () => throw FormatException('Unknown budgetLevel: $value'),
      );
}
