import '../models/activity_draft_model.dart';

abstract class ActivityDraftLocalDataSource {
  Future<ActivityDraftModel?> getDraft({
    required String tripId,
    required String dayId,
  });

  Future<void> saveDraft(ActivityDraftModel draft);

  Future<void> deleteDraft({required String tripId, required String dayId});
}

class InMemoryActivityDraftLocalDataSource
    implements ActivityDraftLocalDataSource {
  static final Map<String, ActivityDraftModel> _draftStore = {};

  String _buildKey(String tripId, String dayId) =>
      'activity_draft:$tripId:$dayId';

  @override
  Future<ActivityDraftModel?> getDraft({
    required String tripId,
    required String dayId,
  }) async {
    return _draftStore[_buildKey(tripId, dayId)];
  }

  @override
  Future<void> saveDraft(ActivityDraftModel draft) async {
    _draftStore[_buildKey(draft.tripId, draft.dayId)] = draft;
  }

  @override
  Future<void> deleteDraft({
    required String tripId,
    required String dayId,
  }) async {
    _draftStore.remove(_buildKey(tripId, dayId));
  }
}
