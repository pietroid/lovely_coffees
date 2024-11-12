part of 'favorite_item_bloc.dart';

sealed class FavoriteItemState extends Equatable {
  const FavoriteItemState();
}

final class FavoriteItemLoading extends FavoriteItemState {
  @override
  List<Object> get props => [];
}

final class FavoriteItemLoaded extends FavoriteItemState {
  const FavoriteItemLoaded({required this.image});

  final Uint8List image;

  @override
  List<Object> get props => [image];
}
