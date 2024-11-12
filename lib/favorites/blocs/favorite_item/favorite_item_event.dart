part of 'favorite_item_bloc.dart';

sealed class FavoriteItemEvent extends Equatable {
  const FavoriteItemEvent();
}

final class FavoriteItemLoad extends FavoriteItemEvent {
  const FavoriteItemLoad({required this.name});

  final String name;

  @override
  List<Object> get props => [name];
}
