import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/app_router/router.dart';
import 'package:my_app/discover/data/repositories/discover_repository.dart';
import 'package:my_app/favorites/data/repositories/favorite_item_repository.dart';
import 'package:my_app/favorites/data/repositories/favorites_repository.dart';
import 'package:my_app/l10n/l10n.dart';

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
        routerConfig: AppRouter().router,
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          ),
          useMaterial3: true,
        ),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
      ),
    );
  }
}
