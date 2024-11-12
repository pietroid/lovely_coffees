import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:lovely_coffees/discover/data/models/coffee_image.dart';
import 'package:lovely_coffees/discover/data/repositories/discover_repository.dart';
import 'package:lovely_coffees/discover/view/widgets/discover_carousel_item.dart';

import '../../../helpers/helpers.dart';
import '../../../helpers/shared_fixtures.dart';

class _MockDiscoverRepository extends Mock implements DiscoverRepository {}

void main() {
  late DiscoverRepository discoverRepository;

  group('DiscoverCarouselItemTest', () {
    setUp(() {
      discoverRepository = _MockDiscoverRepository();
    });

    testWidgets('when image is loading should render circularProgressIndicator',
        (tester) async {
      when(() => discoverRepository.fetchRandomCoffeeImage())
          .thenAnswer((_) async {
        await Future<void>.delayed(const Duration(milliseconds: 10));
        return CoffeeImage(
          url: fakeImageFullUrl,
          image: fakeImage,
        );
      });

      await tester.pumpApp(
        MultiRepositoryProvider(
          providers: [
            RepositoryProvider<DiscoverRepository>(
              create: (context) => discoverRepository,
            ),
          ],
          child: const DiscoverCarouselItem(),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      await tester.pumpAndSettle();
    });

    testWidgets('when image is loaded should render Image', (tester) async {
      when(() => discoverRepository.fetchRandomCoffeeImage())
          .thenAnswer((_) async {
        return CoffeeImage(
          url: fakeImageFullUrl,
          image: fakeImage,
        );
      });

      await tester.pumpApp(
        MultiRepositoryProvider(
          providers: [
            RepositoryProvider<DiscoverRepository>(
              create: (context) => discoverRepository,
            ),
          ],
          child: const DiscoverCarouselItem(),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(Image), findsOneWidget);
    });

    testWidgets('when image is not loaded due to exception should render Error',
        (tester) async {
      when(() => discoverRepository.fetchRandomCoffeeImage()).thenThrow(
        Exception(),
      );

      await tester.pumpApp(
        MultiRepositoryProvider(
          providers: [
            RepositoryProvider<DiscoverRepository>(
              create: (context) => discoverRepository,
            ),
          ],
          child: const DiscoverCarouselItem(),
        ),
      );

      await tester.pumpAndSettle();

      expect(
        find.text('💔 Error loading your next lovely coffee'),
        findsOneWidget,
      );
    });
  });
}
