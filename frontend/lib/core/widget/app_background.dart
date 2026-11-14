import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_gradients.dart';

class AppBackground extends StatelessWidget {
  const AppBackground({
    super.key,
    required this.child,
    this.showAmbientBlob = true,
  });

  final Widget child;
  final bool showAmbientBlob;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(gradient: AppGradients.pageAtmosphere),
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (showAmbientBlob)
            Positioned(
              top: -70,
              right: -50,
              child: IgnorePointer(
                child: Container(
                  width: 220,
                  height: 220,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primary12,
                  ),
                ),
              ),
            ),
          child,
        ],
      ),
    );
  }
}
