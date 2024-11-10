import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_app/discover/view/discover_page.dart';
import 'package:my_app/favorites/view/favorites_page.dart';

import '../helpers/helpers.dart';

void main() {
  // Because of the way routerConfig works, it's hard to maintain a navigationShell mock
  // and render it on the widget tree. For this reason, it's better to just create a widget
  // with the default router and test the internals of this widget.
  group('Root', () {
    testWidgets('renders bottom navigation bar', (tester) async {
      await tester.pumpAppWithDefaultRouter();

      expect(find.byType(NavigationBar), findsOneWidget);
    });

    testWidgets(
        'when clicking the /discover item, it shows the discover page and not show the favorites page',
        (tester) async {
      await tester.pumpAppWithDefaultRouter();

      await tester.tap(find.text('Discover'));
      await tester.pumpAndSettle();

      expect(find.byType(DiscoverPage), findsOneWidget);
      expect(find.byType(FavoritesPage), findsNothing);
    });

    testWidgets(
        'when clicking the /favorites item, it shows the discover page and not show the discover page',
        (tester) async {
      await tester.pumpAppWithDefaultRouter();

      await tester.tap(find.text('Favorites'));
      await tester.pumpAndSettle();

      expect(find.byType(DiscoverPage), findsNothing);
      expect(find.byType(FavoritesPage), findsOneWidget);
    });
  });
}
