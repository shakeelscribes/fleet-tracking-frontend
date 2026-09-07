import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:latlong2/latlong.dart';

import '../../../../core/models/vehicle_live.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/app_localizations_ext.dart';
import '../../../../core/widgets/app_error_widget.dart';
import '../../../../core/widgets/status_chip.dart';
import '../controllers/tracking_providers.dart';

/// PDF surface 3: live map - assigned route polyline (OSM tiles, no API
/// key) + the bus marker that tracks the 5s live poll.
class MapScreen extends HookConsumerWidget {
  const MapScreen({super.key});

  static final MapController _mapController = MapController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final route = ref.watch(routePolylineProvider);
    final live = ref.watch(vehicleLiveProvider);
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.mapTitle)),
      body: route.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => AppErrorWidget(
          error: e,
          onRetry: () => ref.invalidate(routePolylineProvider),
        ),
        data: (r) {
          final points = r.waypoints.map((w) => LatLng(w.lat, w.lng)).toList();
          final hasRoute = points.length >= 2;

          return Stack(
            children: [
              FlutterMap(
                mapController: _mapController,
                options: MapOptions(
                  initialCenter: hasRoute
                      ? points.first
                      : const LatLng(12.9716, 77.5946),
                  initialZoom: hasRoute ? 14 : 11,
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.shakeelscribes.fleet_tracker',
                  ),
                  if (hasRoute)
                    PolylineLayer(
                      polylines: [
                        Polyline(
                          points: points,
                          strokeWidth: 4.5,
                          color: AppColors.routeLine,
                          // Soft teal halo under the line - premium depth
                          // without gradients on the tiles themselves.
                          borderStrokeWidth: 8,
                          borderColor: AppColors.routeLine.withValues(
                            alpha: 0.18,
                          ),
                        ),
                      ],
                    ),
                  live.when(
                    loading: () => const MarkerLayer(markers: []),
                    error: (e, _) => const MarkerLayer(markers: []),
                    data: (v) => MarkerLayer(
                      markers: [
                        if (v.lat != null && v.lng != null)
                          Marker(
                            point: LatLng(v.lat!, v.lng!),
                            width: 44.w,
                            height: 44.w,
                            child: const _BusMarker(),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
              // Status overlay - glass pill so the live status floats over
              // the tiles with real depth (one of two BackdropFilters in
              // the app; the other is the fleet legend).
              Positioned(
                top: 12.h,
                left: 12.w,
                right: 12.w,
                child: SafeArea(
                  child: Row(
                    children: [
                      live.maybeWhen(
                        data: (v) => ClipRRect(
                          borderRadius: BorderRadius.circular(999.r),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
                            child: Container(
                              padding: EdgeInsets.all(2.r),
                              decoration: BoxDecoration(
                                color: AppColors.glassDark,
                                borderRadius: BorderRadius.circular(999.r),
                                border: Border.all(
                                  color: Colors.white.withValues(alpha: 0.08),
                                ),
                              ),
                              child: StatusChip(
                                status: liveStatusOf(v.status),
                                compact: true,
                              ),
                            ),
                          ),
                        ),
                        orElse: () => const SizedBox.shrink(),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
              if (hasRoute)
                Positioned(
                  right: 12.w,
                  bottom: 24.h,
                  child: FloatingActionButton(
                    onPressed: () {
                      final bounds = LatLngBounds.fromPoints(points);
                      _mapController.fitCamera(
                        CameraFit.bounds(
                          bounds: bounds,
                          padding: EdgeInsets.all(48.w),
                        ),
                      );
                    },
                    child: const Icon(Icons.center_focus_strong_outlined),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

class _BusMarker extends StatelessWidget {
  const _BusMarker();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primary,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2.5),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.4),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Icon(
        Icons.directions_bus,
        size: 22.sp,
        color: AppColors.backgroundDark,
      ),
    );
  }
}
