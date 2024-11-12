part of 'favorites_bloc.dart';

@immutable
sealed class FavoritesEvent {}

final class FavoritesLoad extends FavoritesEvent {}

final class FavoritesUpdate extends FavoritesEvent {
  FavoritesUpdate({required this.favorites});

  final List<Favorite> favorites;
}

final class FavoritesAdd extends FavoritesEvent {
  FavoritesAdd({
    required this.image,
    required this.imageUrl,
  });

  final Uint8List image;
  final String imageUrl;
}
