import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/app_localizations_ext.dart';

/// Driver bottom navigation: Home / Map / History (grilling-locked 3 tabs).
class DriverShellScreen extends StatelessWidget {
  const DriverShellScreen({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  static const _destinations = [
    (path: '/home', icon: Icons.home_outlined, selected: Icons.home),
    (path: '/map', icon: Icons.map_outlined, selected: Icons.map),
    (path: '/history', icon: Icons.history_outlined, selected: Icons.history),
  ];

  @override
  Widget build(BuildContext context) {
    final branchIndex = navigationShell.currentIndex;

    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: branchIndex,
        onDestinationSelected: (i) =>
            navigationShell.goBranch(i, initialLocation: branchIndex == i),
        destinations: [
          NavigationDestination(
            icon: Icon(_destinations[0].icon),
            selectedIcon: Icon(_destinations[0].selected),
            label: context.l10n.navHome,
          ),
          NavigationDestination(
            icon: Icon(_destinations[1].icon),
            selectedIcon: Icon(_destinations[1].selected),
            label: context.l10n.navMap,
          ),
          NavigationDestination(
            icon: Icon(_destinations[2].icon),
            selectedIcon: Icon(_destinations[2].selected),
            label: context.l10n.navHistory,
          ),
        ],
      ),
    );
  }
}
