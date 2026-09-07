import 'package:flutter/material.dart';

/// Fleet Tracker palette.
///
/// Seed rationale (design skill): **transit teal** - the hue of departure
/// boards, metro signage and public-transport wayfinding. It reads as
/// "official transit system" rather than "tech startup blue", which fits a
/// fleet-operations tool; amber and green are reserved as *status* colors so
/// the palette doubles as the tracking status language.
class AppColors {
  AppColors._();

  // Brand - teal anchor derived from transit signage.
  static const Color primary = Color(0xFF14B8A6); // teal-500
  static const Color primaryDeep = Color(
    0xFF0F766E,
  ); // teal-700 (light theme primary)
  static const Color primaryContainerDark = Color(0xFF0B3B36);
  static const Color primaryContainerLight = Color(0xFFCCF1EC);

  // Dark surfaces - near-black with a green cast so teal glows naturally.
  static const Color backgroundDark = Color(0xFF0C1211);
  static const Color surfaceDark = Color(0xFF141C1A);
  static const Color surfaceContainerDark = Color(0xFF1B2523);

  // Light surfaces - paper-white with the faintest teal cast.
  static const Color backgroundLight = Color(0xFFF5F8F7);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color surfaceContainerLight = Color(0xFFEAF0EE);

  // Text.
  static const Color textPrimaryDark = Color(0xFFE7EFED);
  static const Color textSecondaryDark = Color(0xFF9AB0AB);
  static const Color textPrimaryLight = Color(0xFF16211E);
  static const Color textSecondaryLight = Color(0xFF52645F);

  // Status language (shared with the backend's derived statuses).
  static const Color statusMoving = Color(0xFF34D399); // green-400
  static const Color statusIdle = Color(0xFFFBBF24); // amber-400
  static const Color statusOffline = Color(0xFF94A3B8); // slate-400

  // Route polyline on the map.
  static const Color routeLine = Color(0xFF2DD4BF); // teal-400
}
