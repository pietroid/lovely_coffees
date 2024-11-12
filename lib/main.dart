import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:isar/isar.dart';
import 'package:my_app/app/app.dart';
import 'package:my_app/bootstrap.dart';
import 'package:my_app/discover/data/data_sources/discover_data_source.dart';
import 'package:my_app/discover/data/repositories/discover_repository.dart';
import 'package:my_app/favorites/data/data_sources/favorites_data_source.dart';
import 'package:my_app/favorites/data/models/favorite.dart';
import 'package:my_app/favorites/data/repositories/favorites_repository.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  bootstrap(() async {
    WidgetsFlutterBinding.ensureInitialized();
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
    final discoverRepository = DiscoverRepository(
      dataSource: DiscoverDataSource(
        client: http.Client(),
        baseUrl: 'https://coffee.alexflipnote.dev/random.json',
      ),
    );
    return App(
      favoritesRepository: favoritesRepository,
      discoverRepository: discoverRepository,
    );
  });
}
