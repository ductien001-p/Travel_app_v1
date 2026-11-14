import 'package:travel_frontend_v1/core/networks/api_exception.dart';

import '../../trip-details/utils/trip_detail_formatters.dart';
import '../application/trip_join_requests_header.dart';
import '../data/models/trip_join_request_models.dart';

String _twoDigits(int value) => value.toString().padLeft(2, '0');

/// `15 phút trước`, `Hôm qua`, then the UTC date like the rest of the app.
String formatJoinRequestAge(DateTime time, {required DateTime now}) {
  final age = now.difference(time);
  if (age.inMinutes < 1) return 'Vừa xong';
  if (age.inHours < 1) return '${age.inMinutes} phút trước';
  if (age.inDays < 1) return '${age.inHours} giờ trước';
  if (age.inDays == 1) return 'Hôm qua';
  if (age.inDays < 7) return '${age.inDays} ngày trước';
  final utc = time.toUtc();
  return '${_twoDigits(utc.day)}/${_twoDigits(utc.month)}/${utc.year}';
}

bool isRecentJoinRequest(DateTime time, {required DateTime now}) =>
    now.difference(time).inDays < 1;

String joinRequestStatusLabel(TripJoinRequestStatus status) => switch (status) {
  TripJoinRequestStatus.pending => 'Chờ duyệt',
  TripJoinRequestStatus.approved => 'Đã duyệt',
  TripJoinRequestStatus.rejected => 'Đã từ chối',
};

String joinRequestTabLabel(TripJoinRequestStatus status, int? count) {
  final label = joinRequestStatusLabel(status);
  return count == null ? label : '$label ($count)';
}

String joinRequestMatchLabel(int score) => '$score% Hợp gu';

/// `Trưởng nhóm • Quyền quản trị`.
String joinRequestReviewerLabel(TripJoinRequestsHeader header) {
  final role = header.viewerRole;
  return role == null ? 'Quyền quản trị' : '${role.label} • Quyền quản trị';
}

String joinRequestTripTypeLabel(TripJoinRequestsHeader header) =>
    'CHUYẾN ĐI ${header.tripType.label}';

String joinRequestCapacityLabel(TripJoinRequestsHeader header) =>
    '${header.memberCount} / ${header.maxMembers} thành viên';

String joinRequestRemainingLabel(TripJoinRequestsHeader header) =>
    header.isFull ? '(Đã đủ)' : '(Còn ${header.remainingSlots} suất)';

/// Warning shown above the requests when seats are about to run out.
String? joinRequestQuotaWarning(TripJoinRequestsHeader header) {
  if (!header.canReview) return null;
  final full = '${header.maxMembers}/${header.maxMembers}';
  if (!header.isOpen) {
    return 'Chuyến đi không còn nhận thành viên mới nên chưa thể duyệt '
        'yêu cầu.';
  }
  if (header.isFull) {
    return 'Nhóm đã đủ quân số ($full). Hãy rà soát thành viên trước khi '
        'duyệt thêm yêu cầu.';
  }
  if (header.remainingSlots == 1) {
    return 'Chuyến đi chỉ còn đúng 1 vị trí trống. Khi bạn đồng ý 1 thành '
        'viên, nhóm sẽ đủ quân số ($full) và không thể duyệt thêm yêu cầu.';
  }
  return null;
}

String joinRequestInviteShareMessage(String tripName, String inviteCode) =>
    'Tham gia chuyến đi "$tripName" cùng mình trên Travel Social!\n'
    'Mã mời: $inviteCode';

String joinRequestDecisionMessage(TripJoinRequest reviewed) =>
    switch (reviewed.status) {
      TripJoinRequestStatus.approved =>
        'Đã thêm ${reviewed.requester.displayName} vào nhóm.',
      TripJoinRequestStatus.rejected =>
        'Đã từ chối yêu cầu của ${reviewed.requester.displayName}.',
      TripJoinRequestStatus.pending => 'Yêu cầu vẫn đang chờ duyệt.',
    };

bool isTripJoinRequestsForbidden(Object error) =>
    error is ApiException && error.statusCode == 403;

String tripJoinRequestsErrorMessage(Object error) {
  if (error is! ApiException) return 'Đã xảy ra lỗi. Vui lòng thử lại.';
  return switch (error.statusCode) {
    null => 'Không thể kết nối máy chủ. Kiểm tra mạng và thử lại.',
    401 => 'Phiên đăng nhập đã hết hạn. Vui lòng đăng nhập lại.',
    403 => 'Chỉ trưởng nhóm hoặc quản trị viên mới duyệt được yêu cầu.',
    404 => 'Chuyến đi không tồn tại hoặc đã bị xóa.',
    _ => 'Không thể tải yêu cầu tham gia. Vui lòng thử lại.',
  };
}

String tripJoinDecisionErrorMessage(Object error) {
  if (error is TripJoinApprovalBlockedException) {
    return switch (error.block) {
      TripJoinApprovalBlock.full =>
        'Nhóm đã đủ thành viên. Hãy rà soát thành viên trước khi duyệt thêm.',
      TripJoinApprovalBlock.closed =>
        'Chuyến đi không còn nhận thành viên mới.',
      TripJoinApprovalBlock.notReviewer =>
        'Chỉ trưởng nhóm hoặc quản trị viên mới duyệt được yêu cầu.',
    };
  }
  if (error is! ApiException) return 'Không thể xử lý yêu cầu. Thử lại sau.';
  return switch (error.statusCode) {
    null => 'Không thể kết nối máy chủ. Kiểm tra mạng và thử lại.',
    403 => 'Chỉ trưởng nhóm hoặc quản trị viên mới duyệt được yêu cầu.',
    404 => 'Yêu cầu này không còn tồn tại.',
    409 => 'Yêu cầu đã được xử lý hoặc nhóm đã đủ thành viên.',
    _ => 'Không thể xử lý yêu cầu. Thử lại sau.',
  };
}

String tripJoinSettingsErrorMessage(Object error) {
  if (error is ApiException && error.statusCode == null) {
    return 'Không thể kết nối máy chủ. Kiểm tra mạng và thử lại.';
  }
  return 'Không thể lưu cài đặt duyệt tự động. Thử lại sau.';
}
