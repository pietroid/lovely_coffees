import 'package:isar/isar.dart';
import 'package:my_app/favorites/data/models/favorite.dart';

class FavoritesDataSource {
  FavoritesDataSource({
    required this.isar,
  });

  final Isar isar;

  Future<List<Favorite>> fetchFavorites() async {
    return isar.favorites.where().findAll();
  }

  Future<void> addFavorite(Favorite favorite) async {
    await isar.favorites.put(favorite);
  }

  Future<void> removeFavorite(Favorite favorite) async {
    await isar.favorites.delete(favorite.id);
  }

  Stream<List<Favorite>> watchFavorites() {
    return isar.favorites.where().watch();
  }
}
