import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/favorites/bloc/favorites_bloc.dart';

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
            FavoritesEmpty() => const Center(child: Text('No favorites')),
            FavoritesSuccess() => ListView.builder(
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('Favorite $index'),
                  );
                },
                itemCount: state.favorites.length,
              ),
          };
        },
      ),
    );
  }
}
