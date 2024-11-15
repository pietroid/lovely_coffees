import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lovely_coffees/favorites/blocs/favorites/favorites_bloc.dart';
import 'package:lovely_coffees/favorites/data/repositories/favorites_repository.dart';

class Root extends StatelessWidget {
  const Root({
    required this.navigationShell,
    super.key,
  });

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => FavoritesBloc(
            favoritesRepository: context.read<FavoritesRepository>(),
          )..add(FavoritesLoad()),
        ),
      ],
      child: RootContent(
        navigationShell: navigationShell,
      ),
    );
  }
}

class RootContent extends StatelessWidget {
  const RootContent({
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
          NavigationDestination(label: 'Favorites', icon: Icon(Icons.favorite)),
          NavigationDestination(label: 'Discover', icon: Icon(Icons.search)),
        ],
        onDestinationSelected: (index) => navigationShell.goBranch(
          index,
          initialLocation: index == navigationShell.currentIndex,
        ),
      ),
    );
  }
}
