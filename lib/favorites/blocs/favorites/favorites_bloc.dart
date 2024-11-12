import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:lovely_coffees/favorites/data/models/favorite.dart';
import 'package:lovely_coffees/favorites/data/repositories/favorites_repository.dart';
import 'package:meta/meta.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  FavoritesBloc({
    required this.favoritesRepository,
  }) : super(FavoritesLoading()) {
    on<FavoritesUpdate>((event, emit) {
      if (event.favorites.isEmpty) {
        emit(FavoritesEmpty());
      } else {
        emit(FavoritesSuccess(favorites: event.favorites));
      }
    });

    on<FavoritesLoad>((event, emit) async {
      favoritesRepository.init();
      favoritesRepository.favorites.listen((favorites) {
        add(
          FavoritesUpdate(
            favorites: favorites,
          ),
        );
      });
    });

    on<FavoritesAdd>((event, emit) async {
      await favoritesRepository.addFavorite(
        image: event.image,
        imageUrl: event.imageUrl,
      );
    });
  }

  @override
  Future<void> close() {
    favoritesRepository.close();
    return super.close();
  }

  final FavoritesRepository favoritesRepository;
}
