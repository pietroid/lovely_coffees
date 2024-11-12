import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lovely_coffees/app_router/router.dart';
import 'package:lovely_coffees/discover/data/repositories/discover_repository.dart';
import 'package:lovely_coffees/favorites/data/repositories/favorite_item_repository.dart';
import 'package:lovely_coffees/favorites/data/repositories/favorites_repository.dart';
import 'package:lovely_coffees/l10n/l10n.dart';

class App extends StatelessWidget {
  const App({
    required this.favoritesRepository,
    required this.favoriteItemRepository,
    required this.discoverRepository,
    super.key,
  });

  final FavoritesRepository favoritesRepository;
  final FavoriteItemRepository favoriteItemRepository;
  final DiscoverRepository discoverRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(
          value: favoritesRepository,
        ),
        RepositoryProvider.value(
          value: favoriteItemRepository,
        ),
        RepositoryProvider.value(
          value: discoverRepository,
        ),
      ],
      child: MaterialApp.router(
        themeMode: ThemeMode.dark,
        routerConfig: AppRouter().router,
        theme: ThemeData(
          useMaterial3: true,
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
        ),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
      ),
    );
  }
}
