import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travel_frontend_v1/features/media/data/models/media_upload_folder.dart';
import 'package:travel_frontend_v1/features/media/providers/media_providers.dart';
import 'package:travel_frontend_v1/app/router/router_names.dart';
import 'package:travel_frontend_v1/core/testing/e2e_keys.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_gradients.dart';
import 'package:travel_frontend_v1/core/theme/app_radius.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/widget/app_error_view.dart';
import 'package:travel_frontend_v1/core/widget/app_skeleton.dart';

import '../../application/trip_chat_controller.dart';
import '../../data/models/trip_chat_models.dart';
import '../widgets/trip_chat_composer.dart';
import '../widgets/trip_chat_header.dart';
import '../widgets/trip_chat_message_list.dart';
import '../widgets/trip_chat_pinned_bar.dart';

class TripChatScreen extends ConsumerStatefulWidget {
  const TripChatScreen({super.key, required this.tripId});

  final String tripId;

  @override
  ConsumerState<TripChatScreen> createState() => _TripChatScreenState();
}

class _TripChatScreenState extends ConsumerState<TripChatScreen> {
  late final TextEditingController _composer;
  bool _utilityExpanded = false;

  @override
  void initState() {
    super.initState();
    _composer = TextEditingController();
    _composer.addListener(_onComposerChanged);
  }

  @override
  void dispose() {
    _composer.removeListener(_onComposerChanged);
    _composer.dispose();
    super.dispose();
  }

  void _onComposerChanged() {
    final notifier = ref.read(
      tripChatControllerProvider(widget.tripId).notifier,
    );
    notifier.setTyping(_composer.text.trim().isNotEmpty);
  }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(tripChatControllerProvider(widget.tripId));

