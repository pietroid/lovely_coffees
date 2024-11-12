import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:lovely_coffees/app_router/router.dart';
import 'package:lovely_coffees/discover/data/models/coffee_image.dart';
import 'package:lovely_coffees/discover/data/repositories/discover_repository.dart';
import 'package:lovely_coffees/discover/view/discover_page.dart';
import 'package:lovely_coffees/favorites/data/repositories/favorites_repository.dart';
import 'package:lovely_coffees/favorites/view/favorites_page.dart';
import 'package:lovely_coffees/l10n/l10n.dart';
import 'package:rxdart/subjects.dart';

import '../helpers/shared_fixtures.dart';

class _MockFavoriteRepository extends Mock implements FavoritesRepository {}

class _MockDiscoverRepository extends Mock implements DiscoverRepository {}

void main() {
  Widget appWithDefaultRouter() => MaterialApp.router(
        routerConfig: AppRouter().router,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
      );
  // Because of the way routerConfig works, it's hard
  // to maintain a navigationShell mock
  // and render it on the widget tree. For this reason,
  // it's better to just create a widget
  // with the default router and test the internals of this widget.
  late FavoritesRepository favoritesRepository;
  late DiscoverRepository discoverRepository;
  group('Root', () {
    setUp(() {
      favoritesRepository = _MockFavoriteRepository();
      discoverRepository = _MockDiscoverRepository();
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
    });
    testWidgets('renders bottom navigation bar', (tester) async {
      await tester.pumpWidget(
        MultiRepositoryProvider(
          providers: [
            RepositoryProvider(create: (_) => favoritesRepository),
            RepositoryProvider(create: (_) => discoverRepository),
          ],
          child: appWithDefaultRouter(),
        ),
      );

      expect(find.byType(NavigationBar), findsOneWidget);
    });

    testWidgets(
        'when clicking the /discover item, it shows the discover page and not show the favorites page',
        (tester) async {
      await tester.pumpWidget(
        MultiRepositoryProvider(
          providers: [
            RepositoryProvider(create: (_) => favoritesRepository),
            RepositoryProvider(create: (_) => discoverRepository),
          ],
          child: appWithDefaultRouter(),
        ),
      );

      await tester.tap(find.text('Discover'));
      await tester.pumpAndSettle();

      expect(find.byType(DiscoverPage), findsOneWidget);
      expect(find.byType(FavoritesPage), findsNothing);
    });

    testWidgets(
        'when clicking the /favorites item, it shows the favorites page and not show the discover page',
        (tester) async {
      await tester.pumpWidget(
        MultiRepositoryProvider(
          providers: [
            RepositoryProvider(create: (_) => favoritesRepository),
            RepositoryProvider(create: (_) => discoverRepository),
          ],
          child: appWithDefaultRouter(),
        ),
      );

      await tester.tap(find.text('Favorites'));
      await tester.pumpAndSettle();

      expect(find.byType(DiscoverPage), findsNothing);
      expect(find.byType(FavoritesPage), findsOneWidget);
    });
  });
}
