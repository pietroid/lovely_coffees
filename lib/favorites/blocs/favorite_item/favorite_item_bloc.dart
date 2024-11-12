import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lovely_coffees/favorites/data/repositories/favorite_item_repository.dart';

part 'favorite_item_event.dart';
part 'favorite_item_state.dart';

class FavoriteItemBloc extends Bloc<FavoriteItemEvent, FavoriteItemState> {
  FavoriteItemBloc({
    required this.favoriteItemRepository,
  }) : super(FavoriteItemLoading()) {
    on<FavoriteItemLoad>((event, emit) async {
      final image = await favoriteItemRepository.fetchImageWithPath(event.name);
      emit(FavoriteItemLoaded(image: image));
    });
  }

  final FavoriteItemRepository favoriteItemRepository;
}
