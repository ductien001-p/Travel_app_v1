import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_sizes.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_glass_surface.dart';
import 'package:travel_frontend_v1/core/widget/app_icon_button.dart';

class TripJoinByCodeTopBar extends StatelessWidget {
  const TripJoinByCodeTopBar({super.key, required this.onBack, this.onScanQr});

  final VoidCallback onBack;
  final VoidCallback? onScanQr;

  @override
  Widget build(BuildContext context) => AppGlassSurface(
    radius: 0,
    color: AppColors.glass85,
    shadows: const [],
    padding: const EdgeInsets.symmetric(
      horizontal: AppSpacing.screenHorizontal,
    ),
    child: SizedBox(
      height: AppSizes.topBarMaxHeight,
      child: Row(
        children: [
          AppIconButton(
            icon: Icons.arrow_back_rounded,
            iconColor: AppColors.textPrimary,
            onPressed: onBack,
            semanticLabel: 'Quay lại',
          ),
          Expanded(
            child: Text(
              'Tham Gia Chuyến Đi',
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTypography.cardTitle.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          AppIconButton(
            icon: Icons.qr_code_scanner_rounded,
            iconColor: AppColors.primary,
            onPressed: onScanQr,
            semanticLabel: 'Quét mã QR',
          ),
        ],
      ),
    ),
  );
}
