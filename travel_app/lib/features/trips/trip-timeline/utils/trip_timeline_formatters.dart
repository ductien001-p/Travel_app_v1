import 'package:travel_frontend_v1/core/networks/api_exception.dart';

import '../application/trip_timeline_filter.dart';
import '../application/trip_timeline_view.dart';
import '../data/models/trip_timeline_models.dart';

/// `21 Tháng 7`, with the year when it differs from [now] (UTC).
String formatTimelineDate(DateTime value, {required DateTime now}) {
  final utc = value.toUtc();
  final label = '${utc.day} Tháng ${utc.month}';
  return utc.year == now.toUtc().year ? label : '$label, ${utc.year}';
}

/// `09:05` from wall-clock fields, without any time zone conversion.
String formatTimelineClock(DateTime wallClock) {
  String twoDigits(int value) => value.toString().padLeft(2, '0');
  return '${twoDigits(wallClock.hour)}:${twoDigits(wallClock.minute)}';
}

({String title, String? subtitle}) timelineDayLabel(
  TripTimelineDayGroup group, {
  required DateTime now,
}) {
  final date = formatTimelineDate(group.date, now: now);
  return switch (group.kind) {
    TripTimelineDayKind.today => (title: 'Hôm nay', subtitle: '($date)'),
    TripTimelineDayKind.yesterday => (title: 'Hôm qua', subtitle: '($date)'),
    TripTimelineDayKind.tripStart => (
      title: 'Khởi tạo chuyến đi',
      subtitle: '($date)',
    ),
    TripTimelineDayKind.other => (title: date, subtitle: null),
  };
}

/// `16.1182° N, 108.2789° E`.
String formatCoordinates(double latitude, double longitude) {
  final lat =
      '${latitude.abs().toStringAsFixed(4)}° ${latitude < 0 ? 'S' : 'N'}';
  final lng =
      '${longitude.abs().toStringAsFixed(4)}° ${longitude < 0 ? 'W' : 'E'}';
  return '$lat, $lng';
}

/// Lower-cases a sentence-case backend message so it reads after the actor's
/// name ("Alex đã check-in"). Words that are not plain sentence case, such as
/// acronyms, are kept as they are.
String timelineSentenceTail(String content) {
  final text = content.trim();
  if (text.isEmpty) return text;
  final firstWord = text.split(RegExp(r'\s+')).first;
  final rest = firstWord.substring(1);
  if (rest.isEmpty || rest != rest.toLowerCase()) return text;
  return '${text[0].toLowerCase()}${text.substring(1)}';
}

enum TimelineTextTone { plain, actor, strong, title, place }

typedef TimelineSentencePart = ({String text, TimelineTextTone tone});

/// "Alex đã check-in hoạt động "Ngắm bình minh" tại Bàn Cờ." built from the
/// metadata, falling back to the backend `content` when it is missing.
List<TimelineSentencePart> timelineSentence(TripTimelineEntry entry) {
  final actor = (text: entry.member.user.name, tone: TimelineTextTone.actor);
  final custom = _sentenceFromMetadata(entry);
  if (custom != null) return [actor, ...custom, _plain('.')];

  final meta = entry.metadata;
  final tail = timelineSentenceTail(entry.content);
  final title = _titleOf(entry.type, meta);
  final place = entry.type == TripTimelineEntryType.activityAdded
      ? null
      : meta?.placeName;
  final hasDetails = title != null || place != null;
  return [
    actor,
    _plain(' $tail'),
    if (title != null) (text: ' "$title"', tone: TimelineTextTone.title),
    if (place != null) ...[
      _plain(' tại '),
      (text: place, tone: TimelineTextTone.place),
    ],
    if (hasDetails || !_endsWithPunctuation.hasMatch(tail)) _plain('.'),
  ];
}

List<TimelineSentencePart>? _sentenceFromMetadata(TripTimelineEntry entry) {
  final meta = entry.metadata;
  if (meta == null) return null;
  switch (entry.type) {
    case TripTimelineEntryType.expenseSettled:
      if (entry.memberId == meta.debtorMemberId && meta.payerName != null) {
        return [_plain(' đã thanh toán cho '), _strong(meta.payerName!)];
      }
      if (entry.memberId == meta.payerMemberId && meta.debtorName != null) {
        return [
          _plain(' đã xác nhận nhận tiền từ '),
          _strong(meta.debtorName!),
        ];
      }
      return null;
    case TripTimelineEntryType.memberKicked when meta.targetName != null:
      return [
        _plain(' đã xóa '),
        _strong(meta.targetName!),
        _plain(' khỏi chuyến đi'),
      ];
    default:
      return null;
  }
}

