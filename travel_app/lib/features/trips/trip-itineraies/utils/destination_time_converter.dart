import 'package:flutter/material.dart';

/// Giờ hoạt động trong lịch trình luôn theo UTC (đồng nhất với backend),
/// không phụ thuộc múi giờ thiết bị hay điểm đến.
class DestinationTimeConverter {
  /// Ghép ngày lịch trình và giờ đã chọn thành chuỗi ISO-8601 UTC (`...Z`).
  static String toUtcIso({required DateTime dayDate, required TimeOfDay time}) {
    final year = dayDate.year.toString().padLeft(4, '0');
    final month = dayDate.month.toString().padLeft(2, '0');
    final day = dayDate.day.toString().padLeft(2, '0');
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');

    return '$year-$month-${day}T$hour:$minute:00Z';
  }

  /// Format TimeOfDay cho UI
  static String formatTimeOfDay(TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  /// Nhãn buổi trong ngày (Derived display)
  static String timeOfDayPeriodLabel(TimeOfDay time) {
    final hour = time.hour;
    if (hour >= 5 && hour < 12) return 'Buổi sáng';
    if (hour >= 12 && hour < 14) return 'Buổi trưa';
    if (hour >= 14 && hour < 18) return 'Buổi chiều';
    return 'Buổi tối';
  }
}
