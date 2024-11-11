import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_app/app_router/router.dart';
import 'package:my_app/discover/view/discover_page.dart';
import 'package:my_app/favorites/data/repositories/favorites_repository.dart';
import 'package:my_app/favorites/view/favorites_page.dart';
import 'package:my_app/l10n/l10n.dart';
import 'package:rxdart/subjects.dart';

class _MockFavoriteRepository extends Mock implements FavoritesRepository {}

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
  group('Root', () {
    setUp(() {
      favoritesRepository = _MockFavoriteRepository();
      when(() => favoritesRepository.favorites)
          .thenAnswer((_) => BehaviorSubject.seeded([]));
    });
    testWidgets('renders bottom navigation bar', (tester) async {
      await tester.pumpWidget(
        MultiRepositoryProvider(
          providers: [
            RepositoryProvider(create: (_) => favoritesRepository),
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
