import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_app/favorites/data/data_sources/favorites_data_source.dart';
import 'package:my_app/favorites/data/models/favorite.dart';
import 'package:my_app/favorites/data/repositories/favorites_repository.dart';

class _MockFavoritesDataSource extends Mock implements FavoritesDataSource {}

void main() {
  late FavoritesDataSource favoritesDataSource;

  group('FavoritesRepository', () {
    setUp(() {
      favoritesDataSource = _MockFavoritesDataSource();
    });
    group('init', () {
      test(
          'when init is called, it should stream favorites from the '
          ' fetchFavorites from data source', () {
        final favorite1 =
            Favorite(pathToImage: 'img1', favoritedAt: DateTime.now());
        final favorite2 =
            Favorite(pathToImage: 'img2', favoritedAt: DateTime.now());

        when(() => favoritesDataSource.fetchFavorites()).thenAnswer(
          (_) async => [favorite1, favorite2],
        );
        when(() => favoritesDataSource.watchFavorites()).thenAnswer(
          (_) => Stream.fromIterable([
            [],
          ]),
        );

        final favoritesRepository =
            FavoritesRepository(dataSource: favoritesDataSource)..init();

        verify(() => favoritesDataSource.fetchFavorites()).called(1);
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

        when(() => favoritesDataSource.fetchFavorites()).thenAnswer(
          (_) async => [],
        );
        when(() => favoritesDataSource.watchFavorites()).thenAnswer(
          (_) => controller.stream,
        );

        final favoritesRepository =
            FavoritesRepository(dataSource: favoritesDataSource)..init();

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
        ' from data source', () {
      final favorite =
          Favorite(pathToImage: 'img1', favoritedAt: DateTime.now());

      when(() => favoritesDataSource.addFavorite(favorite)).thenAnswer(
        (_) async {},
      );

      FavoritesRepository(dataSource: favoritesDataSource)
          .addFavorite(favorite);

      verify(() => favoritesDataSource.addFavorite(favorite)).called(1);
    });

    test(
        'when removeFavorite is called, it should call removeFavorite '
        'from data source', () {
      final favorite =
          Favorite(pathToImage: 'img1', favoritedAt: DateTime.now());

      when(() => favoritesDataSource.removeFavorite(favorite)).thenAnswer(
        (_) async {},
      );

      FavoritesRepository(dataSource: favoritesDataSource)
          .removeFavorite(favorite);

      verify(() => favoritesDataSource.removeFavorite(favorite)).called(1);
    });
  });
}