    return Scaffold(
      key: E2eKeys.tripChatScreenRoot,
      backgroundColor: Colors.transparent,
      body: DecoratedBox(
        decoration: const BoxDecoration(gradient: AppGradients.pageAtmosphere),
        child: SafeArea(
          bottom: false,
          child: async.when(
            loading: () => const _LoadingScaffold(),
            error: (error, _) {
              final unauthorized = tripChatFailureIsUnauthorized(error);
              return Column(
                children: [
                  _ErrorHeader(onBack: () => context.pop()),
                  Expanded(
                    child: AppErrorView(
                      title: unauthorized
                          ? 'Phiên đăng nhập đã hết hạn'
                          : 'Không tải được chat nhóm',
                      message: tripChatFailureMessage(error),
                      actionLabel: 'Thử lại',
                      onRetry: unauthorized
                          ? null
                          : () => ref
                                .read(
                                  tripChatControllerProvider(
                                    widget.tripId,
                                  ).notifier,
                                )
                                .refresh(),
                    ),
                  ),
                ],
              );
            },
            data: (thread) => _LoadedBody(
              thread: thread,
              composer: _composer,
              utilityExpanded: _utilityExpanded,
              onBack: () => context.pop(),
              onMore: _comingSoon,
              onCheckIn: _comingSoon,
              onOpenPinned: () {
                context.pushNamed(
                  RouteNames.tripItinerary,
                  pathParameters: {'tripId': thread.tripId},
                );
              },
              onToggleUtility: () {
                setState(() => _utilityExpanded = !_utilityExpanded);
              },
              onUtilitySelected: (utility) => _onUtility(thread, utility),
              onSend: () => _send(thread),
              onCamera: () => _sendPhoto(thread),
              onReact: (message) => ref
                  .read(tripChatControllerProvider(widget.tripId).notifier)
                  .toggleReaction(
                    messageId: message.id,
                    emoji: '❤️',
                    remove: false,
                  ),
              onRemoveReaction: (message, emoji) => ref
                  .read(tripChatControllerProvider(widget.tripId).notifier)
                  .toggleReaction(
                    messageId: message.id,
                    emoji: emoji,
                    remove: true,
                  ),
              onMic: _comingSoon,
              onOpenExpense: (_) {
                context.pushNamed(
                  RouteNames.tripExpenses,
                  pathParameters: {'tripId': thread.tripId},
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _send(TripChatThread thread) async {
    final text = _composer.text;
    if (text.trim().isEmpty) return;
    _composer.clear();
    final ok = await ref
        .read(tripChatControllerProvider(widget.tripId).notifier)
        .sendText(text);
    if (!ok && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Không gửi được tin nhắn. Thử lại.')),
      );
    }
  }

  Future<void> _sendPhoto(TripChatThread thread) async {
    final file = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (file == null || !mounted) return;
    try {
      final uploaded = await ref
          .read(mediaUploadRepositoryProvider)
          .uploadFiles(folder: MediaUploadFolder.trips, files: [file]);
      if (uploaded.isEmpty) {
        throw StateError('empty upload');
      }
      final ok = await ref
          .read(tripChatControllerProvider(thread.tripId).notifier)
          .sendImage(uploaded.first.id);
      if (!ok && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Không gửi được ảnh. Thử lại.')),
        );
      }
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Không gửi được ảnh. Thử lại.')),
      );
    }
  }

  void _onUtility(TripChatThread thread, TripChatUtility utility) {
    setState(() => _utilityExpanded = false);
    switch (utility.kind) {
      case TripChatUtilityKind.splitBill:
        context.pushNamed(
          RouteNames.tripExpenses,
          pathParameters: {'tripId': thread.tripId},
        );
      case TripChatUtilityKind.album:
        context.pushNamed(
          RouteNames.tripMemories,
          pathParameters: {'tripId': thread.tripId},
        );
      case TripChatUtilityKind.addStop:
        context.pushNamed(
          RouteNames.tripItinerary,
          pathParameters: {'tripId': thread.tripId},
        );
      case TripChatUtilityKind.liveLocation:
        _comingSoon();
    }
  }

  void _comingSoon() {
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Tính năng đang phát triển')));
  }
}

class _LoadedBody extends StatelessWidget {
  const _LoadedBody({
    required this.thread,
    required this.composer,
    required this.utilityExpanded,
    required this.onBack,
    required this.onMore,
    required this.onCheckIn,
    required this.onOpenPinned,
    required this.onToggleUtility,
    required this.onUtilitySelected,
    required this.onSend,
    required this.onCamera,
    required this.onMic,
    required this.onOpenExpense,
    this.onReact,
    this.onRemoveReaction,
  });

  final TripChatThread thread;
  final TextEditingController composer;
  final bool utilityExpanded;
  final VoidCallback onBack;
  final VoidCallback onMore;
  final VoidCallback onCheckIn;
  final VoidCallback onOpenPinned;
  final VoidCallback onToggleUtility;
  final ValueChanged<TripChatUtility> onUtilitySelected;
  final VoidCallback onSend;
  final VoidCallback onCamera;
  final VoidCallback onMic;
  final ValueChanged<TripChatExpensePayload> onOpenExpense;
  final ValueChanged<TripChatMessage>? onReact;
  final void Function(TripChatMessage message, String emoji)? onRemoveReaction;

  @override
  Widget build(BuildContext context) {
    final pinned = thread.pinnedActivity;
    return Column(
      children: [
        TripChatHeader(thread: thread, onBack: onBack, onMore: onMore),
        if (pinned != null)
          TripChatPinnedBar(
            activity: pinned,
            onCheckIn: onCheckIn,
            onOpenDetails: onOpenPinned,
          ),
        Expanded(
          child: TripChatMessageList(
            thread: thread,
            bottomInset: 8,
            onOpenExpense: onOpenExpense,
            onReact: onReact,
            onRemoveReaction: onRemoveReaction,
          ),
        ),
        TripChatComposer(
          utilities: thread.utilities,
          controller: composer,
          utilityExpanded: utilityExpanded,
          onToggleUtility: onToggleUtility,
          onUtilitySelected: onUtilitySelected,
          onSend: onSend,
          onCamera: onCamera,
          onMic: onMic,
        ),
      ],
    );
  }
}

class _LoadingScaffold extends StatelessWidget {
  const _LoadingScaffold();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Padding(
          padding: EdgeInsets.all(AppSpacing.md),
          child: Row(
            children: [
              AppSkeleton(width: 40, height: 40, radius: AppRadius.pill),
              SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppSkeleton(width: 180, height: 16, radius: 8),
                    SizedBox(height: 8),
                    AppSkeleton(width: 220, height: 12, radius: 8),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSpacing.md),
          child: AppSkeleton(
            width: double.infinity,
            height: 56,
            radius: AppRadius.card,
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(AppSpacing.md),
            child: Column(
              children: [
                AppSkeleton(width: 160, height: 28, radius: AppRadius.pill),
                SizedBox(height: AppSpacing.md),
                AppSkeleton(
                  width: double.infinity,
                  height: 72,
                  radius: AppRadius.card,
                ),
                SizedBox(height: AppSpacing.sm),
                AppSkeleton(
                  width: double.infinity,
                  height: 180,
                  radius: AppRadius.card,
                ),
                SizedBox(height: AppSpacing.sm),
                Align(
                  alignment: Alignment.centerRight,
                  child: AppSkeleton(
                    width: 220,
                    height: 72,
                    radius: AppRadius.card,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _ErrorHeader extends StatelessWidget {
  const _ErrorHeader({required this.onBack});

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: IconButton(
        onPressed: onBack,
        icon: const Icon(Icons.arrow_back_rounded),
        color: AppColors.textPrimary,
      ),
    );
  }
}
