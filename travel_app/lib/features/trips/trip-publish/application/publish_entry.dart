import '../data/models/trip_publish_models.dart';

/// Banner label. A failed summary falls back and still leaves the button usable.
String publishBannerLabel({int? activeCount, bool summaryFailed = false}) {
  if (summaryFailed || activeCount == null) return 'Đăng chuyến đi';
  if (activeCount > 0) return 'Quản lý bài đăng';
  return 'Đăng chuyến đi';
}

/// Display name and avatar are required. Phone is not.
bool publishProfileReady({
  String? displayName,
  String? avatarUrl,
  String? avatarId,
}) {
  final name = displayName?.trim() ?? '';
  final hasAvatar =
      (avatarUrl?.trim().isNotEmpty ?? false) ||
      (avatarId?.trim().isNotEmpty ?? false);
  return name.isNotEmpty && hasAvatar;
}

sealed class PublishEntryDecision {
  const PublishEntryDecision();
}

class PublishEntrySheet extends PublishEntryDecision {
  const PublishEntrySheet(this.mine);
  final RecruitmentMine mine;
}

class PublishEntryAskDraft extends PublishEntryDecision {
  const PublishEntryAskDraft(this.draft);
  final PublishDraft draft;
}

class PublishEntryCreateTrip extends PublishEntryDecision {
  const PublishEntryCreateTrip();
}

/// Upcoming trips open the sheet. A lone draft asks to resume in create-trip.
PublishEntryDecision decidePublishEntry(RecruitmentMine mine) {
  if (mine.trips.isNotEmpty) return PublishEntrySheet(mine);
  final draft = mine.latestPublishDraft;
  if (draft != null) return PublishEntryAskDraft(draft);
  return const PublishEntryCreateTrip();
}

String recruitmentStateLabel(RecruitmentState state) => switch (state) {
  RecruitmentState.notPublished => 'Chưa đăng',
  RecruitmentState.open => 'Đang tuyển',
  RecruitmentState.full => 'Đã đủ người',
  RecruitmentState.closed => 'Đã đóng tuyển',
};

/// Đăng and Quản lý both open the manage screen.
String publishMineActionLabel(RecruitmentState state) =>
    state == RecruitmentState.notPublished ? 'Đăng' : 'Quản lý';

String recruitmentBlockerLabel(String code) => switch (code) {
  'START_TOO_SOON' => 'Khởi hành cần cách hiện tại ít nhất 48 giờ.',
  'ACTIVE_LIMIT_REACHED' => 'Bạn đã có 3 bài đang tuyển.',
  'NO_OPEN_SLOT' => 'Chuyến không còn chỗ trống.',
  'DESCRIPTION_TOO_SHORT' => 'Mô tả cần ít nhất 20 ký tự.',
  'COVER_REQUIRED' => 'Cần ảnh bìa trước khi đăng.',
  _ => code,
};

/// Local wall time plus the device UTC offset. The word UTC is not used alone.
String formatRecruitmentInstant(DateTime instant) {
  final local = instant.toLocal();
  final offset = local.timeZoneOffset;
  final sign = offset.isNegative ? '-' : '+';
  final hours = offset.inHours.abs().toString().padLeft(2, '0');
  final minutes = (offset.inMinutes.abs() % 60).toString().padLeft(2, '0');
  final hour = local.hour.toString().padLeft(2, '0');
  final minute = local.minute.toString().padLeft(2, '0');
  final day = local.day.toString().padLeft(2, '0');
  final month = local.month.toString().padLeft(2, '0');
  return '$hour:$minute, $day/$month/${local.year} (UTC$sign$hours:$minutes)';
}

DateTime recruitmentExpiresAt(DateTime startDate) =>
    startDate.toUtc().subtract(const Duration(hours: 24));
