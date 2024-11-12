import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_app/discover/data/repositories/discover_repository.dart';

part 'discover_event.dart';
part 'discover_state.dart';

class DiscoverBloc extends Bloc<DiscoverEvent, DiscoverState> {
  DiscoverBloc({
    required this.repository,
  }) : super(DiscoverLoading()) {
    on<DiscoverLoad>((event, emit) async {
      try {
        final coffeeImage = await repository.fetchRandomCoffeeImage();
        emit(
          DiscoverLoaded(
            name: coffeeImage.url,
            image: coffeeImage.image,
          ),
        );
      } catch (e) {
        emit(DiscoverFailure());
      }
    });
  }

  final DiscoverRepository repository;
}
