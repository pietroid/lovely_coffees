import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:my_app/favorites/data/models/favorite.dart';
import 'package:my_app/favorites/data/repositories/favorites_repository.dart';

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
  }

  @override
  Future<void> close() {
    favoritesRepository.close();
    return super.close();
  }

  final FavoritesRepository favoritesRepository;
}
