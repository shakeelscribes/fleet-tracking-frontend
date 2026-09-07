import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_colors.dart';
import 'app_spacing.dart';

/// Explicit TextTheme (design skill: never ship the stock scale untouched).
///
/// Typeface: Inter - neutral, tabular-friendly numerals for coordinates and
/// speeds; paired with Space Grotesk for display so headers feel like
/// departure-board signage rather than a settings page.
abstract final class AppTextTheme {
  static TextTheme dark(BuildContext context) => _build(
    context,
    textPrimary: AppColors.textPrimaryDark,
    textSecondary: AppColors.textSecondaryDark,
  );

  static TextTheme light(BuildContext context) => _build(
    context,
    textPrimary: AppColors.textPrimaryLight,
    textSecondary: AppColors.textSecondaryLight,
  );

  static TextTheme _build(
    BuildContext context, {
    required Color textPrimary,
    required Color textSecondary,
  }) {
    final display = GoogleFonts.spaceGrotesk(color: textPrimary);
    final body = GoogleFonts.inter(color: textPrimary);
    return TextTheme(
      headlineMedium: display.copyWith(
        fontSize: 28.sp,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.5,
      ),
      titleLarge: display.copyWith(
        fontSize: 20.sp,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.2,
      ),
      titleMedium: body.copyWith(fontSize: 16.sp, fontWeight: FontWeight.w600),
      bodyLarge: body.copyWith(fontSize: 16.sp, height: 1.4),
      bodyMedium: body.copyWith(
        fontSize: 14.sp,
        height: 1.4,
        color: textPrimary,
      ),
      bodySmall: body.copyWith(
        fontSize: 12.sp,
        color: textSecondary,
        height: 1.3,
      ),
      labelLarge: body.copyWith(
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.2,
      ),
      labelSmall: body.copyWith(
        fontSize: 11.sp,
        fontWeight: FontWeight.w600,
        color: textSecondary,
        letterSpacing: 0.6,
      ),
    );
  }
}

/// Data-figure styles (ui-ux-pro-max "Mono+Sans data" pattern): display
/// face + tabular numerals so coordinates, speeds and timestamps align in
/// columns and don't jitter as digits stream in every 5 seconds.
abstract final class AppDataText {
  static TextStyle large(Color color) => GoogleFonts.spaceGrotesk(
    fontSize: 26.sp,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.3,
    color: color,
    fontFeatures: const [FontFeature.tabularFigures()],
  );

  static TextStyle medium(Color color) => GoogleFonts.inter(
    fontSize: 14.sp,
    fontWeight: FontWeight.w600,
    color: color,
    fontFeatures: const [FontFeature.tabularFigures()],
  );
}

/// Shared motion tokens (skill: distance-aware timing, not one duration
/// everywhere). Entry = screens/hero content arriving; pulse = the live
/// breathing dot; press = ripple-adjacent feedback.
abstract final class AppMotion {
  static const Duration entry = Duration(milliseconds: 260);
  static const Duration press = Duration(milliseconds: 120);
  static const Duration pulse = Duration(milliseconds: 1600);
  static const Curve entryCurve = Curves.easeOutCubic;
}

/// Fully-explicit component themes (design skill checklist: no default
/// AppBar/Card/Button anywhere). Dark-first, light fully styled too.
abstract final class AppTheme {
  static ThemeData dark(BuildContext context) => _base(
    context,
    brightness: Brightness.dark,
    background: AppColors.backgroundDark,
    surface: AppColors.surfaceDark,
    surfaceContainer: AppColors.surfaceContainerDark,
    textPrimary: AppColors.textPrimaryDark,
    textSecondary: AppColors.textSecondaryDark,
    primary: AppColors.primary,
    primaryContainer: AppColors.primaryContainerDark,
    onPrimaryContainer: AppColors.textPrimaryDark,
  );

