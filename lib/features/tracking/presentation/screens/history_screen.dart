import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/models/history.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/app_localizations_ext.dart';
import '../../../../core/widgets/app_error_widget.dart';
import '../controllers/tracking_providers.dart';

/// PDF surface 4: history of GPS points for the driver's own vehicle.
///
/// Premium pass: a bearing-rotation leading mark (direction of travel),
/// tabular coordinates and a fixed-width timestamp column - the list reads
/// as a telemetry log, not a contacts list.
class HistoryScreen extends ConsumerWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final history = ref.watch(vehicleHistoryProvider);
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.historyTitle)),
      body: RefreshIndicator(
        onRefresh: () async => ref.invalidate(vehicleHistoryProvider),
        child: history.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => AppErrorWidget(
            error: e,
            onRetry: () => ref.invalidate(vehicleHistoryProvider),
          ),
          data: (h) {
            if (h.points.isEmpty) {
              return ListView(
                children: [
                  SizedBox(height: 120.h),
                  Icon(
                    Icons.timeline_outlined,
                    size: 56.sp,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  16.verticalSpace,
                  Text(
                    l10n.historyEmpty,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              );
            }
            final timeFormat = DateFormat('HH:mm:ss');
            return ListView.separated(
              padding: EdgeInsets.all(AppSpacing.md.w),
              itemCount: h.points.length,
              separatorBuilder: (_, _) => const Divider(height: 1),
              itemBuilder: (context, i) {
                final p = h.points[i];
                final heading = _bearingAt(h.points, i);
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  minLeadingWidth: 40.w,
                  // Compass needle: rotated to the bearing derived from the
                  // previous fix (north at 0); dimmed when direction is
                  // unknown (first point / zero distance).
                  leading: Transform.rotate(
                    angle: (heading ?? 0) * math.pi / 180,
                    child: Icon(
                      Icons.navigation_outlined,
                      size: 22.sp,
                      color: Theme.of(context).colorScheme.primary
                          .withValues(alpha: heading == null ? 0.4 : 1),
                    ),
                  ),
                  title: Text(
                    '${p.lat.toStringAsFixed(5)}, ${p.lng.toStringAsFixed(5)}',
                    style: AppDataText.medium(
                      Theme.of(context).colorScheme.onSurface,
                    ).copyWith(fontWeight: FontWeight.w500),
                  ),
                  subtitle: Text(
                    '${p.speed.toStringAsFixed(1)} ${l10n.kmph}'
                    '  ·  ${timeFormat.format(p.recordedAt.toLocal())}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontFeatures: const [
                        // Aligned timestamp column - digits never jitter.
                        FontFeature.tabularFigures(),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  /// Bearing (degrees clockwise from north) at [i], derived from the next
  /// (older) point. Longitude deltas are cos-latitude corrected. Null for
  /// the oldest point or zero-distance pairs.
  double? _bearingAt(List<HistoryPoint> pts, int i) {
    if (i + 1 >= pts.length) return null;
    final a = pts[i + 1]; // older
    final b = pts[i]; // newer
    final dy = b.lat - a.lat;
    final dx = (b.lng - a.lng) * math.cos(a.lat * math.pi / 180);
    if (dx == 0 && dy == 0) return null;
    return (math.atan2(dx, dy) * 180 / math.pi + 360) % 360;
  }
}
