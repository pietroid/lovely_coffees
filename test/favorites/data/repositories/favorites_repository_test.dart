import 'dart:async';
import 'dart:typed_data';

import 'package:clock/clock.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_app/favorites/data/data_sources/favorites_image_data_source.dart';
import 'package:my_app/favorites/data/data_sources/favorites_local_data_source.dart';
import 'package:my_app/favorites/data/models/favorite.dart';
import 'package:my_app/favorites/data/repositories/favorites_repository.dart';

class _MockFavoritesLocalDataSource extends Mock
    implements FavoritesLocalDataSource {}

class _MockFavoritesImageDataSource extends Mock
    implements FavoritesImageDataSource {}

void main() {
  late FavoritesLocalDataSource favoritesLocalDataSource;
  late FavoritesImageDataSource favoritesImageDataSource;

  group('FavoritesRepository', () {
    setUpAll(() {
      registerFallbackValue(
        Favorite(
          pathToImage: '',
          favoritedAt: clock.now(),
        ),
      );
      registerFallbackValue(Uint8List(0));
    });
    setUp(() {
      favoritesLocalDataSource = _MockFavoritesLocalDataSource();
      favoritesImageDataSource = _MockFavoritesImageDataSource();
    });
    group('init', () {
      test(
          'when init is called, it should stream favorites from the '
          ' fetchFavorites from data source', () {
        final favorite1 =
            Favorite(pathToImage: 'img1', favoritedAt: DateTime.now());
        final favorite2 =
            Favorite(pathToImage: 'img2', favoritedAt: DateTime.now());

        when(() => favoritesLocalDataSource.fetchFavorites()).thenAnswer(
          (_) async => [favorite1, favorite2],
        );
        when(() => favoritesLocalDataSource.watchFavorites()).thenAnswer(
          (_) => Stream.fromIterable([
            [],
          ]),
        );

        final favoritesRepository = FavoritesRepository(
          localDataSource: favoritesLocalDataSource,
          imageDataSource: favoritesImageDataSource,
        )..init();

        verify(() => favoritesLocalDataSource.fetchFavorites()).called(1);
        expect(
          favoritesRepository.favorites,
          emits(
            [
              favorite1,
              favorite2,
            ],
          ),
        );
      });

      test(
          'when init is called, it should stream favorites from the '
          'watchFavorites from data source', () async {
        final controller = StreamController<List<Favorite>>();

        final favorite1 =
            Favorite(pathToImage: 'img1', favoritedAt: DateTime.now());
        final favorite2 =
            Favorite(pathToImage: 'img2', favoritedAt: DateTime.now());

        when(() => favoritesLocalDataSource.fetchFavorites()).thenAnswer(
          (_) async => [],
        );
        when(() => favoritesLocalDataSource.watchFavorites()).thenAnswer(
          (_) => controller.stream,
        );

        final favoritesRepository = FavoritesRepository(
          localDataSource: favoritesLocalDataSource,
          imageDataSource: favoritesImageDataSource,
        )..init();

        // Adding more events
        controller.add([favorite1, favorite2]);
        // Need to add this to listen to the stream result
        await Future<void>.delayed(Duration.zero);

        await expectLater(
          favoritesRepository.favorites,
          emits(
            [
              favorite1,
              favorite2,
            ],
          ),
        );
      });
    });

    test(
        'when addFavorite is called, it should call addFavorite'
        ' from data source', () async {
      when(() => favoritesLocalDataSource.addFavorite(any())).thenAnswer(
        (_) async {},
      );
      when(() => favoritesImageDataSource.saveImageWithPath(any(), any()))
          .thenAnswer(
        (_) async {},
      );

      await FavoritesRepository(
        localDataSource: favoritesLocalDataSource,
        imageDataSource: favoritesImageDataSource,
      ).addFavorite(
        image: Uint8List(0),
        imageUrl: 'https://url/img1.png',
      );

      final capturedFavorite = verify(
        () => favoritesLocalDataSource.addFavorite(
          captureAny<Favorite>(),
        ),
      ).captured.first as Favorite;
      expect(capturedFavorite.pathToImage, 'img1.png');

      verify(() => favoritesImageDataSource.saveImageWithPath(any(), any()))
          .called(1);
    });

    test('when calling close it should close the stream', () {
      final favoritesRepository = FavoritesRepository(
        localDataSource: favoritesLocalDataSource,
        imageDataSource: favoritesImageDataSource,
      )..close();

      expect(favoritesRepository.favorites.isClosed, isTrue);
    });
  });
}
