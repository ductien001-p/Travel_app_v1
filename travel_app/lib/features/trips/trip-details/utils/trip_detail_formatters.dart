import 'package:flutter/widgets.dart' show StringCharacters;
import 'package:travel_frontend_v1/core/networks/api_exception.dart';

import '../data/models/trip_detail_models.dart';

const _vndSymbol = 'đ';

String formatTripMoney(double amount, {String currency = 'VND'}) {
  final rounded = amount.round();
  final digits = rounded.abs().toString();
  final grouped = StringBuffer();
  for (var i = 0; i < digits.length; i++) {
    if (i > 0 && (digits.length - i) % 3 == 0) grouped.write('.');
    grouped.write(digits[i]);
  }
  final sign = rounded < 0 ? '-' : '';
  return currency == 'VND'
      ? '$sign$grouped$_vndSymbol'
      : '$sign$grouped $currency';
}

// Trip dates and activity times are a UTC wall clock across the whole app.
String formatDayMonth(DateTime value) {
  final utc = value.toUtc();
  return '${_twoDigits(utc.day)}/${_twoDigits(utc.month)}';
}

String formatClock(DateTime value) {
  final utc = value.toUtc();
  return '${_twoDigits(utc.hour)}:${_twoDigits(utc.minute)}';
}

String formatDateRange(DateTime start, DateTime end) =>
    '${formatDayMonth(start)} - ${formatDayMonth(end)}';

/// `15 - 18/07` within one month, otherwise `30/07 - 02/08`.
String formatShortDateRange(DateTime start, DateTime end) {
  final utcStart = start.toUtc();
  final utcEnd = end.toUtc();
  if (utcStart.month == utcEnd.month && utcStart.year == utcEnd.year) {
    return '${_twoDigits(utcStart.day)} - ${formatDayMonth(utcEnd)}';
  }
  return formatDateRange(utcStart, utcEnd);
}

String formatTripDuration(DateTime start, DateTime end) {
  final days = _dateOnly(end).difference(_dateOnly(start)).inDays + 1;
  if (days <= 1) return '1 ngày';
  return '$days ngày ${days - 1} đêm';
}

String formatActivityTime(DateTime value, {required DateTime now}) {
  final clock = formatClock(value);
  return switch (_dayOffset(value, now)) {
    0 => '$clock Hôm nay',
    1 => '$clock Ngày mai',
    _ => '$clock • ${formatDayMonth(value)}',
  };
}

String formatTimelineTime(DateTime value, {required DateTime now}) {
  return switch (_dayOffset(value, now)) {
    0 => formatClock(value),
    -1 => 'Hôm qua',
    _ => formatDayMonth(value),
  };
}

String initialsOf(String name) {
  final words = name.trim().split(RegExp(r'\s+')).where((w) => w.isNotEmpty);
  if (words.isEmpty) return '?';
  final first = words.first.characters.first;
  if (words.length == 1) return first.toUpperCase();
  return '$first${words.last.characters.first}'.toUpperCase();
}

String tripDetailErrorMessage(Object error) {
  if (error is ApiException) {
    return switch (error.statusCode) {
      403 => 'Bạn không có quyền xem chuyến đi này.',
      404 => 'Chuyến đi không tồn tại hoặc đã bị xóa.',
      _ => error.message,
    };
  }
  return 'Đã xảy ra lỗi. Vui lòng thử lại.';
}

extension TripDetailStatusLabel on TripDetailStatus {
  String get label => switch (this) {
    TripDetailStatus.draft => 'BẢN NHÁP',
    TripDetailStatus.upcoming => 'SẮP DIỄN RA',
    TripDetailStatus.ongoing => 'ĐANG DIỄN RA',
    TripDetailStatus.completed => 'ĐÃ HOÀN THÀNH',
    TripDetailStatus.cancelled => 'ĐÃ HỦY',
    TripDetailStatus.notCompleted => 'CHƯA HOÀN THÀNH',
  };
}

extension TripDetailVisibilityLabel on TripDetailVisibility {
  String get label => switch (this) {
    TripDetailVisibility.public => 'CÔNG KHAI',
    TripDetailVisibility.private => 'RIÊNG TƯ',
  };
}

extension TripDetailTypeLabel on TripDetailType {
  String get label => switch (this) {
    TripDetailType.solo => 'MỘT MÌNH',
    TripDetailType.couple => 'CẶP ĐÔI',
    TripDetailType.family => 'GIA ĐÌNH',
    TripDetailType.friends => 'BẠN BÈ',
    TripDetailType.backpacker => 'PHƯỢT',
    TripDetailType.other => 'KHÁC',
  };
}

extension TripDetailBudgetLevelLabel on TripDetailBudgetLevel {
  String get label => switch (this) {
    TripDetailBudgetLevel.low => 'Tiết kiệm',
    TripDetailBudgetLevel.medium => 'Tiêu chuẩn',
    TripDetailBudgetLevel.high => 'Cao cấp',
  };
}

extension TripDetailMemberRoleLabel on TripDetailMemberRole {
  String get label => switch (this) {
    TripDetailMemberRole.owner => 'Trưởng nhóm',
    TripDetailMemberRole.admin => 'Quản trị viên',
    TripDetailMemberRole.member => 'Thành viên',
  };
}

extension TripDetailEventTypeLabel on TripDetailEventType {
  String get verb => switch (this) {
    TripDetailEventType.tripCreated => 'đã tạo chuyến đi',
    TripDetailEventType.memberJoined => 'gia nhập nhóm',
    TripDetailEventType.memberLeft => 'rời nhóm',
    TripDetailEventType.memberKicked => 'đã mời một thành viên rời nhóm',
    TripDetailEventType.activityAdded => 'thêm hoạt động',
    TripDetailEventType.activityUpdated => 'sửa hoạt động',
    TripDetailEventType.activityDeleted => 'xóa hoạt động',
    TripDetailEventType.activityCheckin => 'đã check-in',
    TripDetailEventType.expenseCreated => 'thêm khoản chi',
    TripDetailEventType.expenseSettled => 'thanh toán khoản chi',
    TripDetailEventType.photoAdded => 'đã đăng ảnh',
    TripDetailEventType.memoryAdded => 'đã đăng kỷ niệm',
    TripDetailEventType.memoryDeleted => 'xóa kỷ niệm',
    TripDetailEventType.system => 'cập nhật',
  };
}

String _twoDigits(int value) => value.toString().padLeft(2, '0');

DateTime _dateOnly(DateTime value) {
  final utc = value.toUtc();
  return DateTime.utc(utc.year, utc.month, utc.day);
}

int _dayOffset(DateTime value, DateTime now) =>
    _dateOnly(value).difference(_dateOnly(now)).inDays;
