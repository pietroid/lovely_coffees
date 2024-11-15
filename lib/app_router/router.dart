import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lovely_coffees/discover/view/discover_page.dart';
import 'package:lovely_coffees/favorites/view/favorites_page.dart';
import 'package:lovely_coffees/root/root.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorFavoritesKey =
    GlobalKey<NavigatorState>(debugLabel: 'favorites');
final _shellNavigatorDiscoverKey =
    GlobalKey<NavigatorState>(debugLabel: 'discover');

class AppRouter {
  GoRouter get router => GoRouter(
        initialLocation: '/favorites',
        navigatorKey: _rootNavigatorKey,
        debugLogDiagnostics: true,
        routes: [
          StatefulShellRoute.indexedStack(
            builder: (context, state, navigationShell) => Root(
              navigationShell: navigationShell,
            ),
            branches: [
              StatefulShellBranch(
                navigatorKey: _shellNavigatorFavoritesKey,
                routes: [
                  GoRoute(
                    path: '/favorites',
                    pageBuilder: (context, state) => const NoTransitionPage(
                      child: FavoritesPage(),
                    ),
                  ),
                ],
              ),
              StatefulShellBranch(
                navigatorKey: _shellNavigatorDiscoverKey,
                routes: [
                  GoRoute(
                    path: '/discover',
                    pageBuilder: (context, state) => const NoTransitionPage(
                      child: DiscoverPage(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      );
}
