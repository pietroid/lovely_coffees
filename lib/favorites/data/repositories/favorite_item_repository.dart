import 'dart:typed_data';

import 'package:my_app/favorites/data/data_sources/favorites_image_data_source.dart';

class FavoriteItemRepository {
  FavoriteItemRepository({
    required this.imageDataSource,
  });

  final FavoritesImageDataSource imageDataSource;
  Future<Uint8List> fetchImageWithPath(
    String path,
  ) async {
    return imageDataSource.fetchImageWithPath(path);
  }
}
