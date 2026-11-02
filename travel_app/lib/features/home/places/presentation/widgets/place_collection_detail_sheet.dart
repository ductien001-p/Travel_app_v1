import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_frontend_v1/app/router/router_names.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_bottom_sheet.dart';
import 'package:travel_frontend_v1/core/widget/app_button.dart';

import '../../data/models/place_explore_api_models.dart';
import '../../provider/explore_places_provider.dart';

Future<void> showPlaceCollectionDetailSheet({
  required BuildContext context,
  required String collectionId,
}) {
  return showAppBottomSheet<void>(
    context: context,
    child: _CollectionDetailSheet(collectionId: collectionId),
  );
}

class _CollectionDetailSheet extends ConsumerStatefulWidget {
  const _CollectionDetailSheet({required this.collectionId});

  final String collectionId;

  @override
  ConsumerState<_CollectionDetailSheet> createState() =>
      _CollectionDetailSheetState();
}

class _CollectionDetailSheetState
    extends ConsumerState<_CollectionDetailSheet> {
  PlaceCollectionDetail? _detail;
  var _loading = true;
  var _busy = false;
  String? _error;
  int _draftRating = 0;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final detail = await ref
          .read(explorePlacesRepositoryProvider)
          .getCollection(widget.collectionId);
      if (!mounted) return;
      setState(() {
        _detail = detail;
        _draftRating = detail.viewerRating ?? 0;
        _loading = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _loading = false;
        _error = 'Không tải được bộ sưu tập.';
      });
    }
  }

  Future<void> _rate() async {
    if (_draftRating < 1 || _busy) return;
    setState(() => _busy = true);
    try {
      final detail = await ref
          .read(explorePlacesRepositoryProvider)
          .rateCollection(id: widget.collectionId, rating: _draftRating);
      if (!mounted) return;
      setState(() {
        _detail = detail;
        _busy = false;
        _error = null;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _busy = false;
        _error = 'Không gửi được đánh giá.';
      });
    }
  }

  Future<void> _copy() async {
    if (_busy) return;
    setState(() => _busy = true);
    try {
      await ref
          .read(explorePlacesRepositoryProvider)
          .copyCollection(widget.collectionId);
      if (!mounted) return;
      setState(() {
        _busy = false;
        _error = null;
        final current = _detail;
        if (current != null) {
          _detail = current.copyWith(copiedByViewer: true);
        }
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _busy = false;
        _error = 'Không lưu được bộ sưu tập.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final detail = _detail;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (_loading)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: AppSpacing.lg),
            child: Center(child: CircularProgressIndicator()),
          )
        else if (detail == null)
          Text(
            _error ?? 'Không tải được bộ sưu tập.',
            style: AppTypography.body,
          )
        else ...[
          Text(detail.title, style: AppTypography.sectionTitle),
          const SizedBox(height: AppSpacing.xxs),
          Text(
            '${detail.ownerDisplayName} · ${detail.placeCount} địa điểm',
            style: AppTypography.caption,
          ),
          if (detail.averageRating != null) ...[
            const SizedBox(height: AppSpacing.xxs),
            Text(
              '${detail.averageRating} / 5 · ${detail.ratingCount} đánh giá',
              style: AppTypography.caption.copyWith(color: AppColors.primary),
            ),
          ],
          const SizedBox(height: AppSpacing.sm),
          for (final place in detail.places.take(8))
            InkWell(
              onTap: () {
                final router = GoRouter.of(context);
                Navigator.of(context).pop();
                router.pushNamed(
                  RouteNames.placeDetail,
                  pathParameters: {'placeId': place.id},
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.xs),
                child: Text(place.name, style: AppTypography.body),
              ),
            ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              for (var star = 1; star <= 5; star++)
                IconButton(
                  onPressed: _busy
                      ? null
                      : () => setState(() => _draftRating = star),
                  icon: Icon(
                    star <= _draftRating
                        ? Icons.star_rounded
                        : Icons.star_outline_rounded,
                    color: AppColors.warning,
                  ),
                ),
            ],
          ),
          AppButton(
            label: 'Gửi đánh giá',
            onPressed: _draftRating < 1 || _busy ? null : _rate,
            isLoading: _busy,
          ),
          const SizedBox(height: AppSpacing.sm),
          AppButton(
            label: detail.copiedByViewer ? 'Đã lưu bộ này' : 'Lưu bộ sưu tập',
            variant: AppButtonVariant.secondary,
            onPressed: detail.copiedByViewer || _busy ? null : _copy,
          ),
          if (_error != null) ...[
            const SizedBox(height: AppSpacing.sm),
            Text(
              _error!,
              style: AppTypography.caption.copyWith(color: AppColors.danger),
            ),
          ],
        ],
      ],
    );
  }
}
