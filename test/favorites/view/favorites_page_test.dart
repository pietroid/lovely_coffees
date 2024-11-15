import 'package:bloc_test/bloc_test.dart';
import 'package:clock/clock.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lovely_coffees/favorites/blocs/favorites/favorites_bloc.dart';
import 'package:lovely_coffees/favorites/data/models/favorite.dart';
import 'package:lovely_coffees/favorites/data/repositories/favorite_item_repository.dart';
import 'package:lovely_coffees/favorites/view/favorites_page.dart';
import 'package:lovely_coffees/favorites/view/widgets/favorite_item.dart';
import 'package:mocktail/mocktail.dart';
import '../../helpers/helpers.dart';
import '../../helpers/shared_fixtures.dart';

class _MockFavoritesBloc extends MockBloc<FavoritesEvent, FavoritesState>
    implements FavoritesBloc {}

class _MockFavoriteItemRepository extends Mock
    implements FavoriteItemRepository {}

void main() {
  late FavoritesBloc favoritesBloc;
  late FavoriteItemRepository favoriteItemRepository;
  setUp(() {
    favoritesBloc = _MockFavoritesBloc();
    favoriteItemRepository = _MockFavoriteItemRepository();

    when(() => favoriteItemRepository.fetchImageWithPath(any()))
        .thenAnswer((_) => Future.value(fakeImage));
  });
  group('FavoritesPage', () {
    testWidgets('when it is loading, it should render the skeleton',
        (tester) async {
      when(() => favoritesBloc.state).thenReturn(FavoritesLoading());

      await tester.pumpApp(
        MultiBlocProvider(
          providers: [
            BlocProvider.value(
              value: favoritesBloc,
            ),
          ],
          child: const FavoritesPage(),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
    testWidgets('when there are no favorites, it should render empty state',
        (tester) async {
      when(() => favoritesBloc.state).thenReturn(FavoritesEmpty());

      await tester.pumpApp(
        MultiBlocProvider(
          providers: [
            BlocProvider.value(
              value: favoritesBloc,
            ),
          ],
          child: const FavoritesPage(),
        ),
      );

      expect(
        find.text('There are no favorites yet.\n Go to discover, swipe up'
            ' to see lovely'
            ' coffees ☕ \n Double tap to favorite! ❤️ '),
        findsOneWidget,
      );
    });

    group('Favorites list', () {
      testWidgets('when there is just one favorite, it should render one item',
          (tester) async {
        when(() => favoritesBloc.state).thenReturn(
          FavoritesSuccess(
            favorites: [
              Favorite(
                pathToImage: 'img1',
                favoritedAt: clock.now(),
              ),
            ],
          ),
        );

        await tester.pumpApp(
          MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: favoritesBloc,
              ),
              RepositoryProvider(create: (_) => favoriteItemRepository),
            ],
            child: const FavoritesPage(),
          ),
        );

        expect(find.byType(FavoriteItem), findsOneWidget);
      });

      testWidgets(
          'when there are multiple favorites, it should render newer'
          ' items first', (tester) async {
        when(() => favoritesBloc.state).thenReturn(
          FavoritesSuccess(
            favorites: [
              Favorite(
                pathToImage: fakeImageName,
                favoritedAt: clock.now(),
              ),
              Favorite(
                pathToImage: fakeImageName,
                favoritedAt: clock.now(),
              ),
            ],
          ),
        );

        await tester.pumpApp(
          MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: favoritesBloc,
              ),
              RepositoryProvider(create: (_) => favoriteItemRepository),
            ],
            child: const FavoritesPage(),
          ),
        );

        expect(find.byType(FavoriteItem), findsNWidgets(2));
      });
    });
  });
}
