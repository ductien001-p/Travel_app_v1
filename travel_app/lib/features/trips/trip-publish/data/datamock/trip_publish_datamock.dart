import '../models/trip_publish_models.dart';

/// Screen fixture for the publish sheet tests.
///
/// TODO(backend): API demo — thay bằng endpoint thật khi backend xong
RecruitmentMine publishSheetMine() {
  return RecruitmentMine(
    activeRecruitmentCount: 1,
    latestPublishDraft: PublishDraft(
      tripId: 'draft-1',
      name: 'Nháp Đà Lạt',
      description: 'Bản nháp đăng cộng đồng còn dở.',
      draftStep: 2,
      startDate: DateTime.utc(2026, 12, 20),
      endDate: DateTime.utc(2026, 12, 23),
      maxMembers: 4,
      budgetLevel: 'MEDIUM',
      updatedAt: DateTime.utc(2026, 10, 20),
    ),
    trips: [
      RecruitmentMineTrip(
        tripId: 'trip-open',
        name: 'Hội An cuối tuần',
        startDate: DateTime.utc(2026, 12, 1),
        endDate: DateTime.utc(2026, 12, 4),
        maxMembers: 6,
        memberCount: 4,
        pendingRequestCount: 2,
        slotsRemaining: 2,
        estimatedBudgetPerPerson: '2400000',
        effectiveState: RecruitmentState.open,
        canPublish: false,
        destinationLabels: const ['Hội An'],
        expiresAt: DateTime.utc(2026, 11, 30),
      ),
      RecruitmentMineTrip(
        tripId: 'trip-new',
        name: 'Tà Xùa săn mây',
        description: 'Mô tả đủ dài để đăng chuyến lên cộng đồng.',
        startDate: DateTime.utc(2026, 12, 15),
        endDate: DateTime.utc(2026, 12, 18),
        maxMembers: 5,
        memberCount: 1,
        pendingRequestCount: 0,
        slotsRemaining: 4,
        effectiveState: RecruitmentState.notPublished,
        canPublish: true,
        destinationLabels: const ['Sơn La'],
      ),
    ],
  );
}
