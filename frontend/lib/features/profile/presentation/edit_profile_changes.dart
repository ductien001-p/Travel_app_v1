import '../data/models/profile_model.dart';
import '../data/models/update_profile_request.dart';
import 'edit_profile_format.dart';

/// Dựng body `PATCH /users/update` từ form chỉnh sửa hồ sơ.
///
/// `location` và `address` là hai field riêng. Giới tính rỗng nghĩa là xóa.
/// Ngày sinh trống gửi `null`, không gửi chuỗi rỗng.
UpdateProfileRequest editProfileChanges({
  required ProfileModel profile,
  required String displayName,
  required String username,
  required String bio,
  required String phone,
  required String location,
  required String address,
  required String? gender,
  required String dateOfBirthDisplay,
  required BudgetLevel? budgetLevel,
  required Set<String> languages,
  required Set<String> interests,
}) {
  String? changedText(String value, String? original) {
    final trimmed = value.trim();
    return trimmed == (original ?? '') ? null : trimmed;
  }

  final trimmedDate = dateOfBirthDisplay.trim();
  final parsedDate = parseEditProfileDate(trimmedDate);
  final originalDate = profile.dateOfBirth ?? '';
  final selectedGender = gender == null || gender.isEmpty ? null : gender;
  final originalGender = normalizedEditProfileGender(profile.gender);

  return UpdateProfileRequest(
    displayName: changedText(displayName, profile.displayName),
    username: changedText(username, profile.username),
    bio: changedText(bio, profile.bio),
    phone: changedText(phone, profile.phone),
    location: changedText(location, profile.location),
    address: changedText(address, profile.address),
    gender: selectedGender == originalGender ? null : selectedGender,
    clearGender: selectedGender == null && originalGender != null,
    dateOfBirth:
        parsedDate == null || parsedDate.isEmpty || parsedDate == originalDate
        ? null
        : parsedDate,
    clearDateOfBirth: trimmedDate.isEmpty && originalDate.isNotEmpty,
    budgetLevel: budgetLevel == profile.budgetLevel ? null : budgetLevel,
    languages: _sameItems(languages, profile.languages)
        ? null
        : languages.toList(growable: false),
    interests: _sameItems(interests, profile.interests)
        ? null
        : interests.toList(growable: false),
  );
}

String? normalizedEditProfileGender(String? value) {
  final normalized = value?.trim().toLowerCase();
  return switch (normalized) {
    'male' || 'nam' => 'male',
    'female' || 'nữ' || 'nu' => 'female',
    'other' || 'khác' || 'khac' => 'other',
    _ => null,
  };
}

bool _sameItems(Set<String> current, List<String> original) =>
    current.length == original.length && current.containsAll(original);
