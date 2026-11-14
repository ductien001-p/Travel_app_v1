import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';

import '../../data/models/trip_chat_models.dart';

class TripChatSystemChip extends StatelessWidget {
  const TripChatSystemChip({super.key, required this.payload});

  final TripChatSystemPayload payload;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.sizeOf(context).width * 0.88,
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.primaryLight.withValues(alpha: 0.7),
            borderRadius: BorderRadius.circular(AppRadius.pill),
            border: Border.all(color: AppColors.borderBrandSoft),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(_iconFor(payload.icon), size: 16, color: AppColors.primary),
              const SizedBox(width: 6),
              Flexible(
                child: Text.rich(
                  TextSpan(
                    style: AppTypography.caption.copyWith(
                      color: AppColors.primary,
                    ),
                    children: _parseRich(payload.richText),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _iconFor(String icon) => switch (icon) {
    'add_location_alt' => Icons.add_location_alt_rounded,
    _ => Icons.info_outline_rounded,
  };

  List<InlineSpan> _parseRich(String source) {
    final spans = <InlineSpan>[];
    final pattern = RegExp(r'\*\*(.+?)\*\*');
    var start = 0;
    for (final match in pattern.allMatches(source)) {
      if (match.start > start) {
        spans.add(TextSpan(text: source.substring(start, match.start)));
      }
      spans.add(
        TextSpan(
          text: match.group(1),
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
      );
      start = match.end;
    }
    if (start < source.length) {
      spans.add(TextSpan(text: source.substring(start)));
    }
    return spans;
  }
}
