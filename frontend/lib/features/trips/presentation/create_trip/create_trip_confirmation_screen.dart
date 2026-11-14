import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/networks/api_exception.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widget/app_avatar.dart';
import '../../../../core/widget/app_empty_view.dart';
import '../../../../core/widget/app_error_view.dart';
import '../../../../core/widget/app_loading.dart';
import '../../../../core/widget/app_scaffold.dart';
import '../../../profile/application/profile_controller.dart';
import '../../application/create_trip_controller.dart';
import '../../application/trip_creation_support_controller.dart';
import '../../application/trip_invitations_controller.dart';
import '../../data/models/trip.dart';
import '../../data/models/trip_creation_models.dart';
import '../../data/models/trip_enums.dart';
import '../../data/models/trip_requests.dart';
import '../../trip-itineraies/application/trip_itinerary_controller.dart';
import '../../trip-itineraies/data/models/itinerary_models.dart';
import 'create_trip_flow_widgets.dart';

class CreateTripConfirmationScreen extends ConsumerStatefulWidget {
  const CreateTripConfirmationScreen({super.key, required this.tripId});
  final String tripId;

  @override
  ConsumerState<CreateTripConfirmationScreen> createState() =>
      _CreateTripConfirmationScreenState();
}

class _CreateTripConfirmationScreenState
    extends ConsumerState<CreateTripConfirmationScreen> {
  final _search = TextEditingController();
  final Set<String> _sending = {};
  bool _finalizing = false;

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final drafts = ref.watch(tripDraftsProvider);
    final itinerary = ref.watch(tripItineraryControllerProvider(widget.tripId));
    final recommendations = ref.watch(
      companionRecommendationsProvider(widget.tripId),
    );
    final profile = ref.watch(profileControllerProvider);
    final query = _search.text.trim();
    final search = query.isEmpty
        ? null
        : ref.watch(tripUserSearchProvider(query));
    return AppScaffold(
      topBar: CreateTripHeader(
        step: 3,
        subtitle: 'Xác nhận & Mời bạn',
        onBack: () => context.pop(),
        onCancel: () => context.go('/trips'),
      ),
      bottomNavigationBar: CreateTripBottomBar(
        primaryLabel: '🚀 Hoàn tất & Khởi tạo chuyến đi',
        secondaryLabel: 'Bước 2',
        loading: _finalizing,
        onSecondary: () => context.pop(),
        onPrimary: _finalize,
      ),
      body: drafts.when(
        loading: () => const AppLoading(),
        error: (error, _) => AppErrorView(
          title: 'Không thể tải bản nháp',
          message: _errorMessage(error),
          onRetry: () => ref.invalidate(tripDraftsProvider),
        ),
        data: (items) {
          final matches = items.where((trip) => trip.id == widget.tripId);
          if (matches.isEmpty) {
            return const AppEmptyView(
              title: 'Không tìm thấy bản nháp',
              description: 'Trip có thể đã được hoàn tất hoặc bị xóa.',
              icon: Icons.error_outline,
            );
          }
          final trip = matches.first;
          return ListView(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.screenHorizontal,
              AppSpacing.md,
              AppSpacing.screenHorizontal,
              AppSpacing.xl,
            ),
            children: [
              if (trip.visibility == TripVisibility.public)
                Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.md),
                  child: Text(
                    'Chuyến lập kế hoạch chưa xuất hiện trên Khám phá. '
                    'Khi muốn tuyển bạn đồng hành, hãy đăng từ banner trên Trang chủ.',
                    style: AppTypography.caption.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              CreateTripSection(
                title: 'Mời bạn đồng hành',
                subtitle: 'Tối đa ${trip.maxMembers} người',
                icon: Icons.group_add_outlined,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _InviteCode(code: trip.inviteCode),
                    const SizedBox(height: AppSpacing.md),
                    TextField(
                      controller: _search,
                      onChanged: (_) => setState(() {}),
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        hintText: 'Tìm theo tên hoặc @username...',
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    if (search != null)
                      search.when(
                        loading: () => const AppLoading(),
                        error: (error, _) => Text(_errorMessage(error)),
                        data: (page) => _PeopleList(
                          users: page.items,
                          sending: _sending,
                          onInvite: _invite,
                        ),
                      )
                    else ...[
                      Text(
                        'Gợi ý bạn đồng hành',
                        style: AppTypography.caption.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      recommendations.when(
                        loading: () => const AppLoading(),
                        error: (error, _) => Text(_errorMessage(error)),
                        data: (items) => items.isEmpty
                            ? const Text('Chưa có gợi ý phù hợp.')
                            : Column(
                                children: items
                                    .map(
                                      (item) => _RecommendationTile(
                                        item: item,
                                        sending: _sending.contains(
                                          item.user.id,
                                        ),
                                        onInvite: () => _invite(item.user),
                                      ),
                                    )
                                    .toList(),
                              ),
                      ),
                    ],
                    const Divider(height: AppSpacing.xl),
                    profile.when(
                      loading: () => const SizedBox.shrink(),
                      error: (_, _) => const SizedBox.shrink(),
                      data: (user) => Row(
                        children: [
                          AppAvatar(
                            imageUrl: user.avatarUrl,
                            initials: user.initials,
                            size: 38,
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          Expanded(
                            child: Text(
                              user.displayName ?? user.username,
                              style: AppTypography.cardTitle,
                            ),
                          ),
                          const Chip(label: Text('Trưởng nhóm')),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              CreateTripSection(
                title: 'Ngân sách',
                subtitle: 'Thông tin dự kiến của hành trình',
                icon: Icons.account_balance_wallet_outlined,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _budgetLabel(trip),
                      style: AppTypography.cardTitle.copyWith(
                        color: AppColors.primaryActive,
                      ),
                    ),
                    if (trip.estimatedBudgetPerPerson != null)
                      Padding(
                        padding: const EdgeInsets.only(top: AppSpacing.sm),
                        child: Text(
                          '${trip.estimatedBudgetPerPerson} '
                          '${trip.budgetCurrency ?? ''} / người',
                          style: AppTypography.sectionTitle,
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              itinerary.when(
                loading: () => const AppLoading(),
                error: (error, _) => Text(_errorMessage(error)),
                data: (itineraryData) => _TripSummary(
                  trip: trip,
                  destinations: itineraryData.destinations,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _invite(TripCreationUser user) async {
    if (_sending.contains(user.id)) return;
    setState(() => _sending.add(user.id));
    try {
      await ref
          .read(tripInvitationsControllerProvider.notifier)
          .invite(
            CreateTripInvitationRequest(
              tripId: widget.tripId,
              inviteeId: user.id,
            ),
          );
      ref.invalidate(companionRecommendationsProvider(widget.tripId));
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Đã gửi lời mời tới ${user.displayName}.')),
        );
      }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(_errorMessage(error))));
      }
    } finally {
      if (mounted) setState(() => _sending.remove(user.id));
    }
  }

  Future<void> _finalize() async {
    setState(() => _finalizing = true);
    try {
      await ref
          .read(createTripControllerProvider.notifier)
          .finalize(widget.tripId);
      if (mounted) context.go('/trips');
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(_errorMessage(error))));
      }
    } finally {
      if (mounted) setState(() => _finalizing = false);
    }
  }
}

class _InviteCode extends StatelessWidget {
  const _InviteCode({required this.code});
  final String code;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(AppSpacing.md),
    decoration: BoxDecoration(
      color: AppColors.primaryLight,
      borderRadius: BorderRadius.circular(18),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Mã mời chuyến đi bí mật:'),
        Row(
          children: [
            const Icon(Icons.key, color: AppColors.primary),
            const SizedBox(width: AppSpacing.sm),
            Expanded(child: Text(code, style: AppTypography.sectionTitle)),
            OutlinedButton.icon(
              onPressed: () async {
                await Clipboard.setData(ClipboardData(text: code));
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Đã sao chép mã mời.')),
                  );
                }
              },
              icon: const Icon(Icons.copy),
              label: const Text('Sao chép'),
            ),
          ],
        ),
      ],
    ),
  );
}

class _RecommendationTile extends StatelessWidget {
  const _RecommendationTile({
    required this.item,
    required this.sending,
    required this.onInvite,
  });
  final CompanionRecommendation item;
  final bool sending;
  final VoidCallback onInvite;

  @override
  Widget build(BuildContext context) => ListTile(
    contentPadding: EdgeInsets.zero,
    leading: AppAvatar(initials: _initials(item.user.displayName), size: 44),
    title: Text(item.user.displayName),
    subtitle: Text(
      '@${item.user.username} • ${item.tripsTogetherCount} chuyến từng đi cùng',
    ),
    trailing: item.invitationStatus == 'PENDING'
        ? const Chip(label: Text('Đã gửi'))
        : FilledButton(
            onPressed: sending ? null : onInvite,
            child: Text(sending ? 'Đang gửi' : 'Mời'),
          ),
  );
}

class _PeopleList extends StatelessWidget {
  const _PeopleList({
    required this.users,
    required this.sending,
    required this.onInvite,
  });
  final List<TripCreationUser> users;
  final Set<String> sending;
  final ValueChanged<TripCreationUser> onInvite;

  @override
  Widget build(BuildContext context) => users.isEmpty
      ? const Text('Không tìm thấy người dùng phù hợp.')
      : Column(
          children: users
              .map(
                (user) => ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: AppAvatar(
                    initials: _initials(user.displayName),
                    size: 44,
                  ),
                  title: Text(user.displayName),
                  subtitle: Text('@${user.username}'),
                  trailing: FilledButton(
                    onPressed: sending.contains(user.id)
                        ? null
                        : () => onInvite(user),
                    child: const Text('Mời'),
                  ),
                ),
              )
              .toList(),
        );
}

class _TripSummary extends StatelessWidget {
  const _TripSummary({required this.trip, required this.destinations});
  final Trip trip;
  final List<DestinationItinerary> destinations;

  @override
  Widget build(BuildContext context) {
    final activityCount = destinations.fold<int>(
      0,
      (sum, destination) =>
          sum +
          destination.days.fold<int>(
            0,
            (daySum, day) => daySum + day.activities.length,
          ),
    );
    return CreateTripSection(
      title: 'Tóm tắt hành trình trước khi xuất bản',
      icon: Icons.task_alt_outlined,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (trip.coverImageUrl != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                trip.coverImageUrl!,
                height: 150,
                fit: BoxFit.cover,
              ),
            ),
          const SizedBox(height: AppSpacing.sm),
          Text(trip.name, style: AppTypography.sectionTitle),
          const SizedBox(height: AppSpacing.sm),
          _SummaryRow(
            icon: Icons.calendar_month_outlined,
            text: '${_date(trip.startDate)} – ${_date(trip.endDate)}',
          ),
          _SummaryRow(
            icon: Icons.route_outlined,
            text:
                '${destinations.map((item) => item.city).join(' → ')} '
                '(${destinations.length} điểm dừng, $activityCount hoạt động)',
          ),
          _SummaryRow(
            icon: Icons.groups_outlined,
            text: '${trip.tripType.name} • tối đa ${trip.maxMembers} người',
          ),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({required this.icon, required this.text});
  final IconData icon;
  final String text;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
    child: Row(
      children: [
        Icon(icon, color: AppColors.primary),
        const SizedBox(width: AppSpacing.sm),
        Expanded(child: Text(text)),
      ],
    ),
  );
}

String _budgetLabel(Trip trip) => switch (trip.budgetLevel?.name) {
  'low' => 'Tiết kiệm',
  'medium' => 'Tiêu chuẩn',
  'high' => 'Cao cấp',
  _ => 'Chưa chọn phân khúc',
};
String _date(DateTime value) => '${value.day}/${value.month}/${value.year}';
String _initials(String value) => value
    .trim()
    .split(RegExp(r'\s+'))
    .where((part) => part.isNotEmpty)
    .take(2)
    .map((part) => part[0].toUpperCase())
    .join();
String _errorMessage(Object error) =>
    error is ApiException ? error.message : 'Đã xảy ra lỗi. Vui lòng thử lại.';
