import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/providers/auth_provider.dart';
import '../../../../core/routing/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_theme.dart';
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
    final colors = Theme.of(context).colorScheme;

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

              // Hero assignment card - raised gradient surface, icon rail,
              // hairline divider between the route and vehicle sections.
              Container(
                padding: EdgeInsets.all(AppSpacing.md.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppRadius.xl.r),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: Theme.of(context).brightness == Brightness.dark
                        ? [
                            colors.surfaceContainerHighest,
                            AppColors.surfaceRaisedDark,
                          ]
                        : [colors.surface, AppColors.surfaceRaisedLight],
                  ),
                  border: Border.all(
                    color: colors.onSurfaceVariant.withValues(
                      alpha: Theme.of(context).brightness == Brightness.dark
                          ? 0.10
                          : 0.14,
                    ),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        _IconTile(icon: Icons.route_outlined),
                        12.horizontalSpace,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                l10n.routeLabel.toUpperCase(),
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
                              2.verticalSpace,
                              Text(
                                route.name,
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: AppSpacing.md.h),
                      child: Divider(
                        height: 1,
                        thickness: 1,
                        color: colors.onSurfaceVariant.withValues(alpha: 0.10),
                      ),
                    ),
                    Row(
                      children: [
                        _IconTile(icon: Icons.directions_bus_outlined),
                        12.horizontalSpace,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                l10n.vehicleLabel.toUpperCase(),
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
                              2.verticalSpace,
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: vehicle.code,
                                      style: AppDataText.medium(
                                        colors.onSurface,
                                      ),
                                    ),
                                    TextSpan(
                                      text: '  ·  ${vehicle.name}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                            color: colors.onSurfaceVariant,
                                          ),
                                    ),
                                  ],
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              16.verticalSpace,

              // Live telemetry card - big tabular speed readout with a
              // pulsing status chip, stat tiles beneath.
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
                                l10n.liveStatus.toUpperCase(),
                                style: Theme.of(context).textTheme.labelSmall,
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
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: v.speed?.toStringAsFixed(1) ?? '0.0',
                                  style: AppDataText.large(colors.onSurface),
                                ),
                                TextSpan(
                                  text: '  ${l10n.kmph}',
                                  style: Theme.of(context).textTheme.labelSmall
                                      ?.copyWith(
                                        color: colors.onSurfaceVariant,
                                        fontSize: 13.sp,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: AppSpacing.md.h,
                            ),
                            child: Divider(
                              height: 1,
                              thickness: 1,
                              color: colors.onSurfaceVariant.withValues(
                                alpha: 0.10,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: _StatTile(
                                  label: l10n.lastUpdate,
                                  value: v.recordedAt == null
                                      ? '—'
                                      : _timeAgo(context, v.recordedAt!),
                                ),
                              ),
                              Container(
                                width: 1,
                                height: 36.h,
                                color: colors.onSurfaceVariant.withValues(
                                  alpha: 0.10,
                                ),
                              ),
                              Expanded(
                                child: _StatTile(
                                  label: 'Lat, Lng',
                                  value:
                                      '${v.lat!.toStringAsFixed(5)}, '
                                      '${v.lng!.toStringAsFixed(5)}',
                                ),
                              ),
                            ],
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

/// Squircle icon tile used on hero rows - teal-tinted glass with a
/// hairline border, consistent with the brand glow language.
class _IconTile extends StatelessWidget {
  const _IconTile({required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44.w,
      height: 44.w,
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(AppRadius.md.r),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.25)),
      ),
      child: Icon(icon, size: 22.sp, color: AppColors.primary),
    );
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

/// Stat tile with a micro label above a tabular value, separated from its
/// sibling by a vertical hairline.
class _StatTile extends StatelessWidget {
  const _StatTile({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.only(right: AppSpacing.md.w, left: AppSpacing.md.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label.toUpperCase(),
            style: Theme.of(context).textTheme.labelSmall,
          ),
          4.verticalSpace,
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppDataText.medium(colors.onSurface),
          ),
        ],
      ),
    );
  }
}
