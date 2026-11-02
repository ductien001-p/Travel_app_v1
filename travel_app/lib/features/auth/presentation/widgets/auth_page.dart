import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widget/app_scaffold.dart';
import '../../../../core/widget/app_top_bar.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({
    super.key,
    required this.title,
    required this.subtitle,
    required this.child,
    this.topBarTitle = 'Teal Horizon',
    this.onBack,
    this.heroIcon = Icons.explore_outlined,
  });

  final String title;
  final String subtitle;
  final Widget child;
  final String topBarTitle;
  final VoidCallback? onBack;
  final IconData heroIcon;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      topBar: AppTopBar(title: topBarTitle, onBack: onBack, transparent: true),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.screenHorizontal,
          AppSpacing.lg,
          AppSpacing.screenHorizontal,
          AppSpacing.xxl,
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Container(
                    width: 76,
                    height: 76,
                    decoration: const BoxDecoration(
                      color: AppColors.glass90,
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Icon(heroIcon, size: 34, color: AppColors.primary),
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: AppTypography.display,
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  subtitle,
                  textAlign: TextAlign.center,
                  style: AppTypography.body,
                ),
                const SizedBox(height: AppSpacing.xxl),
                child,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
