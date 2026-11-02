import 'package:flutter/material.dart';

abstract final class AppColors {
  // Brand
  static const primary = Color(0xFF20A29D);
  static const primaryActive = Color(0xFF167E7A);
  static const primaryLight = Color(0xFFE6F7F6);
  static const primary08 = Color.fromRGBO(32, 162, 157, 0.08);
  static const primary12 = Color.fromRGBO(32, 162, 157, 0.12);
  static const primary15 = Color.fromRGBO(32, 162, 157, 0.15);
  static const primary20 = Color.fromRGBO(32, 162, 157, 0.20);
  static const primary38 = Color.fromRGBO(32, 162, 157, 0.38);

  // Canvas / surfaces
  static const canvasMint = Color(0xFFF4FAF9);
  static const canvas = Color(0xFFF8FCFC);
  static const surface = Color(0xFFFFFFFF);
  static const surfaceSubdued = Color(0xFFF1F6F5);
  static const glass75 = Color.fromRGBO(255, 255, 255, 0.75);
  static const glass85 = Color.fromRGBO(255, 255, 255, 0.85);
  static const glass90 = Color.fromRGBO(255, 255, 255, 0.90);
  static const glassBorder = Color.fromRGBO(255, 255, 255, 0.60);

  // Border / divider
  static const borderBrandSoft = Color.fromRGBO(32, 162, 157, 0.12);
  static const borderNeutral = Color.fromRGBO(226, 232, 240, 0.80);

  // Typography
  static const textPrimary = Color(0xFF0F1E24);
  static const textSecondary = Color(0xFF4B6169);
  static const textTertiary = Color(0xFF8FA3AA);
  static const textInverse = Color(0xFFFFFFFF);

  // Feedback
  static const success = Color(0xFF10B981);
  static const warning = Color(0xFFF59E0B);
  static const star = Color(0xFFFBBF24);
  static const danger = Color(0xFFEF4444);
  static const dangerStrong = Color(0xFFFF5A36);
  static const info = Color(0xFF3B82F6);

  // Shadow / overlay helpers
  static const black03 = Color.fromRGBO(0, 0, 0, 0.03);
  static const marine08 = Color.fromRGBO(15, 30, 36, 0.08);
  static const marine16 = Color.fromRGBO(15, 30, 36, 0.16);
  static const heroOverlay = Color.fromRGBO(15, 30, 36, 0.80);
}
