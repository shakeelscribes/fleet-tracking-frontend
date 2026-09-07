import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../models/vehicle_live.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../utils/app_localizations_ext.dart';

/// The shared status language - same colors as the polyline/brand, one
/// visual vocabulary across Home, Map and Fleet screens.
///
/// Premium pass: the MOVING dot breathes (motion conveys "live telemetry";
/// idle/offline stay still so color isn't the only signal). Respects the
/// system reduced-motion setting.
class StatusChip extends StatefulWidget {
  const StatusChip({super.key, required this.status, this.compact = false});

  final LiveStatus status;
  final bool compact;

  @override
  State<StatusChip> createState() => _StatusChipState();
}

class _StatusChipState extends State<StatusChip> {
  Timer? _timer;
  bool _up = false;

  @override
  void initState() {
    super.initState();
    _start();
  }

  @override
  void didUpdateWidget(StatusChip oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.status != widget.status) {
      _timer?.cancel();
      _up = false;
      _start();
    }
  }

  void _start() {
    if (widget.status == LiveStatus.moving) {
      _timer = Timer.periodic(AppMotion.pulse, (_) {
        if (MediaQuery.disableAnimationsOf(context)) return;
        setState(() => _up = !_up);
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final (color, label) = switch (widget.status) {
      LiveStatus.moving => (AppColors.statusMoving, context.l10n.statusMoving),
      LiveStatus.idle => (AppColors.statusIdle, context.l10n.statusIdle),
      LiveStatus.offline => (
        AppColors.statusOffline,
        context.l10n.statusOffline,
      ),
    };

    final dotSize = (widget.compact ? 6 : 8).r;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: (widget.compact ? 8 : 10).w,
        vertical: (widget.compact ? 3 : 5).h,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(999.r),
        border: Border.all(color: color.withValues(alpha: 0.45)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Breathing dot: a soft halo that expands/contracts, glowing only
          // for MOVING (live telemetry), static otherwise.
          Container(
            width: dotSize,
            height: dotSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
              boxShadow: [
                BoxShadow(
                  color: color.withValues(alpha: _up ? 0.55 : 0.15),
                  blurRadius: _up ? 9 : 3,
                  spreadRadius: _up ? 2.5 : 0.5,
                ),
              ],
            ),
          ),
          6.horizontalSpace,
          Text(
            label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: color,
              fontWeight: FontWeight.w600,
              fontSize: (widget.compact ? 10 : 12).sp,
            ),
          ),
        ],
      ),
    );
  }
}
