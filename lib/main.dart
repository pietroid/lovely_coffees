import 'package:isar/isar.dart';
import 'package:my_app/app/app.dart';
import 'package:my_app/bootstrap.dart';
import 'package:my_app/favorites/data/data_sources/favorites_data_source.dart';
import 'package:my_app/favorites/data/models/favorite.dart';
import 'package:my_app/favorites/data/repositories/favorites_repository.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  bootstrap(() async {
    final isarDirectory = await getApplicationDocumentsDirectory();
    final isar = await Isar.open(
      [
        FavoriteSchema,
      ],
      directory: isarDirectory.path,
    );
    final favoritesRepository = FavoritesRepository(
      dataSource: FavoritesDataSource(isar: isar),
    );
    return App(
      favoritesRepository: favoritesRepository,
    );
  });
}
