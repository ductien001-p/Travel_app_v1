abstract final class AppSizes {
  static const topBarMinHeight = 56.0;
  static const topBarMaxHeight = 64.0;
  static const iconButton = 40.0;
  static const buttonPrimaryHeight = 56.0;
  static const buttonSecondaryHeight = 44.0;
  static const inputMinHeight = 52.0;
  static const searchMinHeight = 50.0;
  static const avatarSm = 32.0;
  static const avatarMd = 40.0;
  static const avatarLg = 56.0;
  static const avatarXl = 80.0;
  static const bottomNavHeight = 76.0;

  /// Matches [AppBottomNavigation] `SafeArea(minimum: … bottom: 10)`.
  static const bottomNavOuterBottom = 10.0;
  static const fabSize = 56.0;

  /// Vertical space the floating shell bottom nav occupies from the screen bottom.
  static double shellBottomNavClearance(double systemBottomInset) {
    final outer = systemBottomInset > bottomNavOuterBottom
        ? systemBottomInset
        : bottomNavOuterBottom;
    return bottomNavHeight + outer;
  }
}
