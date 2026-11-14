import 'package:flutter/material.dart';

import 'app_colors.dart';

abstract final class AppTypography {
  static const fontFamily = 'Plus Jakarta Sans';

  static const display = TextStyle(
    fontFamily: fontFamily,
    fontSize: 34,
    height: 1.12,
    fontWeight: FontWeight.w800,
    letterSpacing: -1.02,
    color: AppColors.textPrimary,
  );

  static const screenTitle = TextStyle(
    fontFamily: fontFamily,
    fontSize: 21,
    height: 1.20,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.42,
    color: AppColors.textPrimary,
  );

  static const sectionTitle = TextStyle(
    fontFamily: fontFamily,
    fontSize: 19,
    height: 1.25,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  static const cardTitle = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    height: 1.30,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static const body = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    height: 1.50,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
  );

  static const bodyMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    height: 1.50,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
  );

  static const caption = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    height: 1.35,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.12,
    color: AppColors.textTertiary,
  );

  static const badge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 11,
    height: 1.20,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.44,
    color: AppColors.textPrimary,
  );

  static const buttonLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    height: 1.20,
    fontWeight: FontWeight.w700,
    color: AppColors.textInverse,
  );

  static const buttonSmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    height: 1.20,
    fontWeight: FontWeight.w700,
  );

  static TextTheme get textTheme => const TextTheme(
    displayLarge: display,
    headlineSmall: screenTitle,
    titleLarge: sectionTitle,
    titleMedium: cardTitle,
    bodyMedium: body,
    bodySmall: caption,
    labelLarge: buttonLarge,
    labelMedium: badge,
  );
}