  static ThemeData light(BuildContext context) => _base(
    context,
    brightness: Brightness.light,
    background: AppColors.backgroundLight,
    surface: AppColors.surfaceLight,
    surfaceContainer: AppColors.surfaceContainerLight,
    textPrimary: AppColors.textPrimaryLight,
    textSecondary: AppColors.textSecondaryLight,
    primary: AppColors.primaryDeep,
    primaryContainer: AppColors.primaryContainerLight,
    onPrimaryContainer: AppColors.primaryDeep,
  );

  static ThemeData _base(
    BuildContext context, {
    required Brightness brightness,
    required Color background,
    required Color surface,
    required Color surfaceContainer,
    required Color textPrimary,
    required Color textSecondary,
    required Color primary,
    required Color primaryContainer,
    required Color onPrimaryContainer,
  }) {
    final isDark = brightness == Brightness.dark;
    final colorScheme = ColorScheme(
      brightness: brightness,
      primary: primary,
      onPrimary: isDark ? AppColors.backgroundDark : Colors.white,
      primaryContainer: primaryContainer,
      onPrimaryContainer: onPrimaryContainer,
      secondary: AppColors.routeLine,
      onSecondary: AppColors.backgroundDark,
      error: Color(0xFFF87171),
      onError: Color(0xFF2B0B0B),
      surface: surface,
      onSurface: textPrimary,
      surfaceContainerHighest: surfaceContainer,
      onSurfaceVariant: textSecondary,
      outline: textSecondary.withValues(alpha: 0.4),
      outlineVariant: textSecondary.withValues(alpha: 0.18),
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: background,
      textTheme: AppTextTheme._build(
        context,
        textPrimary: textPrimary,
        textSecondary: textSecondary,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: textPrimary,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: GoogleFonts.spaceGrotesk(
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
          color: textPrimary,
        ),
      ),
      cardTheme: CardThemeData(
        color: surfaceContainer,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.md.r),
          side: BorderSide(
            color: isDark
                ? textSecondary.withValues(alpha: 0.10)
                : textSecondary.withValues(alpha: 0.14),
          ),
        ),
        margin: EdgeInsets.zero,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: colorScheme.onPrimary,
          minimumSize: Size.fromHeight(52.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.md.r),
          ),
          textStyle: GoogleFonts.inter(
            fontSize: 15.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primary,
          side: BorderSide(color: primary.withValues(alpha: 0.5)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.md.r),
          ),
          textStyle: GoogleFonts.inter(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surfaceContainer,
        hintStyle: GoogleFonts.inter(fontSize: 14.sp, color: textSecondary),
        contentPadding: EdgeInsets.symmetric(
          horizontal: AppSpacing.md.w,
          vertical: 14.h,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md.r),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md.r),
          borderSide: BorderSide(color: textSecondary.withValues(alpha: 0.18)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md.r),
          borderSide: BorderSide(color: primary, width: 1.6),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md.r),
          borderSide: BorderSide(color: colorScheme.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md.r),
          borderSide: BorderSide(color: colorScheme.error, width: 1.6),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: surface,
        indicatorColor: primaryContainer,
        height: 68.h,
        elevation: 0,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        iconTheme: WidgetStateProperty.resolveWith(
          (states) => IconThemeData(
            size: 22.sp,
            color: states.contains(WidgetState.selected)
                ? primary
                : textSecondary,
          ),
        ),
        labelTextStyle: WidgetStateProperty.resolveWith(
          (states) => GoogleFonts.inter(
            fontSize: 11.sp,
            fontWeight: states.contains(WidgetState.selected)
                ? FontWeight.w600
                : FontWeight.w400,
            color: states.contains(WidgetState.selected)
                ? primary
                : textSecondary,
          ),
        ),
      ),
      dividerTheme: DividerThemeData(
        color: textSecondary.withValues(alpha: 0.16),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: surfaceContainer,
        contentTextStyle: GoogleFonts.inter(
          fontSize: 14.sp,
          color: textPrimary,
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.sm.r),
        ),
      ),
    );
  }
}
