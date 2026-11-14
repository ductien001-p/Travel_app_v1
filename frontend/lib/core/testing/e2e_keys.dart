import 'package:flutter/foundation.dart';

/// Stable [ValueKey]s for UI automation (integration_test / Flutter Driver).
///
/// Keep string values stable — changing them breaks E2E selectors.
abstract final class E2eKeys {
  static const loginEmail = ValueKey<String>('e2e.login.email');
  static const loginPassword = ValueKey<String>('e2e.login.password');
  static const loginSubmit = ValueKey<String>('e2e.login.submit');

  static const navExplore = ValueKey<String>('e2e.nav.explore');
  static const navSocial = ValueKey<String>('e2e.nav.social');
  static const navTrips = ValueKey<String>('e2e.nav.trips');
  static const navChat = ValueKey<String>('e2e.nav.chat');
  static const navProfile = ValueKey<String>('e2e.nav.profile');

  static const chatsHubScreenRoot = ValueKey<String>('e2e.chats.hub');
  static const friendChatScreenRoot = ValueKey<String>('e2e.chats.friendChat');
  static const tripChatScreenRoot = ValueKey<String>('e2e.chats.tripChat');

  static const homeSegmentPlaces = ValueKey<String>('e2e.home.segment.places');
  static const homeSegmentCommunity = ValueKey<String>(
    'e2e.home.segment.community',
  );

  static const featuredSeeAll = ValueKey<String>('featured-see-all');

  static ValueKey<String> featuredPlace(String placeId) =>
      ValueKey<String>('featured-place-$placeId');

  static const placeDetailName = ValueKey<String>('place-detail-name');

  static const tripsCreateFab = ValueKey<String>('e2e.trips.createFab');
  static const tripsScreenRoot = ValueKey<String>('e2e.trips.screen');

  static const profileScreenRoot = ValueKey<String>('e2e.profile.screen');
  static const profileEditButton = ValueKey<String>('e2e.profile.edit');
  static const profileSavedTab = ValueKey<String>('e2e.profile.tab.saved');
  static const savedPlacesScreenRoot = ValueKey<String>(
    'e2e.profile.savedPlaces',
  );

  static const createTripScreenRoot = ValueKey<String>('e2e.createTrip.screen');
}
