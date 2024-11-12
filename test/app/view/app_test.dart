import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_app/app/app.dart';
import 'package:my_app/discover/data/models/coffee_image.dart';
import 'package:my_app/discover/data/repositories/discover_repository.dart';
import 'package:my_app/favorites/data/repositories/favorite_item_repository.dart';
import 'package:my_app/favorites/data/repositories/favorites_repository.dart';
import 'package:my_app/root/root.dart';
import 'package:rxdart/subjects.dart';

class _MockFavoriteRepository extends Mock implements FavoritesRepository {}

class _MockDiscoverRepository extends Mock implements DiscoverRepository {}

class _MockFavoriteItemRepository extends Mock
    implements FavoriteItemRepository {}

void main() {
  late FavoritesRepository favoritesRepository;
  late DiscoverRepository discoverRepository;
  late FavoriteItemRepository favoriteItemRepository;
  group('App', () {
    setUp(() {
      favoritesRepository = _MockFavoriteRepository();
      discoverRepository = _MockDiscoverRepository();
      favoriteItemRepository = _MockFavoriteItemRepository();
      when(() => favoritesRepository.favorites)
          .thenAnswer((_) => BehaviorSubject.seeded([]));
      when(() => discoverRepository.fetchRandomCoffeeImage()).thenAnswer(
        (_) => Future.value(
          CoffeeImage(
            url: 'url',
            image: Uint8List(0),
          ),
        ),
      );
      when(() => favoriteItemRepository.fetchImageWithPath('url'))
          .thenAnswer((_) => Future.value(Uint8List(0)));
    });
    testWidgets('renders Root', (tester) async {
      await tester.pumpWidget(
        App(
          favoritesRepository: favoritesRepository,
          discoverRepository: discoverRepository,
          favoriteItemRepository: favoriteItemRepository,
        ),
      );
      expect(find.byType(Root), findsOneWidget);
    });
  });
}
