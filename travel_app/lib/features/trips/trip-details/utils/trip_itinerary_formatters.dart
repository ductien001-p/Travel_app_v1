import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/location/device_location_service.dart';
import 'package:travel_frontend_v1/core/networks/api_exception.dart';

import '../application/trip_itinerary_action_controller.dart';
import '../application/trip_itinerary_route.dart';
import 'trip_detail_formatters.dart';

/// `08:30 - 10:30`, `08:30` without a duration, null without a start time.
String? formatActivityTimeRange(DateTime? start, DateTime? end) {
  if (start == null) return null;
  if (end == null) return formatClock(start);
  return '${formatClock(start)} - ${formatClock(end)}';
}

/// `45 phút`, `2 giờ`, `2 giờ 30 phút`.
String formatDurationMinutes(int minutes) {
  if (minutes < 60) return '$minutes phút';
  final hours = minutes ~/ 60;
  final rest = minutes % 60;
  return rest == 0 ? '$hours giờ' : '$hours giờ $rest phút';
}

/// `~ 850 m`, `~ 4,2 km`, `~ 28 km`.
String formatApproxDistance(double km) {
  if (km < 1) return '~ ${(km * 1000).round()} m';
  if (km < 10) return '~ ${km.toStringAsFixed(1).replaceAll('.', ',')} km';
  return '~ ${km.round()} km';
}

/// `4,2 km` for road data, `~ 4,2 km` when estimated.
String formatRouteDistance(double km, {required bool isEstimate}) {
  final approx = formatApproxDistance(km);
  return isEstimate ? approx : approx.substring(2);
}

/// `Tổng 12 km · 35 phút`, or `Tổng ~ 12 km (ước tính)`.
String formatRouteSummary(TripItineraryRouteSummary summary) {
  final distance = formatRouteDistance(
    summary.distanceKm,
    isEstimate: summary.isEstimate,
  );
  final minutes = summary.travelMinutes;
  if (summary.isEstimate) return 'Tổng $distance (ước tính)';
  if (minutes == null || minutes == 0) return 'Tổng $distance';
  return 'Tổng $distance · ${formatDurationMinutes(minutes)}';
}

/// Null or zero costs read as free.
String formatActivityCost(double? cost) =>
    cost == null || cost <= 0 ? 'Miễn phí' : formatTripMoney(cost);

({String label, IconData icon}) placeCategoryStyle(String? category) {
  final normalized = category?.trim().toUpperCase();
  return switch (normalized) {
    'RESTAURANT' || 'FOOD' => (label: 'Ẩm thực', icon: Icons.restaurant),
    'CAFE' => (label: 'Cà phê', icon: Icons.local_cafe_outlined),
    'BEACH' => (label: 'Biển', icon: Icons.beach_access_outlined),
    'CRUISE' || 'BOAT' => (label: 'Du thuyền', icon: Icons.directions_boat),
    'SHOPPING' ||
    'MARKET' => (label: 'Mua sắm', icon: Icons.shopping_bag_outlined),
    'HOTEL' || 'ACCOMMODATION' => (label: 'Lưu trú', icon: Icons.hotel),
    'ATTRACTION' => (label: 'Tham quan', icon: Icons.photo_camera_outlined),
    null || '' => (label: 'Hoạt động', icon: Icons.local_activity_outlined),
    _ => (label: category!.trim(), icon: Icons.local_activity_outlined),
  };
}

String tripItineraryActionErrorMessage(
  TripItineraryAction action,
  Object error,
) {
  if (error is DeviceLocationException) {
    return switch (error.failure) {
      DeviceLocationFailure.serviceDisabled => 'Hãy bật định vị để check-in.',
      DeviceLocationFailure.denied || DeviceLocationFailure.deniedForever =>
        'Ứng dụng cần quyền vị trí để check-in.',
      DeviceLocationFailure.unavailable =>
        'Không lấy được vị trí hiện tại. Vui lòng thử lại.',
    };
  }
  if (error is ApiException) {
    final message = switch ((action, error.statusCode)) {
      (TripItineraryAction.checkin, 400) =>
        'Bạn đang ở quá xa địa điểm này. Hãy đến gần hơn để check-in.',
      (TripItineraryAction.checkin, 409) =>
        'Bạn đã check-in địa điểm này hoặc chuyến đi chưa cho phép check-in.',
      (TripItineraryAction.uncheckin, 409) =>
        'Không thể hủy check-in sau khi đã hoàn thành chuyến đi.',
      (_, 403) => 'Bạn không có quyền thực hiện thao tác này.',
      _ => null,
    };
    if (message != null) return message;
  }
  return tripDetailErrorMessage(error);
}
