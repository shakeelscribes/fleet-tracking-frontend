import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/providers/auth_provider.dart';
import '../../../../core/routing/app_router.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/models/vehicle_live.dart';
import '../../../../core/utils/app_localizations_ext.dart';
import '../../../../core/widgets/app_error_widget.dart';
import '../../../../core/widgets/status_chip.dart';
import '../controllers/tracking_providers.dart';

/// PDF surface 2: driver home - the strictly-own assignment (route +
/// vehicle) plus live GPS status, polled every 5 seconds.
class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final assignment = ref.watch(assignmentProvider);
    final live = ref.watch(vehicleLiveProvider);
    final profile = ref.watch(authControllerProvider).value as AuthSignedIn?;
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.appTitle),
        actions: [
          IconButton(
            tooltip: l10n.logout,
            icon: const Icon(Icons.logout_outlined),
            onPressed: () => ref.read(authControllerProvider.notifier).logout(),
          ),
        ],
      ),
      body: assignment.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => AppErrorWidget(
          error: e,
          onRetry: () => ref.invalidate(assignmentProvider),
        ),
        data: (a) {
          final route = a.route;
          final vehicle = a.vehicle;
          if (route == null || vehicle == null) {
            return const _NoAssignment();
          }
          return ListView(
            padding: EdgeInsets.all(AppSpacing.md.w),
            children: [
              Text(
                l10n.homeGreeting,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              8.verticalSpace,
              Text(
                '${profile?.profile.email ?? ''} · ${l10n.driverBadge}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              24.verticalSpace,
              Card(
                child: Padding(
                  padding: EdgeInsets.all(AppSpacing.md.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.routeLabel,
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                      4.verticalSpace,
                      Text(
                        route.name,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      16.verticalSpace,
                      Text(
                        l10n.vehicleLabel,
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                      4.verticalSpace,
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              '${vehicle.code} · ${vehicle.name}',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              16.verticalSpace,
              Card(
                child: Padding(
                  padding: EdgeInsets.all(AppSpacing.md.w),
                  child: live.when(
                    loading: () => const Padding(
                      padding: EdgeInsets.all(24),
                      child: Center(child: CircularProgressIndicator()),
                    ),
                    error: (e, _) => AppErrorWidget(
                      error: e,
                      onRetry: () => ref.invalidate(vehicleLiveProvider),
                    ),
                    data: (v) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                l10n.liveStatus,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ),
                            StatusChip(status: liveStatusOf(v.status)),
                          ],
                        ),
                        16.verticalSpace,
                        if (v.lat == null || v.lng == null)
                          Text(
                            l10n.statusNoFix,
                            style: Theme.of(context).textTheme.bodySmall,
                          )
                        else ...[
                          _StatRow(
                            label: l10n.speed,
                            value:
                                '${v.speed?.toStringAsFixed(1) ?? '0.0'} ${l10n.kmph}',
                          ),
                          8.verticalSpace,
                          _StatRow(
                            label: l10n.lastUpdate,
                            value: v.recordedAt == null
                                ? '—'
                                : _timeAgo(context, v.recordedAt!),
                          ),
                          8.verticalSpace,
                          _StatRow(
                            label: 'Lat, Lng',
                            value:
                                '${v.lat!.toStringAsFixed(5)}, ${v.lng!.toStringAsFixed(5)}',
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
              16.verticalSpace,
              OutlinedButton.icon(
                onPressed: () => context.go(const MapRoute().location),
                icon: const Icon(Icons.map_outlined),
                label: Text(l10n.navMap),
              ),
            ],
          );
        },
      ),
    );
  }

  String _timeAgo(BuildContext context, DateTime t) {
    final diff = DateTime.now().difference(t);
    if (diff.inSeconds < 60) return context.l10n.justNow;
    if (diff.inMinutes < 60) return '${diff.inMinutes} min';
    return '${diff.inHours} h';
  }
}

class _NoAssignment extends StatelessWidget {
  const _NoAssignment();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(AppSpacing.xl.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.assignment_outlined,
              size: 56.sp,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            16.verticalSpace,
            Text(
              context.l10n.noAssignment,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}

class _StatRow extends StatelessWidget {
  const _StatRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: Theme.of(context).textTheme.bodySmall),
        Text(value, style: Theme.of(context).textTheme.titleMedium),
      ],
    );
  }
}
