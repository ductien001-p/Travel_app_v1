import '../data/models/trip_invite_friends_models.dart';

/// Chips backed by `GET /trips/recommend-friends/{tripId}`.
enum TripInviteFriendsFilter {
  all,
  traveledTogether,
  recent,
  sameTaste,
  invited,
}

/// Friends interacted with inside this window count as "Gần đây".
const tripInviteRecentWindow = Duration(days: 30);

/// Minimum match score for the "Cùng gu" chip.
const tripInviteSameTasteScore = 50;

/// Lists the screen renders after search, filter, and member exclusion.
class TripInviteFriendsView {
  const TripInviteFriendsView({
    required this.suggested,
    required this.suggestedTitle,
    required this.directory,
    required this.selected,
    required this.isSearch,
    required this.singleSectionTitle,
    required this.hasMoreSearchResults,
    this.suggestedSubtitle,
    this.directorySubtitle,
  });

  final List<TripInviteCandidate> suggested;
  final String suggestedTitle;
  final String? suggestedSubtitle;

  /// Everyone else, or the whole list when searching / filtering one group.
  final List<TripInviteCandidate> directory;
  final String? directorySubtitle;

  final List<TripInviteCandidate> selected;
  final bool isSearch;

  /// Set when suggested and directory are one list.
  final String? singleSectionTitle;
  final bool hasMoreSearchResults;

  bool get isEmpty => suggested.isEmpty && directory.isEmpty;
}

TripInviteFriendsView buildTripInviteFriendsView({
  required List<TripInviteCandidate> candidates,
  required List<TripInviteCandidate>? searchResults,
  required bool hasMoreSearchResults,
  required TripInviteFriendsFilter filter,
  required Map<String, TripInviteCandidate> selectedById,
  required Set<String> excludedUserIds,
  required DateTime now,
}) {
  final searching = searchResults != null;
  final source = searchResults ?? candidates;
  final visible = _applyFilter(
    [
      for (final person in source)
        if (!excludedUserIds.contains(person.user.id)) person,
    ],
    filter,
    now,
  );
  final singleSection =
      searching ||
      filter == TripInviteFriendsFilter.invited ||
      filter == TripInviteFriendsFilter.recent ||
      filter == TripInviteFriendsFilter.sameTaste;
  final split = singleSection
      ? (suggested: const <TripInviteCandidate>[], directory: visible)
      : _splitSuggestions(visible);

  return TripInviteFriendsView(
    suggested: split.suggested,
    suggestedTitle: _suggestedTitle(visible),
    suggestedSubtitle: _usesDnaSuggestions(visible)
        ? null
        : 'Đã đi chung ở các chuyến trước',
    directory: split.directory,
    directorySubtitle: singleSection ? null : 'Tương tác gần nhất',
    selected: [for (final person in selectedById.values) person],
    isSearch: searching,
    singleSectionTitle: switch ((searching, filter)) {
      (true, _) => 'Kết quả tìm kiếm',
      (false, TripInviteFriendsFilter.invited) => 'Đã gửi lời mời',
      (false, TripInviteFriendsFilter.recent) => 'Gần đây',
      (false, TripInviteFriendsFilter.sameTaste) => 'Cùng gu du lịch',
      _ => null,
    },
    hasMoreSearchResults: searching && hasMoreSearchResults,
  );
}

/// Copies invitation status, DNA, and shared-trip count onto a search hit.
TripInviteCandidate candidateFromSearch(
  TripInviteFriend user,
  List<TripInviteCandidate> known,
) {
  for (final person in known) {
    if (person.user.id == user.id) {
      return person.copyWith(user: user);
    }
  }
  return TripInviteCandidate(user: user);
}

String tripInviteSameTasteChipLabel(String? tripTravelPersona) {
  if (tripTravelPersona == null || tripTravelPersona.isEmpty) {
    return 'Cùng gu du lịch';
  }
  return 'Cùng gu ($tripTravelPersona)';
}

List<TripInviteCandidate> _applyFilter(
  List<TripInviteCandidate> people,
  TripInviteFriendsFilter filter,
  DateTime now,
) => switch (filter) {
  TripInviteFriendsFilter.all => people,
  TripInviteFriendsFilter.traveledTogether => [
    for (final person in people)
      if (person.tripsTogetherCount > 0) person,
  ],
  TripInviteFriendsFilter.recent => [
    for (final person in people)
      if (_isRecent(person, now)) person,
  ],
  TripInviteFriendsFilter.sameTaste => [
    for (final person in people)
      if ((person.matchScore ?? -1) >= tripInviteSameTasteScore) person,
  ],
  TripInviteFriendsFilter.invited => [
    for (final person in people)
      if (person.invitationStatus == TripInviteStatus.pending) person,
  ],
};

bool _isRecent(TripInviteCandidate person, DateTime now) {
  final at = person.lastInteractionAt;
  if (at == null) return false;
  return !at.isBefore(now.subtract(tripInviteRecentWindow));
}

bool _usesDnaSuggestions(List<TripInviteCandidate> people) =>
    people.any((person) => person.matchScore != null);

String _suggestedTitle(List<TripInviteCandidate> people) =>
    _usesDnaSuggestions(people)
    ? 'Gợi ý cùng gu du lịch'
    : 'Gợi ý bạn đồng hành';

({List<TripInviteCandidate> suggested, List<TripInviteCandidate> directory})
_splitSuggestions(List<TripInviteCandidate> people) {
  if (_usesDnaSuggestions(people)) {
    final suggested = [
      for (final person in people)
        if (person.matchScore != null) person,
    ]..sort((a, b) => b.matchScore!.compareTo(a.matchScore!));
    final directory = [
      for (final person in people)
        if (person.matchScore == null) person,
    ]..sort(_byRecentInteraction);
    return (suggested: suggested, directory: directory);
  }

  return (
    suggested: [
      for (final person in people)
        if (person.tripsTogetherCount > 0) person,
    ],
    directory: [
      for (final person in people)
        if (person.tripsTogetherCount == 0) person,
    ]..sort(_byRecentInteraction),
  );
}

int _byRecentInteraction(TripInviteCandidate a, TripInviteCandidate b) {
  final aAt = a.lastInteractionAt;
  final bAt = b.lastInteractionAt;
  if (aAt == null && bAt == null) {
    return a.user.displayName.compareTo(b.user.displayName);
  }
  if (aAt == null) return 1;
  if (bAt == null) return -1;
  final byTime = bAt.compareTo(aAt);
  if (byTime != 0) return byTime;
  return a.user.displayName.compareTo(b.user.displayName);
}
