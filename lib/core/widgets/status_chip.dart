import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../models/vehicle_live.dart';
import '../theme/app_colors.dart';
import '../utils/app_localizations_ext.dart';

/// The shared status language - same colors as the polyline/brand, one
/// visual vocabulary across Home, Map and Fleet screens.
class StatusChip extends StatelessWidget {
  const StatusChip({super.key, required this.status, this.compact = false});

  final LiveStatus status;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final (color, label) = switch (status) {
      LiveStatus.moving => (AppColors.statusMoving, context.l10n.statusMoving),
      LiveStatus.idle => (AppColors.statusIdle, context.l10n.statusIdle),
      LiveStatus.offline => (
        AppColors.statusOffline,
        context.l10n.statusOffline,
      ),
    };

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: (compact ? 8 : 10).w,
        vertical: (compact ? 3 : 5).h,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(999.r),
        border: Border.all(color: color.withValues(alpha: 0.5)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: (compact ? 6 : 8).r,
            height: (compact ? 6 : 8).r,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          6.horizontalSpace,
          Text(
            label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: color,
              fontWeight: FontWeight.w600,
              fontSize: (compact ? 10 : 12).sp,
            ),
          ),
        ],
      ),
    );
  }
}
