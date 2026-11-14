import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/testing/e2e_keys.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/widget/app_chip.dart';

import '../profile_count_format.dart';

enum ProfileContentTab { trips, dna, saved, posts }

class ProfileContentTabs extends StatelessWidget {
  const ProfileContentTabs({
    super.key,
    required this.value,
    required this.onChanged,
    required this.tripCount,
    required this.savedCount,
    required this.postCount,
  });

  final ProfileContentTab value;
  final ValueChanged<ProfileContentTab> onChanged;
  final int tripCount;
  final int savedCount;
  final int postCount;

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      children: [
        AppChip(
          label: 'Chuyến đi (${formatProfileCount(tripCount)})',
          leadingIcon: Icons.luggage_outlined,
          selected: value == ProfileContentTab.trips,
          onTap: () => onChanged(ProfileContentTab.trips),
        ),
        const SizedBox(width: AppSpacing.xs),
        AppChip(
          label: 'Chỉ số DNA',
          leadingIcon: Icons.insights_outlined,
          selected: value == ProfileContentTab.dna,
          onTap: () => onChanged(ProfileContentTab.dna),
        ),
        const SizedBox(width: AppSpacing.xs),
        AppChip(
          key: E2eKeys.profileSavedTab,
          label: 'Đã lưu (${formatProfileCount(savedCount)})',
          leadingIcon: Icons.bookmark_outline_rounded,
          selected: value == ProfileContentTab.saved,
          onTap: () => onChanged(ProfileContentTab.saved),
        ),
        const SizedBox(width: AppSpacing.xs),
        AppChip(
          label: 'Bài viết (${formatProfileCount(postCount)})',
          leadingIcon: Icons.grid_on_rounded,
          selected: value == ProfileContentTab.posts,
          onTap: () => onChanged(ProfileContentTab.posts),
        ),
      ],
    ),
  );
}
