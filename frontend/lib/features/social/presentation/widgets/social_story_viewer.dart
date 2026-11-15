import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_pressable.dart';

import '../../data/models/social_feed_models.dart';

Future<void> showSocialStoryViewer({
  required BuildContext context,
  required List<SocialFeedStory> stories,
  int initialIndex = 0,
}) {
  final viewable = stories
      .where((story) => story.imageUrl != null && story.imageUrl!.isNotEmpty)
      .toList(growable: false);
  if (viewable.isEmpty) return Future.value();

  final startId = stories[initialIndex.clamp(0, stories.length - 1)].id;
  var start = viewable.indexWhere((story) => story.id == startId);
  if (start < 0) start = 0;

  return Navigator.of(context).push(
    PageRouteBuilder<void>(
      opaque: false,
      barrierColor: Colors.black,
      pageBuilder: (_, _, _) =>
          _SocialStoryViewer(stories: viewable, initialIndex: start),
      transitionsBuilder: (_, animation, _, child) =>
          FadeTransition(opacity: animation, child: child),
    ),
  );
}

class _SocialStoryViewer extends StatefulWidget {
  const _SocialStoryViewer({required this.stories, required this.initialIndex});

  final List<SocialFeedStory> stories;
  final int initialIndex;

  @override
  State<_SocialStoryViewer> createState() => _SocialStoryViewerState();
}

class _SocialStoryViewerState extends State<_SocialStoryViewer>
    with SingleTickerProviderStateMixin {
  static const _storyDuration = Duration(seconds: 5);

  late final PageController _controller;
  late final AnimationController _progress;
  late int _index;

  @override
  void initState() {
    super.initState();
    _index = widget.initialIndex;
    _controller = PageController(initialPage: widget.initialIndex);
    _progress = AnimationController(vsync: this, duration: _storyDuration)
      ..addStatusListener(_onProgress)
      ..forward();
  }

  @override
  void dispose() {
    _progress.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _onProgress(AnimationStatus status) {
    if (status != AnimationStatus.completed || !mounted) return;
    _goNext();
  }

  void _goNext() {
    if (_index >= widget.stories.length - 1) {
      Navigator.of(context).pop();
      return;
    }
    _controller.nextPage(
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOut,
    );
  }

  void _restartProgress() {
    _progress
      ..stop()
      ..value = 0
      ..forward();
  }

  @override
  Widget build(BuildContext context) {
    final story = widget.stories[_index];
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            PageView.builder(
              controller: _controller,
              itemCount: widget.stories.length,
              onPageChanged: (value) {
                setState(() => _index = value);
                _restartProgress();
              },
              itemBuilder: (context, index) {
                final item = widget.stories[index];
                return InteractiveViewer(
                  child: Center(
                    child: Image.network(
                      item.imageUrl!,
                      fit: BoxFit.contain,
                      errorBuilder: (_, _, _) => const Icon(
                        Icons.broken_image_outlined,
                        color: Colors.white70,
                        size: 64,
                      ),
                    ),
                  ),
                );
              },
            ),
            Positioned(
              top: AppSpacing.xs,
              left: AppSpacing.md,
              right: AppSpacing.md,
              child: AnimatedBuilder(
                animation: _progress,
                builder: (context, _) {
                  return Row(
                    children: [
                      for (var i = 0; i < widget.stories.length; i++) ...[
                        if (i > 0) const SizedBox(width: 4),
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(99),
                            child: LinearProgressIndicator(
                              minHeight: 3,
                              value: i < _index
                                  ? 1
                                  : i == _index
                                  ? _progress.value
                                  : 0,
                              backgroundColor: Colors.white24,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ],
                  );
                },
              ),
            ),
            Positioned(
              top: AppSpacing.lg,
              left: AppSpacing.md,
              right: AppSpacing.md,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      story.label,
                      style: AppTypography.cardTitle.copyWith(
                        color: Colors.white,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (story.badge == SocialFeedStoryBadge.live)
                    Container(
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.danger,
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        'LIVE',
                        style: AppTypography.badge.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  AppPressable(
                    onTap: () => Navigator.of(context).pop(),
                    child: const Padding(
                      padding: EdgeInsets.all(8),
                      child: Icon(Icons.close, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: AppSpacing.md,
              child: Text(
                '${_index + 1}/${widget.stories.length}',
                textAlign: TextAlign.center,
                style: AppTypography.caption.copyWith(color: Colors.white70),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
