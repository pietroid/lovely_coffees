import 'package:flutter_test/flutter_test.dart';
import 'package:lovely_coffees/app/app.dart';
import 'package:lovely_coffees/discover/data/models/coffee_image.dart';
import 'package:lovely_coffees/discover/data/repositories/discover_repository.dart';
import 'package:lovely_coffees/favorites/data/repositories/favorite_item_repository.dart';
import 'package:lovely_coffees/favorites/data/repositories/favorites_repository.dart';
import 'package:lovely_coffees/root/root.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rxdart/subjects.dart';

import '../../helpers/shared_fixtures.dart';

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
            url: fakeImageName,
            image: fakeImage,
          ),
        ),
      );
      when(() => favoriteItemRepository.fetchImageWithPath(fakeImageName))
          .thenAnswer((_) => Future.value(fakeImage));
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
