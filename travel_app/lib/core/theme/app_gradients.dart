import 'package:flutter/material.dart';

import 'app_colors.dart';

abstract final class AppGradients {
  static const pageAtmosphere = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: [0.0, 0.40, 1.0],
    colors: [Color(0xFFD5F3F1), Color(0xFFEBF9F8), AppColors.canvas],
  );

  static const primaryAction = LinearGradient(
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    colors: [AppColors.primaryActive, AppColors.primary],
  );

  static const heroImageOverlay = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: [0.45, 1.0],
    colors: [Colors.transparent, AppColors.heroOverlay],
  );
}
