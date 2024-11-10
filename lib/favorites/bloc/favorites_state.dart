part of 'favorites_bloc.dart';

@immutable
sealed class FavoritesState extends Equatable {
  @override
  List<Object> get props => [];
}

final class FavoritesLoading extends FavoritesState {}

final class FavoritesEmpty extends FavoritesState {}

final class FavoritesSuccess extends FavoritesState {
  FavoritesSuccess({required this.favorites});

  final List<Favorite> favorites;

  @override
  List<Object> get props => [favorites];
}
