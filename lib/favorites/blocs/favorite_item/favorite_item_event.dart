part of 'favorite_item_bloc.dart';

sealed class FavoriteItemEvent extends Equatable {
  const FavoriteItemEvent();

  @override
  List<Object> get props => [];
}

final class FavoriteItemLoad extends FavoriteItemEvent {
  FavoriteItemLoad({required this.name});

  final String name;

  @override
  List<Object> get props => [name];
}
