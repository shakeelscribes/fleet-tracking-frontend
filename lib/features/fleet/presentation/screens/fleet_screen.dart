import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:latlong2/latlong.dart';

import '../../../../core/models/admin_vehicle.dart';
import '../../../../core/models/vehicle_live.dart';
import '../../../../core/providers/auth_provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/app_localizations_ext.dart';
import '../../../../core/widgets/app_error_widget.dart';
import '../../../../core/widgets/status_chip.dart';
import '../controllers/fleet_providers.dart';

/// Admin surface (grilling-locked): all vehicles on one live map +
/// status chips, polling via the same cadence as the driver view.
class FleetScreen extends HookConsumerWidget {
  const FleetScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fleet = ref.watch(fleetProvider);
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.fleetTitle),
        actions: [
          IconButton(
            tooltip: l10n.logout,
            icon: const Icon(Icons.logout_outlined),
            onPressed: () => ref.read(authControllerProvider.notifier).logout(),
          ),
        ],
      ),
      body: fleet.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => AppErrorWidget(
          error: e,
          onRetry: () => ref.invalidate(fleetProvider),
        ),
        data: (vehicles) {
          final located = vehicles
              .where(
                (v) =>
                    v.currentLocation?.lat != null &&
                    v.currentLocation?.lng != null,
              )
              .toList();

          final points = located
              .map(
                (v) => LatLng(v.currentLocation!.lat!, v.currentLocation!.lng!),
              )
              .toList();

          return Stack(
            children: [
              FlutterMap(
                options: MapOptions(
                  initialCenter: points.isNotEmpty
                      ? points.first
                      : const LatLng(12.9716, 77.5946),
                  initialZoom: points.length == 1 ? 14 : 11,
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.shakeelscribes.fleet_tracker',
                  ),
                  if (points.length >= 2)
                    MarkerLayer(
                      markers: [
                        for (final v in located)
                          Marker(
                            point: LatLng(
                              v.currentLocation!.lat!,
                              v.currentLocation!.lng!,
                            ),
                            width: 44.w,
                            height: 44.w,
                            child: _FleetMarker(vehicle: v),
                          ),
                      ],
                    ),
                ],
              ),
              Positioned(
                top: 12.h,
                left: 12.w,
                right: 12.w,
                child: SafeArea(
                  // Glass legend - frosted panel listing each vehicle with
                  // its live chip (the second of two BackdropFilters in the
                  // app; readable over any tile imagery).
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(14.r),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 8.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.glassDark,
                          borderRadius: BorderRadius.circular(14.r),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.08),
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              l10n.fleetLegend.toUpperCase(),
                              style: Theme.of(context).textTheme.labelSmall
                                  ?.copyWith(
                                    color: AppColors.textSecondaryDark,
                                    fontSize: 9.sp,
                                    letterSpacing: 1.2,
                                  ),
                            ),
                            2.verticalSpace,
                            for (final v in located)
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 3.h),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      v.code,
                                      style: AppDataText.medium(
                                        AppColors.textPrimaryDark,
                                      ),
                                    ),
                                    10.horizontalSpace,
                                    StatusChip(
                                      status: liveStatusOf(
                                        v.currentLocation?.status ?? 'offline',
                                      ),
                                      compact: true,
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              if (located.isEmpty)
                Positioned(
                  bottom: 24.h,
                  left: 12.w,
                  right: 12.w,
                  child: Card(
                    child: Padding(
                      padding: EdgeInsets.all(AppSpacing.md.w),
                      child: Text(
                        l10n.fleetEmpty,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

class _FleetMarker extends StatelessWidget {
  const _FleetMarker({required this.vehicle});

  final AdminVehicle vehicle;

  @override
  Widget build(BuildContext context) {
    final status = liveStatusOf(vehicle.currentLocation?.status ?? 'offline');
    final color = switch (status) {
      LiveStatus.moving => AppColors.statusMoving,
      LiveStatus.idle => AppColors.statusIdle,
      LiveStatus.offline => AppColors.statusOffline,
    };

    return Container(
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2),
      ),
      child: Center(
        child: Text(
          vehicle.code.replaceAll(RegExp(r'[^0-9]'), ''),
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.backgroundDark,
          ),
        ),
      ),
    );
  }
}
