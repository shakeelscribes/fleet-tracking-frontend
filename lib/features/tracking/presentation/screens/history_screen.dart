import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/utils/app_localizations_ext.dart';
import '../../../../core/widgets/app_error_widget.dart';
import '../controllers/tracking_providers.dart';

/// PDF surface 4: history of GPS points for the driver's own vehicle.
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
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(
                    Icons.near_me_outlined,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  title: Text(
                    '${p.lat.toStringAsFixed(5)}, ${p.lng.toStringAsFixed(5)}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  subtitle: Text(
                    '${p.speed.toStringAsFixed(1)} ${l10n.kmph}'
                    ' · ${timeFormat.format(p.recordedAt.toLocal())}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
