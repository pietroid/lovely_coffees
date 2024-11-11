import 'package:bloc_test/bloc_test.dart';
import 'package:clock/clock.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_app/favorites/bloc/favorites_bloc.dart';
import 'package:my_app/favorites/data/models/favorite.dart';
import 'package:my_app/favorites/view/favorites_page.dart';

import '../../helpers/helpers.dart';

class _MockFavoritesBloc extends MockBloc<FavoritesEvent, FavoritesState>
    implements FavoritesBloc {}

void main() {
  late FavoritesBloc favoritesBloc;
  setUp(() {
    favoritesBloc = _MockFavoritesBloc();
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

      expect(find.text('No favorites'), findsOneWidget);
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
            ],
            child: const FavoritesPage(),
          ),
        );

        expect(find.text('Favorite 0'), findsOneWidget);
      });

      testWidgets(
          'when there are multiple favorites, it should render newer'
          ' items first', (tester) async {
        when(() => favoritesBloc.state).thenReturn(
          FavoritesSuccess(
            favorites: [
              Favorite(
                pathToImage: 'img1',
                favoritedAt: clock.now(),
              ),
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
            ],
            child: const FavoritesPage(),
          ),
        );

        expect(find.text('Favorite 0'), findsOneWidget);
        expect(find.text('Favorite 1'), findsOneWidget);
      });
    });
  });
}
