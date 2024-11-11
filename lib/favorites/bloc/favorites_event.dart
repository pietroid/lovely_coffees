part of 'favorites_bloc.dart';

@immutable
sealed class FavoritesEvent {}

final class FavoritesLoad extends FavoritesEvent {}

final class FavoritesUpdate extends FavoritesEvent {
  FavoritesUpdate({required this.favorites});

  final List<Favorite> favorites;
}
