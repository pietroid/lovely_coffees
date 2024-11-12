import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:isar/isar.dart';
import 'package:lovely_coffees/app/app.dart';
import 'package:lovely_coffees/bootstrap.dart';
import 'package:lovely_coffees/discover/data/data_sources/discover_data_source.dart';
import 'package:lovely_coffees/discover/data/repositories/discover_repository.dart';
import 'package:lovely_coffees/favorites/data/data_sources/favorites_image_data_source.dart';
import 'package:lovely_coffees/favorites/data/data_sources/favorites_local_data_source.dart';
import 'package:lovely_coffees/favorites/data/models/favorite.dart';
import 'package:lovely_coffees/favorites/data/repositories/favorite_item_repository.dart';
import 'package:lovely_coffees/favorites/data/repositories/favorites_repository.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  bootstrap(() async {
    WidgetsFlutterBinding.ensureInitialized();
    final appDirectory = await getApplicationDocumentsDirectory();
    final isar = await Isar.open(
      [
        FavoriteSchema,
      ],
      directory: appDirectory.path,
    );
    final favoritesRepository = FavoritesRepository(
      localDataSource: FavoritesLocalDataSource(isar: isar),
      imageDataSource: FavoritesImageDataSource(
        applicationDirectory: appDirectory.path,
      ),
    );
    final favoriteItemRepository = FavoriteItemRepository(
      imageDataSource: FavoritesImageDataSource(
        applicationDirectory: appDirectory.path,
      ),
    );
    final discoverRepository = DiscoverRepository(
      dataSource: DiscoverDataSource(
        client: http.Client(),
        baseUrl: 'https://coffee.alexflipnote.dev/random.json',
      ),
    );
    return App(
      favoritesRepository: favoritesRepository,
      favoriteItemRepository: favoriteItemRepository,
      discoverRepository: discoverRepository,
    );
  });
}
