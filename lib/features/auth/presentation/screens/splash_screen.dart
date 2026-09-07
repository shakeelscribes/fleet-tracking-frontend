import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/utils/app_localizations_ext.dart';
import '../../../../core/widgets/app_background.dart';

/// Brief brand splash shown while the AuthController restores the session.
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: AppBackground(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 88.h,
                height: 88.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppRadius.xl.r),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.primary.withValues(alpha: 0.22),
                      AppColors.primary.withValues(alpha: 0.05),
                    ],
                  ),
                  border: Border.all(
                    color: AppColors.primary.withValues(alpha: 0.30),
                  ),
                ),
                child: Icon(
                  Icons.directions_bus_outlined,
                  size: 44.sp,
                  color: AppColors.primary,
                ),
              ),
              20.verticalSpace,
              Text(
                context.l10n.appTitle,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              24.verticalSpace,
              const SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
