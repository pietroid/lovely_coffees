part of 'favorite_item_bloc.dart';

sealed class FavoriteItemState extends Equatable {
  const FavoriteItemState();

  @override
  List<Object> get props => [];
}

final class FavoriteItemLoading extends FavoriteItemState {}

final class FavoriteItemLoaded extends FavoriteItemState {
  FavoriteItemLoaded({required this.image});

  final Uint8List image;

  @override
  List<Object> get props => [image];
}
