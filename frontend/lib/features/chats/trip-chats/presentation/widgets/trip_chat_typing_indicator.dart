import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_avatar.dart';

class TripChatTypingIndicator extends StatefulWidget {
  const TripChatTypingIndicator({
    super.key,
    required this.label,
    this.avatarUrl,
  });

  final String label;
  final String? avatarUrl;

  @override
  State<TripChatTypingIndicator> createState() =>
      _TripChatTypingIndicatorState();
}

class _TripChatTypingIndicatorState extends State<TripChatTypingIndicator>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppAvatar(size: 24, imageUrl: widget.avatarUrl, initials: '?'),
        const SizedBox(width: 8),
        Flexible(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.glass90,
              borderRadius: BorderRadius.circular(AppRadius.pill),
              border: Border.all(color: AppColors.glassBorder),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: Text(
                    widget.label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.caption.copyWith(
                      color: AppColors.textSecondary,
                      fontSize: 11,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                AnimatedBuilder(
                  animation: _controller,
                  builder: (context, _) {
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(3, (index) {
                        final t = (_controller.value + index * 0.2) % 1.0;
                        final scale = t < 0.4
                            ? (t / 0.4)
                            : t < 0.8
                            ? (1 - (t - 0.4) / 0.4)
                            : 0.0;
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 1.5),
                          child: Transform.translate(
                            offset: Offset(0, -4 * scale),
                            child: Opacity(
                              opacity: 0.4 + scale * 0.6,
                              child: Container(
                                width: 5,
                                height: 5,
                                decoration: const BoxDecoration(
                                  color: AppColors.primary,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
