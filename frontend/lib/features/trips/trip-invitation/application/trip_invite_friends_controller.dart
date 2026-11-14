import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:travel_frontend_v1/core/networks/api_exception.dart';
import '../../data/models/trip_enums.dart';
import '../../data/models/trip_related_models.dart';
import '../../provider/trips_provider.dart';
import '../data/models/trip_invite_friends_models.dart';
import '../provider/trip_invite_friends_provider.dart';
import '../utils/trip_invite_friends_formatters.dart';
import 'trip_invite_friends_view.dart';

class TripInviteFriendsState {
  const TripInviteFriendsState({
    required this.candidates,
    this.tripTravelPersona,
    this.filter = TripInviteFriendsFilter.all,
    this.selectedById = const {},
    this.query = '',
    this.searchResults,
    this.hasMoreSearchResults = false,
    this.isSearching = false,
    this.isSending = false,
    this.cancellingInviteeId,
    this.actionError,
  });

  final List<TripInviteCandidate> candidates;

  /// Travel DNA this trip leans toward. Null when the trip has nothing to compare.
  final String? tripTravelPersona;
  final TripInviteFriendsFilter filter;
  final Map<String, TripInviteCandidate> selectedById;
  final String query;

  /// Null while the friends list is showing. Empty list is a finished search.
  final List<TripInviteCandidate>? searchResults;
  final bool hasMoreSearchResults;
  final bool isSearching;
  final bool isSending;

  /// Invitee whose pending invitation is being cancelled, if any.
  final String? cancellingInviteeId;
  final Object? actionError;

  TripInviteFriendsState copyWith({
    List<TripInviteCandidate>? candidates,
    String? tripTravelPersona,
    bool updateTripPersona = false,
    TripInviteFriendsFilter? filter,
    Map<String, TripInviteCandidate>? selectedById,
    String? query,
    List<TripInviteCandidate>? searchResults,
    bool clearSearch = false,
    bool? hasMoreSearchResults,
    bool? isSearching,
    bool? isSending,
    String? cancellingInviteeId,
    bool clearCancelling = false,
    Object? actionError,
    bool clearActionError = false,
  }) => TripInviteFriendsState(
    candidates: candidates ?? this.candidates,
    tripTravelPersona: updateTripPersona
        ? tripTravelPersona
        : this.tripTravelPersona,
    filter: filter ?? this.filter,
    selectedById: selectedById ?? this.selectedById,
    query: query ?? this.query,
    searchResults: clearSearch ? null : searchResults ?? this.searchResults,
    hasMoreSearchResults: clearSearch
        ? false
        : hasMoreSearchResults ?? this.hasMoreSearchResults,
    isSearching: isSearching ?? this.isSearching,
    isSending: isSending ?? this.isSending,
    cancellingInviteeId: clearCancelling
        ? null
        : cancellingInviteeId ?? this.cancellingInviteeId,
    actionError: clearActionError ? null : actionError ?? this.actionError,
  );
}

class TripInviteFriendsSendResult {
  const TripInviteFriendsSendResult({
    required this.sentCount,
    required this.failedCount,
  });

  final int sentCount;
  final int failedCount;

  bool get hasFailure => failedCount > 0;
}

/// No automatic retry: 403 never recovers, and the screen retries manually.
final tripInviteFriendsControllerProvider = AsyncNotifierProvider.autoDispose
    .family<TripInviteFriendsController, TripInviteFriendsState, String>(
      TripInviteFriendsController.new,
      retry: (_, _) => null,
    );

