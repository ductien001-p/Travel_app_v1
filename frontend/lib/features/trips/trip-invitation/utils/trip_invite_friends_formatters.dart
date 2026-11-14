import 'package:travel_frontend_v1/core/networks/api_exception.dart';

/// Why the owner cannot send invitations right now.
enum TripInviteFriendsBlock { closed, full, overCapacity }

class TripInviteFriendsBlockedException implements Exception {
  const TripInviteFriendsBlockedException(this.block);

  final TripInviteFriendsBlock block;

  @override
  String toString() => 'TripInviteFriendsBlockedException(${block.name})';
}

String tripInviteFriendsBlockMessage(TripInviteFriendsBlock block) =>
    switch (block) {
      TripInviteFriendsBlock.closed =>
        'Chỉ mời thêm người khi chuyến đi sắp diễn ra.',
      TripInviteFriendsBlock.full => 'Chuyến đi đã đủ chỗ.',
      TripInviteFriendsBlock.overCapacity =>
        'Số người đã chọn nhiều hơn số chỗ còn trống.',
    };

String tripInviteSlotsLabel(int openSlots, int memberCount, int maxMembers) {
  if (openSlots <= 0) return 'Đã đủ chỗ ($memberCount/$maxMembers)';
  return 'Còn $openSlots chỗ trống ($memberCount/$maxMembers)';
}

String tripInviteSharedTripsLabel(int count) {
  if (count <= 0) return '';
  return count == 1 ? 'Đã đi 1 chuyến' : 'Đã đi $count chuyến';
}

/// `Beach Lover 🏖️ • Hợp 94%` when the friend has DNA data.
String? tripInviteFitLabel({String? travelPersona, int? matchScore}) {
  final parts = <String>[
    if (travelPersona != null && travelPersona.isNotEmpty) travelPersona,
    if (matchScore != null) 'Hợp $matchScore%',
  ];
  if (parts.isEmpty) return null;
  return parts.join(' • ');
}

bool isTripInviteFriendsForbidden(Object error) =>
    error is ApiException && error.statusCode == 403;

String tripInviteFriendsErrorMessage(Object error) {
  if (error is TripInviteFriendsBlockedException) {
    return tripInviteFriendsBlockMessage(error.block);
  }
  if (error is ApiException) {
    return switch (error.statusCode) {
      403 => 'Chỉ trưởng nhóm mới mời được bạn.',
      404 => 'Không tìm thấy chuyến đi hoặc người được mời.',
      409 => 'Không gửi được lời mời. Chuyến đi có thể đã đủ chỗ hoặc đã đóng.',
      _ => 'Không gửi được lời mời. Vui lòng thử lại.',
    };
  }
  if (error is ArgumentError) return 'Từ khóa tìm kiếm chưa hợp lệ.';
  return 'Đã xảy ra lỗi. Vui lòng thử lại.';
}
