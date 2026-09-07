import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/app_colors.dart';

/// Layered brand backdrop for entry surfaces (login, splash): a subtle
/// vertical lift plus one restrained radial teal glow - depth without
/// runtime cost (static decoration, no animation loop).
class AppBackground extends StatelessWidget {
  const AppBackground({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: isDark
              ? [const Color(0xFF111B19), AppColors.backgroundDark]
              : [Colors.white, AppColors.backgroundLight],
        ),
      ),
      child: Stack(
        children: [
          if (isDark)
            Positioned(
              top: -160.h,
              left: -80.w,
              right: -80.w,
              child: Container(
                height: 420.h,
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    colors: [
                      AppColors.primary.withValues(alpha: 0.13),
                      AppColors.primary.withValues(alpha: 0.0),
                    ],
                  ),
                ),
              ),
            ),
          child,
        ],
      ),
    );
  }
}
