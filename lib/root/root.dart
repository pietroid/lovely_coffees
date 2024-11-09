import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Root extends StatelessWidget {
  const Root({
    required this.navigationShell,
    super.key,
  });

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        destinations: const [
          NavigationDestination(label: 'Favorites', icon: Icon(Icons.home)),
          NavigationDestination(label: 'Discover', icon: Icon(Icons.settings)),
        ],
        onDestinationSelected: (index) => navigationShell.goBranch(
          index,
          initialLocation: index == navigationShell.currentIndex,
        ),
      ),
    );
  }
}
