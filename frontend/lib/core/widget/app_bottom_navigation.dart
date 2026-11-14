import 'package:flutter/material.dart';

import '../testing/e2e_keys.dart';
import '../theme/app_colors.dart';
import '../theme/app_radius.dart';
import '../theme/app_shadows.dart';
import '../theme/app_sizes.dart';
import '../theme/app_typography.dart';
import 'app_pressable.dart';

class AppBottomNavigation extends StatelessWidget {
  const AppBottomNavigation({
    super.key,
    required this.selectedIndex,
    required this.onDestinationSelected,
  });

  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  static const _items = [
    _NavItem(
      key: E2eKeys.navExplore,
      label: 'Explore',
      icon: Icons.explore_outlined,
      selectedIcon: Icons.explore_rounded,
    ),
    _NavItem(
      key: E2eKeys.navSocial,
      label: 'Social',
      icon: Icons.people_outline_rounded,
      selectedIcon: Icons.people_rounded,
    ),
    _NavItem(
      key: E2eKeys.navTrips,
      label: 'Trip',
      icon: Icons.luggage_outlined,
      selectedIcon: Icons.luggage_rounded,
    ),
    _NavItem(
      key: E2eKeys.navChat,
      label: 'Chat',
      icon: Icons.chat_bubble_outline_rounded,
      selectedIcon: Icons.chat_bubble_rounded,
    ),
    _NavItem(
      key: E2eKeys.navProfile,
      label: 'Profile',
      icon: Icons.person_outline_rounded,
      selectedIcon: Icons.person_rounded,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      minimum: const EdgeInsets.fromLTRB(
        12,
        0,
        12,
        AppSizes.bottomNavOuterBottom,
      ),
      child: Container(
        height: AppSizes.bottomNavHeight,
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 9),
        decoration: BoxDecoration(
          color: AppColors.glass85,
          borderRadius: BorderRadius.circular(AppRadius.sheet),
          border: Border.all(color: AppColors.glassBorder),
          boxShadow: AppShadows.level2,
        ),
        child: Row(
          children: [
            for (var index = 0; index < _items.length; index++)
              _buildDestination(index),
          ],
        ),
      ),
    );
  }

  Widget _buildDestination(int index) {
    return Expanded(
      child: _Destination(
        item: _items[index],
        selected: selectedIndex == index,
        onTap: () => onDestinationSelected(index),
      ),
    );
  }
}

class _Destination extends StatelessWidget {
  const _Destination({
    required this.item,
    required this.selected,
    required this.onTap,
  });

  final _NavItem item;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = selected ? AppColors.primary : AppColors.textTertiary;

    return AppPressable(
      key: item.key,
      onTap: onTap,
      pressedScale: 0.95,
      borderRadius: BorderRadius.circular(AppRadius.pill),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 7),
        decoration: BoxDecoration(
          color: selected ? AppColors.primary15 : Colors.transparent,
          borderRadius: BorderRadius.circular(AppRadius.pill),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              selected ? item.selectedIcon : item.icon,
              size: 22,
              color: color,
            ),
            const SizedBox(height: 2),
            Text(
              item.label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTypography.caption.copyWith(
                color: color,
                fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavItem {
  const _NavItem({
    required this.key,
    required this.label,
    required this.icon,
    required this.selectedIcon,
  });

  final Key key;
  final String label;
  final IconData icon;
  final IconData selectedIcon;
}
