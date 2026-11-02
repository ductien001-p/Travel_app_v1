import 'package:travel_frontend_v1/core/networks/api_exception.dart';

import '../data/datamock/trip_join_by_code_datamock.dart';
import '../data/models/trip_join_request_models.dart';

final _nonAlphanumeric = RegExp(r'[^A-Za-z0-9]');

/// Bỏ khoảng trắng / gạch ngang rồi viết hoa — khớp mã backend sinh ra.
String normalizeInviteCode(String raw) =>
    raw.replaceAll(_nonAlphanumeric, '').toUpperCase();

bool isInviteCodeComplete(String normalized) =>
    normalized.length == tripInviteCodeLength;

String inviteCodeNightDayLabel(DateTime start, DateTime end) {
  final days = end.difference(start).inDays + 1;
  final nights = days > 0 ? days - 1 : 0;
  return '${_two(start.day)}/${_two(start.month)}/${start.year} – '
      '${_two(end.day)}/${_two(end.month)}/${end.year} '
      '($days'
      'N$nights'
      'Đ)';
}

String inviteMatchLabel(int score) => '$score% Tương thích';

String joinByCodeSuccessMessage(TripJoinRequest request) =>
    switch (request.status) {
      TripJoinRequestStatus.approved =>
        'Bạn đã tham gia chuyến đi. Chào mừng bạn vào nhóm!',
      TripJoinRequestStatus.pending =>
        'Đã gửi yêu cầu. Trưởng nhóm sẽ xem xét sớm.',
      TripJoinRequestStatus.rejected =>
        'Yêu cầu chưa được chấp nhận. Thử mã khác hoặc liên hệ trưởng nhóm.',
    };

String joinByCodeErrorMessage(Object error) {
  if (error is ArgumentError) {
    return 'Vui lòng nhập đủ mã mời hợp lệ.';
  }
  if (error is! ApiException) {
    return 'Không thể gửi yêu cầu. Vui lòng thử lại.';
  }
  return switch (error.statusCode) {
    null => 'Không thể kết nối máy chủ. Kiểm tra mạng và thử lại.',
    400 =>
      error.message.isNotEmpty
          ? error.message
          : 'Mã mời hoặc lời nhắn không hợp lệ.',
    401 => 'Phiên đăng nhập đã hết hạn. Vui lòng đăng nhập lại.',
    403 => 'Bạn không thể tham gia chuyến đi này.',
    404 => 'Mã mời không hợp lệ hoặc chuyến đi không còn tồn tại.',
    409 => _joinConflictMessage(error.message),
    _ => 'Không thể gửi yêu cầu. Vui lòng thử lại.',
  };
}

String joinByCodePreviewErrorMessage(Object error) {
  if (error is! ApiException) {
    return 'Không thể xem trước chuyến đi.';
  }
  return switch (error.statusCode) {
    null => 'Không thể kết nối máy chủ. Kiểm tra mạng và thử lại.',
    404 => 'Mã mời không hợp lệ.',
    _ => 'Không thể xem trước chuyến đi.',
  };
}

String _joinConflictMessage(String message) {
  final normalized = message.trim().toLowerCase();
  if (normalized.contains('not open for joining')) {
    return 'Chuyến đi chưa mở để nhận thành viên mới.';
  }
  if (normalized.contains('already a member')) {
    return 'Bạn đã là thành viên của chuyến đi này.';
  }
  if (normalized.contains('already pending')) {
    return 'Bạn đã gửi yêu cầu và đang chờ trưởng nhóm duyệt.';
  }
  if (normalized.contains('full')) {
    return 'Nhóm đã đủ thành viên.';
  }
  if (message.isNotEmpty) return message;
  return 'Yêu cầu đã tồn tại hoặc nhóm đã đủ thành viên.';
}

String _two(int value) => value.toString().padLeft(2, '0');
