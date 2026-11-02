import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_bottom_sheet.dart';
import 'package:travel_frontend_v1/core/widget/app_button.dart';
import 'package:travel_frontend_v1/core/widget/app_text_field.dart';
import 'package:travel_frontend_v1/features/home/application/home_failure_message.dart';

import '../../application/place_detail_controller.dart';

Future<void> showPlaceReviewSheet({
  required BuildContext context,
  required WidgetRef ref,
  required String placeId,
}) {
  return showAppBottomSheet<void>(
    context: context,
    child: _PlaceReviewSheet(placeId: placeId),
  );
}

class _PlaceReviewSheet extends ConsumerStatefulWidget {
  const _PlaceReviewSheet({required this.placeId});

  final String placeId;

  @override
  ConsumerState<_PlaceReviewSheet> createState() => _PlaceReviewSheetState();
}

class _PlaceReviewSheetState extends ConsumerState<_PlaceReviewSheet> {
  late final TextEditingController _comment;
  late int _rating;

  @override
  void initState() {
    super.initState();
    final mine = ref
        .read(placeDetailControllerProvider(widget.placeId))
        .value
        ?.myReview;
    _rating = mine == null ? 5 : mine.rating.round().clamp(1, 5);
    _comment = TextEditingController(text: mine?.comment ?? '');
  }

  @override
  void dispose() {
    _comment.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    try {
      await ref
          .read(placeDetailControllerProvider(widget.placeId).notifier)
          .submitReview(rating: _rating, comment: _comment.text);
      if (!mounted) return;
      Navigator.of(context).pop();
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(homeFailureMessage(error))));
    }
  }

  Future<void> _delete() async {
    try {
      await ref
          .read(placeDetailControllerProvider(widget.placeId).notifier)
          .deleteMyReview();
      if (!mounted) return;
      Navigator.of(context).pop();
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(homeFailureMessage(error))));
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(placeDetailControllerProvider(widget.placeId));
    final mine = state.value?.myReview;
    final busy = state.value?.submittingReview ?? false;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          mine == null ? 'Viết đánh giá' : 'Đánh giá của bạn',
          style: AppTypography.sectionTitle,
        ),
        const SizedBox(height: AppSpacing.md),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (var star = 1; star <= 5; star++)
              IconButton(
                key: Key('place-review-star-$star'),
                onPressed: busy || mine != null
                    ? null
                    : () => setState(() => _rating = star),
                icon: Icon(
                  star <= _rating
                      ? Icons.star_rounded
                      : Icons.star_outline_rounded,
                  color: AppColors.warning,
                ),
              ),
          ],
        ),
        AppTextField(
          controller: _comment,
          label: 'Nhận xét',
          hint: 'Chia sẻ trải nghiệm của bạn',
          maxLines: 4,
          enabled: !busy && mine == null,
        ),
        const SizedBox(height: AppSpacing.md),
        if (mine == null)
          AppButton(
            key: const Key('place-review-submit'),
            label: 'Gửi đánh giá',
            isLoading: busy,
            onPressed: busy ? null : _submit,
          )
        else
          AppButton(
            label: 'Xóa đánh giá',
            variant: AppButtonVariant.destructive,
            isLoading: busy,
            onPressed: busy ? null : _delete,
          ),
      ],
    );
  }
}