class TripInviteFriendsController
    extends AsyncNotifier<TripInviteFriendsState> {
  TripInviteFriendsController(this.tripId);

  final String tripId;

  Timer? _searchTimer;
  int _searchGeneration = 0;

  @override
  Future<TripInviteFriendsState> build() {
    ref.onDispose(() => _searchTimer?.cancel());
    return _load();
  }

  Future<void> refresh() async {
    final previous = state.value;
    if (previous == null || previous.isSending) return;
    try {
      final page = await ref
          .read(tripInviteFriendsRepositoryProvider)
          .getCandidates(tripId);
      final latest = state.value ?? previous;
      state = AsyncData(
        latest.copyWith(
          candidates: page.candidates,
          tripTravelPersona: page.tripTravelPersona,
          updateTripPersona: true,
          selectedById: _syncSelection(page.candidates, latest.selectedById),
          clearActionError: true,
        ),
      );
      final query = latest.query.trim();
      if (query.isNotEmpty) await _runSearch(query);
    } catch (error, stackTrace) {
      final latest = state.value;
      if (latest != null) {
        state = AsyncData(latest.copyWith(actionError: error));
      } else {
        state = AsyncError(error, stackTrace);
      }
    }
  }

  void setFilter(TripInviteFriendsFilter filter) {
    final current = state.value;
    if (current == null || current.filter == filter) return;
    state = AsyncData(current.copyWith(filter: filter, clearActionError: true));
  }

  void setQuery(String query) {
    final current = state.value;
    if (current == null) return;
    _searchTimer?.cancel();
    final trimmed = query.trim();
    if (trimmed.isEmpty) {
      _searchGeneration++;
      state = AsyncData(
        current.copyWith(
          query: query,
          clearSearch: true,
          isSearching: false,
          clearActionError: true,
        ),
      );
      return;
    }
    state = AsyncData(
      current.copyWith(query: query, isSearching: true, clearActionError: true),
    );
    final generation = ++_searchGeneration;
    _searchTimer = Timer(const Duration(milliseconds: 350), () {
      unawaited(_runSearch(trimmed, generation: generation));
    });
  }

  void toggle(TripInviteCandidate person, {required int openSlots}) {
    final current = state.value;
    if (current == null || current.isSending || !person.canInvite) return;
    final selected = Map<String, TripInviteCandidate>.of(current.selectedById);
    if (selected.containsKey(person.user.id)) {
      selected.remove(person.user.id);
      state = AsyncData(
        current.copyWith(selectedById: selected, clearActionError: true),
      );
      return;
    }
    if (selected.length >= openSlots) {
      state = AsyncData(
        current.copyWith(
          actionError: const TripInviteFriendsBlockedException(
            TripInviteFriendsBlock.full,
          ),
        ),
      );
      return;
    }
    selected[person.user.id] = person;
    state = AsyncData(
      current.copyWith(selectedById: selected, clearActionError: true),
    );
  }

  void clearSelection() {
    final current = state.value;
    if (current == null || current.isSending || current.selectedById.isEmpty) {
      return;
    }
    state = AsyncData(
      current.copyWith(selectedById: const {}, clearActionError: true),
    );
  }

  /// Cancels a pending invitation for [inviteeId] via sent-invitations lookup.
  Future<bool> cancelPending(String inviteeId) async {
    final current = state.value;
    if (current == null ||
        current.isSending ||
        current.cancellingInviteeId != null) {
      return false;
    }
    final pending = current.candidates.any(
      (person) =>
          person.user.id == inviteeId &&
          person.invitationStatus == TripInviteStatus.pending,
    );
    if (!pending) return false;

    state = AsyncData(
      current.copyWith(
        cancellingInviteeId: inviteeId,
        clearActionError: true,
      ),
    );
    try {
      final sent = await ref
          .read(tripRepositoryProvider)
          .getSentInvitations(tripId, limit: 100);
      TripInvitation? invitation;
      for (final item in sent.items) {
        if (item.inviteeId == inviteeId &&
            item.status == TripInvitationStatus.pending) {
          invitation = item;
          break;
        }
      }
      if (invitation == null) {
        throw const ApiException(
          message: 'Không tìm thấy lời mời đang chờ để hủy.',
        );
      }
      await ref
          .read(tripRepositoryProvider)
          .cancelInvitation(tripId, invitation.id);

      final page = await ref
          .read(tripInviteFriendsRepositoryProvider)
          .getCandidates(tripId);
      if (!ref.mounted) return true;
      final latest = state.value ?? current;
      state = AsyncData(
        latest.copyWith(
          candidates: page.candidates,
          tripTravelPersona: page.tripTravelPersona,
          updateTripPersona: true,
          clearCancelling: true,
          clearActionError: true,
          selectedById: _syncSelection(page.candidates, latest.selectedById),
        ),
      );
      return true;
    } catch (error) {
      if (!ref.mounted) return false;
      final latest = state.value ?? current;
      state = AsyncData(
        latest.copyWith(clearCancelling: true, actionError: error),
      );
      return false;
    }
  }

  Future<TripInviteFriendsSendResult?> send({
    required bool tripIsOpen,
    required int openSlots,
  }) async {
    final current = state.value;
    if (current == null || current.isSending || current.selectedById.isEmpty) {
      return null;
    }
    final block = _sendBlock(
      current,
      tripIsOpen: tripIsOpen,
      openSlots: openSlots,
    );
    if (block != null) {
      state = AsyncData(
        current.copyWith(actionError: TripInviteFriendsBlockedException(block)),
      );
      return null;
    }

    state = AsyncData(
      current.copyWith(isSending: true, clearActionError: true),
    );
    final repository = ref.read(tripInviteFriendsRepositoryProvider);
    var sent = 0;
    var failed = 0;
    Object? firstError;
    final sentIds = <String>{};
    for (final person in current.selectedById.values) {
      try {
        await repository.invite(tripId: tripId, inviteeId: person.user.id);
        sent++;
        sentIds.add(person.user.id);
      } catch (error) {
        if (_isAlreadyPending(error)) {
          sent++;
          sentIds.add(person.user.id);
          continue;
        }
        failed++;
        firstError ??= error;
      }
    }

    List<TripInviteCandidate> candidates;
    String? tripTravelPersona;
    var updateTripPersona = false;
    try {
      final page = await repository.getCandidates(tripId);
      candidates = page.candidates;
      tripTravelPersona = page.tripTravelPersona;
      updateTripPersona = true;
    } catch (_) {
      candidates = [
        for (final person in current.candidates)
          sentIds.contains(person.user.id)
              ? person.copyWith(invitationStatus: TripInviteStatus.pending)
              : person,
      ];
    }
    final remaining = Map<String, TripInviteCandidate>.of(current.selectedById)
      ..removeWhere((id, _) => sentIds.contains(id));
    if (!ref.mounted) {
      return TripInviteFriendsSendResult(sentCount: sent, failedCount: failed);
    }
    state = AsyncData(
      current.copyWith(
        candidates: candidates,
        tripTravelPersona: tripTravelPersona,
        updateTripPersona: updateTripPersona,
        selectedById: _syncSelection(candidates, remaining),
        isSending: false,
        actionError: firstError,
        clearActionError: failed == 0,
      ),
    );
    return TripInviteFriendsSendResult(sentCount: sent, failedCount: failed);
  }

  Future<TripInviteFriendsState> _load() async {
    final page = await ref
        .read(tripInviteFriendsRepositoryProvider)
        .getCandidates(tripId);
    return TripInviteFriendsState(
      candidates: page.candidates,
      tripTravelPersona: page.tripTravelPersona,
    );
  }

  Future<void> _runSearch(String query, {int? generation}) async {
    final token = generation ?? _searchGeneration;
    try {
      final page = await ref
          .read(tripInviteFriendsRepositoryProvider)
          .searchUsers(query);
      final current = state.value;
      if (!ref.mounted || current == null || token != _searchGeneration) return;
      if (current.query.trim() != query) return;
      state = AsyncData(
        current.copyWith(
          searchResults: [
            for (final user in page.users)
              candidateFromSearch(user, current.candidates),
          ],
          hasMoreSearchResults: page.hasNextPage,
          isSearching: false,
        ),
      );
    } catch (error) {
      final current = state.value;
      if (!ref.mounted || current == null || token != _searchGeneration) return;
      state = AsyncData(
        current.copyWith(
          isSearching: false,
          actionError: error,
          clearSearch: true,
        ),
      );
    }
  }

  TripInviteFriendsBlock? _sendBlock(
    TripInviteFriendsState current, {
    required bool tripIsOpen,
    required int openSlots,
  }) {
    if (!tripIsOpen) return TripInviteFriendsBlock.closed;
    if (openSlots <= 0) return TripInviteFriendsBlock.full;
    if (current.selectedById.length > openSlots) {
      return TripInviteFriendsBlock.overCapacity;
    }
    return null;
  }

  Map<String, TripInviteCandidate> _syncSelection(
    List<TripInviteCandidate> candidates,
    Map<String, TripInviteCandidate> selected,
  ) {
    final fresh = {for (final person in candidates) person.user.id: person};
    return {
      for (final entry in selected.entries)
        if (fresh[entry.key]?.canInvite ?? entry.value.canInvite)
          entry.key: fresh[entry.key] ?? entry.value,
    };
  }

  bool _isAlreadyPending(Object error) =>
      error is ApiException &&
      error.statusCode == 409 &&
      error.message.toLowerCase().contains('pending');
}
