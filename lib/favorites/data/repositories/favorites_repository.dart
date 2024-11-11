import 'dart:async';

import 'package:my_app/favorites/data/data_sources/favorites_data_source.dart';
import 'package:my_app/favorites/data/models/favorite.dart';
import 'package:rxdart/subjects.dart';

class FavoritesRepository {
  FavoritesRepository({
    required this.dataSource,
  });

  StreamSubscription<List<Favorite>>? _subscription;
  final FavoritesDataSource dataSource;
  final BehaviorSubject<List<Favorite>> _favorites = BehaviorSubject();

  BehaviorSubject<List<Favorite>> get favorites => _favorites;

  void init() {
    dataSource.fetchFavorites().then(_favorites.add);
    _subscription = dataSource.watchFavorites().listen(_favorites.add);
  }

  Future<void> addFavorite(Favorite favorite) async {
    await dataSource.addFavorite(favorite);
  }

  Future<void> removeFavorite(Favorite favorite) async {
    await dataSource.removeFavorite(favorite);
  }

  void close() {
    _favorites.close();
    _subscription?.cancel();
  }
}
