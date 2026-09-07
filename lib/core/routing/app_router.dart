import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/splash_screen.dart';
import '../../features/fleet/presentation/screens/fleet_screen.dart';
import '../../features/tracking/presentation/screens/driver_shell_screen.dart';
import '../../features/tracking/presentation/screens/history_screen.dart';
import '../../features/tracking/presentation/screens/home_screen.dart';
import '../../features/tracking/presentation/screens/map_screen.dart';
import '../providers/auth_provider.dart';

part 'app_router.g.dart';

@TypedGoRoute<SplashRoute>(path: '/splash')
class SplashRoute extends GoRouteData with $SplashRoute {
  const SplashRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const SplashScreen();
}

@TypedGoRoute<LoginRoute>(path: '/login')
class LoginRoute extends GoRouteData with $LoginRoute {
  const LoginRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const LoginScreen();
}

// --- Driver shell: Home / Map / History (PDF's three app surfaces) -----------

@TypedStatefulShellRoute<DriverShellRoute>(
  branches: [
    TypedStatefulShellBranch(routes: [TypedGoRoute<HomeRoute>(path: '/home')]),
    TypedStatefulShellBranch(routes: [TypedGoRoute<MapRoute>(path: '/map')]),
    TypedStatefulShellBranch(
      routes: [TypedGoRoute<HistoryRoute>(path: '/history')],
    ),
  ],
)
class DriverShellRoute extends StatefulShellRouteData {
  const DriverShellRoute();

  @override
  Widget builder(
    BuildContext context,
    GoRouterState state,
    StatefulNavigationShell navigationShell,
  ) => DriverShellScreen(navigationShell: navigationShell);
}

class HomeRoute extends GoRouteData with $HomeRoute {
  const HomeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const HomeScreen();
}

class MapRoute extends GoRouteData with $MapRoute {
  const MapRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const MapScreen();
}

class HistoryRoute extends GoRouteData with $HistoryRoute {
  const HistoryRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const HistoryScreen();
}

// --- Admin: single fleet-overview surface ------------------------------------

@TypedGoRoute<FleetRoute>(path: '/fleet')
class FleetRoute extends GoRouteData with $FleetRoute {
  const FleetRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const FleetScreen();
}

/// Role-aware guard (PDF: authorization is backend-enforced; the router only
/// routes by the role the backend reports via /me/profile).
@Riverpod(keepAlive: true)
class AppRouter extends _$AppRouter {
  @override
  GoRouter build() {
    final session = ref.watch(authControllerProvider);

    return GoRouter(
      initialLocation: '/splash',
      routes: $appRoutes,
      redirect: (context, state) {
        final loc = state.matchedLocation;

        // Session still restoring -> splash until AuthController settles.
        if (session.isLoading) {
          return loc == '/splash' ? null : '/splash';
        }

        final state0 = session.value;
        if (state0 is! AuthSignedIn) {
          return loc == '/login' ? null : '/login';
        }

        final isAdmin = state0.profile.isAdmin;
        return switch (loc) {
          '/login' || '/splash' => isAdmin ? '/fleet' : '/home',
          '/fleet' => isAdmin ? null : '/home',
          '/home' || '/map' || '/history' => isAdmin ? '/fleet' : null,
          _ => null,
        };
      },
    );
  }
}
