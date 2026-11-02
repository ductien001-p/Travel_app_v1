import 'package:travel_frontend_v1/core/networks/api_exception.dart';
import 'package:travel_frontend_v1/features/media/data/repository/media_upload_exception.dart';

import '../application/trip_memories_view.dart';

String _twoDigits(int value) => value.toString().padLeft(2, '0');

/// `20/07/2025` from calendar fields, without any time zone conversion.
String formatMemoryDate(DateTime date) =>
    '${_twoDigits(date.day)}/${_twoDigits(date.month)}/${date.year}';

/// `05:45` from wall-clock fields, without any time zone conversion.
String formatMemoryClock(DateTime wallClock) =>
    '${_twoDigits(wallClock.hour)}:${_twoDigits(wallClock.minute)}';

/// `Ngày 1: Đà Nẵng`, or the date for photos posted outside the trip.
String memoryGroupTitle(TripMemoryDayGroup group) {
  final day = group.day;
  if (day == null) return formatMemoryDate(group.date);
  final place = group.place;
  return place == null ? 'Ngày $day' : 'Ngày $day: $place';
}

/// `Ngày 1 - Đà Nẵng (18)`.
String memoryDayChipLabel(TripMemoryDayOption option) {
  final place = option.place;
  final label = place == null
      ? 'Ngày ${option.day}'
      : 'Ngày ${option.day} - $place';
  final count = option.count;
  return count == null ? label : '$label ($count)';
}

String memoryCountLabel(int count) => '$count khoảnh khắc';

String withCount(String label, int? count) =>
    count == null ? label : '$label ($count)';

bool isTripMemoriesForbidden(Object error) =>
    error is ApiException && error.statusCode == 403;

String tripMemoriesErrorMessage(Object error) {
  if (error is! ApiException) return 'Đã xảy ra lỗi. Vui lòng thử lại.';
  return switch (error.statusCode) {
    null => 'Không thể kết nối máy chủ. Kiểm tra mạng và thử lại.',
    401 => 'Phiên đăng nhập đã hết hạn. Vui lòng đăng nhập lại.',
    403 => 'Chỉ thành viên chuyến đi mới xem được album kỷ niệm.',
    404 => 'Chuyến đi không tồn tại hoặc đã bị xóa.',
    _ => 'Không thể tải kỷ niệm. Vui lòng thử lại.',
  };
}

/// A filtered request the backend rejects (400): a day outside the trip or a
/// stale cursor.
String tripMemoriesFilterErrorMessage(Object error) {
  if (error is ApiException && error.statusCode == 400) {
    return 'Không áp dụng được bộ lọc này. Hãy xem tất cả kỷ niệm.';
  }
  return tripMemoriesErrorMessage(error);
}

String tripMemoriesUploadErrorMessage(Object error) {
  final cause = error is MediaUploadException ? error.cause : error;
  if (error is MediaUploadException && cause is! ApiException) {
    return 'Không thể tải ảnh lên. Kiểm tra mạng và thử lại.';
  }
  if (cause is! ApiException) return 'Không thể đăng ảnh. Vui lòng thử lại.';
  return switch (cause.statusCode) {
    null => 'Không thể kết nối máy chủ. Kiểm tra mạng và thử lại.',
    400 => 'Ảnh không hợp lệ hoặc đã có trong album.',
    403 => 'Chỉ thành viên chuyến đi mới đăng được kỷ niệm.',
    409 => 'Chuyến đi này chưa thể thêm kỷ niệm.',
    _ => 'Không thể đăng ảnh. Vui lòng thử lại.',
  };
}

String tripMemoryDeleteErrorMessage(Object error) {
  if (error is! ApiException) return 'Không thể xóa ảnh. Vui lòng thử lại.';
  return switch (error.statusCode) {
    403 => 'Bạn chỉ có thể xóa ảnh do mình đăng.',
    404 => 'Ảnh này đã bị xóa.',
    _ => 'Không thể xóa ảnh. Vui lòng thử lại.',
  };
}

String tripMemoryUpdateErrorMessage(Object error) {
  if (error is! ApiException) {
    return 'Không thể cập nhật mô tả. Vui lòng thử lại.';
  }
  return switch (error.statusCode) {
    400 => 'Mô tả không hợp lệ.',
    403 => 'Bạn chỉ có thể sửa mô tả ảnh do mình đăng.',
    404 => 'Ảnh này đã bị xóa.',
    _ => 'Không thể cập nhật mô tả. Vui lòng thử lại.',
  };
}
