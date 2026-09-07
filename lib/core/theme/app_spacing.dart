/// 8pt spacing grid (design skill): named constants, never scattered literals.
///
/// Use with ScreenUtil: `AppSpacing.md.w`, `AppSpacing.lg.h`.
abstract final class AppSpacing {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
}

/// Corner radii - one family, deliberately not the Material default 4dp.
abstract final class AppRadius {
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
}
