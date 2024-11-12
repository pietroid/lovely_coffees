import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:lovely_coffees/favorites/data/data_sources/favorites_image_data_source.dart';
import 'package:lovely_coffees/favorites/data/repositories/favorite_item_repository.dart';

import '../../../helpers/shared_fixtures.dart';

class _MockFavoritesImageDataSource extends Mock
    implements FavoritesImageDataSource {}

void main() {
  group('FavoriteItemRepository', () {
    test('when fetchImageWithPath is called, it should return an image',
        () async {
      final imageDataSource = _MockFavoritesImageDataSource();
      when(() => imageDataSource.fetchImageWithPath(fakeImageName))
          .thenAnswer((_) => Future.value(fakeImage));

      final favoriteItemRepository = FavoriteItemRepository(
        imageDataSource: imageDataSource,
      );

      final image =
          await favoriteItemRepository.fetchImageWithPath(fakeImageName);

      expect(image, fakeImage);
    });
  });
}
