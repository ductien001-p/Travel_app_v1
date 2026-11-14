import 'package:flutter_test/flutter_test.dart';
import 'package:travel_frontend_v1/features/profile/data/models/profile_model.dart';
import 'package:travel_frontend_v1/features/profile/presentation/edit_profile_changes.dart';

void main() {
  const profile = ProfileModel(
    id: 'user-1',
    displayName: 'Alex Nguyễn',
    username: 'alex_wander',
    email: 'alex@example.com',
    avatarId: null,
    bio: 'Bio',
    phone: '0987654678',
    address: '123 Lê Lợi',
    location: 'Đà Nẵng, Việt Nam',
    gender: 'male',
    dateOfBirth: '1996-08-15',
    budgetLevel: BudgetLevel.medium,
    travelStyle: [],
    languages: ['vi'],
    interests: ['food'],
    notificationEnabled: true,
    visitedCount: 1,
  );

  test('clears birth date with null and keeps other fields', () {
    final request = editProfileChanges(
      profile: profile,
      displayName: profile.displayName!,
      username: profile.username,
      bio: profile.bio!,
      phone: profile.phone!,
      location: profile.location!,
      address: profile.address!,
      gender: 'male',
      dateOfBirthDisplay: '',
      budgetLevel: profile.budgetLevel,
      languages: profile.languages.toSet(),
      interests: profile.interests.toSet(),
    );

    expect(request.toJson(), {'dateofBirth': null});
    expect(request.isEmpty, isFalse);
  });

  test('clears gender and updates location without changing address', () {
    final request = editProfileChanges(
      profile: profile,
      displayName: profile.displayName!,
      username: profile.username,
      bio: profile.bio!,
      phone: profile.phone!,
      location: 'Hội An',
      address: profile.address!,
      gender: '',
      dateOfBirthDisplay: '15/08/1996',
      budgetLevel: profile.budgetLevel,
      languages: profile.languages.toSet(),
      interests: profile.interests.toSet(),
    );

    expect(request.toJson(), {'gender': null, 'location': 'Hội An'});
  });

  test('updates address without changing location', () {
    final request = editProfileChanges(
      profile: profile,
      displayName: profile.displayName!,
      username: profile.username,
      bio: profile.bio!,
      phone: profile.phone!,
      location: profile.location!,
      address: '45 Trần Phú',
      gender: 'male',
      dateOfBirthDisplay: '15/08/1996',
      budgetLevel: profile.budgetLevel,
      languages: profile.languages.toSet(),
      interests: profile.interests.toSet(),
    );

    expect(request.toJson(), {'address': '45 Trần Phú'});
  });

  test('leaves location and address untouched when neither field changes', () {
    final request = editProfileChanges(
      profile: profile,
      displayName: profile.displayName!,
      username: profile.username,
      bio: profile.bio!,
      phone: profile.phone!,
      location: profile.location!,
      address: profile.address!,
      gender: 'male',
      dateOfBirthDisplay: '15/08/1996',
      budgetLevel: profile.budgetLevel,
      languages: profile.languages.toSet(),
      interests: profile.interests.toSet(),
    );

    expect(request.isEmpty, isTrue);
    expect(request.toJson(), isEmpty);
  });
}
