import 'package:flutter/material.dart';

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
    this.onCenterAction,
  });

  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;
  final VoidCallback? onCenterAction;

  static const _items = [
    _NavItem(
      label: 'Explore',
      icon: Icons.explore_outlined,
      selectedIcon: Icons.explore_rounded,
    ),
    _NavItem(
      label: 'Trips',
      icon: Icons.luggage_outlined,
      selectedIcon: Icons.luggage_rounded,
    ),
    _NavItem(
      label: 'Social',
      icon: Icons.people_outline_rounded,
      selectedIcon: Icons.people_rounded,
    ),
    _NavItem(
      label: 'Profile',
      icon: Icons.person_outline_rounded,
      selectedIcon: Icons.person_rounded,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final destinations = <Widget>[
      _buildDestination(0),
      _buildDestination(1),
      if (onCenterAction != null) const SizedBox(width: AppSizes.fabSize + 8),
      _buildDestination(2),
      _buildDestination(3),
    ];

    return SafeArea(
      top: false,
      minimum: const EdgeInsets.fromLTRB(12, 0, 12, 10),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          Container(
            height: AppSizes.bottomNavHeight,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 9),
            decoration: BoxDecoration(
              color: AppColors.glass85,
              borderRadius: BorderRadius.circular(AppRadius.sheet),
              border: Border.all(color: AppColors.glassBorder),
              boxShadow: AppShadows.level2,
            ),
            child: Row(children: destinations),
          ),
          if (onCenterAction != null)
            Positioned(
              top: -26,
              child: AppPressable(
                onTap: onCenterAction,
                pressedScale: 0.95,
                borderRadius: BorderRadius.circular(AppRadius.pill),
                child: Container(
                  width: AppSizes.fabSize,
                  height: AppSizes.fabSize,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      colors: [AppColors.primaryActive, AppColors.primary],
                    ),
                    boxShadow: AppShadows.primaryGlow,
                  ),
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.add_rounded,
                    color: AppColors.textInverse,
                    size: 28,
                  ),
                ),
              ),
            ),
        ],
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
      onTap: onTap,
      pressedScale: 0.95,
      borderRadius: BorderRadius.circular(AppRadius.pill),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 7),
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
    required this.label,
    required this.icon,
    required this.selectedIcon,
  });

  final String label;
  final IconData icon;
  final IconData selectedIcon;
}
