import 'package:isar/isar.dart';
import 'package:my_app/favorites/data/models/favorite.dart';

class FavoritesLocalDataSource {
  FavoritesLocalDataSource({
    required this.isar,
  });

  final Isar isar;

  Future<List<Favorite>> fetchFavorites() async {
    return isar.favorites.where().findAll();
  }

  Future<void> addFavorite(Favorite favorite) async {
    await isar.writeTxn(() async {
      await isar.favorites.put(favorite);
    });
  }

  Stream<List<Favorite>> watchFavorites() {
    return isar.favorites.where().watch();
  }
}