String? _titleOf(TripTimelineEntryType type, TripTimelineEntryMetadata? meta) {
  if (meta == null) return null;
  final title = switch (type) {
    TripTimelineEntryType.activityAdded ||
    TripTimelineEntryType.activityUpdated ||
    TripTimelineEntryType.activityDeleted ||
    TripTimelineEntryType.activityCheckin => meta.activityTitle,
    TripTimelineEntryType.expenseCreated => meta.description,
    TripTimelineEntryType.memoryAdded => meta.caption,
    _ => null,
  };
  final trimmed = title?.trim();
  return trimmed == null || trimmed.isEmpty ? null : trimmed;
}

TimelineSentencePart _plain(String text) =>
    (text: text, tone: TimelineTextTone.plain);

TimelineSentencePart _strong(String text) =>
    (text: text, tone: TimelineTextTone.strong);

final _endsWithPunctuation = RegExp(r'[.!?…]$');

String? timelineJoinLabel(TripTimelineJoinVia? via) => switch (via) {
  TripTimelineJoinVia.inviteCode => 'Tham gia qua mã mời',
  TripTimelineJoinVia.invitation => 'Tham gia qua lời mời',
  TripTimelineJoinVia.joinRequest => 'Tham gia qua yêu cầu được duyệt',
  null => null,
};

bool isTripTimelineForbidden(Object error) =>
    error is ApiException && error.statusCode == 403;

String tripTimelineErrorMessage(Object error) {
  if (error is! ApiException) return 'Đã xảy ra lỗi. Vui lòng thử lại.';
  return switch (error.statusCode) {
    null => 'Không thể kết nối máy chủ. Kiểm tra mạng và thử lại.',
    401 => 'Phiên đăng nhập đã hết hạn. Vui lòng đăng nhập lại.',
    403 => 'Chỉ thành viên chuyến đi mới xem được dòng thời gian.',
    404 => 'Chuyến đi không tồn tại hoặc đã bị xóa.',
    _ => 'Không thể tải dòng thời gian. Vui lòng thử lại.',
  };
}

extension TripTimelineFilterLabel on TripTimelineFilter {
  String get label => switch (this) {
    TripTimelineFilter.all => 'Tất cả',
    TripTimelineFilter.checkin => 'Check-in',
    TripTimelineFilter.expense => 'Chi tiêu',
    TripTimelineFilter.memory => 'Kỷ niệm & Ảnh',
    TripTimelineFilter.member => 'Thành viên',
  };
}

extension TripTimelineEntryTypeLabel on TripTimelineEntryType {
  String get badge => switch (this) {
    TripTimelineEntryType.tripCreated => 'KHỞI TẠO',
    TripTimelineEntryType.memberJoined => 'THÀNH VIÊN MỚI',
    TripTimelineEntryType.memberLeft => 'RỜI NHÓM',
    TripTimelineEntryType.memberKicked => 'XÓA THÀNH VIÊN',
    TripTimelineEntryType.activityAdded => 'THÊM HOẠT ĐỘNG',
    TripTimelineEntryType.activityUpdated => 'CẬP NHẬT LỊCH',
    TripTimelineEntryType.activityDeleted => 'XÓA HOẠT ĐỘNG',
    TripTimelineEntryType.activityCheckin => 'CHECK-IN',
    TripTimelineEntryType.expenseCreated => 'KHOẢN CHI MỚI',
    TripTimelineEntryType.expenseSettled => 'ĐÃ THANH TOÁN',
    TripTimelineEntryType.photoAdded => 'ẢNH MỚI',
    TripTimelineEntryType.memoryAdded => 'KỶ NIỆM MỚI',
    TripTimelineEntryType.memoryDeleted => 'XÓA KỶ NIỆM',
    TripTimelineEntryType.system => 'HỆ THỐNG',
  };
}
