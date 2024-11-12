import 'dart:async';
import 'dart:typed_data';

import 'package:my_app/favorites/data/data_sources/favorites_image_data_source.dart';
import 'package:my_app/favorites/data/data_sources/favorites_local_data_source.dart';
import 'package:my_app/favorites/data/models/favorite.dart';
import 'package:rxdart/subjects.dart';

class FavoritesRepository {
  FavoritesRepository({
    required this.localDataSource,
    required this.imageDataSource,
  });

  StreamSubscription<List<Favorite>>? _subscription;
  final FavoritesLocalDataSource localDataSource;
  final FavoritesImageDataSource imageDataSource;
  final BehaviorSubject<List<Favorite>> _favorites = BehaviorSubject();

  BehaviorSubject<List<Favorite>> get favorites => _favorites;

  void init() {
    localDataSource.fetchFavorites().then(_favorites.add);
    _subscription = localDataSource.watchFavorites().listen(_favorites.add);
  }

  Future<void> addFavorite({
    required Uint8List image,
    required String imageUrl,
  }) async {
    final imagePath = imageUrl.split('/').last;
    await imageDataSource.saveImageWithPath(imagePath, image);
    final favorite = Favorite(
      pathToImage: imagePath,
      favoritedAt: DateTime.now(),
    );
    await localDataSource.addFavorite(favorite);
  }

  void close() {
    _favorites.close();
    _subscription?.cancel();
  }
}
