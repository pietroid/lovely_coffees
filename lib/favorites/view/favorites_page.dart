import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/favorites/blocs/favorites/favorites_bloc.dart';
import 'package:my_app/favorites/view/widgets/favorite_item.dart';
import 'package:my_app/l10n/l10n.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<FavoritesBloc, FavoritesState>(
        builder: (context, state) {
          return switch (state) {
            FavoritesLoading() =>
              const Center(child: CircularProgressIndicator()),
            FavoritesEmpty() => Padding(
                padding: const EdgeInsets.all(10),
                child: Center(
                  child: Text(
                    textAlign: TextAlign.center,
                    context.l10n.favoritesEmptyStateText,
                  ),
                ),
              ),
            FavoritesSuccess() => ListView.builder(
                itemBuilder: (context, index) => FavoriteItem(
                  name: state.favorites[index].pathToImage,
                  key: Key(state.favorites[index].pathToImage),
                ),
                itemCount: state.favorites.length,
              ),
          };
        },
      ),
    );
  }
}
