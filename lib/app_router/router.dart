import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app/discover/view/discover.dart';
import 'package:my_app/favorites/view/favorites.dart';
import 'package:my_app/root/root.dart';

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
                      child: FavoritesView(),
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
                      child: DiscoverView(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      );
}
