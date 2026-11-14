import 'package:flutter/material.dart';

import 'app_colors.dart';

abstract final class AppShadows {
  static const level1 = <BoxShadow>[
    BoxShadow(
      color: Color.fromRGBO(32, 162, 157, 0.06),
      offset: Offset(0, 4),
      blurRadius: 20,
      spreadRadius: -2,
    ),
    BoxShadow(
      color: AppColors.black03,
      offset: Offset(0, 2),
      blurRadius: 6,
      spreadRadius: -1,
    ),
  ];

  static const level2 = <BoxShadow>[
    BoxShadow(
      color: AppColors.marine08,
      offset: Offset(0, 10),
      blurRadius: 30,
      spreadRadius: -5,
    ),
  ];

  static const primaryGlow = <BoxShadow>[
    BoxShadow(
      color: AppColors.primary38,
      offset: Offset(0, 10),
      blurRadius: 25,
      spreadRadius: -4,
    ),
  ];

  static const level3 = <BoxShadow>[
    BoxShadow(
      color: AppColors.marine16,
      offset: Offset(0, 20),
      blurRadius: 40,
      spreadRadius: -10,
    ),
  ];
}
