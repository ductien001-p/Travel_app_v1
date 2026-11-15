import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_shadows.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';

import '../../data/models/trip_chat_models.dart';

class TripChatPhotoBubble extends StatelessWidget {
  const TripChatPhotoBubble({
    super.key,
    required this.message,
    required this.photo,
    this.onReact,
    this.onRemoveReaction,
  });

  final TripChatMessage message;
  final TripChatPhotoPayload photo;
  final VoidCallback? onReact;
  final ValueChanged<String>? onRemoveReaction;

  @override
  Widget build(BuildContext context) {
    final reactions = message.reactions.isNotEmpty
        ? message.reactions
        : photo.reactions;

    return GestureDetector(
      onLongPress: onReact,
      child: Container(
      constraints: const BoxConstraints(maxWidth: 280),
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: AppColors.glass90,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(6),
          topRight: Radius.circular(AppRadius.card),
          bottomLeft: Radius.circular(AppRadius.card),
          bottomRight: Radius.circular(AppRadius.card),
        ),
        border: Border.all(color: AppColors.glassBorder),
        boxShadow: AppShadows.level1,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(AppRadius.image),
            child: AspectRatio(
              aspectRatio: 4 / 3,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    photo.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (_, _, _) => const ColoredBox(
                      color: AppColors.primaryLight,
                      child: Icon(
                        Icons.photo_rounded,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  if (photo.locationLabel != null)
                    Positioned(
                      left: 8,
                      bottom: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.heroOverlay.withValues(alpha: 0.45),
                          borderRadius: BorderRadius.circular(AppRadius.pill),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.photo_camera_rounded,
                              size: 12,
                              color: AppColors.textInverse,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              photo.locationLabel!,
                              style: AppTypography.caption.copyWith(
                                fontSize: 10,
                                color: AppColors.textInverse,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          if (photo.caption != null && photo.caption!.isNotEmpty) ...[
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                photo.caption!,
                style: AppTypography.caption.copyWith(
                  color: AppColors.textPrimary,
                  height: 1.35,
                ),
              ),
            ),
          ],
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 4),
            child: Row(
              children: [
                if (reactions.isNotEmpty)
                  GestureDetector(
                    onTap: onRemoveReaction == null || reactions.isEmpty
                        ? null
                        : () => onRemoveReaction!(reactions.first.emoji),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceSubdued.withValues(alpha: 0.85),
                        borderRadius: BorderRadius.circular(AppRadius.pill),
                        border: Border.all(color: AppColors.borderNeutral),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          for (var i = 0; i < reactions.length; i++) ...[
                            if (i > 0) const SizedBox(width: 6),
                            GestureDetector(
                              onTap: onRemoveReaction == null
                                  ? null
                                  : () => onRemoveReaction!(reactions[i].emoji),
                              child: Text(
                                '${reactions[i].emoji} ${reactions[i].count}',
                                style: AppTypography.caption.copyWith(
                                  fontSize: 11,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                const Spacer(),
                Text(
                  message.timeLabel,
                  style: AppTypography.caption.copyWith(
                    fontSize: 11,
                    color: AppColors.textTertiary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      ),
    );
  }
}
