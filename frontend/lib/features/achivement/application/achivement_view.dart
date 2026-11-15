import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/networks/api_exception.dart';

import '../data/models/achivement_models.dart';

String achivementPointsLabel(
  int points, {
  bool withPlus = false,
  bool withUnit = false,
}) {
  final digits = points.abs().toString();
  final buffer = StringBuffer();
  for (var i = 0; i < digits.length; i++) {
    final reverseIndex = digits.length - i;
    buffer.write(digits[i]);
    if (reverseIndex > 1 && reverseIndex % 3 == 1) {
      buffer.write('.');
    }
  }
  final formatted = buffer.toString();
  final signed = withPlus && points > 0 ? '+$formatted' : formatted;
  if (!withUnit) return signed;
  return '$signed pts';
}

String achivementMissionCtaLabel(TripMissionCta cta) => switch (cta) {
  TripMissionCta.itinerary => 'Lịch trình',
  TripMissionCta.memories => 'Album',
};

IconData achivementMissionIcon(String icon) => switch (icon) {
  'photo_camera' || 'camera' || 'photo' => Icons.photo_camera_rounded,
  'restaurant' || 'food' => Icons.restaurant_rounded,
  'location_city' || 'city' => Icons.location_city_rounded,
  'nature' || 'park' => Icons.park_rounded,
  'groups' || 'social' => Icons.groups_rounded,
  'museum' || 'culture' => Icons.museum_rounded,
  'hiking' || 'adventure' => Icons.hiking_rounded,
  'eco' || 'responsible' => Icons.eco_rounded,
  'check_circle' => Icons.check_circle_rounded,
  _ => Icons.explore_rounded,
};

IconData achivementAchievementIcon(String code, {required bool unlocked}) {
  if (!unlocked) return Icons.lock_outline_rounded;
  return switch (code) {
    'FIRST_TRIP' => Icons.flight_takeoff_rounded,
    'CITY_HOPPER' => Icons.location_city_rounded,
    'MISSION_MASTER' => Icons.emoji_events_rounded,
    _ => Icons.military_tech_rounded,
  };
}

String achivementTierNextHint(TravelTier tier) {
  final next = tier.next;
  if (next == null) return 'Bạn đang ở cấp cao nhất';
  final parts = <String>[];
  if (next.tripsRemaining > 0) {
    parts.add('${next.tripsRemaining} chuyến');
  }
  if (next.citiesRemaining > 0) {
    parts.add('${next.citiesRemaining} thành phố');
  }
  final remain = parts.isEmpty ? 'đủ điều kiện' : parts.join(' · ');
  return 'Còn $remain để mở x${_formatMultiplier(next.multiplier)} ${_tierCodeLabel(next.code)}';
}

double achivementTierProgress(TravelTier tier) {
  final next = tier.next;
  if (next == null) return 1;
  final tripsNeed = next.tripsRemaining;
  final citiesNeed = next.citiesRemaining;
  final totalNeed = tripsNeed + citiesNeed;
  if (totalNeed <= 0) return 1;
  // Approximate remaining-based progress: assume current milestones already done.
  final remaining = tripsNeed + citiesNeed;
  final assumedTotal = remaining + (tier.tripsCompleted.clamp(1, 20));
  return (1 - (remaining / assumedTotal)).clamp(0.05, 0.95);
}

String achivementFailureMessage(Object error) {
  if (error is ApiException && error.statusCode == 401) {
    return 'Phiên đăng nhập đã hết hạn';
  }
  if (error is ApiException && error.message.trim().isNotEmpty) {
    return error.message.trim();
  }
  return 'Đã xảy ra lỗi. Vui lòng thử lại.';
}

bool achivementFailureIsUnauthorized(Object error) =>
    error is ApiException && error.statusCode == 401;

String _formatMultiplier(double value) {
  if (value == value.roundToDouble()) return value.toStringAsFixed(0);
  return value
      .toStringAsFixed(2)
      .replaceFirst(RegExp(r'0+$'), '')
      .replaceFirst(RegExp(r'\.$'), '');
}

String _tierCodeLabel(String code) => switch (code) {
  'BEGINNER' => 'Người mới',
  'EXPLORER' => 'Khám phá',
  'TRAVELER' => 'Lữ khách',
  'ADVENTURER' => 'Nhà thám hiểm',
  'LEGEND' => 'Huyền thoại',
  _ => code,
};
