import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_bottom_sheet.dart';
import 'package:travel_frontend_v1/core/widget/app_button.dart';
import 'package:travel_frontend_v1/core/widget/app_text_field.dart';

import '../../application/explore_places_controller.dart';
import '../../application/featured_destinations_controller.dart';
import '../../data/models/place_explore_api_models.dart';
import '../../provider/explore_places_provider.dart';

Future<void> showPlaceSaveSheet({
  required BuildContext context,
  required WidgetRef ref,
  required String placeId,
}) {
  return showAppBottomSheet<void>(
    context: context,
    child: _PlaceSaveSheet(placeId: placeId),
  );
}

class _PlaceSaveSheet extends ConsumerStatefulWidget {
  const _PlaceSaveSheet({required this.placeId});

  final String placeId;

  @override
  ConsumerState<_PlaceSaveSheet> createState() => _PlaceSaveSheetState();
}

class _PlaceSaveSheetState extends ConsumerState<_PlaceSaveSheet> {
  final _title = TextEditingController();
  List<OwnedPlaceCollection> _collections = const [];
  final _selected = <String>{};
  var _loading = true;
  var _saving = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    _title.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    try {
      final collections = await ref
          .read(explorePlacesRepositoryProvider)
          .listMine();
      if (!mounted) return;
      setState(() {
        _collections = collections;
        _selected
          ..clear()
          ..addAll([
            for (final collection in collections)
              if (collection.placeIds.contains(widget.placeId)) collection.id,
          ]);
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

  Future<void> _create() async {
    final title = _title.text.trim();
    if (title.isEmpty || _saving) return;
    setState(() => _saving = true);
    try {
      final created = await ref
          .read(explorePlacesRepositoryProvider)
          .createCollection(title);
      if (!mounted) return;
      setState(() {
        _collections = [created, ..._collections];
        _selected.add(created.id);
        _title.clear();
        _saving = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _saving = false;
        _error = 'Không tạo được bộ sưu tập.';
      });
    }
  }

  Future<void> _confirm() async {
    if (_selected.isEmpty || _saving) return;
    setState(() => _saving = true);
    final ok = await ref
        .read(explorePlacesControllerProvider.notifier)
        .saveToCollections(
          placeId: widget.placeId,
          collectionIds: _selected.toList(),
        );
    if (!mounted) return;
    if (!ok) {
      setState(() {
        _saving = false;
        _error = 'Không lưu được địa điểm.';
      });
      return;
    }
    _noteFeaturedBookmark(true);
    Navigator.of(context).pop();
  }

  Future<void> _unsave() async {
    setState(() => _saving = true);
    final ok = await ref
        .read(explorePlacesControllerProvider.notifier)
        .unsave(widget.placeId);
    if (!mounted) return;
    if (!ok) {
      setState(() {
        _saving = false;
        _error = 'Không bỏ lưu được.';
      });
      return;
    }
    _noteFeaturedBookmark(false);
    Navigator.of(context).pop();
  }

  void _noteFeaturedBookmark(bool bookmarked) {
    if (!ref.exists(featuredDestinationsControllerProvider)) return;
    ref
        .read(featuredDestinationsControllerProvider.notifier)
        .noteBookmark(widget.placeId, bookmarked);
  }

  @override
  Widget build(BuildContext context) {
    final bookmarked =
        ref
            .watch(explorePlacesControllerProvider)
            .asData
            ?.value
            .isBookmarked(widget.placeId) ??
        false;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Lưu vào bộ sưu tập', style: AppTypography.sectionTitle),
        const SizedBox(height: AppSpacing.sm),
        if (_loading)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: AppSpacing.lg),
            child: Center(child: CircularProgressIndicator()),
          )
        else ...[
          if (_collections.isEmpty)
            Text(
              'Chưa có bộ sưu tập. Tạo một bộ để lưu địa điểm này.',
              style: AppTypography.body,
            ),
          for (final collection in _collections)
            GestureDetector(
              onTap: _saving
                  ? null
                  : () {
                      setState(() {
                        if (_selected.contains(collection.id)) {
                          _selected.remove(collection.id);
                        } else {
                          _selected.add(collection.id);
                        }
                      });
                    },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: [
                    Checkbox(
                      value: _selected.contains(collection.id),
                      onChanged: _saving
                          ? null
                          : (checked) {
                              setState(() {
                                if (checked ?? false) {
                                  _selected.add(collection.id);
                                } else {
                                  _selected.remove(collection.id);
                                }
                              });
                            },
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            collection.title,
                            style: AppTypography.cardTitle,
                          ),
                          Text(
                            '${collection.placeCount} địa điểm',
                            style: AppTypography.caption,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          const SizedBox(height: AppSpacing.sm),
          AppTextField(
            controller: _title,
            hint: 'Tên bộ sưu tập mới',
            textInputAction: TextInputAction.done,
            onFieldSubmitted: (_) => _create(),
          ),
          const SizedBox(height: AppSpacing.sm),
          AppButton(
            label: 'Tạo bộ sưu tập',
            variant: AppButtonVariant.secondary,
            onPressed: _saving ? null : _create,
          ),
          if (_error != null) ...[
            const SizedBox(height: AppSpacing.sm),
            Text(
              _error!,
              style: AppTypography.caption.copyWith(color: AppColors.danger),
            ),
          ],
          const SizedBox(height: AppSpacing.md),
          AppButton(
            label: 'Lưu',
            isLoading: _saving,
            onPressed: _selected.isEmpty || _saving ? null : _confirm,
          ),
          if (bookmarked) ...[
            const SizedBox(height: AppSpacing.sm),
            AppButton(
              label: 'Bỏ lưu',
              variant: AppButtonVariant.destructive,
              onPressed: _saving ? null : _unsave,
            ),
          ],
        ],
      ],
    );
  }
}
