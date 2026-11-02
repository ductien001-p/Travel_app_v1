import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/widget/app_chip.dart';
import 'package:travel_frontend_v1/core/widget/app_search_bar.dart';

import '../../application/trip_invite_friends_view.dart';

class TripInviteFriendsSearch extends StatelessWidget {
  const TripInviteFriendsSearch({
    super.key,
    required this.filter,
    required this.onFilter,
    required this.onQueryChanged,
    this.tripTravelPersona,
  });

  final TripInviteFriendsFilter filter;
  final ValueChanged<TripInviteFriendsFilter> onFilter;
  final ValueChanged<String> onQueryChanged;
  final String? tripTravelPersona;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppSearchBar(
          hintText: 'Tìm theo tên hoặc username',
          onChanged: onQueryChanged,
        ),
        const SizedBox(height: AppSpacing.sm),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              for (final item in TripInviteFriendsFilter.values) ...[
                AppChip(
                  label: _label(item),
                  selected: filter == item,
                  onTap: () => onFilter(item),
                ),
                const SizedBox(width: AppSpacing.xs),
              ],
            ],
          ),
        ),
      ],
    );
  }

  String _label(TripInviteFriendsFilter item) => switch (item) {
    TripInviteFriendsFilter.all => 'Tất cả bạn bè',
    TripInviteFriendsFilter.traveledTogether => 'Đã từng đi chung',
    TripInviteFriendsFilter.recent => 'Gần đây',
    TripInviteFriendsFilter.sameTaste => tripInviteSameTasteChipLabel(
      tripTravelPersona,
    ),
    TripInviteFriendsFilter.invited => 'Đã gửi lời mời',
  };
}
